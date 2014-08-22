From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: [PATCH v2 1/3] Push the NATIVE_CRLF Makefile variable to C and added
 a test for native.
Date: Fri, 22 Aug 2014 21:18:57 +0200
Message-ID: <53F797A1.1060804@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: tboegi@web.de
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 22 21:19:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XKuMg-0000ja-MR
	for gcvg-git-2@plane.gmane.org; Fri, 22 Aug 2014 21:19:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751000AbaHVTTG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 22 Aug 2014 15:19:06 -0400
Received: from mout.web.de ([212.227.17.12]:55595 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750982AbaHVTTF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Aug 2014 15:19:05 -0400
Received: from macce.local ([78.72.74.102]) by smtp.web.de (mrweb103) with
 ESMTPSA (Nemesis) id 0M4ZXs-1WQjJR3Nhk-00yjXv; Fri, 22 Aug 2014 21:19:02
 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:31.0) Gecko/20100101 Thunderbird/31.0
X-Provags-ID: V03:K0:wZqI1kNz6H8vwqiWBD6k8nGqwRejkDgxk5G+lRd6AaGdf+hNlNP
 JODApkSreZBWWYe6cN+yUfJkXwOF+fynoZzcs1JFW1NSTexy/tcBD5GjDY+HBsPOkhgYM/3
 pLBrQhXPWwnFhd/xUGV/AAsKQ4V4aVIF8Ob38sur9zSxhr08GNvtXbvkb1Y+76cl97W1Oyp
 pygK973TROLp+OClXGfGg==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255695>

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

This mini series mainly updates git.git with patches from msysgit:
Patch 1 is taken "as is",
Patch 2 is taken "as is",
and Patch 3 is the outcome of the code-review=20

Thanks for careful reading


 Makefile              |  3 +++
 t/t0026-eol-config.sh | 18 ++++++++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/Makefile b/Makefile
index 2320de5..517036e 100644
--- a/Makefile
+++ b/Makefile
@@ -1479,6 +1479,9 @@ ifdef NO_REGEX
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
