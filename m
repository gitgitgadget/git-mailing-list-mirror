Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79766C43334
	for <git@archiver.kernel.org>; Thu, 21 Jul 2022 21:30:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233456AbiGUVaL (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Jul 2022 17:30:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232566AbiGUVaI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jul 2022 17:30:08 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DF8D2AEE
        for <git@vger.kernel.org>; Thu, 21 Jul 2022 14:30:07 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1192D1374AD;
        Thu, 21 Jul 2022 17:30:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=epXWngi1Rq3K
        oBfEwAAH1CxVjslHEdHXFIL+VPRuXUI=; b=LdW6rtgWHecSM7PTVtUgOAjMkZqv
        Y4Mfgm2tTiQ1LiGoNUIhp7NkG7oJ/LFzBzU2qCdVUvTsfyrVLFj036oBAcmedVOW
        73PNuboQZTqC2hq/Q1yN6Vrwiv4w9KVIhh5rnftKNWQRZ/OL7I28AeQStBXU68Bc
        MxJNlqWjCcdT2fU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 97C931374AA;
        Thu, 21 Jul 2022 17:30:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.40.190])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A77391374A5;
        Thu, 21 Jul 2022 17:30:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>
Subject: Re: [PATCH v3 04/26] submodule--helper: fix a leak in
 "clone_submodule"
References: <cover-v2-00.24-00000000000-20220719T204458Z-avarab@gmail.com>
        <cover-v3-00.26-00000000000-20220721T191249Z-avarab@gmail.com>
        <patch-v3-04.26-26f0caf0386-20220721T191249Z-avarab@gmail.com>
Date:   Thu, 21 Jul 2022 14:30:02 -0700
In-Reply-To: <patch-v3-04.26-26f0caf0386-20220721T191249Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Thu, 21 Jul
 2022 21:13:00
        +0200")
Message-ID: <xmqq35euf92d.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 4916C222-093C-11ED-9B1E-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> index 7d5ee6a6261..1ddce8e19c1 100644
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> @@ -1658,14 +1658,15 @@ static int clone_submodule(const struct module_=
clone_data *clone_data,
>  	char *sm_alternate =3D NULL, *error_strategy =3D NULL;
>  	struct child_process cp =3D CHILD_PROCESS_INIT;
>  	const char *clone_data_path;
> +	char *to_free =3D NULL;
> =20
>  	if (!is_absolute_path(clone_data->path)) {
>  		struct strbuf sb =3D STRBUF_INIT;
> =20
>  		strbuf_addf(&sb, "%s/%s", get_git_work_tree(), clone_data->path);
> -		clone_data_path =3D strbuf_detach(&sb, NULL);
> +		clone_data_path =3D to_free =3D strbuf_detach(&sb, NULL);
>  	} else {
> -		clone_data_path =3D xstrdup(clone_data_path);
> +		clone_data_path =3D clone_data->path;
>  	}

Heh, the bug I noticed in the previous step is silently fixed here.

This is why I do not trust a series that is artificially split into
steps and sent out without self reviewing or even compiling them.
Forces reviewers to do more work wasting their time reviewing and
finding bugs that ends up not mattering because that weren't even
something the author intended to write in the end.
