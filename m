Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 704AD1FE4E
	for <e@80x24.org>; Tue, 12 Jul 2016 18:48:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751201AbcGLSs0 (ORCPT <rfc822;e@80x24.org>);
	Tue, 12 Jul 2016 14:48:26 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53306 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751177AbcGLSs0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 12 Jul 2016 14:48:26 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id D12512AC1B;
	Tue, 12 Jul 2016 14:48:19 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=mjQdVe4aeayZ
	dQTUZndiIvh4L8k=; b=uBmcpah9HQmW5yB9/6vTC9tlaUxCqoHJWQsVpUI0LlFh
	CwYWdeX163WsZCiVvuN/rQn1EQ23IYEkILYpPDlKTK5NwMJDaT+VRFZk7vpXzIJ6
	o+18uVMOa4y2Pq2ajfia33a+PklQAoMUehXNrxkSW7aZAoPlsvn5AXFyvBTuV/Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=HRbWGh
	PoEtEBiuYkdelZcCfjPZ3SsebMCOJscpT1Q7XJglvvrLVPg65ArsqaD783lVAvEH
	3FJASsWzEZ8FcRXbySTwYCNZdWStAADFxXMKWvUv8qIjZfUpnn6qv9FzqnEJX/vr
	yzSQr10X6s5Dt0huW67lnk4oE4JdIHaYGbJzQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id C85672AC1A;
	Tue, 12 Jul 2016 14:48:19 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 448732AC19;
	Tue, 12 Jul 2016 14:48:19 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:	git@vger.kernel.org, michelbach94@gmail.com
Subject: Re: [PATCH 0/5] Number truncation with 4+ GB files on 32-bit systems
References: <1466807902.28869.8.camel@gmail.com>
	<20160705170558.10906-1-pclouds@gmail.com>
	<xmqqshve6azl.fsf@gitster.mtv.corp.google.com>
Date:	Tue, 12 Jul 2016 11:48:17 -0700
In-Reply-To: <xmqqshve6azl.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Tue, 12 Jul 2016 10:07:42 -0700")
Message-ID: <xmqq37ne66by.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 336903EC-4861-11E6-B8F7-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: 8BIT
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Nguyễn Thái Ngọc Duy  <pclouds@gmail.com> writes:
>
>> Since I now could reproduce the problem that Christoph showed, I
>> decided to send the good patches out. To sum up, we use "unsigned
>> long" in some places related to file size. On 32-bit systems, it's
>> limited to 32 bits even though the system can handle files larger than
>> that (off_t is 64-bit). This fixes it.
>>
>> clang -Wshorten-64-to-32 is very helpful to spot these problems. I
>> have a couple more patches to clean all these warnings, but some need
>> more code study to see what is the right way to do.
>>
>> Most of the rest seems harmless, except for the local variable "size"
>> in builtin/pack-objects.c:write_one(). I might send 6/5 for that one.
>
>
> Thanks.

All looked nicely done.  I'll queue with a few SQUASH??? (please ack
or reject them) in between on 'pu' and push the result out later
today.

Thanks.
