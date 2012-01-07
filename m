From: Torsten =?utf-8?q?B=C3=B6gershausen?= <tboegi@web.de>
Subject: [PATCH][RFC] git on Mac OS and precomposed unicode
Date: Sat, 7 Jan 2012 20:59:18 +0100
Message-ID: <201201072059.19103.tboegi@web.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: tboegi@web.de
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 07 20:59:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RjcQh-0004Kh-OB
	for gcvg-git-2@lo.gmane.org; Sat, 07 Jan 2012 20:59:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753314Ab2AGT7a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Jan 2012 14:59:30 -0500
Received: from fmmailgate02.web.de ([217.72.192.227]:35862 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753259Ab2AGT73 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Jan 2012 14:59:29 -0500
Received: from moweb002.kundenserver.de (moweb002.kundenserver.de [172.19.20.108])
	by fmmailgate02.web.de (Postfix) with ESMTP id 4B8131BF474D0
	for <git@vger.kernel.org>; Sat,  7 Jan 2012 20:59:23 +0100 (CET)
Received: from maxi.localnet ([194.22.188.61]) by smtp.web.de (mrweb001) with
 ESMTPA (Nemesis) id 0Lz2vo-1SnWt02wTI-014GH4; Sat, 07 Jan 2012 20:59:22 +0100
X-Provags-ID: V02:K0:JpCyRAhO7gR+BBSgYa2QVfWU4v8UmKciBg0tI3LwDmr
 tqE2JzjzO9pPZTs3VdahEjeJz9P4S+Lc4HSaaFo41Qcf0J+T7n
 B9Go2EV3tkObB5hoUZ+MZIFZMH5JhNO8vs+sxDqG1TPzbeEgnb
 j0w21VmNb8NeEqgySdhooMOy+qafbcItbtobCdlxe0nVgdaiXO
 mHxNpZvXaOliyll37h7dw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188085>

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

When core.precomposedunicode=true, all filenames are stored in precomposed
unicode in the index (technically speaking precomposed UTF-8).
Even when readdir() under Mac OS returns filenames as decomposed.

Implementation:
Two files are added to the "compat" directory, darwin.h and darwin.c.
They implement basically 3 new functions:
darwin_opendir(), darwin_readdir() and darwin_closedir().


Compile time configuration:
A new compiler option PRECOMPOSED_UNICODE is introduced in the Makefile,
so that the patch can be switched off completely at compile time.

No decomposed file names in a git repository:
In order to prevent that ever a file name in decomposed unicode is entering
the index, a "brute force" attempt is taken:
all arguments into git (technically argv[1]..argv[n]) are converted into
precomposed unicode.
This is done in git.c by calling argv_precompose() for all commands
except "git commit".
This function is actually a #define, and it is only defined under Mac OS.
Nothing is converted on any other OS.

Implementation details:
The main work is done in darwin_readdir() and argv_precompose().
The conversion into precomposed unicode is done by using iconv,
where decomposed is denoted by "UTF-8-MAC" and precomposed is "UTF-8".
When already precomposed unicode is precomposed, the string is returned
unchanged.

Thread save:
Since there is no need for argv_precompose()to be thread-save, one iconv
instance is created at the beginning and kept for all conversions.
Even readdir() is not thread-save, so that darwin_opendir() will call
iconv_open() once and keep the instance for all calls of darwin_readdir()
until darwin_close() is called.

Auto sensing:
When creating a new git repository with "git init" or "git clone", the
"core.precomposedunicode" will be set automatically to "true" or "false".

Typically core.precomposedunicode is "true" on HFS and VFAT.
It is even true for file systems mounted via SAMBA onto a Linux box,
and "false" for drives mounted via NFS onto a Linux box.


New test case:
The new t3910-mac-os-precompose.sh is added to check if a filename
can be reached either in precomposed or decomposed unicode (NFC or NFD).


 Documentation/config.txt     |    9 ++
 Makefile                     |    3 +
 builtin/init-db.c            |   22 +++++
 compat/darwin.c              |  200 ++++++++++++++++++++++++++++++++++++++++++
 compat/darwin.h              |   31 +++++++
 git-compat-util.h            |    8 ++
 git.c                        |    1 +
 t/t0050-filesystem.sh        |    1 +
 t/t3910-mac-os-precompose.sh |  104 ++++++++++++++++++++++
 9 files changed, 379 insertions(+), 0 deletions(-)
 create mode 100644 compat/darwin.c
 create mode 100644 compat/darwin.h
 create mode 100755 t/t3910-mac-os-precompose.sh

-- 
1.7.8.rc0.43.gb49a8
