Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AD70C4338F
	for <git@archiver.kernel.org>; Fri,  6 Aug 2021 17:55:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F6DB6115C
	for <git@archiver.kernel.org>; Fri,  6 Aug 2021 17:55:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242094AbhHFRzp (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Aug 2021 13:55:45 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:56029 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231718AbhHFRzo (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Aug 2021 13:55:44 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 7D873142A0A;
        Fri,  6 Aug 2021 13:55:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=uMJGFSAo/2zaeGba0EeONfz+kF2eRE31f8dJyg
        WJcP8=; b=M3I1e7dWRVtvq0tViJZ0rI8XlsGkSk2eRCYhjhzA3l0WWmR+zohy9b
        CmXXif/IMAlyEHaPhNJA5K4lGRTnuSMe/7Mw2CbLOdN84yoHCM5JKQnr50+t+82t
        rJN8UCwJW9NVNfkc/u7WYHYR6g96Kz+BXIW2MVtnwIv3L4iT6cCew=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 60316142A09;
        Fri,  6 Aug 2021 13:55:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.71.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 8F986142A08;
        Fri,  6 Aug 2021 13:55:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Sergey Organov <sorganov@gmail.com>, Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        Elijah Newren <newren@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJu?= =?utf-8?B?ZmrDtnLDsA==?= Bjarmason 
        <avarab@gmail.com>, Alex Henrie <alexhenrie24@gmail.com>,
        huang guanlong <gl041188@gmail.com>, git@vger.kernel.org,
        Hudson Ayers <hudsonayers@google.com>,
        Taylor Yu <tlyu@mit.edu>, Joshua Nelson <jyn514@gmail.com>
Subject: Re: [PATCH] Revert 'diff-merges: let "-m" imply "-p"'
References: <CAMMLpeR-W35Qq6a343ifrxJ=mwBc_VcXZtVrBYDpJTySNBroFw@mail.gmail.com>
        <20210520214703.27323-1-sorganov@gmail.com>
        <20210520214703.27323-11-sorganov@gmail.com>
        <YQtYEftByY8cNMml@google.com> <YQyUM2uZdFBX8G0r@google.com>
        <xmqqh7g2ij5q.fsf@gitster.g>
Date:   Fri, 06 Aug 2021 10:55:23 -0700
In-Reply-To: <xmqqh7g2ij5q.fsf@gitster.g> (Junio C. Hamano's message of "Fri,
        06 Aug 2021 10:21:05 -0700")
Message-ID: <xmqqczqqihkk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7A5E3B14-F6DF-11EB-9036-D5C30F5B5667-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>> Similarly, a script author could include
>>
>> 	git log -m --first-parent --format=%H -- README
>>
>> to filter the first-parent history for commits that modified README.
>> The -m is a no-op but it reflects the script author's intent.
>
> So the expectation is with "-m" we'd give single parent commits on
> the fp chain, and merges from side branches that change README, in
> addition to merges from side branches that was forked way before the
> README was updated on the trunk (hence had ancient README but the
> merge kept the version from the trunk)?
>
>> For
>> example, until 1e20a407fe2 (stash list: stop passing "-m" to "git
>> log", 2021-05-21), "git stash list" did this.
>
> This is not a example that supports your conclusion, though.  The
> reason why 288c67ca (stash: default listing to working-tree diff,
> 2014-08-06) added "-m" on the command line to make it:
>
>   git log --format="%gd: %gs" -g --first-parent -m "$@" $ref_stash --
>
> is to prepare for the users who may pass "-p" as part of the "$@";
> they wil get no patches out of these merge commits that represent
> stash entries otherwise, and they'd have to pass "-m -p" instead,
> without the change.
>
>> As a result, we can't safely change "-m" to imply "-p" without fear of
>> breaking such scripts.  Restore the previous behavior.
>
> So the above is *not* an example of a script that would have been
> broken with this change.

Sorry, I have to take 70% of the above back.  While it is *not* an
example that shows an author's intent that changes from not just
trunk but all side branches to README are to be shown, the original
left after 288c67ca (stash: default listing to working-tree diff,
2014-08-06) would have been broken by the change you are proposing
to revert.  It used to be just "if you give -p we'll show a patch"
but if we make "-m" to mean "-m -p", it does get broken.

Which is BAD.

I am inclined to take the revert, but I do not think reverting it
alone will break more things than it fixes.

For example, 1e20a407 (stash list: stop passing "-m" to "git log",
2021-05-21) that dropped "-m" must be reverted as well, no?

