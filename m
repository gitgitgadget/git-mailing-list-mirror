From: =?utf-8?Q?Santi_B=C3=A9jar?= <sbejar@gmail.com>
Subject: $Revision$ keyword replacement?
Date: Tue, 22 Nov 2005 18:36:41 +0100
Message-ID: <871x18h9ee.fsf@ifae.es>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
X-From: git-owner@vger.kernel.org Tue Nov 22 18:39:06 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Eec3M-0005Eh-AW
	for gcvg-git@gmane.org; Tue, 22 Nov 2005 18:35:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965029AbVKVRfd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 22 Nov 2005 12:35:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965033AbVKVRfd
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Nov 2005 12:35:33 -0500
Received: from ifae-s0.ifae.es ([192.101.162.68]:40377 "EHLO ifae-s0.ifae.es")
	by vger.kernel.org with ESMTP id S965029AbVKVRfc (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 22 Nov 2005 12:35:32 -0500
Received: from bela (nb-sbejar.ifae.es [192.101.162.156])
	by ifae-s0.ifae.es (8.11.6/8.11.6) with ESMTP id jAMHZHZ17845
	for <git@vger.kernel.org>; Tue, 22 Nov 2005 18:35:22 +0100
To: Git Mailing List <git@vger.kernel.org>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/22.0.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12559>

--=-=-=

Hello:

        I'm looking for a $Revision$ replacement. I know, in git all that
        matters are the contents. So the equivalent in git could be:

        How similar this file is to the file $path in these commit(s)?

        What I use now is an ugly shell script (as you might known
        I'm not a C programer), see the attatchment.

        So I get:

311bf741d16ee5d0166639a4fafd9194e504aad3:R094   introduccio.tex sim.tex
b764ee049289f5157238596cccc7a4e15f23896c:R094   introduccio.tex sim.tex
f293e1ab1dfb7ff60cb269ed5b18f9222099a752:R098   introduccio.tex sim.tex
f14c4b2d6799354d376e2026a5b7a85ccce48284:R098   introduccio.tex sim.tex
183af55606310218ca0e9a735dad0827acea7910:R098   introduccio.tex sim.tex
73fd2531cce3db0ca804577fb29f87f413fc4563:R096   introduccio.tex sim.tex

        Do you know any other (or better :) way to do it?

        Thanks

        Santi


--=-=-=
Content-Disposition: inline; filename=git-find-sim

#!/bin/sh
##
## find-sim finds the similarity of one file with the files in the
##           selected commits
##
## The arguments are:
##      $1     - file to compare
##      $n n>2 - arguments for git-rev-list to select the commits
##
. git-sh-setup || die "Not a git archive."

[ ! -e $1 ] && exit 1
file=$1
shift

case $GIT_DIR in
    /*)
	GIT_DIR_ORIG=$GIT_DIR;;
    *)
	GIT_DIR_ORIG=$PWD/$GIT_DIR
esac

tmp=`mktemp -t -d git-find-sim.XXXXXXX`
GIT_DIR_TEMP=$tmp
mkdir -p $GIT_DIR_TEMP/objects/info
[ -e $GIT_DIR_ORIG/objects/info/alternates ] &&
cp $GIT_DIR_ORIG/objects/info/alternates $GIT_DIR_TEMP/objects/info/alternates
echo $GIT_DIR_ORIG/objects >> $GIT_DIR_TEMP/objects/info/alternates
export GIT_DIR=$GIT_DIR_TEMP

trap "rm -rf $tmp" 0 1 2 3 15

git update-index --add $file || exit 1
tree=`git-write-tree`

rev_arg=`GIT_DIR=$GIT_DIR_ORIG git-rev-parse --default HEAD --revs-only "$@"`
revs=`GIT_DIR=$GIT_DIR_ORIG git-rev-list $rev_arg`
for i in $revs; do
    git diff-tree --name-status $i -C $tree | grep $file |
    sed "s/^/$i:/"
done

--=-=-=--
