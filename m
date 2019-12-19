Return-Path: <SRS0=FxFb=2J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11E35C43603
	for <git@archiver.kernel.org>; Thu, 19 Dec 2019 04:50:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBA27222C2
	for <git@archiver.kernel.org>; Thu, 19 Dec 2019 04:50:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726924AbfLSEuI (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Dec 2019 23:50:08 -0500
Received: from cloud.peff.net ([104.130.231.41]:49992 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726834AbfLSEuI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Dec 2019 23:50:08 -0500
Received: (qmail 21544 invoked by uid 109); 19 Dec 2019 04:50:08 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 19 Dec 2019 04:50:08 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1250 invoked by uid 111); 19 Dec 2019 04:54:48 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 18 Dec 2019 23:54:48 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 18 Dec 2019 23:50:07 -0500
From:   Jeff King <peff@peff.net>
To:     Bryan Turner <bturner@atlassian.com>
Cc:     wuzhouhui <wuzhouhui14@mails.ucas.ac.cn>,
        Git Users <git@vger.kernel.org>
Subject: Re: How to determine a branch whether has a specified commit
Message-ID: <20191219045007.GA89333@coredump.intra.peff.net>
References: <62a8f522.6873.16f1c0243f6.Coremail.wuzhouhui14@mails.ucas.ac.cn>
 <CAGyf7-GK4SJ8oqJ-n1gCdNOq0Dwsxy4V7Eep7qXTsd51pVz7rA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGyf7-GK4SJ8oqJ-n1gCdNOq0Dwsxy4V7Eep7qXTsd51pVz7rA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 18, 2019 at 07:09:36PM -0800, Bryan Turner wrote:

> > I think
> >     git branch --contains <commit> | grep <branch name>
> 
> "Combine" the two commands: git branch --contains <commit> <branch
> name>. That will either output the branch's name, if it contains the
> commit, or nothing if it doesn't.

Or "git for-each-ref --contains <commit> refs/heads/<branch>" if you're
scripting.

> A different approach would be something like: git rev-list --count
> <commit> ^<branch name>. If that returns a count of 0, it means the
> commit is reachable from the branch. Otherwise, it'll output some
> positive count indicating how many commits (including the specific
> commit you asked about) are not reachable from the branch. (I suspect
> you don't really need the count, so you could also use "-1" instead of
> "--count".)

That works, but is not quite as careful as some other techniques with
respect to looking past commits with clock skew. A more careful way is
to check that "git merge-base <commit> <branch>" is equal to <commit>.

That clock-skew thing will eventually go away once we start using
generation numbers consistently (but I don't think we do yet in
limit_list(), which handles the "^" part of the traversal).

-Peff
