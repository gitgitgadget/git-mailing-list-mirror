From: Pranit Bauva <pranit.bauva@gmail.com>
Subject: [PATCH v12 4/5] t7507-commit-verbose: improve test coverage by
 testing number of diffs
Date: Sat, 2 Apr 2016 23:33:11 +0000
Message-ID: <01020153d952be6c-04f90bd2-291e-4eca-99fd-e897d8601132-000000@eu-west-1.amazonses.com>
References: <01020153d952bd99-d3812bd6-d189-4780-ab48-f015696e9cf0-000000@eu-west-1.amazonses.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 03 01:33:23 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1amV2g-0002Ng-DT
	for gcvg-git-2@plane.gmane.org; Sun, 03 Apr 2016 01:33:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751338AbcDBXdP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Apr 2016 19:33:15 -0400
Received: from a6-243.smtp-out.eu-west-1.amazonses.com ([54.240.6.243]:60995
	"EHLO a6-243.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751041AbcDBXdO (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 2 Apr 2016 19:33:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=ihchhvubuqgjsxyuhssfvqohv7z3u4hn; d=amazonses.com; t=1459639991;
	h=From:To:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
	bh=UVHlwg8Y6D6pnXrLc5Sd1eMIUjViKbXXD2YYXLtvj28=;
	b=XdU+m9xHJKvk+dOLT5ttR3rUe0hH2/crniIIYN7NO2Saamb5VODTrs4izawH/3Dk
	OXu6w442OGqSrM+JfH4F0kvsBFD2u8E8SuFbgJbJmmnQr8BQbQbXRCK6DCyxAsd5INz
	WIZq3qP/9G/i2jPIl6/lHKEJtpqLrfr99UQ6dRBk=
In-Reply-To: <01020153d952bd99-d3812bd6-d189-4780-ab48-f015696e9cf0-000000@eu-west-1.amazonses.com>
X-SES-Outgoing: 2016.04.02-54.240.6.243
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290615>

Make the fake "editor" store output of grep in a file so that we can
see how many diffs were contained in the message and use them in
individual tests where ever it is required. Also use write_script()
to create the fake "editor".

A subsequent commit will introduce scenarios where it is important to be
able to exactly determine how many diffs were present.

Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>

---
Previous version of this patch:
 - [v11] : $gmane/28820
 - [v10]: $gmane/288820

Changes this version wrt previous one:
Include the triple dash which I previously forgot, pointed out by Junio.
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
