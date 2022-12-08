Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C19B8C4332F
	for <git@archiver.kernel.org>; Thu,  8 Dec 2022 21:41:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229652AbiLHVlo (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Dec 2022 16:41:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiLHVlm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Dec 2022 16:41:42 -0500
Received: from mail-40136.proton.ch (mail-40136.proton.ch [185.70.40.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1029FA1A7
        for <git@vger.kernel.org>; Thu,  8 Dec 2022 13:41:40 -0800 (PST)
Date:   Thu, 08 Dec 2022 21:41:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nullpo.dev;
        s=protonmail3; t=1670535697; x=1670794897;
        bh=aWd2mpJwyK/2NeGxvupLtqs29iX//wUUoNlHFbfeS5A=;
        h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
         Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
        b=a3CPwRCB5OKHHtnAg5s1TaxKLRo9xAoY7GTBNQv0wFuF6KYtwFzQEV7Nvuk5TWhmM
         Vme7Fbir0dN+G5MZnXEXVihrFC+4EnBtedjihE2A2RhYU/tYOQD1wUjfTZWq8dogT3
         1rZww/G7EN1imx4wEe29kC8GC1NmDZuYPpyEs/yvpDjn+xfQanUvK5uhD+wGvoiwjW
         fXbKxNqTITP2KUf8It6cT/7L2UI/MoYEUpd5PANed0+CDOjfBRpiDr3cLvDwOzU1D3
         LU037SFCKGTplcHZTzdaHfpxYZxysHshuZOHFq3Fc80+CoU3pjBCdruFy9T5I9fcdz
         7T/43sDpK9DFw==
To:     jacobabel@nullpo.dev
From:   Jacob Abel <jacobabel@nullpo.dev>
Cc:     =?utf-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?utf-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Subject: Re: [PATCH v3 0/2] worktree: Support `--orphan` when creating new worktrees
Message-ID: <20221208214110.bdu5n65c3fvcxjom@phi>
Feedback-ID: 21506737:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Apologies for the delay on the v4 patch. Some unexpected personal stuff has=
 kept
me away from working on this. I expect v4 to be out in the next few days.

Additionally, I've been doing some reading after writing this reply [1]. I'=
ve
realised I had a misunderstanding about how HEAD is managed. I don't think =
it
changes the conclusion of the reply (which is that rolling `--orphan` into =
DWYM
could lead to confusing behavior for users) however I think some additional
changes might be warranted:

* Add some additional text output to `worktree add` when we DWYM to make it
  clearer what action we end up making. Could possibly be hidden under a
  "verbose" flag.
* Annotate what HEAD we are looking at (worktree HEAD vs git repo HEAD) in
  conditions where this could matter.
* Expanding HEAD when it's an invalid ref (instead of just `invalid ref: HE=
AD`).
* Add a hint when using `worktree add`, with a bare git repo, HEAD points t=
o an
  invalid ref, not in a worktree, and other branches exist in the repo. The=
 hint
  would suggest using `git branch -m <branch>` to change the HEAD to an exi=
sting
  branch.
* Add a hint when there are no local branches and the user is trying to cre=
ate a
  worktree off a local branch which has a remote counterpart.

I don't necessarily think any of these changes should hold up this patchset=
 but
I think they could be worthwhile changes for the future.

And in the meantime, below are the anticipated changes for the next revisio=
n. Let
me know if it looks like I've forgotten anything.

Anticipated changes from v3:
  * Fix mistake in SYNOPSIS and `--help`. Patch for this change can be foun=
d
    in [2], by courtesy of =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason.
  * Collapsed sequential if statements into if-else chain & simplified
    conditions as requested in [2].
  * Simplified tests for mutually exclusive options and removed duplicate
    `-B/--detach` test case. Patch for this change can be found in [3],
    by courtesy of =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason.
  * Remove references to `git-switch`. Behavior is now explained fully in d=
ocs
    instead. Changes to the docs suggested in [4], by courtesy of Eric Suns=
hine.
  * Updated test case to use `test_path_is_missing` instead of `! test -d` =
[5].
  * Updated signature for `make_worktree_orphan()` and changed
    `const char *orphan_branch` in `struct add_opts` to `int orphan` (boole=
an)
    to simplify the patch and maintain consistency with other flags [6].
  * Added `advise()` to common cases where `--orphan` is desired [7] to add=
ress
    concerns brought up in [8][9]. Slight change from `HEAD` to `branch` as
    `HEAD` causes existing behavior to break.
  * Added tests to verify `--lock` and `--reason` work properly with
    the newly added `--orphan` flag.
  * Added tests to verify that the orphan advise [7] is emitted only at the
    proper times.
  * Added the new advice to the docs, advice.c/h, and switched to use
    `advise_if_enabled()` as requested in [10].
  * Added tests to verify the changes [7] do not interfere with existing
    behavior. ex: creating a worktree from a remote branch when HEAD is
    an orphan.

1. https://lore.kernel.org/git/20221123042052.t42jmsqjxgx2k3th@phi/
2. https://lore.kernel.org/git/221115.86edu3kfqz.gmgdl@evledraar.gmail.com/
3. https://lore.kernel.org/git/221116.86a64rkdcj.gmgdl@evledraar.gmail.com/
4. https://lore.kernel.org/git/CAPig+cQiyd9yGE_XpPZmzLQnNDMypnrEgkV7nqRZZn3=
j6E0APQ@mail.gmail.com/
5. https://lore.kernel.org/git/221115.86iljfkjjo.gmgdl@evledraar.gmail.com/
6. https://lore.kernel.org/git/20221119025701.syuscuoqjuqhqsoz@phi/
7. https://lore.kernel.org/git/20221119034728.m4kxh4tdpof7us7j@phi/
8. https://lore.kernel.org/git/CAPig+cTTn764ObHJuw8epOtBdTUwocVRV=3DtLieCa4=
zf-PGCegw@mail.gmail.com/
9. https://lore.kernel.org/git/221117.86sfihj3mw.gmgdl@evledraar.gmail.com/
10. https://lore.kernel.org/git/221123.86a64ia6bx.gmgdl@evledraar.gmail.com=
/

