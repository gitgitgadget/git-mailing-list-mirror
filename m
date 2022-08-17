Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27847C25B08
	for <git@archiver.kernel.org>; Wed, 17 Aug 2022 18:57:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241193AbiHQS5Q (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Aug 2022 14:57:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241339AbiHQS5G (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Aug 2022 14:57:06 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E379D7822A
        for <git@vger.kernel.org>; Wed, 17 Aug 2022 11:57:04 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1D592140F28;
        Wed, 17 Aug 2022 14:57:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=18+GLLI0M8HLk+q+2VmQBX2Mh
        P0/nnDkxgCOk2sYov4=; b=dpq+HR3GJ5vE9tdKur1tWHEATDkX2Bb3pMfNa4A28
        yWMnzy84/KgB/YYx0M8rp/Fc641OIFtL9se7+1oXqPc4hb87NUdBcD/UnbSJzA7t
        z7sIbtO5SwaXH24Jajr6oI8Ma4INKfL7hX+N8h/Wt3bkbhI7shSOIhkKxFEx2ivj
        xM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id F101F140F26;
        Wed, 17 Aug 2022 14:57:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 03469140F24;
        Wed, 17 Aug 2022 14:57:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>, git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2 5/6] pipe_command(): handle ENOSPC when writing to a
 pipe
References: <YvyE1RDFVAg4uQo1@coredump.intra.peff.net>
        <YvyGJiz+CFPcgpML@coredump.intra.peff.net>
Date:   Wed, 17 Aug 2022 11:57:01 -0700
Message-ID: <xmqqo7wivgua.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 6186FF2A-1E5E-11ED-B7CB-CB998F0A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> When write() to a non-blocking pipe fails because the buffer is full,
> POSIX says we should see EAGAIN. But our mingw_write() compat layer on
> Windows actually returns ENOSPC for this case. This is probably
> something we want to correct, but given that we don't plan to use
> non-blocking descriptors in a lot of places, we can work around it by
> just catching ENOSPC alongside EAGAIN. If we ever do fix mingw_write(),
> then this patch can be reverted.
>
> We don't actually use a non-blocking pipe yet, so this is still just
> preparation.
>
> Helped-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> Ironically, this ENOSPC bug means that switching away from xwrite() in
> the previous patch wasn't necessary (because it's not clever enough to
> know that ENOSPC on a pipe means EAGAIN!). But I think handling both
> shows the intent, and sets us up better for fixing mingw_write().

Yeah, I am impressed by the attention of small details by you two
shown here to split the steps 4/6 and 5/6.  If we consider that this
step is a band-aid we'd be happier if we can remove, perhaps in-code
comment to explain why we deal with ENOSPC here, instead of burying
it only in the log message, would help remind people of the issue
(but of course the patch is good with or without such a tweak, which
is only relevant in the longer term).

>  run-command.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/run-command.c b/run-command.c
> index e078c3046f..5fbaa8b5ac 100644
> --- a/run-command.c
> +++ b/run-command.c
> @@ -1377,7 +1377,8 @@ static int pump_io_round(struct io_pump *slots, i=
nt nr, struct pollfd *pfd)
>  				    io->u.out.len <=3D MAX_IO_SIZE ?
>  				    io->u.out.len : MAX_IO_SIZE);
>  			if (len < 0) {
> -				if (errno !=3D EINTR && errno !=3D EAGAIN) {
> +				if (errno !=3D EINTR && errno !=3D EAGAIN &&
> +				    errno !=3D ENOSPC) {
>  					io->error =3D errno;
>  					close(io->fd);
>  					io->fd =3D -1;
