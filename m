Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AADFF20A17
	for <e@80x24.org>; Wed, 18 Jan 2017 11:19:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755218AbdARLTE (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Jan 2017 06:19:04 -0500
Received: from cloud.peff.net ([104.130.231.41]:40802 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755006AbdARLTB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jan 2017 06:19:01 -0500
Received: (qmail 14397 invoked by uid 109); 18 Jan 2017 11:17:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 18 Jan 2017 11:17:07 +0000
Received: (qmail 26305 invoked by uid 111); 18 Jan 2017 11:18:02 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 18 Jan 2017 06:18:02 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 18 Jan 2017 06:17:05 -0500
Date:   Wed, 18 Jan 2017 06:17:05 -0500
From:   Jeff King <peff@peff.net>
To:     Matt McCutchen <matt@mattmccutchen.net>
Cc:     git@vger.kernel.org
Subject: Re: "git diff --ignore-space-change --stat" lists files with only
 whitespace differences as "changed"
Message-ID: <20170118111705.6bqzkklluikda3r5@sigill.intra.peff.net>
References: <1484704915.2096.16.camel@mattmccutchen.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1484704915.2096.16.camel@mattmccutchen.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 17, 2017 at 09:01:55PM -0500, Matt McCutchen wrote:

> A bug report: I noticed that "git diff --ignore-space-change --stat"
> lists files with only whitespace differences as having changed with 0
> differing lines.  This is inconsistent with the behavior without --
> stat, which doesn't list such files at all.  (Same behavior with all
> the --ignore*space* flags.)  I can reproduce this with the current
> "next", af746e4.  Quick test case:

Hmm. This is pretty easy to do naively, but the special-casing for
addition/deletion (which I think we _do_ need, and which certainly we
fail t4205 without) makes me feel dirty. I'd worry there are other
cases, too (perhaps renames?). And I also notice that the
binary-diffstat code path just above my changes explicitly creates 0/0
diffstats, but I'm not even sure how one would trigger that.

So I dunno. A sensible rule to me is "iff -p would show a diff header,
then --stat should mention it". I think we'd want to somehow extract the
logic from builtin_diff() and reuse it.

---
diff --git a/diff.c b/diff.c
index e2eb6d66a..57ff5c1dc 100644
--- a/diff.c
+++ b/diff.c
@@ -2105,17 +2105,20 @@ static void show_dirstat_by_line(struct diffstat_t *data, struct diff_options *o
 	gather_dirstat(options, &dir, changed, "", 0);
 }
 
+static void free_diffstat_file(struct diffstat_file *f)
+{
+	if (f->name != f->print_name)
+		free(f->print_name);
+	free(f->name);
+	free(f->from_name);
+	free(f);
+}
+
 static void free_diffstat_info(struct diffstat_t *diffstat)
 {
 	int i;
-	for (i = 0; i < diffstat->nr; i++) {
-		struct diffstat_file *f = diffstat->files[i];
-		if (f->name != f->print_name)
-			free(f->print_name);
-		free(f->name);
-		free(f->from_name);
-		free(f);
-	}
+	for (i = 0; i < diffstat->nr; i++)
+		free_diffstat_file(diffstat->files[i]);
 	free(diffstat->files);
 }
 
@@ -2603,6 +2606,23 @@ static void builtin_diffstat(const char *name_a, const char *name_b,
 		if (xdi_diff_outf(&mf1, &mf2, diffstat_consume, diffstat,
 				  &xpp, &xecfg))
 			die("unable to generate diffstat for %s", one->path);
+
+		/*
+		 * Omit diffstats where nothing changed. Even if
+		 * !same_contents, this might be the case due to ignoring
+		 * whitespace changes, etc.
+		 *
+		 * But note that we special-case additions and deletions,
+		 * as adding an empty file, for example, is still of interest.
+		 */
+		if (DIFF_FILE_VALID(one) && DIFF_FILE_VALID(two)) {
+			struct diffstat_file *file =
+				diffstat->files[diffstat->nr - 1];
+			if (!file->added && !file->deleted) {
+				free_diffstat_file(file);
+				diffstat->nr--;
+			}
+		}
 	}
 
 	diff_free_filespec_data(one);
diff --git a/t/t4015-diff-whitespace.sh b/t/t4015-diff-whitespace.sh
index 289806d0c..2805db411 100755
--- a/t/t4015-diff-whitespace.sh
+++ b/t/t4015-diff-whitespace.sh
@@ -736,7 +736,7 @@ test_expect_success 'checkdiff allows new blank lines' '
 
 cat <<EOF >expect
 EOF
-test_expect_success 'whitespace-only changes not reported' '
+test_expect_success 'whitespace-only changes not reported (diff)' '
 	git reset --hard &&
 	echo >x "hello world" &&
 	git add x &&
@@ -746,6 +746,12 @@ test_expect_success 'whitespace-only changes not reported' '
 	test_cmp expect actual
 '
 
+test_expect_success 'whitespace-only changes not reported (diffstat)' '
+	# reuse state from previous test
+	git diff --stat -b >actual &&
+	test_cmp expect actual
+'
+
 cat <<EOF >expect
 diff --git a/x b/z
 similarity index NUM%
