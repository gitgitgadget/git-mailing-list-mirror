From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 9/9] diff --color: color blank-at-eof
Date: Fri,  4 Sep 2009 03:55:18 -0700
Message-ID: <1252061718-11579-10-git-send-email-gitster@pobox.com>
References: <1252061718-11579-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 04 12:56:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MjWTI-00041M-Bv
	for gcvg-git-2@lo.gmane.org; Fri, 04 Sep 2009 12:56:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756743AbZIDKzo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Sep 2009 06:55:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755223AbZIDKzn
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Sep 2009 06:55:43 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:61185 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755893AbZIDKzj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Sep 2009 06:55:39 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 3E17C25EF9
	for <git@vger.kernel.org>; Fri,  4 Sep 2009 06:55:42 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=EQ+M
	VEEzfqxUXgSelPemCQSGhAo=; b=b6ZNGcrE9BLylVAaaJr1AmZdE8OYKlZDrPOo
	ixmvGI90pXMNx4HzI2E7pBXxTNIs+uQP+qsRmevJxa3sudRQxNuxBp1O9ny4CuCl
	/wezGPZ8kftE+2ecU87jCzx9IbmdUM3C/W9q1kjiPpyMbg8xWeM9c8cfFWPFu4RS
	A0DtHio=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=CqNpYi
	STc/WDpjdO56XkvgM66sZ1dY5YbrdxJaML2+4fBYxhkAQO/x29ml7rz3/4Z5b5NJ
	eJDYAQkxk4cfV5N6h+DEEjXjfmMnY/IuqIwi5bN1odmgOQblRP3/p9ZU7LL8bdfN
	N+VWbCKoxTuMiaFU2PmU7uG58+cKjG80T9WyE=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 3982B25EF8
	for <git@vger.kernel.org>; Fri,  4 Sep 2009 06:55:42 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 84DF025EF7 for
 <git@vger.kernel.org>; Fri,  4 Sep 2009 06:55:41 -0400 (EDT)
X-Mailer: git-send-email 1.6.4.2.313.g0425f
In-Reply-To: <1252061718-11579-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 7D50FED2-9941-11DE-9A4C-CA0F1FFB4A78-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127718>

Since the coloring logic processed the patch output one line at a time, we
couldn't easily color code the new blank lines at the end of file.

Reuse the adds_blank_at_eof() function to find where the runs of such
blank lines start, keep track of the line number in the preimage while
processing the patch output one line at a time, and paint the new blank
lines that appear after that line to implement this.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 diff.c                  |   37 +++++++++++++++++++++++++++----------
 t/t4019-diff-wserror.sh |    9 +++++++++
 2 files changed, 36 insertions(+), 10 deletions(-)

diff --git a/diff.c b/diff.c
index c19c476..2b285b8 100644
--- a/diff.c
+++ b/diff.c
@@ -491,6 +491,8 @@ struct emit_callback {
 	struct xdiff_emit_state xm;
 	int color_diff;
 	unsigned ws_rule;
+	int blank_at_eof;
+	int lno_in_preimage;
 	sane_truncate_fn truncate;
 	const char **label_path;
 	struct diff_words_data *diff_words;
@@ -547,6 +549,12 @@ static void emit_add_line(const char *reset, struct emit_callback *ecbdata, cons
 
 	if (!*ws)
 		emit_line(ecbdata->file, set, reset, line, len);
+	else if ((ecbdata->ws_rule & WS_BLANK_AT_EOF) &&
+		 ecbdata->blank_at_eof &&
+		 (ecbdata->blank_at_eof <= ecbdata->lno_in_preimage) &&
+		 ws_blank_line(line + 1, len - 1, ecbdata->ws_rule))
+		/* Blank line at EOF */
+		emit_line(ecbdata->file, ws, reset, line, len);
 	else {
 		/* Emit just the prefix, then the rest. */
 		emit_line(ecbdata->file, set, reset, line, 1);
@@ -573,9 +581,16 @@ static unsigned long sane_truncate_line(struct emit_callback *ecb, char *line, u
 	return allot - l;
 }
 
+static int find_preimage_lno(const char *line)
+{
+	char *p = strchr(line, '-');
+	if (!p)
+		return 0; /* should not happen */
+	return strtol(p+1, NULL, 10);
+}
+
 static void fn_out_consume(void *priv, char *line, unsigned long len)
 {
-	int color;
 	struct emit_callback *ecbdata = priv;
 	const char *meta = diff_get_color(ecbdata->color_diff, DIFF_METAINFO);
 	const char *plain = diff_get_color(ecbdata->color_diff, DIFF_PLAIN);
@@ -598,6 +613,7 @@ static void fn_out_consume(void *priv, char *line, unsigned long len)
 
 	if (line[0] == '@') {
 		len = sane_truncate_line(ecbdata, line, len);
+		ecbdata->lno_in_preimage = find_preimage_lno(line);
 		emit_line(ecbdata->file,
 			  diff_get_color(ecbdata->color_diff, DIFF_FRAGINFO),
 			  reset, line, len);
@@ -611,7 +627,6 @@ static void fn_out_consume(void *priv, char *line, unsigned long len)
 		return;
 	}
 
-	color = DIFF_PLAIN;
 	if (ecbdata->diff_words) {
 		if (line[0] == '-') {
 			diff_words_append(line, len,
@@ -630,14 +645,13 @@ static void fn_out_consume(void *priv, char *line, unsigned long len)
 		emit_line(ecbdata->file, plain, reset, line, len);
 		return;
 	}
-	if (line[0] == '-')
-		color = DIFF_FILE_OLD;
-	else if (line[0] == '+')
-		color = DIFF_FILE_NEW;
-	if (color != DIFF_FILE_NEW) {
-		emit_line(ecbdata->file,
-			  diff_get_color(ecbdata->color_diff, color),
-			  reset, line, len);
+
+	if (line[0] != '+') {
+		const char *color =
+			diff_get_color(ecbdata->color_diff,
+				       line[0] == '-' ? DIFF_FILE_OLD : DIFF_PLAIN);
+		ecbdata->lno_in_preimage++;
+		emit_line(ecbdata->file, color, reset, line, len);
 		return;
 	}
 	emit_add_line(reset, ecbdata, line, len);
@@ -1557,6 +1571,9 @@ static void builtin_diff(const char *name_a,
 		ecbdata.color_diff = DIFF_OPT_TST(o, COLOR_DIFF);
 		ecbdata.found_changesp = &o->found_changes;
 		ecbdata.ws_rule = whitespace_rule(name_b ? name_b : name_a);
+		if (ecbdata.ws_rule & WS_BLANK_AT_EOF)
+			ecbdata.blank_at_eof =
+				adds_blank_at_eof(&mf1, &mf2, ecbdata.ws_rule);
 		ecbdata.file = o->file;
 		xpp.flags = XDF_NEED_MINIMAL | o->xdl_opts;
 		xecfg.ctxlen = o->context;
diff --git a/t/t4019-diff-wserror.sh b/t/t4019-diff-wserror.sh
index 1517fff..1e75f1a 100755
--- a/t/t4019-diff-wserror.sh
+++ b/t/t4019-diff-wserror.sh
@@ -190,4 +190,13 @@ test_expect_success 'do not color trailing cr in context' '
 
 '
 
+test_expect_success 'color new trailing blank lines' '
+	{ echo a; echo b; echo; echo; } >x &&
+	git add x &&
+	{ echo a; echo; echo; echo; echo; } >x &&
+	git diff --color x >output &&
+	cnt=$(grep "${blue_grep}" output | wc -l) &&
+	test $cnt = 2
+'
+
 test_done
-- 
1.6.4.2.313.g0425f
