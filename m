Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F316D1FEAA
	for <e@80x24.org>; Tue, 19 Jul 2016 19:23:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751806AbcGSTX3 (ORCPT <rfc822;e@80x24.org>);
	Tue, 19 Jul 2016 15:23:29 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59877 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751631AbcGSTX2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jul 2016 15:23:28 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 419E92A3A1;
	Tue, 19 Jul 2016 15:23:27 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=mTfACRLB6Zv4EBsvFLalQ3BQdIg=; b=VQ7onL
	3Rb/66H1OeoJT+7faABjFzt8Cq2qRPKuzfwfS+XTkFSxzQ1Rnhmuhjiptfc+7yQI
	/ldNYL/5odcV47qi+9+9TDW7RtQ9jPFRUeKUyRBXsmPNv9+C6MiBZVS8mGGB2jmk
	3Vl2iqjhw3yiKnXsfT0QOn/2mPATXmDtdBlC4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=AX19DxZulyvl+7SWj0ihtjroAxSlc6pR
	dFk7t7Y7CfGKXs7OU5dbIehrcRExgEtBCwiAjkPesKlwarNBVK5BkcB/THSAxbPj
	Rf9odIdnzJQZExs1Df/gX4Igxtb9QLwAZCuf1KDdfx7xuuunNooOqtwPYFInSAs0
	8QVrj9tevtU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 37D7B2A3A0;
	Tue, 19 Jul 2016 15:23:27 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B20F12A39F;
	Tue, 19 Jul 2016 15:23:26 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Jonathan Tan <jonathantanmy@google.com>
Cc:	Stefan Beller <sbeller@google.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2] fetch-pack: grow stateless RPC windows exponentially
References: <xmqq37n6iq7d.fsf@gitster.mtv.corp.google.com>
	<1468880498-30235-1-git-send-email-jonathantanmy@google.com>
	<CAGZ79kY+2PYx9oz9tvi0zG-oE6qS-Za7D3ocY1XtqcSsDchz0Q@mail.gmail.com>
	<CAGf8dgL3t7uX7yAux0xc2QMJJdmnM0262Quj4o6gDehwA+4JqQ@mail.gmail.com>
Date:	Tue, 19 Jul 2016 12:23:24 -0700
In-Reply-To: <CAGf8dgL3t7uX7yAux0xc2QMJJdmnM0262Quj4o6gDehwA+4JqQ@mail.gmail.com>
	(Jonathan Tan's message of "Tue, 19 Jul 2016 12:03:24 -0700")
Message-ID: <xmqq8twxfn4j.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4470ABCE-4DE6-11E6-B5FC-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

>> So I guess what I do not understand is why we need to slow down the
>> exponential growth at all?
>
> The current code has an exponential (a' = a * 2) then a linear (a' = a
> + 1024) growth. I'm not slowing down the exponential growth - that
> part is retained. I'm replacing the linear growth with another
> conservative exponential growth (a' = a * 11 / 10).

As stateless-rpc mode is to drive a half-duplex channel, the
function essentially determines how many messages to buffer before
passing the control to the other side.  The increment between number
the function is called with and the function returns is how much the
other side is made to wait, i.e. how long the ping-pong latency is.

Even if it is conservative, I wonder if it is truly a good idea to
make it exponentially grow forever from that point of view.  Would
it give essentially the same result to you if we discard the patch
in question and just raise LARGE_FLUSH to 10k instead?

