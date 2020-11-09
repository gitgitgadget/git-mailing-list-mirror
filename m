Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FD98C388F7
	for <git@archiver.kernel.org>; Mon,  9 Nov 2020 18:11:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 52CDA20644
	for <git@archiver.kernel.org>; Mon,  9 Nov 2020 18:11:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="razJiM2m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729785AbgKISLv (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Nov 2020 13:11:51 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52824 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729454AbgKISLv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Nov 2020 13:11:51 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7DF0D90E89;
        Mon,  9 Nov 2020 13:11:47 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=9oFIUrSeM66mptG8RhjhaUJxF8k=; b=razJiM
        2mtcMitf46ldOV0iApafyvC5yYD/uB6kbVHnjFlfpZDzGhpgpQSbjPqw9FOiNTUB
        7WHQI8uFkV9oQk8T2nbSRAjyIKw3xMiwHYEWN/VIA95f+C1jXiCl71Co0UIWp5y+
        jg+24d+DGwpEFVT1IN5aHohDqzIWmrzcJfd/s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=gFXebKLBS3W0iB8EeSwIxA0l0HsUmraL
        lrUD057ZeOz4VmE2uqhxCUFnxFzcdj5+TFIKUxLBDcIbfKMdhbjePib7jw57Er8q
        /YN0qxdhymcVwVjD1dtZNDw5eeNIUyhRtomywMfLZinCUGuNom174TpGy9Z78EHU
        eP2oF9Jv8Tk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 75A3090E88;
        Mon,  9 Nov 2020 13:11:47 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 0593690E87;
        Mon,  9 Nov 2020 13:11:47 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eugen Konkov <kes-kes@yandex.ru>
Cc:     Johannes Sixt <j6t@kdbg.org>, Elijah Newren <newren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git rebase/git rebase --abort cause inconsistent state
References: <1526558917.20201106203213@yandex.ru>
        <CABPp-BGAJiaU5aeC3sGvp3znQw1esrn9c19gyOZQBymYvNFCaw@mail.gmail.com>
        <43de6950-a33c-f3da-2a76-72719fef5af3@kdbg.org>
        <16910030549.20201109134640@yandex.ru>
Date:   Mon, 09 Nov 2020 10:11:46 -0800
In-Reply-To: <16910030549.20201109134640@yandex.ru> (Eugen Konkov's message of
        "Mon, 9 Nov 2020 13:46:40 +0200")
Message-ID: <xmqqft5icsd9.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 07D11EE2-22B7-11EB-8673-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eugen Konkov <kes-kes@yandex.ru> writes:

>> You start at branch dev. Then you use the two argument form
>
>>      git rebase dev local/dev
>
>> and when you later
>
>>      git rebase --abort
>
>> then you are not warped back to dev, but to local/dev:
>
> I suppose `git rebase --abort` should return me back to `dev`, because
> this is the state I was before the command. hmm... suppose it will not
> return to original branch when [branch] parameter is specified for git
> rebase

Yes, "git rebase [--onto C] A B" has always been a short-hand for

	git checkout B
	git rebase [--onto C] A

which means that if the second rebase step aborts, rebase wants to
go back to the state before the rebase started, i.e. immediately
after "checkout B" was done.

I think the root cause of the problem is that addition of the
"--autostash" feature (which came much later than the two-arg form)
was designed poorly.  If it wanted to keep the "two-arg form is a
mere short-hand for checkout followed by rebase" semantics to avoid
confusing existing users (which is probably a good thing and that
seems to be what the code does), then the auto-stash should have
been added _after_ we switch to the branch we rebase, i.e. B.  That
way, the stash would be applicable if the rebase gets aborted and
goes back to the original B, where the stash was taken from.

Of course, that would also mean that the original modification in
the working tree and the index may not allow you to move to branch B
(i.e. starting from your original branch O, and editing files in the
working tree, "git checkout B" may notice that you edited files that
are different between O and B and refuse to check out branch B to
prevent you from losing your local modifications), but that probably
is a good thing, if "two-arg form is a mere short-hand" paradigm is
to be kept.  So, "use autostash and you can always rebase in a clean
state" would no longer hold.

Another thing we could have done when adding "--autostash", was to
redefine the meaning of the two-arg form.  Then it starts to make
sense to take a stash _before_ switching to the branch to be rebased
(i.e.  B), to go back to the original branch before switching to B,
and then to unstash on the working tree of the original branch that
is checked out after aborting.

Note that such an alternative design would have had its own issues.
With such a different semantics of two-arg form, if a rebase cleanly
finishes, instead of staying on the rebased branch B, we MUST go
back to the original branch to unstash what was autostashed.
Usually people expect after a rebase to play with the rebased state
(e.g. test build), so staying on branch B that was just rebased
would be far more usable than going back to unrelated original
branch (and possibly unstashing).

In any case, the ship has long sailed, so ...
