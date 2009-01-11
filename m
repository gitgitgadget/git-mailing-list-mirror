From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v2 1/4] Add color_fwrite(), a function coloring each line
 individually
Date: Mon, 12 Jan 2009 00:49:32 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901120049190.3586@pacific.mpi-cbg.de>
References: <alpine.DEB.1.00.0901112057300.3586@pacific.mpi-cbg.de> <alpine.DEB.1.00.0901112058570.3586@pacific.mpi-cbg.de> <7vwsd1o44i.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0901120048430.3586@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Thomas Rast <trast@student.ethz.ch>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 12 00:51:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMA4T-0005on-0j
	for gcvg-git-2@gmane.org; Mon, 12 Jan 2009 00:50:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751975AbZAKXss (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Jan 2009 18:48:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751958AbZAKXss
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Jan 2009 18:48:48 -0500
Received: from mail.gmx.net ([213.165.64.20]:46242 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751795AbZAKXsr (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Jan 2009 18:48:47 -0500
Received: (qmail invoked by alias); 11 Jan 2009 23:48:45 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp041) with SMTP; 12 Jan 2009 00:48:45 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+tg74eoL6tZ6uXSgoksaFXrlsWuO0k1/vuUPE0q4
	a4nkfM7um4IFEg
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <alpine.DEB.1.00.0901120048430.3586@pacific.mpi-cbg.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.53
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105256>


We have to set the color before every line and reset it before every
newline.  Add a function color_fwrite() which does that for us.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 color.c |   28 ++++++++++++++++++++++++++++
 color.h |    1 +
 2 files changed, 29 insertions(+), 0 deletions(-)

diff --git a/color.c b/color.c
index fc0b72a..b028880 100644
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
+		if (fputs(color, fp) < 0 ||
+				fwrite(buf, p ? p - buf : count, 1, fp) != 1 ||
+				fputs(COLOR_RESET, fp) < 0)
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
@@ -19,5 +19,6 @@ int git_config_colorbool(const char *var, const char *value, int stdout_is_tty);
 void color_parse(const char *var, const char *value, char *dst);
 int color_fprintf(FILE *fp, const char *color, const char *fmt, ...);
 int color_fprintf_ln(FILE *fp, const char *color, const char *fmt, ...);
+int color_fwrite_lines(FILE *fp, const char *color, size_t count, const char *buf);
 
 #endif /* COLOR_H */
-- 
1.6.1.223.g50c8f
