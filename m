From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Re: [PATCH v2] Allow git mv FileA fILEa on case ignore file systems
Date: Sun, 10 Apr 2011 07:48:21 +0200
Message-ID: <4DA144A5.2080103@web.de>
References: <201103191528.34646.tboegi@web.de> <7vsjuitk59.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: kusmabite@gmail.com, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Apr 10 07:48:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q8nVt-0002JX-Vo
	for gcvg-git-2@lo.gmane.org; Sun, 10 Apr 2011 07:48:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752063Ab1DJFs3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 10 Apr 2011 01:48:29 -0400
Received: from smtp-out12.han.skanova.net ([195.67.226.212]:36010 "EHLO
	smtp-out12.han.skanova.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751700Ab1DJFs2 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 10 Apr 2011 01:48:28 -0400
Received: from birne.lan (194.22.188.61) by smtp-out12.han.skanova.net (8.5.133) (authenticated as tboegi@telia.com)
        id 4D65154400D8965B; Sun, 10 Apr 2011 07:48:23 +0200
User-Agent: Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.6; en-US; rv:1.9.2.15) Gecko/20110303 Thunderbird/3.1.9
In-Reply-To: <7vsjuitk59.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171236>

On 20.03.11 06:50, Junio C Hamano wrote:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>Torsten B=C3=B6gershausen <tboegi@web.de> writes:
>
>> > The typical use case is when a file "FileA" should be renamed into=
 fILEa
>> > and we are on a case insenstive file system (system core.ignorecas=
e =3D true).
>> > Source and destination are the same file, it can be accessed under=
 both names.
>> > This makes git think that the destination file exists.
>> > Unless used with --forced, git will refuse the "git mv FileA fILEa=
".
>> > This change will allow "git mv FileA fILEa" under the following co=
ndition:
>> > On Linux/Unix/Mac OS X the move is allowed when the inode of the s=
ource and
>> > destination are equal (and they are on the same device).
>> > This allows renames of M=C3=84RCHEN into M=C3=A4rchen on Mac OS X.
>> > (As a side effect, a file can be renamed to a name which is alread=
y
>> > hard-linked to the same inode).
>> > On Windows, the function win_is_same_file() from compat/win32/same=
-file.c
>> > is used.
>> > It calls GetFileInformationByHandle() to check if both files are
>> > "the same".
>Yeek; is it just me or the above single block of text too dense to be
>readable? Can you use paragraph breaks?
Yes
>
>> > The typical use case is when a file "FileA" should be renamed into=
 fILEa
>> > and we are on a case insenstive file system (system core.ignorecas=
e =3D true).
>Huh? I don't think renaming "FileA" to "fILEa" is typical at all. It i=
s
>very rarely done.
Probably this is not a good example, I changed it to "mv FILE File"

>
>> > (As a side effect, a file can be renamed to a name which is alread=
y
>> > hard-linked to the same inode).
>It is unclear "a side effect" means "an added bonus" or "a regression"=
 in
>this sentence. I think this is latter.
If it is too much regression, we can check that the link count in struc=
t stat
"if (1 =3D=3D st_nlink)" .


>
>Allowing filesystem specific logic to detect that two different "names=
"
>actually refer to a single "file" and help renaming succeed is a sane
>approach, but I think this particular implementation is flawed.
>
>The important thing to notice is that "names" and "file" above refer t=
o
>the entities from the end user's point of view. Two files hardlinked
>together on a filesystem with sane pathname handling are never the sam=
e
>"file". I would probably have called it equivalent_filenames() to stre=
ss
>the fact that two _different_ names alias to the same file. is_same_fi=
le()
>sounds more like you got two different filenames from the filesystem
>(i.e. readdir() gave you both at the same time) and you are trying to =
see
>if they are the same file, but that is not the case here.
Ok, I need to distinct beetwen file names and files.


>I also find it a bad taste to make this feature depend on win32; doesn=
't a
>Linux box mounting a vfat filesystem have the same issue that we shoul=
d be
>able to solve with the same code?  Can't we instead have a configurati=
on
>variable that tells git that the working tree is on a filesystem with
>broken pathname semantics, and what kind of workaround is needed?  Isn=
't
>core.ignorecase already that configuration variable for case insensitv=
e
>filesystems [*1*]?
Agreed about the bad taste ;-)
The suggested patch works for Linux/UNIX/MAC OS X and Windows,=20
but the description wasn't to clear about it.
The same code is used for all OS, except Windows that needs some specif=
ic code=20
which is located in cygwin.c and mingw.c

>
>I would imagine that the implementation of equivalent_filenames(a,b) m=
ay
>be !strcmp(a,b) for a sane filesystem [*2*] and !strcasecmp(a,b) for a
>case insensitive filesystem.  For a totally wacky filesystem, your
>lstat(2) based one might end up to be the best we could do [*3*].
>
>When two different _names_ "A" and "a" refer to a single file, the onl=
y
>thing that should happen for "git mv A a" is for the cache entry for "=
A"
>to be moved to cache entry for "a", and no rename("A", "a") should be =
run,
>but I don't see any such change in the code. It may happen to work (or=
 be
>a no-op) on Windows, but because builtin/mv.c is supposed to be generi=
c
>(and that is the reason you introduced the is_same_file() abstraction =
in
>the first place), I'd still see this as a breakage.
>
Why shouldn't the rename() be done?
"git mv A B" changes both the indes and the file system.
Isn't it natural to have file name  "a" both in the index and in the=20
file system after "git mv A a"?
Note: Windows and MAC OS X allow "mv A a" from command line,=20
while Linux on VFAT gives an error "'A' and 'a' are the same file".

>
>[Footnote]
>
>*1* Off the top of my head, perhaps core.ignorecase may have to grow i=
nto
>boolean plus extra to cover "this is not just case insensitive, but is=
n't
>even case preserving" kind of broken filesystems like HFS+, but I didn=
't
>think things through.
It is not that bad.
My HFS+ here is both case insenstive and case preserving,
so that core.ignorecase can be used as it is.

Note: HFS+ can be formated to be case sensitive (at least at MAC OS X 1=
0.6),
but the default is case insensitive.

>
>*2* Incidentally, wouldn't "!strcmp(a,b)" solution suddenly start allo=
wing
>"git mv Makefile Makefile" that we currently disallow? Is it a regress=
ion
>(less safety against an unexpected input) or a good change?

When running "git mv git.c git.c", the current git says:
"fatal: can not move directory into itself, source=3Dgit.c, destination=
=3Dgit.c"
That test is done earlier in the code path,=20
so that this move is still not allowed.
The error message is somewhat confusing, as git.c is a file.
Is it worth to send a separate patch for that?

>
>*3* If we can find a solution that does not involve any calls to the
>filesystem, it would be ideal, as we can reuse it later in codepaths w=
here
>neither file "a" or file "b" exists on the filesystem yet (think: "we =
are
>about to create 'a' and 'b'---is that sensible, or will they overwrite
>with each other on this filesystem?").
>
That would mean, that git needs to know the encoding of the local files=
ystem.
But we don't have that at the moment.
What do you have in mind?


I run a test script (see at the end of the mail, save it under test-mv.=
sh and
execute it with /bin/sh test-mv.sh).
I tested Linux, MAC OS X, cygwin 1.5, cygwin 1.7 and current msys(git).
Short summary: There are different flavors which filenames are equivale=
nt.

I send out a new patch, thank you for reading this long stuff.

/Torsten


=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Linux 2.6.34.7-0.7-default
/dev/sda6 on /D type vfat (rw,noexec,nosuid,nodev,gid=3D100,umask=3D000=
2,utf8=3Dtrue)
enc=3DUTF-8
a=3DA    Case ignored
mv: `a' and `A' are the same file

=C3=A6=3D=C3=86    Case ignored
mv: `=C3=A6' and `=C3=86' are the same file

=C3=B8=3D=C3=B8    Case sensitive
mv:  =C3=B8  -->  =C3=98  OK

=C3=A4=3D=C3=84    Case ignored
mv: `=C3=A4' and `=C3=84' are the same file
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Linux 2.6.34.7-0.7-default
/dev/sda6 on /D type vfat (rw)
enc=3DUTF-8
a=3DA    Case ignored
mv: `a' and `A' are the same file

=C3=A6=3D=C3=A6    Case sensitive
mv:  =C3=A6  -->  =C3=86  OK

=C3=B8=3D=C3=B8    Case sensitive
mv:  =C3=B8  -->  =C3=98  OK

=C3=A4=3D=C3=A4    Case sensitive
mv:  =C3=A4  -->  =C3=84  OK
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Linux 2.6.34.7-0.7-default
//birne/tb on /birne/tb type cifs (rw)
enc=3DUTF-8
a=3DA    Case ignored
mv:  a  -->  A  OK

=C3=A6=3D=C3=86    Case ignored
mv:  =C3=A6  -->  =C3=86  OK

=C3=B8=3D=C3=98    Case ignored
mv:  =C3=B8  -->  =C3=98  OK

=C3=A4=3D=C3=84    Case ignored
mv:  =C3=A4  -->  =C3=84  OK
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Darwin 10.7.0
/dev/disk0s2 on / (hfs, local, journaled)
enc=3DUTF-8
a=3DA    Case ignored
mv:  a  -->  A  OK

=C3=A6=3D=C3=86    Case ignored
mv:  =C3=A6  -->  =C3=86  OK

=C3=B8=3D=C3=98    Case ignored
mv:  =C3=B8  -->  =C3=98  OK

=C3=A4=3D=C3=84    Case ignored
mv:  =C3=A4  -->  =C3=84  OK
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Darwin 10.7.0
/dev/disk1s3 on /Volumes/LACIEFAT (msdos, local, nodev, nosuid, noowner=
s)
enc=3DUTF-8
a=3DA    Case ignored
mv:  a  -->  A  OK

=C3=A6=3D=C3=86    Case ignored
mv:  =C3=A6  -->  =C3=86  OK

=C3=B8=3D=C3=98    Case ignored
mv:  =C3=B8  -->  =C3=98  OK

=C3=A4=3D=C3=84    Case ignored
mv:  =C3=A4  -->  =C3=84  OK
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Darwin 10.7.0
/dev/disk1s2 on /Volumes/LacieMacOS (hfs, local, nodev, nosuid, journal=
ed)
enc=3DUTF-8
a=3Da    Case sensitive
mv:  a  -->  A  OK

=C3=A6=3D=C3=A6    Case sensitive
mv:  =C3=A6  -->  =C3=86  OK

=C3=B8=3D=C3=B8    Case sensitive
mv:  =C3=B8  -->  =C3=98  OK

=C3=A4=3D=C3=A4    Case sensitive
mv:  =C3=A4  -->  =C3=84  OK
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
CYGWIN_NT-5.1 1.5.25(0.156/4/2)
C:\cygwin on / type system (binmode)
enc=3DISO-8859-1
a=3DA    Case ignored
mv:  a  -->  A  OK

=C3=A6=3D=C3=86    Case ignored
mv: `=C3=A6' and `=C3=86' are the same file

=C3=B8=3D=C3=98    Case ignored
mv: `=C3=B8' and `=C3=98' are the same file

=C3=A4=3D=C3=84    Case ignored
mv: `=C3=A4' and `=C3=84' are the same file
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
CYGWIN_NT-5.1 1.7.8(0.236/5/3)
C:/cygwin on / type ntfs (binary,auto)
enc=3DUTF-8
a=3DA    Case ignored
mv:  a  -->  A  OK

=C3=A6=3D=C3=86    Case ignored
mv: `=C3=A6' and `=C3=86' are the same file

=C3=B8=3D=C3=98    Case ignored
mv: `=C3=B8' and `=C3=98' are the same file

=C3=A4=3D=C3=84    Case ignored
mv: `=C3=A4' and `=C3=84' are the same file
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
MINGW32_NT-5.1 1.0.12(0.46/3/2)
C:\msysgit\msysgit on / type user (binmode,noumount)
enc=3DISO-8859-1
a=3DA    Case ignored
mv:  a  -->  A  OK

=C3=A6=3D=C3=86    Case ignored
mv:  =C3=A6  -->  =C3=86  OK

=C3=B8=3D=C3=98    Case ignored
mv:  =C3=B8  -->  =C3=98  OK

=C3=A4=3D=C3=84    Case ignored
mv:  =C3=A4  -->  =C3=84  OK





=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
#!/bin/sh
testmv() {
  (echo $1 > $1 && echo $2 > $2) || {
    echo >&2 "Wrong encoding $enc"
    cd ..
    rm -rf $$.trash
    exit 1
  }
  a=3D$(cat $1)
  printf "$1=3D$a"
  if test $(cat $1) !=3D $1; then
    echo "    Case ignored"
  else
    echo "    Case sensitive"
  fi
  rm -f $1 $2

  echo $1 > $1
  if mv $1 $2; then
    echo "mv:  $1  -->  $2  OK"
  fi
  rm -f $1 $2
  echo
  return 0
}

rm -rf $$.trash
mkdir $$.trash || {
  echo >&2 "mkdir $$.trash failed"
  exit 1
}

cd $$.trash || {
  echo >&2 "cd $$.trash failed"
  exit 1
}
uname -sr
# get root dir
rdir=3D$PWD
while test "$rdir" !=3D ""
do
  if mount | grep $rdir; then
    break
  fi
  rdir=3D${rdir%/*}
done
if test -z $rdir; then
  mount | grep " / "
fi

enc=3DISO-8859-1
#Find out if utf-8 is used
case "$LANG" in
  *[uU][tT][fF]*8)
  enc=3DUTF-8
  ;;
esac
case "$LC_CTYPE" in
  *[uU][tT][fF]*8)
  enc=3DUTF-8
  ;;
esac

case $(uname) in
  Darwin)
  enc=3DUTF-8
  ;;
esac

echo enc=3D$enc

case "$enc" in
  UTF-8)
  ae=3D$(printf '\303\246')
  AE=3D$(printf '\303\206')
  oe=3D$(printf '\303\270')
  OE=3D$(printf '\303\230')
  auml=3D$(printf '\303\244')
  Auml=3D$(printf '\303\204')
  ;;
  *)
  ae=3D$(printf '\346')
  AE=3D$(printf '\306')
  oe=3D$(printf '\370')
  OE=3D$(printf '\330')
  auml=3D$(printf '\344')
  Auml=3D$(printf '\304')
  ;;
esac

testmv a A
testmv $ae $AE
testmv $oe $OE
testmv $auml $Auml

cd ..
rm -rf $$.trash
