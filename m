Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B6FBC43334
	for <git@archiver.kernel.org>; Wed, 20 Jul 2022 22:35:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230482AbiGTWfu (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Jul 2022 18:35:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230417AbiGTWfs (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Jul 2022 18:35:48 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BC11D115
        for <git@vger.kernel.org>; Wed, 20 Jul 2022 15:35:47 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E120F1A316C;
        Wed, 20 Jul 2022 18:35:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=uFgFocGLqDQn
        MZFmXsRYZglTGUCmxJQM/0O9/u868Lc=; b=JftjJmDvwFWqObVfpYQqggLRLBti
        IsjgL/1+1hKacYsEGeXGXGda5uXORaAEPjoRGnUgh0NY7JsmleD8EsqXyW9y54uJ
        QXMyW8+/pYJhS4U8fMfIQhbxu6HEkbcsnrIRnD9CtIGuM/HMIRFCKAv941sVTt3A
        0NIfzdv5YxjIQdc=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id D84141A316B;
        Wed, 20 Jul 2022 18:35:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 7142E1A3168;
        Wed, 20 Jul 2022 18:35:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>
Subject: Re: [PATCH v2 11/24] submodule--helper: fix "sm_path" and other
 "module_cb_list" leaks
References: <cover-00.11-00000000000-20220713T131601Z-avarab@gmail.com>
        <cover-v2-00.24-00000000000-20220719T204458Z-avarab@gmail.com>
        <patch-v2-11.24-c25b55c9528-20220719T204458Z-avarab@gmail.com>
Date:   Wed, 20 Jul 2022 15:35:41 -0700
In-Reply-To: <patch-v2-11.24-c25b55c9528-20220719T204458Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Tue, 19 Jul
 2022 22:47:02
        +0200")
Message-ID: <xmqqr12f1kg2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 49C25184-087C-11ED-B7CE-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> -	const char *sm_path;
> +	char *sm_path;
>  };
>  #define MODULE_CB_INIT { 0 }
> +static void module_cb_release(struct module_cb *mcb)
> +{
> +	free(mcb->sm_path);
> +}

It would be nice to have a blank line before the new helper
function, just like you did for the next hunk.

>  struct module_cb_list {
>  	struct module_cb **entries;
> @@ -838,6 +842,19 @@ struct module_cb_list {
>  };
>  #define MODULE_CB_LIST_INIT { 0 }
> =20
> +static void module_cb_list_release(struct module_cb_list *mcbl)
> +{
> +	int i;
> +
> +	for (i =3D 0; i < mcbl->nr; i++) {
> +		struct module_cb *mcb =3D mcbl->entries[i];
> +
> +		module_cb_release(mcb);
> +		free(mcb);
> +	}
> +	free(mcbl->entries);
> +}

OK, this was populated in the diff callback function and each
element of the list->entries[] array is a module_cb data, which has
its own release() helper above.

Looking good.


>  struct summary_cb {
>  	int argc;
>  	const char **argv;
> @@ -1181,6 +1198,7 @@ static int compute_summary_module_list(struct obj=
ect_id *head_oid,
>  cleanup:
>  	strvec_clear(&diff_args);
>  	release_revisions(&rev);
> +	module_cb_list_release(&list);
>  	return ret;
>  }
