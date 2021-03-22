Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E040C433C1
	for <git@archiver.kernel.org>; Mon, 22 Mar 2021 09:06:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE6D461973
	for <git@archiver.kernel.org>; Mon, 22 Mar 2021 09:06:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbhCVJF1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Mar 2021 05:05:27 -0400
Received: from smtp5.ctinetworks.com ([205.166.61.198]:54290 "EHLO
        smtp5.ctinetworks.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbhCVJE6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Mar 2021 05:04:58 -0400
Received: from localhost (unknown [117.193.1.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: enometh@meer.net)
        by smtp5.ctinetworks.com (Postfix) with ESMTPSA id 058D11634C7;
        Mon, 22 Mar 2021 05:04:53 -0400 (EDT)
Date:   Mon, 22 Mar 2021 14:34:37 +0530 (IST)
Message-Id: <20210322.143437.212295420302618690.enometh@meer.net>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] init: don't reset core.filemode on git-new-workdirs.
From:   Madhu <enometh@meer.net>
In-Reply-To: <xmqq7dlz94by.fsf@gitster.g>
References: <xmqq1rc89nk7.fsf@gitster.g>
        <20210322.081043.1437207928602570397.enometh@meer.net>
        <xmqq7dlz94by.fsf@gitster.g>
X-Mailer: Mew version 6.8 on Emacs 28.0
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-ctinetworks-Information: Please contact the ISP for more information
X-ctinetworks-MailScanner-ID: 058D11634C7.A389B
X-ctinetworks-VirusCheck: Found to be clean
X-ctinetworks-SpamCheck: 
X-ctinetworks-Watermark: 1617267897.45271@aWgCdt+cGqMNjvCNxmHL/A
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

*  Junio C Hamano <gitster@pobox.com> <xmqq7dlz94by.fsf@gitster.g>
Wrote on Sun, 21 Mar 2021 21:53:37 -0700
> There are two points we should consider.
>
>  * Historically, we've used .git/config as the sample file to check,
>    but that was not because we wanted to make sure we can chmod the
>    config file, but because we knew the file has to be there.  If
>    .git/config is sometimes a symbolic link, and if chmod test
>    requires a regular file, we do not have to use .git/config as the
>    sample file.  We could instead switch to use a different,
>    temporary, file.  After all, the symlink check I pointed out in
>    the message you are responding to uses a brand new temporary
>    filename for that, and there is no reason why we shouldn't do the
>    same with a regular file for the filemode test.
>
>  * If running "git init" in an already functioning repository can be
>    a useful way to "re-initialize" and/or "correct" various aspect
>    of the repository (e.g. perhaps core.filemode is incorrectly set
>    originally and running "git init" again corrects it), we would
>    want to allow that in a normal repository as well as in a
>    repository that is created by new-workdir the same way.  Or if it
>    is not useful and we want "re-initialize" not to touch the
>    filemode, we would want to skip the check in a normal repository
>    as well as in a new-workdir repository the same way.  That is why
>    "if symlink, then skip" is wrong---it targets the new-workdir
>    case specifically.

I'd say it doesn't (target the new-workdir case specifically).  The
lstat test on `config' is incorrect if `config' (or a new file) is not
a regular file, so I think it should be fixed anyway.  The new-workdir
case happens to be handled correctly once this is fixed.

> I personally do not have a strong opinion either way, but to me, it
> seems that "does the filesystem support filemode?" and "does the
> filesystem support symbolic link?" are at about the same level and
> should be treated similarly unless there is a good reason not to.
> And the symlink check is never done in "reinit" case, so perhaps
> when "git init" is run again in an already functioning repository,
> we should not muck with the filemode, either.

I'd think so (on the last point).  While it is understandable to
expect consistent re-initing behaviour (which is why the spurious
git-init was there) the expectations may not hold if the git directory
and work tree are on different filesystems - there is more scope for
making wrong inferences.

Typically checkout worktrees with new-workdir in /dev/shm for
advantages in the low overhead.

I do have repositories where .git/config is a symlink to a config.A
and I have other config.B files - all for the same repo but with
different upstreams. (I know better ways to do it but why should I be
prevented from doing this)

> A natural conclusion of the line of thought is that we can move the
> "check filemode trustability" block (from the comment to concluding
> git_config_set()) inside the "if (!reinit)" that happens a bit later
> and we'd be fine---as an existing normal repository, as well as what
> new-workdir creates, won't have to do the "let's chmod +x/-x the
> config file and see what happens" code at all (perhaps the attached
> patch, which hasn't even been compile tested).
>
> On the other hand, if it is worth "fixing" the filemode setting
> while re-initializing, we probably should switch to use a temporary
> file instead of 'config'.  And we may want to reconsider the placement
> of the "is symlink supported?" check---which may also have to be
> redone to "fix" its existing value.

I don't think the posted patch (snipped) would work as reinit is
always 1 and we are always a candidate for reiniting - I may be
missing something.

Using a new file for the filemode test would be a natural
improvement. But I dont see the added complexity as a win.  I can
imagine other scenarios that need to be fixed: calling git-init on a
worktree prepared by git-new-worktree (not git-new-workdir) on a FAT
fs with .git on ext2.  Calling git-init on a worktree prepared by
calling git-new-worktree with a parent which is checked out by
git-new-workdir. (The parent has a symlinked config). The
possibilities for fun endless :)


