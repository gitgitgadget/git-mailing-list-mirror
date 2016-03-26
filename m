From: Pranit Bauva <pranit.bauva@gmail.com>
Subject: [PATCH v10 2/3] t7507-commit-verbose: store output of grep in a
 file
Date: Sat, 26 Mar 2016 19:48:49 +0000
Message-ID: <01020153b478cf9b-1417ac08-005c-4d72-91f1-0b07f00a24d5-000000@eu-west-1.amazonses.com>
References: <01020153b478cf07-758c7f14-33a1-4a67-9bc9-4688de3d6742-000000@eu-west-1.amazonses.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 26 21:09:48 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ajuWp-0007n5-Vf
	for gcvg-git-2@plane.gmane.org; Sat, 26 Mar 2016 21:09:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754165AbcCZUJo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Mar 2016 16:09:44 -0400
Received: from a6-245.smtp-out.eu-west-1.amazonses.com ([54.240.6.245]:46321
	"EHLO a6-245.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754072AbcCZUJm (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 26 Mar 2016 16:09:42 -0400
X-Greylist: delayed 1251 seconds by postgrey-1.27 at vger.kernel.org; Sat, 26 Mar 2016 16:09:42 EDT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=ihchhvubuqgjsxyuhssfvqohv7z3u4hn; d=amazonses.com; t=1459021729;
	h=From:To:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
	bh=FPOU6bMUnHqB4Ogs14MOixJ6tWoPNW0Bsat4/X4jRXQ=;
	b=SQfwp8h8SJJMzmDrLt6EV8vPxd1/RhcpPzgPATfzoS2YVA0Acyk7Hcyw3OoqPorX
	dcNXLros3zmoBjwICPcKs6d2gpqDLDUrX8QKPjqO+IUgojhKEb0D5koiC4VHPQUMkgA
	58jaf4aFcK5k5AyY8MBmSRyrx18Zs2DNQOqct6/4=
In-Reply-To: <01020153b478cf07-758c7f14-33a1-4a67-9bc9-4688de3d6742-000000@eu-west-1.amazonses.com>
X-SES-Outgoing: 2016.03.26-54.240.6.245
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289987>

So that we can see how many diffs were contained in the message and use
them in individual tests where ever it is required. Also use
write_script() to create the fake "editor".

Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
---
 t/t7507-commit-verbose.sh | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/t/t7507-commit-verbose.sh b/t/t7507-commit-verbose.sh
index 2ddf28c..b40eb3c 100755
--- a/t/t7507-commit-verbose.sh
+++ b/t/t7507-commit-verbose.sh
@@ -3,9 +3,11 @@
 test_description='verbose commit template'
 . ./test-lib.sh
 
-cat >check-for-diff <<EOF
-#!$SHELL_PATH
-exec grep '^diff --git' "\$1"
+write_script "check-for-diff" <<'EOF' &&
+! test -s out ||
+rm out &&
+! grep '^diff --git' "$1" ||
+grep '^diff --git' "$1" >out
 EOF
 chmod +x check-for-diff
 test_set_editor "$PWD/check-for-diff"
@@ -23,7 +25,8 @@ test_expect_success 'setup' '
 '
 
 test_expect_success 'initial commit shows verbose diff' '
-	git commit --amend -v
+	git commit --amend -v &&
+	test_line_count = 1 out
 '
 
 test_expect_success 'second commit' '
@@ -39,13 +42,15 @@ check_message() {
 
 test_expect_success 'verbose diff is stripped out' '
 	git commit --amend -v &&
-	check_message message
+	check_message message &&
+	test_line_count = 1 out
 '
 
 test_expect_success 'verbose diff is stripped out (mnemonicprefix)' '
 	git config diff.mnemonicprefix true &&
 	git commit --amend -v &&
-	check_message message
+	check_message message &&
+	test_line_count = 1 out
 '
 
 cat >diff <<'EOF'

--
https://github.com/git/git/pull/218
