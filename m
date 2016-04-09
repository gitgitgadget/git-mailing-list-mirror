From: Pranit Bauva <pranit.bauva@gmail.com>
Subject: [PATCH v13 5/6] t7507-commit-verbose: improve test coverage by
 testing number of diffs
Date: Sat, 9 Apr 2016 12:23:20 +0000
Message-ID: <01020153faf9fcc9-b883c097-517a-449f-914e-f3f378d3e6f8-000000@eu-west-1.amazonses.com>
References: <01020153faf9fc14-e6ad18fa-c892-4601-bab7-e2cc4cd9e100-000000@eu-west-1.amazonses.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 09 14:23:38 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aorvL-0004iC-Qa
	for gcvg-git-2@plane.gmane.org; Sat, 09 Apr 2016 14:23:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753409AbcDIMX1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Apr 2016 08:23:27 -0400
Received: from a6-247.smtp-out.eu-west-1.amazonses.com ([54.240.6.247]:51400
	"EHLO a6-247.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753021AbcDIMXX (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 9 Apr 2016 08:23:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=ihchhvubuqgjsxyuhssfvqohv7z3u4hn; d=amazonses.com; t=1460204600;
	h=From:To:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
	bh=pvWIHeUu+EfC8/fGI47nHOya2E+QCxhftwRAEnSvTF4=;
	b=EGSVgIWv2BREXZr0loW9TR+egRpqz6XouJ7oCZ3bnbbyVbUgXZNbQcuVkEcDM/gF
	JoP8X1TezlJrL9tJMju5MwCvPfu9N5n7wswbtOM27RiflAFmYdgdsxqqHzfZ4Mb7mme
	kyLf8lPPeyAyC5t0KV40GS3MUn7+i+1//oc5O+JA=
In-Reply-To: <01020153faf9fc14-e6ad18fa-c892-4601-bab7-e2cc4cd9e100-000000@eu-west-1.amazonses.com>
X-SES-Outgoing: 2016.04.09-54.240.6.247
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291093>

Make the fake "editor" store output of grep in a file so that we can
see how many diffs were contained in the message and use them in
individual tests where ever it is required. A subsequent commit will
introduce scenarios where it is important to be able to exactly
determine how many diffs were present.

Also use write_script() to create the fake "editor".

The fake "editor" is always made to succeed regardless of whether grep
found diff headers or not so that we don't have to use 'test_must_fail'
for which 'test_line_count = 0' is an easy substitute.

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
