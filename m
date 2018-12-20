Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2F62D1F405
	for <e@80x24.org>; Thu, 20 Dec 2018 17:17:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733179AbeLTRRu (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Dec 2018 12:17:50 -0500
Received: from cloud.peff.net ([104.130.231.41]:47060 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1729481AbeLTRRu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Dec 2018 12:17:50 -0500
Received: (qmail 7410 invoked by uid 109); 20 Dec 2018 17:17:49 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 20 Dec 2018 17:17:49 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2655 invoked by uid 111); 20 Dec 2018 17:17:00 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 20 Dec 2018 12:17:00 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 20 Dec 2018 12:17:25 -0500
Date:   Thu, 20 Dec 2018 12:17:25 -0500
From:   Jeff King <peff@peff.net>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] diff: add support for reading files literally with
 --no-index
Message-ID: <20181220171725.GB6684@sigill.intra.peff.net>
References: <20181220002610.43832-1-sandals@crustytoothpaste.net>
 <CACsJy8CScTBbYJt_LLp-rBdmJubEQOZqkPQeszzax9YpbCPUkg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACsJy8CScTBbYJt_LLp-rBdmJubEQOZqkPQeszzax9YpbCPUkg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 20, 2018 at 06:06:11PM +0100, Duy Nguyen wrote:

> On Thu, Dec 20, 2018 at 1:26 AM brian m. carlson
> <sandals@crustytoothpaste.net> wrote:
> > @@ -5159,6 +5159,8 @@ int diff_opt_parse(struct diff_options *options,
> >                 options->flags.funccontext = 1;
> >         else if (!strcmp(arg, "--no-function-context"))
> >                 options->flags.funccontext = 0;
> > +       else if (!strcmp(arg, "--literally"))
> > +               options->flags.read_literally = 1;
> 
> You probably want to check in diff_setup_done() that if
> flags.read_literally is set but flags.no_index is not, then abandon
> ship and die() because --literally is not used with --no-index. Even
> when --no-index is implicit, flags.no_index should be set.

Yeah, good catch. "git diff --literally HEAD" should report an error.

> I wonder if --follow-symlinks would be a good alternative for this
> (then if the final destination is unmmapable then we just read the
> file whole in memory without the user asking, so it will work with
> pipes). --follow-symlinks then could be made work with non-"no-index"
> case too. But --literally is also ok.

It's more than symlinks, though. Reading from a named pipe, we'd want to
see the actual contents with --literally (and not "oops, I don't know
how to represent a named pipe").

-Peff
