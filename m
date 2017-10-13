Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4594B20437
	for <e@80x24.org>; Fri, 13 Oct 2017 17:35:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752769AbdJMRfZ (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Oct 2017 13:35:25 -0400
Received: from cloud.peff.net ([104.130.231.41]:52398 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751975AbdJMRfY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Oct 2017 13:35:24 -0400
Received: (qmail 31908 invoked by uid 109); 13 Oct 2017 17:35:24 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 13 Oct 2017 17:35:24 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27334 invoked by uid 111); 13 Oct 2017 17:35:26 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Fri, 13 Oct 2017 13:35:26 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 13 Oct 2017 13:35:22 -0400
Date:   Fri, 13 Oct 2017 13:35:22 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?5bCP5bed5oGt5Y+y?= <aiueogawa217@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Can I remove multiple stashed states at a time?
Message-ID: <20171013173522.vprwjwprhnoiyajy@sigill.intra.peff.net>
References: <CAC2JkrLm3QCNW1t-Yju-sA=9Tbv8hH1AHZUEDux8kSG9mkG5wg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAC2JkrLm3QCNW1t-Yju-sA=9Tbv8hH1AHZUEDux8kSG9mkG5wg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 13, 2017 at 11:58:12AM +0900, 小川恭史 wrote:

> I want to remove multiple stashed states at a time.
> 
> But "git stash drop <stash>" removes only one stashed state at a time
> and "git stash clear" remove all.
> 
> Can I do that?

There isn't a way to do it through "git stash", I don't think. The stash
feature is backed by a reflog, and the underlying machinery is capable
of it. E.g.:

  git reflog delete --updateref --rewrite refs/stash@{1} refs/stash@{2} refs/stash@{3}

works. But that's getting a bit more familiar with the innards of stash
than users should be (both because they shouldn't need to, and because
the underlying storage may be subject to change).

Probably "git stash drop" should learn to take multiple stash arguments
and pass them all along to "reflog delete".

You can also just do:

  for i in 1 2 3; do
     git stash drop $i
  done

of course. It's less efficient than a single invocation (since it has to
rewrite the whole reflog each time), but unless you have thousands of
stashes, I doubt the difference is all that noticeable.

-Peff
