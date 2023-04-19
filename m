Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B8A8C77B73
	for <git@archiver.kernel.org>; Wed, 19 Apr 2023 13:25:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233137AbjDSNZB (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Apr 2023 09:25:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232708AbjDSNY7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Apr 2023 09:24:59 -0400
Received: from mail-4018.proton.ch (mail-4018.proton.ch [185.70.40.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4DDF16B11
        for <git@vger.kernel.org>; Wed, 19 Apr 2023 06:24:31 -0700 (PDT)
Date:   Wed, 19 Apr 2023 13:23:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nullpo.dev;
        s=protonmail3; t=1681910627; x=1682169827;
        bh=yLtOkkbP6OBRD/MM9ZcN6uLI7Kz7EQasUwYZ+ZP2ItU=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=F5RwIIqu+i6b8xBbWw4f1JzFDjyNi9HJq7DYkVNirt5VWCWx2yMIGvKDjtPhyNk9V
         N/jWn3vEECiwkYI1cC45j/HbBrN1TsUqo85ptediHxMC7ONP6UvCcXK11lddJ5jtlR
         qKvR22tmWFaVG6jiQBk3NQ/rHpIjinM3GZwuRd+2nXK227B5Pd8lWbBXoAy7GKJyuh
         vBYQq/8/q5k05pcaMZOduLoOBFe1NS1ZyrXlrkrDqopem9OeU58Aq4U4pqgePhuKTG
         qmhn9LIrZigjFTyGlqf/oTG9/LBT1bDb688rzfkOyinPplsrHBggKnPzxtqJovtgfq
         KMvFx51R6rUQQ==
To:     Junio C Hamano <gitster@pobox.com>
From:   Jacob Abel <jacobabel@nullpo.dev>
Cc:     git@vger.kernel.org,
        =?utf-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?utf-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, rsbecker@nexbridge.com
Subject: Re: [PATCH v9 2/8] t2400: print captured git output when finished
Message-ID: <44hu2yj5d3e2pabrm65vmm32fxe4qesiohii5mbouqu4dupecp@r6nhf3nar4b5>
In-Reply-To: <xmqqsfcxdu9k.fsf@gitster.g>
References: <20230417093255.31079-1-jacobabel@nullpo.dev> <20230417093255.31079-3-jacobabel@nullpo.dev> <xmqq8reqkyfz.fsf@gitster.g> <olztmib77r35mx33a655obqpxui6coj74hfxoxfvcudnkpbqns@ixerneqaai45> <xmqqsfcxdu9k.fsf@gitster.g>
Feedback-ID: 21506737:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 23/04/18 09:34AM, Junio C Hamano wrote:
> Jacob Abel <jacobabel@nullpo.dev> writes:
>
> > [...]
>
> Here is how it fails and test_must_be_empty complains that the
> "actual" file is not empty, if you run the script with "-x -i" after
> applying the patch in the message you are responding to on top of
> this step.
>
> [...]
>
> Observe what test_must_be_empty does in the last part of the
> transcript above.  If you run it without "-i", then the trace will
> show "cat actual" twice (one from test_must_be_empty above, then a
> redundant one from the test_when_finished).
>
> Another reason why we shouldn't add this to test_when_finished is
> because it would not help those who run the tests with "-i" option.
> The test_cleanup handlers are meant to be "clean-up" routines, and
> they are not run when the user uses "-i", intending to go into the
> test directory after seeing the test fail and inspect what is left
> there.

Ah ok I understand what you mean now.

Would the following work? Since all we care about in `git worktree add` is
`stderr`, can't we just duplicate `stderr` to `stdout` while redirecting
stderr to `actual` so that in the event the git command fails, it's still
displayed in the output of `sh t2400-*.sh -x`?

diff --git a/t/t2400-worktree-add.sh b/t/t2400-worktree-add.sh
index 82091cbb1f..a8f734b1c3 100755
--- a/t/t2400-worktree-add.sh
+++ b/t/t2400-worktree-add.sh
@@ -327,8 +327,7 @@ test_expect_success 'add -B' '

 test_expect_success 'add --quiet' '
 =09test_when_finished "git worktree remove -f -f another-worktree" &&
-=09test_when_finished "cat actual" &&
-=09git worktree add --quiet another-worktree main 2>actual &&
+=09git worktree add --quiet another-worktree main 2>actual 2>&1 &&
 =09test_must_be_empty actual
 '


