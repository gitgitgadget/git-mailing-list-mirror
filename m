Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6A8EC20195
	for <e@80x24.org>; Fri, 22 Jul 2016 16:22:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752640AbcGVQWY (ORCPT <rfc822;e@80x24.org>);
	Fri, 22 Jul 2016 12:22:24 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64518 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752073AbcGVQWX convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 22 Jul 2016 12:22:23 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 851E82C534;
	Fri, 22 Jul 2016 12:22:22 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=Dxoy0j3CdgVJ
	AjzjYoVu+TfDOFs=; b=PUtES167EirGSvlln8cDXxVLmWWgMa8fVAMsSfSdvEs/
	Jaeuejmxi6yCRV0qPM9HaOFn1JPyHZ+8lXMSrdAIzQQZ4fmAMao1ZL4Kh7pduBLl
	NCiqsHDBk7crZNBuXB2KMxCy4zjHcGJmusxCMsxPxIYlGroI12nO+AUnSjP2rNU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=hwrSJd
	HMgT2Lj17BgCA7Gyyn/c+MmKto4z/LeSLMX8I23f3zP0ELflFQxdrSV84yBCi1wk
	sUtKJ5R++k/FIOienvjxnOb/Y7bFaIHKHdcxOLyZxYUIlzbxPrGqvBXr7IBuxEJF
	gCCxSTCTOtkJQgaxn24xyaY7cPbHt8J4gcKBU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 7BCFF2C533;
	Fri, 22 Jul 2016 12:22:22 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E24FC2C532;
	Fri, 22 Jul 2016 12:22:21 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Jeff King <peff@peff.net>
Cc:	=?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
	Git List <git@vger.kernel.org>
Subject: Re: [PATCH] use strbuf_addbuf() for appending a strbuf to another
References: <578E732D.2090803@web.de>
	<20160720132025.GD17469@sigill.intra.peff.net>
	<5790FC74.6000602@web.de>
	<20160721210253.GA4604@sigill.intra.peff.net>
Date:	Fri, 22 Jul 2016 09:22:19 -0700
In-Reply-To: <20160721210253.GA4604@sigill.intra.peff.net> (Jeff King's
	message of "Thu, 21 Jul 2016 17:02:54 -0400")
Message-ID: <xmqqr3albq2s.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 77C05670-5028-11E6-A93F-89D312518317-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: 8BIT
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I don't think we do. Going back to the original discussion:
>
>   http://thread.gmane.org/gmane.comp.version-control.git/136141/focus=136774
>
> it was mostly just "hey, this would fail really confusingly if we ever
> did, so let's make it safe".
>
> The second strbuf_grow() is by definition a noop (which is why 81d2cae
> works at all), but we do pay the size-computation cost.

Both true.  If the second one is not a noop, nothing is fixed by
81d2cae at all, but it is subtle.

René's update makes it far easier to understand what is going on.

>> -- >8 --
>> Subject: strbuf: avoid calling strbuf_grow() twice in strbuf_addbuf()
>> 
>> Implement strbuf_addbuf() as a normal function in order to avoid calling
>> strbuf_grow() twice, with the second callinside strbud_add() being a
>> no-op.  This is slightly faster and also reduces the text size a bit.
>
> Seems reasonable.  IMHO the main advantage is that one does not have to
> reason about the double strbuf_grow() (i.e., that the strbuf_add() is
> safe because we know its grow is a noop).
>
> -Peff
