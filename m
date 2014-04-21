From: Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH v3 2/2] blame: use a helper to get suitable blame_date_width
Date: Mon, 21 Apr 2014 14:02:04 +0800
Message-ID: <17454bdfbd4e0e1516a64f75deabddb427792e99.1398059411.git.worldhello.net@gmail.com>
References: <cover.1398059411.git.worldhello.net@gmail.com>
Cc: Brian Gesiak <modocache@gmail.com>, Git List <git@vger.kernel.org>,
	Jiang Xin <worldhello.net@gmail.com>
To: Junio C Hamano <gitster@pobox.com>, Duy Nguyen <pclouds@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Mon Apr 21 08:02:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wc7JZ-0006dC-EC
	for gcvg-git-2@plane.gmane.org; Mon, 21 Apr 2014 08:02:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751278AbaDUGCp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Apr 2014 02:02:45 -0400
Received: from mail-pa0-f54.google.com ([209.85.220.54]:34665 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750887AbaDUGCo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Apr 2014 02:02:44 -0400
Received: by mail-pa0-f54.google.com with SMTP id lf10so3416894pab.27
        for <git@vger.kernel.org>; Sun, 20 Apr 2014 23:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=XYnUOdGu9syw/B1qgqtiChxK5WtgqRrMU2LwJSzmo7s=;
        b=YutViluVru4DvtEVeTERX7yb5uQiwK8xa8wdBgnFK2XLtmdy5PD/GXVC2XLRPVQpFJ
         AP8Rd2KdLj9ArXcomG+fVyNhuCyB/JjMtFtaV8NX4l7uxwigSfSNFiyAigpSMlo8F1kt
         +HNNKruarRH9hEkraoly0tABSpDKmM7OHDJymTdHc4oWotExXJrhEzrg+PBH9ly6bmrf
         +wdF5XZQs5W9VR7nyP73RpgqEQ5hXB4ZyUKKWlX83nUBlFZcH81I0E88y/oM+jGbkDAS
         NalNe2FzzQqmnmhBEi/Eg5I7iUpvHq+DUZWwwIqbxm/Vtz1T67eTuHUTmkeafPOGJOXF
         h0Yw==
X-Received: by 10.66.161.69 with SMTP id xq5mr35945138pab.62.1398060163939;
        Sun, 20 Apr 2014 23:02:43 -0700 (PDT)
Received: from localhost.localdomain ([124.207.10.6])
        by mx.google.com with ESMTPSA id vx10sm181140376pac.17.2014.04.20.23.02.36
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 20 Apr 2014 23:02:42 -0700 (PDT)
X-Mailer: git-send-email 1.9.2.476.ga74def0
In-Reply-To: <cover.1398059411.git.worldhello.net@gmail.com>
In-Reply-To: <cover.1398059411.git.worldhello.net@gmail.com>
References: <7vbnvvllx4.fsf@alter.siamese.dyndns.org> <cover.1398059411.git.worldhello.net@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246608>

When show date in relative date format for git-blame, the max display
width of datetime is set as the length of the string "Thu Oct 19
16:00:04 2006 -0700" (30 characters long).  But actually the max width
for C locale is only 22 (the length of string "x years, xx months ago").
And for other locale, it maybe smaller.  E.g. For Chinese locale, only
needs a half (16-character width).

Add a helper function date_relative_maxwidth() to date.c, which returns
the suitable display width for the relative date field in different
locale.

Suggested-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Jiang Xin <worldhello.net@gmail.com>
---
 builtin/blame.c | 64 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 63 insertions(+), 1 deletion(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index 35e95db..478f739 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -2229,6 +2229,67 @@ static int blame_move_callback(const struct option *option, const char *arg, int
 	return 0;
 }
 
+static int date_relative_maxwidth(void)
+{
+	struct strbuf buf = STRBUF_INIT, years_sb = STRBUF_INIT;
+	static int maxwidth = 0;
+	int width;
+
+	if (maxwidth)
+		return maxwidth;
+
+	strbuf_addf(&buf, _("in the future"));
+	maxwidth = utf8_strwidth(buf.buf);
+
+	strbuf_reset(&buf);
+	strbuf_addf(&buf, Q_("%lu second ago", "%lu seconds ago", 89L), 89L);
+	width = utf8_strwidth(buf.buf);
+	maxwidth = (maxwidth < width) ? width : maxwidth;
+
+	strbuf_reset(&buf);
+	strbuf_addf(&buf, Q_("%lu minute ago", "%lu minutes ago", 89L), 89L);
+	width = utf8_strwidth(buf.buf);
+	maxwidth = (maxwidth < width) ? width : maxwidth;
+
+	strbuf_reset(&buf);
+	strbuf_addf(&buf, Q_("%lu hour ago", "%lu hours ago", 35L), 35L);
+	width = utf8_strwidth(buf.buf);
+	maxwidth = (maxwidth < width) ? width : maxwidth;
+
+	strbuf_reset(&buf);
+	strbuf_addf(&buf, Q_("%lu day ago", "%lu days ago", 13L), 13L);
+	width = utf8_strwidth(buf.buf);
+	maxwidth = (maxwidth < width) ? width : maxwidth;
+
+	strbuf_reset(&buf);
+	strbuf_addf(&buf, Q_("%lu week ago", "%lu weeks ago", 10L), 10L);
+	width = utf8_strwidth(buf.buf);
+	maxwidth = (maxwidth < width) ? width : maxwidth;
+
+	strbuf_reset(&buf);
+	strbuf_addf(&buf, Q_("%lu month ago", "%lu months ago", 12L), 12L);
+	width = utf8_strwidth(buf.buf);
+	maxwidth = (maxwidth < width) ? width : maxwidth;
+
+	strbuf_addf(&years_sb, Q_("%lu year", "%lu years", 4L), 4L);
+	strbuf_reset(&buf);
+	strbuf_addf(&buf,
+		Q_("%s, %lu month ago", "%s, %lu months ago", 11L),
+		years_sb.buf, 11L);
+	width = utf8_strwidth(buf.buf);
+	maxwidth = (maxwidth < width) ? width : maxwidth;
+
+	strbuf_reset(&buf);
+	strbuf_addf(&buf, Q_("%lu year ago", "%lu years ago", 9999L), 9999L);
+	width = utf8_strwidth(buf.buf);
+	maxwidth = (maxwidth < width) ? width : maxwidth;
+
+	strbuf_release(&years_sb);
+	strbuf_release(&buf);
+
+	return maxwidth;
+}
+
 int cmd_blame(int argc, const char **argv, const char *prefix)
 {
 	struct rev_info revs;
@@ -2338,7 +2399,8 @@ parse_done:
 		blame_date_width = sizeof("2006-10-19");
 		break;
 	case DATE_RELATIVE:
-		/* "normal" is used as the fallback for "relative" */
+		blame_date_width = date_relative_maxwidth() + 1; /* add the null */
+		break;
 	case DATE_LOCAL:
 	case DATE_NORMAL:
 		blame_date_width = sizeof("Thu Oct 19 16:00:04 2006 -0700");
-- 
1.9.2.476.ga74def0
