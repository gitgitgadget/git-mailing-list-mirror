Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BBE941F85A
	for <e@80x24.org>; Tue, 10 Jul 2018 20:21:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732382AbeGJUWJ (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Jul 2018 16:22:09 -0400
Received: from cloud.peff.net ([104.130.231.41]:54396 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1732332AbeGJUWJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Jul 2018 16:22:09 -0400
Received: (qmail 1776 invoked by uid 109); 10 Jul 2018 20:21:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 10 Jul 2018 20:21:30 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31248 invoked by uid 111); 10 Jul 2018 20:21:32 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 10 Jul 2018 16:21:32 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 10 Jul 2018 16:21:28 -0400
Date:   Tue, 10 Jul 2018 16:21:28 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Ben Peart <Ben.Peart@microsoft.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        "sandals@crustytoothpaste.net" <sandals@crustytoothpaste.net>,
        "stolee@gmail.com" <stolee@gmail.com>
Subject: Re: [PATCH v1] convert log_ref_write_fd() to use strbuf
Message-ID: <20180710202128.GA6886@sigill.intra.peff.net>
References: <20180710182000.21404-1-benpeart@microsoft.com>
 <20180710184534.GA27535@sigill.intra.peff.net>
 <xmqqsh4q6fpb.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqsh4q6fpb.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 10, 2018 at 12:41:52PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> >> -	while (buf < cp && isspace(cp[-1]))
> >> -		cp--;
> >> -	*cp++ = '\n';
> >> -	return cp - buf;
> >> +	strbuf_rtrim(sb);
> >
> > Using rtrim is a nice reduction in complexity. A pure translation would
> > include a final strbuf_addch(sb, '\n'). It looks like you moved that to
> > the caller. There's only one, so that's OK now, but it may affect topics
> > in flight (and I do in fact have an old topic that calls it).
> >
> > But I think it's OK, as the change in function signature means that any
> > callers will need updated anyway. So there's little risk of a silent
> > mis-merge.
> 
> It is interesting that we came to a slightly different conclusion,
> after doing pretty much the same analysis ;-).  Unless Ben has a
> plan to use a version that trims the trailing LF elsewhere, there is
> no point changing what the function does, especially because the
> existing and only caller does want the terminating LF at the end.

The original actually does a funny thing. It writes the newline into the
buffer, and then maybe calls copy_reflog_msg(). If it does, then we
actually subtract one from the length we feed to the function, to roll
back over the newline. That's harder to do with a strbuf, as those kinds
of manual length shenanigans are discouraged (you'd use strbuf_setlen()
to roll it back). At which point, you are much better off not adding it
in the first place, and building the whole thing sequentially:

  1. add the early bits that are in all entries

  2. (maybe) add the tab and message if there is one

  3. add the trailing newline

And that's exactly what Ben's patch does.

So I think the end result is much cleaner that way. My concern was just
that the function semantics were changed.

-Peff
