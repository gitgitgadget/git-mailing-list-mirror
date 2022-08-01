Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FD0AC00144
	for <git@archiver.kernel.org>; Mon,  1 Aug 2022 18:04:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232995AbiHASE6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Aug 2022 14:04:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231979AbiHASEz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Aug 2022 14:04:55 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F4218237EE
        for <git@vger.kernel.org>; Mon,  1 Aug 2022 11:04:54 -0700 (PDT)
Received: (qmail 698 invoked by uid 109); 1 Aug 2022 18:04:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 01 Aug 2022 18:04:54 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23625 invoked by uid 111); 1 Aug 2022 18:04:54 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 01 Aug 2022 14:04:54 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 1 Aug 2022 14:04:53 -0400
From:   Jeff King <peff@peff.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git List Mailing <git@vger.kernel.org>
Subject: Re: "git symbolic-ref" doesn't do a very good job
Message-ID: <YugVxaej5LdX4S8r@coredump.intra.peff.net>
References: <CAHk-=wh9f0EmsNFgoxUa8BzVej06+7MbLr-MLBjDjtj_=Pf90A@mail.gmail.com>
 <CAHk-=wg9LaHeg0UmZ90gLOaBpO-5fhoaH22iNNm=1eror95pFg@mail.gmail.com>
 <YuXKaLXhnR3mVlWk@coredump.intra.peff.net>
 <xmqqzggpyu7q.fsf@gitster.g>
 <YugPER9UsH1z6MZo@coredump.intra.peff.net>
 <CAHk-=wg8EaHnM_OcHrw=+sT3VPAkTUpzeaQ8EjTDLUENK58HSw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wg8EaHnM_OcHrw=+sT3VPAkTUpzeaQ8EjTDLUENK58HSw@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 01, 2022 at 10:49:26AM -0700, Linus Torvalds wrote:

> Hmm. Looking at that again - even without ALLOW_ONELEVEL I don't
> actually think check_refname_format() requires "refs/" per se. So the
> HEAD check isn't actually made redundant.
> 
> I wonder what the intended semantic meaning of ALLOW_ONELEVEL really
> is supposed to be. It seems to really only require *one* slash - but
> it doesn't really end up checking that it's in the "refs/" hierarchy,
> it can be anywhere.

I'm actually not that surprised. I think the history of that flag
is...weird. I think once upon a time, there was "one-level" checking
which was meant to disallow "refs/foo" versus "refs/heads/foo". But
there were also spots that wanted to make sure we were in refs/, and not
touching MERGE_HEAD, etc.

And because of the generic-ness of the flag name, those two cases got
conflated. I think it's mostly been sorted out over the years, but I
won't be surprised if there are weird corner cases.

> Maybe the refs/ protection comes in somewhere later, I didn't really
> go around to check.

I didn't check where, but I did confirm that the "symbolic-ref HEAD foo"
case in t1401 continues to pass even if we remove the special HEAD code.
So _something_ is doing it. ;)

-Peff
