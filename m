Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9925C77B7C
	for <git@archiver.kernel.org>; Sun,  7 May 2023 13:14:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230248AbjEGNOu (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 7 May 2023 09:14:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229948AbjEGNOb (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 May 2023 09:14:31 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19FEE14E48
        for <git@vger.kernel.org>; Sun,  7 May 2023 06:14:28 -0700 (PDT)
Received: (qmail 28302 invoked by uid 109); 7 May 2023 13:14:28 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 07 May 2023 13:14:28 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23161 invoked by uid 111); 7 May 2023 13:14:27 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 07 May 2023 09:14:27 -0400
Authentication-Results: peff.net; auth=none
Date:   Sun, 7 May 2023 09:14:27 -0400
From:   Jeff King <peff@peff.net>
To:     Elijah Newren <newren@gmail.com>
Cc:     Calvin Wan <calvinwan@google.com>, git@vger.kernel.org
Subject: Re: [PATCH 0/6] strbuf cleanups
Message-ID: <20230507131427.GA1852750@coredump.intra.peff.net>
References: <20230502211454.1673000-1-calvinwan@google.com>
 <CABPp-BFagTvBTe0XbEOM_hO-vDFwVvSSmGOii1q2=7amqerwtQ@mail.gmail.com>
 <CAFySSZAOqX0pESfJ-7bYg9iR2RDB9PL6sC4Kcvr_zitdQ1kD_g@mail.gmail.com>
 <CABPp-BGc6ZK919rEH7-fOVg-nYs2wtvFP-XeQ7V9dEBEJvBYsQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABPp-BGc6ZK919rEH7-fOVg-nYs2wtvFP-XeQ7V9dEBEJvBYsQ@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, May 06, 2023 at 05:14:55PM -0700, Elijah Newren wrote:

> On Wed, May 3, 2023 at 11:00 AM Calvin Wan <calvinwan@google.com> wrote:
> >
> > While moving strbuf_add_separated_string_list() to a separate file
> > would mean that strbuf would no longer have a dependency on
> > string-list, I don't think that dependency is problematic to begin
> > with. Widening the boundary for strbuf as a string manipulation
> > library to a string and string list manipulation library seems
> > reasonable to me.
> 
> Oh, the high level idea behind string-list might make sense at this
> level, but I was assuming Peff would show up at some point and
> highlight the evils of the current string-list API[1][2][3] and how we
> should avoid using, depending on, or implementing something that acts
> like it.  :-)

You rang? :)

Yes, IMHO this strbuf_add_separated_string_list() is another example of
why string-list sucks: it doesn't degrade to a natural array type
(because the "util" magic requires a struct). If it were a strvec or
similar, we could just pass "const char **str, size_t len", which would
make the helper function simpler and more generally useful.

I know there may be other reasons to use a string-list in the caller
here, though (looks like it uses "nodup"). So as usual, the situation is
not so simple as "we should just switch types".

-Peff
