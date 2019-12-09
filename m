Return-Path: <SRS0=90au=Z7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 320C5C43603
	for <git@archiver.kernel.org>; Mon,  9 Dec 2019 07:14:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BC9D20721
	for <git@archiver.kernel.org>; Mon,  9 Dec 2019 07:14:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726623AbfLIHON (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Dec 2019 02:14:13 -0500
Received: from cloud.peff.net ([104.130.231.41]:41786 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726014AbfLIHON (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Dec 2019 02:14:13 -0500
Received: (qmail 18451 invoked by uid 109); 9 Dec 2019 07:14:13 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 09 Dec 2019 07:14:13 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18475 invoked by uid 111); 9 Dec 2019 07:18:30 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 09 Dec 2019 02:18:30 -0500
Authentication-Results: peff.net; auth=none
Date:   Mon, 9 Dec 2019 02:14:12 -0500
From:   Jeff King <peff@peff.net>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH v3 7/9] pack-objects: introduce pack.allowPackReuse
Message-ID: <20191209071412.GG40570@coredump.intra.peff.net>
References: <20191115141541.11149-1-chriscool@tuxfamily.org>
 <20191115141541.11149-8-chriscool@tuxfamily.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191115141541.11149-8-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 15, 2019 at 03:15:39PM +0100, Christian Couder wrote:

> From: Jeff King <peff@peff.net>
> 
> Let's make it possible to configure if we want pack reuse or not.

...because? :)

I mostly used it for debugging and performance testing. I don't think
there should be any big downside to using it that would cause people to
want to turn it off. But it _might_ cause larger packs, because we
wouldn't consider the reused objects as bases for finding new deltas.

I think the documentation could mention this. And maybe make it a bit
more clear what "reuse" means.

So maybe:

diff --git a/Documentation/config/pack.txt b/Documentation/config/pack.txt
index 58323a351f..0dac580581 100644
--- a/Documentation/config/pack.txt
+++ b/Documentation/config/pack.txt
@@ -28,8 +28,11 @@ all existing objects. You can force recompression by passing the -F option
 to linkgit:git-repack[1].
 
 pack.allowPackReuse::
-	When true, which is the default, Git will try to reuse parts
-	of existing packfiles when preparing new packfiles.
+	When true, and when reachability bitmaps are enabled,
+	pack-objects will try to send parts of the bitmapped packfile
+	verbatim. This can reduce memory and CPU usage to serve fetches,
+	but might result in sending a slightly larger pack. Defaults to
+	true.
 
 pack.island::
 	An extended regular expression configuring a set of delta

-Peff
