Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10BC3C433EF
	for <git@archiver.kernel.org>; Thu, 21 Jul 2022 21:26:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233652AbiGUV0l (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Jul 2022 17:26:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbiGUV0j (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jul 2022 17:26:39 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88CF791CE8
        for <git@vger.kernel.org>; Thu, 21 Jul 2022 14:26:38 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id D8FBA1AE72E;
        Thu, 21 Jul 2022 17:26:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=KfjZwoUBN7mN
        m+OLCwjV9B2HzEkkO4u/SGn+6RT7NFg=; b=fS7aM1lg52FzWc0WWFXRfXI7BoKK
        HFC4V5GO7T37XQk4tUZxvzlZC9YIUt4O9Hb/ngJxIxrxfsd0rZCb4hYe3gIg4XVJ
        8Ei1cZoFIewjWNRL0cAGmqoNN9jrg1bDqgAlNFZMhMUMgTwJeTh8p/eXFpkCDdN7
        9f2auEtAm6tMhAM=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id D32861AE72D;
        Thu, 21 Jul 2022 17:26:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.40.190])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 827971AE72C;
        Thu, 21 Jul 2022 17:26:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>
Subject: Re: [PATCH v3 03/26] submodule--helper: pass a "const struct
 module_clone_data" to clone_submodule()
References: <cover-v2-00.24-00000000000-20220719T204458Z-avarab@gmail.com>
        <cover-v3-00.26-00000000000-20220721T191249Z-avarab@gmail.com>
        <patch-v3-03.26-eee6ca28c6f-20220721T191249Z-avarab@gmail.com>
Date:   Thu, 21 Jul 2022 14:26:33 -0700
In-Reply-To: <patch-v3-03.26-eee6ca28c6f-20220721T191249Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Thu, 21 Jul
 2022 21:12:59
        +0200")
Message-ID: <xmqq8romf986.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: CBCFDD3A-093B-11ED-B3E9-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> -static int clone_submodule(struct module_clone_data *clone_data)
> +static int clone_submodule(const struct module_clone_data *clone_data,
> +			   struct string_list *reference)
>  {
>  	char *p;
>  	char *sm_gitdir =3D clone_submodule_sm_gitdir(clone_data->name);
>  	char *sm_alternate =3D NULL, *error_strategy =3D NULL;
>  	struct child_process cp =3D CHILD_PROCESS_INIT;
> +	const char *clone_data_path;
> =20
>  	if (!is_absolute_path(clone_data->path)) {
>  		struct strbuf sb =3D STRBUF_INIT;
> =20
>  		strbuf_addf(&sb, "%s/%s", get_git_work_tree(), clone_data->path);
> -		clone_data->path =3D strbuf_detach(&sb, NULL);
> +		clone_data_path =3D strbuf_detach(&sb, NULL);

OK.

>  	} else {
> -		clone_data->path =3D xstrdup(clone_data->path);
> +		clone_data_path =3D xstrdup(clone_data_path);

Is the variable we are duplicating by passing it to xstrdup() still
uninitialized at this point?  How could the compiler not catch this?

Apparently there is no test coverage on this codepath; all tests
pass when I replace this else clause with BUG().

Let's read on, pretending that you passed clone_data->path to
xstrdup(), for now.

> @@ -1674,7 +1676,7 @@ static int clone_submodule(struct module_clone_da=
ta *clone_data)
>  		if (safe_create_leading_directories_const(sm_gitdir) < 0)
>  			die(_("could not create directory '%s'"), sm_gitdir);
> =20
> -		prepare_possible_alternates(clone_data->name, &clone_data->reference=
);
> +		prepare_possible_alternates(clone_data->name, reference);
> =20
>  		strvec_push(&cp.args, "clone");
>  		strvec_push(&cp.args, "--no-checkout");
> @@ -1684,9 +1686,9 @@ static int clone_submodule(struct module_clone_da=
ta *clone_data)
>  			strvec_push(&cp.args, "--progress");
>  		if (clone_data->depth && *(clone_data->depth))
>  			strvec_pushl(&cp.args, "--depth", clone_data->depth, NULL);
> -		if (clone_data->reference.nr) {
> +		if (reference->nr) {
>  			struct string_list_item *item;
> -			for_each_string_list_item(item, &clone_data->reference)
> +			for_each_string_list_item(item, reference)
>  				strvec_pushl(&cp.args, "--reference",
>  					     item->string, NULL);
>  		}

All the uses of reference (both above, so below) looks OK.

I wonder if we can simply have a separate string list variable in
module_clone() and add_submodule() and remove clone_data.reference
member, which may make the end-result even cleaner, now that we pass
it as a separate parameter anyway.
