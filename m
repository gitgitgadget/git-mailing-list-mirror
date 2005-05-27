From: Pavel Pisa <pisa@cmp.felk.cvut.cz>
Subject: Re: GIT and COGITO individual scripts hidding from PATH
Date: Fri, 27 May 2005 18:29:42 +0200
Message-ID: <200505271829.43511.pisa@cmp.felk.cvut.cz>
References: <200504132249.16848.pisa@cmp.felk.cvut.cz> <20050524111333.GA11223@pasky.ji.cz> <200505271824.05105.pisa@cmp.felk.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 27 18:28:10 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DbheT-0001fI-Hw
	for gcvg-git@gmane.org; Fri, 27 May 2005 18:25:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262487AbVE0Q1n (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 27 May 2005 12:27:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262489AbVE0Q1n
	(ORCPT <rfc822;git-outgoing>); Fri, 27 May 2005 12:27:43 -0400
Received: from av1.karneval.cz ([81.27.192.107]:24581 "EHLO av1.karneval.cz")
	by vger.kernel.org with ESMTP id S262487AbVE0Q1f (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 27 May 2005 12:27:35 -0400
Received: from localhost (localhost [127.0.0.1])
	by av1.karneval.cz (Postfix) with ESMTP id A462C70BA7;
	Fri, 27 May 2005 18:54:14 +0200 (CEST)
Received: from av1.karneval.cz ([127.0.0.1])
 by localhost (av1 [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 23655-07; Fri, 27 May 2005 18:54:14 +0200 (CEST)
Received: from mail.karneval.cz (mx1.karneval.cz [81.27.192.53])
	by av1.karneval.cz (Postfix) with ESMTP id ED4E070BA6;
	Fri, 27 May 2005 18:54:13 +0200 (CEST)
Received: from [10.5.150.25] (unknown [10.5.150.25])
	by mail.karneval.cz (Postfix) with ESMTP id BFB04571763;
	Fri, 27 May 2005 18:27:33 +0200 (CEST)
To: Petr Baudis <pasky@ucw.cz>
User-Agent: KMail/1.8
In-Reply-To: <200505271824.05105.pisa@cmp.felk.cvut.cz>
Content-Disposition: inline
X-Virus-Scanned: by karneval.cz
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Excuse me for resending of e-mail again, but I have forget
to disable wrapping of lines. Sending as attachmet would be
more secure, but I do not know, if it is convenient
on the git list.

The "cgt" is wrapper for all cogito programs. If cogito is
build and installed to any prefix directory (/opt/git-cogito in my case)
and script is copied to bin subdirectory (/opt/git-cogito/bin),
then only single symbolic link from some searchable directory on PATH
is enough to call all cogito commands
  cgt pull
  cgt update
so usage is more convenient for my fingers learned to type cvs up, etc.
I think, that addition of intelligent bash completion could be done easier
if number of the first level commands to cover is smaller.

"cgt" script
---------------------------------------------------------------------------
#!/usr/bin/env bash
#
# The GIT scripted toolkit.
# Copyright (c) Petr Baudis, 2005
#
# Script to automatically wrap individual GIT commands under one script
# for those, who prefer only one or two links in /usr/local/bin
# This script added by Pavel Pisa <pisa@cmp.felk.cvut.cz>
#
# This command mostly only multiplexes to the individual scripts based
# on the first argument.

error () {
	echo cgt: $@ >&2
}
die () {
	error $@
	exit 1
}

if [ -z "$GIT_TOOLS_DIR" ] ; then
	GIT_MUXBINARY_DIR="$(dirname "$0")"
	if [ -h "$0" ]; then
		#GIT_TOOLS_DIR="$(ls -l "$0" | sed 's/^.*-> *\(.*\) *$/\1/')"
		GIT_TOOLS_DIR="$(readlink -f -n $0)"
	        GIT_TOOLS_DIR="$(dirname "$GIT_TOOLS_DIR")"
		GIT_TOOLS_DIR="$(cd "$GIT_MUXBINARY_DIR" ; cd "$GIT_TOOLS_DIR" ; pwd )"
	else
		GIT_TOOLS_DIR="$(cd "$GIT_MUXBINARY_DIR" ; pwd )"
	fi

	if [ -z "$(echo :$PATH: | sed -n -e 's#:'"$GIT_TOOLS_DIR"':#yes#p' )" ] ; then
		export PATH="$GIT_TOOLS_DIR:$PATH"
	fi

	export GIT_TOOLS_DIR
fi

#echo =$GIT_TOOLS_DIR
#echo PATH=$PATH
#echo CWD=$(pwd)
#exit 

help () {
	echo "cgt recognizes next commands:" >&2 
	(cd $GIT_TOOLS_DIR ; ls cg-* ) | sed -n -e 's/\<cg-\([^ ]*\)\>/\1/pg' >&2 
}


cmd=$1; shift

if [ ! "$cmd" ]; then
	error "missing command"
	help
	exit 1
fi

cgt_cmd_exe="${GIT_TOOLS_DIR}/cg-$cmd"

if [ ! -e "$cgt_cmd_exe" ]; then
	error "unrecognized command ${cmd}"
	help
	exit 1
fi

"$cgt_cmd_exe" "$@"
---------------------------------------------------------------------------

"git" script
---------------------------------------------------------------------------
#!/usr/bin/env bash
#
# The GIT scripted toolkit.
# Copyright (c) Petr Baudis, 2005
#
# Script to automatically wrap individual GIT commands under one script
# for those, who prefer only one or two links in /usr/local/bin
# This script added by Pavel Pisa <pisa@cmp.felk.cvut.cz>
#
# This command mostly only multiplexes to the individual scripts based
# on the first argument.

error () {
	echo git: $@ >&2
}
die () {
	error $@
	exit 1
}

if [ -z "$GIT_TOOLS_DIR" ] ; then
	GIT_MUXBINARY_DIR="$(dirname "$0")"
	if [ -h "$0" ]; then
		#GIT_TOOLS_DIR="$(ls -l "$0" | sed 's/^.*-> *\(.*\) *$/\1/')"
		GIT_TOOLS_DIR="$(readlink -f -n $0)"
	        GIT_TOOLS_DIR="$(dirname "$GIT_TOOLS_DIR")"
		GIT_TOOLS_DIR="$(cd "$GIT_MUXBINARY_DIR" ; cd "$GIT_TOOLS_DIR" ; pwd )"
	else
		GIT_TOOLS_DIR="$(cd "$GIT_MUXBINARY_DIR" ; pwd )"
	fi

	if [ -z "$(echo :$PATH: | sed -n -e 's#:'"$GIT_TOOLS_DIR"':#yes#p' )" ] ; then
		export PATH="$GIT_TOOLS_DIR:$PATH"
	fi

	export GIT_TOOLS_DIR
fi

#echo =$GIT_TOOLS_DIR
#echo PATH=$PATH
#echo CWD=$(pwd)
#exit 

help () {
	echo "git recognizes next commands:" >&2 
	(cd $GIT_TOOLS_DIR ; ls git-* ) | sed -n -e 's/\<git-\([^ ]*\)\>/\1/pg' >&2 
}


cmd=$1; shift

if [ ! "$cmd" ]; then
	error "missing command"
	help
	exit 1
fi

git_cmd_exe="${GIT_TOOLS_DIR}/git-$cmd"

if [ ! -e "$git_cmd_exe" ]; then
	error "unrecognized command ${cmd}"
	help
	exit 1
fi

"$git_cmd_exe" "$@"
---------------------------------------------------------------------------
