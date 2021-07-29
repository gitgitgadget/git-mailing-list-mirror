Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DA11C4338F
	for <git@archiver.kernel.org>; Thu, 29 Jul 2021 20:56:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E8EC460EC0
	for <git@archiver.kernel.org>; Thu, 29 Jul 2021 20:56:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233098AbhG2U4x (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Jul 2021 16:56:53 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:51192 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbhG2U4w (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Jul 2021 16:56:52 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 2F7E513AE27;
        Thu, 29 Jul 2021 16:56:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=P3E6XK0ETwaz0ePUsVH/Hj1QoBZLspjbBV4ok+
        W1aOg=; b=QMUi95cw21gL3JsGkGdvuFdbZpPkRMqu47TjYPLza7BdtrdpT/VvW3
        nwDLsEKqj3NohQHRfH+FsmyLqYoDX0J31YU8BdQqFrcluDjDllA+AYAhCaaDb9Su
        68VtimKmx/V3DCR4NzYEh2GNvXGzpGlefLtWqLlYSnhVS62MBF/yM=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 27A2113AE25;
        Thu, 29 Jul 2021 16:56:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.71.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 69A0513AE23;
        Thu, 29 Jul 2021 16:56:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnI=?= =?utf-8?B?w7A=?= Bjarmason 
        <avarab@gmail.com>, Han-Wen Nienhuys <hanwen@google.com>,
        Ramkumar Ramachandra <artagnon@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
Subject: Re: [PATCH 1/2] [GSOC] cherry-pick: fix bug when used with
 GIT_CHERRY_PICK_HELP
References: <pull.1007.git.1627561665.gitgitgadget@gmail.com>
        <5c5ec310b9230ee19bde4b3c8733b359d5218b32.1627561665.git.gitgitgadget@gmail.com>
Date:   Thu, 29 Jul 2021 13:56:44 -0700
In-Reply-To: <5c5ec310b9230ee19bde4b3c8733b359d5218b32.1627561665.git.gitgitgadget@gmail.com>
        (ZheNing Hu via GitGitGadget's message of "Thu, 29 Jul 2021 12:27:43
        +0000")
Message-ID: <xmqqzgu43kkz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7C8D487A-F0AF-11EB-8600-D5C30F5B5667-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com> writes:

> -static void print_advice(struct repository *r, int show_hint,
> -			 struct replay_opts *opts)
> +static char *check_need_delete_cherry_pick_head(struct repository *r)
>  {
>  	char *msg = getenv("GIT_CHERRY_PICK_HELP");
>  
>  	if (msg) {
> -		fprintf(stderr, "%s\n", msg);
>  		/*
>  		 * A conflict has occurred but the porcelain
>  		 * (typically rebase --interactive) wants to take care
> @@ -411,18 +409,22 @@ static void print_advice(struct repository *r, int show_hint,
>  		 */
>  		refs_delete_ref(get_main_ref_store(r), "", "CHERRY_PICK_HEAD",
>  				NULL, 0);
> -		return;
> +		return msg;
>  	}
> +	return NULL;
> +}

The patch is a bit hard to read, but I do not think this improves
the root cause of the issue at all, which is that "do we need to
delete the pseudoref?" decision is tied to and based on the presense
of the custom message in the environment variable.

The original issue was that we declared (erroneously) that the
presence of a custom message _means_ the caller is not a human but a
sequencing machinery that wants to deal with what is done via the
CHERRY_PICK_HEAD pseudoref itself, and your original issue was that
when a human user has the custom message envirnoment (either on
purpose or by mistake), the logic _misidentifies_ the call as if it
is made from a sequencing machinery and we lose the CHERRY_PICK_HEAD
pseudoref.  The root cause is mistaking the correlation (sequencing
machinery uses the environment and it also does not want pseudoref)
as the causation (presense of the environment means we should remove
pseudoref).
