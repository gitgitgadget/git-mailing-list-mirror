Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0FE6EB64D9
	for <git@archiver.kernel.org>; Sun,  2 Jul 2023 22:35:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230018AbjGBWfn (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 2 Jul 2023 18:35:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbjGBWfm (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 2 Jul 2023 18:35:42 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2AF2E49
        for <git@vger.kernel.org>; Sun,  2 Jul 2023 15:35:41 -0700 (PDT)
Received: (qmail 17856 invoked by uid 109); 2 Jul 2023 22:35:41 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 02 Jul 2023 22:35:41 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16702 invoked by uid 111); 2 Jul 2023 22:35:43 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 02 Jul 2023 18:35:43 -0400
Authentication-Results: peff.net; auth=none
Date:   Sun, 2 Jul 2023 18:35:40 -0400
From:   Jeff King <peff@peff.net>
To:     Jan =?utf-8?Q?Kl=C3=B6tzke?= <jan@kloetzke.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Steve Kemp <steve@steve.org.uk>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        Stefan Beller <stefanbeller@gmail.com>
Subject: [PATCH 1/3] ref-filter: avoid parsing tagged objects in
 match_points_at()
Message-ID: <20230702223540.GA3494279@coredump.intra.peff.net>
References: <20230702223342.GA1598765@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230702223342.GA1598765@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When we peel tags to check if they match a --points-at oid, we
recursively parse the tagged object to see if it is also a tag. But
since the tag itself tells us the type of the object it points to (and
even gives us the appropriate object struct via its "tagged" member), we
can use that directly.

We do still have to make sure to call parse_tag() before looking at each
tag. This is redundant for the outermost tag (since we did call
parse_object() to find its type), but that's OK; parse_tag() is smart
enough to make this a noop when the tag has already been parsed.

In my clone of linux.git, with 782 tags (and only 3 non-tags), this
yields a significant speedup (bringing us back where we were before the
commit before this one started recursively dereferencing tags):

  Benchmark 1: ./git.old for-each-ref --points-at=HEAD --format="%(refname)"
    Time (mean ± σ):      20.3 ms ±   0.5 ms    [User: 11.1 ms, System: 9.1 ms]
    Range (min … max):    19.6 ms …  21.5 ms    141 runs

  Benchmark 2: ./git.new for-each-ref --points-at=HEAD --format="%(refname)"
    Time (mean ± σ):      11.4 ms ±   0.2 ms    [User: 6.3 ms, System: 5.0 ms]
    Range (min … max):    11.0 ms …  12.2 ms    250 runs

  Summary
    './git.new for-each-ref --points-at=HEAD --format="%(refname)"' ran
      1.79 ± 0.05 times faster than './git.old for-each-ref --points-at=HEAD --format="%(refname)"'

Signed-off-by: Jeff King <peff@peff.net>
---
This could optionally be squashed into the original. If we leave it as
its own patch, it might be worth replacing "the commit before this one"
with the actual oid (once Junio has picked it up and it's stable).

 ref-filter.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index ad7f244414..e091f056ab 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -2225,10 +2225,18 @@ static const struct object_id *match_points_at(struct oid_array *points_at,
 		return oid;
 	obj = parse_object(the_repository, oid);
 	while (obj && obj->type == OBJ_TAG) {
-		oid = get_tagged_oid((struct tag *)obj);
+		struct tag *tag = (struct tag *)obj;
+
+		if (parse_tag(tag) < 0) {
+			obj = NULL;
+			break;
+		}
+
+		oid = get_tagged_oid(tag);
 		if (oid_array_lookup(points_at, oid) >= 0)
 			return oid;
-		obj = parse_object(the_repository, oid);
+
+		obj = tag->tagged;
 	}
 	if (!obj)
 		die(_("malformed object at '%s'"), refname);
-- 
2.41.0.586.g3c0cc15bc7

