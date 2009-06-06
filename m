From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH v2 1/3] Introduce die_errno() that appends strerror(errno) to die()
Date: Sat,  6 Jun 2009 16:44:51 +0200
Message-ID: <3672f22723a4c14c4a6d67278e9865424c0c68dc.1244299302.git.trast@student.ethz.ch>
References: <cover.1244299302.git.trast@student.ethz.ch>
Cc: git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>,
	Jeff King <peff@peff.net>,
	Alexander Potashev <aspotashev@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jun 06 16:45:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MCx8u-0000n1-9L
	for gcvg-git-2@gmane.org; Sat, 06 Jun 2009 16:45:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753944AbZFFOpA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Jun 2009 10:45:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753275AbZFFOo7
	(ORCPT <rfc822;git-outgoing>); Sat, 6 Jun 2009 10:44:59 -0400
Received: from xsmtp1.ethz.ch ([82.130.70.13]:24862 "EHLO xsmtp1.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753455AbZFFOo6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Jun 2009 10:44:58 -0400
Received: from xfe2.d.ethz.ch ([82.130.124.42]) by xsmtp1.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Sat, 6 Jun 2009 16:44:43 +0200
Received: from localhost.localdomain ([77.56.223.244]) by xfe2.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Sat, 6 Jun 2009 16:44:43 +0200
X-Mailer: git-send-email 1.6.3.2.288.g40844
In-Reply-To: <cover.1244299302.git.trast@student.ethz.ch>
In-Reply-To: <cover.1244299302.git.trast@student.ethz.ch>
References: <200906061509.15870.trast@student.ethz.ch> <cover.1244299302.git.trast@student.ethz.ch>
X-OriginalArrivalTime: 06 Jun 2009 14:44:43.0922 (UTC) FILETIME=[5493EF20:01C9E6B5]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120920>

There are many calls to die() that do, or should, report
strerror(errno) to indicate how the syscall they guard failed.
Introduce a small helper function for this case.

Code by Jeff King and Alexander Potashev, name by Johannes Sixt.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---
 git-compat-util.h |    1 +
 usage.c           |   13 +++++++++++++
 2 files changed, 14 insertions(+), 0 deletions(-)

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
index 820d09f..1819e0a 100644
--- a/usage.c
+++ b/usage.c
@@ -60,6 +60,19 @@ void die(const char *err, ...)
 	va_end(params);
 }
 
+void die_errno(const char *err, ...)
+{
+	va_list params;
+	char msg[1024];
+
+	va_start(params, err);
+
+	vsnprintf(msg, sizeof(msg), err, params);
+	die("%s: %s", msg, strerror(errno));
+
+	va_end(params);
+}
+
 int error(const char *err, ...)
 {
 	va_list params;
-- 
1.6.3.2.288.g40844
