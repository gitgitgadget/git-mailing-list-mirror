Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11C4BC433FE
	for <git@archiver.kernel.org>; Wed,  2 Feb 2022 21:30:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347557AbiBBVax (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Feb 2022 16:30:53 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:53951 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347608AbiBBVan (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Feb 2022 16:30:43 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E4B0117A4E4;
        Wed,  2 Feb 2022 16:30:42 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=b+RyZtSGb6kQCJ5FOqlHvQOjIfHI2TvWCmKOCbYyh4w=; b=GMEe
        o/XJDBsvkF0wM4ag0+dXlSuUli+uat93BQbPkMHleszU0kzt1k2hMWtHjSirWr1r
        nobkDSH/1MhqpE6J1yluzOeWQB2JxBc2wyLapbtLvSKhXLpUIQ6bQT59E4bc1YSD
        kstcxam6L9n+hRsTJE/Cgb0wBpPsy6FZO9urO4s=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id DC61E17A4E3;
        Wed,  2 Feb 2022 16:30:42 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 4569217A4E2;
        Wed,  2 Feb 2022 16:30:39 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>,
        Taylor Blau <me@ttaylorr.com>,
        Johannes Altmanninger <aclopte@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Christian Couder <christian.couder@gmail.com>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Elijah Newren <newren@gmail.com>, Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v2 08/13] merge-tree: support including merge messages
 in output
References: <pull.1122.git.1642888562.gitgitgadget@gmail.com>
        <pull.1122.v2.git.1643479633.gitgitgadget@gmail.com>
        <d0d30e92ecd9dff6174a39a94a9e7d7e29896fd4.1643479633.git.gitgitgadget@gmail.com>
Date:   Wed, 02 Feb 2022 13:30:38 -0800
Message-ID: <xmqqh79hx8g1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5DE267BC-846F-11EC-BB51-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> +By default, for a successful merge, the output from git-merge-tree is
> +simply one line:
> +
> +	<OID of toplevel tree>
> +
> +Whereas for a conflicted merge, the output is by default of the form:
>  
>  	<OID of toplevel tree>
> +	<Informational messages>

Sounds useful.  This made me wonder, as the only shuffling of the
output destination in the past few steps were to send the output to
some "FILE *", how you send the findings you make while coming up
with the result _after_ the result.  It turns out that the ORT
machinery already buffers these findings in a strbuf per path, so
there is no trouble doing so ;-)

It still makes me wonder how the "send rename warnings to the
standard output stream, instead of the standard error stream" change
interacts with this change, though.  That needs to be done way
before you finish computing the result, and it does not seem to be
buffered in-core, like per-path conflict information messages.
