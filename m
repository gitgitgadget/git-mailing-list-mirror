Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8C2442018A
	for <e@80x24.org>; Fri,  1 Jul 2016 17:59:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751964AbcGAR7y (ORCPT <rfc822;e@80x24.org>);
	Fri, 1 Jul 2016 13:59:54 -0400
Received: from cloud.peff.net ([50.56.180.127]:39209 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751912AbcGAR7y (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Jul 2016 13:59:54 -0400
Received: (qmail 22224 invoked by uid 102); 1 Jul 2016 17:59:53 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 01 Jul 2016 13:59:53 -0400
Received: (qmail 20186 invoked by uid 107); 1 Jul 2016 18:00:10 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 01 Jul 2016 14:00:10 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 01 Jul 2016 13:59:50 -0400
Date:	Fri, 1 Jul 2016 13:59:50 -0400
From:	Jeff King <peff@peff.net>
To:	Stefan Beller <sbeller@google.com>
Cc:	"git@vger.kernel.org" <git@vger.kernel.org>,
	Dan Wang <dwwang@google.com>
Subject: Re: [PATCH 1/4] push options: {pre,post}-receive hook learns about
 push options
Message-ID: <20160701175950.GB16235@sigill.intra.peff.net>
References: <20160630005951.7408-1-sbeller@google.com>
 <20160630005951.7408-2-sbeller@google.com>
 <20160701071410.GG5358@sigill.intra.peff.net>
 <CAGZ79kaDCLm3BBURJKfkYWKKvozkFTGCn0wGiQCtspUvtQBd+g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGZ79kaDCLm3BBURJKfkYWKKvozkFTGCn0wGiQCtspUvtQBd+g@mail.gmail.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Fri, Jul 01, 2016 at 10:20:32AM -0700, Stefan Beller wrote:

> >> The rationale for keeping the actual options inside a file instead of
> >> putting them directly into an environment variable has multiple reasons:
> >
> > Thanks for including this rationale; my first thought on seeing the
> > patch was "wouldn't this be much more convenient for a hook if each
> > value had its own environment variable?".
> 
> That's what I thought as well. Office discussion ensued and I am still
> offended by this solution, but it sucks less than multiple environment variables
> (I tried writing a script to construct and evaluate the environment
> variables and
> that doesn't look nice)

If you give up on having multiple incarnations of each variable, then I
think:

  GIT_PUSH_VAR_foo=value_for_foo
  GIT_PUSH_VAR_bar=value_for_bar

is quite elegant, and easy to use from hooks. It just cannot represent
multiple such "foo" variables.

> If we did not have a GIT_PUSH_OPTIONS_COUNT and GIT_PUSH_OPTION_<N>
> but rather GIT_PUSH_OPTIONS_VARIABLES that contains the other variables,
> it may be easier to handle, but whether you read from a file or evaluate the
> environment variable is only a minor step, the indirection is there anyway
> and this would be very close to what we have above.

It makes the server implementation a bit uglier. You have to create the
temporary file, and you have to clean it up. What process is responsible
for cleaning up stale files? Obviously receive-pack would try to clean
up after itself, but what happens when it is "kill -9"'d, or the system
goes down, etc? We clean up stale tmp files like tmp_obj_* in git-gc; I
think we'd want something like that here.

-Peff
