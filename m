Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39EB7C433EF
	for <git@archiver.kernel.org>; Fri,  5 Nov 2021 18:52:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C6A860EE9
	for <git@archiver.kernel.org>; Fri,  5 Nov 2021 18:52:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233079AbhKESy7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Nov 2021 14:54:59 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56210 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229926AbhKESy6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Nov 2021 14:54:58 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 17FC4E67D0;
        Fri,  5 Nov 2021 14:52:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=t0gGbiwJos9tCIcwOkjUj5k8PSRUnohU9fotCb
        3MMfM=; b=C2nYD8hKuhOyjB+ll/GP3KbM4vilDhENgQAZa0hikjuiwtm+mgIJiO
        63QQNgj0IbViSb/FY4Bveo0WIUw/q1W4tbhQQLe3K32Ug627OCYGCF1Gx8BwFFjB
        cxzASMwMxwT9RevZzbCnzWLikY62wBhGH5nuObvXu+g8CM86cW8aM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0F50BE67CF;
        Fri,  5 Nov 2021 14:52:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 6D533E67CE;
        Fri,  5 Nov 2021 14:52:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH] test_bitmap_hashes(): handle repository without bitmaps
References: <YYTy6+DG5guzJIO7@coredump.intra.peff.net>
Date:   Fri, 05 Nov 2021 11:52:16 -0700
In-Reply-To: <YYTy6+DG5guzJIO7@coredump.intra.peff.net> (Jeff King's message
        of "Fri, 5 Nov 2021 05:01:31 -0400")
Message-ID: <xmqq35oaxwnz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7F957922-3E69-11EC-A099-CD991BBA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> If prepare_bitmap_git() returns NULL (one easy-to-trigger cause being
> that the repository does not have bitmaps at all), then we'll segfault
> accessing bitmap_git->hashes:
>
>   $ t/helper/test-tool bitmap dump-hashes
>   Segmentation fault
>
> We should treat this the same as a repository with bitmaps but no
> name-hashes, and quietly produce an empty output. The later call to
> free_bitmap_index() in the cleanup label is OK, as it treats a NULL
> pointer as a noop.
>
> This isn't a big deal in practice, as this function is intended for and
> used only by test-tool. It's probably worth fixing to avoid confusion,
> but not worth adding coverage for this to the test suite.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> This is new in the v2.34.0 cycle, but it's so low impact it doesn't
> matter much if we ship with the bug. OTOH, it's pretty low-risk since it
> is only run by the test suite.

;-)

I wonder how you found it.  Diagnosing a repository that did not
seem healthy?  What I am getting at is if we want a new option to
make a plumbing command, other than the test-tool, that calls this
function, as the latter is usually not deployed in the field.

Will queue.  Thanks.


>  pack-bitmap.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/pack-bitmap.c b/pack-bitmap.c
> index a56ceb9441..f772d3cb7f 100644
> --- a/pack-bitmap.c
> +++ b/pack-bitmap.c
> @@ -1759,7 +1759,7 @@ int test_bitmap_hashes(struct repository *r)
>  	struct object_id oid;
>  	uint32_t i, index_pos;
>  
> -	if (!bitmap_git->hashes)
> +	if (!bitmap_git || !bitmap_git->hashes)
>  		goto cleanup;
>  
>  	for (i = 0; i < bitmap_num_objects(bitmap_git); i++) {
