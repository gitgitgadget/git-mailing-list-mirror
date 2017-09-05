Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D0FE7208E3
	for <e@80x24.org>; Tue,  5 Sep 2017 20:36:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753156AbdIEUg1 (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Sep 2017 16:36:27 -0400
Received: from cloud.peff.net ([104.130.231.41]:57808 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1753168AbdIEUgZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Sep 2017 16:36:25 -0400
Received: (qmail 1843 invoked by uid 109); 5 Sep 2017 20:36:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 05 Sep 2017 20:36:25 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16633 invoked by uid 111); 5 Sep 2017 20:36:57 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Tue, 05 Sep 2017 16:36:57 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 05 Sep 2017 16:36:23 -0400
Date:   Tue, 5 Sep 2017 16:36:23 -0400
From:   Jeff King <peff@peff.net>
To:     Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH v3 1/3] refs/files-backend: add longer-scoped copy of
 string to list
Message-ID: <20170905203622.6fs3hr7zfa7mwpqn@sigill.intra.peff.net>
References: <CAN0heSqn59sFF3A-eQ593G+ZDWnO9pKM5F=sgiSQk+prUr-nSQ@mail.gmail.com>
 <4b4c0d178ad2216eecbc49fb6f54dd8a1d1ac119.1504024261.git.martin.agren@gmail.com>
 <91e365b5-6a5d-1e1c-ab7a-579efa7c1ae8@alum.mit.edu>
 <CAN0heSqa8OnPnkd1xbyZ=QN9qg_8OaxBYnwzOZDDA3g+uGE71g@mail.gmail.com>
 <xmqq60cxcvjk.fsf@gitster.mtv.corp.google.com>
 <CAN0heSqnrPUEgP-BgvuHuVrDG2ifuHHDOPPmxiXJ73u4-PrOng@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAN0heSqnrPUEgP-BgvuHuVrDG2ifuHHDOPPmxiXJ73u4-PrOng@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 05, 2017 at 07:24:18PM +0200, Martin Ågren wrote:

> > And from that point of view, doesn't split_head_update() wants a
> > similar fix?  It attempts to insert "HEAD", makes sure it hasn't
> > been inserted and then hangs a new update transaction as its util.
> > It is not wrong per-se from purely leak-prevention point of view,
> > as that "HEAD" is a literal string we woudn't even want to free,
> > but from logical/"what each data means" point of view, it still
> > feels wrong.
> 
> There is a "Special hack" comment related to this, and I don't feel
> particularly confident that I could make any meaningful contribution in
> this area. To be honest, I don't immediately see in which direction your
> suggestion/idea/thought is going, which tells me I should not be making
> a mess out of it. :-)

I noticed the HEAD funniness, too, when looking at this earlier. I agree
with Junio that it's not quite consistent with the general rule of
"string list items point to their refnames", but I don't think it
matters in practice.

I think the fix, if we wanted to do one, would be similar to what you
did in split_symref_update(). Like:

diff --git a/refs/files-backend.c b/refs/files-backend.c
index f3455609d6..3f9deff902 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -2095,8 +2095,7 @@ static int split_head_update(struct ref_update *update,
 	 * transaction. This insertion is O(N) in the transaction
 	 * size, but it happens at most once per transaction.
 	 */
-	item = string_list_insert(affected_refnames, "HEAD");
-	if (item->util) {
+	if (string_list_has_string(affected_refnames, "HEAD")) {
 		/* An entry already existed */
 		strbuf_addf(err,
 			    "multiple updates for 'HEAD' (including one "
@@ -2111,6 +2110,7 @@ static int split_head_update(struct ref_update *update,
 			update->new_oid.hash, update->old_oid.hash,
 			update->msg);
 
+	item = string_list_insert(affected_refnames, new_update->refname);
 	item->util = new_update;
 
 	return 0;

-Peff
