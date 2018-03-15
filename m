Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AE2F71F404
	for <e@80x24.org>; Thu, 15 Mar 2018 15:48:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932768AbeCOPsT (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Mar 2018 11:48:19 -0400
Received: from cloud.peff.net ([104.130.231.41]:58026 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S932575AbeCOPsR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Mar 2018 11:48:17 -0400
Received: (qmail 29631 invoked by uid 109); 15 Mar 2018 15:48:17 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 15 Mar 2018 15:48:17 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15936 invoked by uid 111); 15 Mar 2018 15:49:11 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 15 Mar 2018 11:49:11 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 15 Mar 2018 11:48:15 -0400
Date:   Thu, 15 Mar 2018 11:48:15 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Michele Locati <michele@locati.it>, git@vger.kernel.org
Subject: Re: [PATCH] filter-branch: return 2 when nothing to rewrite
Message-ID: <20180315154815.GA29874@sigill.intra.peff.net>
References: <20180315130359.6108-1-michele@locati.it>
 <20180315141220.GB27748@sigill.intra.peff.net>
 <xmqqa7v973b5.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqa7v973b5.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 15, 2018 at 08:42:54AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > On Thu, Mar 15, 2018 at 02:03:59PM +0100, Michele Locati wrote:
> >
> >> Using the --state-branch option allows us to perform incremental filtering.
> >> This may lead to having nothing to rewrite in subsequent filtering, so we need
> >> a way to recognize this case.
> >> So, let's exit with 2 instead of 1 when this "error" occurs.
> >
> > That sounds like a good feature. It doesn't look like we use "2" for
> > anything else currently.
> 
> I do not want to sound overly negative against the first
> contribution from a new contributor, but I am not sure if this is a
> good idea.  While I do agree that the caller of filter-branch would
> want _some_ way to tell if the call
> 
>  - got some new stuff,
>  - got no error but did not get anything new, or
>  - failed
> 
> and act accordingly, changing the exit code to a non-zero value for
> the second case above would mean that existing scripts that have
> happily been working would suddenly start failing.  Due to the lack
> of an easy way to tell the first two cases apart, they may have been
> doing _extra_ work after calling filter-branch when it found no new
> development (resulting in an expensive no-op), or perhaps they
> implemented their own way to tell the second case apart from the
> first one and efficiently omitting extra work in the second case
> already.  In either case, these scripts will get broken with this
> change.

Hrm. I took the goal to mean that we used to exit with a failing "1" in
this case, and now we would switch to a more-specific "2". And I think
that matches the behavior of the patch:

-test $commits -eq 0 && die "Found nothing to rewrite"
+test $commits -eq 0 && die_with_status 2 "Found nothing to rewrite"

Am I missing something?

-Peff
