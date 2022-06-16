Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC3AEC43334
	for <git@archiver.kernel.org>; Thu, 16 Jun 2022 04:10:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358608AbiFPEKL (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Jun 2022 00:10:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358610AbiFPEKG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Jun 2022 00:10:06 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9F3956F9A
        for <git@vger.kernel.org>; Wed, 15 Jun 2022 21:10:05 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 69D6D1AACE1;
        Thu, 16 Jun 2022 00:10:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=+eNpkCLd7PSSJSVn/TMS+mmp+z0sENvi1IqJ8o
        sNG24=; b=Vm72jXELu0lfHCyzlBbQaNqx4TIUM2pQoH/cRe14zLtGfw6NzsmZLS
        09q7EQfsN4kPtliD407gstyD9pIgMIOF5FhTHo5jQ5KMKCi1WfW8u8Wnmf5iHF9q
        BglDRHdcoMTIXrlNxoxpYd+5kdEL+4x9laFCAxD/8xnw7o9Q6qWWI=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 62F051AACE0;
        Thu, 16 Jun 2022 00:10:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id D47031AACDB;
        Thu, 16 Jun 2022 00:10:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 02/11] fsmonitor: avoid memory leak in
 `fsm_settings__get_incompatible_msg()`
References: <pull.1264.git.1655336146.gitgitgadget@gmail.com>
        <6d409ad45867aa5193c15828614e865e53ac0c57.1655336146.git.gitgitgadget@gmail.com>
Date:   Wed, 15 Jun 2022 21:10:00 -0700
In-Reply-To: <6d409ad45867aa5193c15828614e865e53ac0c57.1655336146.git.gitgitgadget@gmail.com>
        (Johannes Schindelin via GitGitGadget's message of "Wed, 15 Jun 2022
        23:35:36 +0000")
Message-ID: <xmqqfsk5xn8n.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 31A337E8-ED2A-11EC-9037-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> Reported by Coverity.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  fsmonitor-settings.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/fsmonitor-settings.c b/fsmonitor-settings.c
> index 658cb79da01..464424a1e92 100644
> --- a/fsmonitor-settings.c
> +++ b/fsmonitor-settings.c
> @@ -202,11 +202,15 @@ char *fsm_settings__get_incompatible_msg(const struct repository *r,
>  	case FSMONITOR_REASON_OK:
>  		goto done;

Obviously correct, but the placement of these ...

> -	case FSMONITOR_REASON_BARE:
> +	case FSMONITOR_REASON_BARE: {
> +		char *cwd = xgetcwd();
> +
>  		strbuf_addf(&msg,
>  			    _("bare repository '%s' is incompatible with fsmonitor"),
> -			    xgetcwd());
> +			    cwd);
> +		free(cwd);
>  		goto done;
> +	}

... braces are misleading and confusing.

>  
>  	case FSMONITOR_REASON_ERROR:
>  		strbuf_addf(&msg,
