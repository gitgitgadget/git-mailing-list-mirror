From: =?ISO-8859-1?Q?=22Peter_Valdemar_M=F8rch_=28Lists=29=22?= 
	<4ux6as402@sneakemail.com>
Subject: Re: How to fix (and find) many git-* --check errors?
Date: Fri, 08 Aug 2008 16:57:25 +0200
Message-ID: <489C5ED5.2060501@sneakemail.com>
References: <489C40BC.8000008@sneakemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 08 16:58:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KRTQH-0004d8-1m
	for gcvg-git-2@gmane.org; Fri, 08 Aug 2008 16:58:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751973AbYHHO52 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 8 Aug 2008 10:57:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751633AbYHHO52
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Aug 2008 10:57:28 -0400
Received: from morch.com ([193.58.255.207]:34905 "EHLO morch.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751287AbYHHO52 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Aug 2008 10:57:28 -0400
Received: from [192.168.1.214] (ANice-157-1-71-161.w90-36.abo.wanadoo.fr [90.36.206.161])
	by morch.com (Postfix) with ESMTP id 6107927F2
	for <git@vger.kernel.org>; Fri,  8 Aug 2008 16:59:58 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.16 (X11/20080724)
In-Reply-To: <489C40BC.8000008@sneakemail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91676>

Thanks to hints from both Jeff King and Bj=F6rn Stenbrink I got it=20
working. Here is my script, if anybody is interested.

It handles both fixing whitespace in current workspace diffs:

$ git-fix-whitespace file

(requires existing diffs)

and fixing all whitespace problems in a file:

$ git-fix-whitespace -f file

(asserts no existing diffs)

Now all I need to do is grock how to fix stuff already in the index, bu=
t=20
I'll leave that for another day...

Peter

-----------------
#!/bin/bash

# Take a -f option to fix all whitespace problems in entire files
# completely. Otherwise only fix current diffs.

# Option handling
while getopts fh? o
do=09
     case "$o" in
	f)	fixEntireFile=3D1;;
	[h?])	echo >&2 "Usage: $0 [-f] file ..."
		echo >&2 "-f: Fix the entire file"
		echo >&2 "    Otherwise only fix current diffs"
		exit 1;;
     esac
done

shift $(($OPTIND-1))

# A constant for a rev that is empty
EMPTY_TREE_SHA1=3D4b825dc642cb6eb9a060e54bf8d69288fbee4904

# Check to see we're on a clean HEAD just to be sure.
# (Not sure this is necessary, but just in case.)
git --no-pager diff --exit-code HEAD -- "$@"  > /dev/null
if [ $? =3D 0 ] ; then
	# There is no current diff
	if [ "$fixEntireFile" !=3D "" ] ; then
		# Good, there is no diff, and we've been asked to fix
		# the entire file

		# Remove all files - the -f for rm is just needed if
		# $@ happens to contain only untracked files
		git-ls-tree -z  -r --name-status HEAD "$@"  | \
			xargs --null rm -f

		# Re-create the files - but with whitespace fixed
		git diff $EMPTY_TREE_SHA1 HEAD -- "$@" | \
			git-apply --whitespace=3Dfix
	else
		echo >&2 '*Error*: there no diff with HEAD'
		exit 1
	fi
else
	# There is a current diff
	if [ "$fixEntireFile" =3D "" ] ; then
		# Good, there is a current diff, that we need to fix
		TEMP_FILE=3D$(tempfile)
		git diff -- "$@" > $TEMP_FILE
		git checkout HEAD -- "$@"
		git apply --whitespace=3Dfix $TEMP_FILE
		rm $TEMP_FILE
	else
		echo >&2 '*Error*: there is diff with HEAD'
		exit 1
	fi
fi
