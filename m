Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DF2AF202C9
	for <e@80x24.org>; Wed,  1 Mar 2017 00:32:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751460AbdCAAcE (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Feb 2017 19:32:04 -0500
Received: from cloud.peff.net ([104.130.231.41]:36206 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751099AbdCAAcE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Feb 2017 19:32:04 -0500
Received: (qmail 29669 invoked by uid 109); 28 Feb 2017 22:44:26 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 28 Feb 2017 22:44:26 +0000
Received: (qmail 32327 invoked by uid 111); 28 Feb 2017 22:44:32 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 28 Feb 2017 17:44:32 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 28 Feb 2017 17:44:24 -0500
Date:   Tue, 28 Feb 2017 17:44:24 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Adrian Dudau <Adrian.Dudau@enea.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: format-patch subject-prefix gets truncated when using the
 --numbered flag
Message-ID: <20170228224424.p2po5giijeyvkhib@sigill.intra.peff.net>
References: <1488297556.2955.11.camel@enea.com>
 <xmqqinnuky9e.fsf@gitster.mtv.corp.google.com>
 <xmqqzih6jejg.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqzih6jejg.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 28, 2017 at 11:33:55AM -0800, Junio C Hamano wrote:

> And having said all that, if we really want to allow overlong
> subject prefix that would end up hiding the real title of the patch,
> a modern way to do so would be to use xstrfmt() like the attached
> toy-patch does.

If you are going to keep the ownership inside this function via statics,
you should use a strbuf. That lets you avoid reallocating on each entry
(and we call this once per commit in a traversal, though see below).

> Note that this is merely a small first step---you'd
> notice that "subject" is kept around as a "static" and only freed
> upon entry to this function for the second time, to preserve the
> ownership model of the original code.  In a real "fix" (if this
> needs to be "fixed", that is), I think the ownership model of the
> storage used for *subject_p and *extra_headers_p needs to be updated
> so that it will become caller's responsibility to free them
> (similarly, the ownership model of opt->diffopt.stat_sep that is
> assigned the address of the static buffer[] in the same function
> needs to be revisited).

I agree the ownership model is ugly, and would be nicer if the caller
passed in a strbuf to write into (or a pointer out-parameter, I guess,
but I think strbufs make the ownership semantics much more obvious).

I would just worry about allocation overhead, but that is probably an
overblown concern for format-patch. It tends to be called on a much
smaller set of commits, and it is generally used with "-p", which
creates a lot of overhead already.

-Peff
