Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE97AC433E0
	for <git@archiver.kernel.org>; Thu, 11 Mar 2021 18:01:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 96B7164FD4
	for <git@archiver.kernel.org>; Thu, 11 Mar 2021 18:01:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230200AbhCKSBZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Mar 2021 13:01:25 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:58282 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230288AbhCKSBV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Mar 2021 13:01:21 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id D1480121782;
        Thu, 11 Mar 2021 13:01:20 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:mime-version:content-type; s=sasl; bh=u
        6QJJhYXdwTHKfmHrrJrfeWLV7M=; b=eb1EfjiuMoNMe9IAltyGx6o9rQiwCR1Sm
        IFYVhLuQrjqs2rb5Up9gN+sUCmWuFC1pYZnQ8yach7N++ggQ8laSBrqjeBe5QT/R
        TdWf0W768uL7OAdoj7+T9Xna55JFVbnfcUgzZuvN5uJeQeu8FTrcNGAOyhmg85sp
        YJ1j0o9DOo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:date:message-id:mime-version:content-type; q=dns; s=
        sasl; b=I3O71XFmhF7pd51vxeOPzs9mJxIsHQJG4Gisfehk6NjACgE+bi1akH1R
        +1NBsVXa2p1FSeQ1XnDqf9+JzfsRYgtXszKsrJS7IVlJNDFnfvLRNdTxpOKPTvpa
        fVS8hsaaeb1BiKF3GxzLHA2/VB+aZNDRQo9yBEXKwifgzJcDgUQ=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C9346121781;
        Thu, 11 Mar 2021 13:01:20 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 1084912177E;
        Thu, 11 Mar 2021 13:01:17 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Han-Wen Nienhuys <hanwen@google.com>
Cc:     git@vger.kernel.org
Subject: [PATCH] SQUASH??? allow t0031 to run with any default branch name
Date:   Thu, 11 Mar 2021 10:01:16 -0800
Message-ID: <xmqqeeglefir.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C7531F22-8293-11EB-B721-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I no longer remember which step in your multi-patch series
introduces this script or these are built-up incrementally, but I've
been carrying this patch at the tip of the series so that merging it
to 'seen' (or any other interation branch) would not make the result
fail depending on the hardcoded default fallback name for the first
branch.  Can you update your series so that I do not have to [*]?

Thanks.

[footnote]

* meaning, either squash into the commit that adds the t0031 test
  script, if the entire test is created in a single commit, or pick
  the parts of this patch apart and sprinkle the fixes to the commit
  that introduces t0031 and subsequent commits that updates it.

 t/t0031-reftable.sh | 54 ++++++++++++++++++++++++---------------------
 1 file changed, 29 insertions(+), 25 deletions(-)

diff --git a/t/t0031-reftable.sh b/t/t0031-reftable.sh
index 58c7d5d4bc..ba0738e515 100755
--- a/t/t0031-reftable.sh
+++ b/t/t0031-reftable.sh
@@ -9,23 +9,27 @@ test_description='reftable basics'
 
 INVALID_SHA1=aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
 
+git_init () {
+	git init -b primary "$@"
+}
+
 initialize ()  {
 	rm -rf .git &&
-	git init --ref-storage=reftable &&
+	git_init --ref-storage=reftable &&
 	mv .git/hooks .git/hooks-disabled
 }
 
 test_expect_success 'SHA256 support, env' '
 	rm -rf .git &&
 	GIT_DEFAULT_HASH=sha256 && export GIT_DEFAULT_HASH &&
-	git init --ref-storage=reftable &&
+	git_init --ref-storage=reftable &&
 	mv .git/hooks .git/hooks-disabled &&
 	test_commit file
 '
 
 test_expect_success 'SHA256 support, option' '
 	rm -rf .git &&
-	git init --ref-storage=reftable --object-format=sha256 &&
+	git_init --ref-storage=reftable --object-format=sha256 &&
 	mv .git/hooks .git/hooks-disabled &&
 	test_commit file
 '
@@ -34,13 +38,13 @@ test_expect_success 'delete ref' '
 	initialize &&
 	test_commit file &&
 	SHA=$(git show-ref -s --verify HEAD) &&
-	test_write_lines "$SHA refs/heads/master" "$SHA refs/tags/file" >expect &&
-	git show-ref > actual &&
+	test_write_lines "$SHA refs/heads/primary" "$SHA refs/tags/file" >expect &&
+	git show-ref >actual &&
 	! git update-ref -d refs/tags/file $INVALID_SHA1 &&
 	test_cmp expect actual &&
 	git update-ref -d refs/tags/file $SHA  &&
-	test_write_lines "$SHA refs/heads/master" >expect &&
-	git show-ref > actual &&
+	test_write_lines "$SHA refs/heads/primary" >expect &&
+	git show-ref >actual &&
 	test_cmp expect actual
 '
 
@@ -54,9 +58,9 @@ test_expect_success 'clone calls transaction_initial_commit' '
 test_expect_success 'basic operation of reftable storage: commit, show-ref' '
 	initialize &&
 	test_commit file &&
-	test_write_lines refs/heads/master refs/tags/file >expect &&
+	test_write_lines refs/heads/primary refs/tags/file >expect &&
 	git show-ref &&
-	git show-ref | cut -f2 -d" " > actual &&
+	git show-ref | cut -f2 -d" " >actual &&
 	test_cmp actual expect
 '
 
@@ -70,12 +74,12 @@ test_expect_success 'reflog, repack' '
 	git pack-refs &&
 	ls -1 .git/reftable >table-files &&
 	test_line_count = 2 table-files &&
-	git reflog refs/heads/master >output &&
+	git reflog refs/heads/primary >output &&
 	test_line_count = 10 output &&
 	grep "commit (initial): number 1" output &&
 	grep "commit: number 10" output &&
 	git gc &&
-	git reflog refs/heads/master >output &&
+	git reflog refs/heads/primary >output &&
 	test_line_count = 0 output
 '
 
@@ -86,8 +90,8 @@ test_expect_success 'branch switch in reflog output' '
 	test_commit file2 &&
 	git checkout -b branch2 &&
 	git switch - &&
-	git rev-parse --symbolic-full-name HEAD > actual &&
-	echo refs/heads/branch1 > expect &&
+	git rev-parse --symbolic-full-name HEAD >actual &&
+	echo refs/heads/branch1 >expect &&
 	test_cmp actual expect
 '
 
@@ -102,7 +106,7 @@ test_expect_success 'peeled tags are stored' '
 	test_commit file &&
 	git tag -m "annotated tag" test_tag HEAD &&
 	{
-		print_ref "refs/heads/master" &&
+		print_ref "refs/heads/primary" &&
 		print_ref "refs/tags/file" &&
 		print_ref "refs/tags/test_tag" &&
 		print_ref "refs/tags/test_tag^{}"
@@ -114,32 +118,32 @@ test_expect_success 'peeled tags are stored' '
 test_expect_success 'show-ref works on fresh repo' '
 	initialize &&
 	rm -rf .git &&
-	git init --ref-storage=reftable &&
+	git_init --ref-storage=reftable &&
 	>expect &&
-	! git show-ref > actual &&
+	! git show-ref >actual &&
 	test_cmp expect actual
 '
 
 test_expect_success 'checkout unborn branch' '
 	initialize &&
-	git checkout -b master
+	git checkout -b primary
 '
 
 
 test_expect_success 'dir/file conflict' '
 	initialize &&
 	test_commit file &&
-	! git branch master/forbidden
+	! git branch primary/forbidden
 '
 
 
 test_expect_success 'do not clobber existing repo' '
 	rm -rf .git &&
-	git init --ref-storage=files &&
-	cat .git/HEAD > expect &&
+	git_init --ref-storage=files &&
+	cat .git/HEAD >expect &&
 	test_commit file &&
-	(git init --ref-storage=reftable || true) &&
-	cat .git/HEAD > actual &&
+	(git_init --ref-storage=reftable || true) &&
+	cat .git/HEAD >actual &&
 	test_cmp expect actual
 '
 
@@ -168,7 +172,7 @@ test_expect_success 'rebase' '
 '
 
 test_expect_success 'worktrees' '
-	git init --ref-storage=reftable start &&
+	git_init --ref-storage=reftable start &&
 	(cd start && test_commit file1 && git checkout -b branch1 &&
 	git checkout -b branch2 &&
 	git worktree add  ../wt
@@ -182,13 +186,13 @@ test_expect_success 'worktrees 2' '
 	initialize &&
 	test_commit file1 &&
 	mkdir existing_empty &&
-	git worktree add --detach existing_empty master
+	git worktree add --detach existing_empty primary
 '
 
 test_expect_success 'FETCH_HEAD' '
 	initialize &&
 	test_commit one &&
-	(git init sub && cd sub && test_commit two) &&
+	(git_init sub && cd sub && test_commit two) &&
 	git --git-dir sub/.git rev-parse HEAD >expect &&
 	git fetch sub &&
 	git checkout FETCH_HEAD &&
-- 
2.31.0-rc2-173-g36b77366ca

