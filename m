Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1EDCF20248
	for <e@80x24.org>; Wed, 27 Feb 2019 16:35:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726783AbfB0QfZ (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Feb 2019 11:35:25 -0500
Received: from cloud.peff.net ([104.130.231.41]:60030 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726122AbfB0QfY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Feb 2019 11:35:24 -0500
Received: (qmail 6208 invoked by uid 109); 27 Feb 2019 16:35:24 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 27 Feb 2019 16:35:24 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7167 invoked by uid 111); 27 Feb 2019 16:35:39 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 27 Feb 2019 11:35:39 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 27 Feb 2019 11:35:22 -0500
Date:   Wed, 27 Feb 2019 11:35:22 -0500
From:   Jeff King <peff@peff.net>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Brandon <brandon1024.br@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] commit-tree: utilize parse-options api
Message-ID: <20190227163522.GA25188@sigill.intra.peff.net>
References: <20190226200952.33950-1-brandon1024.br@gmail.com>
 <CACsJy8Bgz6FiTqnq8pnebuyOr55Bqh67iRhr6J+WvzgxPSBLhw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACsJy8Bgz6FiTqnq8pnebuyOr55Bqh67iRhr6J+WvzgxPSBLhw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 27, 2019 at 06:07:42PM +0700, Duy Nguyen wrote:

> > +static int parse_parent_arg_callback(const struct option *opt,
> > +               const char *arg, int unset)
> > +{
> > +       struct object_id oid;
> > +       struct commit_list **parents = opt->value;
> > +
> > +       BUG_ON_OPT_NEG(unset);
> > +
> > +       if (!arg)
> > +               return 1;
> 
> This "return 1;" surprises me because I think we often just return 0
> or -1. I know !arg cannot happen here, so maybe just drop it. Or if
> you want t play absolutely safe, maybe add a new macro like
> 
> BUG_ON_NO_ARG(arg);
> 
> which conveys the intention much better.

I think it should be spelled BUG_ON_OPT_NOARG() to match the other ones.

One of the reasons I did not bother with that condition when I added the
OPT_NEG() and OPT_ARG() variants is that you can only get an unexpected
NULL argument if you explicitly give the NOARG or OPTARG flags. So it's
very easy to _forget_ to give such a flag, because you simply aren't
thinking about that case, and your callback is buggy by default.

But it's rare to actually think to give one of those flags, but then
forget to handle it in your callback.

So I'm not entirely opposed, but it does feel weird to add such a macro
without then using it in the 99% of callbacks which expect arg to be
non-NULL.

Actually, there is one subtlety, which is that it can be NULL if "unset"
is true. But then callbacks should already be looking at "unset" or
using BUG_ON_OPT_NEG(). But that just makes things worse. Take
parse_opt_patchformat(), for example. It _does_ check "unset", so should
not use BUG_ON_OPT_NEG(). But if "!unset", it expects "arg" to be
non-NULL. So adding an assertion there turns our nice cascade of
conditionals:

  if (unset)
	...handle unset...
  else if (!strcmp(arg, "foo"))
	...handle "foo"...
  ...and so on...

into:

  if (unset)
	...handle unset...
  else {
	BUG_ON_OPT_NOARG(arg);
	if (!strcmp, "foo"))
		....
	... and so on...
  }

If we are going to go this route, I think you might actually want macros
that take both "unset" and "args" and make sure that we're not in a
situation the callback doesn't expect (e.g., "!unset && !arg"). That
lets us continue to declare those at the top of the callback.

But as you can see, it gets complicated quickly. I'm not really sure
it's worth the trouble for a maintenance problem that's relatively
unlikely.

-Peff
