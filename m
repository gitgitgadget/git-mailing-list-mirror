Return-Path: <SRS0=wY2r=4U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81131C3F2C6
	for <git@archiver.kernel.org>; Tue,  3 Mar 2020 21:11:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5288520870
	for <git@archiver.kernel.org>; Tue,  3 Mar 2020 21:11:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732447AbgCCVLp (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Mar 2020 16:11:45 -0500
Received: from cloud.peff.net ([104.130.231.41]:59814 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1732026AbgCCVLp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Mar 2020 16:11:45 -0500
Received: (qmail 12274 invoked by uid 109); 3 Mar 2020 21:11:45 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 03 Mar 2020 21:11:45 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12983 invoked by uid 111); 3 Mar 2020 21:20:56 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.3)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 03 Mar 2020 16:20:56 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 3 Mar 2020 13:11:42 -0800
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Damien Robert <damien.olivier.robert@gmail.com>,
        git@vger.kernel.org,
        Damien Robert <damien.olivier.robert+git@gmail.com>
Subject: Re: [PATCH v2 1/2] remote: drop "explicit" parameter from
 remote_ref_for_branch()
Message-ID: <20200303211142.GA36275@coredump.intra.peff.net>
References: <20200302133217.GA1176622@coredump.intra.peff.net>
 <20200303161223.1870298-1-damien.olivier.robert+git@gmail.com>
 <20200303161223.1870298-2-damien.olivier.robert+git@gmail.com>
 <xmqqzhcx8gz8.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqzhcx8gz8.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 03, 2020 at 09:51:07AM -0800, Junio C Hamano wrote:

> > But unlike remote names, there's no default case for the remote branch
> > name.
> 
> Up to this point, it is well written and easy to read.  I think
> "there is no case where a default name for the remoate branch is
> used" would be even more easy to read.
> 
> In any case, if there is no case that default name, I understand
> that explicit is always set to 1?
> 
> > In any case where we don't set "explicit", we'd just an empty
> > string anyway.
> 
> Sorry, but I cannot parse this.  But earlier, you established that
> there is no case that a default is used, so is there any case where
> we don't set "explicit"?  I don't get it.

Maybe more clear:

For remote names, we will always return one of two things:

  - a remote name based on user config, in which case explicit=1

  - the default string "origin", in which case explicit=0

For remote branches, we will return either:

  - the remote branch name from config, in which case explicit=1

  - the empty string, in which case explicit=0

But nobody ever looks at that empty string. For the second case, we
could just as well return NULL. At which point we don't need an explicit
flag at all, as the caller can just check for NULL.

(written before reading what you wrote below)

> After reading the code through, I think "there's no default case"
> was what caused my confusion.
> 
>     But unlike remote names, there is no default name when the user
>     didn't configure one.  The only way the "explicit" parameter is
>     used by the caller is to use the value returned from the helper
>     when it is set, and use an empty string otherwise, ignoring the
>     returned value from the helper.
> 
>     Let's drop the "explicit" out-parameter, and return NULL when
>     the returned value from the helper should be ignored, to
>     simplify the function interface.

Yes, that looks fine to me.

-Peff
