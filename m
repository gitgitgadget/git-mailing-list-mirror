Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 197FE2018E
	for <e@80x24.org>; Mon,  8 Aug 2016 19:06:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752240AbcHHTGR (ORCPT <rfc822;e@80x24.org>);
	Mon, 8 Aug 2016 15:06:17 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64395 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752176AbcHHTGR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Aug 2016 15:06:17 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 8BAF633118;
	Mon,  8 Aug 2016 15:06:15 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=dCwOd5cQGd4evAZgQnr9Q/R4fL0=; b=DltQKW
	dk4qOFUjrsOZj+ZkZjP+ZI9KCog+tP6Cp5PREDvMAtTKjyPiR7RUyyIfLnE2OQta
	/k0lBA2MdJVa0cwOgzPH9EDAOHpO3K3KpodEo+2buv8FIvQTyIFZEP2sPeK7FHzL
	7S1hrgrP5GOfom1ZjUXR0AY43ZVXjPXScsOtk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=LOg2MFGXf+xeDHBplmomOuNaVcU5bFoH
	icxjmtsZ1iiuzd+CYdCqDJH0ZeWPcuOJ2wxQtnTXrPQQRTOpMd8DVx0ofZIHQgCg
	KrubQDQTBN23j5CJUwa37QFk3+kr/PqQBf+7L+PQG19dOe6pUI2HsTBdBDNBCGMc
	5vyyoTvVhek=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 8390433117;
	Mon,  8 Aug 2016 15:06:15 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id F373833116;
	Mon,  8 Aug 2016 15:06:14 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Jeff King <peff@peff.net>
Cc:	Kirill Smelkov <kirr@nexedi.com>, Vicent Marti <tanoku@gmail.com>,
	=?utf-8?Q?J=C3=A9rome?= Perrin <jerome@nexedi.com>,
	Isabelle Vallet <isabelle.vallet@nexedi.com>,
	Kazuhiko Shiozaki <kazuhiko@nexedi.com>,
	Julien Muchembled <jm@nexedi.com>, git@vger.kernel.org
Subject: Re: [PATCH 1/2] pack-objects: Teach --use-bitmap-index codepath to respect --local, --honor-pack-keep and --incremental
References: <20160729074051.GA5987@teco.navytux.spb.ru>
	<20160729074656.23813-1-kirr@nexedi.com>
	<xmqqy44gjqv9.fsf@gitster.mtv.corp.google.com>
	<20160808123734.GA3995@teco.navytux.spb.ru>
	<20160808135020.yggthtfekdiwq3lz@sigill.intra.peff.net>
Date:	Mon, 08 Aug 2016 12:06:13 -0700
In-Reply-To: <20160808135020.yggthtfekdiwq3lz@sigill.intra.peff.net> (Jeff
	King's message of "Mon, 8 Aug 2016 09:50:20 -0400")
Message-ID: <xmqqpopjdqsa.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2DC78CFC-5D9B-11E6-9EBE-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>> +	if grep -qFf nonlocal-loose 1.objects; then
>> +		echo "Non-local object present in pack generated with --local"
>> +		return 1
>> +	fi
>> +'
>
> grep -f isn't portable. However, I think:
>
>   echo $objsha1 >expect &&
>   git show-index <1.pack | cut -d' ' -f2 >actual
>   test_cmp expect actual
>
> would work (if you do stick with two entries, you might need to sort
> your "expect").

Hmph, are you sure?  "grep -f pattern_file" is in POSIX.1.

