Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF924C432BE
	for <git@archiver.kernel.org>; Mon, 30 Aug 2021 16:55:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BECDC60FED
	for <git@archiver.kernel.org>; Mon, 30 Aug 2021 16:55:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237874AbhH3Q4T (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Aug 2021 12:56:19 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60146 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237866AbhH3Q4Q (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Aug 2021 12:56:16 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 83014D2A79;
        Mon, 30 Aug 2021 12:55:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=u14bMMqD6WA9DVr6rpeZjxT0HvDnibKKifCKEG
        mJewY=; b=hcOYse44V45Z5egJbEsbQfnVZ42KomU6hlR63qsvgLEEsBMMIxTSB9
        FDSTLN/kN6DGebhW9I9Uwnz+yQ6ZDxd4w3bK/aF/2JDU01IV+eZvPiiiiBS9r0Cv
        oX4OLVXCSWCxjDAhETI1PHtdNpDQuR6MjFga6I1sIKGhpHVjPj3Bw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7929BD2A78;
        Mon, 30 Aug 2021 12:55:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.116.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id EB0BAD2A77;
        Mon, 30 Aug 2021 12:55:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Git List <git@vger.kernel.org>
Subject: Re: [PATCH] merge-recursive: use fspathcmp() in path_hashmap_cmp()
References: <512abaef-d71c-9308-6a62-f37b4de69e60@web.de>
        <YSvsQcGNpCMZwS8o@nand.local>
Date:   Mon, 30 Aug 2021 09:55:17 -0700
In-Reply-To: <YSvsQcGNpCMZwS8o@nand.local> (Taylor Blau's message of "Sun, 29
        Aug 2021 16:21:21 -0400")
Message-ID: <xmqqeeaa6fey.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0DF87A16-09B3-11EC-8A3F-D601C7D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> Looks obviously right to me. I found another spot in
> t/helper/test-hashmap.c:test_entry_cmp() that could be cleaned up in the
> same way. But this looks fine with or without the following diff:

> diff --git a/t/helper/test-hashmap.c b/t/helper/test-hashmap.c
> index 36ff07bd4b..ab34bdfecd 100644
> --- a/t/helper/test-hashmap.c
> +++ b/t/helper/test-hashmap.c
> @@ -28,10 +28,7 @@ static int test_entry_cmp(const void *cmp_data,
>         e1 = container_of(eptr, const struct test_entry, ent);
>         e2 = container_of(entry_or_key, const struct test_entry, ent);
>
> -       if (ignore_case)
> -               return strcasecmp(e1->key, key ? key : e2->key);
> -       else
> -               return strcmp(e1->key, key ? key : e2->key);
> +       return fspathcmp(e1->key, key ? key : e2->key);

Sorry but I think this patch is wrong.  Before the precontext of the
patch, there is a local variable decl for ignore_case---the existing
code looks at ignore_case that is different from the global
ignore_case fspathcmp() looks at.

Admittedly, it was probably not an excellent idea to give a name so
bland and unremarkable, 'ignore_case', to a global that affects so
many code paths in the system.  But the variable is already very
established that renaming it would not contribute to improving the
code at all.

It however may not be a bad idea to catch these code paths where a
local variable masks 'ignore_case' (and possibly other globals) and
rename these local ones to avoid a mistake like this.

Thanks.
