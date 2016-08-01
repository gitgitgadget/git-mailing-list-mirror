Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E01521F855
	for <e@80x24.org>; Mon,  1 Aug 2016 18:15:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754474AbcHASP1 (ORCPT <rfc822;e@80x24.org>);
	Mon, 1 Aug 2016 14:15:27 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60398 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754404AbcHASP0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Aug 2016 14:15:26 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 5124F310DD;
	Mon,  1 Aug 2016 14:07:40 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=yHXWE3qOsMIDa34z8lpNlGVDKBk=; b=BxEv/E
	+5Y/da1H/hYwQ7nnRS7ywxqiGt2O7wmauQrm8bdhiRIB/MS5LaDixmnJDspO0WeA
	8AMzY4EZlioskpTDMfE7Zk86UOvfTnhKc4Ha5WTB8TBW8zpizYFtgl7wi1Qj5wFw
	BT4tDIGriYs0IZ0bnmGPCxftAQ70xh7NhUC0o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=yJrQQmZsalBknLuiK/5v4Pr+IAQQMhOz
	cJvccl9Aej1+1qxVj5SMQc+Hscicloa1GFuHKoR7gJISktJum+7twJRSoTch0+fN
	bKhxD5C6IUn5GVGRwcSai2+/0k8WIv9YD8Qfngmw+t5izPLsO6akf7nR2L6/39FG
	kksyoYaXHsA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 42FD3310DC;
	Mon,  1 Aug 2016 14:07:40 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B8D14310DB;
	Mon,  1 Aug 2016 14:07:39 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Jeff King <peff@peff.net>
Cc:	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Eric Wong <e@80x24.org>, "Kyle J. McKay" <mackyle@gmail.com>,
	git@vger.kernel.org
Subject: Re: [PATCH 1/2] pager: move pager-specific setup into the build
References: <20160801010557.22191-1-e@80x24.org>
	<20160801010557.22191-2-e@80x24.org>
	<20160801014303.x5j3dqumcmrkyc76@vauxhall.crustytoothpaste.net>
	<20160801172459.wz7wigmytxpfvs22@sigill.intra.peff.net>
Date:	Mon, 01 Aug 2016 11:07:37 -0700
In-Reply-To: <20160801172459.wz7wigmytxpfvs22@sigill.intra.peff.net> (Jeff
	King's message of "Mon, 1 Aug 2016 13:24:59 -0400")
Message-ID: <xmqq37mol5w6.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D59A0EFC-5812-11E6-8FD4-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I'm not too worried about spaces here. This is a resurrection of an old
> discussion, and in all that time, I think the only realistic suggestions
> for built-in values have been pretty tame.
>
> If this were used to parse arbitrary user-provided runtime values, I'd
> be more concerned. But I'm not sure why we would need that. Your $EDITOR
> example is arbitrary shell code, and we let the shell handle it (modulo
> some efficiency shortcuts). Likewise, fancy runtime things should go in
> GIT_PAGER, where you can not only set options with spaces, but do fancy
> things like pipes, shell functions, etc.
>
> The use of stringify() here is funny to me; I think there is a cpp
> tokenizing step in the middle that will do things like gobble up
> whitespace (but I'm not sure if it has other possible effects). I think
> our more usual method here would be to C-quote in the Makefile (with the
> equivalent of 's/\\/\\\\/g; s/"/\\"/g'), and then pass it to the
> compiler as a string literal, like -DPAGER_ENV=\"$(PAGER_ENV_CQ_SQ\".

All sensible arguments, including the rationale to reject 2/2.

Thanks.
