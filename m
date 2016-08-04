Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A364820228
	for <e@80x24.org>; Thu,  4 Aug 2016 20:50:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965770AbcHDUuS (ORCPT <rfc822;e@80x24.org>);
	Thu, 4 Aug 2016 16:50:18 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55018 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S965701AbcHDUuR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Aug 2016 16:50:17 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 089F931C1A;
	Thu,  4 Aug 2016 16:45:14 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=M/Lc+XvzcThJYzN9pxa+5yi+oqY=; b=UxW24P
	TuDsYaJzBd0HrQpE3h0RsZje5kUFcrLrDSptIxMIS9ujibdoI1xBtrmB8b2j72gc
	svae9XkmBR2IFpg34vfsSsEgHJ04Z6gk5vXpoDimuRtOiaUpaeSbi4z3TBzAl5RB
	dc8zJoT/EPUjEQxUd3/xyOV317Zttk7iP0nYQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Qt6o+D6bDVJhiC1Dv5gerS2wltoljWTb
	5FoGOMU40unmaR0uHxlxoDIWWdkjRHoY0p5Y7vUQK+zfzIfEOUAeWzum7JEhdvEg
	uAoLkmnbDxs8QJNeZ3AHRaXWfUHX4WbHM4p23cVkb0k0xNcS98Nvnln6SmsOHaKN
	bhKWVZywkRs=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id F410931C19;
	Thu,  4 Aug 2016 16:45:13 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 7AE9F31C17;
	Thu,  4 Aug 2016 16:45:13 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Jeff King <peff@peff.net>
Cc:	larsxschneider@gmail.com, git@vger.kernel.org
Subject: Re: [PATCH 6/7] trace: disable key after write error
References: <20160803225600.fgm23bdacunmrw44@sigill.intra.peff.net>
	<20160803230103.daexq233ufrttnmn@sigill.intra.peff.net>
Date:	Thu, 04 Aug 2016 13:45:11 -0700
In-Reply-To: <20160803230103.daexq233ufrttnmn@sigill.intra.peff.net> (Jeff
	King's message of "Wed, 3 Aug 2016 19:01:04 -0400")
Message-ID: <xmqq8twc1cx4.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 57B69D56-5A84-11E6-B83D-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> If we get a write error writing to a trace descriptor, the
> error isn't likely to go away if we keep writing. Instead,
> you'll just get the same error over and over. E.g., try:
>
>   GIT_TRACE_PACKET=42 git ls-remote >/dev/null
>
> You don't really need to see:
>
>   warning: unable to write trace for GIT_TRACE_PACKET: Bad file descriptor
>
> hundreds of times. We could fallback to tracing to stderr,
> as we do in the error code-path for open(), but there's not
> much point. If the user fed us a bogus descriptor, they're
> probably better off fixing their invocation. And if they
> didn't, and we saw a transient error (e.g., ENOSPC writing
> to a file), it probably doesn't help anybody to have half of
> the trace in a file, and half on stderr.

Yes, I think I like this better than "we cannot open the named file,
so let's trace into standard error stream" that is done in the code
in the context of [3/7].  We should do the same over there.
