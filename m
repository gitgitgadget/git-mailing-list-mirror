Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D03EC433ED
	for <git@archiver.kernel.org>; Fri, 21 May 2021 09:34:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 837E06135A
	for <git@archiver.kernel.org>; Fri, 21 May 2021 09:34:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236557AbhEUJfn (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 May 2021 05:35:43 -0400
Received: from cloud.peff.net ([104.130.231.41]:33172 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236053AbhEUJfm (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 May 2021 05:35:42 -0400
Received: (qmail 2869 invoked by uid 109); 21 May 2021 09:34:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 21 May 2021 09:34:19 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7825 invoked by uid 111); 21 May 2021 09:34:21 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 21 May 2021 05:34:21 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 21 May 2021 05:34:18 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Denton Liu <liu.denton@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v3] trace2: refactor to avoid gcc warning under -O3
Message-ID: <YKd+mtQuW9Yz0qwh@coredump.intra.peff.net>
References: <xmqqim3ew905.fsf@gitster.g>
 <patch-1.1-2e41e3e4cb-20210520T110357Z-avarab@gmail.com>
 <YKZgZZrZdKyUk9d9@coredump.intra.peff.net>
 <xmqqk0ntt5x0.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqk0ntt5x0.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 21, 2021 at 07:08:11AM +0900, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> >> @@ -287,7 +285,7 @@ static int tr2_dst_try_unix_domain_socket(struct tr2_dst *dst,
> >>  	if (tr2_dst_want_warning())
> >>  		warning("trace2: could not connect to socket '%s' for '%s' tracing: %s",
> >>  			path, tr2_sysenv_display_name(dst->sysenv_var),
> >> -			strerror(e));
> >> +			strerror(errno));
> >
> > We expect the value of errno to persist across tr2_dst_want_warning()
> > and tr2_sysenv_display_name() here. The former may call getenv() and
> > atoi(). I think that's probably fine, but if we wanted to be really
> > paranoid, we'd have to preserve errno manually here, too.
> 
> Being "really paranoid" consistently within the file would mean a
> change like the attached, I would think, on top of what was posted.
> 
> Or tr2_dst_want_warning() and tr2_sysenv_display_name() can be
> taught to preserve errno like tr2_dst_dry_uds_connect() was taught
> to do so by the patch under discussion, which may reduce the amount
> of apparent change, but constantly moving the contents of errno
> around just in case we later might want to use its value feels
> dirty.
> 
> I dunno.
> 
>  trace2/tr2_dst.c | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)

Ah, yeah. I didn't look to see if there were existing cases of the same
thing.

I could go either way on this kind of saved_errno thing in general (the
tr2 functions called in between are really quite unlikely to set errno
(I am not even sure if getenv() and atoi() can, so this really might
just be future-proofing in case those tr2 functions get more
complicated).

But seeing that there are other cases of the same, I definitely think it
is not something that should be in Ævar's patch. It is a cleanup we
could do on top if we cared to.

-Peff
