Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D613E1F461
	for <e@80x24.org>; Fri, 28 Jun 2019 06:25:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726827AbfF1GZA (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Jun 2019 02:25:00 -0400
Received: from cloud.peff.net ([104.130.231.41]:53580 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726574AbfF1GY7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Jun 2019 02:24:59 -0400
Received: (qmail 13466 invoked by uid 109); 28 Jun 2019 06:25:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 28 Jun 2019 06:25:00 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14947 invoked by uid 111); 28 Jun 2019 06:25:51 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 28 Jun 2019 02:25:51 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 28 Jun 2019 02:24:57 -0400
Date:   Fri, 28 Jun 2019 02:24:57 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Barret Rhoden <brho@google.com>, git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jun 2019, #06; Wed, 26)
Message-ID: <20190628062457.GA18662@sigill.intra.peff.net>
References: <xmqq36jwc75i.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq36jwc75i.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 26, 2019 at 03:29:29PM -0700, Junio C Hamano wrote:

> * br/blame-ignore (2019-06-20) 9 commits
>  - blame: add a test to cover blame_coalesce()
>  - blame: use the fingerprint heuristic to match ignored lines
>  - blame: add a fingerprint heuristic to match ignored lines
>  - blame: optionally track line fingerprints during fill_blame_origin()
>  - blame: add config options for the output of ignored or unblamable lines
>  - blame: add the ability to ignore commits and their changes
>  - blame: use a helper function in blame_chunk()
>  - Move oidset_parse_file() to oidset.c
>  - fsck: rename and touch up init_skiplist()
> 
>  "git blame" learned to "ignore" commits in the history, whose
>  effects (as well as their presence) get ignored.
> 
>  Will merge to 'next'.
>  cf. <20190620163820.231316-1-brho@google.com> (v9)

My -Wunused-parameter branch complained about merging with this. Since
it's in 'next', we'd want something like this on top, I think (ideally
after Barret confirms my hand-waving below).

-- >8 --
Subject: [PATCH] blame: drop some unused function parameters

These unused parameters were introduced recently as part of the
br/blame-ignore topic. I assume they are not indicative of bugs, but are
just leftovers from the development process (they were introduced by the
series but not used in any of its iterations).

Signed-off-by: Jeff King <peff@peff.net>
---
 blame.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/blame.c b/blame.c
index 86f6b2bd33..acb1bf7f7a 100644
--- a/blame.c
+++ b/blame.c
@@ -981,7 +981,7 @@ static int *fuzzy_find_matching_lines(struct blame_origin *parent,
 	return result;
 }
 
-static void fill_origin_fingerprints(struct blame_origin *o, mmfile_t *file)
+static void fill_origin_fingerprints(struct blame_origin *o)
 {
 	int *line_starts;
 
@@ -1035,7 +1035,7 @@ static void fill_origin_blob(struct diff_options *opt,
 	else
 		*file = o->file;
 	if (fill_fingerprints)
-		fill_origin_fingerprints(o, file);
+		fill_origin_fingerprints(o);
 }
 
 static void drop_origin_blob(struct blame_origin *o)
@@ -1653,7 +1653,6 @@ static void guess_line_blames(struct blame_origin *parent,
  */
 static void ignore_blame_entry(struct blame_entry *e,
 			       struct blame_origin *parent,
-			       struct blame_origin *target,
 			       struct blame_entry **diffp,
 			       struct blame_entry **ignoredp,
 			       struct blame_line_tracker *line_blames)
@@ -1802,7 +1801,7 @@ static void blame_chunk(struct blame_entry ***dstq, struct blame_entry ***srcq,
 			samep = n;
 		}
 		if (ignore_diffs) {
-			ignore_blame_entry(e, parent, target, &diffp, &ignoredp,
+			ignore_blame_entry(e, parent, &diffp, &ignoredp,
 					   line_blames + e->s_lno - tlno);
 		} else {
 			e->next = diffp;
-- 
2.22.0.761.gd0932b09c9

