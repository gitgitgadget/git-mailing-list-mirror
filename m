Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5E8881FE4E
	for <e@80x24.org>; Tue, 12 Jul 2016 20:38:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751054AbcGLUii (ORCPT <rfc822;e@80x24.org>);
	Tue, 12 Jul 2016 16:38:38 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57743 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750780AbcGLUih convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 12 Jul 2016 16:38:37 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 1FEFB2935D;
	Tue, 12 Jul 2016 16:38:31 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=eDvmGTTbKJRU
	kEi7ZsFsKzXV0ko=; b=k7KQyffza50+uvaE/b7xJQKkZUi8U4RQnRaYvYIAsS4s
	0rH75PVEfXL52GQwsG5nZ8CZ5fP9hdcNAuJJRI7yf74lpX8X9lcJnloJFBuE8M0n
	Gew1kKFYu6/Cm6tCUZSX/OR9CmdmMRHo/MYH7x3Th8ZwURn2PMbACn7JF4fKjFc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=WXtE6/
	wsC98F8O2fBxXGDiKfC8I5gTfMXF50ko/4uvA3zwIVwastLeJEUZW8ElHvJetBmc
	jxxaZfK4+yvAk6Xh2WET09t+5lpdtWcSw1VozHeV+Mu1LiahiUL3LDSiZT8cELhy
	GyZIzaEZyWT9N34F+aHPjCPY5h29+m0kUZk8k=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 185C22935C;
	Tue, 12 Jul 2016 16:38:31 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 88FBE2935B;
	Tue, 12 Jul 2016 16:38:30 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:	git@vger.kernel.org, michelbach94@gmail.com
Subject: Re: [PATCH 0/5] Number truncation with 4+ GB files on 32-bit systems
References: <1466807902.28869.8.camel@gmail.com>
	<20160705170558.10906-1-pclouds@gmail.com>
Date:	Tue, 12 Jul 2016 13:38:28 -0700
In-Reply-To: <20160705170558.10906-1-pclouds@gmail.com> (=?utf-8?B?Ik5n?=
 =?utf-8?B?dXnhu4VuIFRow6FpIE5n4buNYw==?=
	Duy"'s message of "Tue, 5 Jul 2016 19:05:53 +0200")
Message-ID: <xmqq60sa4mnv.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 980A3ED8-4870-11E6-8B53-89D312518317-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: 8BIT
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Nguyễn Thái Ngọc Duy  <pclouds@gmail.com> writes:

> Since I now could reproduce the problem that Christoph showed, I
> decided to send the good patches out. To sum up, we use "unsigned
> long" in some places related to file size. On 32-bit systems, it's
> limited to 32 bits even though the system can handle files larger than
> that (off_t is 64-bit). This fixes it.
>
> clang -Wshorten-64-to-32 is very helpful to spot these problems. I
> have a couple more patches to clean all these warnings, but some need
> more code study to see what is the right way to do.
>
> Most of the rest seems harmless, except for the local variable "size"
> in builtin/pack-objects.c:write_one(). I might send 6/5 for that one.

With 1-7/5 it appears t1050 is broken?
