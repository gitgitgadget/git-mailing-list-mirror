From: Sudhanshu Shekhar <sudshekhar02@gmail.com>
Subject: [PATCH 1/2] reset: allow "-" short hand for previous commit
Date: Sun,  8 Mar 2015 02:34:04 +0530
Message-ID: <1425762244-8629-1-git-send-email-sudshekhar02@gmail.com>
References: <xmqq1tl4705j.fsf@gitster.dls.corp.google.com>
Cc: Matthieu.Moy@grenoble-inp.fr, gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 07 22:04:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YULtY-0003Vc-Kd
	for gcvg-git-2@plane.gmane.org; Sat, 07 Mar 2015 22:04:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752766AbbCGVET (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Mar 2015 16:04:19 -0500
Received: from mail-pd0-f172.google.com ([209.85.192.172]:41410 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752693AbbCGVET (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Mar 2015 16:04:19 -0500
Received: by pdjy10 with SMTP id y10so14521154pdj.8
        for <git@vger.kernel.org>; Sat, 07 Mar 2015 13:04:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gRrpD7FwL1F2PcUaAX2F/qnomBz/ww/3DsS717QYVM8=;
        b=LPREHnvHyC72oWEqeAIMbKqrI5zLORdtcSSj/YRqpCYEcV+QRF1BdCKu4g9Lf12sTJ
         zn2fHbjOHjueQ8Cd2elDJUOVNB1yj2Ninb/9jpEjSC69cmuaamk8jxIbK47A6R2En1Lh
         MUF6Oa+6w0bCJ7VVRNARgBXH5G6FjAqfucrIW5SeZqmEaDE0WlJ/M9nGVh1NBJjqnf8Q
         c6rrcwm28eqH4sll1yJz3RNmkx38R9AHY4PpsuNuV6OWvXGJRYBZKTUneIpTpy3VUQY2
         hJ4ohLv8Uo+ufQ5uYxecEjYyocMDZ0RIs39EZQCUemBs8TFA+Pr3QHcPr4SzSKSPGeXQ
         67eg==
X-Received: by 10.68.215.65 with SMTP id og1mr37692393pbc.79.1425762258819;
        Sat, 07 Mar 2015 13:04:18 -0800 (PST)
Received: from shekhar-Inspiron-N5110.iiit.ac.in ([14.139.82.6])
        by mx.google.com with ESMTPSA id vf6sm13158482pbc.18.2015.03.07.13.04.14
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 07 Mar 2015 13:04:16 -0800 (PST)
X-Mailer: git-send-email 2.3.1.168.g0c82976.dirty
In-Reply-To: <xmqq1tl4705j.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265003>

Teach reset the same shorthand as checkout and merge. "-" means the
"previous commit".

Signed-off-by: Sudhanshu Shekhar <sudshekhar02@gmail.com>
---
 builtin/reset.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/builtin/reset.c b/builtin/reset.c
index 4c08ddc..9f8967d 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -192,6 +192,7 @@ static void parse_args(struct pathspec *pathspec,
 {
 	const char *rev = "HEAD";
 	unsigned char unused[20];
+	int substituted_minus = 0;
 	/*
 	 * Possible arguments are:
 	 *
@@ -205,6 +206,10 @@ static void parse_args(struct pathspec *pathspec,
 	 */
 
 	if (argv[0]) {
+		if(!strcmp(argv[0], "-")) {
+			argv[0] = "@{-1}";
+			substituted_minus = 1;
+		}
 		if (!strcmp(argv[0], "--")) {
 			argv++; /* reset to HEAD, possibly with paths */
 		} else if (argv[1] && !strcmp(argv[1], "--")) {
@@ -225,12 +230,14 @@ static void parse_args(struct pathspec *pathspec,
 			verify_non_filename(prefix, argv[0]);
 			rev = *argv++;
 		} else {
+			/* We were treating "-" as a commit and not a file */
+			if(substituted_minus)
+				argv[0] = "-";
 			/* Otherwise we treat this as a filename */
 			verify_filename(prefix, argv[0], 1);
 		}
 	}
 	*rev_ret = rev;
-
 	if (read_cache() < 0)
 		die(_("index file corrupt"));
 
-- 
2.3.1.168.g0c82976.dirty


>From 21f0298c17768aaa11ff0a677cdefc8f54ac9515 Mon Sep 17 00:00:00 2001
From: Sudhanshu Shekhar <sudshekhar02@gmail.com>
Date: Sun, 8 Mar 2015 02:13:57 +0530
Subject: [PATCH 2/2] Added test cases for reset -

Four test cases have been added

1) when user does reset - without any previous branch => Leads to error
2) when user does reset - with a previous branch      => Ensure it
behaves like @{-1}

Other two deal with the situation when we have a file named '-'. We
ignore such a file and - is always treated either as a previous branch
or a bad filename. Users who wish to reset a file named '-' should specify
it as './-'
---
 builtin/reset.c  |  4 ++--
 t/t7102-reset.sh | 62 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 64 insertions(+), 2 deletions(-)

diff --git a/builtin/reset.c b/builtin/reset.c
index 9f8967d..02f33ef 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -206,7 +206,7 @@ static void parse_args(struct pathspec *pathspec,
 	 */
 
 	if (argv[0]) {
-		if(!strcmp(argv[0], "-")) {
+		if (!strcmp(argv[0], "-")) {
 			argv[0] = "@{-1}";
 			substituted_minus = 1;
 		}
@@ -231,7 +231,7 @@ static void parse_args(struct pathspec *pathspec,
 			rev = *argv++;
 		} else {
 			/* We were treating "-" as a commit and not a file */
-			if(substituted_minus)
+			if (substituted_minus)
 				argv[0] = "-";
 			/* Otherwise we treat this as a filename */
 			verify_filename(prefix, argv[0], 1);
diff --git a/t/t7102-reset.sh b/t/t7102-reset.sh
index 98bcfe2..4b8d7f5 100755
--- a/t/t7102-reset.sh
+++ b/t/t7102-reset.sh
@@ -568,4 +568,66 @@ test_expect_success 'reset --mixed sets up work tree' '
 	test_cmp expect actual
 '
 
+cat > expect << EOF
+fatal: bad flag '-' used after filename
+EOF
+
+test_expect_success 'reset - with no previous branch' '
+	git init no_previous --quiet &&
+	(
+	cd no_previous
+	) &&
+	test_must_fail git reset - 2> output &&
+	test_cmp expect output
+'
+
+test_expect_success 'reset - while having file named - and no previous branch' '
+	git init no_previous --quiet &&
+	(
+	cd no_previous &&
+	touch ./-
+	) &&
+	test_must_fail git reset - 2> output &&
+	test_cmp expect output
+'
+
+cat > expect << EOF
+Unstaged changes after reset:
+M	-
+M	1
+EOF
+
+test_expect_success 'reset - in the prescence of file named - with previou branch' '
+	git init no_previous --quiet &&
+	cd no_previous &&
+	touch ./- 1 &&
+	git add 1 - &&
+	git commit -m "add base files" &&
+	git checkout -b new_branch &&
+	echo "random" > ./- &&
+	echo "wow" > 1 &&
+	git add 1 - &&
+	git reset - > output &&
+	test_cmp output ../expect
+'
+test_expect_success 'reset - works same as reset @{-1}' '
+	git init no_previous --quiet &&
+	cd no_previous &&
+	echo "random" > random &&
+	git add random &&
+	git commit -m "base commit" &&
+	git checkout -b temp &&
+	echo new-file > new-file &&
+	git add new-file &&
+	git commit -m "added new-file" &&
+	git reset - &&
+
+	git status > ../first &&
+	git add new-file &&
+	git commit -m "added new-file" &&
+	git reset @{-1} &&
+	git status > ../second &&
+	test_cmp ../first ../second
+'
+
 test_done
-- 
2.3.1.168.g0c82976.dirty
