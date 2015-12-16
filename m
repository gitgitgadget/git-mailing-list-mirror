From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv2 1/7] submodule.c: write "Fetching submodule <foo>" to stderr
Date: Tue, 15 Dec 2015 16:04:06 -0800
Message-ID: <1450224252-16833-2-git-send-email-sbeller@google.com>
References: <1450224252-16833-1-git-send-email-sbeller@google.com>
Cc: peff@peff.net, jrnieder@gmail.com, johannes.schindelin@gmail.com,
	Jens.Lehmann@web.de, ericsunshine@gmail.com, j6t@kdbg.org,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Dec 16 01:04:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a8za1-0005ka-SH
	for gcvg-git-2@plane.gmane.org; Wed, 16 Dec 2015 01:04:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932651AbbLPAEW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Dec 2015 19:04:22 -0500
Received: from mail-pa0-f52.google.com ([209.85.220.52]:34710 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754372AbbLPAEV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Dec 2015 19:04:21 -0500
Received: by mail-pa0-f52.google.com with SMTP id wq6so13370045pac.1
        for <git@vger.kernel.org>; Tue, 15 Dec 2015 16:04:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pQm2Wdd92mxHaFlLQhzXzrp3VGrt447i7xNR5XiCntY=;
        b=nOqkXqZ29i6V4+sx9P+wmFI0rHZPsFHJ7vjs31XXjpL+uh5hnDq64dEzmqMD0xL3Fh
         PzTVNODm1P8N5142V6Rt3aoQVgKyu1K3wMoOnAm8RFT2rsDD/1sIJWLTWq6tJxq/VTWL
         Gvetba06ssDZnH2bapqsy4HEFni8Wz2VfWJFiMrOL2bUS7vI4yMPIdLcYrCsugIvUTxD
         8aV4ljKimx7l+OC4sQkzAphKNqXDAspbHAJQF/Fy5xySgU9XXn4kZX126v6lFi9x63UN
         HBJlDRP+pLI/uzAhNW7ND7haLcCjO0wh++Sltb16/vdLdBdJxHrbqJkUeSDNyf5+iAIy
         y/Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=pQm2Wdd92mxHaFlLQhzXzrp3VGrt447i7xNR5XiCntY=;
        b=iyaXuH06pE5tPIpxbrPXWgdCl/qEo9cs4OcbHoUV22v7FGp7CcFAgcTQQ7VC7FV53m
         BIHh7pGNCUNuW2YqCgV5co2qFo8HynDzCqrbQEt29iJFfp/49IOrNOotCvSEAxHwk9yx
         7H32izhFJfHlbykxhOzFjVI5SeWb4w2MFCUQakbbPqseMbRdMkHTmKLm7WqhQ7Pn5BIe
         Zu/bV/99Tv6PF0s54kwX6T96fGVJpsVABCeYzlRj0Apv4kgfV8g4/aAyeodMsnP9zMdY
         HjQdWIYty7NbTg1YJG9y9ptbwfdYkjUstzOqtpbIM4UpF1zfvPFwwgPWfMY8n8cegaL8
         s/8w==
X-Gm-Message-State: ALoCoQm+txHi6I5UIixJ+jU4+uLRKD5mIAGI8+ztQQAT22kpMRqUWICiD1jC/4h0B14q0BOIZmlOHgTwU42BiwruCgnnmfBaSQ==
X-Received: by 10.66.90.234 with SMTP id bz10mr59160499pab.115.1450224260695;
        Tue, 15 Dec 2015 16:04:20 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:a171:258:4778:14b4])
        by smtp.gmail.com with ESMTPSA id fe6sm4731593pab.40.2015.12.15.16.04.19
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 15 Dec 2015 16:04:19 -0800 (PST)
X-Mailer: git-send-email 2.6.4.443.ge094245.dirty
In-Reply-To: <1450224252-16833-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282517>

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
index 14e7624..8386477 100644
--- a/submodule.c
+++ b/submodule.c
@@ -689,7 +689,7 @@ int fetch_populated_submodules(const struct argv_array *options,
 			git_dir = submodule_git_dir.buf;
 		if (is_directory(git_dir)) {
 			if (!quiet)
-				printf("Fetching submodule %s%s\n", prefix, ce->name);
+				fprintf(stderr, "Fetching submodule %s%s\n", prefix, ce->name);
 			cp.dir = submodule_path.buf;
 			argv_array_push(&argv, default_argv);
 			argv_array_push(&argv, "--submodule-prefix");
diff --git a/t/t5526-fetch-submodules.sh b/t/t5526-fetch-submodules.sh
index a4532b0..17759b14 100755
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
2.6.4.443.ge094245.dirty
