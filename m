Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D992C1F461
	for <e@80x24.org>; Wed, 28 Aug 2019 23:47:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726948AbfH1XrI (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Aug 2019 19:47:08 -0400
Received: from cloud.peff.net ([104.130.231.41]:60536 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726400AbfH1XrH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Aug 2019 19:47:07 -0400
Received: (qmail 27662 invoked by uid 109); 28 Aug 2019 23:47:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 28 Aug 2019 23:47:07 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16725 invoked by uid 111); 28 Aug 2019 23:48:34 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 28 Aug 2019 19:48:34 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 28 Aug 2019 19:47:06 -0400
From:   Jeff King <peff@peff.net>
To:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc:     git@vger.kernel.org
Subject: Re: Is git clone followed by git verify-tag meaningful?
Message-ID: <20190828234706.GB25355@sigill.intra.peff.net>
References: <20190828203224.GE26001@chatter.i7.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190828203224.GE26001@chatter.i7.local>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 28, 2019 at 04:32:24PM -0400, Konstantin Ryabitsev wrote:

> If I know that a project uses tag signing, would "git clone" followed by
> "git verify-tag" be meaningful without a "git fsck" in-between? I.e. if an
> attacker has control over the remote server, can they sneak in any badness
> into any of the resulting files and still have the clone, checkout, and
> verify-tag return success unless the repository is fsck'd before verify-tag?

It depends on your definition of badness. :)

Generally, Git clients do not trust the server much at all (not only to
be no malicious, but also not to accidentally introduce bit errors).

Even without the fsck, we will compute the sha1 of each object (we must,
because the other side doesn't send it at all), and that we have all
objects reachable from the refs. So verifying the tag at that point
demonstrates a signature on the tag object, which refers to probably
some commit via sha1, which refers to actual trees and blobs by a chain
of sha1s. If you believe in the integrity of sha1, then it has
effectively signed all of that content.

Likewise, Git does not necessarily trust what is in the objects. A
malicious repository could claim to store an entry for ".git/config" or
"/etc/passwd". Without any further action from you, we'd detect and
reject those during a checkout.

If you want to analyze each object for such malformed bits before the
checkout, you can do so with "git fsck". But consider instead setting
transfer.fsckObjects to check the objects while they're being indexed by
the initial clone (i.e., having their sha1's computed). It's effectively
free to do it at that point, whereas a later fsck has to access each
object again (this takes on the order of minutes of CPU for the kernel).

I don't think there's any real safety in doing so for the case you've
described (there's no bad pattern that fsck knows about that the actual
checkout code does not).  But it does give you an early warning, and is
especially help if you're not planning to check things out yourself, but
want to avoid hosting malicious repos.

-Peff
