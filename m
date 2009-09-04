From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 6/9] diff.c: the builtin_diff() deals with only two-file
 comparison
Date: Fri,  4 Sep 2009 03:55:15 -0700
Message-ID: <1252061718-11579-7-git-send-email-gitster@pobox.com>
References: <1252061718-11579-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 04 12:56:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MjWTG-00041M-Py
	for gcvg-git-2@lo.gmane.org; Fri, 04 Sep 2009 12:56:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756746AbZIDKzl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Sep 2009 06:55:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756743AbZIDKzk
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Sep 2009 06:55:40 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:38552 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756727AbZIDKzd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Sep 2009 06:55:33 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 5A4E943D2C
	for <git@vger.kernel.org>; Fri,  4 Sep 2009 06:55:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=YLdx
	Ctfcbqxq67gpOHP3EssKBCk=; b=vb69DIJMVPiWaGmioI2MNCjHeVFAhZoD1WAt
	mt1AC12/T7/chbQlGTROLfeA93OGHsGz6t9G6SsSsB4Ve8wrMUOZfZmufHh6SqB8
	/comBhIiU61A/yoGqiHEzPAoQY8Wva1pmhtE6ll3ytkJY5qjBFHvhZrDSUSDgdf/
	Jec20S8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=jXs4ib
	CI/LJ332sz16T/RiuOs1CF9KlODjCuyndjn808EpbwcyY4IxuBUA4bHdOogrZo65
	CJstyn585Y/rfM90HIdvy2XM/1sWv2i74SRt3UjC0XfGuMbYOjmWIUudnd1qpXcv
	7amtWrGieTwX5wp26TZpzt6Vo9nCRLur54B8E=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 56EC643D2B
	for <git@vger.kernel.org>; Fri,  4 Sep 2009 06:55:36 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 98B2D43D2A for
 <git@vger.kernel.org>; Fri,  4 Sep 2009 06:55:35 -0400 (EDT)
X-Mailer: git-send-email 1.6.4.2.313.g0425f
In-Reply-To: <1252061718-11579-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 79CC6242-9941-11DE-B0B5-8B19076EA04E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127719>

The combined diff is implemented in combine_diff() and fn_out_consume()
codepath never has to deal with anything but two-file comparison.

Drop nparents from the emit_callback structure and simplify the code.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 diff.c |   32 +++++++++-----------------------
 1 files changed, 9 insertions(+), 23 deletions(-)

diff --git a/diff.c b/diff.c
index 6fea3c0..1eddd59 100644
--- a/diff.c
+++ b/diff.c
@@ -489,7 +489,7 @@ typedef unsigned long (*sane_truncate_fn)(char *line, unsigned long len);
 
 struct emit_callback {
 	struct xdiff_emit_state xm;
-	int nparents, color_diff;
+	int color_diff;
 	unsigned ws_rule;
 	sane_truncate_fn truncate;
 	const char **label_path;
@@ -549,9 +549,8 @@ static void emit_add_line(const char *reset, struct emit_callback *ecbdata, cons
 		emit_line(ecbdata->file, set, reset, line, len);
 	else {
 		/* Emit just the prefix, then the rest. */
-		emit_line(ecbdata->file, set, reset, line, ecbdata->nparents);
-		ws_check_emit(line + ecbdata->nparents,
-			      len - ecbdata->nparents, ecbdata->ws_rule,
+		emit_line(ecbdata->file, set, reset, line, 1);
+		ws_check_emit(line + 1, len - 1, ecbdata->ws_rule,
 			      ecbdata->file, set, reset, ws);
 	}
 }
@@ -576,7 +575,6 @@ static unsigned long sane_truncate_line(struct emit_callback *ecb, char *line, u
 
 static void fn_out_consume(void *priv, char *line, unsigned long len)
 {
-	int i;
 	int color;
 	struct emit_callback *ecbdata = priv;
 	const char *meta = diff_get_color(ecbdata->color_diff, DIFF_METAINFO);
@@ -598,13 +596,7 @@ static void fn_out_consume(void *priv, char *line, unsigned long len)
 		ecbdata->label_path[0] = ecbdata->label_path[1] = NULL;
 	}
 
-	/* This is not really necessary for now because
-	 * this codepath only deals with two-way diffs.
-	 */
-	for (i = 0; i < len && line[i] == '@'; i++)
-		;
-	if (2 <= i && i < len && line[i] == ' ') {
-		ecbdata->nparents = i - 1;
+	if (line[0] == '@') {
 		len = sane_truncate_line(ecbdata, line, len);
 		emit_line(ecbdata->file,
 			  diff_get_color(ecbdata->color_diff, DIFF_FRAGINFO),
@@ -614,15 +606,12 @@ static void fn_out_consume(void *priv, char *line, unsigned long len)
 		return;
 	}
 
-	if (len < ecbdata->nparents) {
+	if (len < 1) {
 		emit_line(ecbdata->file, reset, reset, line, len);
 		return;
 	}
 
 	color = DIFF_PLAIN;
-	if (ecbdata->diff_words && ecbdata->nparents != 1)
-		/* fall back to normal diff */
-		free_diff_words_data(ecbdata);
 	if (ecbdata->diff_words) {
 		if (line[0] == '-') {
 			diff_words_append(line, len,
@@ -641,13 +630,10 @@ static void fn_out_consume(void *priv, char *line, unsigned long len)
 		emit_line(ecbdata->file, plain, reset, line, len);
 		return;
 	}
-	for (i = 0; i < ecbdata->nparents && len; i++) {
-		if (line[i] == '-')
-			color = DIFF_FILE_OLD;
-		else if (line[i] == '+')
-			color = DIFF_FILE_NEW;
-	}
-
+	if (line[0] == '-')
+		color = DIFF_FILE_OLD;
+	else if (line[0] == '+')
+		color = DIFF_FILE_NEW;
 	if (color != DIFF_FILE_NEW) {
 		emit_line(ecbdata->file,
 			  diff_get_color(ecbdata->color_diff, color),
-- 
1.6.4.2.313.g0425f
