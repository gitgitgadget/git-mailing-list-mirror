Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0ED3F203F3
	for <e@80x24.org>; Mon, 24 Jul 2017 21:26:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932309AbdGXV0Q (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Jul 2017 17:26:16 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63194 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1756380AbdGXV0A (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jul 2017 17:26:00 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id EE8C69B543;
        Mon, 24 Jul 2017 17:25:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=SKkqY2hs/cT6kT1Qv3U37Irsx0Y=; b=BUx74+
        rXuC3YzdrRIPuIH2Gb3jURYoqbGtn3ACI4HM/B+jBL8VKlCowKPa2Gxjs7SNGM8Q
        md2FyOh/gbd9lp/jeke2lUNoeIhBUd6bChiQDVuZKbIyKY266jH2AwGCnTTqe8SB
        RWbrk6Hp8wOOHXiK4QiOkqAzULQ6FRm9Qqb28=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=h6h88SpvFS0r19/A6YqJC+AHLAccTbQg
        Yao/EisSlssKhJTcRAEsnhCHx9E6Vrjwt1PNAc6d+WwajhJ4tFjTz2a82krrttDs
        h2yq47XzPxf4gS1Pt1m2qjiBk2PmeUBMIAVOMqBuCUYIW6ZmJPfw6RGSknvCqB+l
        24xzXfY4q/0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E65E49B542;
        Mon, 24 Jul 2017 17:25:58 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 58EB99B541;
        Mon, 24 Jul 2017 17:25:58 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Change in output as a result of patch
References: <20170724154119.2926-1-kaarticsivaraam91196@gmail.com>
        <1500923812.20078.8.camel@gmail.com>
Date:   Mon, 24 Jul 2017 14:25:57 -0700
In-Reply-To: <1500923812.20078.8.camel@gmail.com> (Kaartic Sivaraam's message
        of "Tue, 25 Jul 2017 00:46:52 +0530")
Message-ID: <xmqqd18pcysa.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: AF329640-70B6-11E7-97FD-EFB41968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kaartic Sivaraam <kaarticsivaraam91196@gmail.com> writes:

> The patch in the previous mail results in a change in output as
> specified below.
>
>     $ git branch
>     * master
>       foo
>       bar
>
> Before patch,
>
>     $ git branch -m hypothet master
>     fatal: A branch named 'master' already exists.
>
>     $ git branch -m hypothet real
>     error: refname refs/heads/hypothet not found
>     fatal: Branch rename failed
>
> After patch,
>
>     $ git branch -m hypothet master
>     fatal: Branch 'hypothet' does not exist.
>
>     $ git branch -m hypothet real
>     fatal: Branch 'hypothet' does not exist.

Imagine this scenario instead, which I think is more realistic
example of making a typo.  The set of existing branches are like
this:

     $ git branch
       devel
     * test

And then you get these with your patch:

     $ git branch -m tets devel
     fatal: Branch 'tets' does not exist.

     $ git branch -m test devel
     fatal: A branch named 'devel' already exists.

My reaction to the above exchange would be a moderately strong
annoyance.  If I were told that I am using 'devel' for something
else already, my "corrected" attempt to turn the 'test' branch to a
real development branch after getting the first error would have
been:

     $ git branch -m test devel2

and I didn't have to get the second error.

I think your patch points in the right direction---if an operation
can fail due to two reasons, reordering the two checks and still
fail with a report for just the first one you happened to check
first does not give us a real improvement.  If it is easy to check
the other one after you noticed one of the condition is violated,
then you could give a more useful diagnosis, namely, "There is
branch 'tets' to rename, and there already is 'devel' branch".

I suspect that with a moderately-sized refactoring around
validate_new_branchname() function, this should be doable.  Instead
of passing two "int" parameters force and attr_only, make them into
a single "unsigned flag" and allow the caller to pass another option
to tell the function "do not die, do not issue a message, but tell
the caller what is wrong with a return value".  And by using that
updated API, rename_branch() could tell four cases apart and fail
the three bad cases in a more sensible way.

In any case, the illustrations of interaction before and after the
change is a very good thing to have when discussing a patch, and you
are encouraged to put them in your proposed log message.



