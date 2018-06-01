Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B83641F42D
	for <e@80x24.org>; Fri,  1 Jun 2018 21:07:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750917AbeFAVHf (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Jun 2018 17:07:35 -0400
Received: from cloud.peff.net ([104.130.231.41]:59632 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750756AbeFAVHd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Jun 2018 17:07:33 -0400
Received: (qmail 9508 invoked by uid 109); 1 Jun 2018 21:07:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 01 Jun 2018 21:07:33 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28598 invoked by uid 111); 1 Jun 2018 21:07:44 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 01 Jun 2018 17:07:44 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 01 Jun 2018 17:07:31 -0400
Date:   Fri, 1 Jun 2018 17:07:31 -0400
From:   Jeff King <peff@peff.net>
To:     "Robert P. J. Day" <rpjday@crashcourse.ca>
Cc:     Git Mailing list <git@vger.kernel.org>
Subject: Re: how exactly can git config section names contain periods?
Message-ID: <20180601210731.GA20974@sigill.intra.peff.net>
References: <alpine.LFD.2.21.1806011606490.11215@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.21.1806011606490.11215@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 01, 2018 at 04:14:12PM -0400, Robert P. J. Day wrote:

>   more oddities in my travels, this from Doc.../config.txt:
> 
> "The file consists of sections and variables.  A section begins with
> the name of the section in square brackets and continues until the
> next section begins.  Section names are case-insensitive.  Only
> alphanumeric characters, `-` and `.` are allowed in section names.
>                                   ^ ?????
> 
>   what? how can section names contain periods? reading further,

I agree that seems like nonsense. Once we get to the first period, we
consider parts after that to be a subsection name, due to the
"flattened" form we use in various places (i.e., "section.key" or
"section.subsection.key").

Syntactically we do allow:

  [foo.bar]
  key = true

in the config file, which should equivalent to:

  [foo "bar"]
  key = true

This is mentioned later:

  There is also a deprecated [section.subsection] syntax. With this
  syntax, the subsection name is converted to lower-case and is also
  compared case sensitively. These subsection names follow the same
  restrictions as section names.

This has been deprecated since 2011. Maybe it's time to finally get rid
of it.

> "Sections can be further divided into subsections.  To begin a
> subsection put its name in double quotes, separated by space from the
> section name, in the section header, like in the example below:
> 
> --------
>         [section "subsection"]
> 
> 
>   ok, so how on earth would i use "git config" at the command line to
> set a config variable with some arbitrary level of subsections? let's
> try this:

You don't. There are only three levels: section, (optional) subsection,
and key. If there is a subsection, it consists of _everything_ between
the two outer periods.

>   $ git config --global a.b.c.d.e rday
> 
> huh ... seemed to work fine, and added this to my ~/.gitconfig:
> 
>   [a "b.c.d"]
>           e = rday
> 
> as i see it, the first component is intgerpreted as the section name,
> the last component is the variable/key(?) name, and everything in
> between is treated as subsection(s), which is not at all obvious from
> that Doc file, or from "man git-config".

Yep, your understanding is correct.

>   and if a section name can contain periods, how would you specify
> that at the command line?

You can't, because section names cannot contain periods. ;)

I agree that the docs you quoted are somewhere between misleading and
outright wrong. At the very least, we should remove the part about ".
allowed in section names". But I also think we could stand to make the
3-level mental model more explicit.

-Peff
