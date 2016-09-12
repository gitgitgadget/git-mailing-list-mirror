Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EFC56207DF
	for <e@80x24.org>; Mon, 12 Sep 2016 19:53:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751644AbcILTxv (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Sep 2016 15:53:51 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51199 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750998AbcILTxu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Sep 2016 15:53:50 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D50F13D17D;
        Mon, 12 Sep 2016 15:53:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=P5JbKhJJI/n0fh63pDJ6M587GO0=; b=pkKu3b
        X8N1+pQlQvBS89NJavqMGG1vWHUv/vhsNfoMnWMZg3JEs/9TqU2jAJdaDUo/qv+N
        7ZCGUzHgWY88OMM8Q4rwpBKuE8j4vD8qfBW17TQ+UHaFIU3W9Y+MZ1hSZQZTpveO
        fZvcsSTcT1BoBsGh3HEV2YogwNV/dmpTRtpZg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ZwnXRhcc+iLNinoILLi5eop9dBvCLFMy
        nZHpT9Sal0hjZ1owNvNlaULHChkvSKqxjxSHbj81Rq6Zoq3AFveUCUS9sp47RcP7
        qOZRc8MQEmbYGAmzFF9/FZIMnO29mNGeGUuZXXl9XfsYMXnh4JKKihk/z3+59Yy0
        5rgQedXOsaY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id CE5803D17C;
        Mon, 12 Sep 2016 15:53:48 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 518E33D17A;
        Mon, 12 Sep 2016 15:53:48 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org,
        Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v2 04/25] sequencer: future-proof remove_sequencer_state()
References: <cover.1472457609.git.johannes.schindelin@gmx.de>
        <cover.1473590966.git.johannes.schindelin@gmx.de>
        <d6b92cd7aa56ceb515c50467a0e6030401e2e1bc.1473590966.git.johannes.schindelin@gmx.de>
Date:   Mon, 12 Sep 2016 12:53:46 -0700
In-Reply-To: <d6b92cd7aa56ceb515c50467a0e6030401e2e1bc.1473590966.git.johannes.schindelin@gmx.de>
        (Johannes Schindelin's message of "Sun, 11 Sep 2016 12:53:02 +0200
        (CEST)")
Message-ID: <xmqqinu028tx.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9EEBCC48-7922-11E6-A047-51057B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> +static const char *get_dir(const struct replay_opts *opts)
> +{
> +	return git_path_seq_dir();
> +}

Presumably this is what "In a couple of commits" meant, i.e. opts
will be used soonish.

> -static void remove_sequencer_state(void)
> +static void remove_sequencer_state(const struct replay_opts *opts)
>  {
> -	struct strbuf seq_dir = STRBUF_INIT;
> +	struct strbuf dir = STRBUF_INIT;
>  
> -	strbuf_addstr(&seq_dir, git_path_seq_dir());
> -	remove_dir_recursively(&seq_dir, 0);
> -	strbuf_release(&seq_dir);
> +	strbuf_addf(&dir, "%s", get_dir(opts));
> +	remove_dir_recursively(&dir, 0);
> +	strbuf_release(&dir);
>  }

As long as "who called the sequencer" is the only thing that
determines where the state is kept, this should work fine, I would
think.  I wondered that it would introduce a chicken-and-egg problem
if we had to support "git sequencer --clear-state" command ;-) but
that is not the case.

Good.
