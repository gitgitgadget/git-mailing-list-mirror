Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3C17B203BD
	for <e@80x24.org>; Tue, 25 Oct 2016 17:02:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932211AbcJYRCc (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Oct 2016 13:02:32 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53235 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1759282AbcJYRCb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Oct 2016 13:02:31 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6BB83494FD;
        Tue, 25 Oct 2016 13:02:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=VivKtvJGlTNIdyxh+5gHgL1l7B8=; b=s4UnXP
        6moEWUMm0cAghJLhwDnTQ4DOQMuU6ZLgNJdjCnVoXRzM8jo1fSnso/VJvrikNpKA
        P+1GjRAzSD1tqfipPZIJCxScg9j7okKBGjWSts0cF38gKT0PuH+HqgZwvI453Tt8
        BLb3pEyeT/sJSWFtt/EwST4LlRlYLBba88RVM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=yJK4a66ORYORL+rVFgtCyeF+7BRb6YbD
        6fcAthV3ckylBDdK6L66AMOWNWG/A16H+cEb14VdS5uU9LxNKAtv2HAXxWqhVpn+
        GwgkhL9QsZPrp/vVjt4vg57l7Ba60fwxTuLpQ9WbO2CsheaSHJqKjQF6STSVXqsT
        K397FWLRV9Q=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 63BC9494FC;
        Tue, 25 Oct 2016 13:02:30 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E6532494FB;
        Tue, 25 Oct 2016 13:02:29 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Eric Wong <e@80x24.org>, larsxschneider@gmail.com,
        git@vger.kernel.org, jnareb@gmail.com
Subject: Re: [PATCH v2 2/2] read-cache: make sure file handles are not inherited by child processes
References: <20161024180300.52359-1-larsxschneider@gmail.com>
        <20161024180300.52359-3-larsxschneider@gmail.com>
        <20161024183900.GA12769@starla>
        <xmqqwpgx4j89.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.20.1610251230150.3264@virtualbox>
Date:   Tue, 25 Oct 2016 10:02:26 -0700
In-Reply-To: <alpine.DEB.2.20.1610251230150.3264@virtualbox> (Johannes
        Schindelin's message of "Tue, 25 Oct 2016 12:33:54 +0200 (CEST)")
Message-ID: <xmqqshrks6ot.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D0495A02-9AD4-11E6-8BD5-987C12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> That still looks overly complicated, repeatedly ORing cloexec and
> recursing without need. How about this instead?
>
> 	static int oflags = O_RDONLY | O_CLOEXEC;
> 	int fd = open(ce->name, oflags);
>
> 	if ((O_CLOEXEC & oflags) && fd < 0 && errno == EINVAL) {
>   		/* Try again w/o O_CLOEXEC: the kernel might not support it */
> 		oflags &= ~O_CLOEXEC;
> 		fd = open(ce->name, oflags);
> 	}

I deliberately separated the part that can and designed to be
toggled (O_CLOEXEC) and the part that is meant to be constant
(O_RDONLY), and I do not think the first part of suggestion is
particularly a good idea.

I didn't write the same open twice, but I agree that an extra "we
fallback to opening with a different flags" inside the if () { }
block that is there exactly for implementing that fallback is an
excellent idea.  I like that part of the suggestion.

Thanks.
