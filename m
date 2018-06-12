Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 666001F403
	for <e@80x24.org>; Tue, 12 Jun 2018 09:48:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933110AbeFLJsw (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Jun 2018 05:48:52 -0400
Received: from cloud.peff.net ([104.130.231.41]:42248 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S932639AbeFLJsv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Jun 2018 05:48:51 -0400
Received: (qmail 26250 invoked by uid 109); 12 Jun 2018 09:48:51 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 12 Jun 2018 09:48:51 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22228 invoked by uid 111); 12 Jun 2018 09:49:06 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 12 Jun 2018 05:49:06 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 12 Jun 2018 05:48:49 -0400
Date:   Tue, 12 Jun 2018 05:48:49 -0400
From:   Jeff King <peff@peff.net>
To:     Kirill Smelkov <kirr@nexedi.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Brandon Williams <bmwill@google.com>,
        Takuto Ikuta <tikuta@chromium.org>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Git List <git@vger.kernel.org>
Subject: Re: [PATCH v2] fetch-pack: don't try to fetch peel values with --all
Message-ID: <20180612094849.GB26123@sigill.intra.peff.net>
References: <20180610143231.7131-1-kirr@nexedi.com>
 <20180611042016.GA31642@sigill.intra.peff.net>
 <20180611044710.GB31642@sigill.intra.peff.net>
 <CAPig+cT73d0rYoSbt7oHVG4MYHVvjKidP0ogRwV+9F73jcjZEA@mail.gmail.com>
 <20180611055357.GA16430@sigill.intra.peff.net>
 <20180611094255.GA15563@deco.navytux.spb.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180611094255.GA15563@deco.navytux.spb.ru>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 11, 2018 at 09:43:02AM +0000, Kirill Smelkov wrote:

> > Looking deeper, we do not need these trees and blobs at all. The problem
> > is really just a tag that peels to an object that is not otherwise a ref
> > tip, regardless of its type.
> 
> Thanks for feedback and for coming up with the fix. Sure, I'm ok with
> moving the test into your patch. However, even if a test becomes
> different - narrowing down root of _current_ problem, I suggest to also
> keep explicitly testing tag-to-blob and tag-to-tree (and if we really
> also want tag-to-commit and tag-to-tag) behaviour. Reason is: if we skip
> those now, they can potentially break in the future.

Yeah, I have no problem testing these cases separately. There's no bug
with them now, but it is a slightly uncommon case. My suggestion would
be to submit a patch that goes on top of mine that covers these cases.

> I would also suggest to fix upload-pack, as it is just not consistent to
> reject sending objects that were advertised, and so can strike again
> some way in the future. After all git.git's fetch-pack is not the only
> git client that should be possible to interact with git.git's
> upload-pack on remote side, right?

No, it's not the only client. At the same time, I am on the fence over
whether upload-pack's behavior is wrong or not. It depends what you take
a peeled advertisement line to mean. Does it mean: this object has been
advertised and clients should be able to fetch it? Or does it mean: by
the way, you may be interested to know the peeled value of this tag in
case you want to do tag-following?

So far I think it has only meant the latter. I could see an argument for
the former, but any client depending on that would never have worked,
AFAICT. We could _make_ it work, but how would a client know which
server version it's talking to (and therefore whether it is safe to make
the request?). I think you'd have to add a capability to negotiate.

> I'm not sure, but I would say that `fetch-pack --all` from an empty
> repository should not fail and should just give empty output as fetch
> does.

Yeah, that seems reasonable to me. The die() that catches this dates
back to 2005-era, and we later taught the "fetch" porcelain to handle
this. I don't _think_ anybody would be upset that the plumbing learned
to treat this as a noop. It's probably a one-liner change in
fetch_pack() to return early instead of dying.

> For the reference all the cases presented here are real - they appear in
> our repositories on lab.nexedi.com for which I maintain the backup, and
> I've noticed them in the process of switching git-backup from using
> fetch to fetch-pack here:
> 
> https://lab.nexedi.com/kirr/git-backup/blob/0ab7bbb6/git-backup.go#L436

I applaud you using the porcelain for your scripts, but I suspect that
fetch-pack by itself is not at all well-used or well-tested these days
(certainly this --all bug has been around for almost 6 years and is not
very hard to trigger in practice).

If an extra connection isn't a problem, you might be better off with
"git ls-remote", and then picking through the results for refs of
interest, and then "git fetch-pack" to actually get the pack. That's how
git-fetch worked when it was a shell script (e.g., see c3a200120d, the
last shell version).

It may also be sane to just use "git fetch", which I'd say is _fairly_
safe to script. Of course I have no problem if you want to fix all of
the corner cases in fetch-pack. Just giving you fair warning. :)

-Peff
