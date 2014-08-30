From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: [PATCH v3 1/2] Push the NATIVE_CRLF Makefile variable to C and added
 a test for native.
Date: Sat, 30 Aug 2014 23:38:59 +0200
Message-ID: <54024473.4040709@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: tboegi@web.de
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 30 23:39:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XNqMX-0002zy-Cd
	for gcvg-git-2@plane.gmane.org; Sat, 30 Aug 2014 23:39:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752088AbaH3VjD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 30 Aug 2014 17:39:03 -0400
Received: from mout.web.de ([212.227.15.4]:49413 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752016AbaH3VjC (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Aug 2014 17:39:02 -0400
Received: from macce.local ([78.72.74.102]) by smtp.web.de (mrweb001) with
 ESMTPSA (Nemesis) id 0MEEMy-1XdIol43Q0-00FS21; Sat, 30 Aug 2014 23:39:00
 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:31.0) Gecko/20100101 Thunderbird/31.0
X-Provags-ID: V03:K0:tsXc8STgmXSQ1kd2AQ9zFGx33Hhkm0zcxrws7zMF2I6GZhgyH4V
 vONYb2jbkrea7BRbWL4U4JCNmf5ReCh2NPSJnOyW70tMbDhUmWBVtyxPpLPIOUYmOZoy561
 2XFuWU0d4Z5osKxQjF6s28/4O7yanS0fKb3WXarSkna4qkAcmox9QlYZD3gNqGLJ5FX986b
 ZuRkTj/cAzz4tYRbgWaKA==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256269>

=46rom: Pat Thoyts <patthoyts@users.sourceforge.net>

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
Patch 2 is taken from msysgit "nearly as is": the broken && chain
had been fixed.

Changes since V2:
- Patch 1 shoud have the right Author line
 (I used git-send-email for V2, where the Author was lost:
  web.de does not allow to send mails with "From: Pat Thoyts" in the
  mail header, so it will change it to "From: tboegi".
  And git-send-email does not add another
  "From: " line into the subject of the email, so I did it by hand)

Patch 2+3 had been squeezed together
(This may make the integration in msysgit a liitle bit harder)

 Makefile              |  3 +++
 t/t0026-eol-config.sh | 18 ++++++++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/Makefile b/Makefile
index 9f984a9..7d7db02 100644
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
