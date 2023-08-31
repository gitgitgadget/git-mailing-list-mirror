Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 505A8C83F2F
	for <git@archiver.kernel.org>; Thu, 31 Aug 2023 20:48:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233704AbjHaUsm (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 31 Aug 2023 16:48:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347457AbjHaUsl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Aug 2023 16:48:41 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3329E5F
        for <git@vger.kernel.org>; Thu, 31 Aug 2023 13:48:30 -0700 (PDT)
Received: (qmail 25828 invoked by uid 109); 31 Aug 2023 20:48:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 31 Aug 2023 20:48:30 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11244 invoked by uid 111); 31 Aug 2023 20:48:30 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 31 Aug 2023 16:48:30 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 31 Aug 2023 16:48:29 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH 4/8] parse-options: mark unused "opt" parameter in
 callbacks
Message-ID: <20230831204829.GA3233491@coredump.intra.peff.net>
References: <20230831070935.GA3197495@coredump.intra.peff.net>
 <20230831071820.GB3197751@coredump.intra.peff.net>
 <xmqqil8vxjcd.fsf@gitster.g>
 <20230831175018.GB3208283@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230831175018.GB3208283@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 31, 2023 at 01:50:18PM -0400, Jeff King wrote:

> > > -static int parse_refmap_arg(const struct option *opt, const char *arg, int unset)
> > > +static int parse_refmap_arg(const struct option *opt UNUSED,
> > > +			    const char *arg, int unset)
> > >  {
> > >  	BUG_ON_OPT_NEG(unset);
> > 
> > Can't this just point opt->value at the global &refmap?  Obviously
> > not a huge deal, as we could have taken the "annotate as UNUSED"
> > approach for all the functions in [3/8].
> 
> Hmm, yeah. I think I looked at the abstract refspec_append() here and
> assumed that it might be touching other variables. But it's not. It's
> operating purely on the &refspec we pass it (and even though it uses
> ALLOC_GROW, the "nr" and "alloc" are both contained in the struct). So
> yeah, it really should have been converted in patch 3.

Oh, btw, there are two other cases in this patch that _could_ be
converted but I left alone. In log.c, we have a to_callback() and a
cc_callback(), both of which take a single string list. But there is
also header_callback(), which resets both of those when it sees
--no-add-header. So I left them alone as a set.

However, it occurs to me that to_callback() and cc_callback() can just
be OPT_STRING_LIST these days. And that is probably a worthwhile
cleanup to do.

-Peff
