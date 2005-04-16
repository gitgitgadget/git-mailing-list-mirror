From: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
Subject: git-pasky: gitXnormid.sh overhaul
Date: Sat, 16 Apr 2005 18:51:29 +0200
Message-ID: <20050416165129.GA13152@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 16 18:49:05 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DMqTW-0002o3-1b
	for gcvg-git@gmane.org; Sat, 16 Apr 2005 18:48:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262706AbVDPQwb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 16 Apr 2005 12:52:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262702AbVDPQwa
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Apr 2005 12:52:30 -0400
Received: from neapel230.server4you.de ([217.172.187.230]:42924 "EHLO
	neapel230.server4you.de") by vger.kernel.org with ESMTP
	id S262701AbVDPQvf (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Apr 2005 12:51:35 -0400
Received: by neapel230.server4you.de (Postfix, from userid 1000)
	id 94EDD222; Sat, 16 Apr 2005 18:51:29 +0200 (CEST)
To: Petr Baudis <pasky@ucw.cz>
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hello,

I just couldn't stand all the calls to grep and other external tools in
gitXnormid.sh and started rewriting it in a knee-jerk reaction.

You said in a private conversation that you don't like to include things
like ${var#stuff} to stay "sh compatible", while OTOH you favour $(cmd)
over `cmd`.  Both are POSIX extensions of the classical Bourne Shell
syntax (see e.g. http://docs.hp.com/en/B2355-90046/ch15s03.html for a
feature comparision between POSIX shell, Bourne Shell and Korn Shells on
HP-UX).  For reference, The Open Group publishes its IEEE Std 1003.1
standard (vulgo: POSIX) on this website:
http://www.opengroup.org/onlinepubs/009695399/toc.htm.  So which shell
do you want to target with your git scripts?

This time I tested the script. :]  It copes with invalid IDs,
non-existing valid IDs, abbreviated IDs, an omitted ID, valid IDs, with
tags and branch names.  I also made sure the script runs with bash, ash,
pdksh, zsh and bash --posix (all on SuSE 9.2).

I changed the way an ID is verified.  The script now tries to find tags
and branches first by looking for .git/tags/<id> and .git/HEAD.<id> and
after that looking inside .git/objects for a match.  That's faster and
now I can safely give a branch a name consisting of 40 hex digits. :-)

The script follows in plain text format, not as a patch.  Your and my
version share only very few lines, so this way it's easier to review.
I'll send you a patch if and when you're ready to apply it, ok?

Thanks,
Rene


--- 8< ---
#!/bin/sh
#
# Internal: Normalize the given ID to a tree ID.
# Copyright (c) Petr Baudis, 2005
#
# Takes an arbitrary ID as a parameter. -c tells it to give
# a commit id rather than tree id.

usage() {
	echo "Usage: $0 [-c] [tree-id | commit-id | tag | branch]"
	exit 2
}

get_first_word() {
	if read one two; then
		echo "$one"
		return 0
	fi
	return 1
}

expand_hash() {
	hashdir=${SHA1_FILE_DIRECTORY:-.git/objects}
	filename=${1#??}
	dirname=${1%${filename}}
	first=true
	for file in "${hashdir}/${dirname}/${filename}"*; do
		[ -f "$file" ] || return 1
		if $first; then
			hash=${dirname}${file##*/}
			first=false
		else
			return 1
		fi
	done
	$first && return 1
	echo "$hash"
}

get_tree_id() {
	cat-file commit "$1" | while read tag hash; do
		if [ "$tag" = "tree" ]; then
			echo "$hash"
			return
		fi
	done
}

type=tree
case "$1" in
-c) type=commit; shift;;
-*) usage;;
esac

if [ ! "$1" ]; then
	if [ ! -f ".git/HEAD" ]; then
		echo "$0: file .git/HEAD not found"
		usage
	fi
	id=$(get_first_word <".git/HEAD")
elif [ -f ".git/tags/$1" ]; then
	id=$(get_first_word <".git/tags/$1")
elif [ -f ".git/HEAD.$1" ]; then
	id=$(get_first_word <".git/HEAD.$1")
else
	id=$(expand_hash "$1")
fi
if [ $? != 0 ]; then
	echo "$0: invalid ID: $1" >&2
	exit 1
fi

if [ "$type" = "tree" ]; then
	tree_id=$(get_tree_id "$id" 2>/dev/null)
	[ "$tree_id" ] && id=$tree_id
fi

if [ $(cat-file -t "$id") != "$type" ]; then
	echo "$0: invalid ID: $id" >&2
	exit 1
fi
echo "$id"
