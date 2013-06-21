From: Yann Droneaud <ydroneaud@opteya.com>
Subject: Re: git rebase fail with CRLF conversion
Date: Fri, 21 Jun 2013 15:51:53 +0200
Organization: OPTEYA
Message-ID: <6ae09e227e559a024d3ffa13570e81a2@meuh.org>
References: <fb20a7d711fdd218f58f1f2090b1c515@meuh.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jun 21 15:51:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uq1ks-000378-QC
	for gcvg-git-2@plane.gmane.org; Fri, 21 Jun 2013 15:51:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161377Ab3FUNvy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 21 Jun 2013 09:51:54 -0400
Received: from mx-out.ocsa-data.net ([194.36.166.37]:64907 "EHLO
	mx-out.ocsa-data.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161356Ab3FUNvy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Jun 2013 09:51:54 -0400
Received: from [192.168.111.12] (helo=rc.ouvaton.coop)
	by mx-out.ocsa-data.net with esmtpa (Exim - FreeBSD Rulez)
	id 1Uq1kn-000Ieg-7Y
	for <git@vger.kernel.org>; Fri, 21 Jun 2013 15:51:53 +0200
In-Reply-To: <fb20a7d711fdd218f58f1f2090b1c515@meuh.org>
X-Sender: ydroneaud@opteya.com
User-Agent: Roundcube Webmail/0.8.4
X-abuse-contact: abuse@ocsa-data.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228614>

Hi,

Le 21.06.2013 15:41, Yann Droneaud a =C3=A9crit=C2=A0:
>
>
> I believe "git rebase" should not fail here, but more, it must not
> fail in a different fashion randomly.
>
> Please find in reply to this email:
>  - a shell script to demonstrate the behavor


Please find a shell script to test git rebase with .gitattributes text=20
flag
set to enable End-Of-Line (EOL) conversion from CRLF to LF, with=20
core.safecrlf set to warn
and to true.

Regards.

--=20
Yann Droneaud
OPTEYA


----------------------------------8<----------------------------------
#! /bin/sh

set -e

LC_ALL=3DC
export LC_ALL

#GIT_AUTHOR_DATE=3D`date -R`
GIT_AUTHOR_DATE=3D"2001-01-01 00:00:00.+00:00"
GIT_COMMITTER_DATE=3D"$GIT_AUTHOR_DATE"

export GIT_AUTHOR_DATE
export GIT_COMMITTER_DATE

# global settings
set +e
global_core_eol=3D`git config --global core.eol`
global_core_safecrlf=3D`git config --global core.safecrlf`
global_core_autocrlf=3D`git config --global core.autocrlf`
set -e

# archive
if test -d work; then
     dir=3D`mktemp -d work.XXXXX`
     rmdir $dir
     mv work $dir
fi

mkdir work

echo "****** Testing in work *******"

cd work

# prepare
git init
git commit --allow-empty -m "empty root commit"

# local settings, might be different from the global settings
set +e
local_core_eol=3D`git config core.eol`
local_core_safecrlf=3D`git config core.safecrlf`
local_core_autocrlf=3D`git config core.autocrlf`
set -e

echo "global core.eol       =3D $global_core_eol"
echo "global core.safecrlf  =3D $global_core_safecrlf"
echo "global core.autocrlf  =3D $global_core_autocrlf"
echo "local core.eol        =3D $local_core_eol"
echo "local core.safecrlf   =3D $local_core_safecrlf"
echo "local core.autocrlf   =3D $local_core_autocrlf"

# set default configuration
git config --local core.eol native
git config --local core.safecrl warn
git config --local core.autocrlf false

echo "current core.eol      =3D `git config core.eol`"
echo "current core.safecrlf =3D `git config core.safecrlf`"
echo "current core.autocrlf =3D `git config core.autocrlf`"

CRLF=3D"\r\n"
CR=3D"\r"
LF=3D"\n"

# TODO detect line ending on the current environment
if true ; then
     EOL=3D$LF
else
     EOL=3D$CRLF
fi

echo "Create work branches"
git branch import-raw master
git branch import-eol master

echo "Create a branch to be used as new root later"
git checkout import-eol
git commit --allow-empty -m "an empty commit"

file_type=3D

create_raw_file ()
{
     # Want to test mixed EOL:
     # printf "Hello World 1${CRLF}Hello World 2${CRLF}${CR}Hello World=
=20
3${CRLF}Hello World 4" > test
     printf "Hello World 1${CRLF}Hello World 2${CRLF}Hello World=20
3${CRLF}Hello World 4" > test
     file_type=3D"`file test`"
     echo "::: $file_type"

}

check_file ()
{
     local t=3D"`file test`"
     if test "x$file_type" !=3D "x$t" ; then
	file_type=3D"$t"
	echo "::: $file_type"
     fi
}

create_git_attributes ()
{
     printf "test text${EOL}" > .gitattributes
}

#
# First test:
#
# import raw, add .gitattributes after, normalize, rebase
#
echo "=3D=3D=3D=3D=3D BEGIN: first test =3D=3D=3D=3D=3D"
git checkout import-raw
git reset --hard master
create_raw_file
git add test && check_file

git commit -m "Commit raw" && check_file

create_git_attributes  && check_file
git add .gitattributes && check_file
git commit -m "Added git attributes" && check_file

echo "--- First kind of 'normalization'"
#
# trick from https://help.github.com/articles/dealing-with-line-endings
#
git rm --cached test
git reset --hard && check_file
git add test && check_file
git commit -m "Normalization"
check_file
git tag norm1

echo "--- Second kind of 'normalization'"
git reset --hard HEAD^
check_file
create_raw_file
rm test
git checkout test  && check_file
git add test && check_file
git commit -m "Normalization"
check_file
git tag norm2

echo "--- Third kind of 'normalization'"
git reset --hard HEAD^
check_file
create_raw_file
dos2unix test  && check_file
git add test  && check_file
git commit -m "Normalization"
check_file
git tag norm3

echo "--- differences ? ---"
git diff norm1 norm2
git diff norm1 norm3
git diff norm2 norm1
git diff norm2 norm3
git diff norm3 norm1
git diff norm3 norm2

echo "--- rebase, should failed ---"
git rebase import-eol || {
     echo "--- Expected failure to rebase on another branch ---"
     check_file
     git status
     git diff -w --stat
     git diff

     # just adding the file again and continue ...
     git add test && check_file
     git rebase --continue || { echo "### failed to continue rebase" ;=20
exit 1 ; }
     check_file
}

echo "--- rebase complete ---"

check_file

echo "=3D=3D=3D=3D=3D END: first test =3D=3D=3D=3D=3D"


#
# again, with safecrlf set
#
echo "=3D=3D=3D=3D=3D BEGIN: second test =3D=3D=3D=3D=3D"
git config core.safecrlf true

git checkout import-raw
git reset --hard master
create_raw_file
git add test && check_file

git commit -m "Commit raw" && check_file

create_git_attributes  && check_file
git add .gitattributes && check_file
git commit -m "Added git attributes" && check_file

echo "--- First kind of 'normalization', git add should failed"
git rm --cached test
git reset --hard && check_file
git add test && { echo "### git add must failed !" ; exit 1 ; }

echo "--- Second kind of 'normalization', git add should failed"
rm test
git checkout test && check_file
git add test && { echo "### git add must failed !" ; exit 1 ; }

echo "--- Third kind of 'normalization'"
dos2unix test && check_file
git add test && check_file
git commit -m "Normalization"
check_file

echo "--- rebase, should failed ---"
git rebase import-eol || {
     echo "--- Expected failure to rebase on another branch ---"
     check_file
     git status

     set +e
     git diff -w --stat || echo "!? git diff return an error !?"
     git diff || echo "!? git diff return an error !?"
     set -e

     git add test && { echo "### git add must failed !" ; exit 1 ; }

     dos2unix test && check_file
     git add test && check_file
     git status
     git rebase --continue || { echo "### failed to continue rebase" ;=20
exit 1 ; }
     check_file
}

echo "--- rebase complete ---"

check_file

echo "=3D=3D=3D=3D=3D END: second test =3D=3D=3D=3D=3D"

#
# the way around:
# first .gitattributes, then the file with CRLF (with safecrlf unset)
#
echo "=3D=3D=3D=3D=3D BEGIN: third test =3D=3D=3D=3D=3D"
git config core.safecrlf false
git checkout import-raw
git reset --hard master

create_git_attributes
git add .gitattributes
git commit -m "Added git attributes"

create_raw_file
git add test && check_file
git commit -m "Commit raw" && check_file

echo "--- First kind of 'normalization', git commit should failed"
git rm --cached test
git reset --hard && check_file
git add test && check_file
git commit -m "Normalization" && { echo "### git commit should failed=20
here !" ; exit 1 ; }
check_file

echo "--- Second kind of 'normalization', git commit should failed"
rm test
git checkout test && check_file
git add test && check_file
git commit -m "Normalization" && { echo "### git commit should failed=20
here !" ; exit 1 ; }
check_file

echo "--- Third kind of 'normalization', git commit should failed"
dos2unix test && check_file
git add test && check_file
git commit -m "Normalization" && { echo "### git commit should failed=20
here !" ; exit 1 ; }
check_file

echo "--- rebase, should failed ---"
git rebase import-eol || {
     echo "--- Expected failure to rebase on another branch ---"
     check_file
     git status
     git diff -w --stat
     git diff

     # just adding the file again and continue ...
     git add test && check_file
     git rebase --continue || { echo "### failed to continue rebase" ;=20
exit 1 ; }
     check_file
}

echo "--- rebase complete ---"

check_file

echo "=3D=3D=3D=3D=3D END: third test =3D=3D=3D=3D=3D"


#
# the way around
# first .gitattributes, then the file with CRLF (with safecrlf set to=20
true)
#
echo "=3D=3D=3D=3D=3D BEGIN: fourth test =3D=3D=3D=3D=3D"
git config core.safecrlf true
git checkout import-raw
git reset --hard master

create_git_attributes
git add .gitattributes
git commit -m "Added git attributes"

create_raw_file
# with safecrlf set to true, it's impossible to add the file with CRLF.
git add test && { echo "### git add should failed here !" ; exit 1 ; }
dos2unix test && check_file
git add test && check_file
git commit -m "Commit raw" && check_file

echo "--- rebase, should failed ---"
git rebase import-eol || {
     echo "--- Expected failure to rebase on another branch ---"
     check_file
     git status
     git diff -w --stat
     git diff

     # just adding the file again and continue ...
     git add test && check_file
     git rebase --continue || { echo "### failed to continue rebase" ;=20
exit 1 ; }
     check_file
}

echo "--- rebase complete ---"

check_file

echo "=3D=3D=3D=3D=3D END: fourth test =3D=3D=3D=3D=3D"

exit 0
----------------------------------8<----------------------------------
