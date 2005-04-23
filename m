From: James Bottomley <James.Bottomley@SteelEye.com>
Subject: git-changes-script to show inter tree changes
Date: Sat, 23 Apr 2005 14:43:12 -0400
Message-ID: <1114281792.5068.10.camel@mulgrave>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 23 20:39:09 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DPPWk-0003mv-0N
	for gcvg-git@gmane.org; Sat, 23 Apr 2005 20:38:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261674AbVDWSne (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Apr 2005 14:43:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261668AbVDWSne
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Apr 2005 14:43:34 -0400
Received: from stat16.steeleye.com ([209.192.50.48]:24025 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S261674AbVDWSnU (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Apr 2005 14:43:20 -0400
Received: from midgard.sc.steeleye.com (midgard.sc.steeleye.com [172.17.6.40])
	by hancock.sc.steeleye.com (8.11.6/8.11.6) with ESMTP id j3NIhDA04385;
	Sat, 23 Apr 2005 14:43:13 -0400
To: Linus Torvalds <torvalds@osdl.org>
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

One of the features I found most useful about bk changes was the ability
to see changes in my tree that weren't in the other tree (I use this to
keep track of what patches I actually have).

I've modified the gitlog script to take the -L and -R options (local
directories only; won't work on remotes like bk changes would) to add
this functionality.

James

#!/bin/bash
#
# Make a log of changes in a GIT branch.
#
# This script was originally written by (c) Ross Vandegrift.
# Adapted to his scripts set by (c) Petr Baudis, 2005.
# Major optimizations by (c) Phillip Lougher.
# Rendered trivial by Linus Torvalds.
# Added -L|-R option by James Bottomley
#
# options:
# script [-L <dir> | -R <dir> |-r <from_sha1> [ -r <to_sha1] ] [<sha1>]
#
# With no options shows all the revisions from HEAD to the root
# -L shows all the changes in the local tree compared to the tree at <dir>
# -R shows all the changes in the remote tree at <dir> compared to the local
# -r shows all the changes in one commit or between two

tmpfile=/tmp/git_changes.$$
r1=
r2=

showcommit() {
	commit="$1"
	echo commit ${commit%:*};
	cat-file commit $commit | \
		while read key rest; do
			case "$key" in
			"author"|"committer")
				date=(${rest#*> })
				sec=${date[0]};
				pdate="$(date -Rd "1970-01-01 UTC + $sec sec" 2>/dev/null)"
				if [ "$pdate" ]; then
					echo $key $rest | sed "s/>.*/> ${pdate/+0000/$tz}/"
				else
					echo $key $rest
				fi
				;;
			"")
				echo; cat
				;;
			*)
				echo $key $rest
				;;
			esac

		done
}

while true; do
	case "$1" in
		-R)	shift;
			diffsearch=+
			remote="$1"
			shift;;
		-L)	shift;
			diffsearch=-
			remote="$1"
			shift;;
		-r)	shift;
			if [ -z "$r1" ]; then
				r1="$1"
			else
				r2="$1"
			fi
			shift;;
		*)	base="$1"
			break;;
	esac
done

if [ -n "$r1" ]; then
	if [ -z "$r2" ]; then
		showcommit $r1
		exit 0
	fi
	diffsearch=+
	remote=`pwd`;
	tobase="$r2";
	base="$r1"
fi
	
if [ -z "$base" ]; then
	base=$(cat .git/HEAD) || exit 1
fi

rev-tree $base | sort -rn  > ${tmpfile}.base
if [ -n "$remote" ]; then
	[ -d $remote/.git ] || exit 1
	if [ -z "$tobase" ]; then
		tobase=$(cat $remote/.git/HEAD) || exit 1
	fi
	pushd $remote > /dev/null
	rev-tree $tobase | sort -rn > ${tmpfile}.remote
	diff -u ${tmpfile}.base ${tmpfile}.remote | grep "^${diffsearch}[^${diffsearch}]" | cut -c 1- > ${tmpfile}.diff
	rm -f ${tmpfile}.base ${tmpfile}.remote
	mv ${tmpfile}.diff ${tmpfile}.base
	if [ $diffsearch = "-" ]; then
		popd > /dev/null
	fi
fi

[ -s "${tmpfile}.base" ] || exit 0

cat ${tmpfile}.base | while read time commit parents; do
	showcommit $commit
	echo -e "\n--------------------------"

done
rm -f ${tmpfile}.base


