Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9F2CC433EF
	for <git@archiver.kernel.org>; Fri, 19 Nov 2021 19:42:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB2C861283
	for <git@archiver.kernel.org>; Fri, 19 Nov 2021 19:42:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235994AbhKSTpL (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Nov 2021 14:45:11 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59665 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229879AbhKSTpK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Nov 2021 14:45:10 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5824810ADAC;
        Fri, 19 Nov 2021 14:42:08 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=7bbOdq9JVC4S
        do3q+GD3+G9JPmjXJKOwMbRrLJBv3aM=; b=ijtOsSVn/9nHtpQnX2hJs5z1rAgy
        Myc3mcw+F5gQ5wLq+Q6ZCVcRsy0exPlTBrVc78D5irWWMeC+eg5vzJ0brkmEcujw
        88wxbu3jTB7ziSdZtnNgmY/NgvrLoWbMBBLek2PF5OHU8muRPRc5pz5lSQV3dYff
        /hvJ4waSEZkU4wI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3EA4E10ADAB;
        Fri, 19 Nov 2021 14:42:08 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5CECA10ADAA;
        Fri, 19 Nov 2021 14:42:07 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 4/6] alloc.[ch]: remove alloc_report() function
References: <cover-0.6-00000000000-20211119T124420Z-avarab@gmail.com>
        <patch-4.6-bd8aa9b1554-20211119T124420Z-avarab@gmail.com>
Date:   Fri, 19 Nov 2021 11:42:05 -0800
In-Reply-To: <patch-4.6-bd8aa9b1554-20211119T124420Z-avarab@gmail.com>
 (=?utf-8?B?IsOGdmFyCUFybmZqw7Zyw7A=?= Bjarmason"'s message of "Fri, 19 Nov
 2021 13:46:24 +0100")
Message-ID: <xmqqh7c8orua.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: C781F686-4970-11EC-8555-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> The alloc_report() function has been orphaned since its introduction
> in 855419f764a (Add specialized object allocator, 2006-06-19), it
> appears to have been used for demonstration purposes in that commit
> message.

Stopping a program in debugger, and calling these functions that
have otherwise no callers, is a fairly handy way to debug.
It is likely that we used it while developing the allocator.

If we truly want to get rid of it, we'd want to lose the "count"
member from the alloc_state structure, which is otherwise unused, I
would think.

Even though I do not think 5/6 and 6/6 in this series are good idea,
I am on the fence on this one, slightly leaning to "lose it" but not
that strongly.

>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
> ---
>  alloc.c | 19 -------------------
>  alloc.h |  1 -
>  2 files changed, 20 deletions(-)
>
> diff --git a/alloc.c b/alloc.c
> index 957a0af3626..bf7982712f1 100644
> --- a/alloc.c
> +++ b/alloc.c
> @@ -122,22 +122,3 @@ void *alloc_commit_node(struct repository *r)
>  	init_commit_node(c);
>  	return c;
>  }
> -
> -static void report(const char *name, unsigned int count, size_t size)
> -{
> -	fprintf(stderr, "%10s: %8u (%"PRIuMAX" kB)\n",
> -			name, count, (uintmax_t) size);
> -}
> -
> -#define REPORT(name, type)	\
> -    report(#name, r->parsed_objects->name##_state->count, \
> -		  r->parsed_objects->name##_state->count * sizeof(type) >> 10)
> -
> -void alloc_report(struct repository *r)
> -{
> -	REPORT(blob, struct blob);
> -	REPORT(tree, struct tree);
> -	REPORT(commit, struct commit);
> -	REPORT(tag, struct tag);
> -	REPORT(object, union any_object);
> -}
> diff --git a/alloc.h b/alloc.h
> index 371d388b552..3f4a0ad310a 100644
> --- a/alloc.h
> +++ b/alloc.h
> @@ -13,7 +13,6 @@ void init_commit_node(struct commit *c);
>  void *alloc_commit_node(struct repository *r);
>  void *alloc_tag_node(struct repository *r);
>  void *alloc_object_node(struct repository *r);
> -void alloc_report(struct repository *r);
> =20
>  struct alloc_state *allocate_alloc_state(void);
>  void clear_alloc_state(struct alloc_state *s);
