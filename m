From: Greg Bacon <gbacon@dbresearch.net>
Subject: [PATCH] No diff -b/-w output for all-whitespace changes
Date: Thu, 19 Nov 2009 15:12:24 -0600
Message-ID: <1258665144-26520-1-git-send-email-gbacon@dbresearch.net>
Cc: gitster@pobox.com, Greg Bacon <gbacon@dbresearch.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 19 22:20:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NBEQo-0000y7-IR
	for gcvg-git-2@lo.gmane.org; Thu, 19 Nov 2009 22:20:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754865AbZKSVUY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Nov 2009 16:20:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754835AbZKSVUY
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Nov 2009 16:20:24 -0500
Received: from smtp182.iad.emailsrvr.com ([207.97.245.182]:37529 "EHLO
	smtp182.iad.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754268AbZKSVUX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Nov 2009 16:20:23 -0500
X-Greylist: delayed 468 seconds by postgrey-1.27 at vger.kernel.org; Thu, 19 Nov 2009 16:20:23 EST
Received: from relay18.relay.iad.mlsrvr.com (localhost [127.0.0.1])
	by relay18.relay.iad.mlsrvr.com (SMTP Server) with ESMTP id E543B1B409A;
	Thu, 19 Nov 2009 16:12:38 -0500 (EST)
Received: by relay18.relay.iad.mlsrvr.com (Authenticated sender: gbacon-AT-dbresearch.net) with ESMTPSA id B75BB1B40C0;
	Thu, 19 Nov 2009 16:12:38 -0500 (EST)
X-Mailer: git-send-email 1.6.5.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133256>

Change git-diff's whitespace-ignoring modes to generate
output only if a non-empty patch results, which git-apply
rejects.

Update the tests to look for the new behavior.

Signed-off-by: Greg Bacon <gbacon@dbresearch.net>
---
 diff.c                     |   35 +++++++++++++++++++++++++++--------
 t/t4015-diff-whitespace.sh |   14 ++++++++++++--
 2 files changed, 39 insertions(+), 10 deletions(-)

diff --git a/diff.c b/diff.c
index 0d7f5ea..108de23 100644
--- a/diff.c
+++ b/diff.c
@@ -189,6 +189,7 @@ struct emit_callback {
 	struct diff_words_data *diff_words;
 	int *found_changesp;
 	FILE *file;
+	struct strbuf *header;
 };
 
 static int count_lines(const char *data, int size)
@@ -755,6 +756,11 @@ static void fn_out_consume(void *priv, char *line, unsigned long len)
 	const char *plain = diff_get_color(ecbdata->color_diff, DIFF_PLAIN);
 	const char *reset = diff_get_color(ecbdata->color_diff, DIFF_RESET);
 
+	if (ecbdata->header) {
+		fprintf(ecbdata->file, "%s", ecbdata->header->buf);
+		strbuf_reset(ecbdata->header);
+		ecbdata->header = NULL;
+	}
 	*(ecbdata->found_changesp) = 1;
 
 	if (ecbdata->label_path[0]) {
@@ -1561,6 +1567,7 @@ static void builtin_diff(const char *name_a,
 	const char *reset = diff_get_color_opt(o, DIFF_RESET);
 	const char *a_prefix, *b_prefix;
 	const char *textconv_one = NULL, *textconv_two = NULL;
+	struct strbuf header = STRBUF_INIT;
 
 	if (DIFF_OPT_TST(o, SUBMODULE_LOG) &&
 			(!one->mode || S_ISGITLINK(one->mode)) &&
@@ -1595,25 +1602,26 @@ static void builtin_diff(const char *name_a,
 	b_two = quote_two(b_prefix, name_b + (*name_b == '/'));
 	lbl[0] = DIFF_FILE_VALID(one) ? a_one : "/dev/null";
 	lbl[1] = DIFF_FILE_VALID(two) ? b_two : "/dev/null";
-	fprintf(o->file, "%sdiff --git %s %s%s\n", set, a_one, b_two, reset);
+	strbuf_addf(&header, "%sdiff --git %s %s%s\n", set, a_one, b_two, reset);
 	if (lbl[0][0] == '/') {
 		/* /dev/null */
-		fprintf(o->file, "%snew file mode %06o%s\n", set, two->mode, reset);
+		strbuf_addf(&header, "%snew file mode %06o%s\n", set, two->mode, reset);
 		if (xfrm_msg && xfrm_msg[0])
-			fprintf(o->file, "%s%s%s\n", set, xfrm_msg, reset);
+			strbuf_addf(&header, "%s%s%s\n", set, xfrm_msg, reset);
 	}
 	else if (lbl[1][0] == '/') {
-		fprintf(o->file, "%sdeleted file mode %06o%s\n", set, one->mode, reset);
+		strbuf_addf(&header, "%sdeleted file mode %06o%s\n", set, one->mode, reset);
 		if (xfrm_msg && xfrm_msg[0])
-			fprintf(o->file, "%s%s%s\n", set, xfrm_msg, reset);
+			strbuf_addf(&header, "%s%s%s\n", set, xfrm_msg, reset);
 	}
 	else {
 		if (one->mode != two->mode) {
-			fprintf(o->file, "%sold mode %06o%s\n", set, one->mode, reset);
-			fprintf(o->file, "%snew mode %06o%s\n", set, two->mode, reset);
+			strbuf_addf(&header, "%sold mode %06o%s\n", set, one->mode, reset);
+			strbuf_addf(&header, "%snew mode %06o%s\n", set, two->mode, reset);
 		}
 		if (xfrm_msg && xfrm_msg[0])
-			fprintf(o->file, "%s%s%s\n", set, xfrm_msg, reset);
+			strbuf_addf(&header, "%s%s%s\n", set, xfrm_msg, reset);
+
 		/*
 		 * we do not run diff between different kind
 		 * of objects.
@@ -1623,6 +1631,8 @@ static void builtin_diff(const char *name_a,
 		if (complete_rewrite &&
 		    (textconv_one || !diff_filespec_is_binary(one)) &&
 		    (textconv_two || !diff_filespec_is_binary(two))) {
+			fprintf(o->file, "%s", header.buf);
+			strbuf_reset(&header);
 			emit_rewrite_diff(name_a, name_b, one, two,
 						textconv_one, textconv_two, o);
 			o->found_changes = 1;
@@ -1640,6 +1650,8 @@ static void builtin_diff(const char *name_a,
 		if (mf1.size == mf2.size &&
 		    !memcmp(mf1.ptr, mf2.ptr, mf1.size))
 			goto free_ab_and_return;
+		fprintf(o->file, "%s", header.buf);
+		strbuf_reset(&header);
 		if (DIFF_OPT_TST(o, BINARY))
 			emit_binary_diff(o->file, &mf1, &mf2);
 		else
@@ -1656,6 +1668,11 @@ static void builtin_diff(const char *name_a,
 		struct emit_callback ecbdata;
 		const struct userdiff_funcname *pe;
 
+		if (!DIFF_XDL_TST(o, WHITESPACE_FLAGS)) {
+			fprintf(o->file, "%s", header.buf);
+			strbuf_reset(&header);
+		}
+
 		if (textconv_one) {
 			size_t size;
 			mf1.ptr = run_textconv(textconv_one, one, &size);
@@ -1685,6 +1702,7 @@ static void builtin_diff(const char *name_a,
 		if (ecbdata.ws_rule & WS_BLANK_AT_EOF)
 			check_blank_at_eof(&mf1, &mf2, &ecbdata);
 		ecbdata.file = o->file;
+		ecbdata.header = header.len ? &header : NULL;
 		xpp.flags = XDF_NEED_MINIMAL | o->xdl_opts;
 		xecfg.ctxlen = o->context;
 		xecfg.interhunkctxlen = o->interhunkcontext;
@@ -1729,6 +1747,7 @@ static void builtin_diff(const char *name_a,
 	}
 
  free_ab_and_return:
+	strbuf_release(&header);
 	diff_free_filespec_data(one);
 	diff_free_filespec_data(two);
 	free(a_one);
diff --git a/t/t4015-diff-whitespace.sh b/t/t4015-diff-whitespace.sh
index 8dd147d..90f3342 100755
--- a/t/t4015-diff-whitespace.sh
+++ b/t/t4015-diff-whitespace.sh
@@ -93,8 +93,6 @@ git diff > out
 test_expect_success 'another test, without options' 'test_cmp expect out'
 
 cat << EOF > expect
-diff --git a/x b/x
-index d99af23..8b32fb5 100644
 EOF
 git diff -w > out
 test_expect_success 'another test, with -w' 'test_cmp expect out'
@@ -386,6 +384,18 @@ test_expect_success 'checkdiff allows new blank lines' '
 	git diff --check
 '
 
+cat <<EOF >expect
+EOF
+test_expect_success 'whitespace-only changes not reported' '
+	git reset --hard &&
+	echo >x "hello world" &&
+	git add x &&
+	git commit -m "hello 1" &&
+	echo >x "hello  world" &&
+	git diff -b >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'combined diff with autocrlf conversion' '
 
 	git reset --hard &&
-- 
1.6.5.3
