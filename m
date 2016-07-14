Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B6E5320196
	for <e@80x24.org>; Thu, 14 Jul 2016 17:11:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751977AbcGNRLY (ORCPT <rfc822;e@80x24.org>);
	Thu, 14 Jul 2016 13:11:24 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51162 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751295AbcGNRLV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jul 2016 13:11:21 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id B3E852AC80;
	Thu, 14 Jul 2016 13:11:20 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=lKsU2q34YsQ1xuYvtXSB64A4kkE=; b=gPA4t3
	NQiQhuKXBpHGI6wkGdHcL/JLSxXG3JMxuRbbdRqNKCNabfwO3yJFrEbQ58rTqu9A
	Nyt212xycVgCBTcbDG0Emj3DfJEVODb8+JvsZjEdQ1z8vLEWrDuUg5nl356/A6kR
	hYr0+lvK8MF3810Y+c1Vtkex+WEltq5k4uJ+4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=a9HDtYd69LtBKeqvAUMAGWZzRAB54+Uq
	InmT5fS73y8EEP0ktuOPr49+zhn2rP+tefSnIAa4qZscZGFQzW51SSmVrnUgEjCG
	VFurapdLsI6/YnOlqrPfmS7GO/AmQoQ9hDyuB8Kx3tfh+V5jIulhs1MH9mb2rutp
	zzOycvZZhog=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id ACD802AC7F;
	Thu, 14 Jul 2016 13:11:20 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 377772AC7E;
	Thu, 14 Jul 2016 13:11:20 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Johannes Sixt <j6t@kdbg.org>
Cc:	Jeff King <peff@peff.net>, git@vger.kernel.org,
	=?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH v4 3/5] archive-tar: write extended headers for file sizes >= 8GB
References: <20160630090614.GA16725@sigill.intra.peff.net>
	<20160630090916.GC17463@sigill.intra.peff.net>
	<ac016bb4-9f69-7e03-bc99-7a5bbc1a1a33@kdbg.org>
Date:	Thu, 14 Jul 2016 10:11:18 -0700
In-Reply-To: <ac016bb4-9f69-7e03-bc99-7a5bbc1a1a33@kdbg.org> (Johannes Sixt's
	message of "Thu, 14 Jul 2016 18:48:45 +0200")
Message-ID: <xmqq60s8rvpl.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FBCF4A5A-49E5-11E6-B680-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Johannes Sixt <j6t@kdbg.org> writes:

> Am 30.06.2016 um 11:09 schrieb Jeff King:
>> +/*
>> + * This is the max value that a ustar size header can specify, as it is fixed
>> + * at 11 octal digits. POSIX specifies that we switch to extended headers at
>> + * this size.
>> + */
>> +#define USTAR_MAX_SIZE 077777777777UL
>
> This is too large by one bit for our 32-bit unsigned long on Windows:
>
> archive-tar.c: In function 'write_tar_entry':
> archive-tar.c:295: warning: integer constant is too large for
> unsigned long' type
> archive-tar.c: In function 'write_global_extended_header':
> archive-tar.c:332: warning: integer constant is too large for
> unsigned long' type
> archive-tar.c:335: warning: integer constant is too large for
> unsigned long' type
> archive-tar.c:335: warning: overflow in implicit constant conversion

Yikes.  I guess we need ULL here, and it cascade to all the
variables used to interact with this constant, but not everybody has
"long long", so....

