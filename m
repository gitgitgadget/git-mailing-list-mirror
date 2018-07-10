Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4F05C1F85A
	for <e@80x24.org>; Tue, 10 Jul 2018 20:34:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732434AbeGJUfW (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Jul 2018 16:35:22 -0400
Received: from cloud.peff.net ([104.130.231.41]:54422 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1732290AbeGJUfW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Jul 2018 16:35:22 -0400
Received: (qmail 2291 invoked by uid 109); 10 Jul 2018 20:34:40 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 10 Jul 2018 20:34:40 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31356 invoked by uid 111); 10 Jul 2018 20:34:41 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 10 Jul 2018 16:34:41 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 10 Jul 2018 16:34:38 -0400
Date:   Tue, 10 Jul 2018 16:34:38 -0400
From:   Jeff King <peff@peff.net>
To:     David Turner <novalis@novalis.org>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: git log --shortstat doesn't respect -c (but --stat does)
Message-ID: <20180710203438.GB6886@sigill.intra.peff.net>
References: <1531251974.28120.90.camel@novalis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1531251974.28120.90.camel@novalis.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 10, 2018 at 03:46:14PM -0400, David Turner wrote:

> This seems inconsistent:
> 
> $ git log --oneline --stat 91ccfb85176 -c
> 91ccfb8517 Merge branch 'sb/diff-color-move'
> 
>  diff.c                     | 28 +++++++++++++++-------------
>  t/t4015-diff-whitespace.sh |  9 +++++++++
>  2 files changed, 24 insertions(+), 13 deletions(-)
> d1114d87c7 Merge branch 'js/rebase-i-final'
> 
>  sequencer.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> ...
> 
> $ git log --oneline --shortstat 91ccfb85176 -c
> 91ccfb8517 Merge branch 'sb/diff-color-move'

Yeah. Definitely a bug.

The patch below seems to fix it, but:

  - it may need similar treatment around DIRSTAT

  - we should probably have a pre-defined mask for stat formats so it
    doesn't have to be repeated everywhere

I'm logging off for the day in a bit, but maybe somebody wants to
investigate further?

diff --git a/combine-diff.c b/combine-diff.c
index 2ef495963f..dc6183958a 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -1331,7 +1331,7 @@ static struct combine_diff_path *find_paths_generic(const struct object_id *oid,
 		 * combined diff.
 		 */
 		int stat_opt = (output_format &
-				(DIFF_FORMAT_NUMSTAT|DIFF_FORMAT_DIFFSTAT));
+				(DIFF_FORMAT_NUMSTAT|DIFF_FORMAT_DIFFSTAT|DIFF_FORMAT_SHORTSTAT));
 		if (i == 0 && stat_opt)
 			opt->output_format = stat_opt;
 		else
@@ -1459,7 +1459,7 @@ void diff_tree_combined(const struct object_id *oid,
 		 * when doing combined diff.
 		 */
 		stat_opt = (opt->output_format &
-				(DIFF_FORMAT_NUMSTAT|DIFF_FORMAT_DIFFSTAT));
+				(DIFF_FORMAT_NUMSTAT|DIFF_FORMAT_DIFFSTAT|DIFF_FORMAT_SHORTSTAT));
 		if (stat_opt) {
 			diffopts.output_format = stat_opt;
 
@@ -1504,7 +1504,7 @@ void diff_tree_combined(const struct object_id *oid,
 			needsep = 1;
 		}
 		else if (opt->output_format &
-			 (DIFF_FORMAT_NUMSTAT|DIFF_FORMAT_DIFFSTAT))
+			 (DIFF_FORMAT_NUMSTAT|DIFF_FORMAT_DIFFSTAT|DIFF_FORMAT_SHORTSTAT))
 			needsep = 1;
 		else if (opt->output_format & DIFF_FORMAT_CALLBACK)
 			handle_combined_callback(opt, paths, num_parent, num_paths);

-Peff
