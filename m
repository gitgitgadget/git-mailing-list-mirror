Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2A3211FD99
	for <e@80x24.org>; Sun, 14 Aug 2016 20:37:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751594AbcHNUhW convert rfc822-to-8bit (ORCPT
	<rfc822;e@80x24.org>); Sun, 14 Aug 2016 16:37:22 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62841 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751219AbcHNUhW (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Aug 2016 16:37:22 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id E68FF33308;
	Sun, 14 Aug 2016 16:37:20 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=iEgWQwCrbod1
	beeLCOAp+JF+mDE=; b=az9iSS2dMyD3Ik6t5YQWa4gENy3iESj2rrhLe090FIYZ
	1x/PAQCs8Saepr1YWkHVEAqLYH320FpPpdCOvGWvmKhlEm7RdC/5xFB2G1Uv9t13
	TLtnjsHVcgB5gEPM2bvU7yrjYNPI8d4PepQG++upJUKzzy1npv/zyJKKI96V9Pk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=IAjrXU
	Fb0c8kcrbTIc8bjJGGDeCGNTycSRgdUZ/LhIEOTyD3O/V07gA6GNseVbtPQ43jiZ
	Jv9mOMPwYvEH/uf0+4TZHx/hl37acqoGZ/51SHS3cXeUz62e4H+I7eZ4LAEuIwYB
	VUr2XH2mdNn/D619STU9fIz/T6M8w+Ej3iymQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id DD7B733307;
	Sun, 14 Aug 2016 16:37:20 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 6390C33306;
	Sun, 14 Aug 2016 16:37:20 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
Cc:	Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org, peff@peff.net,
	Johannes.Schindelin@gmx.de
Subject: Re: [PATCH v1 1/2] t0027: Correct raciness in NNO test
References: <20160809114938.pcrvirrzrh6ldmnr@sigill.intra.peff.net>
	<1471020662-20746-1-git-send-email-tboegi@web.de>
	<57AF4FCB.7090409@kdbg.org> <20160813211805.GA10624@tb-raspi>
Date:	Sun, 14 Aug 2016 13:37:17 -0700
In-Reply-To: <20160813211805.GA10624@tb-raspi> ("Torsten =?utf-8?Q?B=C3=B6?=
 =?utf-8?Q?gershausen=22's?=
	message of "Sat, 13 Aug 2016 21:18:05 +0000")
Message-ID: <xmqqpopbkrya.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: E5DBCC8C-625E-11E6-9440-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: 8BIT
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Torsten Bögershausen <tboegi@web.de> writes:

> Looking at t0027, it turns out that the changes in the test matrix done in 1/2
> are reverted in 2/2.
> This is not a good thing.
> Either (a) they should be marked as test_expect_failure in 1/2 and
> corrected in 2/2,
> or (b) 1/2 and 2/2 are squashed together and the noise in t0027 is minimal.

Probably (a) is a bit more kosher and useful when somebody wants to
inspect the history of the test ("the test was flaky and that hid a
few bugs, but we fix the timing-dependency which exposes the bugs"
in 1/2, "this is the fix for the bug that the previous one exposed"
in 2/2).  (b) might be a bit less work, though.

