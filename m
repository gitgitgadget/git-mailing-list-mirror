From: Pranit Bauva <pranit.bauva@gmail.com>
Subject: [PATCH v14 5/6] t7507-commit-verbose: improve test coverage by
 testing number of diffs
Date: Tue, 12 Apr 2016 23:02:17 +0000
Message-ID: <010201540cb6096f-5d2150af-6595-4d88-85e5-18eaeb699fb7-000000@eu-west-1.amazonses.com>
References: <010201540cb60832-9402a692-3caa-47a1-9e8e-ae5a1bc7eb2f-000000@eu-west-1.amazonses.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 13 01:02:42 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aq7KS-0002iZ-AT
	for gcvg-git-2@plane.gmane.org; Wed, 13 Apr 2016 01:02:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965441AbcDLXC1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Apr 2016 19:02:27 -0400
Received: from a7-12.smtp-out.eu-west-1.amazonses.com ([54.240.7.12]:55994
	"EHLO a7-12.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S934391AbcDLXCT (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 12 Apr 2016 19:02:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=ihchhvubuqgjsxyuhssfvqohv7z3u4hn; d=amazonses.com; t=1460502137;
	h=From:To:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
	bh=u5FIt2Ac872Mk0ag/2ezL+izC3c8ZktlXQTH9Z/HbwA=;
	b=LCow+cylSNYlmjm0PjtUGPWFiIrasI9LqRQ9o97cpJJ/aqUWeZWHAdyy9E71Ln/m
	X2p/Dt3mV69PaSJdKsWAM6egEIyBxCRU0E9/QtCsgorI8Z/SMVUfnp5VMFEvBRIwwJV
	jTzXIQWQ0nS3Rneoaf610YLAkEPY5XmGs6LdcTEo=
In-Reply-To: <010201540cb60832-9402a692-3caa-47a1-9e8e-ae5a1bc7eb2f-000000@eu-west-1.amazonses.com>
X-SES-Outgoing: 2016.04.12-54.240.7.12
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291314>

Make the fake "editor" store output of grep in a file so that we can
see how many diffs were contained in the message and use them in
individual tests where ever it is required. A subsequent commit will
introduce scenarios where it is important to be able to exactly
determine how many diffs were present.

Also use write_script() to create the fake "editor".

The fake "editor" is always made to succeed regardless of whether grep
found diff headers or not so that we don't have to use 'test_must_fail'
for which 'test_line_count = 0' is an easy substitute and also helps in
maintaining the consistency.

Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>

---
Previous version of this patch:
 - [v12] : $gmane/288820
 - [v11] : $gmane/288820
 - [v10]: $gmane/288820

Changes this version wrt previous one:
Change the commit message as suggested by Eric
---
 t/t7507-commit-verbose.sh | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/t/t7507-commit-verbose.sh b/t/t7507-commit-verbose.sh
index 2ddf28c..0f28a86 100755
--- a/t/t7507-commit-verbose.sh
+++ b/t/t7507-commit-verbose.sh
@@ -3,11 +3,10 @@
 test_description='verbose commit template'
 . ./test-lib.sh
 
-cat >check-for-diff <<EOF
-#!$SHELL_PATH
-exec grep '^diff --git' "\$1"
+write_script "check-for-diff" <<\EOF &&
+grep '^diff --git' "$1" >out
+exit 0
 EOF
-chmod +x check-for-diff
 test_set_editor "$PWD/check-for-diff"
 
 cat >message <<'EOF'
@@ -23,7 +22,8 @@ test_expect_success 'setup' '
 '
 
 test_expect_success 'initial commit shows verbose diff' '
-	git commit --amend -v
+	git commit --amend -v &&
+	test_line_count = 1 out
 '
 
 test_expect_success 'second commit' '
@@ -39,13 +39,15 @@ check_message() {
 
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
