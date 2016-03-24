From: Pranit Bauva <pranit.bauva@gmail.com>
Subject: [PATCH v9 2/3] t7507-commit-verbose: make test suite use
 write_script
Date: Thu, 24 Mar 2016 08:25:18 +0000
Message-ID: <01020153a7ba4eae-9b88e119-0505-418f-a137-595250edaa9d-000000@eu-west-1.amazonses.com>
References: <01020153a7ba4e07-f326395b-63df-4f8a-b378-8f387b02d0bd-000000@eu-west-1.amazonses.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 24 09:38:18 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aj0mU-0004a5-Co
	for gcvg-git-2@plane.gmane.org; Thu, 24 Mar 2016 09:38:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756812AbcCXIiF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Mar 2016 04:38:05 -0400
Received: from a6-243.smtp-out.eu-west-1.amazonses.com ([54.240.6.243]:38803
	"EHLO a6-243.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752144AbcCXIiE (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 24 Mar 2016 04:38:04 -0400
X-Greylist: delayed 763 seconds by postgrey-1.27 at vger.kernel.org; Thu, 24 Mar 2016 04:38:04 EDT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=ihchhvubuqgjsxyuhssfvqohv7z3u4hn; d=amazonses.com; t=1458807918;
	h=From:To:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
	bh=6QtluxLQS6yFAifUURSa+P2MZa/ZXJkWNHdzZuOl/Ig=;
	b=JNiJ9ulhXNz0jcvPlj4jIiFtN4jymKFPYBDWwfSQc3RUR66RjbWsSYD435YPjqxn
	DChwLrZMWp4fYAg27gXowRxUwKmICMn79UdnBzGerQ7/jjoaf5olcpYWGp8am7yAR0V
	hBg43TFzvuXCHObEwo+tqRjaTSIM7wU1C8SJ6Ktw=
In-Reply-To: <01020153a7ba4e07-f326395b-63df-4f8a-b378-8f387b02d0bd-000000@eu-west-1.amazonses.com>
X-SES-Outgoing: 2016.03.24-54.240.6.243
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289723>

Also remove test_set_editor from global scope and use it in whichever
test it is required.
---
 t/t7507-commit-verbose.sh | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/t/t7507-commit-verbose.sh b/t/t7507-commit-verbose.sh
index 2ddf28c..cf95efb 100755
--- a/t/t7507-commit-verbose.sh
+++ b/t/t7507-commit-verbose.sh
@@ -3,12 +3,11 @@
 test_description='verbose commit template'
 . ./test-lib.sh
 
-cat >check-for-diff <<EOF
-#!$SHELL_PATH
-exec grep '^diff --git' "\$1"
+write_script "check-for-diff" <<-\EOF &&
+grep '^diff --git' "$1" >out &&
+test $(wc -l <out) = 1
 EOF
 chmod +x check-for-diff
-test_set_editor "$PWD/check-for-diff"
 
 cat >message <<'EOF'
 subject
@@ -23,6 +22,7 @@ test_expect_success 'setup' '
 '
 
 test_expect_success 'initial commit shows verbose diff' '
+	test_set_editor "$PWD/check-for-diff" &&
 	git commit --amend -v
 '
 
@@ -38,11 +38,13 @@ check_message() {
 }
 
 test_expect_success 'verbose diff is stripped out' '
+	test_set_editor "$PWD/check-for-diff" &&
 	git commit --amend -v &&
 	check_message message
 '
 
 test_expect_success 'verbose diff is stripped out (mnemonicprefix)' '
+	test_set_editor "$PWD/check-for-diff" &&
 	git config diff.mnemonicprefix true &&
 	git commit --amend -v &&
 	check_message message
@@ -66,11 +68,13 @@ test_expect_success 'diff in message is retained without -v' '
 '
 
 test_expect_success 'diff in message is retained with -v' '
+	test_set_editor "$PWD/check-for-diff" &&
 	git commit --amend -F diff -v &&
 	check_message diff
 '
 
 test_expect_success 'submodule log is stripped out too with -v' '
+	test_set_editor "$PWD/check-for-diff" &&
 	git config diff.submodule log &&
 	git submodule add ./. sub &&
 	git commit -m "sub added" &&

--
https://github.com/git/git/pull/218
