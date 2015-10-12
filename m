From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv7 1/8] submodule.c: write "Fetching submodule <foo>" to stderr
Date: Mon, 12 Oct 2015 11:47:14 -0700
Message-ID: <1444675641-14866-2-git-send-email-sbeller@google.com>
References: <1444675641-14866-1-git-send-email-sbeller@google.com>
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	Stefan Beller <sbeller@google.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Oct 12 20:47:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zli8I-000693-F6
	for gcvg-git-2@plane.gmane.org; Mon, 12 Oct 2015 20:47:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752568AbbJLSrd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Oct 2015 14:47:33 -0400
Received: from mail-pa0-f53.google.com ([209.85.220.53]:34674 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752549AbbJLSr1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Oct 2015 14:47:27 -0400
Received: by padhy16 with SMTP id hy16so160544933pad.1
        for <git@vger.kernel.org>; Mon, 12 Oct 2015 11:47:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=KW5JbPo4M07gIBhqikxQwLK+rYsFOYjfXLeyuzB6ff0=;
        b=DMeUCvTnw1ob+B9Pig7W+/tRL1bznoeEradOfsuGwpuFAKNnmZnfDP8wUneY5lSoDQ
         GnPH/MkKi05Hi6zibmfQS9DrqW1KudTmfz2INNM6vjfWhDno/j8JqNtScwejKWFhgsB+
         daZFbg03YarDAKyyUbi7oPouUOsCbXbNVIJhnGIYOy5zUnxcRkrZ3pid1MByIYH4HYxL
         cVTl/8TW2DAzavzIsULvIQ5pu+PPz3vZA5oGOxhNpsHoxHUcb4UkEduqw5rW6JXLN0aZ
         uYRptHCVhvW5yyfvsKXIOI6N/XXqaQDOrCkSIcTODnFLU3WuXcUEJBNW3UpwKjaCrLzw
         SU2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=KW5JbPo4M07gIBhqikxQwLK+rYsFOYjfXLeyuzB6ff0=;
        b=ZcKNpBZl4HKsRzdBhno2Hczt07HKvxIpp2561BcrzYfUFWWqgveZ0JEk7gk5/d/W0x
         yZXdO2VyBP9TYzmNcTigTXV7tpriG2crhDyxs8cNBbD4EOgrjaYR+ET7fDPckJO2xYIV
         +k84Q3/chmxj6snBHT4x1iwXOrdpbkmU6eT3oLhIe6i+Qxl7+U5OtoHU7uh5j7Sei/jT
         PigLuFq350X8eKxGEK3xPwIzGYsqxE4WOhys2aIfi4CKrRJf3wQmLTMfep2aC7SnloEy
         Tr3LQjK9uc3/w4hOGvDaIHMsWpymKznCC+IT2wfUm/GOFLUrEiKobilrFcfp9aNnBB97
         fK3A==
X-Gm-Message-State: ALoCoQk/m5FHpwEMxsqfpaN0kUQJ6WwPW5I+YQxjgXMsf1f8jf1YwnSHYTvK+IuUerr/4N1zgwXt
X-Received: by 10.66.219.8 with SMTP id pk8mr36705991pac.138.1444675647430;
        Mon, 12 Oct 2015 11:47:27 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:5950:8bdc:8939:e460])
        by smtp.gmail.com with ESMTPSA id vm6sm19719516pbc.8.2015.10.12.11.47.26
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 12 Oct 2015 11:47:26 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.268.g453a26a
In-Reply-To: <1444675641-14866-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279394>

From: Jonathan Nieder <jrnieder@gmail.com>

The "Pushing submodule <foo>" progress output correctly goes to
stderr, but "Fetching submodule <foo>" is going to stdout by
mistake.  Fix it to write to stderr.

Noticed while trying to implement a parallel submodule fetch.  When
this particular output line went to a different file descriptor, it
was buffered separately, resulting in wrongly interleaved output if
we copied it to the terminal naively.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 submodule.c                 |  2 +-
 t/t5526-fetch-submodules.sh | 51 +++++++++++++++++++++++----------------------
 2 files changed, 27 insertions(+), 26 deletions(-)

diff --git a/submodule.c b/submodule.c
index 9fcc86f..1d64e57 100644
--- a/submodule.c
+++ b/submodule.c
@@ -694,7 +694,7 @@ int fetch_populated_submodules(const struct argv_array *options,
 			git_dir = submodule_git_dir.buf;
 		if (is_directory(git_dir)) {
 			if (!quiet)
-				printf("Fetching submodule %s%s\n", prefix, ce->name);
+				fprintf(stderr, "Fetching submodule %s%s\n", prefix, ce->name);
 			cp.dir = submodule_path.buf;
 			argv_array_push(&argv, default_argv);
 			argv_array_push(&argv, "--submodule-prefix");
diff --git a/t/t5526-fetch-submodules.sh b/t/t5526-fetch-submodules.sh
index a4532b0..17759b1 100755
--- a/t/t5526-fetch-submodules.sh
+++ b/t/t5526-fetch-submodules.sh
@@ -16,7 +16,8 @@ add_upstream_commit() {
 		git add subfile &&
 		git commit -m new subfile &&
 		head2=$(git rev-parse --short HEAD) &&
-		echo "From $pwd/submodule" > ../expect.err &&
+		echo "Fetching submodule submodule" > ../expect.err &&
+		echo "From $pwd/submodule" >> ../expect.err &&
 		echo "   $head1..$head2  master     -> origin/master" >> ../expect.err
 	) &&
 	(
@@ -27,6 +28,7 @@ add_upstream_commit() {
 		git add deepsubfile &&
 		git commit -m new deepsubfile &&
 		head2=$(git rev-parse --short HEAD) &&
+		echo "Fetching submodule submodule/subdir/deepsubmodule" >> ../expect.err
 		echo "From $pwd/deepsubmodule" >> ../expect.err &&
 		echo "   $head1..$head2  master     -> origin/master" >> ../expect.err
 	)
@@ -56,9 +58,7 @@ test_expect_success setup '
 	(
 		cd downstream &&
 		git submodule update --init --recursive
-	) &&
-	echo "Fetching submodule submodule" > expect.out &&
-	echo "Fetching submodule submodule/subdir/deepsubmodule" >> expect.out
+	)
 '
 
 test_expect_success "fetch --recurse-submodules recurses into submodules" '
@@ -67,7 +67,7 @@ test_expect_success "fetch --recurse-submodules recurses into submodules" '
 		cd downstream &&
 		git fetch --recurse-submodules >../actual.out 2>../actual.err
 	) &&
-	test_i18ncmp expect.out actual.out &&
+	test_must_be_empty actual.out &&
 	test_i18ncmp expect.err actual.err
 '
 
@@ -96,7 +96,7 @@ test_expect_success "using fetchRecurseSubmodules=true in .gitmodules recurses i
 		git config -f .gitmodules submodule.submodule.fetchRecurseSubmodules true &&
 		git fetch >../actual.out 2>../actual.err
 	) &&
-	test_i18ncmp expect.out actual.out &&
+	test_must_be_empty actual.out &&
 	test_i18ncmp expect.err actual.err
 '
 
@@ -127,7 +127,7 @@ test_expect_success "--recurse-submodules overrides fetchRecurseSubmodules setti
 		git config --unset -f .gitmodules submodule.submodule.fetchRecurseSubmodules &&
 		git config --unset submodule.submodule.fetchRecurseSubmodules
 	) &&
-	test_i18ncmp expect.out actual.out &&
+	test_must_be_empty actual.out &&
 	test_i18ncmp expect.err actual.err
 '
 
@@ -146,7 +146,7 @@ test_expect_success "--dry-run propagates to submodules" '
 		cd downstream &&
 		git fetch --recurse-submodules --dry-run >../actual.out 2>../actual.err
 	) &&
-	test_i18ncmp expect.out actual.out &&
+	test_must_be_empty actual.out &&
 	test_i18ncmp expect.err actual.err
 '
 
@@ -155,7 +155,7 @@ test_expect_success "Without --dry-run propagates to submodules" '
 		cd downstream &&
 		git fetch --recurse-submodules >../actual.out 2>../actual.err
 	) &&
-	test_i18ncmp expect.out actual.out &&
+	test_must_be_empty actual.out &&
 	test_i18ncmp expect.err actual.err
 '
 
@@ -166,7 +166,7 @@ test_expect_success "recurseSubmodules=true propagates into submodules" '
 		git config fetch.recurseSubmodules true
 		git fetch >../actual.out 2>../actual.err
 	) &&
-	test_i18ncmp expect.out actual.out &&
+	test_must_be_empty actual.out &&
 	test_i18ncmp expect.err actual.err
 '
 
@@ -180,7 +180,7 @@ test_expect_success "--recurse-submodules overrides config in submodule" '
 		) &&
 		git fetch --recurse-submodules >../actual.out 2>../actual.err
 	) &&
-	test_i18ncmp expect.out actual.out &&
+	test_must_be_empty actual.out &&
 	test_i18ncmp expect.err actual.err
 '
 
@@ -214,16 +214,15 @@ test_expect_success "Recursion stops when no new submodule commits are fetched"
 	git add submodule &&
 	git commit -m "new submodule" &&
 	head2=$(git rev-parse --short HEAD) &&
-	echo "Fetching submodule submodule" > expect.out.sub &&
 	echo "From $pwd/." > expect.err.sub &&
 	echo "   $head1..$head2  master     -> origin/master" >>expect.err.sub &&
-	head -2 expect.err >> expect.err.sub &&
+	head -3 expect.err >> expect.err.sub &&
 	(
 		cd downstream &&
 		git fetch >../actual.out 2>../actual.err
 	) &&
 	test_i18ncmp expect.err.sub actual.err &&
-	test_i18ncmp expect.out.sub actual.out
+	test_must_be_empty actual.out
 '
 
 test_expect_success "Recursion doesn't happen when new superproject commits don't change any submodules" '
@@ -269,7 +268,7 @@ test_expect_success "Recursion picks up config in submodule" '
 		)
 	) &&
 	test_i18ncmp expect.err.sub actual.err &&
-	test_i18ncmp expect.out actual.out
+	test_must_be_empty actual.out
 '
 
 test_expect_success "Recursion picks up all submodules when necessary" '
@@ -285,7 +284,8 @@ test_expect_success "Recursion picks up all submodules when necessary" '
 		git add subdir/deepsubmodule &&
 		git commit -m "new deepsubmodule"
 		head2=$(git rev-parse --short HEAD) &&
-		echo "From $pwd/submodule" > ../expect.err.sub &&
+		echo "Fetching submodule submodule" > ../expect.err.sub &&
+		echo "From $pwd/submodule" >> ../expect.err.sub &&
 		echo "   $head1..$head2  master     -> origin/master" >> ../expect.err.sub
 	) &&
 	head1=$(git rev-parse --short HEAD) &&
@@ -295,13 +295,13 @@ test_expect_success "Recursion picks up all submodules when necessary" '
 	echo "From $pwd/." > expect.err.2 &&
 	echo "   $head1..$head2  master     -> origin/master" >> expect.err.2 &&
 	cat expect.err.sub >> expect.err.2 &&
-	tail -2 expect.err >> expect.err.2 &&
+	tail -3 expect.err >> expect.err.2 &&
 	(
 		cd downstream &&
 		git fetch >../actual.out 2>../actual.err
 	) &&
 	test_i18ncmp expect.err.2 actual.err &&
-	test_i18ncmp expect.out actual.out
+	test_must_be_empty actual.out
 '
 
 test_expect_success "'--recurse-submodules=on-demand' doesn't recurse when no new commits are fetched in the superproject (and ignores config)" '
@@ -317,7 +317,8 @@ test_expect_success "'--recurse-submodules=on-demand' doesn't recurse when no ne
 		git add subdir/deepsubmodule &&
 		git commit -m "new deepsubmodule" &&
 		head2=$(git rev-parse --short HEAD) &&
-		echo "From $pwd/submodule" > ../expect.err.sub &&
+		echo Fetching submodule submodule > ../expect.err.sub &&
+		echo "From $pwd/submodule" >> ../expect.err.sub &&
 		echo "   $head1..$head2  master     -> origin/master" >> ../expect.err.sub
 	) &&
 	(
@@ -335,7 +336,7 @@ test_expect_success "'--recurse-submodules=on-demand' recurses as deep as necess
 	git add submodule &&
 	git commit -m "new submodule" &&
 	head2=$(git rev-parse --short HEAD) &&
-	tail -2 expect.err > expect.err.deepsub &&
+	tail -3 expect.err > expect.err.deepsub &&
 	echo "From $pwd/." > expect.err &&
 	echo "   $head1..$head2  master     -> origin/master" >>expect.err &&
 	cat expect.err.sub >> expect.err &&
@@ -354,7 +355,7 @@ test_expect_success "'--recurse-submodules=on-demand' recurses as deep as necess
 			git config --unset -f .gitmodules submodule.subdir/deepsubmodule.fetchRecursive
 		)
 	) &&
-	test_i18ncmp expect.out actual.out &&
+	test_must_be_empty actual.out &&
 	test_i18ncmp expect.err actual.err
 '
 
@@ -388,7 +389,7 @@ test_expect_success "'fetch.recurseSubmodules=on-demand' overrides global config
 	head2=$(git rev-parse --short HEAD) &&
 	echo "From $pwd/." > expect.err.2 &&
 	echo "   $head1..$head2  master     -> origin/master" >>expect.err.2 &&
-	head -2 expect.err >> expect.err.2 &&
+	head -3 expect.err >> expect.err.2 &&
 	(
 		cd downstream &&
 		git config fetch.recurseSubmodules on-demand &&
@@ -399,7 +400,7 @@ test_expect_success "'fetch.recurseSubmodules=on-demand' overrides global config
 		cd downstream &&
 		git config --unset fetch.recurseSubmodules
 	) &&
-	test_i18ncmp expect.out.sub actual.out &&
+	test_must_be_empty actual.out &&
 	test_i18ncmp expect.err.2 actual.err
 '
 
@@ -416,7 +417,7 @@ test_expect_success "'submodule.<sub>.fetchRecurseSubmodules=on-demand' override
 	head2=$(git rev-parse --short HEAD) &&
 	echo "From $pwd/." > expect.err.2 &&
 	echo "   $head1..$head2  master     -> origin/master" >>expect.err.2 &&
-	head -2 expect.err >> expect.err.2 &&
+	head -3 expect.err >> expect.err.2 &&
 	(
 		cd downstream &&
 		git config submodule.submodule.fetchRecurseSubmodules on-demand &&
@@ -427,7 +428,7 @@ test_expect_success "'submodule.<sub>.fetchRecurseSubmodules=on-demand' override
 		cd downstream &&
 		git config --unset submodule.submodule.fetchRecurseSubmodules
 	) &&
-	test_i18ncmp expect.out.sub actual.out &&
+	test_must_be_empty actual.out &&
 	test_i18ncmp expect.err.2 actual.err
 '
 
-- 
2.5.0.268.g453a26a
