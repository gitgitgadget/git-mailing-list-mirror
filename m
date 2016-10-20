Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8AFE920986
	for <e@80x24.org>; Thu, 20 Oct 2016 06:20:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754202AbcJTGUK (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Oct 2016 02:20:10 -0400
Received: from cloud.peff.net ([104.130.231.41]:59866 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753164AbcJTGUK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Oct 2016 02:20:10 -0400
Received: (qmail 18628 invoked by uid 109); 20 Oct 2016 06:20:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 20 Oct 2016 06:20:10 +0000
Received: (qmail 21070 invoked by uid 111); 20 Oct 2016 06:20:31 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 20 Oct 2016 02:20:31 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 20 Oct 2016 02:20:07 -0400
Date:   Thu, 20 Oct 2016 02:20:07 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 5/7] diff_aligned_abbrev: use "struct oid"
Message-ID: <20161020062007.2iiveklem2fikbvu@sigill.intra.peff.net>
References: <20161020061536.6fqh23xb2nhxodpa@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20161020061536.6fqh23xb2nhxodpa@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since we're modifying this function anyway, it's a good time
to update it to the more modern "struct oid". We can also
drop some of the magic numbers in favor of GIT_SHA1_HEXSZ,
along with some descriptive comments.

Signed-off-by: Jeff King <peff@peff.net>
---
 combine-diff.c |  4 ++--
 diff.c         | 20 +++++++++++---------
 diff.h         |  2 +-
 3 files changed, 14 insertions(+), 12 deletions(-)

diff --git a/combine-diff.c b/combine-diff.c
index b36c2d1..59501db 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -1203,9 +1203,9 @@ static void show_raw_diff(struct combine_diff_path *p, int num_parent, struct re
 
 		/* Show sha1's */
 		for (i = 0; i < num_parent; i++)
-			printf(" %s", diff_aligned_abbrev(p->parent[i].oid.hash,
+			printf(" %s", diff_aligned_abbrev(&p->parent[i].oid,
 							  opt->abbrev));
-		printf(" %s ", diff_aligned_abbrev(p->oid.hash, opt->abbrev));
+		printf(" %s ", diff_aligned_abbrev(&p->oid, opt->abbrev));
 	}
 
 	if (opt->output_format & (DIFF_FORMAT_RAW | DIFF_FORMAT_NAME_STATUS)) {
diff --git a/diff.c b/diff.c
index 2d8b74b..8f0f309 100644
--- a/diff.c
+++ b/diff.c
@@ -4136,14 +4136,15 @@ void diff_free_filepair(struct diff_filepair *p)
 	free(p);
 }
 
-const char *diff_aligned_abbrev(const unsigned char *sha1, int len)
+const char *diff_aligned_abbrev(const struct object_id *oid, int len)
 {
 	int abblen;
 	const char *abbrev;
-	if (len == 40)
-		return sha1_to_hex(sha1);
 
-	abbrev = find_unique_abbrev(sha1, len);
+	if (len == GIT_SHA1_HEXSZ)
+		return oid_to_hex(oid);
+
+	abbrev = find_unique_abbrev(oid->hash, len);
 	abblen = strlen(abbrev);
 
 	/*
@@ -4165,15 +4166,16 @@ const char *diff_aligned_abbrev(const unsigned char *sha1, int len)
 	 * the automatic sizing is supposed to give abblen that ensures
 	 * uniqueness across all objects (statistically speaking).
 	 */
-	if (abblen < 37) {
-		static char hex[41];
+	if (abblen < GIT_SHA1_HEXSZ - 3) {
+		static char hex[GIT_SHA1_HEXSZ + 1];
 		if (len < abblen && abblen <= len + 2)
 			xsnprintf(hex, sizeof(hex), "%s%.*s", abbrev, len+3-abblen, "..");
 		else
 			xsnprintf(hex, sizeof(hex), "%s...", abbrev);
 		return hex;
 	}
-	return sha1_to_hex(sha1);
+
+	return oid_to_hex(oid);
 }
 
 static void diff_flush_raw(struct diff_filepair *p, struct diff_options *opt)
@@ -4184,9 +4186,9 @@ static void diff_flush_raw(struct diff_filepair *p, struct diff_options *opt)
 	fprintf(opt->file, "%s", diff_line_prefix(opt));
 	if (!(opt->output_format & DIFF_FORMAT_NAME_STATUS)) {
 		fprintf(opt->file, ":%06o %06o %s ", p->one->mode, p->two->mode,
-			diff_aligned_abbrev(p->one->oid.hash, opt->abbrev));
+			diff_aligned_abbrev(&p->one->oid, opt->abbrev));
 		fprintf(opt->file, "%s ",
-			diff_aligned_abbrev(p->two->oid.hash, opt->abbrev));
+			diff_aligned_abbrev(&p->two->oid, opt->abbrev));
 	}
 	if (p->score) {
 		fprintf(opt->file, "%c%03d%c", p->status, similarity_index(p),
diff --git a/diff.h b/diff.h
index f2b04b6..01afc70 100644
--- a/diff.h
+++ b/diff.h
@@ -344,7 +344,7 @@ extern void diff_warn_rename_limit(const char *varname, int needed, int degraded
  * This is different from find_unique_abbrev() in that
  * it stuffs the result with dots for alignment.
  */
-extern const char *diff_aligned_abbrev(const unsigned char *sha1, int);
+extern const char *diff_aligned_abbrev(const struct object_id *sha1, int);
 
 /* do not report anything on removed paths */
 #define DIFF_SILENT_ON_REMOVED 01
-- 
2.10.1.619.g16351a7

