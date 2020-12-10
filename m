Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0E66C4361B
	for <git@archiver.kernel.org>; Thu, 10 Dec 2020 02:53:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7FB0D23C81
	for <git@archiver.kernel.org>; Thu, 10 Dec 2020 02:53:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727905AbgLJCwr (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Dec 2020 21:52:47 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:64490 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727885AbgLJCwg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Dec 2020 21:52:36 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 4C19D112D2C;
        Wed,  9 Dec 2020 21:51:54 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=LCADZKOPiCVJVjSYgv2XuuH/ffo=; b=nm9uum
        zyL2wKA5OHiAT4msD9CYUPViG3eLhYfAlcQjim8dDcLk4mNrUgVFdNRbLhI1q3Id
        a4t4gJCChMWbLkAqcLRVUtTPs2HZf4HAMH04amyYoz0KJa0L0wnsuqzACAO/WzCz
        H3KQ0yQNNzkMsJsxBDgafjxKg1ZUQ6wo3+dk0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=KVaZ1S+asZ3QR18NqKKXrgBWunmUKIfA
        +bVWkZxw7aNAoS7RBiyXdQrrCeykDgntyPY6yyp/9gmOvmmPtJo480AnXuYOpwGe
        t3byjV96itCXSm9aE+vu84Ta5PK9Y1bItFspm5h2d9wfOvwE8SeEkEpipG3kDg7b
        wM2FP58rIkw=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 44D6D112D2B;
        Wed,  9 Dec 2020 21:51:54 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 916D2112D2A;
        Wed,  9 Dec 2020 21:51:51 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 6/7] diffcore-rename: simplify and accelerate
 register_rename_src()
References: <pull.929.git.git.1607223276.gitgitgadget@gmail.com>
        <306a48820dd3c338d2b9e2288e5a3e1c7c89f36e.1607223276.git.gitgitgadget@gmail.com>
Date:   Wed, 09 Dec 2020 18:51:49 -0800
In-Reply-To: <306a48820dd3c338d2b9e2288e5a3e1c7c89f36e.1607223276.git.gitgitgadget@gmail.com>
        (Elijah Newren via GitGitGadget's message of "Sun, 06 Dec 2020
        02:54:35 +0000")
Message-ID: <xmqqczzixtiy.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A79469C8-3A92-11EB-BCE3-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Elijah Newren <newren@gmail.com>
>
> reigster_rename_src() took pains to create an array in rename_src which

register?

> was sorted by pathname of the contained diff_filepair.  However, the
> fact that this array was sorted was not needed anywhere, and thus
> represented wasted time.  Simply append to the end of the array, which
> in a usecase of note saved 45% of diffcore_rename() setup time for me.

I originally started writing "I do not recall when the sortedness
stopped mattering", until I realized you wrote "anywhere" not
"anymore".

I do not think of any other reason than we wanted to notice and deal
with the duplicated input.  We do not look up the list of rename
sources by pathname.  So if we were sorting it, it is to prevent
such a bug from breaking the rename machinery.  What you call
"technically the behaviour is different" is "removing the safety".

I do not offhand know which caller might give us such an input in
the current code, so it may be entirely a safe thing to do.
Besides, we use a hashmap of rename sources when computing exact
renames, so even if we need to notice and/or avoid duplicates, we do
not have to have register_rename_src() build the table with an
insertion sort as a way to do so.

> diff --git a/diffcore-rename.c b/diffcore-rename.c
> index 3d637ba4645..816d2fbac44 100644
> --- a/diffcore-rename.c
> +++ b/diffcore-rename.c
> @@ -76,36 +76,12 @@ static struct diff_rename_src {
>  } *rename_src;
>  static int rename_src_nr, rename_src_alloc;
>  
> -static struct diff_rename_src *register_rename_src(struct diff_filepair *p)
> +static void register_rename_src(struct diff_filepair *p)
>  {
> -	int first, last;
> -	struct diff_filespec *one = p->one;
> -	unsigned short score = p->score;
> -
> -	first = 0;
> -	last = rename_src_nr;
> -	while (last > first) {
> -		int next = first + ((last - first) >> 1);
> -		struct diff_rename_src *src = &(rename_src[next]);
> -		int cmp = strcmp(one->path, src->p->one->path);
> -		if (!cmp)
> -			return src;
> -		if (cmp < 0) {
> -			last = next;
> -			continue;
> -		}
> -		first = next+1;
> -	}
> -
> -	/* insert to make it at "first" */
>  	ALLOC_GROW(rename_src, rename_src_nr + 1, rename_src_alloc);
> +	rename_src[rename_src_nr].p = p;
> +	rename_src[rename_src_nr].score = p->score;
>  	rename_src_nr++;
> -	if (first < rename_src_nr)
> -		MOVE_ARRAY(rename_src + first + 1, rename_src + first,
> -			   rename_src_nr - first - 1);
> -	rename_src[first].p = p;
> -	rename_src[first].score = score;
> -	return &(rename_src[first]);
>  }
>  
>  static int basename_same(struct diff_filespec *src, struct diff_filespec *dst)
