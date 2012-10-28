From: Jeff King <peff@peff.net>
Subject: [PATCH 2/2] pickaxe: use textconv for -S counting
Date: Sun, 28 Oct 2012 08:47:01 -0400
Message-ID: <20121028124701.GB24548@sigill.intra.peff.net>
References: <20121028124540.GF11434@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Peter Oberndorfer <kumbayo84@arcor.de>
X-From: git-owner@vger.kernel.org Sun Oct 28 13:47:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TSSGr-0002jx-8p
	for gcvg-git-2@plane.gmane.org; Sun, 28 Oct 2012 13:47:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752202Ab2J1MrF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Oct 2012 08:47:05 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:41333 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751904Ab2J1MrE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Oct 2012 08:47:04 -0400
Received: (qmail 8442 invoked by uid 107); 28 Oct 2012 12:47:44 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 28 Oct 2012 08:47:44 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 28 Oct 2012 08:47:01 -0400
Content-Disposition: inline
In-Reply-To: <20121028124540.GF11434@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208543>

We currently just look at raw blob data when using "-S" to
pickaxe. This is mostly historical, as pickaxe predates the
textconv feature. If the user has bothered to define a
textconv filter, it is more likely that their search string will be
on the textconv output, as that is what they will see in the
diff (and we do not even provide a mechanism for them to
search for binary needles that contain NUL characters).

This patch teaches "-S" to use textconv, just as we
already do for "-G".

Signed-off-by: Jeff King <peff@peff.net>
---
 diffcore-pickaxe.c       | 56 +++++++++++++++++++++++++++++++++---------------
 t/t4030-diff-textconv.sh | 12 +++++++++++
 2 files changed, 51 insertions(+), 17 deletions(-)

diff --git a/diffcore-pickaxe.c b/diffcore-pickaxe.c
index 61f628c..b097fa7 100644
--- a/diffcore-pickaxe.c
+++ b/diffcore-pickaxe.c
@@ -157,17 +157,15 @@ static unsigned int contains(struct diff_filespec *one, struct diff_options *o,
 	return;
 }
 
-static unsigned int contains(struct diff_filespec *one, struct diff_options *o,
+static unsigned int contains(mmfile_t *mf, struct diff_options *o,
 			     regex_t *regexp, kwset_t kws)
 {
 	unsigned int cnt;
 	unsigned long sz;
 	const char *data;
-	if (diff_populate_filespec(one, 0))
-		return 0;
 
-	sz = one->size;
-	data = one->data;
+	sz = mf->size;
+	data = mf->ptr;
 	cnt = 0;
 
 	if (regexp) {
@@ -197,29 +195,53 @@ static int has_changes(struct diff_filepair *p, struct diff_options *o,
 			cnt++;
 		}
 	}
-	diff_free_filespec_data(one);
 	return cnt;
 }
 
 static int has_changes(struct diff_filepair *p, struct diff_options *o,
 		       regex_t *regexp, kwset_t kws)
 {
+	struct userdiff_driver *textconv_one = get_textconv(p->one);
+	struct userdiff_driver *textconv_two = get_textconv(p->two);
+	mmfile_t mf1, mf2;
+	int ret;
+
 	if (!o->pickaxe[0])
 		return 0;
 
-	if (!DIFF_FILE_VALID(p->one)) {
-		if (!DIFF_FILE_VALID(p->two))
-			return 0; /* ignore unmerged */
+	/*
+	 * If we have an unmodified pair, we know that the count will be the
+	 * same and don't even have to load the blobs. Unless textconv is in
+	 * play, _and_ we are using two different textconv filters (e.g.,
+	 * because a pair is an exact rename with different textconv attributes
+	 * for each side, which might generate different content).
+	 */
+	if (textconv_one == textconv_two && diff_unmodified_pair(p))
+		return 0;
+
+	fill_one(p->one, &mf1, &textconv_one);
+	fill_one(p->two, &mf2, &textconv_two);
+
+	if (!mf1.ptr) {
+		if (!mf2.ptr)
+			ret = 0; /* ignore unmerged */
 		/* created */
-		return contains(p->two, o, regexp, kws) != 0;
-	}
-	if (!DIFF_FILE_VALID(p->two))
-		return contains(p->one, o, regexp, kws) != 0;
-	if (!diff_unmodified_pair(p)) {
-		return contains(p->one, o, regexp, kws) !=
-		       contains(p->two, o, regexp, kws);
+		ret = contains(&mf2, o, regexp, kws) != 0;
 	}
-	return 0;
+	else if (!mf2.ptr) /* removed */
+		ret = contains(&mf1, o, regexp, kws) != 0;
+	else
+		ret = contains(&mf1, o, regexp, kws) !=
+		      contains(&mf2, o, regexp, kws);
+
+	if (textconv_one)
+		free(mf1.ptr);
+	if (textconv_two)
+		free(mf2.ptr);
+	diff_free_filespec_data(p->one);
+	diff_free_filespec_data(p->two);
+
+	return ret;
 }
 
 static void diffcore_pickaxe_count(struct diff_options *o)
diff --git a/t/t4030-diff-textconv.sh b/t/t4030-diff-textconv.sh
index 461d27a..53ec330 100755
--- a/t/t4030-diff-textconv.sh
+++ b/t/t4030-diff-textconv.sh
@@ -96,6 +96,18 @@ test_expect_success 'grep-diff (-G) operates on textconv data (modification)' '
 	test_cmp expect actual
 '
 
+test_expect_success 'pickaxe (-S) operates on textconv data (add)' '
+	echo one >expect &&
+	git log --root --format=%s -S0 >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'pickaxe (-S) operates on textconv data (modification)' '
+	echo two >expect &&
+	git log --root --format=%s -S1 >actual &&
+	test_cmp expect actual
+'
+
 cat >expect.stat <<'EOF'
  file | Bin 2 -> 4 bytes
  1 file changed, 0 insertions(+), 0 deletions(-)
-- 
1.8.0.3.g3456896
