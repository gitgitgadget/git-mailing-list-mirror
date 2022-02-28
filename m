Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC024C4167E
	for <git@archiver.kernel.org>; Mon, 28 Feb 2022 18:10:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232146AbiB1SKq (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Feb 2022 13:10:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240525AbiB1SJB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Feb 2022 13:09:01 -0500
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D5DC5DE72
        for <git@vger.kernel.org>; Mon, 28 Feb 2022 09:48:39 -0800 (PST)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C2E9D11EFBF;
        Mon, 28 Feb 2022 12:48:29 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=1MkF8ykVvhnp
        irGbFQIQyJStH3VWpciWS4XNwm+Gm+o=; b=SCrycW0h+NYSp9Ky3cnCJjlpHedp
        5U1qYnVPSwB+ikOo5SziHqMafw6JzC2Z4VxeHPuF4q2uojbxNozHnkoXm9d/8Wp/
        JMtmbqbN+NLcnS6qj14IWIY63N+9fsXs+GGeZj25ka2GGXq24Dls3PERQGfnWF5h
        NQ1tby0okgmcVPY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B7B8311EFBE;
        Mon, 28 Feb 2022 12:48:29 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 2A53A11EFBD;
        Mon, 28 Feb 2022 12:48:29 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        git <git@vger.kernel.org>
Subject: Re: [PATCH v4 2/2] parse-options.c: add style checks for usage-strings
References: <xmqqtuck3yv2.fsf@gitster.g>
        <20220228073908.20553-1-chakrabortyabhradeep79@gmail.com>
Date:   Mon, 28 Feb 2022 09:48:28 -0800
In-Reply-To: <20220228073908.20553-1-chakrabortyabhradeep79@gmail.com>
        (Abhradeep Chakraborty's message of "Mon, 28 Feb 2022 13:09:08 +0530")
Message-ID: <xmqqzgma287n.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: A342BC7C-98BE-11EC-A40A-CB998F0A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com> writes:

> Okay, that's great. But one thing I want to ask - How the discussion
> for `adding check for usage strings` will be held i.e. Whether the
> idea is discarded for now.
>
> If it is not discarded, then how to proceed? Johannes prefers the first
> version and =C3=86var prefers the `add check to parse-options.c` versio=
n.

My take on it is that the "first version" that uses an ad-hoc shell
script will not become acceptably robust.  If coccinelle or other
static analyzer can help us check more reliably, that would be great
because we won't incur runtime cost of checking, like the embedded
check we added in the latest version that we are tentatively removing.

I also think Dscho simply overreacted only because the check broke
an in-flight topic that is from his group, which is not universally
built, and the tests in it was written in such a way that the error
output from the embedded check was not immediately available when
run in the CI, making it harder to debug.  None of that is a fault
in the approach of using the embedded check.

If the embedded check were there from the beginning, together with
tons of the existing checks done by parse_options_check(), the
developers themselves of the in-flight topic(s) would have caught
the problem, even before it hit the public CI.  I am very sure Dscho
wouldn't have complained or even noticed that you added a new check
to the parse_options_check().

So from my point of view, plan should be

 (0) I have been assuming that the check we removed tentatively is
     correct and the breakage in in-flight topic caught usage
     strings that were malformed.  If not, we need to tweak it to
     make sure it does not produce false positives.

 (1) Help Microsoft folks fix the in-flight topic with faulty usage
     strings.

 (2) Rethink if parse_options_check() can be made optional at
     runtime, which would (a) allow our test to enable it, and allow
     us to test all code paths that use parse_options() centrally,
     and (b) allow us to bypass the check while the end-user runs
     "git", to avoid overhead of checking the same option[] array,
     which does not change between invocations of "git", over and
     over again all over the world.

     We may add the check back to parse_options_check() after doing
     the above.  There are already tons of "check sanity of what is
     inside option[]" in there, and it would be beneficial if we can
     separate out from parse_options_start() the sanity checking
     code, regardless of this topic.

 (3) While (2) is ongoing, we can let people also explore static
     analysis possibilities.
