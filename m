Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8D9EC433F5
	for <git@archiver.kernel.org>; Mon, 28 Mar 2022 20:27:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345530AbiC1U3T (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Mar 2022 16:29:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344800AbiC1U3S (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Mar 2022 16:29:18 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E07DA65485
        for <git@vger.kernel.org>; Mon, 28 Mar 2022 13:27:36 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 45DFD192465;
        Mon, 28 Mar 2022 16:27:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=STHwSsASxGC16bkXjUWRF8a6FQ/BiPa4EKOZme
        ysDUQ=; b=jWm8cK4jc/9hF692fz3qimWmnJ/0GftWRp1HzvDYij51JVrBGcHtJD
        8SNCAtSwHR/LHsoz9YQuSoFwGMfIWwTIL6ctuQM8hSiRqHo2SuspR/cUgLcZq5W4
        AtsvHkb5QBF3qRe1irHmPmmSF+mNDTfb8oJzqOKwFyqDLiAdKXV78=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 3E838192464;
        Mon, 28 Mar 2022 16:27:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.227.145.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 9A08D192463;
        Mon, 28 Mar 2022 16:27:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Tao Klerks <tao@klerks.biz>
Cc:     Glen Choo <chooglen@google.com>,
        Tao Klerks via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJu?= =?utf-8?B?ZmrDtnLDsA==?= Bjarmason 
        <avarab@gmail.com>
Subject: Re: [PATCH v3] tracking branches: add advice to ambiguous refspec
 error
References: <pull.1183.v2.git.1647940686394.gitgitgadget@gmail.com>
        <pull.1183.v3.git.1648450268285.gitgitgadget@gmail.com>
        <xmqqwnge2ghe.fsf@gitster.g>
        <kl6l7d8et314.fsf@chooglen-macbookpro.roam.corp.google.com>
        <xmqqilry2dq7.fsf@gitster.g>
        <CAPMMpojYJ9sB7nbAAt1b_yH0Um1O-+TpSRYXTkZ6aDHobhS59A@mail.gmail.com>
Date:   Mon, 28 Mar 2022 13:27:32 -0700
In-Reply-To: <CAPMMpojYJ9sB7nbAAt1b_yH0Um1O-+TpSRYXTkZ6aDHobhS59A@mail.gmail.com>
        (Tao Klerks's message of "Mon, 28 Mar 2022 20:02:10 +0200")
Message-ID: <xmqqo81p256z.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7FC3B544-AED5-11EC-B769-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Tao Klerks <tao@klerks.biz> writes:

>> Having said that, as long as you do that lazily not to penalize
>> those who have sane setting without the need for advice/error to
>> trigger, I do not particularly care how the list of matching remote
>> names are kept.  Having string_list_append() unconditionally like
>> the above patch has, even for folks with just a single match without
>> need for the advice/error message is suboptimal, I would think.
>
> Again, I'm new here, and not a great coder to start with, but I'm
> having a hard time understanding why the single extra/gratuitous
> strbuf_addf() or string_list_append() call that we stand to optimize
> (I haven't understood whether there is a significant difference
> between them) would ever be noticeable in the context of creating
> a branch.

Small things accumulate.

Unless you have to bend over backwards to do so, avoid computing
unconditionally what you only need in an error case.  People do not
make mistake all the time, and they shouldn't be forced to pay for
the possibility that other people may make mistakes and may want to
get help.

When you see that you are wasting cycles "just in case I may see an
error", you may stop, take a deep breath, and think if you can push
the extra work to error code path with equally simple and easy code.
And in this case, I think it is just as equally easy and simple as
the unconditional code in your patch to optimize for the case where
there is *no* duplicate.

It is a good discipline to learn, especially if you are new, as it
is something that stays with you even after you move on to different
projects.

> I of course completely understand optimizing anything that will
> end up looping, but this is a max of 1 iteration's savings; I would

When there is no error, you do not even need to keep the "names that
will become necessary for advice" at all, so you are comparing 0
with 1.  And if you read the no-error case of the suggested rewrite,
you'd realize that it is much easier to reason about.  You do not
have to wonder what the remotes_advice strbuf (or string_list) is
doing in the no-error code path at all.  This is not about
performance, it is about clarity of the code (not doing unnecessary
thing means doing only essential thing, after all).

Between strbuf appending and string_list appending, I do not
personally care.  As long as the code can produce the same output,
it is OK.  Using string_list _may_ have an advantage that string
formatting logic will be concentrated in a single place, as opposed
to strbuf appending, where part of formatting decisions need to be
made in the callback and other part is left in the advise-string.
And because this should all happen only in error code path, the
performance between two APIs would not matter at all (and for that
to truly hold, you need to stick to "do not unconditionally compute 
what you need only in an error case" discipline).





