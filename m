Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8B59C433F5
	for <git@archiver.kernel.org>; Mon, 11 Oct 2021 16:12:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A382A60ED4
	for <git@archiver.kernel.org>; Mon, 11 Oct 2021 16:12:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233385AbhJKQO3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Oct 2021 12:14:29 -0400
Received: from cloud.peff.net ([104.130.231.41]:37006 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231899AbhJKQO2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Oct 2021 12:14:28 -0400
Received: (qmail 29111 invoked by uid 109); 11 Oct 2021 16:12:28 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 11 Oct 2021 16:12:28 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19583 invoked by uid 111); 11 Oct 2021 16:12:27 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 11 Oct 2021 12:12:27 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 11 Oct 2021 12:12:27 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] http: check CURLE_SSL_PINNEDPUBKEYNOTMATCH when emitting
 errors
Message-ID: <YWRia5oAm4HddIe3@coredump.intra.peff.net>
References: <patch-1.1-6e65734cbce-20210924T100532Z-avarab@gmail.com>
 <20211010214209.GE571180@szeder.dev>
 <87o87wl485.fsf@evledraar.gmail.com>
 <20211011044730.GF571180@szeder.dev>
 <87k0ijlmon.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87k0ijlmon.fsf@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 11, 2021 at 03:23:02PM +0200, Ævar Arnfjörð Bjarmason wrote:

> > So it's supposed to be
> >
> >   ... a http.pinnedPubKey doesn't point to the http.pinnedPubKey
> >   variable ...
> >
> > ?  I still have no idea because of the repeated config variable name.
> 
> We emit this currently:
> 
>     $ git -c http.pinnedPubKey=sha256/someNonMatchingKey ls-remote https://github.com/git/git.git
>     fatal: unable to access 'https://github.com/git/git.git/': SSL: public key does not match pinned public key!
> 
> And with this change, this:
> 
>     $ git -c http.pinnedPubKey=sha256/someNonMatchingKey ls-remote https://github.com/git/git.git
>     fatal: unable to access 'https://github.com/git/git.git/' with http.pinnedPubkey configuration: SSL: public key does not match pinned public key!
> 
> I.e. this replaces a generic error message from curl with something that
> points the user at the config variable in question.

FWIW, I too had to stare at the commit message when I first read it.
Perhaps:

  When curl gives us an error related to http.pinnedPubKey, we pass
  along the error from curl: "public key does not match pinned public
  key". But we do not mention the http.pinnedPubKey config, so the user
  may not realize where to start looking to address this.

As you say, this is already in next, so it's too late. So just thoughts
for next time (I find this "we do X, but the problem is Y" explanation
is often more clear than "change Z", because it makes the motivation
explicit).

-Peff
