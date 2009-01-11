From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 1/4] Add color_fwrite(), a function coloring each line
 individually
Date: Sun, 11 Jan 2009 20:59:08 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901112058570.3586@pacific.mpi-cbg.de>
References: <alpine.DEB.1.00.0901112057300.3586@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org, Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Sun Jan 11 20:59:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LM6TR-00048S-9W
	for gcvg-git-2@gmane.org; Sun, 11 Jan 2009 20:59:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753825AbZAKT62 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Jan 2009 14:58:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751880AbZAKT62
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Jan 2009 14:58:28 -0500
Received: from mail.gmx.net ([213.165.64.20]:43645 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753644AbZAKT61 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Jan 2009 14:58:27 -0500
Received: (qmail invoked by alias); 11 Jan 2009 19:58:23 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp008) with SMTP; 11 Jan 2009 20:58:23 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/bTsEOCgrb4sdTQJHdjiCRczLCbo+G6yTeyTY3oM
	kv76N3Hzw5KgFX
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <alpine.DEB.1.00.0901112057300.3586@pacific.mpi-cbg.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.53
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105206>


We have to set the color before every line and reset it before every
newline.  Add a function color_fwrite() which does that for us.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 color.c |   24 ++++++++++++++++++++++++
 color.h |    1 +
 2 files changed, 25 insertions(+), 0 deletions(-)

diff --git a/color.c b/color.c
index fc0b72a..bff24ac 100644
--- a/color.c
+++ b/color.c
@@ -191,3 +191,27 @@ int color_fprintf_ln(FILE *fp, const char *color, const char *fmt, ...)
 	va_end(args);
 	return r;
 }
+
+/*
+ * This function splits the buffer by newlines and colors the lines individually.
+ */
+void color_fwrite(FILE *f, const char *color, size_t count, const char *buf)
+{
+	if (!*color) {
+		fwrite(buf, count, 1, f);
+		return;
+	}
+	while (count) {
+		char *p = memchr(buf, '\n', count);
+		fputs(color, f);
+		fwrite(buf, p ? p - buf : count, 1, f);
+		fputs(COLOR_RESET, f);
+		if (!p)
+			return;
+		fputc('\n', f);
+		count -= p + 1 - buf;
+		buf = p + 1;
+	}
+}
+
+
diff --git a/color.h b/color.h
index 6cf5c88..9fb58f5 100644
--- a/color.h
+++ b/color.h
@@ -19,5 +19,6 @@ int git_config_colorbool(const char *var, const char *value, int stdout_is_tty);
 void color_parse(const char *var, const char *value, char *dst);
 int color_fprintf(FILE *fp, const char *color, const char *fmt, ...);
 int color_fprintf_ln(FILE *fp, const char *color, const char *fmt, ...);
+void color_fwrite(FILE *f, const char *color, size_t count, const char *buf);
 
 #endif /* COLOR_H */
-- 
1.6.1.186.g48f3bc4
