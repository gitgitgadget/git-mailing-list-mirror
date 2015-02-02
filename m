From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 1/4] apply: reject input that touches outside $cwd
Date: Mon,  2 Feb 2015 15:27:27 -0800
Message-ID: <1422919650-13346-2-git-send-email-gitster@pobox.com>
References: <1422919650-13346-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 03 00:27:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YIQPB-00034P-Fp
	for gcvg-git-2@plane.gmane.org; Tue, 03 Feb 2015 00:27:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755344AbbBBX1h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Feb 2015 18:27:37 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:64394 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755342AbbBBX1e (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Feb 2015 18:27:34 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 3F6D035A8A;
	Mon,  2 Feb 2015 18:27:34 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=Ca2n
	4mzjlwtw7LYvGNZF3k8BMTE=; b=WldBS/paxQUP8mlRBaGqim8nGWjXtmIWE/lN
	ib6uf3r1xnxv++YmccT2DGYtu5OnxBv4jkUAGD9DUUNH/UeqNUUAVaXnsjTct5SO
	LRSFu+84A9MKyFxmJsKKyQa+qpLtT0eGwSxrw7z1H913dMq1bOvkiOeeUyentrqi
	1scjEVI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=F+N3tS
	SXFqduuID2okGIgZQ5H+k5sboNW6H3fYPX9yU6xq530ei2kcsE3U4g84WRjnkfic
	NfolnO/h+dyk/AnhDkL1KK+RTasPMbVCaSMxnrS+vA0SKD/YQJd9dglQZnF6Cbkf
	d9/L51zHmc35SduWZTjaGLhPyRlJ04ayJAhIw=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 371AE35A89;
	Mon,  2 Feb 2015 18:27:34 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 85D6535A88;
	Mon,  2 Feb 2015 18:27:33 -0500 (EST)
X-Mailer: git-send-email 2.3.0-rc2-166-g7339d96
In-Reply-To: <1422919650-13346-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 107299B0-AB33-11E4-9CD8-7BA29F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263292>

By default, a patch that affects outside the working area is
rejected as a mistake (or a mischief); Git itself does not create
such a patch, unless the user bends backwards and specifies a
non-standard prefix to "git diff" and friends.

When `git apply` is used without either `--index` or `--cached`
option as a "better GNU patch", the user can pass `--unsafe-paths`
option to override this safety check.  This cannot be used to escape
outside the working tree when using `--index` or `--cached` to apply
the patch to the index.

The new test was stolen from Jeff King with slight enhancements.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git-apply.txt |  14 ++++-
 builtin/apply.c             |  26 +++++++++
 t/t4139-apply-escape.sh     | 137 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 176 insertions(+), 1 deletion(-)
 create mode 100755 t/t4139-apply-escape.sh

diff --git a/Documentation/git-apply.txt b/Documentation/git-apply.txt
index f605327..a6e83a9 100644
--- a/Documentation/git-apply.txt
+++ b/Documentation/git-apply.txt
@@ -16,7 +16,7 @@ SYNOPSIS
 	  [--ignore-space-change | --ignore-whitespace ]
 	  [--whitespace=(nowarn|warn|fix|error|error-all)]
 	  [--exclude=<path>] [--include=<path>] [--directory=<root>]
-	  [--verbose] [<patch>...]
+	  [--verbose] [--unsafe-paths] [<patch>...]
 
 DESCRIPTION
 -----------
@@ -229,6 +229,18 @@ For example, a patch that talks about updating `a/git-gui.sh` to `b/git-gui.sh`
 can be applied to the file in the working tree `modules/git-gui/git-gui.sh` by
 running `git apply --directory=modules/git-gui`.
 
+--unsafe-paths::
+	By default, a patch that affects outside the working area is
+	rejected as a mistake (or a mischief); Git itself never
+	creates such a patch unless the user bends backwards and
+	specifies nonstandard prefix to "git diff" and friends.
++
+When `git apply` is used without either `--index` or `--cached`
+option as a "better GNU patch", the user can pass `--unsafe-paths`
+option to override this safety check.  This cannot be used to escape
+outside the working tree when using `--index` or `--cached` to apply
+the patch to the index.
+
 Configuration
 -------------
 
diff --git a/builtin/apply.c b/builtin/apply.c
index ef32e4f..c751ddf 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -50,6 +50,7 @@ static int apply_verbosely;
 static int allow_overlap;
 static int no_add;
 static int threeway;
+static int unsafe_paths;
 static const char *fake_ancestor;
 static int line_termination = '\n';
 static unsigned int p_context = UINT_MAX;
@@ -3483,6 +3484,23 @@ static int check_to_create(const char *new_name, int ok_if_exists)
 	return 0;
 }
 
+static void die_on_unsafe_path(struct patch *patch)
+{
+	const char *old_name = NULL;
+	const char *new_name = NULL;
+	if (patch->is_delete)
+		old_name = patch->old_name;
+	else if (!patch->is_new && !patch->is_copy)
+		old_name = patch->old_name;
+	if (!patch->is_delete)
+		new_name = patch->new_name;
+
+	if (old_name && !verify_path(old_name))
+		die(_("invalid path '%s'"), old_name);
+	if (new_name && !verify_path(new_name))
+		die(_("invalid path '%s'"), new_name);
+}
+
 /*
  * Check and apply the patch in-core; leave the result in patch->result
  * for the caller to write it out to the final destination.
@@ -3570,6 +3588,9 @@ static int check_patch(struct patch *patch)
 		}
 	}
 
+	if (!unsafe_paths)
+		die_on_unsafe_path(patch);
+
 	if (apply_data(patch, &st, ce) < 0)
 		return error(_("%s: patch does not apply"), name);
 	patch->rejected = 0;
@@ -4379,6 +4400,8 @@ int cmd_apply(int argc, const char **argv, const char *prefix_)
 			N_("make sure the patch is applicable to the current index")),
 		OPT_BOOL(0, "cached", &cached,
 			N_("apply a patch without touching the working tree")),
+		OPT_BOOL(0, "unsafe-paths", &unsafe_paths,
+			N_("accept a patch to touch outside the working area")),
 		OPT_BOOL(0, "apply", &force_apply,
 			N_("also apply the patch (use with --stat/--summary/--check)")),
 		OPT_BOOL('3', "3way", &threeway,
@@ -4451,6 +4474,9 @@ int cmd_apply(int argc, const char **argv, const char *prefix_)
 			die(_("--cached outside a repository"));
 		check_index = 1;
 	}
+	if (check_index)
+		unsafe_paths = 0;
+
 	for (i = 0; i < argc; i++) {
 		const char *arg = argv[i];
 		int fd;
diff --git a/t/t4139-apply-escape.sh b/t/t4139-apply-escape.sh
new file mode 100755
index 0000000..5e67179
--- /dev/null
+++ b/t/t4139-apply-escape.sh
@@ -0,0 +1,137 @@
+#!/bin/sh
+
+test_description='paths written by git-apply cannot escape the working tree'
+. ./test-lib.sh
+
+# tests will try to write to ../foo, and we do not
+# want them to escape the trash directory when they
+# fail
+test_expect_success 'bump git repo one level down' '
+	mkdir inside &&
+	mv .git inside/ &&
+	cd inside
+'
+
+# $1 = name of file
+# $2 = current path to file (if different)
+mkpatch_add() {
+	rm -f "${2:-$1}" &&
+	cat <<-EOF
+	diff --git a/$1 b/$1
+	new file mode 100644
+	index 0000000..53c74cd
+	--- /dev/null
+	+++ b/$1
+	@@ -0,0 +1 @@
+	+evil
+	EOF
+}
+
+mkpatch_del() {
+	echo evil >"${2:-$1}" &&
+	cat <<-EOF
+	diff --git a/$1 b/$1
+	deleted file mode 100644
+	index 53c74cd..0000000
+	--- a/$1
+	+++ /dev/null
+	@@ -1 +0,0 @@
+	-evil
+	EOF
+}
+
+# $1 = name of file
+# $2 = content of symlink
+mkpatch_symlink() {
+	rm -f "$1" &&
+	cat <<-EOF
+	diff --git a/$1 b/$1
+	new file mode 120000
+	index 0000000..$(printf "%s" "$2" | git hash-object --stdin)
+	--- /dev/null
+	+++ b/$1
+	@@ -0,0 +1 @@
+	+$2
+	\ No newline at end of file
+	EOF
+}
+
+test_expect_success 'cannot add file containing ..' '
+	mkpatch_add ../foo >patch &&
+	test_must_fail git apply patch &&
+	test_path_is_missing ../foo
+'
+
+test_expect_success 'can add file containing .. with --unsafe-paths' '
+	mkpatch_add ../foo >patch &&
+	git apply --unsafe-paths patch &&
+	test_path_is_file ../foo
+'
+
+test_expect_success  'cannot add file containing .. (index)' '
+	mkpatch_add ../foo >patch &&
+	test_must_fail git apply --index patch &&
+	test_path_is_missing ../foo
+'
+
+test_expect_success  'cannot add file containing .. with --unsafe-paths (index)' '
+	mkpatch_add ../foo >patch &&
+	test_must_fail git apply --index --unsafe-paths patch &&
+	test_path_is_missing ../foo
+'
+
+test_expect_success 'cannot del file containing ..' '
+	mkpatch_del ../foo >patch &&
+	test_must_fail git apply patch &&
+	test_path_is_file ../foo
+'
+
+test_expect_success 'can del file containing .. with --unsafe-paths' '
+	mkpatch_del ../foo >patch &&
+	git apply --unsafe-paths patch &&
+	test_path_is_missing ../foo
+'
+
+test_expect_success 'cannot del file containing .. (index)' '
+	mkpatch_del ../foo >patch &&
+	test_must_fail git apply --index patch &&
+	test_path_is_file ../foo
+'
+
+test_expect_failure 'symlink escape via ..' '
+	{
+		mkpatch_symlink tmp .. &&
+		mkpatch_add tmp/foo ../foo
+	} >patch &&
+	test_must_fail git apply patch &&
+	test_path_is_missing ../foo
+'
+
+test_expect_failure 'symlink escape via .. (index)' '
+	{
+		mkpatch_symlink tmp .. &&
+		mkpatch_add tmp/foo ../foo
+	} >patch &&
+	test_must_fail git apply --index patch &&
+	test_path_is_missing ../foo
+'
+
+test_expect_failure 'symlink escape via absolute path' '
+	{
+		mkpatch_symlink tmp "$(pwd)" &&
+		mkpatch_add tmp/foo ../foo
+	} >patch &&
+	test_must_fail git apply patch &&
+	test_path_is_missing ../foo
+'
+
+test_expect_success 'symlink escape via absolute path (index)' '
+	{
+		mkpatch_symlink tmp "$(pwd)" &&
+		mkpatch_add tmp/foo ../foo
+	} >patch &&
+	test_must_fail git apply --index patch &&
+	test_path_is_missing ../foo
+'
+
+test_done
-- 
2.3.0-rc2-164-g799cdce
