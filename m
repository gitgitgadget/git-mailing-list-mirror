Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4955F2035A
	for <e@80x24.org>; Tue, 11 Jul 2017 19:08:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933459AbdGKTIt (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Jul 2017 15:08:49 -0400
Received: from cloud.peff.net ([104.130.231.41]:37400 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S933344AbdGKTIs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Jul 2017 15:08:48 -0400
Received: (qmail 28063 invoked by uid 109); 11 Jul 2017 19:08:48 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 11 Jul 2017 19:08:48 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19366 invoked by uid 111); 11 Jul 2017 19:09:00 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Tue, 11 Jul 2017 15:09:00 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 11 Jul 2017 15:08:46 -0400
Date:   Tue, 11 Jul 2017 15:08:46 -0400
From:   Jeff King <peff@peff.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     Peter Krefting <peter@softwolves.pp.se>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: git config --help not functional on bad config
Message-ID: <20170711190846.jr53xhwa42uz4ky2@sigill.intra.peff.net>
References: <alpine.DEB.2.00.1707111541150.18163@ds9.cixit.se>
 <20170711175342.mllx7efdsqlzv5lo@sigill.intra.peff.net>
 <CAGZ79kbQsRQaHjRccs-0jkYkfhBwU-gX-M3A9sP4hqTtqqpFYw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGZ79kbQsRQaHjRccs-0jkYkfhBwU-gX-M3A9sP4hqTtqqpFYw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 11, 2017 at 12:05:01PM -0700, Stefan Beller wrote:

> > diff --git a/builtin/help.c b/builtin/help.c
> > index 334a8494a..c42dfc9e9 100644
> > --- a/builtin/help.c
> > +++ b/builtin/help.c
> > @@ -273,7 +273,7 @@ static int git_help_config(const char *var, const char *value, void *cb)
> >         if (starts_with(var, "man."))
> >                 return add_man_viewer_info(var, value);
> >
> > -       return git_default_config(var, value, cb);
> > +       return 0;
> 
> Instead of ignoring any default config, we could do
> 
>     git_default_config(var, value, cb);
>     /* ignore broken config, we may be the help call for config */
>     return 0;
> 
> I looked through git_default_config which seems to only die
> with useful error messages for compression related settings,
> but these we may want to convert to errors instead of dies,
> when going this way.

There are other die calls hidden deeper. For instance:

  $ git -c core.ignorecase=foo help config
  fatal: bad numeric config value 'foo' for 'core.ignorecase': invalid unit

Those ones are hard to fix without changing the call signature of
git_config_bool().

-Peff
