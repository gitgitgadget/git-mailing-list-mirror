Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0D45B1F576
	for <e@80x24.org>; Wed, 28 Feb 2018 06:37:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751003AbeB1GhK (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Feb 2018 01:37:10 -0500
Received: from cloud.peff.net ([104.130.231.41]:40262 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750756AbeB1GhJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Feb 2018 01:37:09 -0500
Received: (qmail 6054 invoked by uid 109); 28 Feb 2018 06:37:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 28 Feb 2018 06:37:10 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 32017 invoked by uid 111); 28 Feb 2018 06:37:58 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 28 Feb 2018 01:37:58 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 28 Feb 2018 01:37:07 -0500
Date:   Wed, 28 Feb 2018 01:37:07 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee <dstolee@microsoft.com>, git@vger.kernel.org
Subject: Re: [PATCH] revision.c: reduce object database queries
Message-ID: <20180228063707.GA4409@sigill.intra.peff.net>
References: <1519522496-73090-1-git-send-email-dstolee@microsoft.com>
 <20180226013048.GA8677@sigill.intra.peff.net>
 <20180226013822.GA9385@sigill.intra.peff.net>
 <xmqqefl6nhud.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqefl6nhud.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 27, 2018 at 03:16:58PM -0800, Junio C Hamano wrote:

> >> This code comes originally form 454fbbcde3 (git-rev-list: allow missing
> >> objects when the parent is marked UNINTERESTING, 2005-07-10). But later,
> >> in aeeae1b771 (revision traversal: allow UNINTERESTING objects to be
> >> missing, 2009-01-27), we marked dealt with calling parse_object() on the
> >> parents more directly.
> >>
> >> So what I wonder is whether this code is simply redundant and can go
> >> away entirely. That would save the has_object_file() call in all cases.
> 
> Hmm, interesting. I forgot all what I did around this area, but you
> are right.

I'll leave it to Stolee whether he wants to dig into removing the
has_object_file() call. I think it would do the right thing, but the
most interesting bit would be how it impacts the timings.

> > There's a similar case for trees. ...
> > though technically the existing code allows _missing_ trees, but
> > not on corrupt ones.
> 
> True, but the intention of these "do not care too much about missing
> stuff while marking uninteresting" effort is aligned better with
> ignoring corrupt ones, too, I would think, as "missing" in that
> sentence is in fact about "not availble", and stuff that exists in
> corrupt form is still not available anyway.  So I do not think it
> makes a bad change to start allowing corrupt ones.

Agreed. Here it is in patch form, though as we both said, it probably
doesn't matter that much in practice. So I'd be OK dropping it out of
a sense of conservatism.

-- >8 --
Subject: [PATCH] mark_tree_contents_uninteresting: drop has_object check

It's generally acceptable for UNINTERESTING objects in a
traversal to be unavailable (e.g., see aeeae1b771). When
marking trees UNINTERESTING, we access the object database
twice: once to check if the object is missing (and return
quietly if it is), and then again to actually parse it.

We can instead just try to parse; if that fails, we can then
return quietly. That halves the effort we spend on locating
the object.

Note that this isn't _exactly_ the same as the original
behavior, as the parse failure could be due to other
problems than a missing object: it could be corrupted, in
which case the original code would have died. But the new
behavior is arguably better, as it covers the object being
unavailable for any reason. We'll also still issue a warning
to stderr in such a case.

Signed-off-by: Jeff King <peff@peff.net>
---
 revision.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/revision.c b/revision.c
index 5ce9b93baa..221d62c52b 100644
--- a/revision.c
+++ b/revision.c
@@ -51,12 +51,9 @@ static void mark_tree_contents_uninteresting(struct tree *tree)
 {
 	struct tree_desc desc;
 	struct name_entry entry;
-	struct object *obj = &tree->object;
 
-	if (!has_object_file(&obj->oid))
+	if (parse_tree_gently(tree, 1) < 0)
 		return;
-	if (parse_tree(tree) < 0)
-		die("bad tree %s", oid_to_hex(&obj->oid));
 
 	init_tree_desc(&desc, tree->buffer, tree->size);
 	while (tree_entry(&desc, &entry)) {
-- 
2.16.2.582.ge2c16ac3c4

