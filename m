Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECA41C433EF
	for <git@archiver.kernel.org>; Sat, 11 Jun 2022 19:17:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230154AbiFKTR3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 11 Jun 2022 15:17:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiFKTR2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Jun 2022 15:17:28 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B2526C54C
        for <git@vger.kernel.org>; Sat, 11 Jun 2022 12:17:26 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 066C61A881A;
        Sat, 11 Jun 2022 15:17:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=+ImmJKjz9ujl/PvIV7MCriws5WByTCqdhA33Tf
        pOSHc=; b=D4OVkTALM5BuviBxBzxmTynpin0igyQyeElo9Rzv6FQG49K1m2NXan
        ZlxhN6+FJHc9m5OvGPML08prgKcgXR4HOBW43eT6gTWX+509t6/mNUbivG3WT0rP
        RLsbX0OHiXl+30pf0YzbgAVSRZeB69QbBuHuUBHSJpz6wXlIeO/SE=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id F2CCF1A8819;
        Sat, 11 Jun 2022 15:17:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 9D8031A8818;
        Sat, 11 Jun 2022 15:17:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Tao Klerks via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Tao Klerks <tao@klerks.biz>
Subject: Re: [PATCH] apply: support case-only renames in case-insensitive
 filesystems
References: <pull.1257.git.1654967038802.gitgitgadget@gmail.com>
Date:   Sat, 11 Jun 2022 12:17:20 -0700
In-Reply-To: <pull.1257.git.1654967038802.gitgitgadget@gmail.com> (Tao Klerks
        via GitGitGadget's message of "Sat, 11 Jun 2022 17:03:58 +0000")
Message-ID: <xmqqleu3au2n.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1E350FA0-E9BB-11EC-B2D2-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Tao Klerks via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Tao Klerks <tao@klerks.biz>
>
> "git apply" checks, when validating a patch, to ensure that any files
> being added aren't already in the worktree.
>
> When this check runs on a case-only rename, in a case-insensitive
> filesystem, this leads to a false positive - the command fails with an
> error like:
> error: File1: already exists in working directory
>
> Fix this existence check to allow the file to exist, for a case-only
> rename when config core.ignorecase is set.

Hmph, close, but the patch as-posted may be fatally buggy, I think.

At the beginning of the function there is this block:

	const char *old_name = patch->old_name;
	const char *new_name = patch->new_name;
	const char *name = old_name ? old_name : new_name;

which makes us realize that old_name CAN legitimately be NULL.  That
is true for a creation patch.  new_name can also be NULL for a
deletion patch.

>  	if ((tpatch = in_fn_table(state, new_name)) &&
>  	    (was_deleted(tpatch) || to_be_deleted(tpatch)))
>  		ok_if_exists = 1;
> +	else if (ignore_case && !strcasecmp(old_name, new_name))
> +		ok_if_exists = 1;

You'd get a segfault when the patch is creating a file at new_name,
or deleting a file at old_name, wouldn't you?

We need a new test or two to see if a straight creation or deletion
patch does work correctly with icase set, before we even dream of
handling rename patches.  Not having tests for such basic cases is
quite surprising, but apparently the above line passed the CI.

>  	else
>  		ok_if_exists = 0;

Having said that, I wonder what the existing check before the new
condition is doing?  Especially, what is in_fn_table() for and how
does it try to do its work?

Reading the big comment before it, it seems that it tries to deal
with tricky delete/create case already.  With a typechange patch
that first removes a regular file "hello.txt" and then creates a
symbolic link "hello.txt" is exempted from the "what you are
creating should not exist already" rule by using in_fn_table()
check.  If it tries to create a symlink "Hello.txt" instead,
shouldn't we allow it the same way on case-insensitive systems?  I
do not think in_fn_table() pays attention to "ignore_case" option,
so there may be an existing bug there already, regardless of the
problem you are trying to address with your patch.

And I wonder if doing case-insensitive match in in_fn_table() lets
us cover this new case as well as "fixing" the existing issue.

In any case, here are such two tests to make sure creation and
deletion patches on icase systems are not broken by careless
mistakes like the one in this patch.

 t/t4114-apply-typechange.sh | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git c/t/t4114-apply-typechange.sh w/t/t4114-apply-typechange.sh
index da3e64f811..e565ad8da1 100755
--- c/t/t4114-apply-typechange.sh
+++ w/t/t4114-apply-typechange.sh
@@ -126,4 +126,44 @@ test_expect_success 'directory becomes symlink' '
 test_debug 'cat patch'
 
 
+test_expect_success 'file becomes nothing' '
+	git checkout -f initial &&
+	test_when_finished "git reset --hard HEAD" &&
+
+	# prepare a patch to remove path "foo"
+	git rm --cached foo &&
+	git diff-index -p --cached HEAD >patch &&
+
+	# such a patch should apply cleanly to the index
+	git reset HEAD &&
+	git apply --cached patch &&
+
+	# and even with icase set.
+	git reset HEAD &&
+	git -c core.ignorecase=true apply --cached patch
+'
+
+test_debug 'cat patch'
+
+test_expect_success 'nothing becomes a file' '
+	git checkout -f initial &&
+	test_when_finished "git reset --hard HEAD" &&
+
+	# prepare a patch to add path "foo"
+	git rm --cached foo &&
+	git diff-index -p --cached -R HEAD >patch &&
+
+	# such a patch should apply cleanly to the index without "foo"
+	git reset HEAD &&
+	git rm --cached foo &&
+	git apply --cached patch &&
+
+	# and even with icase set.
+	git reset HEAD &&
+	git rm --cached foo &&
+	git -c core.ignorecase=true apply --cached patch
+'
+
+test_debug 'cat patch'
+
 test_done
