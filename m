Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EC2D420954
	for <e@80x24.org>; Mon,  4 Dec 2017 14:31:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754157AbdLDObK (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Dec 2017 09:31:10 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51754 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752768AbdLDObJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Dec 2017 09:31:09 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8E9DAC898A;
        Mon,  4 Dec 2017 09:31:08 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=atwmKwHM3ymvXa551GitJjpr8/0=; b=iAVg/W
        lNfMmddzY9IhMCUh2zZOmjHup32pJcUiaiwm9L0c7cLdZruqhgTyELPyz0+WXv+k
        8+MpnBLV2IORkL5k/UN9ytq5NUw39Ib1k6Hn6PtBvNvGkgzUhIdwJ6lFQyrnzJaX
        NyyM6Wr/fZKb9uG0RG7P7umgJIHRWcc8QTn5g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=DU9PKYt40MQlbghC77CSet/2NqbzaWjh
        WZC63agmYpv11l/A5iFuKzN1cIQ4RffekVImOJMPkQOb+XMTPbw99H4ZxFwu/s0K
        44MDjDErOnRp0v5iWp//T1V3++f0TRVmk3laJxBndDjVYl1Q1XsQeEOYGUi51cyi
        biGM/sl5iTU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 86860C8989;
        Mon,  4 Dec 2017 09:31:08 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id CBC16C8987;
        Mon,  4 Dec 2017 09:31:07 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git@vger.kernel.org, Donald R Laster Jr <laster@dlaster.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v2 1/4] git-compat-util: introduce skip_to_optional_val()
References: <20171204125617.4931-1-chriscool@tuxfamily.org>
Date:   Mon, 04 Dec 2017 06:31:06 -0800
In-Reply-To: <20171204125617.4931-1-chriscool@tuxfamily.org> (Christian
        Couder's message of "Mon, 4 Dec 2017 13:56:14 +0100")
Message-ID: <xmqq8teio991.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C43A9824-D8FF-11E7-A40A-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> writes:

> From: Christian Couder <christian.couder@gmail.com>
>
> We often accept both a "--key" option and a "--key=<val>" option.
>
> These options currently are parsed using something like:
>
> if (!strcmp(arg, "--key")) {
> 	/* do something */
> } else if (skip_prefix(arg, "--key=", &arg)) {
> 	/* do something with arg */
> }
>
> which is a bit cumbersome compared to just:
>
> if (skip_to_optional_val(arg, "--key", &arg)) {
> 	/* do something with arg */
> }
>
> This also introduces skip_to_optional_val_default() for the few
> cases where something different should be done when the first
> argument is exactly "--key" than when it is exactly "--key=".
>
> In general it is better for UI consistency and simplicity if
> "--key" and "--key=" do the same thing though, so that using
> skip_to_optional_val() should be encouraged compared to
> skip_to_optional_val_default().
>
> Note that these functions can be used to parse any "key=value"
> string where "key" is also considered as valid, not just
> command line options.
>
> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> ---
>  git-compat-util.h | 23 +++++++++++++++++++++++
>  strbuf.c          | 20 ++++++++++++++++++++
>  2 files changed, 43 insertions(+)
>
> After thinking about it a bit more and taking a look at the
> current code, I thought that it was probably best to have
> both skip_to_optional_val() and skip_to_optional_val_default().

I guess we came to the same conclusion independently while our mails
crossed ;-)

>   - 2 new functions instead of 1
>   - "optional" instead of "opt" in the function names

I thought that the more important part you agreed was s/val/arg/,
though.

I had a few small comments on later steps, but I think these are
moving in the right direction.

Thanks.
