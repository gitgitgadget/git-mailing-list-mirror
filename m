Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7810C433FE
	for <git@archiver.kernel.org>; Wed, 19 Oct 2022 15:41:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231620AbiJSPly (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Oct 2022 11:41:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231823AbiJSPlY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Oct 2022 11:41:24 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F7301DCCE9
        for <git@vger.kernel.org>; Wed, 19 Oct 2022 08:37:35 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 5C7801C0864;
        Wed, 19 Oct 2022 11:36:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ozF07/2ysEKH9g4XoO8H+4ENUzwvqHHmKW47Tl
        01n9s=; b=GIRex6YWp+DpBDr/LU8B5T8IFgm5KOXzH5xR4fUqf9ICwI4kAA86s4
        4sJNzNZALKE5+QhtMAcu+OzpfPhgNh2jJ0f56Ct08OyUKtWHuOEnmRpwS/2crx4n
        o35RrymcL/pqidnZ0CNcUTzkYEb4ICVIimaY1NStgFOJWaMHjL+U8=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 54F911C0863;
        Wed, 19 Oct 2022 11:36:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 82AD91C0860;
        Wed, 19 Oct 2022 11:36:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        Victoria Dye <vdye@github.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH] Makefile: force -O0 when compiling with SANITIZE=leak
References: <Y07yeEQu+C7AH7oN@nand.local>
        <Y08BPbWBj7SNluXq@coredump.intra.peff.net>
        <Y08JZVDgJpJvrBiz@coredump.intra.peff.net>
Date:   Wed, 19 Oct 2022 08:36:17 -0700
In-Reply-To: <Y08JZVDgJpJvrBiz@coredump.intra.peff.net> (Jeff King's message
        of "Tue, 18 Oct 2022 16:15:33 -0400")
Message-ID: <xmqqfsfju8pa.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C67AF698-4FC3-11ED-8F21-C2DA088D43B2-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Subject: Makefile: force -O0 when compiling with SANITIZE=leak
>
> Compiling with -O2 can interact badly with LSan's leak-checker, causing
> false positives. Imagine a simplified example like:
>
>   char *str = allocate_some_string();
>   if (some_func(str) < 0)
>           die("bad str");
>   free(str);
>
> The compiler may eliminate "str" as a stack variable, and just leave it
> in a register. The register is preserved through most of the function,
> including across the call to some_func(), since we'd eventually need to
> free it. But because die() is marked with NORETURN, the compiler knows
> that it doesn't need to save registers, and just clobbers it.

Yup, this is one weak point in the runtime checker in that it must
see the pointer held in the stack or register to ignore a still
reachable cruft that does not matter upon program exit, which cannot
work well with certain optimizations.

Theoretically there may be no guarantee that -O0 would disable all
optimizations that are potentially problematic to what LSan expects
to see, but I fully agree with you that this is the right direction.

Will queue.  Thanks.
