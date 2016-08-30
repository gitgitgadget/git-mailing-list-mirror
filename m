Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 169D11F6C1
	for <e@80x24.org>; Tue, 30 Aug 2016 18:30:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758950AbcH3SaU (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Aug 2016 14:30:20 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64995 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752902AbcH3SaT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Aug 2016 14:30:19 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A5D5839A5C;
        Tue, 30 Aug 2016 14:30:17 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=MCmZaK/C/dMNt4JgA8qQY6cUVJU=; b=Q/gXBC
        m83WanplnJr1YVUYxYOropUYwA4QNLpHX6azjeeHGNcWfpw/kMA2wyqv5Ui1neyB
        D9N9fGQj3d++IlsxIlgdREnd7BjKuAAesQV8kEASPKeGZNNr3tqPX+e5MlrG8jhq
        ff0zK8cc15DLkjn3UdbSq3DNEBECzLJmI+JPc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=X8RYkVjxhu8rA4D8EJKK8+IoOcEGX5z2
        z3Fyo+dH/k72TUl2jLluvZN8umP1Eu/25oBiDRMQZs3VhZHw9iKR3EB/MlcEMeQB
        H5Hhdmf+kQUyGBGDAb9U6Zycjo39ACHgermbZqgEX23Z2zLh8fDYCvj8TxeaVtzj
        T/SRXPc6Cow=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9E97439A5B;
        Tue, 30 Aug 2016 14:30:17 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 2352639A5A;
        Tue, 30 Aug 2016 14:30:17 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 06/22] sequencer: release memory that was allocated when reading options
References: <cover.1472457609.git.johannes.schindelin@gmx.de>
        <e4b48a9a73ff33179556c0137caae85bfb4a48d9.1472457609.git.johannes.schindelin@gmx.de>
Date:   Tue, 30 Aug 2016 11:30:14 -0700
In-Reply-To: <e4b48a9a73ff33179556c0137caae85bfb4a48d9.1472457609.git.johannes.schindelin@gmx.de>
        (Johannes Schindelin's message of "Mon, 29 Aug 2016 10:04:37 +0200
        (CEST)")
Message-ID: <xmqqfupm3ya1.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CCA6130C-6EDF-11E6-8BFC-51057B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> @@ -811,13 +813,18 @@ static int populate_opts_cb(const char *key, const char *value, void *data)
>  		opts->allow_ff = git_config_bool_or_int(key, value, &error_flag);
>  	else if (!strcmp(key, "options.mainline"))
>  		opts->mainline = git_config_int(key, value);
> -	else if (!strcmp(key, "options.strategy"))
> +	else if (!strcmp(key, "options.strategy")) {
>  		git_config_string(&opts->strategy, key, value);
> -	else if (!strcmp(key, "options.gpg-sign"))
> +		sequencer_entrust(opts, (char *) opts->strategy);
> +	}
> +	else if (!strcmp(key, "options.gpg-sign")) {
>  		git_config_string(&opts->gpg_sign, key, value);
> +		sequencer_entrust(opts, (char *) opts->gpg_sign);
> +	}
>  	else if (!strcmp(key, "options.strategy-option")) {
>  		ALLOC_GROW(opts->xopts, opts->xopts_nr + 1, opts->xopts_alloc);
> -		opts->xopts[opts->xopts_nr++] = xstrdup(value);
> +		opts->xopts[opts->xopts_nr++] =
> +			sequencer_entrust(opts, xstrdup(value));
>  	} else
>  		return error(_("Invalid key: %s"), key);

Hmm.

I would have expected a call to sequencer_opts_clear(&opts) once the
machinery is done with the options structure, and among these places
where an old value in opts->field is overwritten by a new one would
get

	free(opt->field); opt->field = ... new value ...;

Perhaps there was a good reason to do it this way (one valid reason
may be that there is _no_ good place to declare that opts is now
done and it is safe to call sequencer_opts_clear() on it), but this
looks backwards from the way things are usually done.

