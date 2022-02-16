Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20898C433EF
	for <git@archiver.kernel.org>; Wed, 16 Feb 2022 19:42:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238197AbiBPTmM (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Feb 2022 14:42:12 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236511AbiBPTmL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Feb 2022 14:42:11 -0500
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5653CA708
        for <git@vger.kernel.org>; Wed, 16 Feb 2022 11:41:56 -0800 (PST)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 01DD7164EEE;
        Wed, 16 Feb 2022 14:41:56 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=GmUZWZSz/R9ho5Av3Ni0LOVv3bytv0Q8iGxeTj
        PTD0Q=; b=xsoC4+i6xNjhHSpvsDfYYrwvBUjGDciutxsz+zntCJ6Uu5IqJq4IW2
        nuPsinaVVRS4Avo8z7hkygpcnKcED5IcIlcKZudcioUdjOtZn5K6ht7ceIYigdz5
        wcIVE0ZFchI/05XaWKz4+Loy/ayhk+Jdxx3aciV1VXr6hCXZMhmdo=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id EF48A164EEC;
        Wed, 16 Feb 2022 14:41:55 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 5F76A164EEB;
        Wed, 16 Feb 2022 14:41:53 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Erlend Egeberg Aasland via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Erlend Egeberg Aasland <erlend.aasland@innova.no>
Subject: Re: [PATCH] branch: delete now accepts '-' as branch name
References: <pull.1217.git.git.1645020495014.gitgitgadget@gmail.com>
        <xmqqbkz6vjkj.fsf@gitster.g>
        <00720bfb-c7b7-aaf2-e846-19b08d7b9cf4@sunshineco.com>
Date:   Wed, 16 Feb 2022 11:41:52 -0800
In-Reply-To: <00720bfb-c7b7-aaf2-e846-19b08d7b9cf4@sunshineco.com> (Eric
        Sunshine's message of "Wed, 16 Feb 2022 14:03:38 -0500")
Message-ID: <xmqqv8xed2f3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7DEE9746-8F60-11EC-A500-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> On 2/16/22 11:54 AM, Junio C Hamano wrote:
>> From: "Erlend E. Aasland" <erlend.aasland@innova.no>
>>> This makes it easy to get rid of short-lived branches:
>>>
>>> $ git switch -c experiment
>>> $ git switch -
>>> $ git branch -D -
>> Or you can use @{-1} directly.  Or short-lived experiment can
>> directly be done on HEAD without any branch ;-)
>> Thanks for trying to make Git better.
>
> Patches implementing this behavior for `git branch -D` have been
> submitted previously but were rejected (if I recall correctly) since 
> "delete" is a destructive operation, unlike other cases in which `-`
> is accepted. A relatively recent submission and ensuing discussion is
> at [1].
>
> [1]: https://lore.kernel.org/git/20200501222227.GE41612@syl.local/T/

I think the thread around <vpqh944eof7.fsf@anie.imag.fr> is what you
have in mind as the origin of

 * "-" usually stands for "read from standard input" and using it to
   mean "the previous branch" is a source of confusion, and cannot
   be defended with the excuse of "'cd -' is used to go back to
   where we were" when the command is not going back to that branch
   (i.e. not "checkout -" or "switch -").

 * it is doubly dubious to make it easy to type "-" to cause
   something destructive.

 * on the other hand, since "checkout -" already makes "-" as a
   synonym to "@{-1}", not supporting it elsewhere may appear
   inconsistent.

I personally am sympathetic to the first point, but not that
sympathetic to the second one.  We made it worse since then by
accepting "merge -", which is not about going back, though.

