From: =?utf-8?Q?Santi_B=C3=A9jar?= <sbejar@gmail.com>
Subject: "git cat" and "git ls"
Date: Wed, 18 Jan 2006 16:10:16 +0100
Message-ID: <87irsh6087.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
X-From: git-owner@vger.kernel.org Wed Jan 18 16:09:24 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EzEuj-00080f-SQ
	for gcvg-git@gmane.org; Wed, 18 Jan 2006 16:07:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030340AbWARPHz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Jan 2006 10:07:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030337AbWARPHz
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Jan 2006 10:07:55 -0500
Received: from ifae-s0.ifae.es ([192.101.162.68]:39328 "EHLO ifae-s0.ifae.es")
	by vger.kernel.org with ESMTP id S1030336AbWARPHy (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 Jan 2006 10:07:54 -0500
Received: from bela (l9.ifae.es [192.101.162.199])
	by ifae-s0.ifae.es (8.11.6/8.11.6) with ESMTP id k0IF7oB16204
	for <git@vger.kernel.org>; Wed, 18 Jan 2006 16:07:50 +0100
To: Git Mailing List <git@vger.kernel.org>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/22.0.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14833>

--=-=-=

Hello,

        following the "git diff" wrapper I've done two new wrappers:

git cat: USAGE='<tag|commit|blob> | [<ent>|-1|-2|-3] -- <file>'

    It shows the content of the giventag/commit/blob.

    You can also ask for a file in a tree or in the index (stage
    optional).

git ls: USAGE='[<ent>] [--] <path>'

    It lists the files in <path> in the <ent> or in the index.

  Santi


--=-=-=
Content-Type: text/x-sh
Content-Disposition: inline; filename=git-cat.sh

#!/bin/sh
#

USAGE='<tag|commit|blob> | [<ent>|-1|-2|-3] -- <file>'
SUBDIRECTORY_OK='Yes'
. git-sh-setup

rev=$(git-rev-parse --revs-only --no-flags --sq "$@") || exit
flags=$(git-rev-parse --no-revs --flags "$@")
files=$(git-rev-parse --no-revs --no-flags --sq "$@")

case "$rev,$files" in
?*' '?*,*|*,?*' '?*)
	usage
	;;
?*,?*)
	sha1=$(eval "git-ls-tree $rev $files" | cut -f 1 | cut -d " " -f 3)
	;;
?*,)
	sha1=$rev
	;;
,?*)
	# Only one file
	[ $(eval "git-ls-files $files | wc -l") != 1 ] && usage
	stg=0
	flag=${flags#-}
	case $flag in
	    1|2|3) stg=$flag;;
	esac
	sha1=$(eval "git-ls-files -s $files" | while read -r mode sha stage name ; do
		[ $stage -eq $stg ] && echo $sha && break ; done)
	;;
*)
	usage
	;;
esac

[ -z $sha1 ] && echo "$(basename $0): $files: Not found" && exit 1
type=$(eval "git-cat-file -t $sha1")

case $type in
    tree)
	usage
	;;
    tag|blob)
	cmd="git-cat-file $type $sha1"
	;;
    commit)
	cmd="git-rev-list --max-count=1 $sha1 --pretty=fuller"
	;;
esac

eval "$cmd"
exit

--=-=-=
Content-Type: text/x-sh
Content-Disposition: inline; filename=git-ls.sh

#!/bin/sh
#

USAGE='[<ent>] [--] <path>'
SUBDIRECTORY_OK='Yes'
. git-sh-setup

tree=$(git-rev-parse --verify $1^{tree} 2>/dev/null)
[ -n "$tree" ] && shift
files=$(git-rev-parse --no-revs --no-flags --sq "$@")

case "$tree" in
"")
        cmd="git-ls-files -s $files"
	;;
?*)
	cmd="git-ls-tree $tree $files"
	;;
esac

eval "$cmd"
exit

--=-=-=--
