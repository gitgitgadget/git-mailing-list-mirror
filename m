Return-Path: <SRS0=p769=6V=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DFBDC38A2A
	for <git@archiver.kernel.org>; Thu,  7 May 2020 17:27:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1508B20A8B
	for <git@archiver.kernel.org>; Thu,  7 May 2020 17:27:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726470AbgEGR1P (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 May 2020 13:27:15 -0400
Received: from cloud.peff.net ([104.130.231.41]:40582 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726222AbgEGR1O (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 May 2020 13:27:14 -0400
Received: (qmail 968 invoked by uid 109); 7 May 2020 17:27:14 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 07 May 2020 17:27:14 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19622 invoked by uid 111); 7 May 2020 17:27:17 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 07 May 2020 13:27:17 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 7 May 2020 13:27:13 -0400
From:   Jeff King <peff@peff.net>
To:     Jiang Xin <worldhello.net@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Git List <git@vger.kernel.org>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: Re: [PATCH v12 3/7] receive-pack: add new proc-receive hook
Message-ID: <20200507172713.GA3645853@coredump.intra.peff.net>
References: <xmqq3697cax0.fsf@gitster.c.googlers.com>
 <20200414123257.27449-4-worldhello.net@gmail.com>
 <xmqqo8rs7ntb.fsf@gitster.c.googlers.com>
 <CANYiYbE84Jj46m0ZTfAepc7t4v4KcqU9R99WGY9b7cdTXBfw_g@mail.gmail.com>
 <xmqqzhbc61jv.fsf@gitster.c.googlers.com>
 <CANYiYbGNTMpdvW7AGs-drOuwhzcR_CJnsCE9TjAWujZtb3cfEg@mail.gmail.com>
 <20200429075604.GA637261@coredump.intra.peff.net>
 <CANYiYbFCG1_hdy1kA06wjrvGSQ2=y-hJX3Rsh-rn=X9tcqv1VQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CANYiYbFCG1_hdy1kA06wjrvGSQ2=y-hJX3Rsh-rn=X9tcqv1VQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 30, 2020 at 11:33:27PM +0800, Jiang Xin wrote:

> Thanks to Peff for providing technical details of the architecture.  I
> understand that "receive-pack" of GitHub backend is not involved in
> references update (executing the commands), so the "proc-receive" hook
> won't be turned on for GitHub's architecture. While in our
> architecture (inspired by "spokes" of GitHub), the proxy will deliver
> not only packfile, but also commands to all three replicas. The proxy
> will execute "receive-pack" on the replica with a special argument, so
> the proxy can talk with "receive-pack" with an extended protocol.
> After running pre-receive hook and release the packfile from
> quarantine, the replica will stop and wait for the proxy to
> coordinate. After creating a distributed lock, the proxy will tell all
> the replicas continue to update the references.  One problem we met is
> the proc-receive and the post-receive hook must be executed once. We
> can make the execution of the hooks idempotent, or let only one of the
> replica run the hook. We choose the latter.

OK, that makes more sense. We solve that by not updating the refs at all
via receive-pack (which gives us flexibility to run our own hooks
separately on just one replica, etc).

> I agree that adding new capability (report-status-v2) is a better
> solution, but I think the above extension is a bit wordy. We add
> additional 18 characters for each "ok <ref>" status, and add
> additional 32 characters for each "ng <ref> <msg>" status. Can we
> extend it like this:
> 
>     ok <ref>
>     [optional key-value pairs]
>     ng <ref> <error message>
>     [optional key-value pairs]

I doubt the number of bytes is all that important, but certainly I'm
happy with this (and it looks like what you put into v14).

-Peff
