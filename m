Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C2FE220954
	for <e@80x24.org>; Thu, 23 Nov 2017 01:38:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751936AbdKWBiK (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Nov 2017 20:38:10 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55121 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751897AbdKWBiJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Nov 2017 20:38:09 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D6C529D937;
        Wed, 22 Nov 2017 20:38:08 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=0miyiE+uxOtHrEZGBqLmDUN4/TM=; b=Qi8mk3
        UoF31/pRbWwjfpwvSIY/4VcW+C4hCLQAxi64d9mWP5iToXmCCR3A8iQPgRTH+a0d
        plZ32HNhnJRW5E+AfpruusaBwxRJdSEnpXRPpolTrlFAHX1DOArRWdVVEJjU/dl/
        uOZRe/AU++74MJM7xmIP1syCqGPMj5LT+XwYk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=iGIDdo5irtkUy1ebxnzQDanSBaEWCGoL
        ZVKjjYKO7QbUDCxpNVruSWE0qIs6meXjh0aFYa01b6ZF7Htq12vdbFPW4aBXQ5yg
        PCaiut84l+ZBYCGYGT/qoNKbsHafexM/NSebyQWRgLAnXa9cn84bepAA+MGvdpHs
        yJ4Or4Y8u44=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id CD72E9D936;
        Wed, 22 Nov 2017 20:38:08 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 43D1F9D934;
        Wed, 22 Nov 2017 20:38:08 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Jeff King <peff@peff.net>, Stefan Beller <sbeller@google.com>,
        git@vger.kernel.org, git@jeffhostetler.com
Subject: Re: [PATCH 0/3] Introduce BUG_ON(cond, msg) MACRO
References: <20171122223827.26773-1-sbeller@google.com>
        <20171122232457.GA8577@sigill>
        <20171122232814.GH11671@aiede.mtv.corp.google.com>
        <20171122233905.GC8577@sigill>
        <20171122234532.GI11671@aiede.mtv.corp.google.com>
        <20171122235851.GE8577@sigill>
        <20171123000839.GL11671@aiede.mtv.corp.google.com>
Date:   Thu, 23 Nov 2017 10:38:07 +0900
In-Reply-To: <20171123000839.GL11671@aiede.mtv.corp.google.com> (Jonathan
        Nieder's message of "Wed, 22 Nov 2017 16:08:39 -0800")
Message-ID: <xmqqefopsrk0.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F55176EA-CFEE-11E7-960B-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

> FWIW I think we've done fine at using assert so far.  But if I
> understand correctly, the point of this series is to stop having to
> worry about it.

I recalled that there was at least one, and "log -Sassert" piped to
"less" that looks for "/^[ ^I]*assert\(" caught me one recent one.

    08414938 ("mailinfo.c: move side-effects outside of assert", 2016-12-19)

Even though I do not personally mind

	assert(flags & EXPECTED_BIT);
	assert(remaining_doshes == 0);

left as a reminder primarily for coders, we can do just as well do
so with

	if (remaining_doshes != 0)
		BUG("the gostak did not distim all doshes???");

So I am fine if we want to move to reduce the use of assert()s or
get rid of them.  I personally prefer (like Peff, if I am not
mistaken) an explicit use of the usual control structure, as it is
easy to follow.  BUG_ON() would become another thing readers need to
get used to, if we were to use it, and my gut feeling is that it may
not be worth it.

A few more random things related to this topic that comes to my
mind:

 - If we had a good set of tools to tell us if an expression is free
   of side-effects, then assert(<expression>) would be less
   problematic---we could mechanically check if an assert() that is
   left as a reminder for coders/readers is safe.

 - Even if we had such a check, using the check only on new changes
   when a patch is accepted is not good enough.  An assert(distim())
   may have been safe back when it was added because distim() used
   to be free of side-effects, but a later update to it may add side
   effects to it.

 - The issue that is caused by "this function used to be pure but
   lately it gained side-effects" is not limited to assert().  Using
   it in "if (condition) BUG(...)" or "BUG_ON(condition,...)" will
   not sidestep the fact that such a change will alter behaviour of
   callers of the function.  It's just that assert(condition) is
   conditionally compiled, which makes the issue a worse one.


