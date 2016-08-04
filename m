Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BB04220193
	for <e@80x24.org>; Thu,  4 Aug 2016 15:39:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756858AbcHDPjV (ORCPT <rfc822;e@80x24.org>);
	Thu, 4 Aug 2016 11:39:21 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61512 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755297AbcHDPjU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Aug 2016 11:39:20 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A48C130B58;
	Thu,  4 Aug 2016 11:39:18 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=v9hQ159SbAbm3u/Ssh+/4UgZ9qs=; b=SgFciZ
	+Rz6gEhhX1meksZZjMbQEEERdVl2eGWBlCKKm5OpPfazWv5jKYUdVGaT3PKjjgjS
	sycE6NPHXSUFfggCS1osWDxcNKe/eoMY/c44uxxtcbNcoGjrCm1hox4R5Gy48E1Q
	FZk3H/uZcTvD2b5iyU0yHsrtBag1DwGGCL++Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=vs6+Eqp+N3mVwLahxeQorFodEAZZMlmw
	CIkW+HO3T05SjSieySbnlq+Bj3XLPLHEnrFF73IPFsNKEBdi1sXich/Jfjwr+J99
	TmeW49mhlEYO3cB22HEX7R9E3QCwp4Gf3CKv3JedAlGZPC6M6wKndlygItLwvU28
	MlJiQI9YsjQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 9C38B30B57;
	Thu,  4 Aug 2016 11:39:18 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 185F230B56;
	Thu,  4 Aug 2016 11:39:18 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Pranit Bauva <pranit.bauva@gmail.com>
Cc:	Git List <git@vger.kernel.org>
Subject: Re: [RFC/PATCH v11 03/13] bisect--helper: `write_terms` shell function in C
References: <0102015640423c26-2060fd70-c90d-4de3-ae8c-1801ad160b1c-000000@eu-west-1.amazonses.com>
	<0102015640423cd0-ae286008-08b7-4ca4-9b2b-f4226aa80a97-000000@eu-west-1.amazonses.com>
	<xmqq37mnf4vk.fsf@gitster.mtv.corp.google.com>
	<CAFZEwPNFz60GrX9ZqaFAvCU4HoNg8rmuqa0t5+DXFjaEHTmDeg@mail.gmail.com>
Date:	Thu, 04 Aug 2016 08:39:16 -0700
In-Reply-To: <CAFZEwPNFz60GrX9ZqaFAvCU4HoNg8rmuqa0t5+DXFjaEHTmDeg@mail.gmail.com>
	(Pranit Bauva's message of "Thu, 4 Aug 2016 01:51:48 +0530")
Message-ID: <xmqqvazg5ysb.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9B0A6162-5A59-11E6-9190-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Pranit Bauva <pranit.bauva@gmail.com> writes:

>>> +     res = fprintf(fp, "%s\n%s\n", bad, good);
>>> +     res |= fclose(fp);
>>> +     return (res < 0) ? -1 : 0;
>>> +}
>>
>> If fprintf(3) were a function that returns 0 on success and negative
>> on error (like fclose(3) is), the pattern to cascade the error
>> return with "res |= another_call()" is appropriate, but the made me
>> hiccup a bit while reading it.  It is not wrong per-se and it would
>> certainly be making it worse if we did something silly like
>>
>>         res = fprintf(...) < 0 ? -1 : 0;
>>         res |= fclose(fp);
>>
>> so I guess what you have is the most succinct way to do this.
>
> I agree with your point and your suggested code is better!

Puzzled... Read it again, I was not suggesting it---I was saying
"this could be a silly rewrite, which I think is making it worse".
