Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E47CFC46467
	for <git@archiver.kernel.org>; Wed, 11 Jan 2023 20:30:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231132AbjAKUaU (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Jan 2023 15:30:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjAKUaS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Jan 2023 15:30:18 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A762EA1
        for <git@vger.kernel.org>; Wed, 11 Jan 2023 12:30:17 -0800 (PST)
Received: (qmail 31887 invoked by uid 109); 11 Jan 2023 20:30:17 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 11 Jan 2023 20:30:17 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8994 invoked by uid 111); 11 Jan 2023 20:30:18 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 11 Jan 2023 15:30:18 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 11 Jan 2023 15:30:16 -0500
From:   Jeff King <peff@peff.net>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH 0/5] cleaning up read_object() family of functions
Message-ID: <Y78cWKKXz944pWBS@coredump.intra.peff.net>
References: <Y7l4LsEQcDT9HZ21@coredump.intra.peff.net>
 <f1028cba-5fc6-3584-3f21-545550012e9d@github.com>
 <Y77/T8dktee3wOA5@coredump.intra.peff.net>
 <6c896cc8-2da9-a448-4ab6-2dc535fb0e2b@github.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6c896cc8-2da9-a448-4ab6-2dc535fb0e2b@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 11, 2023 at 03:17:58PM -0500, Derrick Stolee wrote:

> > For example, here's an attempt to let the caller use designated
> > initializers to set up the query struct:
> 
> > +	struct object_info oi = OBJECT_INFO(.typep = type,
> > +					    .sizep = size,
> > +					    .contentp = &data);
> 
> Your macro expansion creates this format:
> 
> 	struct object_info oi = {
> 		.type = type,
> 		.sizep = size,
> 		.contentp = &data,
> 	};
> 
> And even this expansion looks a bit better than the inline
> updates:

There's a subtle assumption in the expanded initializer, though, which
is that everything not specified is OK to be zero-initialized. That
works for object_info, but not for arbitrary structs (which is why we
have these INIT macros in the first place).

-Peff
