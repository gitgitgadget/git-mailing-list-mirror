Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF645C77B7A
	for <git@archiver.kernel.org>; Thu,  1 Jun 2023 19:48:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbjFATsx convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Thu, 1 Jun 2023 15:48:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231818AbjFATss (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jun 2023 15:48:48 -0400
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 572C8184
        for <git@vger.kernel.org>; Thu,  1 Jun 2023 12:48:47 -0700 (PDT)
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-626117a8610so11147966d6.1
        for <git@vger.kernel.org>; Thu, 01 Jun 2023 12:48:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685648926; x=1688240926;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Divl12jSy6HmhwL/hxATYNm7WIcgbyIb7MYWvUiQFDw=;
        b=bxO2Wek+mYrMZ48TaaOY1/maHGf/8RQP+sy86rJ5LRpuVp0QYYuS1SMBiYUbCQhyDz
         etda2qBKLcnqsE+/2eZh5rZhkfOy7G3q9p3CpZbByyW9jD7Q8B+Z1g2pvvoCvb97dqnV
         /x3saJSSAKs+7Y1E5IbB7FXCVNsPIvBPvATLWdr625Pu9AimIE9FZBDqu4utVBdp8r9C
         Wpa7Y8YoIEp5sAjj4jgHXMM8mxnwKtEVECfV7DErqS6aELuspHBmagjMbEaN9qCgmnj7
         Vqe3f+6RvDTFcJmrmWesrY2COMPz7no4ul8eNqhxKd1J0WrUrDs6MURjc11v7UgZ/nph
         goeg==
X-Gm-Message-State: AC+VfDwhEbvOFiIyEIclvdH1GlAT7OZICClGNLX1+O/GYM+Sa7KCWc+U
        AEUBeKmM6ZSzquaYgqJklNWYWlMfN6HD1Y2GbYpZ5AdxmpY=
X-Google-Smtp-Source: ACHHUZ7c5ehzcGxxITJq/UgAvrE8Msi8j/YHuX5YOtHXwaD7rGpiQ4mmjx7DajBL39oLa30gWp4K5EB4QNuyVD9KoMk=
X-Received: by 2002:a05:6214:490:b0:626:2047:c845 with SMTP id
 pt16-20020a056214049000b006262047c845mr11800820qvb.55.1685648926357; Thu, 01
 Jun 2023 12:48:46 -0700 (PDT)
MIME-Version: 1.0
References: <CAPMMpohHo2co7n_NjD9XntBs3DVU91Rqx8dmRrSWg=1eof+Rhw@mail.gmail.com>
In-Reply-To: <CAPMMpohHo2co7n_NjD9XntBs3DVU91Rqx8dmRrSWg=1eof+Rhw@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 1 Jun 2023 15:48:35 -0400
Message-ID: <CAPig+cQ6tuh1nGG+t6c2O8VL-=Ggy+hWzJHTFWCb7xRH2HZkXg@mail.gmail.com>
Subject: Re: When someone creates a new worktree by copying an existing one
To:     Tao Klerks <tao@klerks.biz>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 31, 2023 at 3:00 PM Tao Klerks <tao@klerks.biz> wrote:
> I've recently encountered some users who've got themselves into
> trouble by copying a worktree into another folder, to create a second
> worktree, instead of using "git worktree add".
>
> They assumed this would be fine, just the same as creating a new
> *repository* by copying an new *repository* is generally fine (except
> when you introduce worktrees, of course).
>
> There users eventually understood that something was wrong, as you
> might expect, when a checkout in one worktree also "checked out" (and
> produced lots of unexpected changes) in the other worktree - or
> similar weirdnesses, eg on commit.
>
> Ideally, as I user, I would expect git to start shouting at me to "git
> worktree repair" the moment the mutual reference between the ".git"
> file of the worktree, and the "gitdir" file of the repo's worktree
> metadata, stopped agreeing.
>
> Is there any reason we can't/don't have such a safety check? (would it
> be expensive??)
>
> I think I can implement something reasonably effective with a pair of
> hooks (pre-commit and post-checkout look like good candidates), but
> I'm weirded out that something like this should need to be "custom".
>
> I did a quick search of the archives but didn't find anything
> relevant. Has this been discussed? Should I try to prepare a patch
> including that sort of validation... somewhere?

Just some thoughts, not a proper answer...

If you want to detect this sort of problem early, then patching one of
the initialization functions which is called by each Git command which
requires a working tree (i.e. those with NEED_WORK_TREE set or which
call setup_work_tree() manually) would be one approach. It's not
immediately obvious which function should be patched since there is
deep and mysterious interaction between the various startup functions,
but probably something in setup.c or environment.c.

An alternative might be to perform the detection only when the "index"
is about to be updated or some other worktree-local administrative
entry, but that seems like a much less tractable approach.

Aside from the corruption you describe above, there may be other types
of corruption worth detecting early, but any such detection may be
prohibitively expensive, even if it's just the type you mentioned. (By
"prohibitively", I'm referring to previous work to reduce the startup
time of Git commands; people may not want to see those gains reversed,
especially for a case such as this which is likely to be rare.)

Unless I'm mistaken, the described corruption can only be detected by
a Git command running within the duplicate directory itself since
there will be no entry in .git/worktrees/ corresponding to the
manually-created copy. Hence, Git commands run in any other worktree
will be unable to detect it, not even the "git worktree" command.

The validation performed by worktree.c:validate_worktree() is already
capable of detecting the sort of corruption you describe, if handed a
`struct worktree` populated to point at the worktree which is a copy
of the original worktree. However, there is no API presently to create
a `struct worktree` from an arbitrary path, so that is something you'd
have to add if you want to take advantage of
worktree.c:validate_worktree(). Adding such a function does feel
somewhat ugly and special-purpose, though.

I was going to mention that suggesting to the user merely to use "git
worktree repair" would not help in this situation, but I see in your
followup email that you instruct the user to first delete one of the
worktrees before running "git worktree repair", which would indeed
work. However, you probably want the instructions to be clearer,
saying that the user should delete the worktree directory manually
(say, with "rm -rf"), _not_ with "git worktree remove".

It wouldn't help with early-detection, but it might be worthwhile to
add a "git worktree validate" command which detects and reports
problems with worktree administrative data (i.e. call
worktree.c:validate_worktree() for each worktree). However, the above
caveat still applies about inability to detect the problem from other
worktrees.

Upgrading "git worktree repair" to report the problem might be
worthwhile, but it also is subject to the same caveat about inability
to detect the problem from other worktrees.

One might suggest that "git worktree repair" should somehow repair the
situation itself, perhaps by creating a new entry in .git/worktrees/,
but it's not at all clear if that is a good idea. Any such automated
solution would need to be very careful not to throw away the user's
work (for instance, work which is staged in the "index").

It may be possible to add some option or subcommand to "git worktree"
which would allow a user to "attach" an existing directory as a
worktree. For instance:

    % cp -R worktreeA worktreeB
    % git worktree attach worktreeB

would create the necessary administrative entries in
.git/worktrees/worktreeB/ and make worktreeB/.git point at
.git/worktrees/worktreeB. However, I'm extremely reluctant to suggest
doing this since we don't want to encourage users to perform worktree
manipulation manually; they should be using "git worktree" for all
such tasks. (We also don't want users hijacking a worktree which
belongs to some other repository.)
