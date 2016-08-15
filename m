Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A4CBD1F6C1
	for <e@80x24.org>; Mon, 15 Aug 2016 20:36:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932233AbcHOUgf (ORCPT <rfc822;e@80x24.org>);
	Mon, 15 Aug 2016 16:36:35 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61667 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932207AbcHOUgf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Aug 2016 16:36:35 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id DAFA434758;
	Mon, 15 Aug 2016 16:36:33 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/Wb/PNop8zLjhVa74X8GL2LkCfg=; b=rtoCFZ
	ds8SGd72frD3VDMtcMqnhThjkNhDl6Zr7kxY6umkSsPl1k3Axye7Ham/mzLoNDbZ
	1kIdl/ZuqhajmKnGzwwu2CALTf3FDEgCRWqrhp5DPmtWqxVlKxaIW5YR50+K1D4S
	qlvaob9Lz48ybck8VomcTei9bHVu6BaHrFW2k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ebokkmWUwO5d0lrNhtWmXZ2OMTn+jF4t
	EP1wFNOc+L8ynK2qXDRA0GHU5qHzwuU+CJjXy1BYVN5itxlconnx/ZxNNOq1B/F0
	1nqj/W2+L90A4cKl+UwJKM9ZP7dyWQiu1GGBwkKZU2CvrfekNdUtyH5g4ALrEfLm
	aTaAAU76vyA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D192E34757;
	Mon, 15 Aug 2016 16:36:33 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 59CAB34756;
	Mon, 15 Aug 2016 16:36:33 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Stefan Beller <sbeller@google.com>
Cc:	"git\@vger.kernel.org" <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCHv4 5/8] clone: factor out checking for an alternate path
References: <20160811231405.17318-1-sbeller@google.com>
	<20160811231405.17318-6-sbeller@google.com>
	<xmqqa8ghvd3j.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kYVh7N-H7iO4E7HydeOzdUfxGTc3sUo8RhCzR33u9gRHw@mail.gmail.com>
Date:	Mon, 15 Aug 2016 13:36:31 -0700
In-Reply-To: <CAGZ79kYVh7N-H7iO4E7HydeOzdUfxGTc3sUo8RhCzR33u9gRHw@mail.gmail.com>
	(Stefan Beller's message of "Mon, 15 Aug 2016 12:03:22 -0700")
Message-ID: <xmqq1t1phir4.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F43B371C-6327-11E6-9C05-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> On Fri, Aug 12, 2016 at 3:25 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Stefan Beller <sbeller@google.com> writes:
>>
>>> +     struct strbuf sb = STRBUF_INIT;
>>> +     char *ref_git = compute_alternate_path(item->string, &sb);
>>
>> Who owns the memory for ref_git?
>
> The caller of compute_alternate_path(..), which makes
> add_one_reference faulty as of this patch.
>
>>
>>> -     if (!access(mkpath("%s/shallow", ref_git), F_OK))
>>> -             die(_("reference repository '%s' is shallow"), item->string);
>>> +     if (!ref_git)
>>> +             die("%s", sb.buf);
>>
>> Presumably the second argument to compute_alternate_path() is a
>> strbuf to receive the error message?  It is unfortunate that the
>> variable used for this purpose is a bland "sb", but perhaps that
>> cannot be helped as you would reuse that strbuf for a different
>> purpose (i.e. not to store the error message, but to formulate a
>> pathname).
>
> Ok. I had an intermediate version with 2 strbufs but for some reason I
> decided one is better. We'll have 2 again. (err and sb; sb will have a
> smaller scope only in the else part.)

My "unfortunate" was meant to say "it is unfortunate that this is
the best, adding one extra variable is not worth the cost".

>> Why do you need "err_buf", instead of directly writing the error to
>> "err", especially if "err" is not optional?
>>
>>> + ...
>>> +out:
>>> +     if (err_buf.len) {
>
> If we were directly writing to err, we would have checked
> err.len here. Then you open up a subtle way of saying "dry run"
> by giving a non empty error buffer.
>
> I contemplated doing that actually instead of splitting up into 2 functions,
> but I considered that bad taste as it would require documentation.

Sorry, but I do not understand this response at all.  I am still
talking about keeping one function "compute_alternate_path()".  The
suggestion was just to drop "struct strbuf err_buf" local variable,
and instead add the error messages the patch adds to err_buf with
code like:

> +	if (!ref_git_s) {
> +		strbuf_addf(&err_buf, _("path '%s' does not exist"), path);
> +		goto out;

to directly do

		strbuf_addf(err, _("path '%s' does not exist"), path);

instead.  That way you do not have to move the bytes around from one
buffer to the other, like this:

>>> +             strbuf_addbuf(err, &err_buf);
>>> +             free(ref_git);
>>> +             ref_git = NULL;
>>> +     }

If you allow err->len to be non-zero upon entry, you'd need a way to
remember if you noticed an error, so that you can free and clear
ref_git after "out:" label, and doing so with a separate variable
would make the code more readable, I would think, either by (1)
recording the original err->len upon entry, and comparing it with
err->len at "out:" label, or (2) using a new bool "seen_error = 0"
and setting it to true when you diagnose an error.  The latter would
make the code a bit more verbose but I suspect the result would be
easier to read than the former.

