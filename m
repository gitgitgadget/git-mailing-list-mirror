Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 43CAE20248
	for <e@80x24.org>; Tue, 19 Mar 2019 07:06:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726753AbfCSHGc (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Mar 2019 03:06:32 -0400
Received: from cloud.peff.net ([104.130.231.41]:56124 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725996AbfCSHGc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Mar 2019 03:06:32 -0400
Received: (qmail 9709 invoked by uid 109); 19 Mar 2019 07:06:31 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 19 Mar 2019 07:06:31 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27398 invoked by uid 111); 19 Mar 2019 07:06:53 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 19 Mar 2019 03:06:53 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 19 Mar 2019 03:06:30 -0400
Date:   Tue, 19 Mar 2019 03:06:30 -0400
From:   Jeff King <peff@peff.net>
To:     Dimitri Joukoff <dimitri.joukoff@griffithuni.edu.au>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Git server side "pre-receive" hook to create new repositories
Message-ID: <20190319070629.GE31801@sigill.intra.peff.net>
References: <SYXPR01MB095712C6765970605923A2FDDD4E0@SYXPR01MB0957.ausprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <SYXPR01MB095712C6765970605923A2FDDD4E0@SYXPR01MB0957.ausprd01.prod.outlook.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Mar 09, 2019 at 10:46:09AM +0000, Dimitri Joukoff wrote:

> Thus, this feature request is asking that the 'pre-receive' hook
> triggers when someone tries to push to a repository regardless of
> whether the repository exists.  This would allow automatic creation of
> new repositories and smooth the work-flow described above.  If the
> semantics of the existing 'pre-receive' hook are such that it would not
> be suitable for such a purpose, then an alternative way of providing the
> call-back ability would be implemented.

The pre-receive hook is a bit too late for this. It runs after the
server has told the client what it has in the repo, the client decides
what to push, and the server has received the pack. So receive-pack
would have to know about this and fake having an empty repository. And
then figure out where to store the incoming packfile, since we have no
repo.

So I think it would have to be another hook that runs before the rest of
receive-pack. I.e., a system-level config option that says "if you are
asked to accept a push for a repo and it doesn't exist, run this instead
and then run as usual".

It does feel a little error-prone, though, if the client does not
positively say "I want you to create this if it doesn't exist".
Otherwise if I do "git push server:my-misspelled-repo.git", the result
is going to be rather confusing. And retro-fitting that into the
receive-pack protocol is going to be tricky.

It would be much easier to have a separate endpoint for the client to
say "please make this repo if it doesn't exist". And then just run that
before doing the push.

For an unrestricted client connecting over ssh, we already have that:
you can just run "ssh $host git init /path/to/repo". There isn't a
similar thing that can be done over HTTP, though.

-Peff
