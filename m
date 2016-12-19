Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 85C471FF40
	for <e@80x24.org>; Mon, 19 Dec 2016 19:05:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752679AbcLSTFj (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Dec 2016 14:05:39 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54433 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750889AbcLSTEL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Dec 2016 14:04:11 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8F52D581A2;
        Mon, 19 Dec 2016 14:04:10 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=W/RiXuge1h60RD6EoXpcayOm71k=; b=eg9P1S
        obhCLqfkm2kU9L5b7SPj8NRy3YILS3GPHu7VpMAIS+q8tcM29gnwme0PsRcXOAv0
        KFxySkxBdEWEkftfDrDV60ZKs0Ww+RCti0YBe/KK0z2p7sO4wPdVUcz/WA3Ep36C
        1VTU1tBxjhMsyPWlDMhH4BNOYhWoZlI0da4Ww=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=rtbUBY/qJdpzZUP0rmYXFj3YKMGRQ2ad
        lul0m3huC8xemKTjRRShoUdCcrDa7zRDPd74n4x6KFg4oeI9lTjLh9fevpkBcT3p
        NYzH8KwkopVl4YGGNI7XVCnihNzBJDbZ5gehtpXyjw92d3q5VofPOTKtoEp/fwpx
        /kQvAKPAckY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8809A581A1;
        Mon, 19 Dec 2016 14:04:10 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 09F0D5819F;
        Mon, 19 Dec 2016 14:04:09 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, Kevin Daudt <me@ikke.info>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: Re: [PATCH v2 27/34] sequencer (rebase -i): differentiate between comments and 'noop'
References: <cover.1472633606.git.johannes.schindelin@gmx.de>
        <cover.1481642927.git.johannes.schindelin@gmx.de>
        <b82347c627fd3b8a74827bc773a5df2d16c6dded.1481642927.git.johannes.schindelin@gmx.de>
Date:   Mon, 19 Dec 2016 11:04:08 -0800
In-Reply-To: <b82347c627fd3b8a74827bc773a5df2d16c6dded.1481642927.git.johannes.schindelin@gmx.de>
        (Johannes Schindelin's message of "Tue, 13 Dec 2016 16:31:57 +0100
        (CET)")
Message-ID: <xmqqvaufoi53.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: EC343FEC-C61D-11E6-A29F-E98412518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> In the upcoming patch, we will support rebase -i's progress
> reporting. The progress skips comments but counts 'noop's.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  sequencer.c | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)

> diff --git a/sequencer.c b/sequencer.c
> index 1f314b2743..63f6f25ced 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -770,7 +770,9 @@ enum todo_command {
>  	TODO_EXEC,
>  	/* commands that do nothing but are counted for reporting progress */
>  	TODO_NOOP,
> -	TODO_DROP
> +	TODO_DROP,
> +	/* comments (not counted for reporting progress) */
> +	TODO_COMMENT
>  };
>  
>  static struct {

Makes sense.  I would have done this immediately after introducing
NOOP if I were doing this series, if only because by having the
unchanging last element early in enum {} definition, we can avoid
having to deal with the "last element cannot have comma", but that
is not a big issue.

> @@ -785,12 +787,13 @@ static struct {
>  	{ 's', "squash" },
>  	{ 'x', "exec" },
>  	{ 0,   "noop" },
> -	{ 'd', "drop" }
> +	{ 'd', "drop" },
> +	{ 0,   NULL }
>  };
>  
>  static const char *command_to_string(const enum todo_command command)
>  {
> -	if ((size_t)command < ARRAY_SIZE(todo_command_info))
> +	if (command < TODO_COMMENT)
>  		return todo_command_info[command].str;
>  	die("Unknown command: %d", command);
>  }

The same comment as "instead of comparing with TODO_NOOP, you would
want is_noop()" applies to three instances of comparing with
TODO_COMMENT we can see in this patch, I think.

"is_counted()" perhaps?
