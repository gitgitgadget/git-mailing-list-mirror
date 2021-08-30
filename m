Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF8B4C432BE
	for <git@archiver.kernel.org>; Mon, 30 Aug 2021 21:14:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D256E60F44
	for <git@archiver.kernel.org>; Mon, 30 Aug 2021 21:14:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236305AbhH3VPr (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Aug 2021 17:15:47 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60195 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234509AbhH3VPq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Aug 2021 17:15:46 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D1D62E6B78;
        Mon, 30 Aug 2021 17:14:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=xmHqtdoCDlW1HBEqGNCDbvEDP8fwsQ6knTFKti
        tydaE=; b=m6N5bs4rF6wByv7zJHhBe6YrNRV5KbEqRy2QEVqAzrt0WwZ7xz+x9H
        AxYja7ly28BIYZxWE6/oZnYMS0FuKJ8gw6B6lqWK/0rVKX4aw/h84RgH/x3Rq/ny
        ebXxYy5F7BHM8XkJ/+mKxGsM/f2Uh8/T+t85WyEWOa8dqIhZkIj+g=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C922BE6B77;
        Mon, 30 Aug 2021 17:14:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.116.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 52E8AE6B76;
        Mon, 30 Aug 2021 17:14:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [PATCH 4/4] RFC: refs: reflog entries aren't written based on
 reflog existence.
References: <pull.1067.git.git.1630334929.gitgitgadget@gmail.com>
        <2f11fd7718005d1e94b3139f086134896da202f1.1630334929.git.gitgitgadget@gmail.com>
Date:   Mon, 30 Aug 2021 14:14:50 -0700
In-Reply-To: <2f11fd7718005d1e94b3139f086134896da202f1.1630334929.git.gitgitgadget@gmail.com>
        (Han-Wen Nienhuys via GitGitGadget's message of "Mon, 30 Aug 2021
        14:48:48 +0000")
Message-ID: <xmqqbl5e3a9h.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 506CB884-09D7-11EC-AEC2-ECFD1DBA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Han-Wen Nienhuys <hanwen@google.com>
>
> Before, if we aren't supposed to update reflogs (eg.
> core.logallrefupdates=NONE), we would still write reflog entries if the
> reflog file (.git/logs/REFNAME) existed.
>
> The reftable storage backend cannot distinguish between a non-existing
> reflog, and an empty one. Therefore it cannot mimick this functionality.
>
> In CAFQ2z_Ps3YxycA+NJ9VKt_PEXb+m83JdNB7ujzWw1fTPKyZ=fg@mail.gmail.com,
> we came to the conclusion that this feature is probably a remnant from
> the time that reflogs weren't enabled by default, and it does not need
> to be kept.
>
> Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
> ---
>  refs/files-backend.c  | 20 +-------------------
>  t/t1400-update-ref.sh |  7 +++----
>  2 files changed, 4 insertions(+), 23 deletions(-)

While I like the loss of lines and reduced complexity...

One potential harm this change will bring to us is what happens to
people who disable core.logAllRefUpdates manually after using the
repository for a while.  Their @{4} will point at the same commit no
matter how many operations are done on the current branch after they
do so.  I wouldn't mind if "git reflog disable" command is given to
the users prominently and core.logAllRefUpdates becomes a mere
implementation detail nobody has to care about---in such a world, we
could set the configuration and drop the existing reflog records at
the same time and nobody will be hurt.

If we keep the current behaviour, what are we harming instead?
Growth of diskspace usage is an obvious one, but disks are cheaper
compared to human brainwave cycles cost.

> diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
> index de0cf678f8e..52433f6d0d2 100755
> --- a/t/t1400-update-ref.sh
> +++ b/t/t1400-update-ref.sh
> @@ -269,7 +269,7 @@ test_expect_success "(not) changed .git/$m" '
>  '
>  
>  rm -f .git/logs/refs/heads/main
> -test_expect_success "create $m (logged by touch)" '
> +test_expect_success "create $m" '
>  	test_config core.logAllRefUpdates false &&
>  	GIT_COMMITTER_DATE="2005-05-26 23:30" \
>  	git update-ref --create-reflog HEAD $A -m "Initial Creation" &&
> @@ -315,12 +315,10 @@ test_expect_success 'symref empty directory removal' '
>  	test_path_is_file .git/logs/HEAD
>  '
>  
> -TAB='	'
>  cat >expect <<EOF
>  $Z $A $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1117150200 +0000	Initial Creation
> -$A $B $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1117150260 +0000	Switch
> -$B $A $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1117150860 +0000$TAB
>  EOF
> +
>  test_expect_success "verifying $m's log (logged by touch)" '
>  	test_when_finished "git update-ref -d $m && rm -rf .git/logs actual expect" &&
>  	test-tool ref-store main for-each-reflog-ent $m > actual &&
> @@ -346,6 +344,7 @@ test_expect_success "set $m (logged by config)" '
>  	test $A = $(git show-ref -s --verify $m)
>  '
>  
> +TAB='	'
>  cat >expect <<EOF
>  $Z $A $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1117150320 +0000	Initial Creation
>  $A $B $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1117150380 +0000	Switch

Moving the definition of TAB= around in the test is not all that
welcome.  If anything, I'd suggest doing so nearer to the beginning
of the test sequence, before the first test that uses the ref-store
test-tool, because it is just like $GIT_COMMITTER_EMAIL and $RUN
that define constants used throughout the remainder of the test
script.

THanks.
