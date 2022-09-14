Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92A46ECAAD8
	for <git@archiver.kernel.org>; Wed, 14 Sep 2022 01:48:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbiINBs2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Sep 2022 21:48:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230080AbiINBsP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Sep 2022 21:48:15 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80CDB6EF1B
        for <git@vger.kernel.org>; Tue, 13 Sep 2022 18:48:14 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id F3F271C30B5;
        Tue, 13 Sep 2022 21:48:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=dbaNY7HztWQoQ/Da+pfeYED/RmvYafYHd/v827/YPxI=; b=ckNu
        IQmr6EzvKMNn63Eqj0xUg5ibTdNX+IadWdJo3bemHbiLYEJeSsjoiKPf3vUdZOwH
        qsRox5MhE1lh4O8nGHk1wrT9zUGZWCmwZFQmOuH0urjO2rBqHqFGGSpZ2rBL7/pr
        DJvy1xH3S7jMezPyWDu98dkEVdhPMf7xlwxt314=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id EC7B91C30B4;
        Tue, 13 Sep 2022 21:48:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 918C41C30B3;
        Tue, 13 Sep 2022 21:48:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Eric DeCosta via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff Hostetler <git@jeffhostetler.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eric DeCosta <edecosta@mathworks.com>
Subject: Re: [PATCH v6 4/6] fsmonitor: avoid socket location check if using
 hook
References: <pull.1326.v5.git.1662840031.gitgitgadget@gmail.com>
        <pull.1326.v6.git.1663100858.gitgitgadget@gmail.com>
        <3428bcf8763b553b722699d4095cb30cbf9709b6.1663100859.git.gitgitgadget@gmail.com>
Date:   Tue, 13 Sep 2022 18:48:09 -0700
Message-ID: <xmqq7d267mli.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 49B3B89E-33CF-11ED-BCF3-B31D44D1D7AA-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Eric DeCosta via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Eric DeCosta <edecosta@mathworks.com>
>
> If monitoring is done via fsmonitor hook rather than IPC there is no
> need to check if the location of the Unix Domain socket (UDS) file is
> on a remote filesystem.

Nicely done.


>
> Signed-off-by: Eric DeCosta <edecosta@mathworks.com>
> ---
>  compat/fsmonitor/fsm-settings-darwin.c | 10 ++++++----
>  compat/fsmonitor/fsm-settings-win32.c  |  2 +-
>  fsmonitor-settings.c                   |  8 ++++----
>  fsmonitor-settings.h                   |  2 +-
>  4 files changed, 12 insertions(+), 10 deletions(-)
>
> diff --git a/compat/fsmonitor/fsm-settings-darwin.c b/compat/fsmonitor/fsm-settings-darwin.c
> index dba3ced6bb7..3463c71763e 100644
> --- a/compat/fsmonitor/fsm-settings-darwin.c
> +++ b/compat/fsmonitor/fsm-settings-darwin.c
> @@ -49,13 +49,15 @@ static enum fsmonitor_reason check_uds_volume(struct repository *r)
>  	return FSMONITOR_REASON_OK;
>  }
>  
> -enum fsmonitor_reason fsm_os__incompatible(struct repository *r)
> +enum fsmonitor_reason fsm_os__incompatible(struct repository *r, int ipc)
>  {
>  	enum fsmonitor_reason reason;
>  
> -	reason = check_uds_volume(r);
> -	if (reason != FSMONITOR_REASON_OK)
> -		return reason;
> +	if (ipc) {
> +		reason = check_uds_volume(r);
> +		if (reason != FSMONITOR_REASON_OK)
> +			return reason;
> +	}
>  
>  	return FSMONITOR_REASON_OK;
>  }
> diff --git a/compat/fsmonitor/fsm-settings-win32.c b/compat/fsmonitor/fsm-settings-win32.c
> index d88b06ae610..a8af31b71de 100644
> --- a/compat/fsmonitor/fsm-settings-win32.c
> +++ b/compat/fsmonitor/fsm-settings-win32.c
> @@ -25,7 +25,7 @@ static enum fsmonitor_reason check_vfs4git(struct repository *r)
>  	return FSMONITOR_REASON_OK;
>  }
>  
> -enum fsmonitor_reason fsm_os__incompatible(struct repository *r)
> +enum fsmonitor_reason fsm_os__incompatible(struct repository *r, int ipc)
>  {
>  	enum fsmonitor_reason reason;
>  
> diff --git a/fsmonitor-settings.c b/fsmonitor-settings.c
> index d288cbad479..531a1b6f956 100644
> --- a/fsmonitor-settings.c
> +++ b/fsmonitor-settings.c
> @@ -60,7 +60,7 @@ static enum fsmonitor_reason check_remote(struct repository *r)
>  }
>  #endif
>  
> -static enum fsmonitor_reason check_for_incompatible(struct repository *r)
> +static enum fsmonitor_reason check_for_incompatible(struct repository *r, int ipc)
>  {
>  	if (!r->worktree) {
>  		/*
> @@ -77,7 +77,7 @@ static enum fsmonitor_reason check_for_incompatible(struct repository *r)
>  		reason = check_remote(r);
>  		if (reason != FSMONITOR_REASON_OK)
>  			return reason;
> -		reason = fsm_os__incompatible(r);
> +		reason = fsm_os__incompatible(r, ipc);
>  		if (reason != FSMONITOR_REASON_OK)
>  			return reason;
>  	}
> @@ -162,7 +162,7 @@ const char *fsm_settings__get_hook_path(struct repository *r)
>  
>  void fsm_settings__set_ipc(struct repository *r)
>  {
> -	enum fsmonitor_reason reason = check_for_incompatible(r);
> +	enum fsmonitor_reason reason = check_for_incompatible(r, 1);
>  
>  	if (reason != FSMONITOR_REASON_OK) {
>  		fsm_settings__set_incompatible(r, reason);
> @@ -185,7 +185,7 @@ void fsm_settings__set_ipc(struct repository *r)
>  
>  void fsm_settings__set_hook(struct repository *r, const char *path)
>  {
> -	enum fsmonitor_reason reason = check_for_incompatible(r);
> +	enum fsmonitor_reason reason = check_for_incompatible(r, 0);
>  
>  	if (reason != FSMONITOR_REASON_OK) {
>  		fsm_settings__set_incompatible(r, reason);
> diff --git a/fsmonitor-settings.h b/fsmonitor-settings.h
> index d9c2605197f..0721617b95a 100644
> --- a/fsmonitor-settings.h
> +++ b/fsmonitor-settings.h
> @@ -48,7 +48,7 @@ struct fsmonitor_settings;
>   * fsm_os__* routines should considered private to fsm_settings__
>   * routines.
>   */
> -enum fsmonitor_reason fsm_os__incompatible(struct repository *r);
> +enum fsmonitor_reason fsm_os__incompatible(struct repository *r, int ipc);
>  #endif /* HAVE_FSMONITOR_OS_SETTINGS */
>  
>  #endif /* FSMONITOR_SETTINGS_H */
