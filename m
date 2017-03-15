Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 67C08202C1
	for <e@80x24.org>; Wed, 15 Mar 2017 15:21:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751959AbdCOPTP (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Mar 2017 11:19:15 -0400
Received: from cloud.peff.net ([104.130.231.41]:44599 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752220AbdCOPS5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Mar 2017 11:18:57 -0400
Received: (qmail 10478 invoked by uid 109); 15 Mar 2017 15:18:56 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 15 Mar 2017 15:18:56 +0000
Received: (qmail 10902 invoked by uid 111); 15 Mar 2017 15:19:07 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 15 Mar 2017 11:19:07 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 15 Mar 2017 11:18:53 -0400
Date:   Wed, 15 Mar 2017 11:18:53 -0400
From:   Jeff King <peff@peff.net>
To:     Robert Dailey <rcdailey.lists@gmail.com>
Cc:     Git <git@vger.kernel.org>
Subject: Re: git pretty format: "%+b" not working with "%w" in front of it?
Message-ID: <20170315151853.c3mn7xyc5fqmkkn4@sigill.intra.peff.net>
References: <CAHd499BP-iaXJDNg+4RWB9GaQ1xW8ZnH0oysWSa7u_DCSWFFDg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHd499BP-iaXJDNg+4RWB9GaQ1xW8ZnH0oysWSa7u_DCSWFFDg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 15, 2017 at 09:08:10AM -0500, Robert Dailey wrote:

> $ git log
> 
> commit 7ffb909bb8f38607e3d6d9f3504a66ca978f0ac2
> Author: Robert Dailey <robert@ziosk.com>
> Date:   Mon Dec 12 11:01:00 2016 -0600
> 
>     Add initial skeleton files & a few interfaces for new kizi/sc16 stuff
> 
>     This is still FAR from complete....
> 
> 
> I want to generate changelogs, using github markdown list format. I
> tried doing that using this command:
> 
> $ git log --pretty=format:"* %s%n%w(100,2,2)%+b"
> 
> However, the 2nd newline is not inserted:
> 
> * Add initial skeleton files & a few interfaces for new kizi/sc16 stuff
>    This is still FAR from complete....
> 
> The format I'm expecting is:
> 
> * Add initial skeleton files & a few interfaces for new kizi/sc16 stuff
> 
>   This is still FAR from complete....

Hmm. I think the leading newline is added, but it gets eaten by the
wrapping code. If I run your example in a debugger, we enter
strbuf_add_wrapped_text() with:

  buf = "* the subject line\n"
  text = "\nthe body text"
  indent1=2, indent2=2, width=100

Which looks right.  But the wrapping code seems to treat blank lines
oddly. I can't quite figure out what it's _trying_ to do, but if there's
one blank line, it gets converted into a space (and thus the weird
three-space indent you see). But if there are two, they are both
preserved!

So I think the line-wrapping code is simply buggy, and you are not doing
anything wrong. But maybe I am missing some subtle case.

-Peff
