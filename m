Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B444C4321E
	for <git@archiver.kernel.org>; Wed, 30 Nov 2022 20:54:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229538AbiK3UyD (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Nov 2022 15:54:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiK3UyC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Nov 2022 15:54:02 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9B0E837C0
        for <git@vger.kernel.org>; Wed, 30 Nov 2022 12:54:01 -0800 (PST)
Received: (qmail 19129 invoked by uid 109); 30 Nov 2022 20:54:01 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 30 Nov 2022 20:54:01 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8127 invoked by uid 111); 30 Nov 2022 20:54:01 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 30 Nov 2022 15:54:01 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 30 Nov 2022 15:54:00 -0500
From:   Jeff King <peff@peff.net>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 3/4] object-file: refactor replace object lookup
Message-ID: <Y4fC6HSkpYXKPVCr@coredump.intra.peff.net>
References: <cover.1669839849.git.jonathantanmy@google.com>
 <940396307fea59b434d33edbf2c7f98adc62c053.1669839849.git.jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <940396307fea59b434d33edbf2c7f98adc62c053.1669839849.git.jonathantanmy@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 30, 2022 at 12:30:48PM -0800, Jonathan Tan wrote:

> diff --git a/object-store.h b/object-store.h
> index 88c879c61e..9684562eb2 100644
> --- a/object-store.h
> +++ b/object-store.h
> @@ -406,6 +406,7 @@ struct object_info {
>  	struct object_id *delta_base_oid;
>  	struct strbuf *type_name;
>  	void **contentp;
> +	const struct object_id **real_oidp;

OK. The double-pointer here is a bit funky as an interface. It may point
back to the "oid" we fed the function, or it may point to long-term
storage owned by the replace mechanism. A more straightforward one would
be to store a single-pointer to caller-owned storage, and copy to that
(like we do for delta_base_oid, for example).

But doing it this way avoids extra oid copies in the normal,
non-replaced case, and matches how the current callers view things. So
while it's a little convoluted, I think it makes sense to do it as you
did.

-Peff
