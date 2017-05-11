Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 01E41201A0
	for <e@80x24.org>; Thu, 11 May 2017 20:52:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755817AbdEKUwS (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 May 2017 16:52:18 -0400
Received: from cloud.peff.net ([104.130.231.41]:49890 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755197AbdEKUwR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 May 2017 16:52:17 -0400
Received: (qmail 17199 invoked by uid 109); 11 May 2017 20:52:16 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 11 May 2017 20:52:16 +0000
Received: (qmail 18762 invoked by uid 111); 11 May 2017 20:52:47 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 11 May 2017 16:52:47 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 11 May 2017 16:52:14 -0400
Date:   Thu, 11 May 2017 16:52:14 -0400
From:   Jeff King <peff@peff.net>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, jrnieder@gmail.com, spearce@spearce.org
Subject: Re: [PATCH v3] fetch-pack: always allow fetching of literal SHA1s
Message-ID: <20170511205214.ofwkqogksohs6s4b@sigill.intra.peff.net>
References: <20170509182042.28389-1-jonathantanmy@google.com>
 <20170510221157.8971-1-jonathantanmy@google.com>
 <20170511094635.ljpwg3bxkqj2wmgc@sigill.intra.peff.net>
 <695d833e-9ef1-4d74-265e-f5e3af8a54cd@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <695d833e-9ef1-4d74-265e-f5e3af8a54cd@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 11, 2017 at 10:51:37AM -0700, Jonathan Tan wrote:

> > This is inside the nr_sought loop. So if I were to do:
> > 
> >   git fetch origin $(git ls-remote origin | awk '{print $1}')
> > 
> > we're back to being quadratic. I realize that's probably a silly thing
> > to do, but in the general case, you're O(m*n), where "n" is number of
> > unmatched remote refs and "m" is the number of SHA-1s you're looking
> > for.
> 
> The original patch was quadratic regardless of whether we're fetching names
> or SHA-1s, which can be said to be bad since it is a regression in an
> existing and common use case (and I agree). This one is O(m*n), as you said
> - the "quadratic-ness" only kicks in if you fetch SHA-1s, which before this
> patch is impossible.

Yeah, no question this is an improvement over the original. I think this
still "regresses" a certain request performance-wise, but it's a request
that could never have succeeded in the original. Mostly I'd just rather
not leave a hidden quadratic loop that will blow up in somebody's face
a year or two down the road.

> Having a sha1_array or oidset would require allocation (O(n log n) time, I
> think, in addition to O(n) space) and this cost would be incurred regardless
> of how many SHA-1s were actually fetched (if m is an order of magnitude less
> than log n, for example, having a sha1_array might be actually worse). Also,
> presumably we don't want to incur this cost if we are fetching zero SHA-1s,
> so we would need to do some sort of pre-check. I'm inclined to leave it the
> way it is and consider this only if the use case of fetching many SHA1-s
> comes up.

An oidset should be O(n) in both time and space. Which we're already
spending in the earlier loop (and in general, when we allocate O(n) ref
structs in the first place). I don't think we need to care too much
about micro-optimizing bumps to the constant-factor here; we just need
to make sure we don't end up in an algorithmic explosion.

And if we initialize the oidset lazily, then we incur that cost only
when we would be doing the linear walk in your patch anyway. See the
patch below.

> > AIUI, you could also avoid creating the unmatched list entirely when the
> > server advertises tip/reachable sha1s. That's a small optimization, but
> > I think it may actually make the logic clearer.
> 
> If you mean adding an "if" block at the point where we add the unmatched ref
> to the unmatched list (that either adds it to the list or immediately frees
> it), I think it makes the logic slightly more complicated. Or maybe you had
> something else in mind?

I was just thinking that it does not leave a case where we create a
data structure (the unmatched list) even though we know right then that
it will not ever be used. So it's an extra line of logic there, but the
overall function may be clearer. I dunno, it's probably not a big deal
either way.

-Peff

---
diff --git a/fetch-pack.c b/fetch-pack.c
index 5cace7458..a660331e6 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -15,6 +15,7 @@
 #include "version.h"
 #include "prio-queue.h"
 #include "sha1-array.h"
+#include "oidset.h"
 
 static int transfer_unpack_limit = -1;
 static int fetch_unpack_limit = -1;
@@ -592,6 +593,12 @@ static void mark_recent_complete_commits(struct fetch_pack_args *args,
 	}
 }
 
+static void add_refs_to_oidset(struct oidset *oids, const struct ref *refs)
+{
+	for (; refs; refs = refs->next)
+		oidset_insert(oids, &refs->old_oid);
+}
+
 static void filter_refs(struct fetch_pack_args *args,
 			struct ref **refs,
 			struct ref **sought, int nr_sought)
@@ -600,6 +607,8 @@ static void filter_refs(struct fetch_pack_args *args,
 	struct ref **newtail = &newlist;
 	struct ref *unmatched = NULL;
 	struct ref *ref, *next;
+	struct oidset tip_oids = OIDSET_INIT;
+	int tip_oids_initialized = 0;
 	int i;
 
 	i = 0;
@@ -654,22 +663,15 @@ static void filter_refs(struct fetch_pack_args *args,
 		    (ALLOW_TIP_SHA1 | ALLOW_REACHABLE_SHA1))) {
 			can_append = 1;
 		} else {
-			struct ref *u;
-			/* Check all refs, including those already matched */
-			for (u = unmatched; u; u = u->next) {
-				if (!oidcmp(&ref->old_oid, &u->old_oid)) {
-					can_append = 1;
-					goto can_append;
-				}
-			}
-			for (u = newlist; u; u = u->next) {
-				if (!oidcmp(&ref->old_oid, &u->old_oid)) {
-					can_append = 1;
-					break;
-				}
+			if (!tip_oids_initialized) {
+				/* Check all refs, including those already matched */
+				add_refs_to_oidset(&tip_oids, unmatched);
+				add_refs_to_oidset(&tip_oids, newlist);
+				tip_oids_initialized = 1;
 			}
+			can_append = oidset_contains(&tip_oids, &ref->old_oid);
 		}
-can_append:
+
 		if (can_append) {
 			ref->match_status = REF_MATCHED;
 			*newtail = copy_ref(ref);
@@ -680,6 +682,7 @@ static void filter_refs(struct fetch_pack_args *args,
 	}
 	*refs = newlist;
 
+	oidset_clear(&tip_oids);
 	for (ref = unmatched; ref; ref = next) {
 		next = ref->next;
 		free(ref);
