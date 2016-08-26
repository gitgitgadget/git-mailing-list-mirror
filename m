Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E34861FD99
	for <e@80x24.org>; Fri, 26 Aug 2016 23:30:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754337AbcHZXaS (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Aug 2016 19:30:18 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:65193 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751554AbcHZXaR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Aug 2016 19:30:17 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8DD1C39F38;
        Fri, 26 Aug 2016 19:24:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=zRzi0yfhQKwRHwmM5382/+0xiew=; b=i8pVEi
        acuXEcFUroBXfWUTJBynLLdGC8Y3bqLj705YkkcX+ap+qYNsNnFcdV3Z60BMafKG
        o7UFljJ4X9QnWdFsuoOY/BrVjezZUsX6FAQq8L3aewJ29gf0UPCFNoOKpDaZIId0
        33J53NFh3RMDHPCHEkL4OLK2OzC0iAmmEwbvk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=pArtea39xtk133Ulp9ddD7GCE5pWKgOR
        Nun9qmo931uoGwcR1kKJBr8pdUn9oI548SutBo5fl+FARBiEBjvzSF1KOaIEbacz
        wWyljyermQKviTk8ODAbpxVM9HhRKc/kx1pDip+CPqtz7m17zjHLdawCOlp/votC
        UJJA0C1JD2Y=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8678239F37;
        Fri, 26 Aug 2016 19:24:41 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 00ACF39F36;
        Fri, 26 Aug 2016 19:24:40 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Pranit Bauva <pranit.bauva@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v14 22/27] bisect--helper: `bisect_replay` shell function in C
References: <01020156b73fe5b4-5dc768ab-b73b-4a21-ab92-018e2a7aa6f7-000000@eu-west-1.amazonses.com>
        <01020156b73fe6d7-6cd42223-f46c-4e4c-a15f-516fc13a4521-000000@eu-west-1.amazonses.com>
Date:   Fri, 26 Aug 2016 16:24:38 -0700
In-Reply-To: <01020156b73fe6d7-6cd42223-f46c-4e4c-a15f-516fc13a4521-000000@eu-west-1.amazonses.com>
        (Pranit Bauva's message of "Tue, 23 Aug 2016 11:53:53 +0000")
Message-ID: <xmqq7fb3dsg9.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 437A6D10-6BE4-11E6-8ABF-51057B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Pranit Bauva <pranit.bauva@gmail.com> writes:

> +static int get_next_word(struct strbuf *line, struct strbuf *word)
> +{
> +	int i;
> +	for (i = 0; line->buf[i] != ' ' && line->buf[i] != '\0'; i++)
> +		strbuf_addch(word, line->buf[i]);
> +
> +	return 0;
> +}

This looks like a very non-standard way to use a string buffer.  The
function does not even have to take line as a whole strbuf, because
the logic does not even look at line->len and relies on line->buf[]
to be NUL terminated, which means the first parameter should instead
be "const char *buf", and the caller would feed then line.buf to the
function.

And I highly suspect that this is a very suboptimal interface, if
the caller then has to compute up to which byte in the line.buf to
splice away to get to the "next word" again.

A better alternative with higher level of abstraction would instead
be to keep the two strbuf parameters as-is, but have this function
responsible for "moving" the first word of "line" strbuf into "word"
strbuf.  Then the caller can repeatedly call this function to get
each word in "word" strbuf until "line" becomes empty if it wants to
implement "a word at a time" operation.

If that higher level of abstraction is too limiting for the caller
(and also that would be just as inefficient as the patch under
discussion), another alternative would be to have the caller
maintain "the current byte position in the input" and
do something like:

	int pos = 0;

	while (pos < line.len) {
                strbuf_reset(&word);
                get_next_word(line.buf, pos, word);
                pos += word.len;
		do a thing on "word";
	}

to implement "a word at a time" operation.  For this to work,
get_next_word() would need to skip the leading blanks itself, of
course.

In any case, I won't comment on the body of the function too deeply;
it will probably become a lot cleaner if you employed the "retval +
goto finish:" pattern for error handling.  Use of dequote seems
correct from the cursory look, too.

