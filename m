From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Teach 'git apply' to look at $GIT_DIR/config
Date: Sat, 17 Feb 2007 13:12:52 -0800
Message-ID: <7v8xewsd2j.fsf@assigned-by-dhcp.cox.net>
References: <7vlkiwsepm.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 17 22:12:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HIWrZ-0007ZK-KK
	for gcvg-git@gmane.org; Sat, 17 Feb 2007 22:12:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932663AbXBQVMy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 17 Feb 2007 16:12:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932915AbXBQVMy
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Feb 2007 16:12:54 -0500
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:32835 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932663AbXBQVMx (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Feb 2007 16:12:53 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070217211253.POGT1306.fed1rmmtao107.cox.net@fed1rmimpo01.cox.net>;
          Sat, 17 Feb 2007 16:12:53 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id QlCs1W00B1kojtg0000000; Sat, 17 Feb 2007 16:12:53 -0500
In-Reply-To: <7vlkiwsepm.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Sat, 17 Feb 2007 12:37:25 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40013>

When neither --index nor --cached was used, git-apply did not
try calling setup_git_directory(), which means it did not look
at configuration files at all.  This fixes it to call the setup
function but still allow the command to be run in a directory
not controlled by git.

The bug probably meant that 'git apply', not moving up to the
toplevel, did not apply properly formatted diffs from the
toplevel when you are inside a subdirectory, even though 'git
apply --index' would.  As a side effect, this patch fixes it as
well.

Signed-off-by: Junio C Hamano <junkio@cox.net>

---

 builtin-apply.c         |   21 +++++++----
 t/t4119-apply-config.sh |   90 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 103 insertions(+), 8 deletions(-)

diff --git a/builtin-apply.c b/builtin-apply.c
index 3fefdac..fc1d673 100644
--- a/builtin-apply.c
+++ b/builtin-apply.c
@@ -2595,9 +2595,18 @@ int cmd_apply(int argc, const char **argv, const char *unused_prefix)
 	int read_stdin = 1;
 	int inaccurate_eof = 0;
 	int errs = 0;
+	int is_not_gitdir = 0;
 
 	const char *whitespace_option = NULL;
 
+	prefix = setup_git_directory_gently(&is_not_gitdir);
+	prefix_length = prefix ? strlen(prefix) : 0;
+	if (!is_not_gitdir) {
+		git_config(git_apply_config);
+		if (apply_default_whitespace)
+			parse_whitespace_option(apply_default_whitespace);
+	}
+
 	for (i = 1; i < argc; i++) {
 		const char *arg = argv[i];
 		char *end;
@@ -2648,10 +2657,14 @@ int cmd_apply(int argc, const char **argv, const char *unused_prefix)
 			continue;
 		}
 		if (!strcmp(arg, "--index")) {
+			if (is_not_gitdir)
+				die("--index outside a repository");
 			check_index = 1;
 			continue;
 		}
 		if (!strcmp(arg, "--cached")) {
+			if (is_not_gitdir)
+				die("--cached outside a repository");
 			check_index = 1;
 			cached = 1;
 			continue;
@@ -2700,14 +2713,6 @@ int cmd_apply(int argc, const char **argv, const char *unused_prefix)
 			inaccurate_eof = 1;
 			continue;
 		}
-
-		if (check_index && prefix_length < 0) {
-			prefix = setup_git_directory();
-			prefix_length = prefix ? strlen(prefix) : 0;
-			git_config(git_apply_config);
-			if (!whitespace_option && apply_default_whitespace)
-				parse_whitespace_option(apply_default_whitespace);
-		}
 		if (0 < prefix_length)
 			arg = prefix_filename(prefix, prefix_length, arg);
 
diff --git a/t/t4119-apply-config.sh b/t/t4119-apply-config.sh
new file mode 100755
index 0000000..0e8ea7e
--- /dev/null
+++ b/t/t4119-apply-config.sh
@@ -0,0 +1,90 @@
+#!/bin/sh
+#
+# Copyright (c) 2007 Junio C Hamano
+#
+
+test_description='git-apply --whitespace=strip and configuration file.
+
+'
+
+. ./test-lib.sh
+
+test_expect_success setup '
+	echo A >file1 &&
+	cp file1 saved &&
+	git add file1 &&
+	echo "B " >file1 &&
+	git diff >patch.file
+'
+
+test_expect_success 'apply --whitespace=strip' '
+
+	cp saved file1 &&
+	git update-index --refresh &&
+
+	git apply --whitespace=strip patch.file &&
+	if grep " " file1
+	then
+		echo "Eh?"
+		false
+	else
+		echo Happy
+	fi
+'
+
+test_expect_success 'apply --whitespace=strip from config' '
+
+	cp saved file1 &&
+	git update-index --refresh &&
+
+	git config apply.whitespace strip &&
+	git apply patch.file &&
+	if grep " " file1
+	then
+		echo "Eh?"
+		false
+	else
+		echo Happy
+	fi
+'
+
+mkdir sub
+D=`pwd`
+
+test_expect_success 'apply --whitespace=strip in subdir' '
+
+	cd "$D" &&
+	git config --unset-all apply.whitespace
+	cp saved file1 &&
+	git update-index --refresh &&
+
+	cd sub &&
+	git apply --whitespace=strip ../patch.file &&
+	if grep " " ../file1
+	then
+		echo "Eh?"
+		false
+	else
+		echo Happy
+	fi
+'
+
+test_expect_success 'apply --whitespace=strip from config in subdir' '
+
+	cd "$D" &&
+	git config apply.whitespace strip &&
+	cp saved file1 &&
+	git update-index --refresh &&
+
+	cd sub &&
+	git apply ../patch.file &&
+	if grep " " file1
+	then
+		echo "Eh?"
+		false
+	else
+		echo Happy
+	fi
+'
+
+test_done
