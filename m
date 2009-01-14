From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 1/4] Add color_fwrite_lines(), a function coloring each line
 individually
Date: Wed, 14 Jan 2009 18:50:16 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901141850050.3586@pacific.mpi-cbg.de>
References: <alpine.DEB.1.00.0901112057300.3586@pacific.mpi-cbg.de> <alpine.DEB.1.00.0901112059340.3586@pacific.mpi-cbg.de> <200901120947.13566.trast@student.ethz.ch> <7vprisj26i.fsf@gitster.siamese.dyndns.org> <adf1fd3d0901140500j10556a1as6370d40d766f1899@mail.gmail.com>
 <alpine.DEB.1.00.0901141840100.3586@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org,
	=?ISO-8859-15?Q?Santi_B=E9jar?= <santi@agolina.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 14 18:52:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LN9u6-0002Mw-UR
	for gcvg-git-2@gmane.org; Wed, 14 Jan 2009 18:51:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752927AbZANRtk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Jan 2009 12:49:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760402AbZANRth
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Jan 2009 12:49:37 -0500
Received: from mail.gmx.net ([213.165.64.20]:38967 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1762277AbZANRtg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jan 2009 12:49:36 -0500
Received: (qmail invoked by alias); 14 Jan 2009 17:49:30 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp024) with SMTP; 14 Jan 2009 18:49:30 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+PFcltEaGP2XTvUokuJNAHcsfPEfnDsvqI1rBb6d
	SvlPmCe/SXBXYz
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <alpine.DEB.1.00.0901141840100.3586@pacific.mpi-cbg.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.53
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105670>


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
@@ -19,5 +19,6 @@ int git_config_colorbool(const char *var, const char *value, int stdout_is_tty);
 void color_parse(const char *var, const char *value, char *dst);
 int color_fprintf(FILE *fp, const char *color, const char *fmt, ...);
 int color_fprintf_ln(FILE *fp, const char *color, const char *fmt, ...);
+int color_fwrite_lines(FILE *fp, const char *color, size_t count, const char *buf);
 
 #endif /* COLOR_H */
-- 
1.6.1.243.g4c9c5a
