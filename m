Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9264C48BE0
	for <git@archiver.kernel.org>; Thu, 10 Jun 2021 21:51:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC038611CD
	for <git@archiver.kernel.org>; Thu, 10 Jun 2021 21:51:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230444AbhFJVxF (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Jun 2021 17:53:05 -0400
Received: from cloud.peff.net ([104.130.231.41]:51870 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230421AbhFJVxE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Jun 2021 17:53:04 -0400
Received: (qmail 9527 invoked by uid 109); 10 Jun 2021 21:51:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 10 Jun 2021 21:51:07 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1864 invoked by uid 111); 10 Jun 2021 21:51:07 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 10 Jun 2021 17:51:07 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 10 Jun 2021 17:51:06 -0400
From:   Jeff King <peff@peff.net>
To:     Elijah Newren <newren@gmail.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Git Mailing List <git@vger.kernel.org>,
        Taylor Blau <me@ttaylorr.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 3/5] submodule: refrain from filtering GIT_CONFIG_COUNT
Message-ID: <YMKJSuin9fS/4acr@coredump.intra.peff.net>
References: <cover.1622580781.git.jonathantanmy@google.com>
 <cover.1623345496.git.jonathantanmy@google.com>
 <e1a40108f42addf8a589c1d0ac4ed76fb525be9b.1623345496.git.jonathantanmy@google.com>
 <CABPp-BFpW7KLQGbe1kz5FNWABrTNaHOCZw3poXBMWQ9MP91GuQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CABPp-BFpW7KLQGbe1kz5FNWABrTNaHOCZw3poXBMWQ9MP91GuQ@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 10, 2021 at 02:13:49PM -0700, Elijah Newren wrote:

> > diff --git a/submodule.c b/submodule.c
> > index 0b1d9c1dde..f09031e397 100644
> > --- a/submodule.c
> > +++ b/submodule.c
> > @@ -489,7 +489,8 @@ static void prepare_submodule_repo_env_no_git_dir(struct strvec *out)
> >         const char * const *var;
> >
> >         for (var = local_repo_env; *var; var++) {
> > -               if (strcmp(*var, CONFIG_DATA_ENVIRONMENT))
> > +               if (strcmp(*var, CONFIG_DATA_ENVIRONMENT) &&
> > +                   strcmp(*var, CONFIG_COUNT_ENVIRONMENT))
> >                         strvec_push(out, *var);
> >         }
> >  }
> > --
> > 2.32.0.rc1.229.g3e70b5a671-goog
> 
> I'm super confused.  It appears that
> prepare_submodule_repo_env_no_git_dir() is filtering out
> "GIT_CONFIG_PARAMETERS" (CONFIG_DATA_ENVIRONMENT) and
> "GIT_CONFIG_COUNT" (CONFIG_COUNT_ENVIRONMENT), using all environment
> variables other than these ones.  But the commit message talks about
> adding an extra environment variable, rather than filtering another
> out.  I must be mis-reading something somewhere, but I'm struggling to
> figure it out.

I think there might be a double (triple?) negative here:

  - we want to pass through the config parameters variable, but not
    other local repo env variables;

  - so we _don't_ want the config variable to appear in the "out"
    strvec, because its presence would cause it to be cleared
    from the child process environment;

  - so we go through the list adding everything _except_ that variable;

  - and we match using strcmp(), so a true value means "did not match",
    so we should add it to the list

> Also, from looking at the other commit messages you reference, it
> appears GIT_CONFIG_PARAMETERS was just one big environment variable,
> whereas GIT_CONFIG_COUNT is closely associated with 2*N other
> environment variables...so shouldn't your loop (and perhaps also
> git-submodule.sh) also be checking GIT_CONFIG_KEY_\d+ and
> GIT_CONFIG_VALUE_\d+ ?

We definitely could clean out those GIT_CONFIG_KEY_* values. But the
COUNT serves as a master parameter. Anybody who sets COUNT would then
also set the individual key/value parameters, too (and even it only sets
it to "5", and there is a crufty GIT_CONFIG_KEY_6 in the environment,
that is not wrong).

-Peff
