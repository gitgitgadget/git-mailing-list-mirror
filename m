Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2983C4332F
	for <git@archiver.kernel.org>; Fri, 21 Oct 2022 04:55:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229678AbiJUEzp (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Oct 2022 00:55:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbiJUEzn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Oct 2022 00:55:43 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBF381A5B2D
        for <git@vger.kernel.org>; Thu, 20 Oct 2022 21:55:40 -0700 (PDT)
Received: (qmail 10345 invoked by uid 109); 21 Oct 2022 04:55:40 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 21 Oct 2022 04:55:40 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 960 invoked by uid 111); 21 Oct 2022 04:55:41 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 21 Oct 2022 00:55:41 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 21 Oct 2022 00:55:39 -0400
From:   Jeff King <peff@peff.net>
To:     Michael McClimon <michael@mcclimon.org>
Cc:     Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>,
        Glen Choo <chooglen@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: What's cooking in git.git (Oct 2022, #06; Wed, 19)
Message-ID: <Y1ImS1Muvk1MAQeC@coredump.intra.peff.net>
References: <xmqqa65rnuvv.fsf@gitster.g>
 <Y1Hy9n7E1/yWKkYv@newk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y1Hy9n7E1/yWKkYv@newk>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 20, 2022 at 09:16:38PM -0400, Michael McClimon wrote:

> > * mm/git-pm-try-catch-syntax-fix (2022-10-17) 1 commit
> >  - Git.pm: add semicolon after catch statement
> > 
> >  Fix a longstanding syntax error in Git.pm error codepath.
> > 
> >  Will merge to 'next'??
> >  source: <20221016212236.12453-2-michael@mcclimon.org>
> 
> I am not totally sure what these question marks mean, but I'm happy for
> this to go to next, for what it's worth. (There was an outstanding
> question about the general behavior of Git.pm in bare unsafe
> repositories, but I certainly am not planning to solve it in this
> series.) Thanks!

Me too. I had hoped for a test, but because of those outstanding
questions about the behavior, I think we are better off skipping it for
now, and fixing what is obviously a bug.

There is one devil's advocate thing that is nagging at me, though.
Because this whole safe-directory thing is security-relevant, could we
make things worse by "fixing" it partially? That is, consider
this code:

  git init --bare foo.git
  sudo chown -R nobody foo.git
  cd foo.git
  perl -MGit -e 'Git->repository'

Post 2.35.4, etc, is it a security vulnerability for that final step to
open the repository? If so, then right now we are "not vulnerable" in
the sense that an unrelated bug causes Git.pm to bail in the final step.
And fixing that will mean we become vulnerable.

To be clear, having an unrelated bug is not a good way to prevent
security vulnerabilities. But it is the status quo. If the fixed version
(after your patch to add the semicolon) is vulnerable, but the released
one in the hands of users is not, then fixing it does make things worse
in the short term (even though the obviously correct thing in the long
run is to fix that bug and also correct the vulnerability the right
way).

I wasn't around when the directory-ownership stuff was discussed or
worked on. But it might be nice for people who worked on it or thought a
lot about it to give an opinion on whether the state after your patch is
in fact vulnerable to a security flaw.

-Peff
