From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: [PATCH maint] fetch: Also fetch submodules in subdirectories in on-demand
 mode
Date: Mon, 20 Jun 2011 20:18:03 +0200
Message-ID: <4DFF8EDB.2040502@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 20 20:18:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QYj38-0006Q8-9b
	for gcvg-git-2@lo.gmane.org; Mon, 20 Jun 2011 20:18:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752158Ab1FTSSJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Jun 2011 14:18:09 -0400
Received: from fmmailgate01.web.de ([217.72.192.221]:50042 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752153Ab1FTSSI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Jun 2011 14:18:08 -0400
Received: from smtp01.web.de  ( [172.20.0.243])
	by fmmailgate01.web.de (Postfix) with ESMTP id B4C53191CC9DF;
	Mon, 20 Jun 2011 20:18:06 +0200 (CEST)
Received: from [93.246.56.111] (helo=[192.168.178.43])
	by smtp01.web.de with asmtp (WEB.DE 4.110 #2)
	id 1QYj30-0005G7-00; Mon, 20 Jun 2011 20:18:06 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.2.17) Gecko/20110414 Lightning/1.0b2 Thunderbird/3.1.10
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX199NqCVueN/gl3h1/D4YDtYheo6pGXOwdu+I1KQ
	mFdOXX/eVtiaiajpuKB7oyvkdSUsMwywmMeYpDYM22NKV7wiYX
	4cH18wQHcrRuuz9GwAvw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176083>

When on-demand mode was active examining the new commits just fetched in
the superproject (to check if they record commits for submodules which are
not downloaded yet) wasn't done recursively. Because of that fetch did not
recursively fetch submodules living in subdirectories even when it should
have.

Fix that by adding the RECURSIVE flag to the diff_options used to check
the new commits and avoid future regressions in this area by moving a
submodule in t5526 into a subdirectory.

Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
---

I found this bug after investigating a rather surprising "commits not
present" message at work today. I suspect most submodules live in the
top level directory of their superproject ...


 submodule.c                 |    1 +
 t/t5526-fetch-submodules.sh |   16 ++++++++--------
 2 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/submodule.c b/submodule.c
index 5294cef..e43f221 100644
--- a/submodule.c
+++ b/submodule.c
@@ -362,6 +362,7 @@ void check_for_new_submodule_commits(unsigned char new_sha1[20])
 		while (parent) {
 			struct diff_options diff_opts;
 			diff_setup(&diff_opts);
+			DIFF_OPT_SET(&diff_opts, RECURSIVE);
 			diff_opts.output_format |= DIFF_FORMAT_CALLBACK;
 			diff_opts.format_callback = submodule_collect_changed_cb;
 			if (diff_setup_done(&diff_opts) < 0)
diff --git a/t/t5526-fetch-submodules.sh b/t/t5526-fetch-submodules.sh
index a1fddd4..ca5b027 100755
--- a/t/t5526-fetch-submodules.sh
+++ b/t/t5526-fetch-submodules.sh
@@ -47,7 +47,7 @@ test_expect_success setup '
 		git init &&
 		echo subcontent > subfile &&
 		git add subfile &&
-		git submodule add "$pwd/deepsubmodule" deepsubmodule &&
+		git submodule add "$pwd/deepsubmodule" subdir/deepsubmodule &&
 		git commit -a -m new
 	) &&
 	git submodule add "$pwd/submodule" submodule &&
@@ -58,7 +58,7 @@ test_expect_success setup '
 		git submodule update --init --recursive
 	) &&
 	echo "Fetching submodule submodule" > expect.out &&
-	echo "Fetching submodule submodule/deepsubmodule" >> expect.out
+	echo "Fetching submodule submodule/subdir/deepsubmodule" >> expect.out
 '

 test_expect_success "fetch --recurse-submodules recurses into submodules" '
@@ -277,12 +277,12 @@ test_expect_success "Recursion picks up all submodules when necessary" '
 	(
 		cd submodule &&
 		(
-			cd deepsubmodule &&
+			cd subdir/deepsubmodule &&
 			git fetch &&
 			git checkout -q FETCH_HEAD
 		) &&
 		head1=$(git rev-parse --short HEAD^) &&
-		git add deepsubmodule &&
+		git add subdir/deepsubmodule &&
 		git commit -m "new deepsubmodule"
 		head2=$(git rev-parse --short HEAD) &&
 		echo "From $pwd/submodule" > ../expect.err.sub &&
@@ -309,12 +309,12 @@ test_expect_success "'--recurse-submodules=on-demand' doesn't recurse when no ne
 	(
 		cd submodule &&
 		(
-			cd deepsubmodule &&
+			cd subdir/deepsubmodule &&
 			git fetch &&
 			git checkout -q FETCH_HEAD
 		) &&
 		head1=$(git rev-parse --short HEAD^) &&
-		git add deepsubmodule &&
+		git add subdir/deepsubmodule &&
 		git commit -m "new deepsubmodule"
 		head2=$(git rev-parse --short HEAD) &&
 		echo "From $pwd/submodule" > ../expect.err.sub &&
@@ -345,13 +345,13 @@ test_expect_success "'--recurse-submodules=on-demand' recurses as deep as necess
 		git config fetch.recurseSubmodules false &&
 		(
 			cd submodule &&
-			git config -f .gitmodules submodule.deepsubmodule.fetchRecursive false
+			git config -f .gitmodules submodule.subdir/deepsubmodule.fetchRecursive false
 		) &&
 		git fetch --recurse-submodules=on-demand >../actual.out 2>../actual.err &&
 		git config --unset fetch.recurseSubmodules
 		(
 			cd submodule &&
-			git config --unset -f .gitmodules submodule.deepsubmodule.fetchRecursive
+			git config --unset -f .gitmodules submodule.subdir/deepsubmodule.fetchRecursive
 		)
 	) &&
 	test_i18ncmp expect.out actual.out &&
-- 
1.7.5.4.3.ge9634
