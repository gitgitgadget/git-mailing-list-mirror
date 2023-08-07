Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 634BCC001B0
	for <git@archiver.kernel.org>; Mon,  7 Aug 2023 20:21:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231344AbjHGUVD (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Aug 2023 16:21:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231179AbjHGUVB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Aug 2023 16:21:01 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89924172B
        for <git@vger.kernel.org>; Mon,  7 Aug 2023 13:20:59 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 5DFBB318FD;
        Mon,  7 Aug 2023 16:20:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=KVh8YHpVuZE9MpId/3MTmKF/tG26A86viWkrqB
        oRA9Q=; b=F6DPEfLs4aeJqxSxUbrHTtgcEnQ/GInU3ecvPNg/Jx5X9EYySsFV40
        W/JjflMlxe9gl4Ko2qE0p4tBxntvhLOuDJ0I/wzATHiixjtJseXAUoro1/WJPfmX
        86uIQWvAIEZ1zCYsPY5LD4gJn0tSssPhtNoTr3yloeJACt5G8DaLY=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 55E9E318FC;
        Mon,  7 Aug 2023 16:20:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.168.215.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 7E2B0318FB;
        Mon,  7 Aug 2023 16:20:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v3] advice: handle "rebase" in error_resolve_conflict()
References: <20230428125649.1719796-1-oswald.buddenhagen@gmx.de>
        <20230807170935.2336715-1-oswald.buddenhagen@gmx.de>
Date:   Mon, 07 Aug 2023 13:20:53 -0700
In-Reply-To: <20230807170935.2336715-1-oswald.buddenhagen@gmx.de> (Oswald
        Buddenhagen's message of "Mon, 7 Aug 2023 19:09:35 +0200")
Message-ID: <xmqq5y5qeh96.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E92DB84C-355F-11EE-A2FE-C2DA088D43B2-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Oswald Buddenhagen <oswald.buddenhagen@gmx.de> writes:

> This makes sure that we get a properly translated message rather than
> inserting the command (which we failed to translate) into a generic
> fallback message.

Makes sense.

>
> The function is called indirectly via die_resolve_conflict() with fixed
> strings, and directly with the string obtained via action_name(), which
> in turn returns a string from a fixed set. Hence we know that the now
> covered set of strings is exhausitive, and will therefore BUG() out when
> encountering an unexpected string. We also know that all covered strings
> are actually used.
>
> Arguably, the above suggests that it would be cleaner to pass the
> command as an enum in the first place, but that's left for another time.
>
> Signed-off-by: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
> ---
> v2:
> - more verbose description
>
> Cc: Junio C Hamano <gitster@pobox.com>
> ---
>  advice.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/advice.c b/advice.c
> index e5a9bb9b44..50c79443ba 100644
> --- a/advice.c
> +++ b/advice.c
> @@ -191,9 +191,10 @@ int error_resolve_conflict(const char *me)
>  		error(_("Pulling is not possible because you have unmerged files."));
>  	else if (!strcmp(me, "revert"))
>  		error(_("Reverting is not possible because you have unmerged files."));
> +	else if (!strcmp(me, "rebase"))
> +		error(_("Rebasing is not possible because you have unmerged files."));
>  	else
> -		error(_("It is not possible to %s because you have unmerged files."),
> -			me);
> +		BUG("Unhandled conflict reason '%s'", me);
>  
>  	if (advice_enabled(ADVICE_RESOLVE_CONFLICT))
>  		/*
