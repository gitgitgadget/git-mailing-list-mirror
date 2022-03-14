Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB498C433EF
	for <git@archiver.kernel.org>; Mon, 14 Mar 2022 23:13:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343627AbiCNXOe (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Mar 2022 19:14:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343629AbiCNXOc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Mar 2022 19:14:32 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAC9131234
        for <git@vger.kernel.org>; Mon, 14 Mar 2022 16:13:21 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 48FBE189F0F;
        Mon, 14 Mar 2022 19:13:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=V4LrXFWvHS3XGOY5oluBGZ/3I8fINgUNzS3DRuG54XY=; b=Igrd
        loZqPmSaSXCO/JFzWVo5iJ1kLtn2YE+wgU7TT1xQhX5GA/k3kl0WrSaZ2AcmQ+zH
        q6ThCi7xev3OzzjJD2sPT1IqlGqbc9qxMA8ncjYK6fXL0C9OtaYpnjyCwVCK5dCI
        psrdj7AiPNozYDD5VSbfGOYVG345vaiNAxL+Z5E=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 2DD16189F0E;
        Mon, 14 Mar 2022 19:13:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 5CACE189F09;
        Mon, 14 Mar 2022 19:13:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Yubin Ruan <ablacktshirt@gmail.com>
Cc:     git <git@vger.kernel.org>
Subject: Re: git cherry-pick with --no-verify option
References: <CAJYFCiPw6VPPKpiC0f1iwdYf0LCFCbfrpNSHFs1qbwtGXX6pUA@mail.gmail.com>
Date:   Mon, 14 Mar 2022 23:13:16 +0000
Message-ID: <xmqqee34m8kz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 54EB03B6-A3EC-11EC-8391-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Yubin Ruan <ablacktshirt@gmail.com> writes:

> Is there any version of Git that supports the cherry-pick command with
> "--no-verify"?
>
> It is supported in "git commit" command but not in "git cherry-pick"
> command, and I always have to move .git/hooks/pre-commit away to work
> around this in case of "git cherry-pick".

Does "git cherry-pick" even trigger pre-commit hook in the first
place?  In my quick tests, it does not seem to.

 $ git init test
 $ cd test
 $ printf "%s\n" '#!/bin/sh' 'echo >&2 no' 'exit 1' >.git/hooks/pre-commit
 $ chmod +x .git/hooks/pre-commit
 $ git commit --allow-empty -m initial
 no

Up to this point, I set up a pre-commit that stops me
unconditionally and made sure it is working.

 $ git commit --no-verify --allow-empty -m initial
 [master (root-commit) 5d967c2] initial
 $ I=$(git rev-parse HEAD)
 $ echo "foo" >file
 $ git add file
 $ git commit --no-verify -m 'add file'
 [master 93a33c4] add file
  1 file changed, 1 insertion(+)
  create mode 100644 file

Then I built two commits

 $ git checkout --detach $I
 HEAD is now at 5d967c2 initial

And rewound to the initial commit so that the second one can be
cherry-picked on top of it.

 $ git cherry-pick master
 [detached HEAD 699c604] add file
  Date: Mon Mar 14 15:58:38 2022 -0700
  1 file changed, 1 insertion(+)
  create mode 100644 file

And that is understandable, as "cherry-pick" is more about replaying
what was committed in the past, with bugs and crufts preserved, than
committing a new-and-improved version out of an existing commit.

Perhaps in a case where a conflict stops the command there is
something?  Let's see.  Continuing from the above transcript:

 $ git cherry-pick master
 HEAD detached from 5d967c2
 You are currently cherry-picking commit 93a33c4.
   (all conflicts fixed: run "git cherry-pick --continue")
   (use "git cherry-pick --skip" to skip this patch)
   (use "git cherry-pick --abort" to cancel the cherry-pick operation)

 nothing to commit, working tree clean
 The previous cherry-pick is now empty, possibly due to conflict resolution.
 If you wish to commit it anyway, use:

     git commit --allow-empty

 Otherwise, please use 'git cherry-pick --skip'
 $ edit file
 $ git commit --allow-empty -a
 no

Of course, "git commit" to conclude a conflicted cherry-pick,
possibly with intervening conflict resolutin by editing working tree
files, would by default trigger pre-commit hook, and it of course
takes --no-verify as expected.

 $ git commit --allow-empty -a --no-verify --no-edit
 [detached HEAD 5858d22] add file
  Date: Mon Mar 14 15:58:38 2022 -0700

Ahh, I think the user is fooled by a bad advice in the message.
(all conflicts fixed: run "git cherry-pick --continue") is wrong and
misleading advice added by those who did not think things through.

After fixing all conflicts, run "git commit" to record it and then
you run "git cherry-pick --continue" if there are more steps to
cherry-pick (i.e. "git cherry-pick A..B").  "git commit" takes not
just "--no-verify" but other options like "--reset-author" to let
you take over authorship if the conflict resolution (actually,
adjusting the original commit to the different context it is being
cherry-picked to) is so involved that a change of authorship is
warranted.  "cherry-pick --continue" does not have all the necessary
flexibility and conceptually it is a separte operation (i.e. "please
continue the stopped sequence" is what it means) from concluding the
current step in the sequence.


