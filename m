Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54E49C352A1
	for <git@archiver.kernel.org>; Wed,  7 Dec 2022 06:14:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229802AbiLGGO2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Dec 2022 01:14:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229813AbiLGGOZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Dec 2022 01:14:25 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 287A45986A
        for <git@vger.kernel.org>; Tue,  6 Dec 2022 22:14:24 -0800 (PST)
Received: (qmail 17897 invoked by uid 109); 7 Dec 2022 06:14:24 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 07 Dec 2022 06:14:24 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30659 invoked by uid 111); 7 Dec 2022 06:14:25 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 07 Dec 2022 01:14:25 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 7 Dec 2022 01:14:22 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
Subject: Re: [PATCH v2 1/3] object-file: don't exit early if skipping loose
Message-ID: <Y5AvPjTjKPxq7vG8@coredump.intra.peff.net>
References: <cover.1669839849.git.jonathantanmy@google.com>
 <cover.1670373420.git.jonathantanmy@google.com>
 <9ad34a1dce977044066de0bfa6e25977215e8dc9.1670373420.git.jonathantanmy@google.com>
 <xmqqy1rk6mqa.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqy1rk6mqa.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 07, 2022 at 10:12:13AM +0900, Junio C Hamano wrote:

> Hmph, who passes IGNORE_LOOSE and why?  Explaining the answer to
> that question would give us confidence why this change is safe.
> 
> If the reason IGNORE_LOOSE is set by the callers is because they are
> interested only in locally packed objects, then this change would
> break them because they end up triggering the lazy fetch in the
> updated code, no?  Or do all callers that set IGNORE_LOOSE drop the
> fetch_if_missing global before calling us?

I wondered who those callers might be, too, because it is such a weird
thing for a caller to want to care about (usually we try to abstract the
object database).

It looks like the only user went away in 97b2fa08b6 (fetch-pack: drop
custom loose object cache, 2018-11-12). So I think we just want to drop
it:

diff --git a/object-file.c b/object-file.c
index 26290554bb..cf724bc19b 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1575,9 +1575,6 @@ static int do_oid_object_info_extended(struct repository *r,
 		if (find_pack_entry(r, real, &e))
 			break;
 
-		if (flags & OBJECT_INFO_IGNORE_LOOSE)
-			return -1;
-
 		/* Most likely it's a loose object. */
 		if (!loose_object_info(r, real, oi, flags))
 			return 0;
diff --git a/object-store.h b/object-store.h
index 1be57abaf1..371629c1e1 100644
--- a/object-store.h
+++ b/object-store.h
@@ -434,8 +434,6 @@ struct object_info {
 #define OBJECT_INFO_ALLOW_UNKNOWN_TYPE 2
 /* Do not retry packed storage after checking packed and loose storage */
 #define OBJECT_INFO_QUICK 8
-/* Do not check loose object */
-#define OBJECT_INFO_IGNORE_LOOSE 16
 /*
  * Do not attempt to fetch the object if missing (even if fetch_is_missing is
  * nonzero).


We could also renumber the later flags to keep them compact, but I don't
have a strong opinion there.

-Peff
