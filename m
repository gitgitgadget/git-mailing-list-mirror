From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v2 07/18] fsck: Make =?UTF-8?Q?fsck=5Fident=28=29=20warn-f?=  =?UTF-8?Q?riendly?=
Date: Mon, 19 Jan 2015 16:50:46 +0100
Organization: gmx
Message-ID: <fd39fcf9ea878711423e03a162a9f671dcf3310c.1421682369.git.johannes.schindelin@gmx.de>
References: <xmqqr3w7gxr4.fsf@gitster.dls.corp.google.com>
 <cover.1421682369.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Jan 19 16:59:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YDEjw-0006J3-0h
	for gcvg-git-2@plane.gmane.org; Mon, 19 Jan 2015 16:59:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751786AbbASP7i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Jan 2015 10:59:38 -0500
Received: from s15462909.onlinehome-server.info ([87.106.4.80]:35068 "EHLO
	s15462909.onlinehome-server.info" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751731AbbASP7h (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 19 Jan 2015 10:59:37 -0500
X-Greylist: delayed 563 seconds by postgrey-1.27 at vger.kernel.org; Mon, 19 Jan 2015 10:59:22 EST
Received: from s15462909.onlinehome-server.info (localhost.localdomain [127.0.0.1])
	by s15462909.onlinehome-server.info (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id t0JFokZP026316;
	Mon, 19 Jan 2015 16:50:46 +0100
Received: (from www-data@localhost)
	by s15462909.onlinehome-server.info (8.14.4/8.14.4/Submit) id t0JFokAL026315;
	Mon, 19 Jan 2015 16:50:46 +0100
X-Authentication-Warning: s15462909.onlinehome-server.info: www-data set sender to johannes.schindelin@gmx.de using -f
X-PHP-Originating-Script: 1000:rcube.php
In-Reply-To: <cover.1421682369.git.johannes.schindelin@gmx.de>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1-git
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262627>

When fsck_ident() identifies a problem with the ident, it should still
advance the pointer to the next line so that fsck can continue in the
case of a mere warning.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 fsck.c | 49 +++++++++++++++++++++++++++----------------------
 1 file changed, 27 insertions(+), 22 deletions(-)

diff --git a/fsck.c b/fsck.c
index 78944f0..233385b 100644
--- a/fsck.c
+++ b/fsck.c
@@ -453,40 +453,45 @@ static int require_end_of_header(const void *data, unsigned long size,
 
 static int fsck_ident(const char **ident, struct object *obj, struct fsck_options *options)
 {
+	const char *p = *ident;
 	char *end;
 
-	if (**ident == '<')
+	*ident = strchrnul(*ident, '\n');
+	if (**ident == '\n')
+		(*ident)++;
+
+	if (*p == '<')
 		return report(options, obj, FSCK_MSG_MISSING_NAME_BEFORE_EMAIL, "invalid author/committer line - missing space before email");
-	*ident += strcspn(*ident, "<>\n");
-	if (**ident == '>')
+	p += strcspn(p, "<>\n");
+	if (*p == '>')
 		return report(options, obj, FSCK_MSG_BAD_NAME, "invalid author/committer line - bad name");
-	if (**ident != '<')
+	if (*p != '<')
 		return report(options, obj, FSCK_MSG_MISSING_EMAIL, "invalid author/committer line - missing email");
-	if ((*ident)[-1] != ' ')
+	if (p[-1] != ' ')
 		return report(options, obj, FSCK_MSG_MISSING_SPACE_BEFORE_EMAIL, "invalid author/committer line - missing space before email");
-	(*ident)++;
-	*ident += strcspn(*ident, "<>\n");
-	if (**ident != '>')
+	p++;
+	p += strcspn(p, "<>\n");
+	if (*p != '>')
 		return report(options, obj, FSCK_MSG_BAD_EMAIL, "invalid author/committer line - bad email");
-	(*ident)++;
-	if (**ident != ' ')
+	p++;
+	if (*p != ' ')
 		return report(options, obj, FSCK_MSG_MISSING_SPACE_BEFORE_DATE, "invalid author/committer line - missing space before date");
-	(*ident)++;
-	if (**ident == '0' && (*ident)[1] != ' ')
+	p++;
+	if (*p == '0' && p[1] != ' ')
 		return report(options, obj, FSCK_MSG_ZERO_PADDED_DATE, "invalid author/committer line - zero-padded date");
-	if (date_overflows(strtoul(*ident, &end, 10)))
+	if (date_overflows(strtoul(p, &end, 10)))
 		return report(options, obj, FSCK_MSG_DATE_OVERFLOW, "invalid author/committer line - date causes integer overflow");
-	if (end == *ident || *end != ' ')
+	if ((end == p || *end != ' '))
 		return report(options, obj, FSCK_MSG_BAD_DATE, "invalid author/committer line - bad date");
-	*ident = end + 1;
-	if ((**ident != '+' && **ident != '-') ||
-	    !isdigit((*ident)[1]) ||
-	    !isdigit((*ident)[2]) ||
-	    !isdigit((*ident)[3]) ||
-	    !isdigit((*ident)[4]) ||
-	    ((*ident)[5] != '\n'))
+	p = end + 1;
+	if ((*p != '+' && *p != '-') ||
+	    !isdigit(p[1]) ||
+	    !isdigit(p[2]) ||
+	    !isdigit(p[3]) ||
+	    !isdigit(p[4]) ||
+	    (p[5] != '\n'))
 		return report(options, obj, FSCK_MSG_BAD_TIMEZONE, "invalid author/committer line - bad time zone");
-	(*ident) += 6;
+	p += 6;
 	return 0;
 }
 
-- 
2.0.0.rc3.9669.g840d1f9
