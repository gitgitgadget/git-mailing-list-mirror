Return-Path: <SRS0=mOGp=6L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53A94C4CECC
	for <git@archiver.kernel.org>; Mon, 27 Apr 2020 19:19:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4429F20775
	for <git@archiver.kernel.org>; Mon, 27 Apr 2020 19:19:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726508AbgD0TS7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Apr 2020 15:18:59 -0400
Received: from cloud.peff.net ([104.130.231.41]:41274 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726315AbgD0TS7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Apr 2020 15:18:59 -0400
Received: (qmail 15496 invoked by uid 109); 27 Apr 2020 19:18:59 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 27 Apr 2020 19:18:59 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26893 invoked by uid 111); 27 Apr 2020 19:30:20 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 27 Apr 2020 15:30:20 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 27 Apr 2020 15:18:58 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>,
        git@vger.kernel.org, dirk@ed4u.de, sunshine@sunshineco.com
Subject: Re: [PATCH v3] git-credential-store: skip empty lines and comments
 from store
Message-ID: <20200427191858.GB1728884@coredump.intra.peff.net>
References: <20200427084235.60798-1-carenas@gmail.com>
 <20200427125915.88667-1-carenas@gmail.com>
 <xmqqftco94wx.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqftco94wx.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 27, 2020 at 11:09:34AM -0700, Junio C Hamano wrote:

> > modified store files which might have empty lines or even comments
> > were reported[1] failing to parse as valid credentials.
> 
> These files are not supposed to be viewed or edited without the help
> of the credential helpers.  Do these blank lines and comments even
> survive when a new credential is approved, or do we just overwrite
> and lose them?

That's a good question. In the older code we do save them, because
credential-store passes through lines which don't match the credential
we're operating on.

But in Carlo's patch, the immediate "continue" means we wouldn't ever
call "other_cb", which is what does that pass-through.

> I'd rather not to do either, if we did not have to, but if it were
> necessary for us to do something, I am OK to ignore empty lines.
> But I'd prefer not to mix the new "# comment" feature in, if we did
> not have to.
> 
> Also, triming the lines that are not empty is unwarranted.  IIUC,
> what the "store" action writes encodes whitespaces, so as soon as
> you see whitespace on either end, (or anywhere on the line for that
> matter), it is a hand-edited cruft in the file.  If you ignore
> comments, you probably should ignore those lines, too.

Yeah, all of that seems quite sensible.

-Peff
