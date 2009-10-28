From: Markus Heidelberg <markus.heidelberg@web.de>
Subject: [PATCH 2/3] diff: move the handling of the hunk header after the changed lines
Date: Wed, 28 Oct 2009 13:24:31 +0100
Message-ID: <1256732672-11817-3-git-send-email-markus.heidelberg@web.de>
References: <1256732672-11817-1-git-send-email-markus.heidelberg@web.de>
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Markus Heidelberg <markus.heidelberg@web.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 28 13:26:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N37bW-0003xT-9L
	for gcvg-git-2@lo.gmane.org; Wed, 28 Oct 2009 13:26:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751874AbZJ1M0J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Oct 2009 08:26:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751040AbZJ1M0I
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Oct 2009 08:26:08 -0400
Received: from fmmailgate01.web.de ([217.72.192.221]:60175 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751000AbZJ1M0G (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Oct 2009 08:26:06 -0400
Received: from smtp06.web.de (fmsmtp06.dlan.cinetic.de [172.20.5.172])
	by fmmailgate01.web.de (Postfix) with ESMTP id F0052133B7A84;
	Wed, 28 Oct 2009 13:25:12 +0100 (CET)
Received: from [89.59.65.242] (helo=localhost.localdomain)
	by smtp06.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #314)
	id 1N37aS-0002WH-00; Wed, 28 Oct 2009 13:25:12 +0100
X-Mailer: git-send-email 1.6.5.2.86.g61663
In-Reply-To: <1256732672-11817-1-git-send-email-markus.heidelberg@web.de>
X-Sender: markus.heidelberg@web.de
X-Provags-ID: V01U2FsdGVkX1+07ivVKIhO6CbkfjO6zkvepwS5G3tdYrY4pOG5
	yIKm9P8o2B/pJrVoIdxPT36CVD/zztfyQt+vcJ94Q2xgbsaHUy
	UBckSmBgjYn932DIO5/w==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131459>

In preparation for a special case handling of colored word diff without
context.

Signed-off-by: Markus Heidelberg <markus.heidelberg@web.de>
---
 diff.c |   41 +++++++++++++++++++++--------------------
 1 files changed, 21 insertions(+), 20 deletions(-)

diff --git a/diff.c b/diff.c
index b0c7e61..067e5a0 100644
--- a/diff.c
+++ b/diff.c
@@ -771,17 +771,6 @@ static void fn_out_consume(void *priv, char *line, unsigned long len)
 		len = 1;
 	}
 
-	if (line[0] == '@') {
-		len = sane_truncate_line(ecbdata, line, len);
-		find_lno(line, ecbdata);
-		emit_line(ecbdata->file,
-			  diff_get_color(ecbdata->color_diff, DIFF_FRAGINFO),
-			  reset, line, len);
-		if (line[len-1] != '\n')
-			putc('\n', ecbdata->file);
-		return;
-	}
-
 	if (len < 1) {
 		emit_line(ecbdata->file, reset, reset, line, len);
 		return;
@@ -796,17 +785,18 @@ static void fn_out_consume(void *priv, char *line, unsigned long len)
 			diff_words_append(line, len,
 					  &ecbdata->diff_words->plus);
 			return;
+		} else if (line[0] == ' ') {
+			if (ecbdata->diff_words->minus.text.size ||
+			    ecbdata->diff_words->plus.text.size)
+				diff_words_show(ecbdata->diff_words);
+			line++;
+			len--;
+			emit_line(ecbdata->file, plain, reset, line, len);
+			return;
 		}
-		if (ecbdata->diff_words->minus.text.size ||
-		    ecbdata->diff_words->plus.text.size)
-			diff_words_show(ecbdata->diff_words);
-		line++;
-		len--;
-		emit_line(ecbdata->file, plain, reset, line, len);
-		return;
 	}
 
-	if (line[0] != '+') {
+	if (line[0] == ' ' || line[0] == '-') {
 		const char *color =
 			diff_get_color(ecbdata->color_diff,
 				       line[0] == '-' ? DIFF_FILE_OLD : DIFF_PLAIN);
@@ -814,10 +804,21 @@ static void fn_out_consume(void *priv, char *line, unsigned long len)
 		if (line[0] == ' ')
 			ecbdata->lno_in_postimage++;
 		emit_line(ecbdata->file, color, reset, line, len);
-	} else {
+		return;
+	} else if (line[0] == '+') {
 		ecbdata->lno_in_postimage++;
 		emit_add_line(reset, ecbdata, line + 1, len - 1);
+		return;
 	}
+
+	/* line[0] == '@' */
+	len = sane_truncate_line(ecbdata, line, len);
+	find_lno(line, ecbdata);
+	emit_line(ecbdata->file,
+		  diff_get_color(ecbdata->color_diff, DIFF_FRAGINFO),
+		  reset, line, len);
+	if (line[len-1] != '\n')
+		putc('\n', ecbdata->file);
 }
 
 static char *pprint_rename(const char *a, const char *b)
-- 
1.6.5.2.86.g61663
