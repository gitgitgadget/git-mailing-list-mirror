Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E259DC76196
	for <git@archiver.kernel.org>; Thu,  6 Apr 2023 23:23:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230509AbjDFXXT (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Apr 2023 19:23:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbjDFXXS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Apr 2023 19:23:18 -0400
X-Greylist: delayed 2847 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 06 Apr 2023 16:23:16 PDT
Received: from bsmtp5.bon.at (bsmtp5.bon.at [195.3.86.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48AA0558A
        for <git@vger.kernel.org>; Thu,  6 Apr 2023 16:23:16 -0700 (PDT)
Received: from bsmtp2.bon.at (unknown [192.168.181.105])
        by bsmtp5.bon.at (Postfix) with ESMTPS id 4PsxD32dxZz5tlG
        for <git@vger.kernel.org>; Fri,  7 Apr 2023 00:35:47 +0200 (CEST)
Received: from [192.168.0.98] (unknown [93.83.142.38])
        by bsmtp2.bon.at (Postfix) with ESMTPSA id 4PsxCx6NcPz5tlC;
        Fri,  7 Apr 2023 00:35:41 +0200 (CEST)
Message-ID: <7fe0aa93-a764-66b0-5015-2f5fbd3901ab@kdbg.org>
Date:   Fri, 7 Apr 2023 00:35:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] userdiff: support regexec(3) with multi-byte support
To:     =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>, Diomidis Spinellis <dds@aueb.gr>,
        Eric Sunshine <sunshine@sunshineco.com>,
        demerphq <demerphq@gmail.com>,
        Mario Grgic <mario_grgic@hotmail.com>,
        "D. Ben Knoble" <ben.knoble@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
References: <CAPig+cSNmws2b7f7aRA2C56kvQYG3w_g+KhYdqhtmf+XhtAMhQ@mail.gmail.com>
 <b45bf46f-580a-870c-5293-10ecdf2e56d3@aueb.gr>
 <b8b3777b-ee6e-d90e-3365-5cb9c9d129fe@web.de>
 <c4728fac-bea9-3794-077e-c978d99f46bf@web.de> <xmqq5yad7wv3.fsf@gitster.g>
 <bc6e89c9-d886-c519-85b3-fbc3f4eb5528@web.de>
 <7327ac06-d5da-ec53-543e-78e7729e78bb@web.de>
Content-Language: en-US
From:   Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <7327ac06-d5da-ec53-543e-78e7729e78bb@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 06.04.23 um 22:19 schrieb René Scharfe:
> Since 1819ad327b (grep: fix multibyte regex handling under macOS,
> 2022-08-26) we use the system library for all regular expression
> matching on macOS, not just for git grep.  It supports multi-byte
> strings and rejects invalid multi-byte characters.
> 
> This broke all built-in userdiff word regexes in UTF-8 locales because
> they all include such invalid bytes in expressions that are intended to
> match multi-byte characters without explicit support for that from the
> regex engine.
> 
> "|[^[:space:]]|[\xc0-\xff][\x80-\xbf]+" is added to all built-in word
> regexes to match a single non-space or multi-byte character.  The \xNN
> characters are invalid if interpreted as UTF-8 because they have their
> high bit set, which indicates they are part of a multi-byte character,
> but they are surrounded by single-byte characters.

Perhpas the expression should be "[\xc4\x80-\xf7\xbf\xbf\xbf]+", i.e.,
sequences of code points U+0080 to U+10FFFF?

> 
> Replace that expression with "|[^[:space:]]" if the regex engine
> supports multi-byte matching, as there is no need to have an explicit
> range for multi-byte characters then.

This is not equivalent. The original treated a sequence of non-ASCII
characters as a word. The new version treats each individual non-space
character (both ASCII and non-ASCII) as a word.

> Additionally the word regex for tex contains the expression
> "[a-zA-Z0-9\x80-\xff]+" with a similarly invalid range.  The best
> replacement with only valid characters that I can come up with is
> "([a-zA-Z0-9]|[^\x01-\x7f])+".  Unlike the original it matches NUL
> characters, though.  Assuming that tex files usually don't contain NUL
> this should be acceptable.

This is acceptable, of course. The replacement range looks sensible.

-- Hannes

