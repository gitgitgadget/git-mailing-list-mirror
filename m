Return-Path: <SRS0=YePV=76=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD02EC433DF
	for <git@archiver.kernel.org>; Wed, 17 Jun 2020 08:34:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A1598206E2
	for <git@archiver.kernel.org>; Wed, 17 Jun 2020 08:34:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726480AbgFQIeZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Jun 2020 04:34:25 -0400
Received: from cloud.peff.net ([104.130.231.41]:34226 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726326AbgFQIeZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Jun 2020 04:34:25 -0400
Received: (qmail 32652 invoked by uid 109); 17 Jun 2020 08:34:24 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 17 Jun 2020 08:34:24 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21148 invoked by uid 111); 17 Jun 2020 08:34:25 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 17 Jun 2020 04:34:25 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 17 Jun 2020 04:34:23 -0400
From:   Jeff King <peff@peff.net>
To:     Noel Grandin <noelgrandin@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: filtering on git fetch?
Message-ID: <20200617083423.GA695303@coredump.intra.peff.net>
References: <f6c1377f-6945-b04f-07cf-887c4b7c9f76@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f6c1377f-6945-b04f-07cf-887c4b7c9f76@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 17, 2020 at 09:41:37AM +0200, Noel Grandin wrote:

> Setup
> 
> (*) I'm fetching across a transatlantic link (RTT in the 300ms range on a good day)
> (*) I'm fetching from a gerrit server
> 
> $ GIT_PACKET_TRACE=true git fetch
> 
> shows tons and tons of
> 
> 09:39:43.355675 pkt-line.c:80           packet:        fetch<
> 3a7ad7ee5d7daa0c93a80fbb32a677597d81ac75 refs/changes/00/9000/3
> 09:39:43.355684 pkt-line.c:80           packet:        fetch<
> 6cacf1db5311f6b250ebaa12c71419a8ff9b747e refs/changes/00/9000/meta
> 09:39:43.355693 pkt-line.c:80           packet:        fetch<
> 849a43434a5ede9ce9b70da14231f34edb2593fb refs/changes/00/90100/1
> 
> type stuff before it starts fetching the updates to master that I am interested in.
> 
> Is there any way to tell the remote git server that I'm only interested in a subset of stuff?

The ref advertisement in the v0 protocol is unconditional and always
complete. In v2, the client is able to specify which parts of the
namespace it cares about.

Try:

  GIT_TRACE_PACKET=1 git -c protocol.version=2

This will probably be the default in v2.28 (it was the default in v2.26,
but there was a performance regression, so we backed it out for v2.27).

-Peff
