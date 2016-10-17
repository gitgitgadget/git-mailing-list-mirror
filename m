Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0E6F21F4F8
	for <e@80x24.org>; Mon, 17 Oct 2016 19:06:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757758AbcJQTGS (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Oct 2016 15:06:18 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59415 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1757604AbcJQTGO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Oct 2016 15:06:14 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1CE6245A97;
        Mon, 17 Oct 2016 15:06:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=44+mdrzubEWzFECKxjzpiauiAbE=; b=SpJOP/
        zCGXQauRno+CeHRqjByLw5RHWl33LQwW7iypHOJ03D4y+xoCHflu1VNsbGOXKyNK
        VxlvJIT52QbNwCq/NN0XtEgyGNh46WdhScwUBBdjecANQSwi4enCNv7xQzYwNhFp
        RgxIXZwBLURm6GeZeV72UbHJQt3MgROzYqYe0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=xOASgu28WjFqBu0YsB5ledxnGC6JB8Zw
        Dk6KH3EpL1M9GLb4u/qFg3e3xSAOtdA5M/GnUnVIy/2mKPTIJxVUa26QqYHXwTdN
        Q2qSWVOrtnLWqClS+7cOZrM440ZLdE3INX3VODMHFYJwhEpRKL8u5zcsIob+Q7BC
        2LU/P9MphuQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 13F1A45A96;
        Mon, 17 Oct 2016 15:06:08 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 4493A45A94;
        Mon, 17 Oct 2016 15:06:07 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org,
        Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH v4 05/25] sequencer: eventually release memory allocated for the option values
References: <cover.1476120229.git.johannes.schindelin@gmx.de>
        <cover.1476450940.git.johannes.schindelin@gmx.de>
        <b771bfbc88734b74acda0c377446e984ca81fd9c.1476450940.git.johannes.schindelin@gmx.de>
Date:   Mon, 17 Oct 2016 12:06:04 -0700
In-Reply-To: <b771bfbc88734b74acda0c377446e984ca81fd9c.1476450940.git.johannes.schindelin@gmx.de>
        (Johannes Schindelin's message of "Fri, 14 Oct 2016 15:17:24 +0200
        (CEST)")
Message-ID: <xmqq4m4avlr7.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C20F7126-949C-11E6-8EC1-3AB77A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> The sequencer is our attempt to lib-ify cherry-pick. Yet it behaves
> like a one-shot command when it reads its configuration: memory is
> allocated and released only when the command exits.
>
> This is kind of okay for git-cherry-pick, which *is* a one-shot
> command. All the work to make the sequencer its work horse was
> done to allow using the functionality as a library function, though,
> including proper clean-up after use.
>
> To remedy that, we now take custody of the option values in question,
> requiring those values to be malloc()ed or strdup()ed

That is the approach this patch takes, so "eventually release" in
the title is no longer accurate, I would think.

> Sadly, the current approach makes the code uglier, as we now have to
> take care to strdup() the values passed via the command-line.

I obviously disagree with that statement and the _entrust was too
ugly to live, but it is obviously subjective, and it boils down to
who has a better taste.  Let's not go there.

> +
> +	/* These option values will be free()d */
> +	opts->gpg_sign = xstrdup_or_null(opts->gpg_sign);
> +	opts->strategy = xstrdup_or_null(opts->strategy);

xstrdup-or-null does make things cleaner.

> +static int git_config_string_dup(char **dest,
> +				 const char *var, const char *value)
> +{
> +	if (!value)
> +		return config_error_nonbool(var);
> +	free(*dest);
> +	*dest = xstrdup(value);
> +	return 0;
> +}

So does this.
