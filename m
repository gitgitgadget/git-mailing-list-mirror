Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DB07120196
	for <e@80x24.org>; Thu, 14 Jul 2016 20:09:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751348AbcGNUJo (ORCPT <rfc822;e@80x24.org>);
	Thu, 14 Jul 2016 16:09:44 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53302 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751285AbcGNUJn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jul 2016 16:09:43 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 1FFC22A948;
	Thu, 14 Jul 2016 16:09:42 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=wXxg5g8fCIFx4RukvF1L1LmNej8=; b=GrC1yP
	WISBNF9XG4Mfvq15Mm0kX+DGQEpjCccHdIHF8hUmH5r7h5CKvwJQ++fda2MKfDdC
	TyV47lZcFd2X3SSxMv9Zt9B2zSL3nSjG+gy+yk1FPR5HINw20OhhobY6KUIh/9eB
	PLHG+x8Iuxuotg8N0q7UTM+1anAGYLrmUvfgU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=duItBTo8Wmhem1ShAafSp2prQc/n8KmJ
	XQNc2qa50uiGqCJ6n0Vcb9dXTgCrDcmQhxPc0faXTYnG5RL7l0ytVWqZLDIl66hz
	zp0Q+KwX8GUWkkjl+uY1se1RHC5ul2vkRD4Lf/ysMwyiucKU07bQ96ypRB/cFNa7
	iPN7EJ6+FMk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 17BD72A947;
	Thu, 14 Jul 2016 16:09:42 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8FE8C2A946;
	Thu, 14 Jul 2016 16:09:41 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Jeff King <peff@peff.net>
Cc:	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
	Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v4 2/5] t5000: test tar files that overflow ustar headers
References: <20160630090614.GA16725@sigill.intra.peff.net>
	<20160630090857.GB17463@sigill.intra.peff.net>
	<alpine.DEB.2.20.1607141745420.6426@virtualbox>
	<20160714182108.GB16497@sigill.intra.peff.net>
	<xmqqshvcourb.fsf@gitster.mtv.corp.google.com>
Date:	Thu, 14 Jul 2016 13:09:39 -0700
In-Reply-To: <xmqqshvcourb.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Thu, 14 Jul 2016 13:00:08 -0700")
Message-ID: <xmqqfurcoubg.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E65B56AA-49FE-11E6-A0FC-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> OK, how about this on top of a replacement for js/t0006-for-v2.9.2
> that I'll send out as a reply to this message?

I won't repeat the patch body, but I had to write a log message, so 
here is what I tentatively committed (not queued yet).

Subject: archive-tar: huge offset and future timestamps would not work on 32-bit

As we are not yet moving everything to size_t but still using ulong
internally when talking about the size of object, platforms with
32-bit long will not be able to produce tar archive with 4GB+ file,
and cannot grok 077777777777UL as a constant.  Disable the extended
header feature and do not test it on them.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
