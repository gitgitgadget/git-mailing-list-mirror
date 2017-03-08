Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 28E51202D7
	for <e@80x24.org>; Wed,  8 Mar 2017 17:49:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753058AbdCHRt2 (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Mar 2017 12:49:28 -0500
Received: from cloud.peff.net ([104.130.231.41]:40595 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753860AbdCHRtX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Mar 2017 12:49:23 -0500
Received: (qmail 4656 invoked by uid 109); 8 Mar 2017 17:42:39 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 08 Mar 2017 17:42:39 +0000
Received: (qmail 32569 invoked by uid 111); 8 Mar 2017 17:42:48 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 08 Mar 2017 12:42:48 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 08 Mar 2017 12:42:37 -0500
Date:   Wed, 8 Mar 2017 12:42:37 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org, Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v3 0/9] Fix the early config
Message-ID: <20170308174237.cm6e5uvve6hu7lpf@sigill.intra.peff.net>
References: <cover.1488506615.git.johannes.schindelin@gmx.de>
 <cover.1488562287.git.johannes.schindelin@gmx.de>
 <20170304073952.drfgy7jacnlm6tum@sigill.intra.peff.net>
 <alpine.DEB.2.20.1703071314180.3767@virtualbox>
 <20170308073035.pt5ysp6bzpozoqps@sigill.intra.peff.net>
 <xmqqy3wf3dbo.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqy3wf3dbo.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 08, 2017 at 09:09:31AM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > Good catch. Another "non-gentle" thing I noticed here while looking at
> > another thread: the repository-format version check uses the config
> > parser, which will die() in certain circumstances. So for instance:
> >
> >   $ git init
> >   $ git rev-parse && echo ok
> >   ok
> >
> >   $ echo '[core]repositoryformatversion = 10' >.git/config
> >   $ git rev-parse && echo ok
> >   fatal: Expected git repo version <= 1, found 10
> 
> Just to set my expectation straight.  Do you expect/wish this not to
> fail because of this in cmd_rev_parse()?

No, I was just using "rev-parse" as a sample command that tried to do
repo setup. I meant the above snippet that you quoted to both be fine
and expected outputs. The problem is the _other_ two cases where the
config code dies before we even get to the version-number check.

> Or are you discussing a more general issue, iow, anything that can
> work without repository (i.e. those who do _gently version of the
> setup and act on *nongit_ok) should pretend as if there were no
> (broken) repository and take the "no we are not in a repository"
> codepath?

Yes, exactly.  It would have been less confusing if I picked something
that passed nongit_ok. Like hash-object:

  $ git init
  $ echo content >file
  $ git hash-object file
  d95f3ad14dee633a758d2e331151e950dd13e4ed

  $ echo '[core]repositoryformatversion = 10' >.git/config
  $ git hash-object file
  warning: Expected git repo version <= 1, found 10
  d95f3ad14dee633a758d2e331151e950dd13e4ed

The warning is fine and reasonable here. But then:

  $ echo '[core]repositoryformatversion = foobar' >.git/config
  $ git hash-object file
  fatal: bad numeric config value 'foobar' for 'core.repositoryformatversion' in file .git/config: invalid unit

That's wrong. We're supposed to be gentle. And ditto:

  $ echo '[co' >.git/config
  $ git hash-object file
  fatal: bad config line 1 in file .git/config

Those last two should issue a warning at most, and then let the command
continue.

-Peff
