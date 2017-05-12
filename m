Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9495D20188
	for <e@80x24.org>; Fri, 12 May 2017 07:59:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756557AbdELH7i (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 May 2017 03:59:38 -0400
Received: from cloud.peff.net ([104.130.231.41]:50144 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755051AbdELH7h (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 May 2017 03:59:37 -0400
Received: (qmail 31708 invoked by uid 109); 12 May 2017 07:59:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 12 May 2017 07:59:33 +0000
Received: (qmail 21995 invoked by uid 111); 12 May 2017 08:00:05 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 12 May 2017 04:00:05 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 12 May 2017 03:59:31 -0400
Date:   Fri, 12 May 2017 03:59:31 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
Subject: Re: [PATCH v5] fetch-pack: always allow fetching of literal SHA1s
Message-ID: <20170512075931.umunxd72nj53snds@sigill.intra.peff.net>
References: <20170509182042.28389-1-jonathantanmy@google.com>
 <20170511223054.25239-1-jonathantanmy@google.com>
 <20170511224639.GC21723@aiede.svl.corp.google.com>
 <xmqq37ca7gw0.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq37ca7gw0.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 12, 2017 at 03:01:35PM +0900, Junio C Hamano wrote:

> Jonathan Nieder <jrnieder@gmail.com> writes:
> 
> >> +static void add_refs_to_oidset(struct oidset *oids, struct ref *refs)
> >> +{
> >> +	for (; refs; refs = refs->next)
> >> +		oidset_insert(oids, &refs->old_oid);
> >> +}
> >> +
> >> +static int tip_oids_contain(struct oidset *tip_oids,
> >> +			    struct ref *unmatched, struct ref *newlist,
> >> +			    const struct object_id *id)
> >> +{
> >> +	if (!tip_oids->map.cmpfn) {
> >
> > This feels like a layering violation.  Could it be e.g. a static inline
> > function oidset_is_initialized in oidset.h?
> 
> Surely it does.
> 
> Also, tip_oids_contain() uses unmatched and newlist only on the
> first call, but the internal API this patch establishes gives an
> illusion (confusion) that updating unmatched and newlist while
> making repeated to calls to this function may affect the outcome of
> tip_oids_contain() function.  In fact, doesn't the loop that calls
> this function extend "newlist" by extending the list at its tail?

It does, but only with elements whose oids were already in the set. So I
don't think it's wrong, but I agree the interface makes it a bit muddy.

The whole thing is much easier to follow if you just create the oidset
before chopping it up into two lists. But that loses the "lazy"
property, and you pay for the oidset even if there are no raw sha1s
requested. But it is nice and short. See the patch below (as a
replacement for what we've been discussing, not on top).

It's hard to resolve that because the loop that chops up the lists is
also the loop that is figuring out if there are leftover raw-sha1
names. But you could probably structure it like:

  1. Loop and see if we have unmatched names that look like sha1s.

  2. Set up the oidset from the two chopped-up lists if there are
     sha1 candidates (and if we aren't going to just send them
     regardless due to server options).

  3. Loop over the unmatched candidates and check them against the
     oidset.

That avoids the lazy-init, so pulling (2) out into a function results in
a better interface.

---
diff --git a/fetch-pack.c b/fetch-pack.c
index afb8b0502..4f3e8fa6b 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -15,6 +15,7 @@
 #include "version.h"
 #include "prio-queue.h"
 #include "sha1-array.h"
+#include "oidset.h"
 
 static int transfer_unpack_limit = -1;
 static int fetch_unpack_limit = -1;
@@ -599,6 +600,9 @@ static void filter_refs(struct fetch_pack_args *args,
 	struct ref *newlist = NULL;
 	struct ref **newtail = &newlist;
 	struct ref *ref, *next;
+	struct oidset tip_oids = OIDSET_INIT;
+	int send_raw_oids = (allow_unadvertised_object_request &
+			     (ALLOW_TIP_SHA1 | ALLOW_REACHABLE_SHA1));
 	int i;
 
 	i = 0;
@@ -626,6 +630,9 @@ static void filter_refs(struct fetch_pack_args *args,
 		    (!args->deepen || !starts_with(ref->name, "refs/tags/")))
 			keep = 1;
 
+		if (!send_raw_oids)
+			oidset_insert(&tip_oids, &ref->old_oid);
+
 		if (keep) {
 			*newtail = ref;
 			ref->next = NULL;
@@ -647,8 +654,7 @@ static void filter_refs(struct fetch_pack_args *args,
 		    hashcmp(sha1, ref->old_oid.hash))
 			continue;
 
-		if ((allow_unadvertised_object_request &
-		    (ALLOW_TIP_SHA1 | ALLOW_REACHABLE_SHA1))) {
+		if (send_raw_oids || oidset_contains(&tip_oids, &ref->old_oid)) {
 			ref->match_status = REF_MATCHED;
 			*newtail = copy_ref(ref);
 			newtail = &(*newtail)->next;
@@ -657,6 +663,8 @@ static void filter_refs(struct fetch_pack_args *args,
 		}
 	}
 	*refs = newlist;
+
+	oidset_clear(&tip_oids);
 }
 
 static void mark_alternate_complete(struct object *obj)
