Return-Path: <SRS0=iCZD=ZT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C65C8C432C3
	for <git@archiver.kernel.org>; Wed, 27 Nov 2019 12:32:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A44B32075C
	for <git@archiver.kernel.org>; Wed, 27 Nov 2019 12:32:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726530AbfK0McN (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Nov 2019 07:32:13 -0500
Received: from cloud.peff.net ([104.130.231.41]:33806 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726383AbfK0McM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Nov 2019 07:32:12 -0500
Received: (qmail 10926 invoked by uid 109); 27 Nov 2019 12:32:12 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 27 Nov 2019 12:32:12 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9721 invoked by uid 111); 27 Nov 2019 12:36:15 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 27 Nov 2019 07:36:15 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 27 Nov 2019 07:32:11 -0500
From:   Jeff King <peff@peff.net>
To:     "Patrick Marlier (pamarlie)" <pamarlie@cisco.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: [PATCH] send-pack: use OBJECT_INFO_QUICK to check negative objects
Message-ID: <20191127123211.GG22221@sigill.intra.peff.net>
References: <CH2PR11MB429411CA1288526D21C7AF26CF4C0@CH2PR11MB4294.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CH2PR11MB429411CA1288526D21C7AF26CF4C0@CH2PR11MB4294.namprd11.prod.outlook.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 19, 2019 at 01:12:51PM +0000, Patrick Marlier (pamarlie) wrote:

> I am hitting a performance issue with "git push <remote> <refspec>".
> The local repository has only few refs and the remote repository has a
> lot of refs (1000+) with objects unknown to the local repository.
> 
> "git push" of only one refspec takes minutes to complete. A quick
> analysis shows that a lot of time is spent in the client side.
> A deeper analysis shows that the client receives the entire list of
> refs on the remote, then the client is checking in its local
> repository if the objects exist for all remote refs.

Right, this is expected. The client send-pack feeds the list of remote
objects (that it has) to pack-objects, which can then limit the size of
the packfile it sends based on what the other side has.

So the patch you showed (to skip refs that aren't part of the push)
would miss many opportunities for a smaller push. E.g., imagine I create
a new branch "topic" from the remote branch "master", and then try to
push it up. If I do not look at which objects are in "master", I'll end
up sending the whole history again, when I really just need to send the
differences between the two.

> Since the local repository has a only few refs, most of the objects
> are unknown.
>
> This issue is particularly amplified because the local repository is
> using many alternates. Indeed for each unknown object, git will try to
> find in all alternates too.

I think the patch below would help you.

-- >8 --
Subject: [PATCH] send-pack: use OBJECT_INFO_QUICK to check negative objects

When pushing, we feed pack-objects a list of both positive and negative
objects. The positive objects are what we want to send, and the negative
objects are what the other side told us they have, which we can use to
limit the size of the push.

Before passing along a negative object, send_pack() will make sure we
actually have it (since we only know about it because the remote
mentioned it, not because it's one of our refs). So it's expected that
some of these objects will be missing on the local side. But looking for
a missing object is more expensive than one that we have: it triggers
reprepare_packed_git() to handle a racy repack, plus it has to explore
every alternate's loose object tree (which can be slow if you have a lot
of them, or have a high-latency filesystem).

This isn't usually a big problem, since repositories you're pushing to
don't generally have a large number of refs that are unrelated to what
the client has. But there's no reason such a setup is wrong, and it
currently performs poorly.

We can fix this by using OBJECT_INFO_QUICK, which tells the lookup
code that we expect objects to be missing. Notably, it will not re-scan
the packs, and it will use the loose cache from 61c7711cfe (sha1-file:
use loose object cache for quick existence check, 2018-11-12).

The downside is that in the rare case that we race with a local repack,
we might fail to feed some objects to pack-objects, making the resulting
push larger. But we'd never produce an invalid or incorrect push, just a
less optimal one. That seems like a reasonable tradeoff, and we already
do similar things on the fetch side (e.g., when marking COMPLETE
commits).

Signed-off-by: Jeff King <peff@peff.net>
---
Interestingly, upload-pack does not use OBJECT_INFO_QUICK when it's
getting oids from the other side. But I think it could possibly benefit
in the same way. Nobody seems to have noticed. Perhaps it simply comes
up less, as servers would tend to have more objects than their clients?

 send-pack.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/send-pack.c b/send-pack.c
index 34c77cbb1a..16d6584439 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -41,7 +41,9 @@ int option_parse_push_signed(const struct option *opt,
 static void feed_object(const struct object_id *oid, FILE *fh, int negative)
 {
 	if (negative &&
-	    !has_object_file_with_flags(oid, OBJECT_INFO_SKIP_FETCH_OBJECT))
+	    !has_object_file_with_flags(oid,
+					OBJECT_INFO_SKIP_FETCH_OBJECT |
+					OBJECT_INFO_QUICK))
 		return;
 
 	if (negative)
-- 
2.24.0.716.g722aff65ed

