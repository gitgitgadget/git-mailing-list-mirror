From: =?UTF-8?q?Ren=C3=A9=20Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH 1/2] read-cache: add simple performance test
Date: Sun,  9 Jun 2013 19:39:17 +0200
Message-ID: <1370799558-18188-1-git-send-email-rene.scharfe@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Stephen Boyd <sboyd@codeaurora.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 09 19:39:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UljaU-0002hH-Ue
	for gcvg-git-2@plane.gmane.org; Sun, 09 Jun 2013 19:39:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751512Ab3FIRj0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 9 Jun 2013 13:39:26 -0400
Received: from india601.server4you.de ([85.25.151.105]:59095 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750987Ab3FIRjZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jun 2013 13:39:25 -0400
Received: from debian.Speedport_W_504V_Typ_A (p4FFD9DEC.dip0.t-ipconnect.de [79.253.157.236])
	by india601.server4you.de (Postfix) with ESMTPSA id C82A71DA;
	Sun,  9 Jun 2013 19:39:23 +0200 (CEST)
X-Mailer: git-send-email 1.8.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227046>

Add the helper test-read-cache, which can be used to call read_cache an=
d
discard_cache in a loop as well as a performance check based on it.

Signed-off-by: Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx>
---
 .gitignore                 |  1 +
 Makefile                   |  1 +
 t/perf/p0002-read-cache.sh | 14 ++++++++++++++
 test-read-cache.c          | 13 +++++++++++++
 4 files changed, 29 insertions(+)
 create mode 100755 t/perf/p0002-read-cache.sh
 create mode 100644 test-read-cache.c

diff --git a/.gitignore b/.gitignore
index 1640c3a..c0e00eb 100644
--- a/.gitignore
+++ b/.gitignore
@@ -191,6 +191,7 @@
 /test-mktemp
 /test-parse-options
 /test-path-utils
+/test-read-cache
 /test-regex
 /test-revision-walking
 /test-run-command
diff --git a/Makefile b/Makefile
index a748133..2e3b4ee 100644
--- a/Makefile
+++ b/Makefile
@@ -572,6 +572,7 @@ TEST_PROGRAMS_NEED_X +=3D test-mergesort
 TEST_PROGRAMS_NEED_X +=3D test-mktemp
 TEST_PROGRAMS_NEED_X +=3D test-parse-options
 TEST_PROGRAMS_NEED_X +=3D test-path-utils
+TEST_PROGRAMS_NEED_X +=3D test-read-cache
 TEST_PROGRAMS_NEED_X +=3D test-regex
 TEST_PROGRAMS_NEED_X +=3D test-revision-walking
 TEST_PROGRAMS_NEED_X +=3D test-run-command
diff --git a/t/perf/p0002-read-cache.sh b/t/perf/p0002-read-cache.sh
new file mode 100755
index 0000000..9180ae9
--- /dev/null
+++ b/t/perf/p0002-read-cache.sh
@@ -0,0 +1,14 @@
+#!/bin/sh
+
+test_description=3D"Tests performance of reading the index"
+
+. ./perf-lib.sh
+
+test_perf_default_repo
+
+count=3D1000
+test_perf "read_cache/discard_cache $count times" "
+	test-read-cache $count
+"
+
+test_done
diff --git a/test-read-cache.c b/test-read-cache.c
new file mode 100644
index 0000000..b25bcf1
--- /dev/null
+++ b/test-read-cache.c
@@ -0,0 +1,13 @@
+#include "cache.h"
+
+int main (int argc, char **argv)
+{
+	int i, cnt =3D 1;
+	if (argc =3D=3D 2)
+		cnt =3D strtol(argv[1], NULL, 0);
+	for (i =3D 0; i < cnt; i++) {
+		read_cache();
+		discard_cache();
+	}
+	return 0;
+}
--=20
1.8.3
