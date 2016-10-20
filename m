Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A7E2020986
	for <e@80x24.org>; Thu, 20 Oct 2016 06:19:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754140AbcJTGTq (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Oct 2016 02:19:46 -0400
Received: from cloud.peff.net ([104.130.231.41]:59863 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753338AbcJTGTq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Oct 2016 02:19:46 -0400
Received: (qmail 18617 invoked by uid 109); 20 Oct 2016 06:19:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 20 Oct 2016 06:19:46 +0000
Received: (qmail 21053 invoked by uid 111); 20 Oct 2016 06:20:07 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 20 Oct 2016 02:20:07 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 20 Oct 2016 02:19:43 -0400
Date:   Thu, 20 Oct 2016 02:19:43 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 4/7] diff_unique_abbrev: rename to diff_aligned_abbrev
Message-ID: <20161020061943.tcndl4cngwycw7zi@sigill.intra.peff.net>
References: <20161020061536.6fqh23xb2nhxodpa@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20161020061536.6fqh23xb2nhxodpa@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The word "align" describes how the function actually differs
from find_unique_abbrev, and will make it less confusing
when we add more diff-specific abbrevation functions that do
not do this alignment.

Since this is a globally available function, let's also move
its descriptive comment to the header file, where we
typically document function interfaces.

Signed-off-by: Jeff King <peff@peff.net>
---
 combine-diff.c |  6 +++---
 diff.c         | 10 +++-------
 diff.h         |  6 +++++-
 3 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/combine-diff.c b/combine-diff.c
index 8e2a577..b36c2d1 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -1203,9 +1203,9 @@ static void show_raw_diff(struct combine_diff_path *p, int num_parent, struct re
 
 		/* Show sha1's */
 		for (i = 0; i < num_parent; i++)
-			printf(" %s", diff_unique_abbrev(p->parent[i].oid.hash,
-							 opt->abbrev));
-		printf(" %s ", diff_unique_abbrev(p->oid.hash, opt->abbrev));
+			printf(" %s", diff_aligned_abbrev(p->parent[i].oid.hash,
+							  opt->abbrev));
+		printf(" %s ", diff_aligned_abbrev(p->oid.hash, opt->abbrev));
 	}
 
 	if (opt->output_format & (DIFF_FORMAT_RAW | DIFF_FORMAT_NAME_STATUS)) {
diff --git a/diff.c b/diff.c
index f5d6d7e..2d8b74b 100644
--- a/diff.c
+++ b/diff.c
@@ -4136,11 +4136,7 @@ void diff_free_filepair(struct diff_filepair *p)
 	free(p);
 }
 
-/*
- * This is different from find_unique_abbrev() in that
- * it stuffs the result with dots for alignment.
- */
-const char *diff_unique_abbrev(const unsigned char *sha1, int len)
+const char *diff_aligned_abbrev(const unsigned char *sha1, int len)
 {
 	int abblen;
 	const char *abbrev;
@@ -4188,9 +4184,9 @@ static void diff_flush_raw(struct diff_filepair *p, struct diff_options *opt)
 	fprintf(opt->file, "%s", diff_line_prefix(opt));
 	if (!(opt->output_format & DIFF_FORMAT_NAME_STATUS)) {
 		fprintf(opt->file, ":%06o %06o %s ", p->one->mode, p->two->mode,
-			diff_unique_abbrev(p->one->oid.hash, opt->abbrev));
+			diff_aligned_abbrev(p->one->oid.hash, opt->abbrev));
 		fprintf(opt->file, "%s ",
-			diff_unique_abbrev(p->two->oid.hash, opt->abbrev));
+			diff_aligned_abbrev(p->two->oid.hash, opt->abbrev));
 	}
 	if (p->score) {
 		fprintf(opt->file, "%c%03d%c", p->status, similarity_index(p),
diff --git a/diff.h b/diff.h
index 25ae60d..f2b04b6 100644
--- a/diff.h
+++ b/diff.h
@@ -340,7 +340,11 @@ extern void diff_warn_rename_limit(const char *varname, int needed, int degraded
 #define DIFF_STATUS_FILTER_AON		'*'
 #define DIFF_STATUS_FILTER_BROKEN	'B'
 
-extern const char *diff_unique_abbrev(const unsigned char *, int);
+/*
+ * This is different from find_unique_abbrev() in that
+ * it stuffs the result with dots for alignment.
+ */
+extern const char *diff_aligned_abbrev(const unsigned char *sha1, int);
 
 /* do not report anything on removed paths */
 #define DIFF_SILENT_ON_REMOVED 01
-- 
2.10.1.619.g16351a7

