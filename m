Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 257AC1F6A9
	for <e@80x24.org>; Thu,  3 Jan 2019 07:29:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729827AbfACH3m (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 Jan 2019 02:29:42 -0500
Received: from cloud.peff.net ([104.130.231.41]:53606 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726284AbfACH3m (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Jan 2019 02:29:42 -0500
Received: (qmail 25455 invoked by uid 109); 3 Jan 2019 07:29:42 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 03 Jan 2019 07:29:42 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8569 invoked by uid 111); 3 Jan 2019 07:29:19 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 03 Jan 2019 02:29:19 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 03 Jan 2019 02:29:40 -0500
Date:   Thu, 3 Jan 2019 02:29:40 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Xheroz 128 <kenneth.951218@gmail.com>, git@vger.kernel.org
Subject: Re: Git extra hook, pre-upload
Message-ID: <20190103072940.GA24925@sigill.intra.peff.net>
References: <754B8F69-BD83-4EBB-9E86-6DF845624B1B@gmail.com>
 <87k1jqem1p.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87k1jqem1p.fsf@evledraar.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Dec 30, 2018 at 10:34:26PM +0100, Ævar Arnfjörð Bjarmason wrote:

> 
> On Sun, Dec 30 2018, Xheroz 128 wrote:
> 
> > Currently, I’m doing my Final Year Project that requires a hook that executes automatically on the server side of the repository, before the objects been pulled to the client side, and after the objects have been pushed to the server side, which is "post-receive" hook. The post-receive hook work well for me, but I couldn’t find any hook to be executed immediately before an upload-operation is performed, i.e. before data is sent to the client.
> >
> > Why Git doesn't have a hook that executed immediately before the data is sent to the client? Any advice on getting this hook or any similar function of the hook?
> 
> We do not have such a pre-upload hook, but could have one. There's an
> old thread from 2011 detailing some potential downsides:
> 
> https://public-inbox.org/git/CAMK1S_jaEWV=F6iHKZw_6u5ncDW0bPosNx-03W9bOLOfEEEY1Q@mail.gmail.com/
> 
> FWIW I think most servers who find themselves needing such a hook use it
> to e.g. log how many fetches a given repository might serve, and end up
> instead wrapping git commands in some custom shell.
> 
> It's also possible to imagine a much deeper integration for such a hook,
> e.g. something that would allow you to implement the functionality of
> the uploadpack.* variables and more in your own code, but I don't know
> if that's the sort of thing you're imagining.

Since that thread, we've added this config:

  uploadpack.packObjectsHook
	     If this option is set, when upload-pack would run git
	     pack-objects to create a packfile for a client, it will run
	     this shell command instead. The pack-objects command and
	     arguments it would have run (including the git pack-objects
	     at the beginning) are appended to the shell command. The
	     stdin and stdout of the hook are treated as if pack-objects
	     itself was run. I.e., upload-pack will feed input intended
	     for pack-objects to the hook, and expects a completed
	     packfile on stdout.

	     Note that this configuration variable is ignored if it is
	     seen in the repository-level config (this is a safety
	     measure against fetching from untrusted repositories).

So:

  1. That's some prior art for how an upload-pack hook could behave
     without introducing a security problem.

  2. Depending on what you want to do, this hook may be enough already.
     But it can't do everything (for instance, a fetch which results in
     no objects being requested would not trigger the hook at all, so if
     you were planning to keep stats about no-op fetches, it would not
     work).

-Peff
