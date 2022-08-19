Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D4DBC32772
	for <git@archiver.kernel.org>; Fri, 19 Aug 2022 18:15:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350579AbiHSSPE (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Aug 2022 14:15:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350573AbiHSSOk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Aug 2022 14:14:40 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A45ECF7E
        for <git@vger.kernel.org>; Fri, 19 Aug 2022 11:11:07 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 3280F1ACCB7;
        Fri, 19 Aug 2022 14:11:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=h9G4B8FrhsLdkEubV/VY3csO4IRsfcS4EE3dxe
        /aEYE=; b=InlFnp1lCfCII9dbvmVstXrfo2Gbgl/tYRbE06TaA1ivXR6FNQdBwX
        unMgj2HmBNw/EkAbpbeD7lJ8Gj8Mp5E+iDCUwnet2FG2MU3sPvK79WgxpC5zOroy
        DTAWYw1H5rd46gmOKA+FEhu/EzW/QgNoF46JPUcW58P/ayoZuhtVo=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 2C0411ACCB6;
        Fri, 19 Aug 2022 14:11:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id D54401ACCB5;
        Fri, 19 Aug 2022 14:11:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     =?utf-8?Q?Rub=C3=A9n?= Justo via GitGitGadget 
        <gitgitgadget@gmail.com>, git@vger.kernel.org,
        =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>
Subject: Re: [PATCH] branch: allow "-" as a short-hand for "previous branch"
References: <pull.1315.git.1659910949556.gitgitgadget@gmail.com>
        <s7862q69-05o8-s5s8-n635-823s34q358q4@tzk.qr>
        <xmqqk07iu3c3.fsf@gitster.g>
        <5194s6qn-570s-6053-2104-9s22qo1874sn@tzk.qr>
        <55n449n3-71r9-28n9-094q-6r61545r7505@tzk.qr>
Date:   Fri, 19 Aug 2022 11:11:02 -0700
In-Reply-To: <55n449n3-71r9-28n9-094q-6r61545r7505@tzk.qr> (Johannes
        Schindelin's message of "Fri, 19 Aug 2022 15:05:46 +0200 (CEST)")
Message-ID: <xmqqr11ckssp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 49C64188-1FEA-11ED-A8C6-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> This patch does that:
>
> -- snip --
> diff --git a/object-name.c b/object-name.c
> index 4d2746574cd..a2732be3b71 100644
> --- a/object-name.c
> +++ b/object-name.c
> @@ -1616,6 +1616,20 @@ int repo_interpret_branch_name(struct repository *r,
>  	if (!namelen)
>  		namelen = strlen(name);
>
> +	if (namelen == 1 && *name == '-') {
> +		struct grab_nth_branch_switch_cbdata cb = {
> +			.remaining = 1,
> +			.sb = buf
> +		};
> +
> +		if (refs_for_each_reflog_ent_reverse(get_main_ref_store(r),
> +						     "HEAD",
> +						     grab_nth_branch_switch,
> +						     &cb) <= 0)
> +			return -1;
> +		return namelen;
> +	}
> +

This is very reasonable.  

Anywhere we take '@{-1}', 'main', or 'js/dash-is-previous', nobody
would be surprised if we take '-' and interpreted as '@{-1}' in
addition.

However, as I said earlier, we have command line disambiguation that
wants to tell dashed options, revs, and paths apart.  We need to
find places that need adjusting and adjust them, *AND* then make
sure that such tweaks do not introduce unintended side effect.
These, especially the last one, take a careful work I would rather
not to see unexperienced developer perform alone and take the
finding by them blindly.

> What does not work with this patch is `git show -`. I am not sure whether
> we want to make that work, although I have to admit that I would use it.
> Often. And this patch would make it work, the test suite even passes with
> it:

Exactly my above point.  Nobody including our tests expect that a
single '-' to be taken as a rev when we disambiguate command line
arguments, so it is very unlikely that it is tested to ensure that a
single '-' ends the revs and is checked for its "path-ness".  It is
not surprising that the tests do not fail ;-).

> -- snip --
> diff --git a/revision.c b/revision.c
> index f4eee11cc8b..207b554aef1 100644
> --- a/revision.c
> +++ b/revision.c
> @@ -2802,7 +2802,7 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
>  		revarg_opt |= REVARG_CANNOT_BE_FILENAME;
>  	for (left = i = 1; i < argc; i++) {
>  		const char *arg = argv[i];
> -		if (!seen_end_of_options && *arg == '-') {
> +		if (!seen_end_of_options && *arg == '-' && arg[1]) {
>  			int opts;
>
>  			opts = handle_revision_pseudo_opt(
> -- snap --

Thanks.  These two patch snippets in the message I am responding to
are promising and exciting.
