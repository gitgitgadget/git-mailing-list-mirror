From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: [PATCH] Push the NATIVE_CRLF Makefile variable to C and added a test
 for native.
Date: Mon, 18 Aug 2014 21:31:20 +0200
Message-ID: <53F25488.8000103@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: tboegi@web.de
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 18 21:31:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XJSeN-00077f-Ap
	for gcvg-git-2@plane.gmane.org; Mon, 18 Aug 2014 21:31:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751938AbaHRTbX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 18 Aug 2014 15:31:23 -0400
Received: from mout.web.de ([212.227.15.14]:62695 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750915AbaHRTbW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Aug 2014 15:31:22 -0400
Received: from macce.local ([78.72.74.102]) by smtp.web.de (mrweb001) with
 ESMTPSA (Nemesis) id 0Lvk56-1WIr5X0QEm-017Uru; Mon, 18 Aug 2014 21:31:20
 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:31.0) Gecko/20100101 Thunderbird/31.0
X-Provags-ID: V03:K0:IKgpww2tlNI+S738zs/wbvnuJBVIbxKKJrFJggrEe3++jhOtNaF
 ekodMAsgE6em3n6UnviwuKnWO8k4DINC6/W9RntjLA2JTB7fD9NW7PqY/pq4qFbTXQi4hDq
 hE8ooA5JIAg6GlCfSZbv1lrjAYLUVkv2CzM4CRkOW4YKLNxmjOoSH8JiBe20dI0bXZv13Dc
 kXX/3hzj9An34pXEHSTrA==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255408>

Commit 95f31e9a correctly points out that the NATIVE_CRLF setting is
incorrectly set on Mingw git. However, the Makefile variable is not
propagated to the C preprocessor and results in no change. This patch
pushes the definition to the C code and adds a test to validate that
when core.eol as native is crlf, we actually normalize text files to th=
is
line ending convention when core.autocrlf is false.

Signed-off-by: Pat Thoyts <patthoyts@users.sourceforge.net>
Signed-off-by: Stepan Kasal <kasal@ucw.cz>
Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
---

(This is from MINGW, and some part of my brain thougth that this was se=
nd
upstream, but it wasn't. Only 95f31e9a is in git.git)

 Makefile              |  3 +++
 t/t0026-eol-config.sh | 18 ++++++++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/Makefile b/Makefile
index 63a210d..13311d2 100644
--- a/Makefile
+++ b/Makefile
@@ -1481,6 +1481,9 @@ ifdef NO_REGEX
 	COMPAT_CFLAGS +=3D -Icompat/regex
 	COMPAT_OBJS +=3D compat/regex/regex.o
 endif
+ifdef NATIVE_CRLF
+	BASIC_CFLAGS +=3D -DNATIVE_CRLF
+endif
=20
 ifdef USE_NED_ALLOCATOR
        COMPAT_CFLAGS +=3D -Icompat/nedmalloc
diff --git a/t/t0026-eol-config.sh b/t/t0026-eol-config.sh
index 4807b0f..43a580a 100755
--- a/t/t0026-eol-config.sh
+++ b/t/t0026-eol-config.sh
@@ -80,4 +80,22 @@ test_expect_success 'autocrlf=3Dtrue overrides unset=
 eol' '
 	test -z "$onediff" && test -z "$twodiff"
 '
=20
+test_expect_success NATIVE_CRLF 'eol native is crlf' '
+
+	rm -rf native_eol && mkdir native_eol &&
+	( cd native_eol &&
+	printf "*.txt text\n" > .gitattributes
+	printf "one\r\ntwo\r\nthree\r\n" > filedos.txt
+	printf "one\ntwo\nthree\n" > fileunix.txt
+	git init &&
+	git config core.autocrlf false &&
+	git config core.eol native &&
+	git add filedos.txt fileunix.txt &&
+	git commit -m "first" &&
+	rm file*.txt &&
+	git reset --hard HEAD &&
+	has_cr filedos.txt && has_cr fileunix.txt
+	)
+'
+
 test_done
--=20
2.1.0.rc2.210.g636bceb
