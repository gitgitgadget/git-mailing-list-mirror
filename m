Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 70DD32022A
	for <e@80x24.org>; Wed, 26 Oct 2016 16:23:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932260AbcJZQXZ (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Oct 2016 12:23:25 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55517 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1755022AbcJZQXY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Oct 2016 12:23:24 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E9B8646D3C;
        Wed, 26 Oct 2016 12:23:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=e7nTcclLOqae24C2md+kE3gr064=; b=u9Zq+P
        Gl8KCYW6/xsLyVO/h6fhHsNnzzAh/5dRmWQd9wPAXE077ACr9mUTQVGl/h30Gsfg
        AhtymEy3qNM1O+pqmP9VYxu3+pC4pxdzM825UFqZ4nIbL1COsekgyrqwgsMXqH+V
        RZF/mL8A1GBNZHoLd3XW2EKsBcNWRAD0OCAy4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=BJe5ndDEhSqRZMUwlJZ0R1B6EMpSgP34
        GB8wBzRUkbCqCvD3RAwvWOBwCv9M3fmc44UL/w+PQwHmLyUeB2rqYQP6uc12L7rk
        peatbps+5M82XE30HsENhy8u3Mpv5Cq9Ndvgjs25xha7a94A1+dFOt6a56LuIQUF
        lZ6KLwAzBP4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E09AD46D3B;
        Wed, 26 Oct 2016 12:23:23 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 5CF1546D3A;
        Wed, 26 Oct 2016 12:23:23 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v3 2/3] sha1_file: open window into packfiles with O_CLOEXEC
References: <alpine.DEB.2.20.1610251327050.3264@virtualbox>
        <20161025181621.4201-1-gitster@pobox.com>
        <20161025181621.4201-3-gitster@pobox.com>
        <20161026042555.neaxvnmggtcku5cc@sigill.intra.peff.net>
Date:   Wed, 26 Oct 2016 09:23:21 -0700
In-Reply-To: <20161026042555.neaxvnmggtcku5cc@sigill.intra.peff.net> (Jeff
        King's message of "Wed, 26 Oct 2016 00:25:55 -0400")
Message-ID: <xmqqa8drcc5i.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 840A74CC-9B98-11E6-BA6F-3AB77A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>> +		/* Try again w/o O_CLOEXEC: the kernel might not support it */
>> +		if ((sha1_file_open_flag & O_CLOEXEC) && errno == EINVAL) {
>> +			sha1_file_open_flag &= ~O_CLOEXEC;
>>  			continue;
>>  		}
>
> So if we start with O_CLOEXEC|O_NOATIME, we drop CLOEXEC here and try
> again with just O_NOATIME. And then if _that_ fails...
>
>> +		/* Might the failure be due to O_NOATIME? */
>> +		if (errno != ENOENT && (sha1_file_open_flag & O_NOATIME)) {
>> +			sha1_file_open_flag &= ~O_NOATIME;
>> +			continue;
>> +		}
>
> We drop O_NOATIME, and end up with an empty flag field.
>
> But we will never have tried just O_CLOEXEC, which might have worked.

Yes, doing so would smudge atime, so one question is which one
between noatime or cloexec is more important to be done at open(2)
time.

It may be possible to open(2) only with cloexec and then fcntl(2)
FD_SET noatime immediately after, but going that way would explode
the combination even more, as it may not be possible to set these
two flags the other way around.

> I'm not sure it's worth worrying about or not; I don't know which
> systems are actually lacking either of the flags, or if they tend to
> have both.

