Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A592C05027
	for <git@archiver.kernel.org>; Wed,  1 Feb 2023 23:04:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229649AbjBAXD7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Feb 2023 18:03:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjBAXD6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Feb 2023 18:03:58 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E126C68125
        for <git@vger.kernel.org>; Wed,  1 Feb 2023 15:03:56 -0800 (PST)
Received: (qmail 6498 invoked by uid 109); 1 Feb 2023 23:03:56 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 01 Feb 2023 23:03:56 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25315 invoked by uid 111); 1 Feb 2023 23:03:55 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 01 Feb 2023 18:03:55 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 1 Feb 2023 18:03:55 -0500
From:   Jeff King <peff@peff.net>
To:     demerphq <demerphq@gmail.com>
Cc:     "D. Ben Knoble" <ben.knoble@gmail.com>, git@vger.kernel.org
Subject: Re: grep: fix multibyte regex handling under macOS
 (1819ad327b7a1f19540a819813b70a0e8a7f798f)
Message-ID: <Y9rv29c0dYUAYx8B@coredump.intra.peff.net>
References: <CALnO6CAZtwfGY4SYeOuKqdP9+e_0EYNf4F703DRQB7UUfd_bUg@mail.gmail.com>
 <CANgJU+X_e0owKC3uWPaA_gVP54syF1+MJ-cTn+fjPrNS5LDsMA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANgJU+X_e0owKC3uWPaA_gVP54syF1+MJ-cTn+fjPrNS5LDsMA@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 01, 2023 at 05:09:33PM +0100, demerphq wrote:

> > Failure (using Zsh to produce the characters; I think there's a Bash
> > equivalent):
> > ```
> > # git diff --word-diff --word-diff-regex=$'[\xc0-\xff][\x80-\xbf]+'
> > fatal¬†: invalid regular expression: [¿-ˇ][Ä-ø]+
> > ```
> 
> FWIW that looks pretty weird to me, like the escapes in the charclass
> were interpolated before being fed to the regex engine. Are you sure
> you tested the right thing?

I think the point is that he is feeding a raw \xc0 byte (not the escape
sequence) to the regex engine, which is bogus UTF8. And the internal
userdiff drivers do the same thing. They contain "[\xc0-\xff]", and
those "\x" will be interpolated by the compiler into their actual bytes.

So the regex engine is complaining that it is getting bytes with high
bits set, but that are not part of a multi-byte character. I.e., it is
not happy to do bytewise matching, but really wants valid UTF8 in the
expression.

glibc's regex engine seems OK with this. Try:

  git grep $'[\xc0-\xff]'

in git.git, and it will find lots of multi-byte characters. But pcre,
for example, is not:

  $ git grep -P $'[\xc0-\xff]'
  fatal: command line, '[<C0>-<FF>]': UTF-8 error: byte 2 top bits not 0x80

There you really want to feed the literal escapes (obviously dropping
the '$ shell interpolation is a better solution, but for the sake of
illustration):

  git grep -P $'[\\xc0-\\xff]'

But I don't think we can rely on the libc BRE supporting "\x" in
character classes. Glibc certainly doesn't. I'm not sure what the
portable solution is.

-Peff
