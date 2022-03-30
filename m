Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01DEEC433EF
	for <git@archiver.kernel.org>; Wed, 30 Mar 2022 21:15:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347221AbiC3VQ7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Mar 2022 17:16:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347240AbiC3VQ5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Mar 2022 17:16:57 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4446057480
        for <git@vger.kernel.org>; Wed, 30 Mar 2022 14:15:11 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id D064717C50B;
        Wed, 30 Mar 2022 17:15:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=gB5UnKV/c3Udof83+oYfYY37b8vr41mXlhwvXA
        4+30c=; b=SoB9MQV2Wr7teGvzCCVmCJEoqFTxHEYTLCX7BwgXxFT/eKOyUd6poa
        v0lfQeMVtUUoFezydQ0a07aPVBeHc2FOKb0bP80/jYOKR5p/nmuXFr4yW6bYlMNw
        RElZpuHnMgdP5n5MFjWZp2U0k+Kws/VIhBXZJn3y+pwEFPROS9h8c=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C220717C508;
        Wed, 30 Mar 2022 17:15:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.227.145.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 2979717C505;
        Wed, 30 Mar 2022 17:15:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Glen Choo via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Glen Choo <chooglen@google.com>
Subject: Re: [PATCH 2/4] branch: give submodule updating advice before exit
References: <pull.1190.git.1648584079.gitgitgadget@gmail.com>
        <f21d283e5ade542b73cb36178c3c33008e2c67df.1648584079.git.gitgitgadget@gmail.com>
Date:   Wed, 30 Mar 2022 14:15:07 -0700
In-Reply-To: <f21d283e5ade542b73cb36178c3c33008e2c67df.1648584079.git.gitgitgadget@gmail.com>
        (Glen Choo via GitGitGadget's message of "Tue, 29 Mar 2022 20:01:17
        +0000")
Message-ID: <xmqqa6d76t2c.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7A079A4A-B06E-11EC-B556-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Glen Choo via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Glen Choo <chooglen@google.com>
>
> Fix a bug where "hint:" was printed _before_ "fatal:" (instead of the
> other way around).
>
> Signed-off-by: Glen Choo <chooglen@google.com>
> ---
>  branch.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/branch.c b/branch.c
> index 7377b9f451a..133e6047bc6 100644
> --- a/branch.c
> +++ b/branch.c
> @@ -607,11 +607,13 @@ void create_branches_recursively(struct repository *r, const char *name,
>  	 */
>  	for (i = 0; i < submodule_entry_list.entry_nr; i++) {
>  		if (submodule_entry_list.entries[i].repo == NULL) {
> +			int code = die_message(
> +				_("submodule '%s': unable to find submodule"),
> +				submodule_entry_list.entries[i].submodule->name);
>  			if (advice_enabled(ADVICE_SUBMODULES_NOT_UPDATED))
>  				advise(_("You may try updating the submodules using 'git checkout %s && git submodule update --init'"),
>  				       start_commitish);
> -			die(_("submodule '%s': unable to find submodule"),
> -			    submodule_entry_list.entries[i].submodule->name);
> +			exit(code);
>  		}
>  
>  		if (submodule_create_branch(

Great.

Thanks.
