From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH 2/3] diff: refactor the word-diff setup from builtin_diff_cmd
Date: Wed, 14 Mar 2012 19:24:08 +0100
Message-ID: <9f2f3a870a8d88850444090318647f3c7b8c0743.1331749299.git.trast@student.ethz.ch>
References: <3bb99e938624ae674674b304c24c48b9dc05871b.1331749299.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>, <git@vger.kernel.org>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Wed Mar 14 19:24:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S7ss1-0001BW-Ax
	for gcvg-git-2@plane.gmane.org; Wed, 14 Mar 2012 19:24:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761383Ab2CNSYQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Mar 2012 14:24:16 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:33801 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761138Ab2CNSYO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Mar 2012 14:24:14 -0400
Received: from CAS10.d.ethz.ch (172.31.38.210) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.1.355.2; Wed, 14 Mar
 2012 19:24:10 +0100
Received: from thomas.inf.ethz.ch (129.132.153.233) by cas10.d.ethz.ch
 (172.31.38.210) with Microsoft SMTP Server (TLS) id 14.1.355.2; Wed, 14 Mar
 2012 19:24:09 +0100
X-Mailer: git-send-email 1.7.10.rc0.286.gd2cb29
In-Reply-To: <3bb99e938624ae674674b304c24c48b9dc05871b.1331749299.git.trast@student.ethz.ch>
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193143>

Quite a chunk of builtin_diff_cmd deals with word-diff setup, defaults
and such.  This makes the function a bit hard to read, but is also
asymmetric because the corresponding teardown lives in free_diff_words_data
already.

Refactor into a new function init_diff_words_data.  For simplicity,
also shuffle around some functions it depends on.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---
 diff.c |  119 ++++++++++++++++++++++++++++++++++------------------------------
 1 file changed, 63 insertions(+), 56 deletions(-)

diff --git a/diff.c b/diff.c
index a698a3f..aac86d3 100644
--- a/diff.c
+++ b/diff.c
@@ -989,6 +989,67 @@ static void diff_words_flush(struct emit_callback *ecbdata)
 		diff_words_show(ecbdata->diff_words);
 }
 
+static void diff_filespec_load_driver(struct diff_filespec *one)
+{
+	/* Use already-loaded driver */
+	if (one->driver)
+		return;
+
+	if (S_ISREG(one->mode))
+		one->driver = userdiff_find_by_path(one->path);
+
+	/* Fallback to default settings */
+	if (!one->driver)
+		one->driver = userdiff_find_by_name("default");
+}
+
+static const char *userdiff_word_regex(struct diff_filespec *one)
+{
+	diff_filespec_load_driver(one);
+	return one->driver->word_regex;
+}
+
+static void init_diff_words_data(struct emit_callback *ecbdata,
+				 struct diff_options *o,
+				 struct diff_filespec *one,
+				 struct diff_filespec *two)
+{
+	int i;
+
+	ecbdata->diff_words =
+		xcalloc(1, sizeof(struct diff_words_data));
+	ecbdata->diff_words->type = o->word_diff;
+	ecbdata->diff_words->opt = o;
+	if (!o->word_regex)
+		o->word_regex = userdiff_word_regex(one);
+	if (!o->word_regex)
+		o->word_regex = userdiff_word_regex(two);
+	if (!o->word_regex)
+		o->word_regex = diff_word_regex_cfg;
+	if (o->word_regex) {
+		ecbdata->diff_words->word_regex = (regex_t *)
+			xmalloc(sizeof(regex_t));
+		if (regcomp(ecbdata->diff_words->word_regex,
+			    o->word_regex,
+			    REG_EXTENDED | REG_NEWLINE))
+			die ("Invalid regular expression: %s",
+			     o->word_regex);
+	}
+	for (i = 0; i < ARRAY_SIZE(diff_words_styles); i++) {
+		if (o->word_diff == diff_words_styles[i].type) {
+			ecbdata->diff_words->style =
+				&diff_words_styles[i];
+			break;
+		}
+	}
+	if (want_color(o->use_color)) {
+		struct diff_words_style *st = ecbdata->diff_words->style;
+		st->old.color = diff_get_color_opt(o, DIFF_FILE_OLD);
+		st->new.color = diff_get_color_opt(o, DIFF_FILE_NEW);
+		st->ctx.color = diff_get_color_opt(o, DIFF_PLAIN);
+	}
+}
+
 static void free_diff_words_data(struct emit_callback *ecbdata)
 {
 	if (ecbdata->diff_words) {
@@ -2061,20 +2122,6 @@ static void emit_binary_diff(FILE *file, mmfile_t *one, mmfile_t *two, char *pre
 	emit_binary_diff_body(file, two, one, prefix);
 }
 
-static void diff_filespec_load_driver(struct diff_filespec *one)
-{
-	/* Use already-loaded driver */
-	if (one->driver)
-		return;
-
-	if (S_ISREG(one->mode))
-		one->driver = userdiff_find_by_path(one->path);
-
-	/* Fallback to default settings */
-	if (!one->driver)
-		one->driver = userdiff_find_by_name("default");
-}
-
 int diff_filespec_is_binary(struct diff_filespec *one)
 {
 	if (one->is_binary == -1) {
@@ -2100,12 +2147,6 @@ static const struct userdiff_funcname *diff_funcname_pattern(struct diff_filespe
 	return one->driver->funcname.pattern ? &one->driver->funcname : NULL;
 }
 
-static const char *userdiff_word_regex(struct diff_filespec *one)
-{
-	diff_filespec_load_driver(one);
-	return one->driver->word_regex;
-}
-
 void diff_set_mnemonic_prefix(struct diff_options *options, const char *a, const char *b)
 {
 	if (!options->a_prefix)
@@ -2292,42 +2333,8 @@ static void builtin_diff(const char *name_a,
 			xecfg.ctxlen = strtoul(diffopts + 10, NULL, 10);
 		else if (!prefixcmp(diffopts, "-u"))
 			xecfg.ctxlen = strtoul(diffopts + 2, NULL, 10);
-		if (o->word_diff) {
-			int i;
-
-			ecbdata.diff_words =
-				xcalloc(1, sizeof(struct diff_words_data));
-			ecbdata.diff_words->type = o->word_diff;
-			ecbdata.diff_words->opt = o;
-			if (!o->word_regex)
-				o->word_regex = userdiff_word_regex(one);
-			if (!o->word_regex)
-				o->word_regex = userdiff_word_regex(two);
-			if (!o->word_regex)
-				o->word_regex = diff_word_regex_cfg;
-			if (o->word_regex) {
-				ecbdata.diff_words->word_regex = (regex_t *)
-					xmalloc(sizeof(regex_t));
-				if (regcomp(ecbdata.diff_words->word_regex,
-						o->word_regex,
-						REG_EXTENDED | REG_NEWLINE))
-					die ("Invalid regular expression: %s",
-							o->word_regex);
-			}
-			for (i = 0; i < ARRAY_SIZE(diff_words_styles); i++) {
-				if (o->word_diff == diff_words_styles[i].type) {
-					ecbdata.diff_words->style =
-						&diff_words_styles[i];
-					break;
-				}
-			}
-			if (want_color(o->use_color)) {
-				struct diff_words_style *st = ecbdata.diff_words->style;
-				st->old.color = diff_get_color_opt(o, DIFF_FILE_OLD);
-				st->new.color = diff_get_color_opt(o, DIFF_FILE_NEW);
-				st->ctx.color = diff_get_color_opt(o, DIFF_PLAIN);
-			}
-		}
+		if (o->word_diff)
+			init_diff_words_data(&ecbdata, o, one, two);
 		xdi_diff_outf(&mf1, &mf2, fn_out_consume, &ecbdata,
 			      &xpp, &xecfg);
 		if (o->word_diff)
-- 
1.7.10.rc0.286.gd2cb29
