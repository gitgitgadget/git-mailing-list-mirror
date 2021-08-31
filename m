Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0706C432BE
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 06:17:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 78BCE60FD8
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 06:17:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230519AbhHaGS0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 Aug 2021 02:18:26 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:65160 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229891AbhHaGSZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Aug 2021 02:18:25 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8B1FFD8289;
        Tue, 31 Aug 2021 02:17:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=j/khfa94rL1FxrELYJVWHUVk4PlrDFPsswN4AR
        jPZXA=; b=r0s1gOVFKE+JdOEeAxH9bsrCSaAioK22nf+XYLYvDYgkyjjbJpXYxg
        jNdpGhPafRRYG6z9jejA+E+UsYJwmhGJv9wSTyqQIvJZHqHM6Wp6yuu7d+hhYR66
        4glzWmWN3fq9xktSZymeZv4Ky1VFWg+btAHkXkLTPZvQu3go8ztOM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 824ADD8288;
        Tue, 31 Aug 2021 02:17:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.116.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0B06BD8287;
        Tue, 31 Aug 2021 02:17:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     David Turner <David.Turner@twosigma.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "novalis@novalis.org" <novalis@novalis.org>
Subject: Re: [PATCH 2/3] diff --submodule=diff: do not fail on
 ever-initialied deleted submodules
References: <20210726183358.3255233-1-dturner@twosigma.com>
        <20210726183358.3255233-2-dturner@twosigma.com>
        <xmqqv94wfzu0.fsf@gitster.g>
        <91f6fc69470d4291a982cb9c4b3cd6c1@exmbdft7.ad.twosigma.com>
Date:   Mon, 30 Aug 2021 23:17:29 -0700
In-Reply-To: <91f6fc69470d4291a982cb9c4b3cd6c1@exmbdft7.ad.twosigma.com>
        (David Turner's message of "Tue, 27 Jul 2021 17:35:10 +0000")
Message-ID: <xmqqwno2xhmu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1EECB0A6-0A23-11EC-AB2F-D601C7D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

David Turner <David.Turner@twosigma.com> writes:

>> From: Junio C Hamano <gitster@pobox.com>
>> Sent: Monday, July 26, 2021 6:57 PM
>> To: David Turner <David.Turner@twosigma.com>
>> Cc: git@vger.kernel.org
>> Subject: Re: [PATCH 2/3] diff --submodule=diff: do not fail on 
>> ever-initialied deleted submodules
>> 
>> David Turner <dturner@twosigma.com> writes:
>> 
>> > If you have ever initialized a submodule, open_submodule will open it.
>> > If you then delete the submodule's worktree directory (but don't 
>> > remove it from .gitmodules), git diff --submodule=diff would crash 
>> > as it attempted to chdir into the now-deleted working tree directory.
>> 
>> Hmph.  So what does the failure look like?  The child process inside
>> start_command() attempts chdir() and reports CHILD_ERR_CHDIR back, and 
>> we catch it as an error by reading from notify_pipe[0] and report 
>> failure from start_command()?  Or are we talking about a more severe 
>> "crash" of an uncontrolled kind?
>
> It's the first kind.
>
>> Bypassing the execution of diff in the submodule like this patch does 
>> may avoid such a failure, but is that all we need to "fix" this issue?  
>> What does the user expect after removing a submodule that way and runs 
>> "diff" with the "-- submodule=diff" option?  Shouldn't we be giving 
>> "all lines from all files have been removed" patch?
>
> Just a note: this only matters if the submodules git dir is
> absorbed.  If not, then we no longer have anywhere to run the
> diff.  But that case does not trigger this error, because in that
> case, open_submodule fails, so we don't resolve a left commit, so
> we exit early, which is the only thing we could do.
>
> If absorbed, then we could, in theory, go into the submodule's
> absorbed git dir (.git/modules/sm2) and run the diff there.  But
> in practice, that's a bit more complicated, because `git diff`
> expects to be run from inside a working directory, not a git dir.
> So it looks in the config for core.worktree, and does
> chdir("../../../sm2"), which is the very dir that we're trying to
> avoid visiting because it's been deleted.  We could work around
> this by setting GIT_WORK_TREE (and GIT_DIR) to ".".  This
> actually seems to work, but it's a little weird to set
> GIT_WORK_TREE to something that is not a working tree just to
> avoid an unnecessary chdir.  To my mild surprise, it also seems
> to work correctly in the case of deleted nested (absorbed)
> submodules.  What do you think of this idea?
>
> (Side note: The same bit about chdir into the working tree is
> true for diff-tree even though it normally does not need anything
> from the working tree.  I say "normally", because in the case of
> nested submodules, it might need to look inside those submodules,
> which might themselves not be absorbed.  Of course, this case
> cannot obtain if the submodule in the worktree has been deleted.
> We should consider fixing the docs for git diff-tree
> --submodule=diff to specify that it only works if -p is passed.)
>
> (Sorry if the formatting on this email ends up bad -- corporate
> email is... corporate .  I'm going to CC my personal address so
> that I can use a better mailer on future replies). 

That I had to ask questions based on the proposed log message and
you needed to answer to clarify means that the next person who
encounters this commit in "git log" would likely have to ask the
same question, and worse, unlike I had you, there is nobody to whom
they ask for help understanding this commit.

Thanks.
