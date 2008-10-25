From: Jeff King <peff@peff.net>
Subject: [PATCH 3/7] textconv: assume text-converted contents are not binary
Date: Fri, 24 Oct 2008 20:52:25 -0400
Message-ID: <20081025005225.GC23903@coredump.intra.peff.net>
References: <20081025004815.GA23851@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Oct 25 02:53:42 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KtXPQ-0003bS-TO
	for gcvg-git-2@gmane.org; Sat, 25 Oct 2008 02:53:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751374AbYJYAw2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Oct 2008 20:52:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751372AbYJYAw2
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Oct 2008 20:52:28 -0400
Received: from peff.net ([208.65.91.99]:1783 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751215AbYJYAw2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Oct 2008 20:52:28 -0400
Received: (qmail 25816 invoked by uid 111); 25 Oct 2008 00:52:27 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Fri, 24 Oct 2008 20:52:27 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 24 Oct 2008 20:52:25 -0400
Content-Disposition: inline
In-Reply-To: <20081025004815.GA23851@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99087>

Previously, we would use a 'textconv' filter when filling
the mmfile_t, but then still check the diff_filespec struct,
which was not modified at all by the text conversion,
whether it was binary. And in general, it was, since the
point of text conversion is to munge binary contents. This
meant that the user had to manually set "diff.foo.binary =
false" to convince the text conversion to actually happen.

This patch pulls the logic for "can we textconv this
diff_filespec?" into a separate function. We can then check
this to see if a filespec which is binary would have been
converted.

Signed-off-by: Jeff King <peff@peff.net>
---
This used to be part 1 of the big refactoring patch.

 diff.c                   |   18 ++++++++++++++----
 t/t4030-diff-textconv.sh |    4 ++--
 2 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/diff.c b/diff.c
index d1fd594..8fad215 100644
--- a/diff.c
+++ b/diff.c
@@ -284,8 +284,18 @@ static void emit_rewrite_diff(const char *name_a,
 		copy_file_with_prefix(o->file, '+', two->data, two->size, new, reset);
 }
 
+static const char *get_textconv(struct diff_filespec *one)
+{
+	if (!DIFF_FILE_VALID(one))
+		return NULL;
+	diff_filespec_load_driver(one);
+	return one->driver->textconv;
+}
+
 static int fill_mmfile(mmfile_t *mf, struct diff_filespec *one)
 {
+	const char *textconv;
+
 	if (!DIFF_FILE_VALID(one)) {
 		mf->ptr = (char *)""; /* does not matter */
 		mf->size = 0;
@@ -294,10 +304,9 @@ static int fill_mmfile(mmfile_t *mf, struct diff_filespec *one)
 	else if (diff_populate_filespec(one, 0))
 		return -1;
 
-	diff_filespec_load_driver(one);
-	if (one->driver->textconv) {
+	if ((textconv = get_textconv(one))) {
 		size_t size;
-		mf->ptr = run_textconv(one->driver->textconv, one, &size);
+		mf->ptr = run_textconv(textconv, one, &size);
 		if (!mf->ptr)
 			return -1;
 		mf->size = size;
@@ -1391,7 +1400,8 @@ static void builtin_diff(const char *name_a,
 		die("unable to read files to diff");
 
 	if (!DIFF_OPT_TST(o, TEXT) &&
-	    (diff_filespec_is_binary(one) || diff_filespec_is_binary(two))) {
+	    ( (diff_filespec_is_binary(one) && !get_textconv(one)) ||
+	      (diff_filespec_is_binary(two) && !get_textconv(two)) )) {
 		/* Quite common confusing case */
 		if (mf1.size == mf2.size &&
 		    !memcmp(mf1.ptr, mf2.ptr, mf1.size))
diff --git a/t/t4030-diff-textconv.sh b/t/t4030-diff-textconv.sh
index 1b09648..af94e1a 100755
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
-- 
1.6.0.3.523.g38597.dirty
