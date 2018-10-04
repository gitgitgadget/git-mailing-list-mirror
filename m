Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E9CF11F453
	for <e@80x24.org>; Thu,  4 Oct 2018 06:50:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727269AbeJDNmR (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 Oct 2018 09:42:17 -0400
Received: from cloud.peff.net ([104.130.231.41]:41062 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726899AbeJDNmR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Oct 2018 09:42:17 -0400
Received: (qmail 3051 invoked by uid 109); 4 Oct 2018 06:50:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 04 Oct 2018 06:50:32 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22861 invoked by uid 111); 4 Oct 2018 06:49:52 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 04 Oct 2018 02:49:52 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 04 Oct 2018 02:50:30 -0400
Date:   Thu, 4 Oct 2018 02:50:30 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/2] oidset: use khash
Message-ID: <20181004065030.GA15613@sigill.intra.peff.net>
References: <64911aec-71cd-d990-5dfd-bf2c3163690c@web.de>
 <5efe6695-2e82-786c-1170-7874978cb534@web.de>
 <20181003194051.GB20709@sigill.intra.peff.net>
 <d17f104e-7cc2-5e73-78c9-6c268f9ec5b2@web.de>
 <20181004064833.GA9051@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181004064833.GA9051@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 04, 2018 at 02:48:33AM -0400, Jeff King wrote:

> On Thu, Oct 04, 2018 at 07:56:44AM +0200, René Scharfe wrote:
> 
> > > As the comment above notes, I think we're really looking at the case
> > > where this gets populated on the first call, but not subsequent ones. It
> > > might be less hacky to use a "static int initialized" here. Or if we
> > > want to avoid hidden globals, put the logic into filter_refs() to decide
> > > when to populate.
> > 
> > Right.  I'd prefer the latter, but was unable to find a nice way that
> > still populates the oidset lazily.  It's certainly worth another look,
> > and a separate series.
> 
> It's a little awkward because the lazy load happens in a conditional.
> You can fully encapsulate it like the patch below, but I actually don't
> think it's really helping readability.

I forgot the patch, of course. ;)

I'm not really proposing this, just illustrating one direction (that I
think is kind of ugly). Notably it doesn't get rid of the tricky comment
in tip_oids_contain(), because that is explaining why the single load
works even on a list we're still adding to.

diff --git a/fetch-pack.c b/fetch-pack.c
index a839315726..a6212c8758 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -526,8 +526,14 @@ static void add_refs_to_oidset(struct oidset *oids, struct ref *refs)
 		oidset_insert(oids, &refs->old_oid);
 }
 
-static int tip_oids_contain(struct oidset *tip_oids,
-			    struct ref *unmatched, struct ref *newlist,
+struct lazy_tip_oids {
+	int loaded;
+	struct oidset oids;
+	struct ref *unmatched;
+	struct ref *newlist;
+};
+
+static int tip_oids_contain(struct lazy_tip_oids *tip_oids,
 			    const struct object_id *id)
 {
 	/*
@@ -536,11 +542,12 @@ static int tip_oids_contain(struct oidset *tip_oids,
 	 * add to "newlist" between calls, the additions will always be for
 	 * oids that are already in the set.
 	 */
-	if (!tip_oids->set.n_buckets) {
-		add_refs_to_oidset(tip_oids, unmatched);
-		add_refs_to_oidset(tip_oids, newlist);
+	if (!tip_oids->loaded) {
+		add_refs_to_oidset(&tip_oids->oids, tip_oids->unmatched);
+		add_refs_to_oidset(&tip_oids->oids, tip_oids->newlist);
+		tip_oids->loaded = 1;
 	}
-	return oidset_contains(tip_oids, id);
+	return oidset_contains(&tip_oids->oids, id);
 }
 
 static void filter_refs(struct fetch_pack_args *args,
@@ -551,7 +558,7 @@ static void filter_refs(struct fetch_pack_args *args,
 	struct ref **newtail = &newlist;
 	struct ref *unmatched = NULL;
 	struct ref *ref, *next;
-	struct oidset tip_oids = OIDSET_INIT;
+	struct lazy_tip_oids tip_oids = { 0 };
 	int i;
 
 	i = 0;
@@ -589,6 +596,9 @@ static void filter_refs(struct fetch_pack_args *args,
 		}
 	}
 
+	tip_oids.unmatched = unmatched;
+	tip_oids.newlist = newlist;
+
 	/* Append unmatched requests to the list */
 	for (i = 0; i < nr_sought; i++) {
 		struct object_id oid;
@@ -604,8 +614,7 @@ static void filter_refs(struct fetch_pack_args *args,
 
 		if ((allow_unadvertised_object_request &
 		     (ALLOW_TIP_SHA1 | ALLOW_REACHABLE_SHA1)) ||
-		    tip_oids_contain(&tip_oids, unmatched, newlist,
-				     &ref->old_oid)) {
+		    tip_oids_contain(&tip_oids, &ref->old_oid)) {
 			ref->match_status = REF_MATCHED;
 			*newtail = copy_ref(ref);
 			newtail = &(*newtail)->next;
@@ -614,7 +623,7 @@ static void filter_refs(struct fetch_pack_args *args,
 		}
 	}
 
-	oidset_clear(&tip_oids);
+	oidset_clear(&tip_oids.oids);
 	for (ref = unmatched; ref; ref = next) {
 		next = ref->next;
 		free(ref);
