Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D048C433EF
	for <git@archiver.kernel.org>; Fri, 18 Feb 2022 00:34:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229984AbiBRAe7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Feb 2022 19:34:59 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:51488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiBRAe6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Feb 2022 19:34:58 -0500
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31D4E115E
        for <git@vger.kernel.org>; Thu, 17 Feb 2022 16:34:38 -0800 (PST)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D6AC21051AA;
        Thu, 17 Feb 2022 19:32:19 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=CLI79cnZrPTF41eT3Wl+fMvTKLNtlDkPGVRx3tOWUYo=; b=JD3x
        tLLExhD70cb50r0hzBNSmSv3Y1xeZif6BCiBe0DPxSeNuTWdU0IUMydBjTp8ZZj9
        odo/RcEKA+yEaPufk5+O06OxQkeH/0OdkoyAOYQq5tWTdSR97dqIbzLT4BUL5DsV
        WEVaqI6I3NztAikXVWMCbmFV4Q+1VMG0eyQebHY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id CDEC11051A8;
        Thu, 17 Feb 2022 19:32:19 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.212.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 393E21051A7;
        Thu, 17 Feb 2022 19:32:19 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Han-Wen Nienhuys <hanwen@google.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>
Subject: Re: [PATCH v2 2/7] reftable: reject 0 object_id_len
References: <pull.1185.git.git.1642010868.gitgitgadget@gmail.com>
        <pull.1185.v2.git.git.1645106124.gitgitgadget@gmail.com>
        <4c1a19fc4aef2742e2733b804221186aa164f721.1645106124.git.gitgitgadget@gmail.com>
Date:   Thu, 17 Feb 2022 16:32:18 -0800
Message-ID: <xmqqwnht3tgt.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3AF5AFC2-9052-11EC-A4E4-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Han-Wen Nienhuys <hanwen@google.com>
>
> The spec says 2 <= object_id_len <= 31. We are lenient and allow 1,
> but we forbid 0, so we can we can be sure that we never read a

s/we can we can/we can/;

> 0-length key.
>
> Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
> ---
>  reftable/reader.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/reftable/reader.c b/reftable/reader.c
> index 00906e7a2de..54b4025105c 100644
> --- a/reftable/reader.c
> +++ b/reftable/reader.c
> @@ -155,6 +155,11 @@ static int parse_footer(struct reftable_reader *r, uint8_t *footer,
>  	r->log_offsets.is_present = (first_block_typ == BLOCK_TYPE_LOG ||
>  				     r->log_offsets.offset > 0);
>  	r->obj_offsets.is_present = r->obj_offsets.offset > 0;
> +	if (r->obj_offsets.is_present && !r->object_id_len) {
> +		err = REFTABLE_FORMAT_ERROR;
> +		goto done;
> +	}
> +
>  	err = 0;
>  done:
>  	return err;
