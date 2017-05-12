Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 55EB720188
	for <e@80x24.org>; Fri, 12 May 2017 08:14:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752111AbdELIOY (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 May 2017 04:14:24 -0400
Received: from cloud.peff.net ([104.130.231.41]:50176 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750713AbdELIOV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 May 2017 04:14:21 -0400
Received: (qmail 32596 invoked by uid 109); 12 May 2017 08:14:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 12 May 2017 08:14:19 +0000
Received: (qmail 22074 invoked by uid 111); 12 May 2017 08:14:51 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 12 May 2017 04:14:51 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 12 May 2017 04:14:17 -0400
Date:   Fri, 12 May 2017 04:14:17 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
Subject: Re: [PATCH v5] fetch-pack: always allow fetching of literal SHA1s
Message-ID: <20170512081417.w537fmd4o5rl4kja@sigill.intra.peff.net>
References: <20170509182042.28389-1-jonathantanmy@google.com>
 <20170511223054.25239-1-jonathantanmy@google.com>
 <20170511224639.GC21723@aiede.svl.corp.google.com>
 <xmqq37ca7gw0.fsf@gitster.mtv.corp.google.com>
 <20170512075931.umunxd72nj53snds@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170512075931.umunxd72nj53snds@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 12, 2017 at 03:59:31AM -0400, Jeff King wrote:

> It's hard to resolve that because the loop that chops up the lists is
> also the loop that is figuring out if there are leftover raw-sha1
> names. But you could probably structure it like:
> 
>   1. Loop and see if we have unmatched names that look like sha1s.
> 
>   2. Set up the oidset from the two chopped-up lists if there are
>      sha1 candidates (and if we aren't going to just send them
>      regardless due to server options).
> 
>   3. Loop over the unmatched candidates and check them against the
>      oidset.
> 
> That avoids the lazy-init, so pulling (2) out into a function results in
> a better interface.

Here that is for reference. It's a bit more complex than the other
solutions, requiring the unmatched list, the is_literal_sha1() helper,
and the oidset. But it avoids any extra allocation when it isn't
necessary, and drops the laziness.

I mostly did this to give the discussion something concrete to look at.
I'm actually OK with any of the options so far, as long as it does not
have any quadratic behavior. :)

diff --git a/fetch-pack.c b/fetch-pack.c
index afb8b0502..e167213c0 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -15,6 +15,7 @@
 #include "version.h"
 #include "prio-queue.h"
 #include "sha1-array.h"
+#include "oidset.h"
 
 static int transfer_unpack_limit = -1;
 static int fetch_unpack_limit = -1;
@@ -592,13 +593,27 @@ static void mark_recent_complete_commits(struct fetch_pack_args *args,
 	}
 }
 
+static int is_literal_sha1(const struct ref *ref)
+{
+	struct object_id oid;
+	const char *end;
+	return !parse_oid_hex(ref->name, &oid, &end) &&
+	       !*end &&
+	       !oidcmp(&oid, &ref->old_oid);
+}
+
 static void filter_refs(struct fetch_pack_args *args,
 			struct ref **refs,
 			struct ref **sought, int nr_sought)
 {
 	struct ref *newlist = NULL;
 	struct ref **newtail = &newlist;
+	struct ref *unmatched = NULL;
 	struct ref *ref, *next;
+	struct oidset tip_oids = OIDSET_INIT;
+	int send_raw_oids = (allow_unadvertised_object_request &
+			     (ALLOW_TIP_SHA1 | ALLOW_REACHABLE_SHA1));
+	int seeking_raw_oid = 0;
 	int i;
 
 	i = 0;
@@ -617,7 +632,8 @@ static void filter_refs(struct fetch_pack_args *args,
 				else if (cmp == 0) {
 					keep = 1; /* definitely have it */
 					sought[i]->match_status = REF_MATCHED;
-				}
+				} else if (is_literal_sha1(sought[i]))
+					seeking_raw_oid = 1;
 				i++;
 			}
 		}
@@ -631,24 +647,27 @@ static void filter_refs(struct fetch_pack_args *args,
 			ref->next = NULL;
 			newtail = &ref->next;
 		} else {
-			free(ref);
+			ref->next = unmatched;
+			unmatched = ref;
 		}
 	}
 
+	if (seeking_raw_oid && !send_raw_oids) {
+		for (ref = newlist; ref; ref = ref->next)
+			oidset_insert(&tip_oids, &ref->old_oid);
+		for (ref = unmatched; ref; ref = ref->next)
+			oidset_insert(&tip_oids, &ref->old_oid);
+	}
+
 	/* Append unmatched requests to the list */
 	for (i = 0; i < nr_sought; i++) {
-		unsigned char sha1[20];
-
 		ref = sought[i];
 		if (ref->match_status != REF_NOT_MATCHED)
 			continue;
-		if (get_sha1_hex(ref->name, sha1) ||
-		    ref->name[40] != '\0' ||
-		    hashcmp(sha1, ref->old_oid.hash))
+		if (!is_literal_sha1(ref))
 			continue;
 
-		if ((allow_unadvertised_object_request &
-		    (ALLOW_TIP_SHA1 | ALLOW_REACHABLE_SHA1))) {
+		if (send_raw_oids || oidset_contains(&tip_oids, &ref->old_oid)) {
 			ref->match_status = REF_MATCHED;
 			*newtail = copy_ref(ref);
 			newtail = &(*newtail)->next;
@@ -656,6 +675,13 @@ static void filter_refs(struct fetch_pack_args *args,
 			ref->match_status = REF_UNADVERTISED_NOT_ALLOWED;
 		}
 	}
+
+	oidset_clear(&tip_oids);
+	for (ref = unmatched; ref; ref = next) {
+		next = ref->next;
+		free(ref);
+	}
+
 	*refs = newlist;
 }
 
