Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0BA00209B4
	for <e@80x24.org>; Tue, 13 Dec 2016 20:43:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S938929AbcLMUmm (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Dec 2016 15:42:42 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62337 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S965757AbcLMUib (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Dec 2016 15:38:31 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id ABBAF5740D;
        Tue, 13 Dec 2016 15:38:02 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=qYI3r4ALlUzD/258FpG4FM5KjA0=; b=WJNs+W
        J64mB7hl2F1pMFP789lH38OguBglOw6qXvvw6husnqkj5QrARG72QuJh5YXgzyxj
        2s6FBY1km4ENOHKyV+QVHwk8fMibR74rCulGvcNrsspBf7C13u94+qqYTROM8cKL
        oRxcvdtbc2cELfc6eSMFxM3QAF1aoG1hb21xo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=V2w0zncw0YB6kZo2v5u+ueRVDiGhFghe
        CcAQXAoKRoKk/z1zXRqHEACxxlWe1/KJaJCCe4IDta50m1ncnNQWW1W+qhWQ5e5h
        KGc0vLpNHBy6XWfOhxmf9+MaI/8iNGJ3WWzyM+eosuQAjeBs/DgJ4NQMmAwMyNQ2
        r0OGW/QWWAY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A2F935740C;
        Tue, 13 Dec 2016 15:38:02 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 14C6F5740A;
        Tue, 13 Dec 2016 15:38:02 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, Kevin Daudt <me@ikke.info>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: Re: [PATCH v2 02/34] sequencer (rebase -i): implement the 'noop' command
References: <cover.1472633606.git.johannes.schindelin@gmx.de>
        <cover.1481642927.git.johannes.schindelin@gmx.de>
        <934c8e420cc4a75b1f3e4489fa4a4135c48f78ae.1481642927.git.johannes.schindelin@gmx.de>
Date:   Tue, 13 Dec 2016 12:38:00 -0800
In-Reply-To: <934c8e420cc4a75b1f3e4489fa4a4135c48f78ae.1481642927.git.johannes.schindelin@gmx.de>
        (Johannes Schindelin's message of "Tue, 13 Dec 2016 16:29:34 +0100
        (CET)")
Message-ID: <xmqqfulr1s5z.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0AB0144A-C174-11E6-B650-B2917B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> +/*
> + * Note that ordering matters in this enum. Not only must it match the mapping
> + * below, it is also divided into several sections that matter.  When adding
> + * new commands, make sure you add it in the right section.
> + */

Good thinking.  Makes me wish C were a better language, though ;-)

>  enum todo_command {
> +	/* commands that handle commits */
>  	TODO_PICK = 0,
> -	TODO_REVERT
> +	TODO_REVERT,
> +	/* commands that do nothing but are counted for reporting progress */
> +	TODO_NOOP
>  };
>  
>  static const char *todo_command_strings[] = {
>  	"pick",
> -	"revert"
> +	"revert",
> +	"noop"
>  };

> @@ -1292,7 +1316,12 @@ static int pick_commits(struct todo_list *todo_list, struct replay_opts *opts)
>  		struct todo_item *item = todo_list->items + todo_list->current;
>  		if (save_todo(todo_list, opts))
>  			return -1;
> -		res = do_pick_commit(item->command, item->commit, opts);
> +		if (item->command <= TODO_REVERT)
> +			res = do_pick_commit(item->command, item->commit,
> +					opts);
> +		else if (item->command != TODO_NOOP)
> +			return error(_("unknown command %d"), item->command);

I wonder if making this a switch() statement is easier to read in
the longer run.  The only thing at this point we are gaining by "not
only mapping and enum must match, the orders matter" is so that this
codepath can do the same thing for PICK and REVERT, but these two
would become more and more minority as we learn more words.

>  		todo_list->current++;
>  		if (res)
>  			return res;
