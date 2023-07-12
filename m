Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2039EB64DD
	for <git@archiver.kernel.org>; Wed, 12 Jul 2023 22:25:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231641AbjGLWZc (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Jul 2023 18:25:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230236AbjGLWZb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jul 2023 18:25:31 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BD371BF9
        for <git@vger.kernel.org>; Wed, 12 Jul 2023 15:25:30 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8412D1B79BD;
        Wed, 12 Jul 2023 18:25:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=xFN7VaqL3q13Af1lvsta7IjvoVpvIIp9MJUYWl
        mzOn4=; b=dxzUH+PJXQH/694SyaBfsPlLN9Qt283temLzB1RpRB6Zm7DeSNnj/d
        +lxbxWxbmTcAMnL+idCuv6kEmubhbfLRJAsHHznYBbYIzfMM9DawbYcmhus2JmA+
        8w3h7FhUTCTniZ9Rq2HJKVtB7pl0/D0/plnYdn+Elz63oD3qqYSWE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7DBB01B79BC;
        Wed, 12 Jul 2023 18:25:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.127.75.226])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E705F1B79BB;
        Wed, 12 Jul 2023 18:25:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     Josh Soref <jsoref@gmail.com>
Subject: Re* [rebase] `fatal: cannot force update the branch ... checkout
 out at ...` is confusing when it isn't active
References: <CACZqfqAB7zyn56+NOL=E8Y3bXNiQnJdmVXgzsnj78C-Anw-h2Q@mail.gmail.com>
        <xmqqbkghw4qd.fsf@gitster.g>
        <CACZqfqDE-SCOqVX9a8KCLAn1zSVbYxuCeU8Y=3-nhj5wbL=AWQ@mail.gmail.com>
        <xmqq5y6osvmc.fsf@gitster.g>
Date:   Wed, 12 Jul 2023 15:25:27 -0700
In-Reply-To: <xmqq5y6osvmc.fsf@gitster.g> (Junio C. Hamano's message of "Wed,
        12 Jul 2023 13:49:47 -0700")
Message-ID: <xmqqy1jkrcmg.fsf_-_@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 018B9894-2103-11EE-B29E-C65BE52EC81B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> It shouldn't be a rocket surgery to teach the function to leave that
> information, but I am not offhand sure how valuable it would be to
> do so.  After all, once you learn which worktree of yours is using
> the branch you wanted to touch, you'll either know already or it
> would be easy for you to find out what you have been doing in that
> other worktree anyway, no?

So, before we forget, let's make a minimum patch and let the list
archive it.

----- >8 --------- >8 --------- >8 --------- >8 --------- >8 -----

Subject: [PATCH] branch: update the message to refuse touching a branch in-use

The "git branch -f" command can refuse to force-update a branch that
is in use in another worktree.  The original rationale for this
behaviour was that updating a branch that is checked out in another
worktree, without making a matching change to the index and the
working tree files in that worktree, will lead to a very confused
user.  "git diff HEAD" will no longer give a useful patch, because
HEAD is a commit unrelated to what the index and the working tree in
the worktree were based on, for example.

These days, however, the same mechanism also protects branches that
are being rebased or bisected, and the same machanism is expected to
be the right place to add more checks, when we decide to protect
branches undergoing other kinds of operations.  We forgot to rethink
the messaging, which originally said that we are refusing to touch
the branch because it is "checked out" elsewhere, when d2ba271a
(branch: check for bisects and rebases, 2022-06-14) started to
protect branches that are being rebased or bisected.

The spirit of the check is that we do not want to disrupt the use of
the same branch in other worktrees.  Let's reword the message slightly
to say that the branch is "in use", instead of "checked out".

We could teach the branch.c:prepare_checked_out_branches() function
to remember why it decided that a particular branch needs protecting
(i.e. was it because it was checked out?  being bisected?  something
else?) in addition to which worktree the branch was in use, and use
that in the error message to say "you cannot force update this
branch because it is being bisected in the worktree X", etc., but it
is dubious that such extra complexity is worth it.  The message
already tells which directory the worktree in question is, and it
should be just a "chdir" away for the user to find out what state it
is in, if the user felt curious enough.  So let's not go there yet.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 branch.c                  |  2 +-
 t/t2407-worktree-heads.sh | 10 +++++-----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/branch.c b/branch.c
index cdf70b0ef0..6cb3b4c56d 100644
--- a/branch.c
+++ b/branch.c
@@ -471,7 +471,7 @@ int validate_new_branchname(const char *name, struct strbuf *ref, int force)
 
 	if ((path = branch_checked_out(ref->buf)))
 		die(_("cannot force update the branch '%s' "
-		      "checked out at '%s'"),
+		      "in use at '%s'"),
 		    ref->buf + strlen("refs/heads/"), path);
 
 	return 1;
diff --git a/t/t2407-worktree-heads.sh b/t/t2407-worktree-heads.sh
index 019a40df2c..d005ce2f20 100755
--- a/t/t2407-worktree-heads.sh
+++ b/t/t2407-worktree-heads.sh
@@ -58,7 +58,7 @@ test_expect_success !SANITIZE_LEAK 'refuse to overwrite: worktree in bisect' '
 	git -C wt-4 bisect good wt-1 &&
 
 	test_must_fail git branch -f wt-4 HEAD 2>err &&
-	grep "cannot force update the branch '\''wt-4'\'' checked out at.*wt-4" err
+	grep "cannot force update the branch '\''wt-4'\'' in use at.*wt-4" err
 '
 
 test_expect_success !SANITIZE_LEAK 'refuse to overwrite: worktree in rebase (apply)' '
@@ -68,7 +68,7 @@ test_expect_success !SANITIZE_LEAK 'refuse to overwrite: worktree in rebase (app
 	test_must_fail git -C wt-2 rebase --apply conflict-2 &&
 
 	test_must_fail git branch -f wt-2 HEAD 2>err &&
-	grep "cannot force update the branch '\''wt-2'\'' checked out at.*wt-2" err
+	grep "cannot force update the branch '\''wt-2'\'' in use at.*wt-2" err
 '
 
 test_expect_success !SANITIZE_LEAK 'refuse to overwrite: worktree in rebase (merge)' '
@@ -78,7 +78,7 @@ test_expect_success !SANITIZE_LEAK 'refuse to overwrite: worktree in rebase (mer
 	test_must_fail git -C wt-2 rebase conflict-2 &&
 
 	test_must_fail git branch -f wt-2 HEAD 2>err &&
-	grep "cannot force update the branch '\''wt-2'\'' checked out at.*wt-2" err
+	grep "cannot force update the branch '\''wt-2'\'' in use at.*wt-2" err
 '
 
 test_expect_success !SANITIZE_LEAK 'refuse to overwrite: worktree in rebase with --update-refs' '
@@ -90,7 +90,7 @@ test_expect_success !SANITIZE_LEAK 'refuse to overwrite: worktree in rebase with
 	for i in 3 4
 	do
 		test_must_fail git branch -f can-be-updated HEAD 2>err &&
-		grep "cannot force update the branch '\''can-be-updated'\'' checked out at.*wt-3" err ||
+		grep "cannot force update the branch '\''can-be-updated'\'' in use at.*wt-3" err ||
 			return 1
 	done
 '
@@ -150,7 +150,7 @@ test_expect_success 'refuse to overwrite when in error states' '
 	for i in 1 2
 	do
 		test_must_fail git branch -f fake-$i HEAD 2>err &&
-		grep "cannot force update the branch '\''fake-$i'\'' checked out at" err ||
+		grep "cannot force update the branch '\''fake-$i'\'' in use at" err ||
 			return 1
 	done
 '
-- 
2.41.0-327-gaa9166bcc0

