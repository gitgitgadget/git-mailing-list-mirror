Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C449ECAAA1
	for <git@archiver.kernel.org>; Fri, 16 Sep 2022 22:23:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229532AbiIPWXJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Sep 2022 18:23:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbiIPWXG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Sep 2022 18:23:06 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DB4BBB028
        for <git@vger.kernel.org>; Fri, 16 Sep 2022 15:23:05 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 759D31AB0BA;
        Fri, 16 Sep 2022 18:23:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=EbIZdzZC1j/eulRChjonJ3P808fILnmP6p2AdJ
        gUFmM=; b=BDwwD074uLMFpRPGlilWZPNjwYmNPnvQ6jZaCmrsbjAUbsZ5biql2Q
        Tg+IIBTPL1YglB7nphPYvSZoqFg3vqoL6lQzhmT75GAIpC7D/7AkEtl75ZlQf0+0
        Ni8ZOgwzy3l/Wn0pj++B/rOPVP0ANx3YD9G+f06ASuofyFW+aixxY=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 6D8E11AB0B9;
        Fri, 16 Sep 2022 18:23:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id C9EA11AB0B4;
        Fri, 16 Sep 2022 18:22:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Siddharth Asthana <siddharthasthana31@gmail.com>
Cc:     git@vger.kernel.org, christian.couder@gmail.com,
        johncai86@gmail.com
Subject: Re: [PATCH 2/3] cat-file: add mailmap support to -s option
References: <20220916205946.178925-1-siddharthasthana31@gmail.com>
        <20220916205946.178925-3-siddharthasthana31@gmail.com>
Date:   Fri, 16 Sep 2022 15:22:58 -0700
In-Reply-To: <20220916205946.178925-3-siddharthasthana31@gmail.com> (Siddharth
        Asthana's message of "Sat, 17 Sep 2022 02:29:45 +0530")
Message-ID: <xmqq8rmjez7h.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1F26EDF8-360E-11ED-B992-C2DA088D43B2-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Siddharth Asthana <siddharthasthana31@gmail.com> writes:

> Using `git cat-file --use-mailmap` with `-s` option, like the following is
> allowed:
>
>  git cat-file --use-mailmap -s <commit/tag object sha>
>
> The current implementation will return the same object size irrespective
> of the mailmap option, which is not as useful as it could be.
> When we
> use the mailmap mechanism to replace the idents, the size of the object
> can change and `-s` option would be more useful if it shows the size of
> the changed object. This patch implements that.

Simply put, the current implementation is BUGGY, in other words, no?

The above sounds like a quite roundabout way to say that.  "the
following is allowed" (but it does not work, really).  "is not as
useful as it could be" (it is pretty much useless, in fact).

If I were doing this step, I'd summarize it into a single three-line
paragraph, like so:

    Even though the cat-file command with -s option does not complain
    when --use-mailmap option is given, it is ignored.  Compute the size
    of the object after replacing the idents and report it instead.

>  -s::
>  	Instead of the content, show the object size identified by
> -	`<object>`.
> +	`<object>`. If used with `--use-mailmap` option, will show the
> +	size of updated object after replacing idents using the mailmap
> +	mechanism.

We are not modifying the object in the object database, so it would
be preferrable to avoid a misleading phrasing "updated object", if
we can.  The size that the object would have had, if the idents
recorded in it were the ones "corrected" by the mailmap, is what we
report.

> diff --git a/builtin/cat-file.c b/builtin/cat-file.c
> index 989eee0bb4..9942b93867 100644
> --- a/builtin/cat-file.c
> +++ b/builtin/cat-file.c
> @@ -132,8 +132,21 @@ static int cat_one_file(int opt, const char *exp_type, const char *obj_name,
>  
>  	case 's':
>  		oi.sizep = &size;
> +
> +		if (use_mailmap) {
> +			oi.typep = &type;
> +			oi.contentp = (void**)&buf;
> +		}
> +
>  		if (oid_object_info_extended(the_repository, &oid, &oi, flags) < 0)
>  			die("git cat-file: could not get object info");
> +
> +		if (use_mailmap && (type == OBJ_COMMIT || type == OBJ_TAG)) {
> +			size_t s = size;
> +			buf = replace_idents_using_mailmap(buf, &s);
> +			size = cast_size_t_to_ulong(s);
> +		}
> +
>  		printf("%"PRIuMAX"\n", (uintmax_t)size);
>  		ret = 0;
>  		goto cleanup;

We did not grab the object contents but just asked the API to fill oi.sizep
but now we grab the contents in oi.contentp, and possibly munge it
via mailmap.

Are we merely borrowing the object contents from somebody so we do
not have to release anything before jumping to "cleanup" here?
What's the memory ownership around replace_idents_using_mailmap()?
You pass "buf" to it, and overwrite "buf" with what it returns.  If
you were responsible for releasing the original "buf" you obtained
from oid_object_info_extended(), have you lost the only pointer to
it that you may have wanted to use to release it by doing so?

    ... goes and looks ...

OK, replace_idents_using_mailmap() assumes that object_buf is owned
by the caller and the caller is willing to let it go.  That is why
it attaches it to a strbuf, calls apply_mailmap_to_header() to munge
the strbuf, and detaches.  The net effect is that the original "buf"
we took from oid_object_info_extended() may be freed inside it, and
the returned value may be a newly allocated one to replace it, so
overwriting buf is OK.

We still need to free "buf", but the function assumes that all cases
"buf" would be populated (or left to NULL) and it is OK to free it
at cleanup: label, so we are not leaking anything here.

Good.

> diff --git a/t/t4203-mailmap.sh b/t/t4203-mailmap.sh
> index cd1cab3e54..59513e7c57 100755
> --- a/t/t4203-mailmap.sh
> +++ b/t/t4203-mailmap.sh
> @@ -1022,4 +1022,14 @@ test_expect_success '--mailmap enables mailmap in cat-file for annotated tag obj
>  	test_cmp expect actual
>  '
>  
> +test_expect_success 'git cat-file -s returns correct size with --use-mailmap' '
> +	test_when_finished "rm .mailmap" &&
> +	cat >.mailmap <<-EOF &&
> +	C O Mitter <committer@example.com> Orig <orig@example.com>
> +	EOF
> +	echo "220" >expect &&
> +	git cat-file --use-mailmap -s HEAD >actual &&
> +	test_cmp expect actual
> +'
> +
>  test_done
