Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A24681F42D
	for <e@80x24.org>; Sat, 12 May 2018 08:45:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750854AbeELIp0 (ORCPT <rfc822;e@80x24.org>);
        Sat, 12 May 2018 04:45:26 -0400
Received: from cloud.peff.net ([104.130.231.41]:37046 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750722AbeELIpZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 12 May 2018 04:45:25 -0400
Received: (qmail 23279 invoked by uid 109); 12 May 2018 08:45:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 12 May 2018 08:45:25 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13448 invoked by uid 111); 12 May 2018 08:45:30 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Sat, 12 May 2018 04:45:30 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 12 May 2018 04:45:23 -0400
Date:   Sat, 12 May 2018 04:45:23 -0400
From:   Jeff King <peff@peff.net>
To:     Surenkumar Nihalani <suren.k.n@icloud.com>
Cc:     git@vger.kernel.org
Subject: Re: Bug report for git push
Message-ID: <20180512084523.GA28279@sigill.intra.peff.net>
References: <27C6F6E9-2F80-48A6-B551-4AE9957C98A5@icloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <27C6F6E9-2F80-48A6-B551-4AE9957C98A5@icloud.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 11, 2018 at 09:44:54PM -0400, Surenkumar Nihalani wrote:

> Push summary: [remote rejected] (cannot lock ref 'refs/heads/master': is at cf2cc0c147d8215ec87d3ddaf32f0b2c58630423 but expected fdda486ad43a6e6b5dc5f2795ce27124e0686752)

This generally indicates that somebody was pushing at the same time as
you, and you lost the race. The push conversation works basically like
this:

 1. server advertise master at some sha1 (like fdda486ad)

 2. client checks that moving from fdda486ad to whatever the new value is
    (let's say 1234abcd) matches its criteria (e.g., not a fast-forward)
    and prepares a pack with the appropriate objects

 3. client tells server "update master from fdda486ad to 1234abcd"

 4. server locks master and then under lock checks that it's still at
    fdda486ad. In this case it's not, so it aborts the lock. This is
    likely due to somebody else pushing in the interim.

If you push again at this point, the client will notice in step that
it's not a fast-forward and give you the "somebody else has pushed, you
need to pull first" error message.

The only difference here is that because of the timing (i.e., somebody
pushing at the exact same time as you), only the server's locking
operation noticed the conflict. But the fix is the same (pull their
work, then push).

-Peff
