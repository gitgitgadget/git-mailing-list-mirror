Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 08E5D1F461
	for <e@80x24.org>; Thu, 18 Jul 2019 21:07:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391074AbfGRVHb (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Jul 2019 17:07:31 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:61144 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727950AbfGRVHb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Jul 2019 17:07:31 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id EAF7C73729;
        Thu, 18 Jul 2019 17:07:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=G/AbUrgbFetmZkrZei1c9ZW8mb4=; b=mOqJ3/
        9ew1siujBehwBhQ8QqlQJDxIIoSnmOxU/0TqiuTFquahpAMNvFgz1dNE7t1TeIxI
        PMpB4hfixO1HbObtOCThgar7/7WG5eqVRdMW+JSFnjWbaQpQW+4AsYiUSrsAMw8S
        ftPd78zZ+Q7FfUTn2umTnMn+expcJwNOozmCI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=TxmB1A381/Ge8XDAL1CdgepUp5I0bk+N
        7KEDywn/c5UV+5aBSNv4sAMsJ8ACDy26ldsi+qKxqvIgm4dgR2VNe/LSewptFmi9
        vaS6m4uJDLjQ37VNhXX4YehYedmFCoLULp2YgyjNfTPK85IsTrC8SXsWCa6rvUtn
        aaDU5w+j/O0=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E402873728;
        Thu, 18 Jul 2019 17:07:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 1F20973727;
        Thu, 18 Jul 2019 17:07:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org,
        Ulrich Windl <Ulrich.Windl@rz.uni-regensburg.de>
Subject: Re: [PATCH] rm: resolving by removal is not a warning-worthy event
References: <5D2ED50D020000A100032435@gwsmtp.uni-regensburg.de>
        <xmqqd0i81ui4.fsf@gitster-ct.c.googlers.com>
        <xmqqims0z99w.fsf_-_@gitster-ct.c.googlers.com>
        <20190718202656.GC22038@sigill.intra.peff.net>
Date:   Thu, 18 Jul 2019 14:07:23 -0700
In-Reply-To: <20190718202656.GC22038@sigill.intra.peff.net> (Jeff King's
        message of "Thu, 18 Jul 2019 16:26:56 -0400")
Message-ID: <xmqq8ssvxd9w.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0B53F42C-A9A0-11E9-BA20-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>> +test_expect_success 'Resolving by removal is not a warning-worthy event' '
>> +	git reset -q --hard &&
>> +	test_when_finished "rm -f .git/index.lock msg && git reset -q --hard" &&
>> +	qfwfq=$(echo qfwfq | git hash-object -w --stdin) &&
>
> I'd have called this "$blob" for my own sanity in typing later lines,
> but OK. :)

OK, I can change that easily ;-)

>> +	do
>> +		echo "100644 $qfwfq $stage	qfwfq"
>> +	done | git update-index --index-info &&
>> +	git rm qfwfq >msg &&
>> +	test_i18ngrep ! "needs merge" msg &&
>
> Should we capture stderr from "git rm", too, to cover all bases?

Do you mean

	git rm blob >msg 2>&1

because we could later change our mind and send "needs merge"
message to the standard error stream?


