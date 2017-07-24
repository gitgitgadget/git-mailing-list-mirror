Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8D614203F3
	for <e@80x24.org>; Mon, 24 Jul 2017 16:59:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932122AbdGXQ7L (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Jul 2017 12:59:11 -0400
Received: from cloud.peff.net ([104.130.231.41]:47112 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1755811AbdGXQ7J (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jul 2017 12:59:09 -0400
Received: (qmail 5557 invoked by uid 109); 24 Jul 2017 16:59:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 24 Jul 2017 16:59:10 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10051 invoked by uid 111); 24 Jul 2017 16:59:26 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Mon, 24 Jul 2017 12:59:26 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 24 Jul 2017 12:59:07 -0400
Date:   Mon, 24 Jul 2017 12:59:07 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        David Turner <novalis@novalis.org>,
        Brandon Williams <bmwill@google.com>, git@vger.kernel.org
Subject: Re: [PATCH 21/28] commit_packed_refs(): use a staging file separate
 from the lockfile
Message-ID: <20170724165907.53zx657qmizgl4lb@sigill.intra.peff.net>
References: <cover.1497534157.git.mhagger@alum.mit.edu>
 <2779ee9a75e75ff80898e51e46d561b8074e0dc2.1497534157.git.mhagger@alum.mit.edu>
 <xmqqy3riiu0f.fsf@gitster.mtv.corp.google.com>
 <20170720233051.GB159617@aiede.mtv.corp.google.com>
 <xmqqpocuib06.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqpocuib06.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 20, 2017 at 11:01:45PM -0700, Junio C Hamano wrote:

> The general strategy we take for these atomic update of a file
> entity at $path is to:
> 
>  (1) try to create $path.lock exclusively; if we cannot, somebody
>      else holds the lock so fail (or backoff and retry, which
>      amounts to the same thing in the larger picture).
> 
>  (2) update $path.lock and close the fd.
> 
>  (3) rename $path.lock to $path atomically to unlock.
> 
> Would it be sufficent to tweak the above procedure with a new,
> zeroth step?
> 
>  (0) see $path is a symlink; if so, readlink it and assign the
>      result to $path.  Then go on to step (1) above.
> 
> I do not think such an enhancement would break atomicity guarantee
> we want from the locking.  When updating .git/packed-refs in an
> ancient new-workdir'ed directory, we would end up locking the
> corresponding file in the real repository, which is exactly what we
> want anyway.  As the basic assumption of having a symbolic link in
> the new-workdir'ed directory is that a symlink can stay the same
> forever while the linked target will be updated, I think this would
> be a reasonable short-term "fix".

This seems like the correct path to me. If the existing behavior is to
lock the referring symref, that seems like a violation of the lock
procedure in the first place. Because if "A" points to "B", we take
"A.lock" and then modify "B". But "B" may have any number of "A" links
pointing to it, eliminating the purpose of the lock.

I thought we already did this, though. And that modifying HEAD (which
might be a symlink) required LOCK_NO_DEREF.

-Peff
