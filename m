From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 1/8] submodule.c: write "Fetching submodule <foo>" to stderr
Date: Mon, 28 Sep 2015 16:13:59 -0700
Message-ID: <1443482046-25569-2-git-send-email-sbeller@google.com>
References: <1443482046-25569-1-git-send-email-sbeller@google.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>, ramsay@ramsayjones.plus.com,
	jacob.keller@gmail.com, peff@peff.net, gitster@pobox.com,
	johannes.schindelin@gmail.com, Jens.Lehmann@web.de,
	ericsunshine@gmail.com, Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 29 01:14:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zghcs-00075C-B0
	for gcvg-git-2@plane.gmane.org; Tue, 29 Sep 2015 01:14:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753639AbbI1XO0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Sep 2015 19:14:26 -0400
Received: from mail-pa0-f43.google.com ([209.85.220.43]:33749 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753508AbbI1XOX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Sep 2015 19:14:23 -0400
Received: by pacex6 with SMTP id ex6so186729194pac.0
        for <git@vger.kernel.org>; Mon, 28 Sep 2015 16:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5q7/qnGHECXnMAsSiu6kfEW9Lu5hDXfzSNBv8BWwO64=;
        b=U+NS0fLwy60L6ppJ94BSTC4LQoch4q3RDLZI6pCiUjkYohJ7MR1Z2ECSkEv/S9HVnz
         +DKIsYwtSnYtvTE7xtVXNTicZYgN4jvESV1lJROhA4tXOc2g/J2ZsDdISxaVoNQAJpOr
         UJ+xD5sr1pkyK4kxZ9dTdt2D8JmhvaaeUPop8msHZhyH971/TYdAlZrIRGuJ9SHPS5X8
         GLm5adUi3nxZezp19S+qqXQmjZjAEw6RmVGqbi7XGK0RDunnnZrvZsXQxvNANEF+KT0C
         xAaumGSNA+SfehuSFq318J1+7YtHCVsRCE7nXJU0+KcFh0XTiP93lBBp9QaPgjDZHL7u
         Bpjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=5q7/qnGHECXnMAsSiu6kfEW9Lu5hDXfzSNBv8BWwO64=;
        b=bPq4Vja7euJA0hpL4HL0rQEF+L2PZJ8/IOlr0//uBrY6uNaNs1nkoKgd3hHlELkS8/
         9EcuAEMr6gz3pNlvAXgVtihXBisB4vNFCnaZeWhGs+QUYM3hYqP3ZJSyhSSAU8S7Wbk3
         IOMUCZe3jUCKSPLBeZcw8shazJZFaRKAxz2we2rl4AIg67n0oT/hbIendjsqZHVS58KJ
         77W76mFGAN8/ohmJcBaJF8VNX9W+1k9zs5+NL/lK/p6DguFbEl19yCwaVFs65zh2p5I6
         KJRIu9NsG5E8WOxLJ72JlgEodkm5peky2SV00R7ZEpzQ72hU/gLl4MpUJH2KelgGXLD/
         hORQ==
X-Gm-Message-State: ALoCoQlQZQ7BfBEou5a9I0N8z+ECPCTp/JQpiqv62WE2QCVg4fcfd4oRUKdloduikznFV0AHqMmq
X-Received: by 10.68.227.8 with SMTP id rw8mr29253024pbc.74.1443482062538;
        Mon, 28 Sep 2015 16:14:22 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:79ce:7412:e4be:3e39])
        by smtp.gmail.com with ESMTPSA id gi4sm21482823pbc.4.2015.09.28.16.14.21
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 28 Sep 2015 16:14:22 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.273.g6fa2560.dirty
In-Reply-To: <1443482046-25569-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278801>

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
2.5.0.273.g6fa2560.dirty
