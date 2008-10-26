From: Jeff King <peff@peff.net>
Subject: [PATCH v3 4/8] refactor userdiff textconv code
Date: Sun, 26 Oct 2008 00:44:53 -0400
Message-ID: <20081026044453.GD21047@coredump.intra.peff.net>
References: <20081026043802.GA14530@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Oct 26 05:46:10 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KtxVx-0005Gm-BN
	for gcvg-git-2@gmane.org; Sun, 26 Oct 2008 05:46:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751289AbYJZEo4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Oct 2008 00:44:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751299AbYJZEo4
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Oct 2008 00:44:56 -0400
Received: from peff.net ([208.65.91.99]:2013 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751289AbYJZEo4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Oct 2008 00:44:56 -0400
Received: (qmail 4961 invoked by uid 111); 26 Oct 2008 04:44:54 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Sun, 26 Oct 2008 00:44:54 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 26 Oct 2008 00:44:53 -0400
Content-Disposition: inline
In-Reply-To: <20081026043802.GA14530@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99144>

The original implementation of textconv put the conversion
into fill_mmfile. This was a bad idea for a number of
reasons:

 - it made the semantics of fill_mmfile unclear. In some
   cases, it was allocating data (if a text conversion
   occurred), and in some cases not (if we could use the
   data directly from the filespec). But the caller had
   no idea which had happened, and so didn't know whether
   the memory should be freed

 - similarly, the caller had no idea if a text conversion
   had occurred, and so didn't know whether the contents
   should be treated as binary or not. This meant that we
   incorrectly guessed that text-converted content was
   binary and didn't actually show it (unless the user
   overrode us with "diff.foo.binary = false", which then
   created problems in plumbing where the text conversion
   did _not_ occur)

 - not all callers of fill_mmfile want the text contents. In
   particular, we don't really want diffstat, whitespace
   checks, patch id generation, etc, to look at the
   converted contents.

This patch pulls the conversion code directly into
builtin_diff, so that we only see the conversion when
generating an actual patch. We also then know whether we are
doing a conversion, so we can check the binary-ness and free
the data from the mmfile appropriately (the previous version
leaked quite badly when text conversion was used)

Signed-off-by: Jeff King <peff@peff.net>
---
This patch is the interesting one. I think your suggestion turned out
fairly clean (and this reverts fill_mmfile back to its state before the
original textconv series).

 diff.c                   |   48 +++++++++++++++++++++++++++++++++------------
 t/t4030-diff-textconv.sh |    6 ++--
 2 files changed, 38 insertions(+), 16 deletions(-)

diff --git a/diff.c b/diff.c
index d1fd594..6f01595 100644
--- a/diff.c
+++ b/diff.c
@@ -294,18 +294,8 @@ static int fill_mmfile(mmfile_t *mf, struct diff_filespec *one)
 	else if (diff_populate_filespec(one, 0))
 		return -1;
 
-	diff_filespec_load_driver(one);
-	if (one->driver->textconv) {
-		size_t size;
-		mf->ptr = run_textconv(one->driver->textconv, one, &size);
-		if (!mf->ptr)
-			return -1;
-		mf->size = size;
-	}
-	else {
-		mf->ptr = one->data;
-		mf->size = one->size;
-	}
+	mf->ptr = one->data;
+	mf->size = one->size;
 	return 0;
 }
 
@@ -1323,6 +1313,14 @@ void diff_set_mnemonic_prefix(struct diff_options *options, const char *a, const
 		options->b_prefix = b;
 }
 
+static const char *get_textconv(struct diff_filespec *one)
+{
+	if (!DIFF_FILE_VALID(one))
+		return NULL;
+	diff_filespec_load_driver(one);
+	return one->driver->textconv;
+}
+
 static void builtin_diff(const char *name_a,
 			 const char *name_b,
 			 struct diff_filespec *one,
@@ -1337,6 +1335,7 @@ static void builtin_diff(const char *name_a,
 	const char *set = diff_get_color_opt(o, DIFF_METAINFO);
 	const char *reset = diff_get_color_opt(o, DIFF_RESET);
 	const char *a_prefix, *b_prefix;
+	const char *textconv_one, *textconv_two;
 
 	diff_set_mnemonic_prefix(o, "a/", "b/");
 	if (DIFF_OPT_TST(o, REVERSE_DIFF)) {
@@ -1390,8 +1389,12 @@ static void builtin_diff(const char *name_a,
 	if (fill_mmfile(&mf1, one) < 0 || fill_mmfile(&mf2, two) < 0)
 		die("unable to read files to diff");
 
+	textconv_one = get_textconv(one);
+	textconv_two = get_textconv(two);
+
 	if (!DIFF_OPT_TST(o, TEXT) &&
-	    (diff_filespec_is_binary(one) || diff_filespec_is_binary(two))) {
+	    ( (diff_filespec_is_binary(one) && !textconv_one) ||
+	      (diff_filespec_is_binary(two) && !textconv_two) )) {
 		/* Quite common confusing case */
 		if (mf1.size == mf2.size &&
 		    !memcmp(mf1.ptr, mf2.ptr, mf1.size))
@@ -1412,6 +1415,21 @@ static void builtin_diff(const char *name_a,
 		struct emit_callback ecbdata;
 		const struct userdiff_funcname *pe;
 
+		if (textconv_one) {
+			size_t size;
+			mf1.ptr = run_textconv(textconv_one, one, &size);
+			if (!mf1.ptr)
+				die("unable to read files to diff");
+			mf1.size = size;
+		}
+		if (textconv_two) {
+			size_t size;
+			mf2.ptr = run_textconv(textconv_two, two, &size);
+			if (!mf2.ptr)
+				die("unable to read files to diff");
+			mf2.size = size;
+		}
+
 		pe = diff_funcname_pattern(one);
 		if (!pe)
 			pe = diff_funcname_pattern(two);
@@ -1443,6 +1461,10 @@ static void builtin_diff(const char *name_a,
 			      &xpp, &xecfg, &ecb);
 		if (DIFF_OPT_TST(o, COLOR_DIFF_WORDS))
 			free_diff_words_data(&ecbdata);
+		if (textconv_one)
+			free(mf1.ptr);
+		if (textconv_two)
+			free(mf2.ptr);
 	}
 
  free_ab_and_return:
diff --git a/t/t4030-diff-textconv.sh b/t/t4030-diff-textconv.sh
index 1b09648..090a21d 100755
--- a/t/t4030-diff-textconv.sh
+++ b/t/t4030-diff-textconv.sh
@@ -52,7 +52,7 @@ test_expect_success 'setup textconv filters' '
 	git config diff.fail.textconv false
 '
 
-test_expect_failure 'diff produces text' '
+test_expect_success 'diff produces text' '
 	git diff HEAD^ HEAD >diff &&
 	find_diff <diff >actual &&
 	test_cmp expect.text actual
@@ -64,7 +64,7 @@ test_expect_success 'diff-tree produces binary' '
 	test_cmp expect.binary actual
 '
 
-test_expect_failure 'log produces text' '
+test_expect_success 'log produces text' '
 	git log -1 -p >log &&
 	find_diff <log >actual &&
 	test_cmp expect.text actual
@@ -80,7 +80,7 @@ cat >expect.stat <<'EOF'
  file |  Bin 2 -> 4 bytes
  1 files changed, 0 insertions(+), 0 deletions(-)
 EOF
-test_expect_failure 'diffstat does not run textconv' '
+test_expect_success 'diffstat does not run textconv' '
 	echo file diff=fail >.gitattributes &&
 	git diff --stat HEAD^ HEAD >actual &&
 	test_cmp expect.stat actual
-- 
1.6.0.3.524.ge8b2e.dirty
