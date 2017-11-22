Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 314082036D
	for <e@80x24.org>; Wed, 22 Nov 2017 05:35:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752124AbdKVFff (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Nov 2017 00:35:35 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57297 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751784AbdKVFfb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Nov 2017 00:35:31 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B08BCB2869;
        Wed, 22 Nov 2017 00:35:30 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Y8Hns2OxwqfV1djsuZR717I1EIs=; b=Xt3EU5
        KhNOmd4K7NerRTRdo/xii6fa2nVs6M+x7FIlJ0tzEbciQMGAz/OaOBlZSyY2MJtl
        6igM4XsmLL1Yi2RVGmjyJS/UjtvAWGYO8g5ewdSTUC7KxkglzIm9jfO8DZ9Nd9bc
        +FnelQ1VNxn24TSslMWUuC6RcIXeIz8G8QoZk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=hceMd438bAvimrk+1NxB8h2h4aw1J/6w
        Za9VCg7OlMvUa6Vf0rkQef/klUumic5LdaXIJTOBmJpuRHN5aWFOmYWqj3lN+MXj
        vxyKxdv1za0fTYAXX0gEMKCvHEuI/M+//v6fmyVcWGBmXSbHdZHiO4aNE8Tshzel
        srLaXZc7Ev8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A8A67B2868;
        Wed, 22 Nov 2017 00:35:30 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1D6FEB2867;
        Wed, 22 Nov 2017 00:35:30 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Adam Dinwoodie <adam@dinwoodie.org>
Cc:     git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>
Subject: Re: [RFC PATCH v2 0/2] bisect: add a single command for editing logs
References: <20171108135931.166880-1-adam@dinwoodie.org>
        <cover.1511200589.git.adam@dinwoodie.org>
Date:   Wed, 22 Nov 2017 14:35:28 +0900
In-Reply-To: <cover.1511200589.git.adam@dinwoodie.org> (Adam Dinwoodie's
        message of "Mon, 20 Nov 2017 18:24:37 +0000")
Message-ID: <xmqqshd6ub8f.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F3B3013A-CF46-11E7-9B33-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Adam Dinwoodie <adam@dinwoodie.org> writes:

> - It's possible to start a bisect session with a command like `git
>   bisect @ @~10`.  This will lead to the bisect log including the `@`
>   and `@~10` literally, and the interpretation of those values changes
>   depending on the current HEAD.  As a result, if you do a `git bisect
>   edit` after starting a bisect like that, but don't actually edit the
>   file, you'll nonetheless be in a different state.

This is a tangent, but for writing to the general public, please do
spell out HEAD, not the line noise synonym "@" that confuses readers.

>   I can see a few ways of coping with that:
>
>   1. Change the existing `git bisect start` behaviour to run arguments
>      through `git rev-parse` before recording them.  It appears `git
>      bisect good` et al. already do that, but it is a change in
>      behaviour that I guess could impact badly on other people using
>      `git bisect log`-based workflows.

The issue is not just HEAD but also for anything fruid, i.e. the
name of a branch, a search result ":/pattern", etc., and if we want
to allow restarting a previously failed bisect session from a
midpoint, we should be recording things in absolute terms as early
as possible.  I'd think it was an oversight the "log" thing did not
do so.

>   2. Do a full `git bisect reset` before replaying the log, so the
>      revisions will be parsed in the same way as they were originally.
>      I'd be slightly sad about that, as it seems an unnecessary
>      inefficiency, but it may well be the simplest approach.

It is not just inefficient, but would require there is no a local
change; I thought that the current system allows you to have a local
modification to a path that is not involved in the bisect session
and losing that property would be sad.

> - There aren't yet any tests or documentation changes; I wanted to get
>   commentary on the initial code changes before I spent time on those
>   parts.

There are some chicken-and-egg around this area.  For some changes,
without a doc update and test addition, it is harder to judge if a
reviewer can agree with the proposed change, as there is only a high
level description "we allow editing" and the lowest level changes to
the actual code, without anything in between that describes the
guiding principle and design decision that lead to the patch.

I'll need to see if the changes in the patch is clear/trivial enough
to see where you are trying to go to see if it is the case for this
patch, though, so read the above paragraph as a general guideline.


