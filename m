Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DCF5C1F404
	for <e@80x24.org>; Wed, 12 Sep 2018 04:29:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725966AbeILJcT (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Sep 2018 05:32:19 -0400
Received: from cloud.peff.net ([104.130.231.41]:46670 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725740AbeILJcT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Sep 2018 05:32:19 -0400
Received: (qmail 6159 invoked by uid 109); 12 Sep 2018 04:29:42 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 12 Sep 2018 04:29:42 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24015 invoked by uid 111); 12 Sep 2018 04:29:54 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 12 Sep 2018 00:29:54 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 12 Sep 2018 00:29:39 -0400
Date:   Wed, 12 Sep 2018 00:29:39 -0400
From:   Jeff King <peff@peff.net>
To:     Derrick Stolee <dstolee@microsoft.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "sbeller@google.com" <sbeller@google.com>,
        "stolee@gmail.com" <stolee@gmail.com>,
        "jonathantanmy@google.com" <jonathantanmy@google.com>,
        "gitster@pobox.com" <gitster@pobox.com>
Subject: Re: [PATCH v2 17/18] commit-reach: make can_all_from_reach... linear
Message-ID: <20180912042938.GA15876@sigill.intra.peff.net>
References: <pull.10.git.gitgitgadget@gmail.com>
 <20180720163227.105950-1-dstolee@microsoft.com>
 <20180720163227.105950-18-dstolee@microsoft.com>
 <20180912041425.GA10472@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180912041425.GA10472@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 12, 2018 at 12:14:25AM -0400, Jeff King wrote:

> > +	ALLOC_ARRAY(list, from->nr);
> >  	for (i = 0; i < from->nr; i++) {
> > -		struct object *from_one = from->objects[i].item;
> > +		list[i] = (struct commit *)from->objects[i].item;
> 
> Some of the objects in my array are not commits, but rather tags, so
> this is a bogus cast.
> 
> You can see that the original code peeled them and threw away
> non-commits:
> 
> >  
> > -		if (from_one->flags & assign_flag)
> > -			continue;
> > -		from_one = deref_tag(the_repository, from_one, "a from object", 0);
> > -		if (!from_one || from_one->type != OBJ_COMMIT) {
> > -			/* no way to tell if this is reachable by
> > -			 * looking at the ancestry chain alone, so
> > -			 * leave a note to ourselves not to worry about
> > -			 * this object anymore.
> > -			 */
> > -			from->objects[i].item->flags |= assign_flag;
> > -			continue;
> > -		}
> 
> So presumably we'd need to do something similar.

This patch seems to fix it for me. It's more or less a reversion of the
hunk above, though I didn't dig into whether I'm violating some other
assumption in your new code.

I think this function leaks "list" both from the location I noted here,
as well as from normal exit

---
 commit-reach.c | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/commit-reach.c b/commit-reach.c
index 622eeb313d..abe90a2f55 100644
--- a/commit-reach.c
+++ b/commit-reach.c
@@ -547,20 +547,31 @@ int can_all_from_reach_with_flag(struct object_array *from,
 {
 	struct commit **list = NULL;
 	int i;
+	int nr_commits;
 	int result = 1;
 
 	ALLOC_ARRAY(list, from->nr);
+	nr_commits = 0;
 	for (i = 0; i < from->nr; i++) {
-		list[i] = (struct commit *)from->objects[i].item;
+		struct object *from_one = from->objects[i].item;
 
-		if (parse_commit(list[i]) ||
-		    list[i]->generation < min_generation)
-			return 0;
+		from_one = deref_tag(the_repository, from_one,
+				     "a from object", 0);
+		if (!from_one || from_one->type != OBJ_COMMIT) {
+			from->objects[i].item->flags |= assign_flag;
+			continue;
+		}
+
+		list[nr_commits] = (struct commit *)from_one;
+		if (parse_commit(list[nr_commits]) ||
+		    list[nr_commits]->generation < min_generation)
+			return 0; /* is this a leak? */
+		nr_commits++;
 	}
 
-	QSORT(list, from->nr, compare_commits_by_gen);
+	QSORT(list, nr_commits, compare_commits_by_gen);
 
-	for (i = 0; i < from->nr; i++) {
+	for (i = 0; i < nr_commits; i++) {
 		/* DFS from list[i] */
 		struct commit_list *stack = NULL;
 
@@ -603,7 +614,7 @@ int can_all_from_reach_with_flag(struct object_array *from,
 	}
 
 cleanup:
-	for (i = 0; i < from->nr; i++) {
+	for (i = 0; i < nr_commits; i++) {
 		clear_commit_marks(list[i], RESULT);
 		clear_commit_marks(list[i], assign_flag);
 	}
-- 
2.19.0.600.ga229f7d059

