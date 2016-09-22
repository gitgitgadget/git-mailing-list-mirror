Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 104491F4F8
	for <e@80x24.org>; Thu, 22 Sep 2016 22:17:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757343AbcIVWR2 (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Sep 2016 18:17:28 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62405 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1757328AbcIVWR1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Sep 2016 18:17:27 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7BF8C40135;
        Thu, 22 Sep 2016 18:17:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=6E0Nh50K7eOmXY0avmAbbqsP8HI=; b=kwrE6d
        dogYTu+0fbSnsg04VVrnYtzqr90fKzTWTOSLQTIvMU34w7xLaBWn9+YnP1hbCpsK
        VWBNdTPVlZg086nMgO+fQtbNo1ZizmsBBVbpbW6NbcNmzQPAZs1oVAz2TAlQ6s7R
        3gbQf7Ptc7V+bJ7uiWPG63NsvNWXpMRnb3Lgo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=muz17OyI2I1vPXuTG4SutTWRnyRXukXd
        krU+Rgn4N4PTwmEiDAkk+h7GxLyuds7HJFPMw5QfHnKhs6mejm+U+GoIFoVkr4h2
        2Dzb+ifNpDCI5ucyF1IltaxRN/BrzX+nbZ9l8aDA2CkyddJcqGJKYZJ4DWrCsi/K
        h37ju0S0mcQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 748A940134;
        Thu, 22 Sep 2016 18:17:26 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E049E40133;
        Thu, 22 Sep 2016 18:17:25 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Kevin Daudt <me@ikke.info>, git@vger.kernel.org,
        Swift Geek <swiftgeek@gmail.com>
Subject: Re: [PATCH v2 2/2] mailinfo: unescape quoted-pair in header fields
References: <20160916210204.31282-1-me@ikke.info>
        <20160919185440.18234-3-me@ikke.info>
        <20160921110934.f6eu2dz6i2mlpa45@sigill.intra.peff.net>
Date:   Thu, 22 Sep 2016 15:17:23 -0700
In-Reply-To: <20160921110934.f6eu2dz6i2mlpa45@sigill.intra.peff.net> (Jeff
        King's message of "Wed, 21 Sep 2016 07:09:35 -0400")
Message-ID: <xmqq60pn37gs.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5788CC78-8112-11E6-AFCC-C26412518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Mon, Sep 19, 2016 at 08:54:40PM +0200, Kevin Daudt wrote:
>
>> + ...
>> +	while ((c = *in++) != 0) {
>> +		if (take_next_literally) {
>> +			take_next_literally = 0;
>> +		} else {
>> [...]
>> +		}
>> +
>> +		strbuf_addch(line, c);
>> +	}
>> +}
>
> It needs to `free(in)` at the end of the function.

Ehh, in has been incremented and is pointing at the terminating NUL
there, so it would be more like

	char *to_free, *in;

        to_free = strbuf_detach(line, NULL);
        in = to_free;
	...
        while ((c = *in++)) {
        	...
	}
        free(to_free);

I would think ;-).

        
