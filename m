Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A842920323
	for <e@80x24.org>; Tue, 14 Mar 2017 06:00:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750788AbdCNGA4 (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Mar 2017 02:00:56 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60395 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750752AbdCNGAz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Mar 2017 02:00:55 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B255A66DFA;
        Tue, 14 Mar 2017 02:00:53 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=H1i77Mg6pKI8kPkESToHkkuZjN4=; b=u6XEhr
        tc1JJ1dIaiZmLZHX3jMX7mujyvLUTVpYUHrd+5Jf4BK7eN5hwTs5aw9vkcX7CocF
        TMfZrVDQzE1H6w6hvfvD/k8xhS9d/UfSWmCG87UiiBjXlNUZyESNe1ZEML+lYqoE
        FkUHYXf/m9O3FOUIzRcSC7+cN9LKUxiAUAKiM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=PxGwjsBfhiVsQNXYu1ynkxfS3PvP0NaX
        WMwLHYUX3l1PoQleUo/UtGWyax2YUOpOXeoOJcDQeTLcThwf47Aq3qeCS2Wcw82M
        xgV6uF5P7BSZjpR39roDuBfH5HvgtpPoH82hx7X8L6bqF+02vgjnoSniNghEE0FN
        Sl4ZnjwYyjs=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id ABA7666DF9;
        Tue, 14 Mar 2017 02:00:53 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 262F266DF8;
        Tue, 14 Mar 2017 02:00:53 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Andreas Politz <politza@hochschule-trier.de>
Cc:     git@vger.kernel.org
Subject: Re: git checkout exit value and post-commit hooks
References: <87y3w8k4ac.fsf@luca>
Date:   Mon, 13 Mar 2017 23:00:52 -0700
In-Reply-To: <87y3w8k4ac.fsf@luca> (Andreas Politz's message of "Tue, 14 Mar
        2017 02:58:35 +0100")
Message-ID: <xmqqshmgjt2j.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 94FCE7F6-087B-11E7-9F0E-97B1B46B9B0B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Andreas Politz <politza@hochschule-trier.de> writes:

> the exit value of a `git checkout' seems to depend on the exit values of
> the hooks it runs. This breaks for example `git bisect', as seen in the
> following example.

I am a bit puzzled why you have "checkout" and "post-commit" on the
title, though.  Does checkout call a hook for "commit"?

Any script that calls "git checkout" and sees it fail should not
blindly continue its usual processing; if "git bisect" notices an
error from "git checkout" it internally runs and stops, it is doing
the right thing.

A hook script that tries to do something during the main command
(e.g. "git checkout") and fails to do what it wanted to do needs a
way to tell the main command that it failed, and the way for it to
do so is to exit with non-zero status.  Upon seeing such an error,
the main command needs to relay the error to the end user, as the
operation as the whole (i.e. what the main command does, in addition
to what the end user wanted to customize by running the hook) failed.

So if your hook tells "git checkout" it failed to do something it
wanted to do, it is very sensible for that error to percolate up.
If that is not wanted, perhaps you should stop exiting with a failure
status from your hook when it did not fail?



