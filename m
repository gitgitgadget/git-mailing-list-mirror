From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Re: [PATCH V4] git on Mac OS and precomposed unicode
Date: Sun, 29 Jan 2012 11:29:53 +0100
Message-ID: <4F251FA1.80400@web.de>
References: <201201212036.57632.tboegi@web.de> <7vsjj8acmh.fsf@alter.siamese.dyndns.org> <CACsJy8BKQHLdoXfSKsULkWWbWjWEuZgr=bVNKmgCSArvwbf2UA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	=?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jan 29 11:30:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RrS1O-0003Se-9b
	for gcvg-git-2@plane.gmane.org; Sun, 29 Jan 2012 11:30:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751826Ab2A2K37 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 29 Jan 2012 05:29:59 -0500
Received: from smtp-out21.han.skanova.net ([195.67.226.208]:53561 "EHLO
	smtp-out21.han.skanova.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751482Ab2A2K36 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 29 Jan 2012 05:29:58 -0500
Received: from birne.lan (194.22.188.61) by smtp-out21.han.skanova.net (8.5.133) (authenticated as tboegi@telia.com)
        id 4EC0B93A01C345F9; Sun, 29 Jan 2012 11:29:55 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:9.0) Gecko/20111222 Thunderbird/9.0.1
In-Reply-To: <CACsJy8BKQHLdoXfSKsULkWWbWjWEuZgr=bVNKmgCSArvwbf2UA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189285>

On 22.01.12 10:58, Nguyen Thai Ngoc Duy wrote:
> On Sun, Jan 22, 2012 at 5:56 AM, Junio C Hamano <gitster@pobox.com> w=
rote:
>> [Pinging Nguyen who has worked rather extensively on the start-up se=
quence
>> for ideas.]
>>
[snip]
>=20
> I just have a quick look, you reencode opendir, readdir, and
> closedir() to precomposed form. But files are still in decomposed
> form, does open(<precomposed file>) work when only <decomposed file>
> exists?

Yes. All function like stat(), lstat(), open(), fopen(), unlink() behav=
e the same
for precomped or decomposed. This is similar to the ignore case feature=
=2E
And because the default HFS+ is case preserving, case insenstive and un=
icode decomposing
all at the same time, a file name "=C3=84" could be reached under 4 dif=
ferent names.
Please see the output of the test script:
(which is at the end of this email)

tests/Darwin_i386/NFC file name created as nfc is readable as nfd
tests/Darwin_i386/NFC readdir returns nfd but expected is nfc
tests/Darwin_i386/NFD file name created as nfd is readable as nfc
tests/Darwin_i386/NFCNFD 1 file found in directory, but there should be=
 2
tests/Darwin_i386/NFCNFD nfc is missing, nfd is present
tests/Darwin_i386/NFCNFD nfc File content overwritten by nfd
tests/Darwin_i386/NFDNFC 1 file found in directory, but there should be=
 2
tests/Darwin_i386/NFDNFC nfc is missing, nfd is present
tests/Darwin_i386/NFDNFC nfd File content overwritten by nfc


>=20
>>> In order to prevent that ever a file name in decomposed unicode is
>>> entering the index, a "brute force" attempt is taken: all arguments=
 into
>>> git (argv[1]..argv[n]) are converted into precomposed unicode.  Thi=
s is
>>> done in git.c by calling precompose_argv().  This function is actua=
lly a
>>> #define, and it is only defined under Mac OS.  Nothing is converted=
 on
>>> any other platforms.
>=20
> This is not entirely safe. Filenames can be taken from a file for
> example (--stdin option or similar). Unless I'm mistaken, all file
> names must enter git through the index, the conversion at read-cache.=
c
> may be a better option.
Good point, thanks.=20
I added some code to read-cache.c, and it works for files, but not for =
directories.
I looked through the code for "case-ignoring" directory names, and coul=
dn't
find something obvious. More work is to be done.
=20

[snip]
> I'd rather encode at index level and read_directory() than at argv[].
>But if reencoding argv is the only feasible way, perhaps put the
>conversion in parse_options()?

I tried that, and found that git-lsfiles.c doesn't use parse_options.

[snip]

On the long run I want to get rid of the argv[] conversion completely,
but I'm not there yet.

Thanks for all comments and inspiration!

(and apologies for my long response times I use to have)
/Torsten



PS:
Here the script.
Mac OS writes decomposd unicode to HFS+, precomposed unicode to VFAT an=
d SAMBA.
In any case readdir() returns decomposed.

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
#!/bin/sh
errorandout() {
  echo Error: The shell can not handle nfd
  echo try to run /bin/bash $0
  rm -rf $DIR
  exit 1
}

checkDirNfcOrNfd() {
  DDNFCNFD=3D$1
  readdirexp=3D$2
  if test -r $DDNFCNFD/$aumlnfc; then
    x=3D`cat $DDNFCNFD/$aumlnfc`
    if test "$x" =3D nfd; then
      echo $DDNFCNFD file name created as nfd is readable as nfc
    fi
  fi
  if test -r $DDNFCNFD/$aumlnfd; then
    x=3D`cat $DDNFCNFD/$aumlnfd 2>/dev/null` || {
      echo $DDNFCNFD nfd is not readable, but readdir says that it exis=
t
    }
    if test "$x" =3D nfc; then
      echo $DDNFCNFD file name created as nfc is readable as nfd
    fi
  fi
  readdirres=3D`echo $DDNFCNFD/*`
  if test "$readdirres" !=3D "$DDNFCNFD/$readdirexp"; then
    if test "$readdirres" =3D $DDNFCNFD/$aumlnfd; then
      echo $DDNFCNFD readdir returns nfd but expected is nfc
    fi
    if test "$readdirres" =3D $DDNFCNFD/$aumlnfc; then
      echo $DDNFCNFD readdir returns nfc but expected is nfd
    fi
  fi
}

checkdirnfcnfd() {
  DDNFCNFD=3D$1
  if test `ls -1 $DDNFCNFD | wc -l` !=3D 2; then
    if test `ls -1 $DDNFCNFD | wc -l` =3D=3D 1; then
      echo $DDNFCNFD 1 file found in directory, but there should be 2
    else
      echo $DDNFCNFD 2 files should be in directory
    fi =20
  fi

  x=3D`echo $DDNFCNFD/*`
  a=3D`echo $DDNFCNFD/$aumlnfd $DDNFCNFD/$aumlnfc`
  b=3D`echo $DDNFCNFD/$aumlnfc $DDNFCNFD/$aumlnfd`
  c=3D`echo $DDNFCNFD/$aumlnfc $DDNFCNFD/$aumlnfc`
  d=3D`echo $DDNFCNFD/$aumlnfd $DDNFCNFD/$aumlnfd`
  e=3D`echo $DDNFCNFD/$aumlnfc`
  f=3D`echo $DDNFCNFD/$aumlnfd`
  case "$x" in
    $a)
    ;;     =20
    $b)
    ;;
    $c)
    echo $DDNFCNFD nfd is hidden, nfc is listed twice
    ;;
    $d)
    echo $DDNFCNFD nfc is hidden, nfd is listed twice
    ;;
    $e)
    echo $DDNFCNFD nfd is missing, nfc is present
    ;;     =20
    $f)
    echo $DDNFCNFD nfc is missing, nfd is present
    ;;     =20
    *)
    echo $DDNFCNFD x`echo $x | xxd`
    ;;
  esac

  if ! test -r $DDNFCNFD/$aumlnfc; then
    echo $DDNFCNFD/nfc File does not exist
  else
    x=3D`cat $DDNFCNFD/$aumlnfc`
    if test "$x" !=3D nfc; then
      echo $DDNFCNFD nfc File content overwritten by $x
    fi
  fi
 =20
  if ! test -r $DDNFCNFD/$aumlnfd; then
    echo $DDNFCNFD/nfd File does not exist
  else
    x=3D`cat $DDNFCNFD/$aumlnfd`
    if test "$x" !=3D nfd; then
      echo $DDNFCNFD nfd File content overwritten by $x
    fi
  fi
}


aumlnfc=3D$(printf '\303\204')
aumlnfd=3D$(printf '\101\314\210')

DIR=3Dtests/`uname -s`_`uname -m`
echo "DIR=3D$DIR"

rm -rf $DIR/NFC &&
rm -rf $DIR/NFD &&
rm -rf $DIR/NFCNFD &&
rm -rf $DIR/NFDNFC &&
mkdir -p $DIR/NFC &&
mkdir -p $DIR/NFD &&
mkdir -p $DIR/NFDNFC &&
mkdir -p $DIR/NFCNFD &&
echo nfc > $DIR/NFC/$aumlnfc &&
echo nfd > $DIR/NFD/$aumlnfd &&
echo nfd > $DIR/NFDNFC/$aumlnfd &&
echo nfc > $DIR/NFDNFC/$aumlnfc &&
echo nfc > $DIR/NFCNFD/$aumlnfc &&
echo nfd > $DIR/NFCNFD/$aumlnfd && {
    # test 1: basic if the shell handles nfd
    if ! test -r $DIR/NFD/$aumlnfd; then
      errorandout
    fi

  for DD in tests/*; do
    checkDirNfcOrNfd $DD/NFC  $aumlnfc
    checkDirNfcOrNfd $DD/NFD  $aumlnfd

    checkdirnfcnfd $DD/NFCNFD
    checkdirnfcnfd $DD/NFDNFC
  done
} || errorandout
