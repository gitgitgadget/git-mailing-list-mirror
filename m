Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B17631F4F8
	for <e@80x24.org>; Wed,  5 Oct 2016 21:12:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754465AbcJEVMr (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Oct 2016 17:12:47 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56740 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754388AbcJEVMr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Oct 2016 17:12:47 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1FFA043ECE;
        Wed,  5 Oct 2016 17:12:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=On+N3FBrEEw1G3KZryiJvZKtSlY=; b=SElT4W
        /g4aL3e7GkOOgYV4KxGGaQP+5PKl3swTJUTHqqUwCqlY0hiCtPsCGZU0AYVKMcVs
        +R81Mpzrt9BL4zAhc6sFnySsIKkCCFOZw5P/mxJKn+dWwYnPTkW3h3xKqd1I0Wck
        G6Nhkrfbky4IDCoZUOtkLmB1g/tkNpiBvS4nc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=huCge3jrqOnVLVNjGVE4UkHRb4B3GNfj
        VV3oMUYih2UFRbuoNtlfe7CIghtoyMFvaVe+T7dz6Te2YqHg2oQMeUBVbVyaGjit
        kohsaJ4KEDgR44mdKlpJev9z6QIrM9PcsBxbHeFfx0ywGmtQFoG+b1PrHq+1pdUw
        TCZSeYde4i0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 178F243ECD;
        Wed,  5 Oct 2016 17:12:45 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 886EF43ECA;
        Wed,  5 Oct 2016 17:12:44 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     git@vger.kernel.org, ramsay@ramsayjones.plus.com, jnareb@gmail.com,
        j6t@kdbg.org, tboegi@web.de, peff@peff.net, mlbright@gmail.com
Subject: Re: [PATCH v9 04/14] run-command: add wait_on_exit
References: <20161004125947.67104-1-larsxschneider@gmail.com>
        <20161004125947.67104-5-larsxschneider@gmail.com>
        <xmqqh98rud20.fsf@gitster.mtv.corp.google.com>
        <1FD7FB64-0F40-47F0-A047-25B91B170E66@gmail.com>
Date:   Wed, 05 Oct 2016 14:12:42 -0700
In-Reply-To: <1FD7FB64-0F40-47F0-A047-25B91B170E66@gmail.com> (Lars
        Schneider's message of "Wed, 5 Oct 2016 22:57:07 +0200")
Message-ID: <xmqqeg3uo5yt.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 75784712-8B40-11E6-A5F4-5F377B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Lars Schneider <larsxschneider@gmail.com> writes:

> OK. Something like the patch below would work nicely.

Yeah, something along that line; it would eliminate the need to
worry about a field named "stdin" ;-)

But ...

>  	while (children_to_clean) {
>  		struct child_to_clean *p = children_to_clean;
>  		children_to_clean = p->next;
> +
> +		if (p->clean_on_exit_handler) {
> +			p->clean_on_exit_handler(p->pid, in_signal);
> +		}

... the application that used run_command() API would want to be
able to pass extra piece of data that is appliation-specific for the
child being killed, so it may make sense to extend the function
signature to take a pointer to "struct child_process" for the child
process being killed, together with a new field added to "struct
child_process" that is "void *exit_handler_cbdata;", perhaps?

