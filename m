Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7C54820229
	for <e@80x24.org>; Fri, 21 Oct 2016 18:31:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935008AbcJUSbA (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Oct 2016 14:31:00 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62133 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S933350AbcJUSa7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Oct 2016 14:30:59 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 62E8048A3C;
        Fri, 21 Oct 2016 14:30:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=73fy64+9WHzxOPAttEiAY49lRg4=; b=Yn9/Ai
        i4YE/hpm2ld3+Sq0GHWp0uEztNvE7bJxd2Jl6N/RAzjaGEXzRBlXSnRn/NKBcTK3
        U6685QVZLIn7SJwTBi1fVbbAhjyuFOBlKDpL2Zmj/bDtDpPgsZ5S0E4/Ahbq3xul
        CqKYsTg4NgCfs1hC6DT4IfGNTwqfAfiV48ALc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=porp88Z7yHqloxCvWcD+vZqS2Y8eSzVN
        PMwuQ+PKilpc4hvXdqdZ1tcda42L4js5WZT96QPWNTpDhd62Ri7KXbIyfN+Nw9z6
        R3doCg6x0mjan1izTAgBx8z3u536jGFG73bunBiqyo8McZAefSc7eyrjmDxinTpa
        fb/kHuO/t20=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5AF9348A3B;
        Fri, 21 Oct 2016 14:30:58 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id CEF7A48A3A;
        Fri, 21 Oct 2016 14:30:57 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org,
        Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH v5 19/27] sequencer: stop releasing the strbuf in write_message()
References: <cover.1476450940.git.johannes.schindelin@gmx.de>
        <cover.1477052405.git.johannes.schindelin@gmx.de>
        <c89508366501c17e7363a7d5c631fce9b3750cd2.1477052405.git.johannes.schindelin@gmx.de>
Date:   Fri, 21 Oct 2016 11:30:55 -0700
In-Reply-To: <c89508366501c17e7363a7d5c631fce9b3750cd2.1477052405.git.johannes.schindelin@gmx.de>
        (Johannes Schindelin's message of "Fri, 21 Oct 2016 14:25:41 +0200
        (CEST)")
Message-ID: <xmqqr379blls.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 82648E76-97BC-11E6-830C-3AB77A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> Nothing in the name "write_message()" suggests that the function
> releases the strbuf passed to it. So let's release the strbuf in the
> caller instead.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---

I agree that it makes quite a lot of sense from the point of view of
"taste in the API design".

>  sequencer.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/sequencer.c b/sequencer.c
> index d74fdce..745c86f 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -243,7 +243,6 @@ static int write_message(struct strbuf *msgbuf, const char *filename)
>  		return error_errno(_("Could not lock '%s'"), filename);
>  	if (write_in_full(msg_fd, msgbuf->buf, msgbuf->len) < 0)
>  		return error_errno(_("Could not write to %s"), filename);
> -	strbuf_release(msgbuf);
>  	if (commit_lock_file(&msg_file) < 0)
>  		return error(_("Error wrapping up %s."), filename);
>  
> @@ -759,6 +758,7 @@ static int do_pick_commit(enum todo_command command, struct commit *commit,
>  		free_commit_list(common);
>  		free_commit_list(remotes);
>  	}
> +	strbuf_release(&msgbuf);
>  
>  	/*
>  	 * If the merge was clean or if it failed due to conflict, we write
