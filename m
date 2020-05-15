Return-Path: <SRS0=YoUm=65=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABBCCC433E0
	for <git@archiver.kernel.org>; Fri, 15 May 2020 18:17:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7DAC620657
	for <git@archiver.kernel.org>; Fri, 15 May 2020 18:17:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726251AbgEOSR4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 May 2020 14:17:56 -0400
Received: from cloud.peff.net ([104.130.231.41]:47912 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726023AbgEOSR4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 May 2020 14:17:56 -0400
Received: (qmail 25881 invoked by uid 109); 15 May 2020 18:17:55 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 15 May 2020 18:17:55 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14054 invoked by uid 111); 15 May 2020 18:17:55 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 15 May 2020 14:17:55 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 15 May 2020 14:17:54 -0400
From:   Jeff King <peff@peff.net>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Taylor Blau <me@ttaylorr.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 05/13] upload-pack: pass upload_pack_data to
 get_common_commits()
Message-ID: <20200515181754.GE3692649@coredump.intra.peff.net>
References: <20200515100454.14486-1-chriscool@tuxfamily.org>
 <20200515100454.14486-6-chriscool@tuxfamily.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200515100454.14486-6-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 15, 2020 at 12:04:46PM +0200, Christian Couder wrote:

> As we cleanup 'upload-pack.c' by using 'struct upload_pack_data'
> more thoroughly, let's pass 'struct upload_pack_data' to
> get_common_commits(), so that this function and the functions
> it calls can use all the fields of that struct in followup
> commits.

This one is optional, I think. We're not removing any globals nor moving
towards removing any (I don't think), because we're really just
replacing two object_array parameters with the big data struct:

> -static int get_common_commits(struct packet_reader *reader,
> -			      struct object_array *have_obj,
> -			      struct object_array *want_obj)
> +static int get_common_commits(struct upload_pack_data *data,
> +			      struct packet_reader *reader)

I say "I don't think" because it's possible that get_common_commits()
could use one of the other fields (or pass it to another function) in a
later patch. But I don't see it.

So I think one _could_ argue that it should continue to take the minimum
set of arguments it needs. I doubt it would ever be useful outside of the
context of upload_pack, so I think in practice it doesn't matter much
(beyond perhaps documenting which parts of the global data it needs). So
I don't feel strongly either way.

-Peff
