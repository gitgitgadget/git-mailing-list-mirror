Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 698371F404
	for <e@80x24.org>; Mon, 11 Dec 2017 23:23:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751663AbdLKXXS (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Dec 2017 18:23:18 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60995 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751379AbdLKXXR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Dec 2017 18:23:17 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 28E60BB69F;
        Mon, 11 Dec 2017 18:23:17 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=/Lon0n7PRrgUwLmFQ+r6pe+xqgQ=; b=MjE7mq
        Kdo6bbs7btlTzPOqW/exFG135QUimM45krB/YH01+n7m6lNZFUWLvsLBuMX6vAH6
        UU7RQ6I0TL11QwcgEv/d/j3d954d8alGy0G5+xuRm5TDJ68rWatpLSwnCLvzpR4A
        g4C6HGDWheTbGlNEwLKa+7JPoBZ7HR+k0Fbzw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=O2VC4b14v0IHR8hAv3C4wZ1SMcW5zTGJ
        Qmk9Zo1Hbexusv7IB/r/kuBvZ9MOWi/ItEK0DHBQiXR5tduv0DQa3WnO6moXKVAc
        iQ5SwBm4kCf5VIXLJmg/PbtaWKt7BtdsrHlonHZKWNq0eSJ1lfGBi9qSDyVpdt8F
        auULe8BzjG4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1FB7ABB69E;
        Mon, 11 Dec 2017 18:23:17 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 7590FBB69C;
        Mon, 11 Dec 2017 18:23:16 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org,
        Donald R Laster Jr <laster@dlaster.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v3 1/7] git-compat-util: introduce skip_to_optional_arg()
References: <20171209204013.10997-1-chriscool@tuxfamily.org>
        <20171210143118.GB19453@sigill.intra.peff.net>
        <20171210143914.GA19894@sigill.intra.peff.net>
Date:   Mon, 11 Dec 2017 15:23:15 -0800
In-Reply-To: <20171210143914.GA19894@sigill.intra.peff.net> (Jeff King's
        message of "Sun, 10 Dec 2017 09:39:15 -0500")
Message-ID: <xmqqmv2o4zoc.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 441D3810-DECA-11E7-98A5-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>
>   +       else if (starts_with(arg, "-B") ||
>   +                skip_to_optional_arg(arg, "--break-rewrites", NULL)) {
> 	  if ((options->break_opt = diff_scoreopt_parse(arg)) == -1)
>
> So that's kind-of weird, because we are parsing "-B", etc, and then
> expecting it to be _reparsed_ by diff_scoreopt_parse. So the two
> callsites must always match.

Correct.  diff_scoreopt_parse() can be coaxed to fit better within
this if/else if/... cascade by making it take a pointer to .break_opt
field and have it return "did I handle the -B/break-rewrites?" etc.,
but otherwise, this shows that skip_to_optional_arg() has impedance
mismatch with its current API.  And the NULL thing serves as a reminder
that skip_to_optional_arg() is used _only_ as a prefix check and not
for parsing.


