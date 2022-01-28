Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF28EC433EF
	for <git@archiver.kernel.org>; Fri, 28 Jan 2022 01:19:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345001AbiA1BTi (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Jan 2022 20:19:38 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56633 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232096AbiA1BTh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Jan 2022 20:19:37 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D325F10870A;
        Thu, 27 Jan 2022 20:19:36 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=xnDRxyP4ZEmJNoWTZlsJrHnBKdOdyq91Qp99AG
        srhH4=; b=EAc1cunJ9PnxPdqZtgv3Aag7qLOM2tw63gqdaUSMgVILfkkSuSOrwr
        BrT+2VKbvyizBzsQavdlcaKE9BzQ2lBWHk8OvLd5wL9PH/SCZzJOTQ+eLVZlCgc2
        VTFbT8p/HUl3kffPy5KZI5bi5YBXABskB9G99ov7ua2UvoLyTOSIg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C99DC108709;
        Thu, 27 Jan 2022 20:19:36 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3DFD1108708;
        Thu, 27 Jan 2022 20:19:36 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Robin Jarry <robin.jarry@6wind.com>
Cc:     git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>,
        Patryk Obara <patryk.obara@gmail.com>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: Re: [PATCH v3] receive-pack: check if client is alive before
 completing the push
References: <CHGR6XNP6TV7.15VGVNQUJM9J6@diabtop>
        <20220127215553.1386024-1-robin.jarry@6wind.com>
Date:   Thu, 27 Jan 2022 17:19:35 -0800
In-Reply-To: <20220127215553.1386024-1-robin.jarry@6wind.com> (Robin Jarry's
        message of "Thu, 27 Jan 2022 22:55:53 +0100")
Message-ID: <xmqqy230y7vc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5B47563E-7FD8-11EC-91EC-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Robin Jarry <robin.jarry@6wind.com> writes:

> Abort the push operation (i.e. do not migrate the objects from temporary
> to permanent storage) if the client has disconnected while the
> pre-receive hook was running.
>
> This reduces the risk of inconsistencies on network errors or if the
> user hits ctrl-c while the pre-receive hook is running.
>
> Send a keepalive packet (empty) on sideband 2 (the one to report
> progress). If the client has exited, receive-pack will be killed via
> SIGPIPE and the push will be aborted. This only works when sideband*
> capabilities are advertised by the client.
>
> Signed-off-by: Robin Jarry <robin.jarry@6wind.com>
> ---
> v2 -> v3:
>     I had missed Documentation/technical/pack-protocol.txt. Using
>     sideband 2 to send the keepalive packet works.

Yes, as long as sideband capability is supported (which is true
everywhere these days), this would be good.

Simple and sensible.

Thanks.



>  builtin/receive-pack.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
> index 9f4a0b816cf9..8b0d56897c9f 100644
> --- a/builtin/receive-pack.c
> +++ b/builtin/receive-pack.c
> @@ -1971,6 +1971,15 @@ static void execute_commands(struct command *commands,
>  		return;
>  	}
>  
> +	/*
> +	 * Send a keepalive packet on sideband 2 (progress info) to ensure that
> +	 * the client has not disconnected while pre-receive was running.
> +	 */
> +	if (use_sideband) {
> +		static const char buf[] = "0005\2";
> +		write_or_die(1, buf, sizeof(buf) - 1);
> +	}
> +
>  	/*
>  	 * Now we'll start writing out refs, which means the objects need
>  	 * to be in their final positions so that other processes can see them.
