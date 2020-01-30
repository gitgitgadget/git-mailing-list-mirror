Return-Path: <SRS0=gonI=3T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 360EBC33C9E
	for <git@archiver.kernel.org>; Thu, 30 Jan 2020 07:11:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BE552067C
	for <git@archiver.kernel.org>; Thu, 30 Jan 2020 07:11:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726415AbgA3HLE (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jan 2020 02:11:04 -0500
Received: from cloud.peff.net ([104.130.231.41]:48136 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725865AbgA3HLD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jan 2020 02:11:03 -0500
Received: (qmail 21614 invoked by uid 109); 30 Jan 2020 07:11:03 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 30 Jan 2020 07:11:03 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21391 invoked by uid 111); 30 Jan 2020 07:18:44 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 30 Jan 2020 02:18:44 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 30 Jan 2020 02:11:02 -0500
From:   Jeff King <peff@peff.net>
To:     Bryan Turner <bturner@atlassian.com>
Cc:     Git Users <git@vger.kernel.org>
Subject: Re: packObjectsHook and the git executable
Message-ID: <20200130071102.GA2189233@coredump.intra.peff.net>
References: <CAGyf7-E==gzsvP-ckK0kwHD+f9pMmLBVpL4y2rC9tqk7ZiuW1g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGyf7-E==gzsvP-ckK0kwHD+f9pMmLBVpL4y2rC9tqk7ZiuW1g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 29, 2020 at 05:00:18PM -0800, Bryan Turner wrote:

> In upload-pack.c, when Git invokes the packObjectsHook, it's
> hard-coded to pass "git". Unless it modifies the PATH environment
> variable, though, if the script were to invoke the provided command
> line as-is, it may end up running a different version of Git than the
> version being used to run upload-pack (or http-backend).

We do modify PATH to put git's exec-path at the start. This happens in
setup_path(), which is called by the main "git" executable (so "git
upload-pack" before it hits cmd_upload_pack()).

Programs which are invoked directly as "git-upload-pack" need to call
that function on their own (which happens when upload-pack is invoked
over ssh). But upload-pack and http-backend do that.

> Is there any way the packObjectsHook could be passed the "right" git
> executable? Or am I missing some surrounding context that means
> executing "git" is somehow guaranteed to invoke the "right" binary?
> (Perhaps this same PATH-related caveat applies to other places where
> Git invokes itself recursively?)

I think all is working as designed, but if you have a reproducible case
where we run the "wrong" git, I can take a look at it.

-Peff
