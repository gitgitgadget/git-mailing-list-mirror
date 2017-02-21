Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BDF35201A9
	for <e@80x24.org>; Tue, 21 Feb 2017 23:00:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752347AbdBUXAd (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Feb 2017 18:00:33 -0500
Received: from cloud.peff.net ([104.130.231.41]:59537 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751452AbdBUXAc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Feb 2017 18:00:32 -0500
Received: (qmail 7549 invoked by uid 109); 21 Feb 2017 23:00:31 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 21 Feb 2017 23:00:31 +0000
Received: (qmail 16723 invoked by uid 111); 21 Feb 2017 23:00:34 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 21 Feb 2017 18:00:34 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 21 Feb 2017 18:00:29 -0500
Date:   Tue, 21 Feb 2017 18:00:29 -0500
From:   Jeff King <peff@peff.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     Toolforger <toolforger@durchholz.org>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: url.<base>.insteadOf vs. submodules
Message-ID: <20170221230029.cs36tjwpsw2opuwp@sigill.intra.peff.net>
References: <84fcb0bd-85dc-0142-dd58-47a04eaa7c2b@durchholz.org>
 <20170220090115.6kfzwl62opj4q7k7@sigill.intra.peff.net>
 <404d109f-e5a7-85a3-e64c-ab1b21c3045d@durchholz.org>
 <20170220205243.lynnmxouwq7jelld@sigill.intra.peff.net>
 <28fb85d4-89cd-1f32-3063-2f48d8b935be@durchholz.org>
 <20170221070653.65ho2anbp55uzjeu@sigill.intra.peff.net>
 <CAGZ79kZgMbEZy7hoA+VxsKdKBavt59SmC1c6FpDdgrW2GKMHvQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGZ79kZgMbEZy7hoA+VxsKdKBavt59SmC1c6FpDdgrW2GKMHvQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 21, 2017 at 10:19:38AM -0800, Stefan Beller wrote:

> On Mon, Feb 20, 2017 at 11:06 PM, Jeff King <peff@peff.net> wrote:
> >
> > We'll see if the submodule folks have any ideas on how to implement
> > that.
> >
> 
> So from reading your discussion, the user expectation is to have
> `git submodule {init, update --init, sync}`
> to pay attention to url.<base>.insteadOf when setting up the
> submodule.<name>.URL, such that the modified URL is used for the
> initial clone of the submodule (and hence any subsequent usage within
> the submodule).

Yeah, that was what I was envisioning.

> Two caveates:
> 
> * After running `git submodule init`, you change url.<base>.insteadOf
>   in the superproject. How do we need to word the documentation to
>   have users expecting this change doesn't affect submodules?
>   (See above Any vs. "Any except (initialized) submodules")

Good question.

I guess one answer is that this is the wrong approach entirely, and the
right one is something like: submodules should understand that they are
part of a superproject, and respect some whitelisted set of config from
the superproject .git/config file.

The second half is pretty easy to do (use git_config_from_file on the
super-project's $GIT_DIR/config, and pass a callback which filters the
keys before passing them along to the real callback).

I'm not sure about the first half (submodules know about their
superproject), though.

> * So with the point above the insteadOf config only applies to the
>   init/sync process, (i.e. once in time, ideally).
>   Is that confusing or actually simplifying the submodule workflow?

Not sure. That's why I asked you. :)

One other caveat: I'm not sure if we do insteadOf recursively, but it
may be surprising to the child "git clone" that we've already applied
the insteadOf rewriting (especially if the rules are coming from
~/.gitconfig and may be applied twice).

-Peff
