Return-Path: <SRS0=IlH6=24=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2104BC33C99
	for <git@archiver.kernel.org>; Tue,  7 Jan 2020 11:01:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7CF92073D
	for <git@archiver.kernel.org>; Tue,  7 Jan 2020 11:01:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727747AbgAGLBr (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Jan 2020 06:01:47 -0500
Received: from cloud.peff.net ([104.130.231.41]:58826 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727273AbgAGLBr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Jan 2020 06:01:47 -0500
Received: (qmail 11076 invoked by uid 109); 7 Jan 2020 11:01:47 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 07 Jan 2020 11:01:47 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28941 invoked by uid 111); 7 Jan 2020 11:07:20 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 07 Jan 2020 06:07:20 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 7 Jan 2020 06:01:45 -0500
From:   Jeff King <peff@peff.net>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        "Miriam R." <mirucam@gmail.com>
Subject: Re: [PATCH] run-command: avoid undefined behavior in exists_in_PATH
Message-ID: <20200107110145.GA1073219@coredump.intra.peff.net>
References: <20200107013640.1821227-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200107013640.1821227-1-sandals@crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 07, 2020 at 01:36:40AM +0000, brian m. carlson wrote:

> In this function, we free the pointer we get from locate_in_PATH and
> then check whether it's NULL.  However, this is undefined behavior if
> the pointer is non-NULL, since the C standard no longer permits us to
> use a valid pointer after freeing it.
> 
> The only case in which the C standard would permit this to be defined
> behavior is if r were NULL, since it states that in such a case "no
> action occurs" as a result of calling free.
> 
> It's easy to suggest that this is not likely to be a problem, but we
> know that GCC does aggressively exploit the fact that undefined
> behavior can never occur to optimize and rewrite code, even when that's
> contrary to the expectations of the programmer.  It is, in fact, very
> common for it to omit NULL pointer checks, just as we have here.

OK, I agree it makes sense to be on the safe side here (and the patch is
obviously the right fix).

> Noticed-by: Miriam R. <mirucam@gmail.com>
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>

I think Miriam actually posted the same patch in her initial email:

  https://lore.kernel.org/git/CAN7CjDDBA0ZoCG9aaQf5rg3gxqny=EjR6v6jE1mnxvUJQSF_0Q@mail.gmail.com/

I don't know how we want to handle authorship.

-Peff
