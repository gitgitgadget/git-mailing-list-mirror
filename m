Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 521E9C25B08
	for <git@archiver.kernel.org>; Wed, 17 Aug 2022 14:33:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236893AbiHQOdg (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Aug 2022 10:33:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236516AbiHQOdd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Aug 2022 10:33:33 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 844DC2ED7A
        for <git@vger.kernel.org>; Wed, 17 Aug 2022 07:33:31 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 0FA1B1AF83A;
        Wed, 17 Aug 2022 10:33:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=R5k5VaAMtXWS4ct0J+J3OpBB/5stJGr+py9LV2RMFT8=; b=vcPN
        EehPAuDO89OJzzyCMfPvBI4hZZvg0dHL9byvaKKQipQBPzvMqESYIW899E6wYgJv
        AKzzHtxtofK2k5fCWcyM2xUQqmV8bKpQTKzk2bpkxNeLh7C2x8CasvMcd4HF+2bV
        CxJ0tnXvHH7AZTWxWVQHiXGMJQFGvJZDa4fAkWs=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 066441AF839;
        Wed, 17 Aug 2022 10:33:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 9A4FC1AF832;
        Wed, 17 Aug 2022 10:33:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, johannes.schindelin@gmx.de,
        mjcheetham@outlook.com, Victoria Dye <vdye@github.com>
Subject: Re: [PATCH v2 1/5] scalar-unregister: handle error codes greater
 than 0
References: <pull.1324.git.1660673269.gitgitgadget@gmail.com>
        <pull.1324.v2.git.1660694290.gitgitgadget@gmail.com>
        <36fc3cb604d835f06bd5eca22b6eeff73e7117c8.1660694290.git.gitgitgadget@gmail.com>
Date:   Wed, 17 Aug 2022 07:33:25 -0700
Message-ID: <xmqq4jyb0wju.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8E3A1A0E-1E39-11ED-A9B6-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Victoria Dye <vdye@github.com>
>
> When 'scalar unregister' tries to disable maintenance and remove an
> enlistment, ensure that the return value is nonzero if either operation
> produces *any* nonzero return value, not just when they return a value less
> than 0.

Interesting.  Did this actually cause problems in the wild?  Just
being curious.

The return values from toggle_maintenance() and add_or_remove() are
what scalar.c::run_git() returns, which in turn come from
run_command() and eventually come from wait_or_whine(), so it very
well can be a positive non-zero value that signals a failure.  It is
good to be prepared to see not just negative values but also
positive ones.

> Signed-off-by: Victoria Dye <vdye@github.com>
> ---
>  contrib/scalar/scalar.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/contrib/scalar/scalar.c b/contrib/scalar/scalar.c
> index 97e71fe19cd..e888fa5408e 100644
> --- a/contrib/scalar/scalar.c
> +++ b/contrib/scalar/scalar.c
> @@ -253,10 +253,10 @@ static int unregister_dir(void)
>  {
>  	int res = 0;
>  
> -	if (toggle_maintenance(0) < 0)
> +	if (toggle_maintenance(0))
>  		res = -1;
>  
> -	if (add_or_remove_enlistment(0) < 0)
> +	if (add_or_remove_enlistment(0))
>  		res = -1;
>  
>  	return res;
