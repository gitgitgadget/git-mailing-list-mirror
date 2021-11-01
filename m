Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE0FDC433EF
	for <git@archiver.kernel.org>; Mon,  1 Nov 2021 07:07:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D2ED60E52
	for <git@archiver.kernel.org>; Mon,  1 Nov 2021 07:07:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230312AbhKAHKF (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Nov 2021 03:10:05 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59221 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229938AbhKAHKD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Nov 2021 03:10:03 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4C048DD7BC;
        Mon,  1 Nov 2021 03:07:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=C77ARdFsaKCJdnbSirqFsjEdfASNfOpqriXzLP
        I/v4I=; b=xEznGz51fpml1W+gFXUDMJZxhF6o39KrQOWSfBP/be6jFNoYQ9/AKX
        NJLJn1KYzDd1DTIxtgSnYdqOV0MsfjcUZFkxT2sEmUegdLdqHoCku6IrvXAtkFEL
        Orl9/pnGK5esPOPVPHvv82ZWhFqz83pHI8Mb9oAMPt+qwqhXe//sE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 421A5DD7BB;
        Mon,  1 Nov 2021 03:07:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 8C928DD7BA;
        Mon,  1 Nov 2021 03:07:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Altmanninger <aclopte@gmail.com>
Cc:     rhodges@cisco.com, git@vger.kernel.org, rphodges@gmail.com
Subject: Re* [PATCH v2] apply: make --intent-to-add not stomp index
References: <20211030204155.2500624-1-aclopte@gmail.com>
        <20211030205147.2503327-1-aclopte@gmail.com>
        <xmqqr1c0cray.fsf@gitster.g>
Date:   Mon, 01 Nov 2021 00:07:28 -0700
In-Reply-To: <xmqqr1c0cray.fsf@gitster.g> (Junio C. Hamano's message of "Sun,
        31 Oct 2021 23:40:05 -0700")
Message-ID: <xmqqfssgcq1b.fsf_-_@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 60662180-3AE2-11EC-808A-CD991BBA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Can you study the code to decide if check_apply_state() is the right
> place to do this instead?  I have this feeling that the following
> bit in the function
>
> 	if (state->ita_only && (state->check_index || is_not_gitdir))
> 		state->ita_only = 0;
>
> is simply _wrong_ to silently drop the ita_only bit when not in a
> repository, or other index-touching options are in effect.  Rather,
> I wonder if it should look more like the attached (the other parts
> of the implementation of ita_only may be depending on the buggy
> construct, which might result in other breakages if we did this
> alone, though).

All the existing tests and your new test seem to pass with the "-N
should imply --index" fix.  It could merely be an indication that
our test coverage is horrible, but I _think_ the intent of "-N" is
to behave like "--index" does, but handle creation part slightly
differently.

Of course there is another possible interpretation for "-N", which
is to behave unlike "--index" and touch _only_ the working tree
files, but creations are recorded as if "git add -N" were run for
new paths after such a "working tree only" application was done.

I cannot tell if that is what you wanted to implement; the new test
in your patch seems to pass with the first interpretation.

----- >8 --------- >8 --------- >8 --------- >8 --------- >8 -----
Subject: [PATCH] apply: --intent-to-add should imply --index

Otherwise we do not read the current index, and more importantly, we
do not check with the current index, losing all the safety.

And the worst part of the story is that we still write the result
out to the index, which loses all the files that are not mentioned
in the incoming patch.

Reported-by: Ryan Hodges <rhodges@cisco.com>
Test-by: Johannes Altmanninger <aclopte@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 apply.c               | 4 ++--
 t/t2203-add-intent.sh | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/apply.c b/apply.c
index 43a0aebf4e..887465347b 100644
--- a/apply.c
+++ b/apply.c
@@ -146,6 +146,8 @@ int check_apply_state(struct apply_state *state, int force_apply)
 	}
 	if (!force_apply && (state->diffstat || state->numstat || state->summary || state->check || state->fake_ancestor))
 		state->apply = 0;
+	if (state->ita_only)
+		state->check_index = 1;
 	if (state->check_index && is_not_gitdir)
 		return error(_("--index outside a repository"));
 	if (state->cached) {
@@ -153,8 +155,6 @@ int check_apply_state(struct apply_state *state, int force_apply)
 			return error(_("--cached outside a repository"));
 		state->check_index = 1;
 	}
-	if (state->ita_only && (state->check_index || is_not_gitdir))
-		state->ita_only = 0;
 	if (state->check_index)
 		state->unsafe_paths = 0;
 
diff --git a/t/t2203-add-intent.sh b/t/t2203-add-intent.sh
index cf0175ad6e..035ce3a2b9 100755
--- a/t/t2203-add-intent.sh
+++ b/t/t2203-add-intent.sh
@@ -307,7 +307,7 @@ test_expect_success 'apply --intent-to-add' '
 	grep "new file" expected &&
 	git reset --hard &&
 	git apply --intent-to-add expected &&
-	git diff >actual &&
+	(git diff && git diff --cached) >actual &&
 	test_cmp expected actual
 '
 
-- 
2.34.0-rc0-136-gecf67dd964

