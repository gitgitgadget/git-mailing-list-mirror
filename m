From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH v3 1/3] Introduce die_errno() that appends strerror(errno) to die()
Date: Mon,  8 Jun 2009 23:02:18 +0200
Message-ID: <5f43aa9d0b69e99600a73bddd4c93217608ab661.1244494647.git.trast@student.ethz.ch>
References: <cover.1244494646.git.trast@student.ethz.ch>
Cc: git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>,
	Jeff King <peff@peff.net>,
	Alexander Potashev <aspotashev@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 08 23:02:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MDlzN-0002u3-TS
	for gcvg-git-2@gmane.org; Mon, 08 Jun 2009 23:02:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755998AbZFHVCa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Jun 2009 17:02:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755910AbZFHVC3
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Jun 2009 17:02:29 -0400
Received: from xsmtp0.ethz.ch ([82.130.70.14]:19756 "EHLO XSMTP0.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755692AbZFHVC1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Jun 2009 17:02:27 -0400
Received: from xfe2.d.ethz.ch ([82.130.124.42]) by XSMTP0.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 8 Jun 2009 23:02:13 +0200
Received: from localhost.localdomain ([77.58.128.129]) by xfe2.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 8 Jun 2009 23:02:12 +0200
X-Mailer: git-send-email 1.6.3.2.333.g27636
In-Reply-To: <cover.1244494646.git.trast@student.ethz.ch>
In-Reply-To: <cover.1244494646.git.trast@student.ethz.ch>
References: <cover.1244299302.git.trast@student.ethz.ch> <cover.1244494646.git.trast@student.ethz.ch>
X-OriginalArrivalTime: 08 Jun 2009 21:02:13.0145 (UTC) FILETIME=[65649890:01C9E87C]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121106>

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
---
 git-compat-util.h |    1 +
 usage.c           |   12 ++++++++++++
 2 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/git-compat-util.h b/git-compat-util.h
index f25f7f1..0366cde 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -162,6 +162,7 @@
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
1.6.3.2.333.g27636
