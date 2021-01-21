Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EA9FC433DB
	for <git@archiver.kernel.org>; Thu, 21 Jan 2021 20:57:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1848B22BEF
	for <git@archiver.kernel.org>; Thu, 21 Jan 2021 20:57:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727439AbhAUU5X (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Jan 2021 15:57:23 -0500
Received: from cloud.peff.net ([104.130.231.41]:34504 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725779AbhAUU4X (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jan 2021 15:56:23 -0500
Received: (qmail 6838 invoked by uid 109); 21 Jan 2021 20:55:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 21 Jan 2021 20:55:30 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5915 invoked by uid 111); 21 Jan 2021 20:55:30 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 21 Jan 2021 15:55:30 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 21 Jan 2021 15:55:29 -0500
From:   Jeff King <peff@peff.net>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH v4 2/3] connect, transport: add no-op arg for future patch
Message-ID: <YAnqQZaVByUYYRNr@coredump.intra.peff.net>
References: <20201211210508.2337494-1-jonathantanmy@google.com>
 <cover.1608673963.git.jonathantanmy@google.com>
 <14f3962adc0ce03505fbef2c40434400c539c40d.1608673963.git.jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <14f3962adc0ce03505fbef2c40434400c539c40d.1608673963.git.jonathantanmy@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 22, 2020 at 01:54:19PM -0800, Jonathan Tan wrote:

> In a future patch we plan to return the name of an unborn current branch
> from deep in the callchain to a caller via a new pointer parameter that
> points at a variable in the caller when the caller calls
> get_remote_refs() and transport_get_remote_refs(). Add the parameter to
> functions involved in the callchain, but no caller passes an actual
> argument yet in this step. Thus, the future patch only needs to concern
> itself with new logic.

OK. Since the call stack is so deep, it's nice to get all of this diff
noise out of the way of the third patch.

It does make me wonder if we should be passing a struct like:

  struct transport_fetch_options {
	struct strvec ref_prefixes;
	char **unborn_head;
  }
  #define TRANSPORT_FETCH_OPTIONS_INIT = { STRVEC_INIT }

which would solve this problem once for any future options.

> @@ -455,7 +455,8 @@ struct ref **get_remote_refs(int fd_out, struct packet_reader *reader,
>  			     struct ref **list, int for_push,
>  			     const struct strvec *ref_prefixes,
>  			     const struct string_list *server_options,
> -			     int stateless_rpc)
> +			     int stateless_rpc,
> +			     char **unborn_head_target)

Is a single string enough? The way the protocol is defined, I think the
server is free to tell us about other unborn symrefs, too (but of course
our implementation does not). And I'm not sure what we'd do with such
values (in a "--mirror" clone, I guess we could make local copies of
them).

Should we be prepared for that at the transport layer, or is it
over-engineering?

-Peff
