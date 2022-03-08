Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C851AC433F5
	for <git@archiver.kernel.org>; Tue,  8 Mar 2022 17:26:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346516AbiCHR1n (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Mar 2022 12:27:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234890AbiCHR1m (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Mar 2022 12:27:42 -0500
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D910D54FB2
        for <git@vger.kernel.org>; Tue,  8 Mar 2022 09:26:45 -0800 (PST)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 954BDFF58D;
        Tue,  8 Mar 2022 12:26:43 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=p62ehKqD4b8/
        2dQ1tph5t9pPrjGVrlDCg0JJilBYqIg=; b=W5KlGMy0f5+p83kBsoJZXDystLER
        kySCVC3MVXpY+YpxCjObvfn9wwAlMdilzVtXy89CnhZm17ouVAJOh8ytfkg0Lwpk
        8/a+BzBh6VjQegEXPMBBtH7A9LwiHy1wpuo9V2jL1vyLL8Yqyic+kc9aX274390q
        VYFxxL4kt8k9y50=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8C282FF58B;
        Tue,  8 Mar 2022 12:26:43 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.230.65.123])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id F0C6DFF589;
        Tue,  8 Mar 2022 12:26:42 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason_via_GitGitGadget?= 
        <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, stolee@gmail.com, avarab@gmail.com,
        zhiyou.jx@alibaba-inc.com, jonathantanmy@google.com,
        Jeff Hostetler <git@jeffhostetler.com>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v3 07/12] list-objects: handle NULL function pointers
References: <pull.1159.v2.git.1646689840.gitgitgadget@gmail.com>
        <pull.1159.v3.git.1646750359.gitgitgadget@gmail.com>
        <782182a26e37eb8e84aef7d8cc67cf276b2abb54.1646750359.git.gitgitgadget@gmail.com>
Date:   Tue, 08 Mar 2022 09:26:41 -0800
In-Reply-To: <782182a26e37eb8e84aef7d8cc67cf276b2abb54.1646750359.git.gitgitgadget@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason via GitGitGadget"'s message
 of "Tue, 08 Mar
        2022 14:39:14 +0000")
Message-ID: <xmqq8rtknyni.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: EC046C8E-9F04-11EC-ABF9-CB998F0A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason via GitGitGadget"  <gitgitgadget@=
gmail.com>
writes:

> Replace all callers of the show_commit and show_object function pointer=
s
> in list-objects.c to be local methods show_commit() and show_object()

"to be local methods" -> "to call helper functions"

> which check that the given contex has non-NULL functions before passing

"contex" -> "context"

> the necessary data. One extra benefit is that it reduces duplication
> due to passing ctx->show_data to every caller.

> -		ctx->show_object(obj, path->buf, ctx->show_data);
> +		show_object(ctx, obj, path->buf);

I guess this is the "reduced duplication" refers to.  The helper
does make it easier to follow and reason about: "show the given
object at the path in this context" is what it asks.

> diff --git a/t/t6020-bundle-misc.sh b/t/t6020-bundle-misc.sh
> index b13e8a52a93..6522401617d 100755
> --- a/t/t6020-bundle-misc.sh
> +++ b/t/t6020-bundle-misc.sh
> @@ -475,4 +475,16 @@ test_expect_success 'clone from bundle' '
>  	test_cmp expect actual
>  '
> =20
> +test_expect_success 'unfiltered bundle with --objects' '
> +	git bundle create all-objects.bdl \
> +		--all --objects &&
> +	git bundle create all.bdl \
> +		--all &&
> +
> +	# Compare the headers of these files.
> +	head -11 all.bdl >expect &&
> +	head -11 all-objects.bdl >actual &&

"head -n 11" but more importantly, why eleven and not ten or twelve?
Is that a number this code can automatically learn from the given
.bdl file?
