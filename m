Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8322EC433FE
	for <git@archiver.kernel.org>; Tue, 11 Oct 2022 05:21:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229537AbiJKFVs (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Oct 2022 01:21:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbiJKFVr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Oct 2022 01:21:47 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FCA07E305
        for <git@vger.kernel.org>; Mon, 10 Oct 2022 22:21:45 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 9602F1C2370;
        Tue, 11 Oct 2022 01:21:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=avdgaVUOKu+h4mGBB6HThOBYfm1FVoTcR7Rk6x
        cVr14=; b=YS9Ng8fjUBEWHKqRjuZF3Bef8R9i9HyBIBjXAczeOeSOCI1gR/rEkJ
        enoSjqbDLvKrawCMPdylrwX44lxwVUcxRdPos7GbM/3ueGFbqG5ncieXqXwKSESI
        4qOfEIL5Zfrz5VUZwcNiUzKrTMRp+Wf5n9nueKSlkxNVY1jER7/pU=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 8DC471C236F;
        Tue, 11 Oct 2022 01:21:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id C81D81C236E;
        Tue, 11 Oct 2022 01:21:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Eric DeCosta <edecosta@mathworks.com>, git@vger.kernel.org
Subject: Re: What's cooking in git.git (Oct 2022, #03; Mon, 10)
References: <xmqqlepnz1vu.fsf@gitster.g>
        <Y0S7/jA5tNeoQ2Hm@coredump.intra.peff.net>
Date:   Mon, 10 Oct 2022 22:21:40 -0700
In-Reply-To: <Y0S7/jA5tNeoQ2Hm@coredump.intra.peff.net> (Jeff King's message
        of "Mon, 10 Oct 2022 20:42:38 -0400")
Message-ID: <xmqqczazx7dn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 96F0288A-4924-11ED-ADE2-B31D44D1D7AA-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> There's a tiny leak in this one. Here's a fix that can go on top.
>
> -- >8 --
> Subject: [PATCH] fsmonitor: fix leak of warning message
>
> The fsm_settings__get_incompatible_msg() function returns an allocated
> string.  So we can't pass its result directly to warning(); we must hold
> on to the pointer and free it to avoid a leak.
>
> The leak here is small and fixed size, but Coverity complained, and
> presumably SANITIZE=leaks would eventually.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  fsmonitor.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Is there anybody else who is reading Coverity reports, I wonder.
This one is a clear positive.

Thanks.

> diff --git a/fsmonitor.c b/fsmonitor.c
> index 540736b39f..08af00c738 100644
> --- a/fsmonitor.c
> +++ b/fsmonitor.c
> @@ -309,8 +309,10 @@ void refresh_fsmonitor(struct index_state *istate)
>  	enum fsmonitor_reason reason = fsm_settings__get_reason(r);
>  
>  	if (!warn_once && reason > FSMONITOR_REASON_OK) {
> +		char *msg = fsm_settings__get_incompatible_msg(r, reason);
>  		warn_once = 1;
> -		warning("%s", fsm_settings__get_incompatible_msg(r, reason));
> +		warning("%s", msg);
> +		free(msg);
>  	}
>  
>  	if (fsm_mode <= FSMONITOR_MODE_DISABLED ||
