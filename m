Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D92AC433F5
	for <git@archiver.kernel.org>; Fri, 28 Jan 2022 19:44:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350979AbiA1Tov (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Jan 2022 14:44:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350996AbiA1Tor (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Jan 2022 14:44:47 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7531C061714
        for <git@vger.kernel.org>; Fri, 28 Jan 2022 11:44:47 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id q1-20020a17090a064100b001b4d85cbaf7so6740190pje.9
        for <git@vger.kernel.org>; Fri, 28 Jan 2022 11:44:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=i7IW21V0u87QjoOw9nsKb7rGChhgHQbK7CbRRMw5/4g=;
        b=B9xalZ4LmYu7tJHpR3SzXMed8FLaB8Fphwk/2Nd/rsfzOUIDmHCd+jgiAFqfPWzo39
         biJHtMsE6OgrMGd1Y1CUdBGpMafNqvVp1qVaWvOqj5t+K1YlCC3rgJelCW1yULrGKN4B
         j3EXQljkEMMyCzp1FRiekNt8fkAQvTzdEzDXNp92e/WbqUhP0qR0y7GpCj3EtACqTYwp
         gJSoSVfJPITHruz4ZFbzZ0shS//HrzgE5cSktUp4QJXGnJW4OGbardn1GKAkV4fhzq3J
         ataq8ENzX/C2oNSv4b+h7mTpBg6VI4kzNXPdSgsSlmiyZ/41Ea1L3hu+4S5Xpkd2nUA2
         sW2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=i7IW21V0u87QjoOw9nsKb7rGChhgHQbK7CbRRMw5/4g=;
        b=23RlKP1XmMdQEb0kAwAsVvVDlm73S1ROgZxLfSt2Nen+fdUc9ZIVS6iy77dVAhpZlP
         xDo6BY/BAqr4rQMuRQNI0qsFP433iYsXIO/I4ObyI8L33nhZeiZTS/jkr25eVbFqOU6Q
         q/yT8f3y9AKK2F/dpb6QWdqgV9jvyK3Q19Q0Kc4bkvfqjTbQ7vEzOwLAadj2VeUWzHFQ
         9xViFlakwqF7ASRqhisTkaBu7vJLp++FTg4jA65EKqlbfdBYnIOWnLb3Rq3wl6UQjGGe
         rLgJ3fyCW4+XkHSN91wR66ouadzDlRkp//qMMAAfi/dMke6NUV9X5qa4I+nhdNppN2Gj
         t9xA==
X-Gm-Message-State: AOAM533j+6mbdhAHIDJ0uAxmiqhF/cjqu7pk16Xpm2RnB35QN91z72vX
        fdHyX14mHrjSQrFx0Ar8k+r2qbKllRE3IQ==
X-Google-Smtp-Source: ABdhPJweE1eI7QxYnoJrh01BlMAQ0JeedbmqRCjZzPbxnvxObtYDITz7mtZKpyU0aZ2f/uXmknLQZ74ToijeZA==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a62:30c5:: with SMTP id
 w188mr9832019pfw.45.1643399087288; Fri, 28 Jan 2022 11:44:47 -0800 (PST)
Date:   Fri, 28 Jan 2022 11:44:45 -0800
In-Reply-To: <xmqqfsp8zuyg.fsf@gitster.g>
Message-Id: <kl6lh79nmyqa.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <20211220233459.45739-1-chooglen@google.com> <20220124204442.39353-1-chooglen@google.com>
 <20220124204442.39353-7-chooglen@google.com> <xmqqfsp8zuyg.fsf@gitster.g>
Subject: Re: [PATCH v7 6/6] branch.c: use 'goto cleanup' in setup_tracking()
 to fix memory leaks
From:   Glen Choo <chooglen@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>,
        Josh Steadmon <steadmon@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Glen Choo <chooglen@google.com> writes:
>
>> Signed-off-by: Glen Choo <chooglen@google.com>
>> ---
>>  branch.c | 5 +++--
>>  1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/branch.c b/branch.c
>> index be33fe09fa..1e9a585633 100644
>> --- a/branch.c
>> +++ b/branch.c
>> @@ -239,7 +239,7 @@ static void setup_tracking(const char *new_ref, const char *orig_ref,
>>  	if (track != BRANCH_TRACK_INHERIT)
>>  		for_each_remote(find_tracked_branch, &tracking);
>>  	else if (inherit_tracking(&tracking, orig_ref))
>> -		return;
>> +		goto cleanup;
>>  
>>  	if (!tracking.matches)
>>  		switch (track) {
>> @@ -249,7 +249,7 @@ static void setup_tracking(const char *new_ref, const char *orig_ref,
>>  		case BRANCH_TRACK_INHERIT:
>>  			break;
>>  		default:
>> -			return;
>> +			goto cleanup;
>>  		}
>>  
>>  	if (tracking.matches > 1)
>> @@ -262,6 +262,7 @@ static void setup_tracking(const char *new_ref, const char *orig_ref,
>>  				tracking.remote, tracking.srcs) < 0)
>>  		exit(-1);
>>  
>> +cleanup:
>>  	string_list_clear(tracking.srcs, 0);
>
> Makes sense.  There is no other exit paths out of the function after
> the tracking_srcs variable gets initialized, so this should be
> covering everything.
>
> Two tangential findings:
>
>  * I see exit(-1) in the precontext of the final hunk.  We probably
>    would want to fix it, as negative argument to exit(3) is
>    misleading (the standard makes it clear that only the least
>    significant 8 bits matter, so it is not that bad).

Thanks for the reminder. We had this discussion previously and the
conclusion was that I would send this cleanup as a separate series [1].
Unlike this relatively obvious cleanup, I think exit codes might spark a
more involved discussion.

>
>  * At the end, what is cleared is tracking.srcs, but because it is a
>    pointer to the real resource we allocated on our stack, it would
>    be cleaner to pass &tracking_srcs instead.

Ah yes, that is true. I'll do that. If you (or others) prefer, I can
move this patch to its own series, or possibly as part of a grab bag
with the exit code fix.

>
> Both are not what this patch introduces, and are outside the scope
> of this series.
>
> Thanks.

[1] https://lore.kernel.org/git/211210.86ee6ldwlc.gmgdl@evledraar.gmail.com
