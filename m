Return-Path: <SRS0=aR3Y=3R=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02E28C32771
	for <git@archiver.kernel.org>; Tue, 28 Jan 2020 00:45:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A00982467C
	for <git@archiver.kernel.org>; Tue, 28 Jan 2020 00:45:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="xeSD3XT4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726099AbgA1Api (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Jan 2020 19:45:38 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55472 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725955AbgA1Api (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Jan 2020 19:45:38 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9163628CAC;
        Mon, 27 Jan 2020 19:45:37 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=vgikffoRB4OXB3Gkg/fLZkYrwDg=; b=xeSD3X
        T4jUtsPBIKwcWD+0uZzvPe+LFk6q87CbADfKUoYYmkcv6yDGnFgpj3BtOOr9mGaX
        jAjuDR6u/bEjpiR31jn2SoNjhY2W+KMqnWPx34wvNK7WAbhJ0UA6SQs0Ic8R9Y1E
        1Jfqa+xFZ8Q/CzqtsVsHZw6vroCkEP6nyIQ2s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=GRQuvnKG1TJAc4lhAWQ8t2wqxUagoSi2
        hZU1QbElN50yh4cWWjhINLo9Chbm9+xaqqQ2csiu2dtjcWPn9wne2AcOR+hRPmfU
        lT4vDsTl3GCsNmIPApePr7WU41yFAo22aOslfUL1FX0JwNTyz7zDmstNOtruhxTi
        L+3HGRNfRNU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 79B9A28CA9;
        Mon, 27 Jan 2020 19:45:37 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id CB9C828CA8;
        Mon, 27 Jan 2020 19:45:36 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] C: use skip-prefix to avoid hardcoded string length
References: <xmqqv9owa6cw.fsf@gitster-ct.c.googlers.com>
        <20200127232004.GE19360@coredump.intra.peff.net>
Date:   Mon, 27 Jan 2020 16:45:35 -0800
In-Reply-To: <20200127232004.GE19360@coredump.intra.peff.net> (Jeff King's
        message of "Mon, 27 Jan 2020 18:20:04 -0500")
Message-ID: <xmqq36c09zo0.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7FB8DD96-4167-11EA-83A7-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>> +		else if (skip_prefix(arg, "--expire=", &valptr)) {
>> +			if (parse_expiry_date(valptr, &cb.cmd.expire_total))
>>  				die(_("'%s' is not a valid timestamp"), arg);
>>  			explicit_expiry |= EXPIRE_TOTAL;
>>  		}
>
> In this case, I think the die message in the context could be improved
> to show "valptr". At which point you might as well do:
>
>   else if (skip_prefix(arg, "--expire=", &arg)) {

The version that loses "to which parameter did I give malformed
timestamp?" information was what I originally have written, and then
I added a new valptr variable to avoid the information loss and
message change.

But thinking about it again,

	git frotz --expire=tea --expire-unreachable=tee

would say "I don't know 'tee'" and then the user can go back and see
to which one the misspelt version went, and if the user did

	git frotz --expire=tee --expire-unreachable=tee

and got "I don't know 'tee'", then it also is OK to give that
without saying it is about --expire or --expire-unreachable; they
are both wrong ;-)

So, I guess it probably is a good idea to skip the option name in
the error message (we might have to adjust some tests, though).

Thanks.

>> -		else if (starts_with(arg, "--expire-unreachable=")) {
>> -			if (parse_expiry_date(arg + 21, &cb.cmd.expire_unreachable))
>> +		else if (skip_prefix(arg, "--expire-unreachable=", &valptr)) {
>> +			if (parse_expiry_date(valptr, &cb.cmd.expire_unreachable))
>>  				die(_("'%s' is not a valid timestamp"), arg);
>>  			explicit_expiry |= EXPIRE_UNREACH;
>>  		}
>
> Ditto here.
>
> -Peff
