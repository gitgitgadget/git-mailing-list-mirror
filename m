Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A95C4203BD
	for <e@80x24.org>; Thu, 14 Jul 2016 22:27:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751348AbcGNW1F (ORCPT <rfc822;e@80x24.org>);
	Thu, 14 Jul 2016 18:27:05 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60207 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750699AbcGNW1E (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jul 2016 18:27:04 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 7F0BF2BBB3;
	Thu, 14 Jul 2016 18:27:02 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=hYjHvHN4fAzWWn0aJG8FQQPdf9o=; b=kgHVyG
	GwxVRW2cHWULwk3x4I3fNxUA42pYCvrf3faO/7gYPlV9dPqsRlebmVsZTu3ACs6/
	aapESug2RS5FTbuTGuyl1icPJlPtWiHOZseHi3RjocgV8fUw1jYPjPJYDFF+XZMH
	9l/3yVNYN1D59ovzPz2gqUemoZUAGhCagtZEg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=sZA2J4MdxpaZV+Ko0oZvA3UNaO98jExK
	U7zLMoGuiQ9QGsnjLgLY0RSOChrPaPF017c6l2l/UKoUtTdoTI18jOEcvvbzg8sG
	AmR7Uui3TVoMZ2yNP0aSL0OJYrG+tHAzFjJqkrhUuZdht9Xk44UKevJ+myzPSUgE
	Vh8eYymDxUs=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 774382BBB1;
	Thu, 14 Jul 2016 18:27:02 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 018DE2BBAF;
	Thu, 14 Jul 2016 18:27:02 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Johannes Sixt <j6t@kdbg.org>
Cc:	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jeff King <peff@peff.net>, git@vger.kernel.org,
	=?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH v4 2/5] t5000: test tar files that overflow ustar headers
References: <20160630090614.GA16725@sigill.intra.peff.net>
	<20160630090857.GB17463@sigill.intra.peff.net>
	<alpine.DEB.2.20.1607141745420.6426@virtualbox>
	<19a2d02e-3918-3bc9-db34-66e12ab950e4@kdbg.org>
	<xmqqa8hkrvu5.fsf@gitster.mtv.corp.google.com>
	<3d71cf3a-44c7-0620-0375-fb7ecf2fac13@kdbg.org>
Date:	Thu, 14 Jul 2016 15:26:59 -0700
In-Reply-To: <3d71cf3a-44c7-0620-0375-fb7ecf2fac13@kdbg.org> (Johannes Sixt's
	message of "Thu, 14 Jul 2016 22:52:55 +0200")
Message-ID: <xmqqtwfronyk.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1606B472-4A12-11E6-BE68-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Johannes Sixt <j6t@kdbg.org> writes:

> My first thought was that this is not warranted because t0006 is about
> commit time stamps, but the huge-tar breakage is file sizes, and the
> cases should be treated differently.
>
> But on second thought, under the hood, both boil down to the size of
> unsigned long in our implementation. It may make sense to tie both
> cases to the same prerequisite.
>
> On third thought, however, I think the two requirements could diverge
> in the future. The file size case should depend on the size of
> size_t. The timestamp case may become dependent on the size of time_t
> if we decide to move timestamp handling away from unsigned long: in
> modern(!) Microsoft SDKs, time_t is 64 bits, but unsigned long is 32
> bits, in both the 32-bit and 64-bit environments!

I had the same three toughts, but this being a 'maint' material
stopped me going too deep into them.  Right now, "long being 32-bit"
is the source of all of these issues, and we would solve them on the
development track (not necessarily during this cycle) by deciding on
more appropriate types.  Timestamps may become time_t, and object
sizes may become off_t, such changes will come separately, and each
of them would need to lift "unless long is 64-bit, skip this test"
limitation and swap it with something else.

