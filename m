Return-Path: <SRS0=dkLL=BK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B3E6C433E0
	for <git@archiver.kernel.org>; Fri, 31 Jul 2020 20:04:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D1D7E21744
	for <git@archiver.kernel.org>; Fri, 31 Jul 2020 20:04:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="nVeXQ+rp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726800AbgGaUER (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 31 Jul 2020 16:04:17 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:59581 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725938AbgGaUEQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Jul 2020 16:04:16 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id BB577EDC10;
        Fri, 31 Jul 2020 16:04:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=n+tdG0jyQJxBNFYGtvPRPa3bfMs=; b=nVeXQ+
        rpE6Ur81NgsGktwFkurYtcoEmmFfSjl3IKEBXN1wu5B6ovFDHRLchWP7JP8s7clc
        AtjahZrkAl6O2HU5WmGxt+c4Qr/HS9euU+HS3qxHqwKVv5Ez85tRIP8z4Y2rEJnu
        ccqgM3A0cAjNF164Al3LrkITfGPI7Z8Dwfi4g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=oUE8EIz/soRDYugvVBaVbUN4jX4TVGO+
        z3gQelJuf/jblkymfjLIccEkaaXk35+mpfs2hjHbXBUnumUBPONTbX/1rInVONNS
        WA7cGm+35JuDWlIuTzjKmtQXcFxCDgAOzCWLQIYQ2UIoKp/gRM+5a4LmCwzuzfrh
        HiWVthaiLlc=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B3FDAEDC0F;
        Fri, 31 Jul 2020 16:04:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 0A574EDC07;
        Fri, 31 Jul 2020 16:04:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Alban Gruin <alban.gruin@gmail.com>, git@vger.kernel.org,
        Christian Couder <christian.couder@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v1] t6300: fix issues related to %(contents:size)
References: <21bb2dad-5845-8cee-8f6a-1089ef7cae3b@gmail.com>
        <20200731174509.9199-1-alban.gruin@gmail.com>
        <20200731174709.GD843002@coredump.intra.peff.net>
Date:   Fri, 31 Jul 2020 13:04:10 -0700
In-Reply-To: <20200731174709.GD843002@coredump.intra.peff.net> (Jeff King's
        message of "Fri, 31 Jul 2020 13:47:09 -0400")
Message-ID: <xmqqpn8b30zp.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 006FB5DE-D369-11EA-AEE8-843F439F7C89-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Fri, Jul 31, 2020 at 07:45:09PM +0200, Alban Gruin wrote:
>
>> b6839fda68 (ref-filter: add support for %(contents:size), 2020-07-16)
>> added a new format for ref-filter, and added a function to generate
>> tests for this new feature in t6300.  Unfortunately, it tries to run
>> `test_expect_sucess' instead of `test_expect_success', and writes
>> $expect to `expected', but tries to read `expect'.  Those two issues
>> were probably unnoticed because the script only printed errors, but did
>> not crash.  This fixes these issues.
>
> Oh, this just crossed with my mail. :)
>
> Definitely fixes the issue, though I wonder:
>
>> -		echo $expect >expected
>> -		test_expect_${4:-sucess} $PREREQ "basic atom: $1 contents:size" '
>> +		echo $expect >expect
>> +		test_expect_${4:-success} $PREREQ "basic atom: $1 contents:size" '
>>  			git for-each-ref --format="%(contents:size)" "$ref" >actual &&
>>  			test_cmp expect actual
>>  		'
>
> Should we instead switch the test_cmp to look at "expected" to be
> consistent with the rest of the tests in this file?

If I recall correctly, "expect vs actual" were more common when I
counted across all the tests last time.  Matching local convention
is fine, though.
