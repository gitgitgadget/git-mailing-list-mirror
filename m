Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E17B2E9272C
	for <git@archiver.kernel.org>; Thu,  5 Oct 2023 14:43:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237302AbjJEOnJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 Oct 2023 10:43:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234105AbjJEOha (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Oct 2023 10:37:30 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 128724E352
        for <git@vger.kernel.org>; Thu,  5 Oct 2023 07:03:15 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 224061A8C52;
        Thu,  5 Oct 2023 06:25:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=/tOKOrfYttQjsR7SD7huJZ1HBjeah1VczsvE3x
        qxfmE=; b=Z7GQY5RlG6crj54X+YBvIZ/1GADwp9kezraBHaQh2Atg4Ll7tIAemH
        79F9vJgKnEwodiOG0nSM+Qvj4Ja3Z962oPSyzM/2lzYENoIR4bApEWLlipLi7HfO
        eSHZy6GZk5Wo5wKnao0bZqUQbEiKvzGL8ZxDife5cCk1Boa3WG4Ho=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 193671A8C51;
        Thu,  5 Oct 2023 06:25:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7FC701A8C50;
        Thu,  5 Oct 2023 06:25:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Sergey Organov <sorganov@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Oct 2023, #01; Mon, 2)
In-Reply-To: <871qeay6tz.fsf@osv.gnss.ru> (Sergey Organov's message of "Wed,
        04 Oct 2023 14:18:00 +0300")
References: <xmqqedic35u4.fsf@gitster.g> <871qecgpg1.fsf@osv.gnss.ru>
        <xmqq34yr3btn.fsf@gitster.g> <874jj7lh7x.fsf@osv.gnss.ru>
        <xmqqo7hessro.fsf@gitster.g> <871qeay6tz.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13)
Date:   Thu, 05 Oct 2023 03:25:33 -0700
Message-ID: <xmqqjzs1mkma.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 84C6954E-6369-11EE-8839-78DCEB2EC81B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sergey Organov <sorganov@gmail.com> writes:

> Just for better understanding: does it mean that *any* addition of
> one-letter option is prohibited from any existing Git command? Cause it
> definitely sounds this way.

No, we just prefer to think twice before giving short-and-sweet
single letter option to a feature that is not proven useful, and
during the discussion it has become rather clear that the proposed
combination of options goes against helping normal Git users by
forcing them to read an aggregated and redundant patch for a merge
when they already see patches for individual commits on the side
branch that was merged.

>> If I have to pick a candidate for "get me diff" that is the most
>> useful among those currently are available, it is "give patches to
>> all single-parent commit, and show tricky conflict resolution part
>> only for merge commits".
>
> I'm afraid you need to pick a candidate that will be natural for '-d',
> not just most useful output for your workflows, whatever it happens to
> be.

Literal match to word "diff" does not necessarily mean it is useful,
and short-and-sweet single-letter option name is primarily about
letting users reach useful features with minimum typing [*1*], so you
cannot avoid "most useful" being a large part of the equation.

I am wondering if we can have a generalized "personal command option
alias" mechanism implemented.  Then you can give '-[a-z]'[*2*] to
whatever combination you like without affecting others by only
futzing with your $HOME/.gitconfig file.


[Footnote]

 *1* ...or if we are mimicking options of an existing external
     commmand, we need to match them, but in this case it does not
     apply.

 *2* If we were to do this for real, it may make sense to carve out
     option namespace so that end-user aliases cannot overlap with
     official set of options.  For example, if you can never get a
     string that matches "^-![a-z]$" recognised as an official
     command line option by our parsers, then '-!' followed by a
     single letter would be a good candidate for our "personal
     command option alias" to work with, and '-!d' might be
     something you want to use your personal option alias, without
     having to worry about a later version of Git using the option
     officially for something else.

     Another thing that need to be considered when designing such a
     "command option alias" feature is how to express the set of
     commands an alias applies to, as some underlying commands may
     share the same set of options.  For example, having to say

	optionAlias.bisect.1 = --first-parent
	optionAlias.blame.1 = --first-parent
	optionAlias.log.1 = --first-parent

     is a bit too cumbersome to allow me to say "git bisect -!1",
     "git blame -!1", and "git log -!1".  But I am not offhand sure
     if a much simpler

	optionAlias.1 = --first-parent

     is sufficient.  "git commit -!1" would expand into "git commit
     --first-parent" and would give you an error with the usage
     message, which may not be too bad.  I dunno.

