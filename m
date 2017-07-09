Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7741F20357
	for <e@80x24.org>; Sun,  9 Jul 2017 10:13:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751824AbdGIKNy (ORCPT <rfc822;e@80x24.org>);
        Sun, 9 Jul 2017 06:13:54 -0400
Received: from cloud.peff.net ([104.130.231.41]:34756 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751667AbdGIKNx (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Jul 2017 06:13:53 -0400
Received: (qmail 3762 invoked by uid 109); 9 Jul 2017 10:13:53 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sun, 09 Jul 2017 10:13:53 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 32481 invoked by uid 111); 9 Jul 2017 10:14:04 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Sun, 09 Jul 2017 06:14:04 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 09 Jul 2017 06:13:51 -0400
Date:   Sun, 9 Jul 2017 06:13:51 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Kyle Meyer <kyle@kyleam.com>, git@vger.kernel.org,
        Sahil Dua <sahildua2305@gmail.com>, Eric Wong <e@80x24.org>
Subject: Re: [PATCH v2 3/7] log: do not free parents when walking reflog
Message-ID: <20170709101351.qcwgtzly72wwvwmq@sigill.intra.peff.net>
References: <20170707090507.ko2ygry7j4zv7t3s@sigill.intra.peff.net>
 <20170707090734.x2ki7lluawf66g4a@sigill.intra.peff.net>
 <xmqqwp7kb2ap.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqwp7kb2ap.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 07, 2017 at 10:10:54AM -0700, Junio C Hamano wrote:

> > diff --git a/builtin/log.c b/builtin/log.c
> > index 8ca1de9894..9c8bb3b5c3 100644
> > --- a/builtin/log.c
> > +++ b/builtin/log.c
> > @@ -374,9 +374,9 @@ static int cmd_log_walk(struct rev_info *rev)
> >  		if (!rev->reflog_info) {
> >  			/* we allow cycles in reflog ancestry */
> >  			free_commit_buffer(commit);
> > +			free_commit_list(commit->parents);
> > +			commit->parents = NULL;
> 
> After step 6/7, we no longer "allow cycles in reflog ancestry", as
> there will be no reflog ancestry to speak of ;-), so it would be
> nice to remove the comment above in that step.  But alternatively,
> we can rephrase the comment here, to say something like "the same
> commit can be shown multiple times while showing entries from the
> reflog" instead.

I actually think the comment is a bit obtuse in the first place. The
real issue is that we show commits multiple times. That's caused by
cycles, yes, but also by us clearing the SEEN flag. ;)

Maybe this on top?

-- >8 --
Subject: [PATCH] log: clarify comment about reflog cycles

When we're walking reflogs, we leave the commit buffer and
parents in place. A comment explains that this is due to
"cycles". But the interesting thing is the unsaid
implication: that the cycles (plus our clearing of the SEEN
flag) will cause us to show commits multiple times. Let's
spell it out.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/log.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/builtin/log.c b/builtin/log.c
index 9c8bb3b5c..630d6cff2 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -372,7 +372,10 @@ static int cmd_log_walk(struct rev_info *rev)
 			 */
 			rev->max_count++;
 		if (!rev->reflog_info) {
-			/* we allow cycles in reflog ancestry */
+			/*
+			 * We may show a given commit multiple times when
+			 * walking the reflogs.
+			 */
 			free_commit_buffer(commit);
 			free_commit_list(commit->parents);
 			commit->parents = NULL;
-- 
2.13.2.1066.gabaed60bd

