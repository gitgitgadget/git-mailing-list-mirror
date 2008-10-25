From: Jeff King <peff@peff.net>
Subject: [PATCH 4/7] textconv: don't convert for every operation
Date: Fri, 24 Oct 2008 20:52:56 -0400
Message-ID: <20081025005256.GD23903@coredump.intra.peff.net>
References: <20081025004815.GA23851@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Oct 25 02:54:14 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KtXPx-0003gj-6G
	for gcvg-git-2@gmane.org; Sat, 25 Oct 2008 02:54:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751413AbYJYAw7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Oct 2008 20:52:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751403AbYJYAw7
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Oct 2008 20:52:59 -0400
Received: from peff.net ([208.65.91.99]:1789 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751372AbYJYAw6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Oct 2008 20:52:58 -0400
Received: (qmail 25841 invoked by uid 111); 25 Oct 2008 00:52:57 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Fri, 24 Oct 2008 20:52:57 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 24 Oct 2008 20:52:56 -0400
Content-Disposition: inline
In-Reply-To: <20081025004815.GA23851@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99088>

Since we do the text conversion in fill_mmfile, the
conversion was happening any time we fed data to xdiff,
including diffstat, whitespace checking, etc.

This patch makes it optional for each caller, and
conservatively chooses to turn it on only for actual patch
generation.

Signed-off-by: Jeff King <peff@peff.net>
---
And this was part 2 of the big refactoring patch.

 diff.c                   |   19 ++++++++++---------
 t/t4030-diff-textconv.sh |    2 +-
 2 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/diff.c b/diff.c
index 8fad215..fcdfd7b 100644
--- a/diff.c
+++ b/diff.c
@@ -292,7 +292,8 @@ static const char *get_textconv(struct diff_filespec *one)
 	return one->driver->textconv;
 }
 
-static int fill_mmfile(mmfile_t *mf, struct diff_filespec *one)
+static int fill_mmfile(mmfile_t *mf, struct diff_filespec *one,
+		int try_textconv)
 {
 	const char *textconv;
 
@@ -304,7 +305,7 @@ static int fill_mmfile(mmfile_t *mf, struct diff_filespec *one)
 	else if (diff_populate_filespec(one, 0))
 		return -1;
 
-	if ((textconv = get_textconv(one))) {
+	if (try_textconv && (textconv = get_textconv(one))) {
 		size_t size;
 		mf->ptr = run_textconv(textconv, one, &size);
 		if (!mf->ptr)
@@ -1396,7 +1397,7 @@ static void builtin_diff(const char *name_a,
 		}
 	}
 
-	if (fill_mmfile(&mf1, one) < 0 || fill_mmfile(&mf2, two) < 0)
+	if (fill_mmfile(&mf1, one, 1) < 0 || fill_mmfile(&mf2, two, 1) < 0)
 		die("unable to read files to diff");
 
 	if (!DIFF_OPT_TST(o, TEXT) &&
@@ -1486,7 +1487,7 @@ static void builtin_diffstat(const char *name_a, const char *name_b,
 		data->added = count_lines(two->data, two->size);
 		goto free_and_return;
 	}
-	if (fill_mmfile(&mf1, one) < 0 || fill_mmfile(&mf2, two) < 0)
+	if (fill_mmfile(&mf1, one, 0) < 0 || fill_mmfile(&mf2, two, 0) < 0)
 		die("unable to read files to diff");
 
 	if (diff_filespec_is_binary(one) || diff_filespec_is_binary(two)) {
@@ -1528,7 +1529,7 @@ static void builtin_checkdiff(const char *name_a, const char *name_b,
 	data.o = o;
 	data.ws_rule = whitespace_rule(attr_path);
 
-	if (fill_mmfile(&mf1, one) < 0 || fill_mmfile(&mf2, two) < 0)
+	if (fill_mmfile(&mf1, one, 0) < 0 || fill_mmfile(&mf2, two, 0) < 0)
 		die("unable to read files to diff");
 
 	/*
@@ -2085,8 +2086,8 @@ static void run_diff(struct diff_filepair *p, struct diff_options *o)
 
 		if (DIFF_OPT_TST(o, BINARY)) {
 			mmfile_t mf;
-			if ((!fill_mmfile(&mf, one) && diff_filespec_is_binary(one)) ||
-			    (!fill_mmfile(&mf, two) && diff_filespec_is_binary(two)))
+			if ((!fill_mmfile(&mf, one, 0) && diff_filespec_is_binary(one)) ||
+			    (!fill_mmfile(&mf, two, 0) && diff_filespec_is_binary(two)))
 				abbrev = 40;
 		}
 		strbuf_addf(&msg, "index %.*s..%.*s",
@@ -2983,8 +2984,8 @@ static int diff_get_patch_id(struct diff_options *options, unsigned char *sha1)
 
 		diff_fill_sha1_info(p->one);
 		diff_fill_sha1_info(p->two);
-		if (fill_mmfile(&mf1, p->one) < 0 ||
-				fill_mmfile(&mf2, p->two) < 0)
+		if (fill_mmfile(&mf1, p->one, 0) < 0 ||
+				fill_mmfile(&mf2, p->two, 0) < 0)
 			return error("unable to read files to diff");
 
 		len1 = remove_space(p->one->path, strlen(p->one->path));
diff --git a/t/t4030-diff-textconv.sh b/t/t4030-diff-textconv.sh
index af94e1a..090a21d 100755
--- a/t/t4030-diff-textconv.sh
+++ b/t/t4030-diff-textconv.sh
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
1.6.0.3.523.g38597.dirty
