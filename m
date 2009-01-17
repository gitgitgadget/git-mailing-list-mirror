From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH v4 1/7] Add color_fwrite_lines(), a function coloring each line individually
Date: Sat, 17 Jan 2009 17:29:42 +0100
Message-ID: <1232209788-10408-2-git-send-email-trast@student.ethz.ch>
References: <alpine.DEB.1.00.0901162208180.3586@pacific.mpi-cbg.de>
 <1232209788-10408-1-git-send-email-trast@student.ethz.ch>
Cc: Junio C Hamano <junio@pobox.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	=?utf-8?q?Santi=20B=C3=A9jar?= <santi@agolina.net>,
	"Boyd Stephen Smith Jr." <bss@iguanasuicide.net>,
	Teemu Likonen <tlikonen@iki.fi>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 17 17:32:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LOE5J-00087b-Ck
	for gcvg-git-2@gmane.org; Sat, 17 Jan 2009 17:31:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763126AbZAQQ3s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Jan 2009 11:29:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761757AbZAQQ3p
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Jan 2009 11:29:45 -0500
Received: from xsmtp1.ethz.ch ([82.130.70.13]:41359 "EHLO xsmtp1.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1763074AbZAQQ3m (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Jan 2009 11:29:42 -0500
Received: from xfe0.d.ethz.ch ([82.130.124.40]) by xsmtp1.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Sat, 17 Jan 2009 17:29:39 +0100
Received: from localhost.localdomain ([84.75.148.62]) by xfe0.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Sat, 17 Jan 2009 17:29:39 +0100
X-Mailer: git-send-email 1.6.1.315.g92577
In-Reply-To: <1232209788-10408-1-git-send-email-trast@student.ethz.ch>
X-OriginalArrivalTime: 17 Jan 2009 16:29:39.0206 (UTC) FILETIME=[CB070A60:01C978C0]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106083>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

We have to set the color before every line and reset it before every
newline.  Add a function color_fwrite_lines() which does that for us.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 color.c |   28 ++++++++++++++++++++++++++++
 color.h |    1 +
 2 files changed, 29 insertions(+), 0 deletions(-)

diff --git a/color.c b/color.c
index fc0b72a..d4ae83f 100644
--- a/color.c
+++ b/color.c
@@ -191,3 +191,31 @@ int color_fprintf_ln(FILE *fp, const char *color, const char *fmt, ...)
 	va_end(args);
 	return r;
 }
+
+/*
+ * This function splits the buffer by newlines and colors the lines individually.
+ *
+ * Returns 0 on success.
+ */
+int color_fwrite_lines(FILE *fp, const char *color,
+		size_t count, const char *buf)
+{
+	if (!*color)
+		return fwrite(buf, count, 1, fp) != 1;
+	while (count) {
+		char *p = memchr(buf, '\n', count);
+		if (p != buf && (fputs(color, fp) < 0 ||
+				fwrite(buf, p ? p - buf : count, 1, fp) != 1 ||
+				fputs(COLOR_RESET, fp) < 0))
+			return -1;
+		if (!p)
+			return 0;
+		if (fputc('\n', fp) < 0)
+			return -1;
+		count -= p + 1 - buf;
+		buf = p + 1;
+	}
+	return 0;
+}
+
+
diff --git a/color.h b/color.h
index 6cf5c88..cd5c985 100644
--- a/color.h
+++ b/color.h
@@ -19,5 +19,6 @@
 void color_parse(const char *var, const char *value, char *dst);
 int color_fprintf(FILE *fp, const char *color, const char *fmt, ...);
 int color_fprintf_ln(FILE *fp, const char *color, const char *fmt, ...);
+int color_fwrite_lines(FILE *fp, const char *color, size_t count, const char *buf);
 
 #endif /* COLOR_H */
-- 
1.6.1.315.g92577
