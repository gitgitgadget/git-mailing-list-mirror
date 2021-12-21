Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B099BC433F5
	for <git@archiver.kernel.org>; Tue, 21 Dec 2021 17:13:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240246AbhLURNe (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Dec 2021 12:13:34 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:54837 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240248AbhLURNd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Dec 2021 12:13:33 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 4687518064B;
        Tue, 21 Dec 2021 12:13:33 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=7Izn4y7tcWymNkQk1ReBzM6/ngMDzo4pNWmnDT
        lOvjY=; b=evBP0yALEjOwwpKhK5hwrV74jG+0ej31LcRpmshmgGNtUkEyw199G9
        kkf0JM5FdhHd1qO+U8+gkx/XMDqO767diU2xOGPfMQzPCDATO2t1lXseLkSiCvqv
        I41RaiJgS0MFIvvoHkH3VVxhg3JyiexndaS7AisVxjF9WXGKZwZeA=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 298D418064A;
        Tue, 21 Dec 2021 12:13:33 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 7A5D2180649;
        Tue, 21 Dec 2021 12:13:29 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Daniel Vicarel <shundra8820@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Why does "merge --continue" expect no arguments?
References: <CALRdAfcyfesNqfLhhe2GW_5V9s2hf++i6mZS1Lw5hqQYTca85w@mail.gmail.com>
Date:   Tue, 21 Dec 2021 09:13:28 -0800
In-Reply-To: <CALRdAfcyfesNqfLhhe2GW_5V9s2hf++i6mZS1Lw5hqQYTca85w@mail.gmail.com>
        (Daniel Vicarel's message of "Tue, 21 Dec 2021 09:50:56 -0500")
Message-ID: <xmqqlf0dq3t3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 51413908-6281-11EC-838E-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Daniel Vicarel <shundra8820@gmail.com> writes:

> There are several git commands that take a "--continue"
> option...`merge`, `rebase`, `cherry-pick`, etc. From looking through
> the source though, only `merge --continue` seems to expect no other
> arguments. Suppose that you have just resolved some merge conflicts,
> and then want to run `git merge --continue --no-edit` to accept the
> default merge commit message. Having to open/close the configured text
> editor still is mildly annoying. I'm interested in submitting a patch
> to "fix" this `merge` behavior, but I wanted to check if this was
> really the intended behavior first, and if so why.

The answer lies somewhere between "it is very much deliberate" and
"'merge --continue' is so unimportant that nobody bothered".

Originally, our "merge" did not open an editor to give you a chance
to explain why you are merging a side branch when recording a
cleanly auto-resolved result.  In fact, it didn't even have an
"--edit" option to optionally allow you to edit.  This changed at
f8246281 (merge: use editor by default in interactive sessions,
2012-01-10); its log message is worth a read to understand the
issues.

Compared to a merge that cleanly auto-resolved, in a conflicted
merge, you have one more thing worth explaining to future readers of
"git log"---how and why the work on the side branch conflicted with
the work on the mainline, and how you chose to resolve it.

So, in that sense, we would very much want to do whatever possible
to encourage you to write a good log message.  Opening an editor is
one step in that direction.

Among the commands with "--continue", "merge --continue" came much
later, and it did not even need to exist.  The other commands with
"--continue", e.g. "rebase", deal with multi-step operations, and it
is worth to have a way to say "I am finished with this step, let's
CONTINUE WITH THE REST".  But in "merge", there is no remaining
thing to do after you are done with the conflict you saw.

In hindsight, we probably should have resisted the urge to add
"merge --continue", just for the sake of misguided "consistency"
perceived on non-existent similarity with other commands that truly
need "--continue".  What is called "merge --continue" should have
been called "merge --finish", if we needed to add something back
then.

The way to finish a conflicted merge has always been to run "git
commit" before "merge --continue" was added, and it still is not
just accepted but is the right way to finish a conflicted merge.

So, in that sense, "merge --continue" is so unimportant that it is
understandable that nobody bothered.

So I guess that makes two discouraging factors against adding
"--no-edit" to "merge --continue".  It encourages a wrong behaviour
of under-explaining the result of your work, and "commit" is a much
shorter way to say "merge --continue" anyway.

In fact, "merge --continue --no-edit" is much longer to type than
"commit --no-edit".

merge --continue
commit --no-edit

Having said all that, among various things that the above discussion
suggests as possible next steps, i.e.

 * deprecate and eventually remove "merge --continue"
 * deprecate and eventually rename "merge --continue" to "merge --finish"
 * add "--no-edit" to "merge --continue"

I think the last one might be the change with least impact and
resistance.  Those who are unaware that "commit --no-edit" suffices
would end up typing a lot more and wasting their keyswitches' life,
but the damage is limited ;-)

Or we could throw in another

 * document more clearly that "merge --continue" is a mere synonym
   for, and hint that there is no reason to favor it over, "git
   commit".

which happens to be my favourite so far after thinking the above
through.

Thanks.
