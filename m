Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A1B1E215F6
	for <e@80x24.org>; Wed, 12 Oct 2016 23:10:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932872AbcJLXKS (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Oct 2016 19:10:18 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53111 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752488AbcJLXKQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Oct 2016 19:10:16 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id CF32246355;
        Wed, 12 Oct 2016 18:57:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ey4SExMNThw5es5nVO00feIv6UA=; b=CcNhdz
        g2XvUr+oScinDC63AkJkVpqgq8OYorqXWxZlKTvxoSwJnrpCA8MAQpV/h8Id7Fub
        HsavqHAdEgpHTNsjhCta+Hz8GdpLc3MxpOdvQltGouWOMlgOBCT5a1/X/KtRlUwu
        LtpG3IrA/gUCcxxYjbGLse1oLIEOHcYlYxYwE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=OHRakhDNr0imWZAJxN+Jazts54YqTQEh
        Hgl8py3cA+/cgq/9fJh0k+10Zv26bFVXA50ylCd0pH1Oi9lFYKPBwJTjSNZ4S9w+
        20q48uNcjHM9I7ppaYAGWbOWra2rYpd9Y2+TBTb1ZuCdtrK4vf6Woj+JbDnlmw5X
        XKXFAVtm0w8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C7BA846354;
        Wed, 12 Oct 2016 18:57:33 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 38C3646351;
        Wed, 12 Oct 2016 18:57:33 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     "git\@vger.kernel.org" <git@vger.kernel.org>,
        Brandon Williams <bmwill@google.com>
Subject: Re: [PATCHv2] attr: convert to new threadsafe API
References: <20161011235951.8358-1-sbeller@google.com>
        <xmqqvawy5c4i.fsf@gitster.mtv.corp.google.com>
        <CAGZ79kZrNSmPAQ6SmBzFDJtSmdCbqKcgQu4KDLfoYVkSXvo-og@mail.gmail.com>
        <xmqqfuo15yjm.fsf@gitster.mtv.corp.google.com>
        <CAGZ79kaBhXHLDEK0XMLjm3QofmtaGZspA3EEx5x4-qCYY--wZA@mail.gmail.com>
Date:   Wed, 12 Oct 2016 15:57:31 -0700
In-Reply-To: <CAGZ79kaBhXHLDEK0XMLjm3QofmtaGZspA3EEx5x4-qCYY--wZA@mail.gmail.com>
        (Stefan Beller's message of "Wed, 12 Oct 2016 13:02:40 -0700")
Message-ID: <xmqqlgxt18h0.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 42AA3158-90CF-11E6-A930-5F377B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

>> But many callers do not follow that; rather they do
>>
>>         loop to iterate over paths {
>>                 call a helper func to learn attr X for path
>>                 use the value of attr X
>>         }
>>
>> using a callchain that embeds a helper function deep inside, and
>> "check" is kept in the helper, check-attr function is called from
>> there, and "result" is not passed from the caller to the helper
>> (obviously, because it does not exist in the current API).  See the
>> callchain that leads down to convert.c::convert_attrs() for a
>> typical example.  When converted to the new API, it needs to have a
>> new "result" structure every time it is called, and cannot reuse the
>> one that was used in its previous call.
>
> Why would that be? i.e. I do not understand the reasoning/motivation
> as well as what you propose to change here.

The leaf function may look like

	check_eol(const char *path)
	{
                static struct git_attr_check *check;

		initl(&check, "eol", NULL);
		git_check_attr(&check, path, result);
		return nth_element_in_result(result, 0);
	}                

and we want "result" to be thread-ready.  

A naive and undesired way to put it on stack is like so:

	const char *check_eol(const char *path)
	{
                static struct git_attr_check *check;
		struct git_attr_result result = RESULT_INIT;
		const char *eol;

		initl(&check, "eol", NULL);
		init_result(&check, &result);
		git_check_attr(&check, path, &result);
		eol = nth_element_in_result(&result, 0);
		clear_result(&result);
		return eol;
	}                

where your "struct git_attr_result" has a fixed size, and the actual
result array is allocated via ALLOC_GROW() etc.  That's overhead
that we do not want.  Instead can't we do this?

	const char *check_eol(const char *path)
	{
                static struct git_attr_check *check;
		/* we know we only want one */
		struct git_attr_result result[1];
		const char *eol;

		initl(&check, "eol", NULL);
		git_check_attr(&check, path, result);
		return result[0];
	}                

That way, we won't be doing ALLOC_GROW() in init_result() or free in
clear_result().

If you use a structure that has pointer to an array (i.e. the "naive
and undesired way" above), you cannot amortize the alloc/free by
making result "static" if you want to be thread-ready.
