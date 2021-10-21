Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 857B4C433F5
	for <git@archiver.kernel.org>; Thu, 21 Oct 2021 16:27:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B5436137C
	for <git@archiver.kernel.org>; Thu, 21 Oct 2021 16:27:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231865AbhJUQ3X (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Oct 2021 12:29:23 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:58513 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230187AbhJUQ3W (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Oct 2021 12:29:22 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 6A6AD161000;
        Thu, 21 Oct 2021 12:27:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=U+OmbmDMhaT6Be+I2l6nAg59KyrroCwxSezSY9
        s7Lak=; b=V3+99Sz+115mLrrqLvvSdzREHkbtHezwfljm1ZkZ8fCZAv1lqlgvxs
        DOXd3463xQmLg0i8TU9TN0ubg+o8Y7C8l6pyo2L+80C7uMhCWmPUpjO3A/c0hJNw
        kkJftBJ9czogskAtl5NpCteK6S0lI946jpwMgOdJWarkqyw1desfY=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 62CC4160FFF;
        Thu, 21 Oct 2021 12:27:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id BEC0C160FFE;
        Thu, 21 Oct 2021 12:27:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, avarab@gmail.com, dstolee@microsoft.com,
        peff@peff.net
Subject: Re: [PATCH 02/11] midx.c: don't leak MIDX from verify_midx_file
References: <cover.1634787555.git.me@ttaylorr.com>
        <b0c79904ab7bdaee7a1bc7a55b0fb26b1f2cf8d3.1634787555.git.me@ttaylorr.com>
Date:   Thu, 21 Oct 2021 09:27:02 -0700
In-Reply-To: <b0c79904ab7bdaee7a1bc7a55b0fb26b1f2cf8d3.1634787555.git.me@ttaylorr.com>
        (Taylor Blau's message of "Wed, 20 Oct 2021 23:39:50 -0400")
Message-ID: <xmqqr1cemjhl.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B9A346F6-328B-11EC-A359-98D80D944F46-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> The function midx.c:verify_midx_file() allocate a MIDX struct by calling
> load_multi_pack_index(). But when cleaning up, it calls free() without
> freeing any resources associated with the MIDX.
>
> Call the more appropriate close_midx() which does free those resources,
> which causes t5319.3 to pass when Git is compiled with SANITIZE=leak.

Nice.

By the way, the function starts like so:

    int verify_midx_file(struct repository *r, const char *object_dir, unsigned flags)
    {
            struct pair_pos_vs_id *pairs = NULL;
            uint32_t i;
            struct progress *progress = NULL;
            struct multi_pack_index *m = load_multi_pack_index(object_dir, 1);
            verify_midx_error = 0;

            if (!m) {
                    int result = 0;
                    struct stat sb;
                    char *filename = get_midx_filename(object_dir);
                    if (!stat(filename, &sb)) {
                            error(_("multi-pack-index file exists, but failed to parse"));
                            result = 1;
                    }
                    free(filename);
                    return result;
            }

but after seeing die() sprinkled in load_multi_pack_index() with
checks during parsing, I am not sure if this is a good error
reporting mechanism we are seeing here.

It is wonderful to plug leaks here and there, but to be honest, even
with only a very little parts I saw in this code, I think there are
other things that need clean-up here.

Also, the way the file-scope global verify_midx_error is used is
beyond words _ugly_, if the only reason for its use is to make
midx_report() look simpler, which is what I think is happening.

Not very impressed, but all of the above is not a new issue
introduced by this patch.

Thanks.
