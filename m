From: Pranit Bauva <pranit.bauva@gmail.com>
Subject: [PATCH v11 3/4] t7507-commit-verbose: improve test coverage by
 testing number of diffs
Date: Thu, 31 Mar 2016 14:45:53 +0000
Message-ID: <01020153cd2341ef-eed17644-85ee-4d1d-8051-b5d56bd9ae52-000000@eu-west-1.amazonses.com>
References: <01020153cd2340f8-4665cd5f-cd5c-41ab-a162-20acc43ca52e-000000@eu-west-1.amazonses.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 31 16:54:52 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aldzl-0000aK-IR
	for gcvg-git-2@plane.gmane.org; Thu, 31 Mar 2016 16:54:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757147AbcCaOyp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Mar 2016 10:54:45 -0400
Received: from a7-17.smtp-out.eu-west-1.amazonses.com ([54.240.7.17]:47193
	"EHLO a7-17.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757137AbcCaOyp (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 31 Mar 2016 10:54:45 -0400
X-Greylist: delayed 529 seconds by postgrey-1.27 at vger.kernel.org; Thu, 31 Mar 2016 10:54:44 EDT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=ihchhvubuqgjsxyuhssfvqohv7z3u4hn; d=amazonses.com; t=1459435553;
	h=From:To:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
	bh=OJguRN8ffi2IJZamecFVN0amuNFXvTn2JoPX0ddrBVU=;
	b=MSjoA9YQnXAe06jG9HEqUb+2ewQE2EGkdx8hzDbIHZDMsY+gMxqjtDSt0yMtodbH
	gx5SmVSSGTBN3mOI+qeOvmRYtXOSsYe9km12m4vlW/ZU6waQuekY4o+9/U42p9uds2x
	Vj1t1cz1ROMnfiLD4JXIHXEN66TvXTorxmOTRpj0=
In-Reply-To: <01020153cd2340f8-4665cd5f-cd5c-41ab-a162-20acc43ca52e-000000@eu-west-1.amazonses.com>
X-SES-Outgoing: 2016.03.31-54.240.7.17
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290395>

Make the fake "editor" store output of grep in a file so that we can
see how many diffs were contained in the message and use them in
individual tests where ever it is required. Also use write_script()
to create the fake "editor".

A subsequent commit will introduce scenarios where it is important to be
able to exactly determine how many diffs were present.

Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>

Previous version of this patch:
 - [v10]: $gmane/288820

Changes this version wrt previous one:
I decided to include no of diffs in every test and rewrote the commit
message so as to sell this idea. This was given as an option to me by
Eric and the other option being to drop unnecessary testing of lines
where it isn't required. Also this patch uses a suggestion given by Eric
to make the "editor" look more clean as compared to the editor in my
previous version.
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
