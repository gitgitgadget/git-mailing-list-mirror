Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A9CD820A10
	for <e@80x24.org>; Tue,  7 Nov 2017 01:15:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933220AbdKGBPI (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Nov 2017 20:15:08 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50738 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1755574AbdKGBPG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Nov 2017 20:15:06 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 26A31A52F6;
        Mon,  6 Nov 2017 20:15:04 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=DgjgnoiMr1nlTTOf6qngqfnGbjk=; b=lTlNxh
        UlxOfhT/XIsJTpnR1xdZhKscHakY5tOW+uud/ddGhJJTH3W5YXpXpZtb/eXdxDi0
        X7eRfj8+rIvgXaRvdE6cBTG2A1igVYsd2NVZBjOoMMokN5NHeV0mcZXA/uzC1Prn
        qX3rgGVUloo1UPboWYBlqgdMahjnn428lNeio=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ibOFf09y9UtxyLwh3xKdgmrjzLZnM9QA
        gd7dcqjTSdrS8SQVymL2T+qI2nDm9twNDgON0qsPZB3Rfmq0O281SRHfgztNBTHM
        t612sEwYxMmSVRPQYpqPjmz/UD7IZX20WW5r1coanjHMGiOUnm7PNmIz6mWIIIaS
        cZ2F4sWxdls=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D5293A52F4;
        Mon,  6 Nov 2017 20:15:03 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 066E8A52EE;
        Mon,  6 Nov 2017 20:15:02 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v2 2/8] t0021/rot13-filter: refactor packet reading functions
References: <20171105213836.11717-1-chriscool@tuxfamily.org>
        <20171105213836.11717-3-chriscool@tuxfamily.org>
Date:   Tue, 07 Nov 2017 10:15:00 +0900
In-Reply-To: <20171105213836.11717-3-chriscool@tuxfamily.org> (Christian
        Couder's message of "Sun, 5 Nov 2017 22:38:30 +0100")
Message-ID: <xmqqo9oehotn.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 147928A8-C359-11E7-9504-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> writes:

> +sub packet_required_key_val_read {
> +	my ( $key ) = @_;
> +	my ( $res, $buf ) = packet_txt_read();
> +	unless ( $res == -1 or ( $buf =~ s/^$key=// and $buf ne '' ) ) {
> +		die "bad $key: '$buf'";
> +	}
> +	return ( $res, $buf );
> +}

The function calls itself "required", but it does not die when it
sees an unexpected EOF or an empty line.  Neither of these cases
gives it a key (nor val), but it is not treated as an error.

That is curious, isn't it?

By the way, is it just me who finds this "unless" even less
unerstandable than the original in packet_txt_read() you modeled
this one after?  The original depended on packet_bin_read() to die
on an unexpected EOF, so its "unless" made some sense (we know we
got some input, and it is an error for the input not to end with LF
unless it is an empty string).  Negating the condition and making it
"if" may make it easier to understand, perhaps.  I dunno.
