Return-Path: <SRS0=W4Po=BO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D568C433E0
	for <git@archiver.kernel.org>; Tue,  4 Aug 2020 21:25:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8688222B42
	for <git@archiver.kernel.org>; Tue,  4 Aug 2020 21:25:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726962AbgHDVZT (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Aug 2020 17:25:19 -0400
Received: from cloud.peff.net ([104.130.231.41]:48212 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725922AbgHDVZT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Aug 2020 17:25:19 -0400
Received: (qmail 6116 invoked by uid 109); 4 Aug 2020 21:25:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 04 Aug 2020 21:25:19 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16425 invoked by uid 111); 4 Aug 2020 21:25:18 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 04 Aug 2020 17:25:18 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 4 Aug 2020 17:25:18 -0400
From:   Jeff King <peff@peff.net>
To:     Sergey Organov <sorganov@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Chris Torek <chris.torek@gmail.com>
Subject: Re: [PATCH v2 0/7] making log --first-parent imply -m
Message-ID: <20200804212518.GB2020725@coredump.intra.peff.net>
References: <20200729201002.GA2989059@coredump.intra.peff.net>
 <871rku3soc.fsf@osv.gnss.ru>
 <20200731230858.GA1461090@coredump.intra.peff.net>
 <87mu3drynx.fsf@osv.gnss.ru>
 <xmqqsgd5rlwi.fsf@gitster.c.googlers.com>
 <87o8nrybnb.fsf@osv.gnss.ru>
 <20200803180824.GA2711830@coredump.intra.peff.net>
 <874kpi47xj.fsf@osv.gnss.ru>
 <20200804195830.GA2014743@coredump.intra.peff.net>
 <873652166e.fsf@osv.gnss.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <873652166e.fsf@osv.gnss.ru>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 04, 2020 at 11:56:25PM +0300, Sergey Organov wrote:

> >> diff --git a/revision.c b/revision.c
> >> index 669bc856694f..dcdff59bc36a 100644
> >> --- a/revision.c
> >> +++ b/revision.c
> >> @@ -2323,10 +2323,31 @@ static int handle_revision_opt(struct
> >> rev_info *revs, int argc, const char **arg
> >>  		revs->diff = 1;
> >>  		revs->diffopt.flags.recursive = 1;
> >>  		revs->diffopt.flags.tree_in_recursive = 1;
> >> -	} else if (!strcmp(arg, "-m") || !strcmp(arg, "--diff-merges")) {
> >> +	} else if ((argcount = parse_long_opt("diff-merges", argv, &optarg))) {
> >>  		revs->ignore_merges = 0;
> >> +		if (!strcmp(optarg, "off")) {
> >> +			revs->ignore_merges = 1;
> >> +		} else if (!strcmp(optarg, "all")) {
> >> +			revs->diff = 0;
> >
> > Should this be revs->ignore_merges = 0?
> 
> It's 4 lines above, as it's in fact common for all the cases but the
> first one.

Ah, I missed that. That raises more questions, though. ;)

For "-m" we do not need to set revs->diff; why do we need to do so
here?

For "--cc", we do not need to set revs->ignore_merges. Why do we need to
do so here? We do need it set eventually, but I think setup_revisions()
later handles that, and wants ignore_merges untouched to decide whether
the user asked for it or not.

-Peff
