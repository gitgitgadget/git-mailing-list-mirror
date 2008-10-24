From: Jeff King <peff@peff.net>
Subject: [PATCH 3/5] refactor userdiff textconv code
Date: Thu, 23 Oct 2008 22:53:30 -0400
Message-ID: <20081024025330.GC2831@coredump.intra.peff.net>
References: <20081024024631.GA20365@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 24 04:54:51 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KtCp7-0004ep-NG
	for gcvg-git-2@gmane.org; Fri, 24 Oct 2008 04:54:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752399AbYJXCxd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Oct 2008 22:53:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752481AbYJXCxd
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Oct 2008 22:53:33 -0400
Received: from peff.net ([208.65.91.99]:2533 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751517AbYJXCxc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Oct 2008 22:53:32 -0400
Received: (qmail 12893 invoked by uid 111); 24 Oct 2008 02:53:31 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Thu, 23 Oct 2008 22:53:31 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 23 Oct 2008 22:53:30 -0400
Content-Disposition: inline
In-Reply-To: <20081024024631.GA20365@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99003>

The initial implementation inserted itself at the level of
fill_mmfile. That is, the diff_filespec always contained the
actual file data, but we set up the xdl mmfile with the fake
data. This had several disadvantages:

 - fill_mmfile gets called from several places, but we don't
   necessarily want all of them to see the textconv'd
   version (e.g., whitespace checking should probably
   consider it binary)

 - the filespec itself carried no information about
   binaryness. If we have textconv'd it, then it is no
   longer binary and we need to mark that somehow (which
   lets us avoid having to manually set the filetype to
   non-binary in the diff driver config)

This patch moves the text conversion to a
diff_filespec_textconv function; this function can be called
to insert the text-converted contents of the file into the
filespec. These contents will survive through any
diff_populate_filespec calls, meaning that it is safe to
pass the resulting filespec to other diff functions which
will look at the content.

We now turn on the text conversion only for actual diffs,
not diffstats or whitespace checking. We may eventually want
it for other formats, too, but we will be conservative for
now.

Signed-off-by: Jeff King <peff@peff.net>
---
I think this is much cleaner. I have a nagging worry that a
text-converted filespec might live longer than I expect. Maybe it would
make sense to free the filespec data after the diff has been generated
(and then further populate_filespec calls would just restore the
original data).

Also, I'm happy to hear comments on which functionality should get
text-converted. I think I like seeing the --stat report the binary
changes.

 diff.c                   |   51 +++++++++++++++++++++++++++++++++++----------
 diffcore.h               |    1 +
 t/t4030-diff-textconv.sh |    6 +---
 3 files changed, 42 insertions(+), 16 deletions(-)

diff --git a/diff.c b/diff.c
index d1fd594..89bd2ff 100644
--- a/diff.c
+++ b/diff.c
@@ -284,6 +284,36 @@ static void emit_rewrite_diff(const char *name_a,
 		copy_file_with_prefix(o->file, '+', two->data, two->size, new, reset);
 }
 
+static int diff_filespec_textconv(struct diff_filespec *one)
+{
+	size_t size;
+	char *buf;
+
+	if (one->data_is_textconv)
+		return 0;
+
+	if (!DIFF_FILE_VALID(one))
+		return 0;
+
+	diff_filespec_load_driver(one);
+	if (!one->driver->textconv)
+		return 0;
+
+	if (diff_populate_filespec(one, 0) < 0)
+		return -1;
+
+	buf = run_textconv(one->driver->textconv, one, &size);
+	if (!buf)
+		return -1;
+
+	diff_free_filespec_blob(one);
+	one->data = buf;
+	one->size = size;
+	one->should_free = 1;
+	one->data_is_textconv = 1;
+	return 0;
+}
+
 static int fill_mmfile(mmfile_t *mf, struct diff_filespec *one)
 {
 	if (!DIFF_FILE_VALID(one)) {
@@ -294,18 +324,8 @@ static int fill_mmfile(mmfile_t *mf, struct diff_filespec *one)
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
 
@@ -1292,6 +1312,8 @@ static void diff_filespec_load_driver(struct diff_filespec *one)
 
 int diff_filespec_is_binary(struct diff_filespec *one)
 {
+	if (one->data_is_textconv)
+		return 0;
 	if (one->is_binary == -1) {
 		diff_filespec_load_driver(one);
 		if (one->driver->binary != -1)
@@ -1387,6 +1409,10 @@ static void builtin_diff(const char *name_a,
 		}
 	}
 
+	if (diff_filespec_textconv(one) < 0 ||
+	    diff_filespec_textconv(two) < 0)
+			die("unable to read files to diff");
+
 	if (fill_mmfile(&mf1, one) < 0 || fill_mmfile(&mf2, two) < 0)
 		die("unable to read files to diff");
 
@@ -1778,6 +1804,7 @@ void diff_free_filespec_blob(struct diff_filespec *s)
 		s->should_free = s->should_munmap = 0;
 		s->data = NULL;
 	}
+	s->data_is_textconv = 0;
 }
 
 void diff_free_filespec_data(struct diff_filespec *s)
diff --git a/diffcore.h b/diffcore.h
index 713cca7..33aebc2 100644
--- a/diffcore.h
+++ b/diffcore.h
@@ -42,6 +42,7 @@ struct diff_filespec {
 #define DIFF_FILE_VALID(spec) (((spec)->mode) != 0)
 	unsigned should_free : 1; /* data should be free()'ed */
 	unsigned should_munmap : 1; /* data should be munmap()'ed */
+	unsigned data_is_textconv : 1;
 
 	struct userdiff_driver *driver;
 	/* data should be considered "binary"; -1 means "don't know yet" */
diff --git a/t/t4030-diff-textconv.sh b/t/t4030-diff-textconv.sh
index d0d7691..28d3640 100755
--- a/t/t4030-diff-textconv.sh
+++ b/t/t4030-diff-textconv.sh
@@ -51,7 +51,7 @@ test_expect_success 'setup textconv filter' '
 	git config diff.foo.textconv "$PWD"/hexdump
 '
 
-test_expect_failure 'diff produces text' '
+test_expect_success 'diff produces text' '
 	git diff HEAD^ HEAD >diff &&
 	find_diff <diff >actual &&
 	test_cmp expect.text actual
@@ -63,14 +63,12 @@ test_expect_success 'diff-tree produces binary' '
 	test_cmp expect.binary actual
 '
 
-test_expect_failure 'log produces text' '
+test_expect_success 'log produces text' '
 	git log -1 -p >log &&
 	find_diff <log >actual &&
 	test_cmp expect.text actual
 '
 
-# actually passes, but only because textconv is broken
-# and its failure mode happens to be the same as success
 test_expect_failure 'format-patch produces binary' '
 	git format-patch --no-binary --stdout HEAD^ >patch &&
 	find_diff <patch >actual &&
-- 
1.6.0.3.518.gdb328.dirty
