From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] diff --whitespace: fix blank lines at end
Date: Mon, 14 Sep 2009 22:05:57 -0700
Message-ID: <7vocpc94qy.fsf_-_@alter.siamese.dyndns.org>
References: <wavexx-2ECE7F.13171313092009@ger.gmane.org>
 <7viqfmsoej.fsf@alter.siamese.dyndns.org>
 <20090915123456.6117@nanako3.lavabit.com>
 <7vvdjk95qi.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Yuri D'Elia" <wavexx@users.sf.net>, git@vger.kernel.org
To: Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Tue Sep 15 07:07:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MnQGf-0007T7-8S
	for gcvg-git-2@lo.gmane.org; Tue, 15 Sep 2009 07:07:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751855AbZIOFGI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Sep 2009 01:06:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751801AbZIOFGH
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Sep 2009 01:06:07 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:36424 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751641AbZIOFGF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Sep 2009 01:06:05 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id BCBB151D14;
	Tue, 15 Sep 2009 01:06:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ETC7+I/DvRVjVGRWuKimSeQOvEs=; b=IDFgOa
	3uEM1coKcmsxSKy7i6BR4Mm3/dJwZz+HaNcSjXgAYPVmyjDQ6vElCbL40+MXzNO0
	OGMglSN2jMkCuLkagt2Q9432oVWac9t2TNx+IpxZecaXNJGkJMRhdsAt2sGKYw0j
	iIuDrcPYfayyvwjsEtxbEjijnzefGedQ1EgUw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=VyHyvWBUsgkNd0PuisU0D9rih/EKJi/a
	H5fygnVlRzCLfUsDnHvxrVZqhti04/grl1j+7tpmd5x64rPpK7+4M8YDstmwU060
	sm+MKSDnfwZMeBiKEsiI9XOAWJPSmw0VsFljiRC+ErMDMTx0np69lrnXokavi3+k
	YjQupL6Qu1k=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 902FA51D13;
	Tue, 15 Sep 2009 01:06:04 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id AD6E151D10; Tue, 15 Sep 2009
 01:05:59 -0400 (EDT)
In-Reply-To: <7vvdjk95qi.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Mon\, 14 Sep 2009 21\:44\:37 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 7832D700-A1B5-11DE-9978-8B19076EA04E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128509>

The earlier logic tried to colour any and all blank lines that were added
beyond the last blank line in the original, but this was very wrong.  If
you added 96 blank lines, a non-blank line, and then 3 blank lines at the
end, only the last 3 lines should trigger the error, not the earlier 96
blank lines.

We need to also make sure that the lines are after the last non-blank line
in the postimage as well before deciding to paint them.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * This is _not_ about colouring whitespace errors in -B output;
   that is a bit more involved change that needs a few more changes.

 diff.c                  |   74 +++++++++++++++++++++++++++++++++-------------
 t/t4019-diff-wserror.sh |    2 +-
 2 files changed, 54 insertions(+), 22 deletions(-)

diff --git a/diff.c b/diff.c
index 2b285b8..63a3bfc 100644
--- a/diff.c
+++ b/diff.c
@@ -491,8 +491,10 @@ struct emit_callback {
 	struct xdiff_emit_state xm;
 	int color_diff;
 	unsigned ws_rule;
-	int blank_at_eof;
+	int blank_at_eof_in_preimage;
+	int blank_at_eof_in_postimage;
 	int lno_in_preimage;
+	int lno_in_postimage;
 	sane_truncate_fn truncate;
 	const char **label_path;
 	struct diff_words_data *diff_words;
@@ -542,6 +544,17 @@ static void emit_line(FILE *file, const char *set, const char *reset, const char
 		fputc('\n', file);
 }
 
+static int new_blank_line_at_eof(struct emit_callback *ecbdata, const char *line, int len)
+{
+	if (!((ecbdata->ws_rule & WS_BLANK_AT_EOF) &&
+	      ecbdata->blank_at_eof_in_preimage &&
+	      ecbdata->blank_at_eof_in_postimage &&
+	      ecbdata->blank_at_eof_in_preimage <= ecbdata->lno_in_preimage &&
+	      ecbdata->blank_at_eof_in_postimage <= ecbdata->lno_in_postimage))
+		return 0;
+	return ws_blank_line(line + 1, len - 1, ecbdata->ws_rule);
+}
+
 static void emit_add_line(const char *reset, struct emit_callback *ecbdata, const char *line, int len)
 {
 	const char *ws = diff_get_color(ecbdata->color_diff, DIFF_WHITESPACE);
@@ -549,11 +562,8 @@ static void emit_add_line(const char *reset, struct emit_callback *ecbdata, cons
 
 	if (!*ws)
 		emit_line(ecbdata->file, set, reset, line, len);
-	else if ((ecbdata->ws_rule & WS_BLANK_AT_EOF) &&
-		 ecbdata->blank_at_eof &&
-		 (ecbdata->blank_at_eof <= ecbdata->lno_in_preimage) &&
-		 ws_blank_line(line + 1, len - 1, ecbdata->ws_rule))
-		/* Blank line at EOF */
+	else if (new_blank_line_at_eof(ecbdata, line, len))
+		/* Blank line at EOF - paint '+' as well */
 		emit_line(ecbdata->file, ws, reset, line, len);
 	else {
 		/* Emit just the prefix, then the rest. */
@@ -581,12 +591,19 @@ static unsigned long sane_truncate_line(struct emit_callback *ecb, char *line, u
 	return allot - l;
 }
 
-static int find_preimage_lno(const char *line)
+static void find_lno(const char *line, struct emit_callback *ecbdata)
 {
-	char *p = strchr(line, '-');
+	const char *p;
+	ecbdata->lno_in_preimage = 0;
+	ecbdata->lno_in_postimage = 0;
+	p = strchr(line, '-');
 	if (!p)
-		return 0; /* should not happen */
-	return strtol(p+1, NULL, 10);
+		return; /* cannot happen */
+	ecbdata->lno_in_preimage = strtol(p + 1, NULL, 10);
+	p = strchr(p, '+');
+	if (!p)
+		return; /* cannot happen */
+	ecbdata->lno_in_postimage = strtol(p + 1, NULL, 10);
 }
 
 static void fn_out_consume(void *priv, char *line, unsigned long len)
@@ -613,7 +630,7 @@ static void fn_out_consume(void *priv, char *line, unsigned long len)
 
 	if (line[0] == '@') {
 		len = sane_truncate_line(ecbdata, line, len);
-		ecbdata->lno_in_preimage = find_preimage_lno(line);
+		find_lno(line, ecbdata);
 		emit_line(ecbdata->file,
 			  diff_get_color(ecbdata->color_diff, DIFF_FRAGINFO),
 			  reset, line, len);
@@ -651,10 +668,13 @@ static void fn_out_consume(void *priv, char *line, unsigned long len)
 			diff_get_color(ecbdata->color_diff,
 				       line[0] == '-' ? DIFF_FILE_OLD : DIFF_PLAIN);
 		ecbdata->lno_in_preimage++;
+		if (line[0] == ' ')
+			ecbdata->lno_in_postimage++;
 		emit_line(ecbdata->file, color, reset, line, len);
-		return;
+	} else {
+		ecbdata->lno_in_postimage++;
+		emit_add_line(reset, ecbdata, line, len);
 	}
-	emit_add_line(reset, ecbdata, line, len);
 }
 
 static char *pprint_rename(const char *a, const char *b)
@@ -1470,16 +1490,23 @@ static int count_trailing_blank(mmfile_t *mf, unsigned ws_rule)
 	return cnt;
 }
 
-static int adds_blank_at_eof(mmfile_t *mf1, mmfile_t *mf2, unsigned ws_rule)
+static void check_blank_at_eof(mmfile_t *mf1, mmfile_t *mf2,
+			       struct emit_callback *ecbdata)
 {
 	int l1, l2, at;
+	unsigned ws_rule = ecbdata->ws_rule;
 	l1 = count_trailing_blank(mf1, ws_rule);
 	l2 = count_trailing_blank(mf2, ws_rule);
-	if (l2 <= l1)
-		return 0;
-	/* starting where? */
+	if (l2 <= l1) {
+		ecbdata->blank_at_eof_in_preimage = 0;
+		ecbdata->blank_at_eof_in_postimage = 0;
+		return;
+	}
 	at = count_lines(mf1->ptr, mf1->size);
-	return (at - l1) + 1; /* the line number counts from 1 */
+	ecbdata->blank_at_eof_in_preimage = (at - l1) + 1;
+
+	at = count_lines(mf2->ptr, mf2->size);
+	ecbdata->blank_at_eof_in_postimage = (at - l2) + 1;
 }
 
 static void builtin_diff(const char *name_a,
@@ -1572,8 +1599,7 @@ static void builtin_diff(const char *name_a,
 		ecbdata.found_changesp = &o->found_changes;
 		ecbdata.ws_rule = whitespace_rule(name_b ? name_b : name_a);
 		if (ecbdata.ws_rule & WS_BLANK_AT_EOF)
-			ecbdata.blank_at_eof =
-				adds_blank_at_eof(&mf1, &mf2, ecbdata.ws_rule);
+			check_blank_at_eof(&mf1, &mf2, &ecbdata);
 		ecbdata.file = o->file;
 		xpp.flags = XDF_NEED_MINIMAL | o->xdl_opts;
 		xecfg.ctxlen = o->context;
@@ -1699,7 +1725,13 @@ static void builtin_checkdiff(const char *name_a, const char *name_b,
 		xdi_diff(&mf1, &mf2, &xpp, &xecfg, &ecb);
 
 		if (data.ws_rule & WS_BLANK_AT_EOF) {
-			int blank_at_eof = adds_blank_at_eof(&mf1, &mf2, data.ws_rule);
+			struct emit_callback ecbdata;
+			int blank_at_eof;
+
+			ecbdata.ws_rule = data.ws_rule;
+			check_blank_at_eof(&mf1, &mf2, &ecbdata);
+			blank_at_eof = ecbdata.blank_at_eof_in_preimage;
+
 			if (blank_at_eof) {
 				static char *err;
 				if (!err)
diff --git a/t/t4019-diff-wserror.sh b/t/t4019-diff-wserror.sh
index 1e75f1a..3a3663f 100755
--- a/t/t4019-diff-wserror.sh
+++ b/t/t4019-diff-wserror.sh
@@ -193,7 +193,7 @@ test_expect_success 'do not color trailing cr in context' '
 test_expect_success 'color new trailing blank lines' '
 	{ echo a; echo b; echo; echo; } >x &&
 	git add x &&
-	{ echo a; echo; echo; echo; echo; } >x &&
+	{ echo a; echo; echo; echo; echo c; echo; echo; echo; echo; } >x &&
 	git diff --color x >output &&
 	cnt=$(grep "${blue_grep}" output | wc -l) &&
 	test $cnt = 2
-- 
1.6.5.rc1.54.g4aad
