Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AF33E1FD99
	for <e@80x24.org>; Fri, 26 Aug 2016 17:19:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752839AbcHZRTw (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Aug 2016 13:19:52 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60129 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751321AbcHZRTv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Aug 2016 13:19:51 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9BE4537321;
        Fri, 26 Aug 2016 13:15:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=2Qhtwxn5BdlR2sjKaWRdy22B1fs=; b=XMiXHP
        Uh2AoZk7WeWKPrv5aUQC2KFLCiDB4/PCAZ7b4JAKxAvrsH584DCiQB4KnZsxnzRT
        YJolQGwh8UALutdXBt8CDP8bNeVzzy/0yJ0zDTLe1SZ8y8B0t4XnZnfpqjSScqmQ
        USmvrKuaqv2pHWVjF66zWyVAwBl05BfE5AK14=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=wbSAN9HZILwJ3C59PhqQB8XpnB4HQIS7
        pbaKzoByogXiBnkU3PcKceHOHCuEQwOeUV6BP+GmziiWthC9OvBXJZHhuZPTm2D0
        YHxq88FO+RGl92V1A5fnMvi4dNkB04DrlQIDReiUsLg0n7PuyiNIROgKlV3bUhU0
        J5aMCFUIYAo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 933B037320;
        Fri, 26 Aug 2016 13:15:44 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1D3623731F;
        Fri, 26 Aug 2016 13:15:44 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     git@vger.kernel.org, peff@peff.net, sbeller@google.com,
        Johannes.Schindelin@gmx.de, jnareb@gmail.com, mlbright@gmail.com
Subject: Re: [PATCH v6 05/13] pkt-line: add packet_write_gently()
References: <20160825110752.31581-1-larsxschneider@gmail.com>
        <20160825110752.31581-6-larsxschneider@gmail.com>
        <xmqq4m68ldrg.fsf@gitster.mtv.corp.google.com>
        <0BD3A97F-A9FD-45A6-AF82-E01CC6B9BA89@gmail.com>
Date:   Fri, 26 Aug 2016 10:15:42 -0700
In-Reply-To: <0BD3A97F-A9FD-45A6-AF82-E01CC6B9BA89@gmail.com> (Lars
        Schneider's message of "Fri, 26 Aug 2016 11:40:44 +0200")
Message-ID: <xmqqeg5bih8h.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B8E78A26-6BB0-11E6-BC26-F7BB12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Lars Schneider <larsxschneider@gmail.com> writes:

>> Do you anticipate future need of non-gently variant of this
>> function?  If so, perhaps a helper that takes a boolean "am I
>> working for the gently variant?" may help share more code.
>
> With helper you mean "an additional boolean parameter"? I don't 
> see a need for a non-gently variant right now but I will
> add this parameter if you think it is a good idea. How would the
> signature look like?
>
> int packet_write_gently(const int fd_out, const char *buf, size_t size, int gentle)
>
> This would follow type_from_string_gently() in object.h.

I actually imagined it would be more like your packet_write_fmt vs
packet_write_fmt_gently pair of functions.  If you do not have an
immediate need for a non-gentle packet_write() right now, but you
still forsee that it is likely some other caller may want one, you
could still prepare for it by doing a static

	packet_write_1((const int fd_out, const char *buf, size_t size, int gentle)

and make packet_write_gently() call it with gentle=1, without
actually introducing packet_write() nobody yet calls.


