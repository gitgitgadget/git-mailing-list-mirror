Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-7.0 required=5.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A37451FE4D
	for <e@80x24.org>; Thu, 16 Jun 2016 18:18:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752713AbcFPSSa (ORCPT <rfc822;e@80x24.org>);
	Thu, 16 Jun 2016 14:18:30 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59694 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751930AbcFPSS0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Jun 2016 14:18:26 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id D601922703;
	Thu, 16 Jun 2016 14:18:19 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=wUoFa5XGroCiFVEUsFQJPP9w0kU=; b=KO1uyT
	Ivw7xH3K0+P12SpToar/NteMPwOhOJ3l4SgPLmSGaTWb/AuwriwQlZ9M4mScBjFU
	HQyODvPHS/jAJEZu3Cmy73xLARZSWYznVgRzGyjCVyojKI9p8+KaaGEuGYbfSpTn
	PDMT+TuVoOoMml7hro1Hx4Ek6PZb/m8/Am5Qk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=hr9NSiHDeM1VBzsxXUpdSLunBb9Rkbuz
	n4w2OYdBxvGVmlzm3sEBpA1ZbxTOlMEXs6xlGm0IPS9KYpt6LpEcisjVcmXh/R83
	LvFntmzSo9OECHOZ+PUauIQ1dpkfBMcO15s4bI9B9f8YyNfPiKumGFd6euBMO5d8
	qZco8YotSpk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id CCB6922702;
	Thu, 16 Jun 2016 14:18:19 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 5365422701;
	Thu, 16 Jun 2016 14:18:19 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Duy Nguyen <pclouds@gmail.com>
Cc:	Charles Bailey <charles@hashpling.org>,
	Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] grep: fix grepping for "intent to add" files
References: <20160616065324.GA14967@hashpling.org>
	<20160616074709.GA24412@duynguyen-vnpc.vn.dektech.internal>
	<20160616094749.GA20681@hashpling.org>
	<CACsJy8Bp6Mv2D1QCsR6MWhW2XMedo2svQKHBrx8AgA1Le56Grw@mail.gmail.com>
Date:	Thu, 16 Jun 2016 11:18:17 -0700
In-Reply-To: <CACsJy8Bp6Mv2D1QCsR6MWhW2XMedo2svQKHBrx8AgA1Le56Grw@mail.gmail.com>
	(Duy Nguyen's message of "Thu, 16 Jun 2016 17:57:18 +0700")
Message-ID: <xmqq37od576e.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B3D24548-33EE-11E6-BCE5-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

>> You don't think the revert is correct or you don't think the revert is
>> sufficient? (I wasn't able to find a test case which proved that the
>> change to line 399 was necessary, so perhaps I don't understand.)
>
> OK insufficient.
>
>> I would have thought that grepping the empty SHA-1 would be correct for
>> with or without -v. An "intent to add" file has no content in the index
>> so I would expect it to have zero matching and zero non-matching lines
>> for any grep --cached query?
>>
>> Or is this an efficiency and not a correctness concern?
>
> "git grep --cached" searches file content that will be committed by
> "git commit" (no -a). An i-t-a entry will not be committed (you would
> need "git add" first, or do "git commit -a"). So if I say "search
> among the to-be-committed file content, list files that do not match
> abc" (git grep -l -v --cached abc), the i-t-a entry will show up
> because its fake content is empty (i.e. not contain "abc"), even
> though it's not in the "to-be-committed" list. So yeah, correctness
> issue.

OK, sounds like a good start for a proper log message for the fix.
Thanks for hashing it all out before I got to the end of the thread
;-)
