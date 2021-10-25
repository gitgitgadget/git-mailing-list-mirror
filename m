Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0B09C433FE
	for <git@archiver.kernel.org>; Mon, 25 Oct 2021 16:39:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8380D60EB9
	for <git@archiver.kernel.org>; Mon, 25 Oct 2021 16:39:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234009AbhJYQl5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Oct 2021 12:41:57 -0400
Received: from cloud.peff.net ([104.130.231.41]:45704 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231258AbhJYQl4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Oct 2021 12:41:56 -0400
Received: (qmail 6044 invoked by uid 109); 25 Oct 2021 16:39:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 25 Oct 2021 16:39:33 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20570 invoked by uid 111); 25 Oct 2021 16:39:32 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 25 Oct 2021 12:39:32 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 25 Oct 2021 12:39:32 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Sixt <j6t@kdbg.org>,
        =?utf-8?Q?=C3=98ystein?= Walle <oystwa@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v2 07/10] generate-cmdlist.sh: stop sorting category lines
Message-ID: <YXbdxDcaZOVrPUBz@coredump.intra.peff.net>
References: <cover-0.8-00000000000-20211020T183533Z-avarab@gmail.com>
 <cover-v2-00.10-00000000000-20211022T193027Z-avarab@gmail.com>
 <patch-v2-07.10-f2f37c2963b-20211022T193027Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-v2-07.10-f2f37c2963b-20211022T193027Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 22, 2021 at 09:36:11PM +0200, Ævar Arnfjörð Bjarmason wrote:

> In a preceding commit we changed the print_command_list() loop to use
> printf's auto-repeat feature. Let's now get rid of get_category_line()
> entirely by not sorting the categories.
> 
> This will change the output of the generated code from e.g.:
> 
>     -       { "git-apply", N_("Apply a patch to files and/or to the index"), 0 | CAT_complete | CAT_plumbingmanipulators },
> 
> To:
> 
>     +       { "git-apply", N_("Apply a patch to files and/or to the index"), 0 | CAT_plumbingmanipulators | CAT_complete },
> 
> I.e. the categories are no longer sorted, but as they're OR'd together
> it won't matter for the end result.

Thanks for picking this up. The commit message here is well explained.

> This speeds up the generate-cmdlist.sh a bit. Comparing HEAD~ (old)
> and "master" to this code:
> 
>   'sh generate-cmdlist.sh command-list.txt' ran
>     1.07 ± 0.33 times faster than 'sh generate-cmdlist.sh.old command-list.txt'
>     1.15 ± 0.36 times faster than 'sh generate-cmdlist.sh.master command-list.txt'

Curious. I get much more dramatic results (as I'd expect, as we are
cutting out 2 of 3 process spawns in the loop):

    'sh generate-cmdlist.sh command-list.txt' ran
    2.16 ± 0.17 times faster than 'sh generate-cmdlist.sh.old command-list.txt'
    2.37 ± 0.28 times faster than 'sh generate-cmdlist.sh.master command-list.txt'

Either way, I think it's a good idea (and it paves the way for the next
patch, where we get the biggest speedup because we stop spawning any
processes at all).

-Peff
