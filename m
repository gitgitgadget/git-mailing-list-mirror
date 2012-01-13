From: tb <tboegi@web.de>
Subject: [RFC][PATCH v3] git on Mac OS and precomposed unicode
Date: Fri, 13 Jan 2012 22:53:00 +0100
Message-ID: <201201132253.00799.tboegi@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: tboegi@web.de
To: gitster@pobox.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 13 22:53:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rlp3y-0003yl-FF
	for gcvg-git-2@lo.gmane.org; Fri, 13 Jan 2012 22:53:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759295Ab2AMVx0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 13 Jan 2012 16:53:26 -0500
Received: from fmmailgate01.web.de ([217.72.192.221]:48045 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754002Ab2AMVxZ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 13 Jan 2012 16:53:25 -0500
Received: from moweb001.kundenserver.de (moweb001.kundenserver.de [172.19.20.114])
	by fmmailgate01.web.de (Postfix) with ESMTP id 8CE4F1A8CB25B
	for <git@vger.kernel.org>; Fri, 13 Jan 2012 22:53:12 +0100 (CET)
Received: from wanderer.localnet ([194.22.188.61]) by smtp.web.de (mrweb002)
 with ESMTPA (Nemesis) id 0M2dxF-1Sdv2u1iTN-00s8G5; Fri, 13 Jan 2012 22:53:09
 +0100
X-Provags-ID: V02:K0:L0Q96Cr648e/cfdTHrM9va0L97xX0Jq+Zs7/bxEOWDm
 UPbrfPl5A9SYwuR6a9RHlQBzb/WAxNxnIes9Ahpq9DmNYjmGfy
 75XYREUOPIDV3MHvPMlR3DcfXWbQSmz3zV3+h8LqQr+Juu7by+
 ZgLt+jMW0GVX72D8k0coffP782h71LFSZjeczy4rYgw75L2qXy
 NtrC3HJNOIUwvrN9BpP1A==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188540>

Changes since V2:
- renamed compat/darwin.[ch] into compat/precomposed_utf8.[ch]
- builtin/init-db.c: use probe_utf8_pathname_composition()
- fix in reencode_string_iconv(): Don't call iconv_close()
- Allways convert all arguments, no special handling for "git commit"
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
They implement basically 4 new functions:
precomposed_utf8_opendir(), precomposed_utf8_readdir(),
precomposed_utf8_closedir() argv_precompose()



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
This is done in git.c by calling argv_precompose().
This function is actually a #define, and it is only defined under Mac O=
S.
Nothing is converted on any other OS.

Implementation details:
The main work is done in precomposed_utf8_readdir() and argv_precompose=
().
The conversion into precomposed unicode is done by using iconv,
where decomposed is denoted by "UTF-8-MAC" and precomposed is "UTF-8".
When already precomposed unicode is precomposed, the string is returned
unchanged.

Thread save:
Since there is no need for argv_precompose()to be thread-save, one icon=
v
instance is created at the beginning and kept for all conversions.
Even readdir() is not thread-save, so that precomposed_utf8_opendir() w=
ill call
iconv_open() once and keep the instance for all calls of precomposed_ut=
f8_readdir()
until precomposed_utf8_close() is called.

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
 builtin/init-db.c            |    2 +
 compat/precomposed_utf8.c    |  213 ++++++++++++++++++++++++++++++++++=
++++++++
 compat/precomposed_utf8.h    |   39 ++++++++
 git-compat-util.h            |    9 ++
 git.c                        |    1 +
 t/t0050-filesystem.sh        |    1 +
 t/t3910-mac-os-precompose.sh |  117 +++++++++++++++++++++++
 9 files changed, 394 insertions(+), 0 deletions(-)
 create mode 100644 compat/precomposed_utf8.c
 create mode 100644 compat/precomposed_utf8.h
 create mode 100755 t/t3910-mac-os-precompose.sh

--=20
1.7.8.rc0.43.gb49a8
