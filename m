Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8CC631F403
	for <e@80x24.org>; Fri,  8 Jun 2018 05:47:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751535AbeFHFrs (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Jun 2018 01:47:48 -0400
Received: from cloud.peff.net ([104.130.231.41]:38596 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750962AbeFHFrr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Jun 2018 01:47:47 -0400
Received: (qmail 30722 invoked by uid 109); 8 Jun 2018 05:47:48 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 08 Jun 2018 05:47:48 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24922 invoked by uid 111); 8 Jun 2018 05:48:01 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 08 Jun 2018 01:48:01 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 08 Jun 2018 01:47:45 -0400
Date:   Fri, 8 Jun 2018 01:47:45 -0400
From:   Jeff King <peff@peff.net>
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     Martin-Louis Bright <mlbright@gmail.com>,
        lars.schneider@autodesk.com, git@vger.kernel.org,
        sandals@crustytoothpaste.net, Johannes.Schindelin@gmx.de,
        pstodulk@redhat.com, nickh@reactrix.com, jeremy.wyman@microsoft.com
Subject: Re: [RFC PATCH v1] http: add http.keepRejectedCredentials config
Message-ID: <20180608054745.GA2893@sigill.intra.peff.net>
References: <20180604122635.95342-1-lars.schneider@autodesk.com>
 <20180604144747.GA27655@sigill.intra.peff.net>
 <CAG2PGsoHajiYbS29F2nD+_0i2b4+Min5NR3tQYDb3MH=BW=0Aw@mail.gmail.com>
 <20180604185551.GA4296@sigill.intra.peff.net>
 <46F82119-D185-4B41-828B-FC92709CFCDA@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <46F82119-D185-4B41-828B-FC92709CFCDA@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 07, 2018 at 08:15:16PM -0700, Lars Schneider wrote:

> > In fact, this patch probably should give the user some advice in that
> > regard (either in the documentation, or as a warning when we skip the
> > rejection). If you _do_ have a bogus credential and set the new option,
> > you'd need to reject it manually (you can do it with "git credential
> > reject", but it's probably easier to just unset the option temporarily
> > and re-invoke the original command).
> 
> I like the advice idea very much!
> 
> How about this?
> 
> $ git fetch
> hint: Git has stored invalid credentials.
> hint: Reject them with 'git credential reject' or
> hint: disable the Git config 'http.keepRejectedCredentials'.
> remote: Invalid username or password.
> fatal: Authentication failed for 'https://server.com/myrepo.git/'
> 
> I am not really sure about the grammar :-)

It's probably not worth pointing the user at "git credential reject",
since it's not really meant to be friendly to users. In particular, you
have to speak the credential protocol on stdin.

I _think_

  echo https://server.com/myrepo.git | git credential reject

might be enough, but I didn't test. Probably better advice is to just
repeat the command. Maybe:

  hint: Git kept invalid credentials due to the value of
  hint: http.keepRejectedCredentials. If you wish to drop these
  hint: credentials and be prompted for new ones, re-run your
  hint: command with "git -c http.keepRejectedCredentials=false".

or something?

-Peff
