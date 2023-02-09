Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D874C05027
	for <git@archiver.kernel.org>; Thu,  9 Feb 2023 13:15:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230076AbjBINPv (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Feb 2023 08:15:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230045AbjBINPr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Feb 2023 08:15:47 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D6B15EBFC
        for <git@vger.kernel.org>; Thu,  9 Feb 2023 05:15:26 -0800 (PST)
Received: (qmail 659 invoked by uid 109); 9 Feb 2023 13:15:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 09 Feb 2023 13:15:10 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12902 invoked by uid 111); 9 Feb 2023 13:15:10 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 09 Feb 2023 08:15:10 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 9 Feb 2023 08:15:09 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     William Blevins <wblevins001@gmail.com>, git@vger.kernel.org
Subject: Re: Unexpected (bug-like) behavior in `git ls-remote` matching.
Message-ID: <Y+Tx3Z45SlMJqDfh@coredump.intra.peff.net>
References: <CALJHx121C+=mAmfWxko0PUy1QBjfezM4ft6uE1+cyiH3gaLQ2w@mail.gmail.com>
 <xmqqedr0vd1l.fsf@gitster.g>
 <CALJHx12DetwZ=+aMEG6Ss4P3fMTeLN2styXuPw93C5N6yg98NA@mail.gmail.com>
 <Y+POCxHMzrZj2bwz@coredump.intra.peff.net>
 <xmqq357gt5s9.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq357gt5s9.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 08, 2023 at 09:40:06AM -0800, Junio C Hamano wrote:

> > Likewise, something more elaborate like full-path globbing or even
> > regex matching would be possible, but would need to be activated by an
> > option.
> 
> True.  We should be able to do a bit better than just tail-matching
> with an option.
> 
> I would not recommend sending over regex as protocol capability the
> same way as ref-prefix works, unless we adopt something that can
> match linear-time like re2 and use it everywhere, as you can send a
> pattern that is deliberately made inefficient to inconvenience the
> other side.

Yeah, I should not even have mentioned regex. It was really meant as "if
you really wanted to go wild, you could do something as crazy as
regexes". But I agree that we would never want to pass regexes over the
wire. If we want to make things more efficient, prefix-matching is the
way. If we want to make things more ergonomic for the client-side user,
then we should stick to globbing (which we already do, but we could do
things like full-string globs rather than strict tail-matching).

But I would hold off on all of that until somebody has a concrete case
that shows why their preferred matching scheme is useful.

-Peff
