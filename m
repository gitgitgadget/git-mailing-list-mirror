From: Torsten =?utf-8?q?B=C3=B6gershausen?= <tboegi@web.de>
Subject: [RFC][PATCH v2]  git on Mac OS and precomposed unicode
Date: Mon, 9 Jan 2012 17:45:24 +0100
Message-ID: <201201091745.25252.tboegi@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: tboegi@web.de
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 09 17:45:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RkILl-0005pE-H2
	for gcvg-git-2@lo.gmane.org; Mon, 09 Jan 2012 17:45:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932341Ab2AIQp2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 9 Jan 2012 11:45:28 -0500
Received: from fmmailgate03.web.de ([217.72.192.234]:51792 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932234Ab2AIQp1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 9 Jan 2012 11:45:27 -0500
Received: from moweb001.kundenserver.de (moweb001.kundenserver.de [172.19.20.114])
	by fmmailgate03.web.de (Postfix) with ESMTP id 8B7291AF59941
	for <git@vger.kernel.org>; Mon,  9 Jan 2012 17:45:26 +0100 (CET)
Received: from maxi.localnet ([194.22.188.61]) by smtp.web.de (mrweb002) with
 ESMTPA (Nemesis) id 0MWirL-1SC9AD1P8l-00Xdme; Mon, 09 Jan 2012 17:45:26 +0100
X-Provags-ID: V02:K0:G/UiWBbf5UCRXtV3ZE1M4acTFK6aKm/dC0Oz8D++aVv
 VtwEP9ZmUE9aianuZbK6gXX9OjLfHtNUGBl+atR9JTyVI2OZUt
 mlc+0+J/dEmw/8L8hRpfPuIX6fEImhtBX0yZF14KE6fQtPzCMQ
 nCY++tObib3O+gANFG8QSQUI9vN+im3EWIJI/88/D50UwDTm21
 E5JjmiFwdGSS5+J7LFdkw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188177>

Changes since last version:
- Improved testcase t/t3910-mac-os-precompose.sh:
  test "git commit -- pathspec" (Thanks Junio)
- Improved the converting of argv[] for "git commit"

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Purpose:
This patch is a suggestion to work around the unpleasenties
when Mac OS is decomposing unicode filenames.

The suggested change:
a) is only used under Mac OS
b) can be switched off by a configuration variable
c) is optimized to handle ASCII only filename
d) will improve the interwork between Mac OS, Linux and Windows*
   via git push/pull, using USB sticks (technically speaking VFAT)
   or mounted network shares using samba.

* (Not all Windows versions support UTF-8 yet:
   Msysgit needs the unicode branch, cygwin supports UTF-8 since 1.7)


Runtime configuration:
A new confguration variable is added: "core.precomposedunicode"
This variable is only used on Mac OS.
If set to false, git behaves exactly as older versions of git.
When a new git version is installed and there is a repository
where the configuration "core.precomposedunicode" is not present,
the new git is backward compatible.

When core.precomposedunicode=3Dtrue, all filenames are stored in precom=
posed
unicode in the index (technically speaking precomposed UTF-8).
Even when readdir() under Mac OS returns filenames as decomposed.

Implementation:
Two files are added to the "compat" directory, darwin.h and darwin.c.
They implement basically 3 new functions:
darwin_opendir(), darwin_readdir() and darwin_closedir().


Compile time configuration:
A new compiler option PRECOMPOSED_UNICODE is introduced in the Makefile=
,
so that the patch can be switched off completely at compile time.

No decomposed file names in a git repository:
In order to prevent that ever a file name in decomposed unicode is ente=
ring
the index, a "brute force" attempt is taken:
all arguments into git (technically argv[1]..argv[n]) are converted int=
o
precomposed unicode.
This is done in git.c by calling argv_precompose() for all commands:
=46or "git commit" all args after "--" are converted,
for all other commands all argv[] is converted.

This function is actually a #define, and it is only defined under Mac O=
S.
Nothing is converted on any other OS.

Implementation details:
The main work is done in darwin_readdir() and argv_precompose().
The conversion into precomposed unicode is done by using iconv,
where decomposed is denoted by "UTF-8-MAC" and precomposed is "UTF-8".
When already precomposed unicode is precomposed, the string is returned
unchanged.

Thread save:
Since there is no need for argv_precompose()to be thread-save, one icon=
v
instance is created at the beginning and kept for all conversions.
Even readdir() is not thread-save, so that darwin_opendir() will call
iconv_open() once and keep the instance for all calls of darwin_readdir=
()
until darwin_close() is called.

Auto sensing:
When creating a new git repository with "git init" or "git clone", the
"core.precomposedunicode" will be set automatically to "true" or "false=
".

Typically core.precomposedunicode is "true" on HFS and VFAT.
It is even true for file systems mounted via SAMBA onto a Linux box,
and "false" for drives mounted via NFS onto a Linux box.


New test case:
The new t3910-mac-os-precompose.sh is added to check if a filename
can be reached either in precomposed or decomposed unicode (NFC or NFD)=
=2E


Torsten B=C3=B6gershausen (1):
  git on Mac OS and precomposed unicode

 Documentation/config.txt     |    9 ++
 Makefile                     |    3 +
 builtin/init-db.c            |   22 +++++
 compat/darwin.c              |  208 ++++++++++++++++++++++++++++++++++=
++++++++
 compat/darwin.h              |   31 ++++++
 git-compat-util.h            |    8 ++
 git.c                        |    1 +
 t/t0050-filesystem.sh        |    1 +
 t/t3910-mac-os-precompose.sh |  117 +++++++++++++++++++++++
 9 files changed, 400 insertions(+), 0 deletions(-)
 create mode 100644 compat/darwin.c
 create mode 100644 compat/darwin.h
 create mode 100755 t/t3910-mac-os-precompose.sh

--=20
1.7.8.rc0.43.gb49a8
