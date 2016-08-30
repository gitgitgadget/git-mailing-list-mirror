Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 300F71F6C1
	for <e@80x24.org>; Tue, 30 Aug 2016 17:32:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932969AbcH3Rc3 (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Aug 2016 13:32:29 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52263 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932614AbcH3Rc0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Aug 2016 13:32:26 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8D2FB38F7E;
        Tue, 30 Aug 2016 13:32:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=MO0N/UJO50W9R6kGQV/0bpsTwS0=; b=Cy5C6+
        j0sWtLK3dxCPap86mS3uu1KZIewLzt8K2MVePbkV9GrP4e7rCnm6nG8lUwxmgD3k
        /OE+R53AKFKlIzh9PNiJZChBWqO/IB5noGeguIvua8DPCT4a2dMkxFVX2XUrsevP
        UGM/SZWB4aAQtVu5/SCmJUojjaqX9Ikk6MWNw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=lkkOExvNbxbK/Ir9WdpkpOfUApGhkfcN
        vQT7wRoyYMs9SnuxCZoF/KsTx9M+f5yIuTRawDPqJm9OtbXq9nK2N4ymTvgaUT1w
        +9q4BmA19V+yCioTUbIDFam3HAkcFV+a7uEKOS3Eyoez+JsrCWku3fhipaPOclfi
        52+pKDXuaAM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8668F38F7D;
        Tue, 30 Aug 2016 13:32:24 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 03C5038F79;
        Tue, 30 Aug 2016 13:32:23 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 14/22] sequencer: prepare for rebase -i's commit functionality
References: <cover.1472457609.git.johannes.schindelin@gmx.de>
        <1d83fa095c03eac9abfd1038ff7791bae8ace984.1472457609.git.johannes.schindelin@gmx.de>
        <xmqq8tvf8dmz.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.20.1608300836030.129229@virtualbox>
Date:   Tue, 30 Aug 2016 10:32:22 -0700
In-Reply-To: <alpine.DEB.2.20.1608300836030.129229@virtualbox> (Johannes
        Schindelin's message of "Tue, 30 Aug 2016 08:53:30 +0200 (CEST)")
Message-ID: <xmqqfupm5fix.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B680F270-6ED7-11E6-ACC0-51057B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> > +static char **read_author_script(void)
>> > +{
>> > +	struct strbuf script = STRBUF_INIT;
>> > +	int i, count = 0;
>> > +	char *p, *p2, **env;
>> > +	size_t env_size;
>> > +
>> > +	if (strbuf_read_file(&script, rebase_path_author_script(), 256) <= 0)
>> > +		return NULL;
>> > +
>> > +	for (p = script.buf; *p; p++)
>> > +		if (skip_prefix(p, "'\\\\''", (const char **)&p2))
>> > +			strbuf_splice(&script, p - script.buf, p2 - p, "'", 1);
>> > +		else if (*p == '\'')
>> > +			strbuf_splice(&script, p-- - script.buf, 1, "", 0);
>> > +		else if (*p == '\n') {
>> > +			*p = '\0';
>> > +			count++;
>> > +		}
>> 
>> Hmph.  What is this loop doing?  Is it decoding a sq-quoted buffer
>> or something?  Don't we have a helper function to do that?
>
> Well, it is not just decoding an sq-quoted buffer, but several lines with
> definitions we sq-quoted ourselves, individually.
>
> The quote.[ch] code currently has no code to dequote lines individually.

There is a function with exactly the same name in builtin/am.c and I
assume that it is reading from a file with the same format, which
uses a helper to read one variable line at a time.  Hopefully that
can be refactored so that more parsing is shared between the two
users.

Two functions with the same name reading from the same format, even
when they expect to produce the same result in different internal
format, without even being aware of each other is a bad enough
"regression" in maintainability of the code.  One of them not even
using sq_dequote() helper and reinventing is even worse.
