Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A22B2C4332F
	for <git@archiver.kernel.org>; Thu,  8 Dec 2022 22:03:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230020AbiLHWDD convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Thu, 8 Dec 2022 17:03:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbiLHWCh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Dec 2022 17:02:37 -0500
Received: from elephants.elehost.com (elephants.elehost.com [216.66.27.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A718779C2F
        for <git@vger.kernel.org>; Thu,  8 Dec 2022 14:01:16 -0800 (PST)
Received: from Mazikeen (163.150.245.213.rev.sfr.net [213.245.150.163])
        (authenticated bits=0)
        by elephants.elehost.com (8.16.1/8.16.1) with ESMTPSA id 2B8M0wOf053031
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 8 Dec 2022 17:00:59 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
Reply-To: <rsbecker@nexbridge.com>
From:   <rsbecker@nexbridge.com>
To:     "'Jacob Abel'" <jacobabel@nullpo.dev>
Cc:     "=?UTF-8?Q?'=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason'?=" 
        <avarab@gmail.com>, "'Eric Sunshine'" <sunshine@sunshineco.com>,
        "'Phillip Wood'" <phillip.wood123@gmail.com>,
        "=?UTF-8?Q?'Rub=C3=A9n_Justo'?=" <rjusto@gmail.com>,
        "'Taylor Blau'" <me@ttaylorr.com>, <git@vger.kernel.org>
References: <20221208214110.bdu5n65c3fvcxjom@phi>
In-Reply-To: <20221208214110.bdu5n65c3fvcxjom@phi>
Subject: RE: [PATCH v3 0/2] worktree: Support `--orphan` when creating new worktrees
Date:   Thu, 8 Dec 2022 17:00:53 -0500
Organization: Nexbridge Inc.
Message-ID: <007001d90b50$8ee3c000$acab4000$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQGEkSmpqEJbc/7FIDRH64kYKuSPo68NfkZA
Content-Language: en-ca
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On December 8, 2022 4:41 PM, Jacob Abel wrote:
>Subject: Re: [PATCH v3 0/2] worktree: Support `--orphan` when creating new
>worktrees
>
>Apologies for the delay on the v4 patch. Some unexpected personal stuff has kept
>me away from working on this. I expect v4 to be out in the next few days.
>
>Additionally, I've been doing some reading after writing this reply [1]. I've realised
>I had a misunderstanding about how HEAD is managed. I don't think it changes the
>conclusion of the reply (which is that rolling `--orphan` into DWYM could lead to
>confusing behavior for users) however I think some additional changes might be
>warranted:
>
>* Add some additional text output to `worktree add` when we DWYM to make it
>  clearer what action we end up making. Could possibly be hidden under a
>  "verbose" flag.
>* Annotate what HEAD we are looking at (worktree HEAD vs git repo HEAD) in
>  conditions where this could matter.
>* Expanding HEAD when it's an invalid ref (instead of just `invalid ref: HEAD`).
>* Add a hint when using `worktree add`, with a bare git repo, HEAD points to an
>  invalid ref, not in a worktree, and other branches exist in the repo. The hint
>  would suggest using `git branch -m <branch>` to change the HEAD to an existing
>  branch.
>* Add a hint when there are no local branches and the user is trying to create a
>  worktree off a local branch which has a remote counterpart.
>
>I don't necessarily think any of these changes should hold up this patchset but I
>think they could be worthwhile changes for the future.
>
>And in the meantime, below are the anticipated changes for the next revision. Let
>me know if it looks like I've forgotten anything.
>
>Anticipated changes from v3:
>  * Fix mistake in SYNOPSIS and `--help`. Patch for this change can be found
>    in [2], by courtesy of Ævar Arnfjörð Bjarmason.
>  * Collapsed sequential if statements into if-else chain & simplified
>    conditions as requested in [2].
>  * Simplified tests for mutually exclusive options and removed duplicate
>    `-B/--detach` test case. Patch for this change can be found in [3],
>    by courtesy of Ævar Arnfjörð Bjarmason.
>  * Remove references to `git-switch`. Behavior is now explained fully in docs
>    instead. Changes to the docs suggested in [4], by courtesy of Eric Sunshine.
>  * Updated test case to use `test_path_is_missing` instead of `! test -d` [5].
>  * Updated signature for `make_worktree_orphan()` and changed
>    `const char *orphan_branch` in `struct add_opts` to `int orphan` (boolean)
>    to simplify the patch and maintain consistency with other flags [6].
>  * Added `advise()` to common cases where `--orphan` is desired [7] to address
>    concerns brought up in [8][9]. Slight change from `HEAD` to `branch` as
>    `HEAD` causes existing behavior to break.
>  * Added tests to verify `--lock` and `--reason` work properly with
>    the newly added `--orphan` flag.
>  * Added tests to verify that the orphan advise [7] is emitted only at the
>    proper times.
>  * Added the new advice to the docs, advice.c/h, and switched to use
>    `advise_if_enabled()` as requested in [10].
>  * Added tests to verify the changes [7] do not interfere with existing
>    behavior. ex: creating a worktree from a remote branch when HEAD is
>    an orphan.
>
>1. https://lore.kernel.org/git/20221123042052.t42jmsqjxgx2k3th@phi/
>2. https://lore.kernel.org/git/221115.86edu3kfqz.gmgdl@evledraar.gmail.com/
>3. https://lore.kernel.org/git/221116.86a64rkdcj.gmgdl@evledraar.gmail.com/
>4.
>https://lore.kernel.org/git/CAPig+cQiyd9yGE_XpPZmzLQnNDMypnrEgkV7nqRZZn
>3j6E0APQ@mail.gmail.com/
>5. https://lore.kernel.org/git/221115.86iljfkjjo.gmgdl@evledraar.gmail.com/
>6. https://lore.kernel.org/git/20221119025701.syuscuoqjuqhqsoz@phi/
>7. https://lore.kernel.org/git/20221119034728.m4kxh4tdpof7us7j@phi/
>8.
>https://lore.kernel.org/git/CAPig+cTTn764ObHJuw8epOtBdTUwocVRV=tLieCa4zf-
>PGCegw@mail.gmail.com/
>9. https://lore.kernel.org/git/221117.86sfihj3mw.gmgdl@evledraar.gmail.com/
>10. https://lore.kernel.org/git/221123.86a64ia6bx.gmgdl@evledraar.gmail.com/

I am not sure this is entirely related, but there is a gap in worktree configuration, specifically includeIf that I was working on, but suspended waiting for worktree code to stabilize. Do you have a sense as to whether this might run into this topic?

Regards,
Randall

