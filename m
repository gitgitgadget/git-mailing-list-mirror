Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C455C433FE
	for <git@archiver.kernel.org>; Tue, 29 Nov 2022 18:54:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236226AbiK2Sy0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Nov 2022 13:54:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235889AbiK2SyY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Nov 2022 13:54:24 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5584D56543
        for <git@vger.kernel.org>; Tue, 29 Nov 2022 10:54:23 -0800 (PST)
Received: (qmail 14551 invoked by uid 109); 29 Nov 2022 18:54:22 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 29 Nov 2022 18:54:22 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22320 invoked by uid 111); 29 Nov 2022 18:54:22 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 29 Nov 2022 13:54:22 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 29 Nov 2022 13:54:21 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Ping Yin <pkufranky@gmail.com>,
        mailinggit list <git@vger.kernel.org>
Subject: Re: [bug] git diff --word-diff gives wrong result for utf-8 chinese
Message-ID: <Y4ZVXWNHO25IFYQL@coredump.intra.peff.net>
References: <CACSwcnQfTOYHxSJQqc+viiqkCqt=WZieuCw70PqOdvo88XdeOQ@mail.gmail.com>
 <221129.867czejabi.gmgdl@evledraar.gmail.com>
 <xmqqlenu2dxx.fsf@gitster.g>
 <Y4ZOHwwgtztwhbhr@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y4ZOHwwgtztwhbhr@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 29, 2022 at 01:23:27PM -0500, Jeff King wrote:

> > I suspect that "--word-diff" internal is not even aware what a
> > character is, but if you assume UTF-8 (precomposed), then you should
> > be able to tell where the character boundary is by only looking at
> > the high-bit patterns to avoid producing such an output.
> 
> Agreed that we should probably avoid breaking characters. But what
> puzzles me more is that we break it between B8 and BA, and not
> elsewhere. Why not between E4 and B8? Why not between BA and "1"?
> 
> If the rule is "break on ascii whitespace", then I'd have expected the
> whole four-character sequence to be taken as a unit. In other words, it
> does should not have to care that a character is, as long as the bytes
> for space characters cannot appear inside other characters (which is
> true of utf8).

Even more puzzling is that it produces the expected output for me:

  [note that \x is a bash-ism]
  $ printf '\xe4\xb8\xba1' >one
  $ printf '\xe4\xb8\xba2' >two
  $ git diff --no-index --word-diff one two
  diff --git a/one b/two
  index 9ae469fc41..576e6e32d8 100644
  --- a/one
  +++ b/two
  @@ -1 +1 @@
  [-为1-]{+为2+}

I wonder if OP has diff.wordRegex config (or attributes triggering a
diff.*.wordRegex) that is doing something else.

-Peff
