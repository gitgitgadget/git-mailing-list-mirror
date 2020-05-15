Return-Path: <SRS0=YoUm=65=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1864FC433E0
	for <git@archiver.kernel.org>; Fri, 15 May 2020 18:28:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E279920728
	for <git@archiver.kernel.org>; Fri, 15 May 2020 18:28:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726249AbgEOS24 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 May 2020 14:28:56 -0400
Received: from cloud.peff.net ([104.130.231.41]:47982 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726197AbgEOS2z (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 May 2020 14:28:55 -0400
Received: (qmail 26027 invoked by uid 109); 15 May 2020 18:28:55 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 15 May 2020 18:28:55 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14149 invoked by uid 111); 15 May 2020 18:28:55 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 15 May 2020 14:28:55 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 15 May 2020 14:28:54 -0400
From:   Jeff King <peff@peff.net>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Taylor Blau <me@ttaylorr.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 08/13] upload-pack: move symref to upload_pack_data
Message-ID: <20200515182854.GH3692649@coredump.intra.peff.net>
References: <20200515100454.14486-1-chriscool@tuxfamily.org>
 <20200515100454.14486-9-chriscool@tuxfamily.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200515100454.14486-9-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 15, 2020 at 12:04:49PM +0200, Christian Couder wrote:

> As we cleanup 'upload-pack.c' by using 'struct upload_pack_data'
> more thoroughly, we are passing around that struct to many
> functions, so let's also pass 'struct string_list symref' around
> at the same time by moving it from a local variable in
> upload_pack() into a field of 'struct upload_pack_data'.

Hmm, do we really benefit here at all? The symref list is a local
implementation detail of upload_pack(), and v2 would not use it at all.
Nor does it ever survive past the function in which it's declared.

Perhaps it would help if we were able to send upload_pack_data along to
for_each_ref(), as you do in the next patch, and that let us make use of
upload_pack_data to access other variables. But it doesn't look like we
ever do.

In light of that, is it worth it?

I think we _could_ switch send_ref() (the callback for for_each_ref())
to use the packet-writer struct. Perhaps that would make it worth doing.

-Peff
