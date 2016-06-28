Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4D6872018A
	for <e@80x24.org>; Tue, 28 Jun 2016 19:02:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752305AbcF1TC1 (ORCPT <rfc822;e@80x24.org>);
	Tue, 28 Jun 2016 15:02:27 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54186 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751977AbcF1TC0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jun 2016 15:02:26 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 3E8F327740;
	Tue, 28 Jun 2016 15:02:25 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=uk6WEXTHGXkzcB78NgmRO1O6ORQ=; b=Vdc3VC
	iP2pcnvn9tAyOsWGO6p2HaluNV8oMYbBHTrnxkbgkafIez+Qls3BMDERjWAoaVcp
	5VHG8N+SL59/Dw7ZOJHwNS+NAwOTXYLJBFQf/YhqspRyrf780PyjTK1bqF3yBukv
	b66cvyQNC7LiwFVgrtqL2kPWo65Ahae/qTgv8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=CGctJeX5Wn95x6vkxDw4/2PSQq1oNpfb
	Xh73u1C6ASfCQ3+D9gJZtqqWucWyYz3Qwl16qbk3V082MY8qA1uL8sDR1N+5K2HZ
	HqdLijTRD5Zqh+t1V3FFzyqYiem4zSq30m/ex98eTsBoeF25ZjxCSmI7pPSrbV2x
	ktV6pVSVjXE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 36B3A2773B;
	Tue, 28 Jun 2016 15:02:25 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id AD4BF2773A;
	Tue, 28 Jun 2016 15:02:24 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Patrick Steinhardt <ps@pks.im>
Cc:	git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Daniel Hahler <git@thequod.de>
Subject: Re: [PATCH] rebase -i: restore autostash on abort
References: <20160628175704.26095-1-ps@pks.im>
Date:	Tue, 28 Jun 2016 12:02:22 -0700
In-Reply-To: <20160628175704.26095-1-ps@pks.im> (Patrick Steinhardt's message
	of "Tue, 28 Jun 2016 19:57:04 +0200")
Message-ID: <xmqqa8i587cx.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D9947382-3D62-11E6-AEF1-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Patrick Steinhardt <ps@pks.im> writes:

> When we abort an interactive rebase we do so by calling
> `die_abort`, which cleans up after us by removing the rebase
> state directory. If the user has requested to use the autostash
> feature, though, the state directory may also contain a reference
> to the autostash, which will now be deleted.
>
> Fix the issue by trying to re-apply the autostash in `die_abort`.
> This will also handle the case where the autostash does not apply
> cleanly anymore by recording it in a user-visible stash.

I do not do autostash myself, but it is a good thing to try not to
lose information ;-)

> +test_expect_success 'restore autostash on editor failure' '
> +	test_when_finished "git reset --hard" &&
> +	echo uncommited-content >file0 &&
> +	(
> +		test_set_editor "false" &&
> +		test_must_fail git rebase -i --autostash HEAD^
> +	) &&
> +	echo uncommited-content >expected &&

While making sure this case works is crucial, it is not an
interesting failure mode, is it?  Can we also have "does not apply
cleanly anymore" case, too?


> +	test_cmp expected file0
> +'
> +
>  test_done
