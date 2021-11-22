Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE5E0C433EF
	for <git@archiver.kernel.org>; Mon, 22 Nov 2021 02:10:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231837AbhKVCNU (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 21 Nov 2021 21:13:20 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58892 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229906AbhKVCNT (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 Nov 2021 21:13:19 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3462CEDA4B;
        Sun, 21 Nov 2021 21:10:13 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=BzWpcg0PNI8bm/127j4vbLRyzaezFNkOI5yr09
        FwZJk=; b=bMGPxiscI3KKCM06L0DkA/1gldMg++gVyM12qPldIJrjeNsjSu6Vv0
        q5dSL3AyBqc0uqzOCXPpPPW/LvXncDwK9KEbQ6aKPo0p/wShzj/Wx4Y1pBPMy/kt
        Rk2NNIcLW4Wlx9VNyjp8w4PvjV6+cWLqKd+/pIVHZKAAMqfPsNE8I=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id EDF18EDA49;
        Sun, 21 Nov 2021 21:10:12 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C6FD4EDA47;
        Sun, 21 Nov 2021 21:10:10 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Enzo Matsumiya <ematsumiya@suse.de>, git@vger.kernel.org
Subject: Re: [PATCH v2] pager: fix crash when pager program doesn't exist
References: <20211120194048.12125-1-ematsumiya@suse.de>
        <YZqSBlvzz2KgOMnJ@coredump.intra.peff.net>
Date:   Sun, 21 Nov 2021 18:10:08 -0800
In-Reply-To: <YZqSBlvzz2KgOMnJ@coredump.intra.peff.net> (Jeff King's message
        of "Sun, 21 Nov 2021 13:37:58 -0500")
Message-ID: <xmqqfsrplz3z.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 527372FA-4B39-11EC-901B-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> We'd usually leave of "Reviewed-by" until the reviewer has had a chance
> to see _this_ version of the patch. I.e., usually it would not be added
> by the submitter, but by the maintainer (unless you are resending
> verbatim a patch that already got review).
>
>> diff --git a/run-command.c b/run-command.c
>> index f329391154ae..a7bf81025afb 100644
>> --- a/run-command.c
>> +++ b/run-command.c
>> @@ -19,6 +19,7 @@ void child_process_clear(struct child_process *child)
>>  {
>>  	strvec_clear(&child->args);
>>  	strvec_clear(&child->env_array);
>> +	child_process_init(child);
>>  }
>
> And naturally I agree that the patch itself looks good. :)

Well, not to me X-<.  This is way too aggressive a change to be made
lightly without auditing the current users of run_command API.

It is rather common for us to reuse "struct child_process" in a code
path, e.g. builtin/worktree.c::add_worktree() prepares a single
instance of such a struct, sets cp.git_cmd to true, and runs either
"update-ref" or "symbolic-ref" to update "HEAD".  After successful
invocation of such a git subcommand, it then runs "git reset --hard",
with this piece of code:

	cp.git_cmd = 1;

	if (!is_branch)
		strvec_pushl(&cp.args, "update-ref", "HEAD",
			     oid_to_hex(&commit->object.oid), NULL);
	else {
		strvec_pushl(&cp.args, "symbolic-ref", "HEAD",
			     symref.buf, NULL);
		if (opts->quiet)
			strvec_push(&cp.args, "--quiet");
	}

	cp.env = child_env.v;
	ret = run_command(&cp);
	if (ret)
		goto done;

	if (opts->checkout) {
		cp.argv = NULL;
		strvec_clear(&cp.args);
		strvec_pushl(&cp.args, "reset", "--hard", "--no-recurse-submodules", NULL);
		if (opts->quiet)
			strvec_push(&cp.args, "--quiet");
		cp.env = child_env.v;
		ret = run_command(&cp);
		if (ret)
			goto done;
	}

Now, we could argue that this existing caller is too lazy to assume
that cp.git_cmd bit will be retained after run_command()
successfully finishes and can reuse the structure without setting
the bit again, and it should be more defensive.  And "successful
run_command() clears the child process so that you'll get a clean
slate" may even be a better API in the longer term.

But then a change like this one that changes the world order to make
it a better place is also responsible to ensure that the callers are
already following the new world order.

When merged to 'seen', this literally destroys tons of tests (the
first and easiest one to observe may be t0002).

Thanks.



