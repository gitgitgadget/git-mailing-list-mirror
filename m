From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH v4 1/4] Introduce die_errno() that appends strerror(errno) to die()
Date: Sat, 27 Jun 2009 17:58:44 +0200
Message-ID: <352b76f4c7b442cae5c16451396ad129d25ef29a.1246115205.git.trast@student.ethz.ch>
References: <cover.1244494646.git.trast@student.ethz.ch> <cover.1246115204.git.trast@student.ethz.ch>
Cc: git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>,
	Jeff King <peff@peff.net>,
	Alexander Potashev <aspotashev@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jun 27 17:59:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MKaIt-0004IM-PR
	for gcvg-git-2@gmane.org; Sat, 27 Jun 2009 17:59:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753973AbZF0P6u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Jun 2009 11:58:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753956AbZF0P6u
	(ORCPT <rfc822;git-outgoing>); Sat, 27 Jun 2009 11:58:50 -0400
Received: from xsmtp0.ethz.ch ([82.130.70.14]:16289 "EHLO XSMTP0.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753579AbZF0P6s (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Jun 2009 11:58:48 -0400
Received: from xfe2.d.ethz.ch ([82.130.124.42]) by XSMTP0.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Sat, 27 Jun 2009 17:58:49 +0200
Received: from localhost.localdomain ([77.56.223.244]) by xfe2.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Sat, 27 Jun 2009 17:58:49 +0200
X-Mailer: git-send-email 1.6.3.3.433.gc91b
In-Reply-To: <cover.1246115204.git.trast@student.ethz.ch>
X-OriginalArrivalTime: 27 Jun 2009 15:58:49.0133 (UTC) FILETIME=[28CE0DD0:01C9F740]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122371>

There are many calls to die() that do, or should, report
strerror(errno) to indicate how the syscall they guard failed.
Introduce a small helper function for this case.

Note:

- POSIX says vsnprintf can modify errno in some unlikely cases, so we
  have to use errno early.

- We take some care to pass the original format to die_routine(), in
  case someone wants to call die_errno() with custom format
  characters.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 git-compat-util.h |    1 +
 usage.c           |   12 ++++++++++++
 2 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/git-compat-util.h b/git-compat-util.h
index 919b7f1..9609eaa 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -175,6 +175,7 @@
 /* General helper functions */
 extern void usage(const char *err) NORETURN;
 extern void die(const char *err, ...) NORETURN __attribute__((format (printf, 1, 2)));
+extern void die_errno(const char *err, ...) NORETURN __attribute__((format (printf, 1, 2)));
 extern int error(const char *err, ...) __attribute__((format (printf, 1, 2)));
 extern void warning(const char *err, ...) __attribute__((format (printf, 1, 2)));
 
diff --git a/usage.c b/usage.c
index 820d09f..fd936a1 100644
--- a/usage.c
+++ b/usage.c
@@ -60,6 +60,18 @@ void die(const char *err, ...)
 	va_end(params);
 }
 
+void die_errno(const char *fmt, ...)
+{
+	va_list params;
+	char fmt_with_err[1024];
+
+	snprintf(fmt_with_err, sizeof(fmt_with_err), "%s: %s", fmt, strerror(errno));
+
+	va_start(params, fmt);
+	die_routine(fmt_with_err, params);
+	va_end(params);
+}
+
 int error(const char *err, ...)
 {
 	va_list params;
-- 
1.6.3.3.433.gc91b
