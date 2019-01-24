Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 474BE1F453
	for <e@80x24.org>; Thu, 24 Jan 2019 13:12:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728109AbfAXNMn (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 Jan 2019 08:12:43 -0500
Received: from cloud.peff.net ([104.130.231.41]:47214 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727798AbfAXNMn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Jan 2019 08:12:43 -0500
Received: (qmail 27493 invoked by uid 109); 24 Jan 2019 13:12:42 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 24 Jan 2019 13:12:42 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28329 invoked by uid 111); 24 Jan 2019 13:12:47 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 24 Jan 2019 08:12:47 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 24 Jan 2019 08:12:41 -0500
Date:   Thu, 24 Jan 2019 08:12:41 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 7/8] convert: drop len parameter from conversion checks
Message-ID: <20190124131240.GG22398@sigill.intra.peff.net>
References: <20190124131104.GA24017@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190124131104.GA24017@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We've already extracted the useful information into our text_stat
struct, so the length is no longer needed.

Signed-off-by: Jeff King <peff@peff.net>
---
 convert.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/convert.c b/convert.c
index 0d89ae7c23..dafd6db643 100644
--- a/convert.c
+++ b/convert.c
@@ -92,7 +92,7 @@ static void gather_stats(const char *buf, unsigned long size, struct text_stat *
  * The same heuristics as diff.c::mmfile_is_binary()
  * We treat files with bare CR as binary
  */
-static int convert_is_binary(unsigned long size, const struct text_stat *stats)
+static int convert_is_binary(const struct text_stat *stats)
 {
 	if (stats->lonecr)
 		return 1;
@@ -110,7 +110,7 @@ static unsigned int gather_convert_stats(const char *data, unsigned long size)
 	if (!data || !size)
 		return 0;
 	gather_stats(data, size, &stats);
-	if (convert_is_binary(size, &stats))
+	if (convert_is_binary(&stats))
 		ret |= CONVERT_STAT_BITS_BIN;
 	if (stats.crlf)
 		ret |= CONVERT_STAT_BITS_TXT_CRLF;
@@ -245,7 +245,7 @@ static int has_crlf_in_index(const struct index_state *istate, const char *path)
 	return has_crlf;
 }
 
-static int will_convert_lf_to_crlf(size_t len, struct text_stat *stats,
+static int will_convert_lf_to_crlf(struct text_stat *stats,
 				   enum crlf_action crlf_action)
 {
 	if (output_eol(crlf_action) != EOL_CRLF)
@@ -260,7 +260,7 @@ static int will_convert_lf_to_crlf(size_t len, struct text_stat *stats,
 		if (stats->lonecr || stats->crlf)
 			return 0;
 
-		if (convert_is_binary(len, stats))
+		if (convert_is_binary(stats))
 			return 0;
 	}
 	return 1;
@@ -527,7 +527,7 @@ static int crlf_to_git(const struct index_state *istate,
 	convert_crlf_into_lf = !!stats.crlf;
 
 	if (crlf_action == CRLF_AUTO || crlf_action == CRLF_AUTO_INPUT || crlf_action == CRLF_AUTO_CRLF) {
-		if (convert_is_binary(len, &stats))
+		if (convert_is_binary(&stats))
 			return 0;
 		/*
 		 * If the file in the index has any CR in it, do not
@@ -549,7 +549,7 @@ static int crlf_to_git(const struct index_state *istate,
 			new_stats.crlf = 0;
 		}
 		/* simulate "git checkout" */
-		if (will_convert_lf_to_crlf(len, &new_stats, crlf_action)) {
+		if (will_convert_lf_to_crlf(&new_stats, crlf_action)) {
 			new_stats.crlf += new_stats.lonelf;
 			new_stats.lonelf = 0;
 		}
@@ -601,7 +601,7 @@ static int crlf_to_worktree(const char *path, const char *src, size_t len,
 		return 0;
 
 	gather_stats(src, len, &stats);
-	if (!will_convert_lf_to_crlf(len, &stats, crlf_action))
+	if (!will_convert_lf_to_crlf(&stats, crlf_action))
 		return 0;
 
 	/* are we "faking" in place editing ? */
-- 
2.20.1.842.g8986705066

