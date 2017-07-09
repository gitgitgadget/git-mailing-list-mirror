Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C75CE20357
	for <e@80x24.org>; Sun,  9 Jul 2017 10:08:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751774AbdGIKIq (ORCPT <rfc822;e@80x24.org>);
        Sun, 9 Jul 2017 06:08:46 -0400
Received: from cloud.peff.net ([104.130.231.41]:34740 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751122AbdGIKIp (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Jul 2017 06:08:45 -0400
Received: (qmail 3433 invoked by uid 109); 9 Jul 2017 10:08:39 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sun, 09 Jul 2017 10:08:39 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 32460 invoked by uid 111); 9 Jul 2017 10:08:51 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Sun, 09 Jul 2017 06:08:51 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 09 Jul 2017 06:08:38 -0400
Date:   Sun, 9 Jul 2017 06:08:38 -0400
From:   Jeff King <peff@peff.net>
To:     Kyle Meyer <kyle@kyleam.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Sahil Dua <sahildua2305@gmail.com>, Eric Wong <e@80x24.org>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v2 6/7] reflog-walk: stop using fake parents
Message-ID: <20170709100837.kr5fs2kva6bdrole@sigill.intra.peff.net>
References: <20170707090507.ko2ygry7j4zv7t3s@sigill.intra.peff.net>
 <20170707091407.nm4pm3bdvx6alohs@sigill.intra.peff.net>
 <87van48cpu.fsf@kyleam.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87van48cpu.fsf@kyleam.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 07, 2017 at 11:54:05AM -0400, Kyle Meyer wrote:

> Jeff King <peff@peff.net> writes:
> 
> >      Prior to this commit, we show both entries with
> >      identical reflog messages. After this commit, we show
> >      only the "comes back" entry. See the update in t3200
> >      which demonstrates this.
> >
> >      Arguably either is fine, as the whole double-entry
> >      thing is a bit hacky in the first place. And until a
> >      recent fix, we truncated the traversal in such a case
> >      anyway, which was _definitely_ wrong.
> 
> Yeah, I agree that the double-entry thing is a bit hacky and only
> showing the "comes back" entry makes sense.
> 
> And with this change, I believe that the display of a rename event will
> be the same for HEAD's log and the renamed branch's log, despite the
> underlying entries having a different representation.

There's one minor difference: the numbering for HEAD will show a "hole"
in the reflog. So on the branch you might see something like:

  $ git log -g --oneline other
  269000b other@{0}: Branch: renamed refs/heads/master to refs/heads/other
  269000b other@{1}: commit (initial): foo

but the HEAD reflog will show:

  $ git log -g --oneline HEAD
  269000b HEAD@{0}: Branch: renamed refs/heads/master to refs/heads/other
  269000b HEAD@{2}: commit (initial): foo

This is pretty minor. I do wonder if there are other bits that might be
confused, though. Looking at the hole is odd:

  $ git show --oneline HEAD@{1}
  warning: Log for ref HEAD unexpectedly ended on Sun, 9 Jul 2017 06:07:05 -0400.
  269000b foo

Despite the warning, we do seem to correctly walk past it, though:

  $ git show --oneline HEAD@{2}
  269000b foo

-Peff
