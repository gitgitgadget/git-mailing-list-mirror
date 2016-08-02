Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 16B881F71B
	for <e@80x24.org>; Tue,  2 Aug 2016 17:06:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967846AbcHBRG2 (ORCPT <rfc822;e@80x24.org>);
	Tue, 2 Aug 2016 13:06:28 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54316 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1030363AbcHBRGY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 2 Aug 2016 13:06:24 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 89A0F31654;
	Tue,  2 Aug 2016 13:06:22 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=bPbhlPYQ2hT2
	Fcry08pCzK93WOI=; b=CGQpxrJp5KxQScAnDkdoYCkALTbuy4RksRv5dTqHLo1S
	8wF0YqHKJArtZN632HFzNB/G57fE6gAXeGWGzJOv5SYlI3y9pYiHT/8ATUfulV4J
	MBnCSkZdpMPvmLfCgRihBiRA/tm9AL0faYYrIvvhgeobuEAfumMJyaqih/kMpTc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=km6nTy
	R65MXku3QaPSenVs0l/19BnDLVPfMdxr3oKwHoO17FOpvXCOrwKa31WnxKFEjCkg
	GLq9yjc2hQnj2vzsJwJakNszIEGR99q5Fzes/xJ/VXDbNRydGm7wcMROUGwmBgd5
	8lb3HUfvAG2w/MUYpkUdGAuRt8umRDfvro+2I=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 8207B31650;
	Tue,  2 Aug 2016 13:06:22 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 020333164F;
	Tue,  2 Aug 2016 13:06:21 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>
Cc:	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Kevin Willford <kcwillford@gmail.com>, git@vger.kernel.org,
	Kevin Willford <kewillf@microsoft.com>
Subject: Re: [[PATCH v2] 4/4] rebase: avoid computing unnecessary patch IDs
References: <20160729161920.3792-1-kcwillford@gmail.com>
	<20160729161920.3792-5-kcwillford@gmail.com>
	<xmqqa8h0m82f.fsf@gitster.mtv.corp.google.com>
	<alpine.DEB.2.20.1608011055180.149069@virtualbox>
	<xmqqtwf4i71l.fsf@gitster.mtv.corp.google.com>
	<8ec80c21-5ab1-d806-d8d6-e7180be00670@gmail.com>
Date:	Tue, 02 Aug 2016 10:06:19 -0700
In-Reply-To: <8ec80c21-5ab1-d806-d8d6-e7180be00670@gmail.com> ("Jakub
	=?utf-8?Q?Nar=C4=99bski=22's?= message of "Tue, 2 Aug 2016 11:50:58 +0200")
Message-ID: <xmqqoa5bf6d0.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 6FE81970-58D3-11E6-B4ED-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: 8BIT
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Jakub Narębski <jnareb@gmail.com> writes:

> The problem is that one expects hashmap_cmp_fn() to return ==0 on equality,
> while one would expect for hashmap_eq_fn() to return true (==1) on equality.
> So we would have to rewrite all calling sites.

Yes, and I do not think it is a "problem".  There only are about a
dozen callsites of hashmap_init().

> It would be nice to have a comment about how hashmap uses cmpfn in
> hashmap.h.  

That is the absolute minimum but I think that is already done in the
Documentation/technical/api-hashmap.txt.

> Though... currently our hashmap implementation uses linked
> list (separate chaining) for handling hash collisions (for collision
> resolution). More sophisticated data structures, such as balanced search
> trees,...

But that requires total ordering of the elements registered in a
hashmap.  So far, because cmp_fn that was misnamed was only about
equality, you can safely use a hashmap to store things that do not
have inherent order among them.  Besides, if your hashmap has to
optimize the hash collision resolution part with complex strucure,
your hash function is bad or your hash bucket growing strategy is
suboptimal, or both, which is the first thing you should look at,
not the "now how would we find it in the bucket with too many
things?"

