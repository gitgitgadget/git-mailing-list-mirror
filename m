From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v4 1/4] apply: reject input that touches outside the working area
Date: Tue, 10 Feb 2015 14:36:08 -0800
Message-ID: <1423607771-27157-2-git-send-email-gitster@pobox.com>
References: <1423010662-26497-1-git-send-email-gitster@pobox.com>
 <1423607771-27157-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 10 23:36:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YLJPo-0004zW-He
	for gcvg-git-2@plane.gmane.org; Tue, 10 Feb 2015 23:36:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752360AbbBJWgQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Feb 2015 17:36:16 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:52024 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751381AbbBJWgP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Feb 2015 17:36:15 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 2FF573749A;
	Tue, 10 Feb 2015 17:36:15 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=bUIP
	0Mm6zJPbh//zeu6ex7branU=; b=ikGHbc9DeuQdVc9UGqitdVicjIXapI84MqY6
	Fbyi7HUQTtLKltT9WepQDL8LHlV8APTZhz7g4eASoz4GasvXio5AUcmIX5SrJb6d
	PViY3muRkQm8vsM5bOji1JI806YkEXXtGR25OkPqxoEU3nfvvmUZBvFAluw9VecA
	tZWhv3Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=rXAxYg
	tUBCVGwXLrn3GSY8g+JVuJjczbyj3f45NQr20Te5YBvAhWzvL9Y9R0Zif1DHsw9K
	5mIicsz1WLjlLL0wZzGqcNPAHxPJ6/oqaouvK2W0rdgST1hH031MqP+3mg9WrOe3
	q7RZMTPEc3mjCdinM2ap28hM1iud/mOp2cEGo=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 1DE6837498;
	Tue, 10 Feb 2015 17:36:15 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5BFE837497;
	Tue, 10 Feb 2015 17:36:14 -0500 (EST)
X-Mailer: git-send-email 2.3.0-185-g073f588
In-Reply-To: <1423607771-27157-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 3872181C-B175-11E4-A8D7-38A39F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263651>

By default, a patch that affects outside the working area (either a
Git controlled working tree, or the current working directory when
"git apply" is used as a replacement of GNU patch) is rejected as a
mistake (or a mischief).  Git itself does not create such a patch,
unless the user bends over backwards and specifies a non-standard
prefix to "git diff" and friends.

When `git apply` is used as a "better GNU patch", the user can pass
the `--unsafe-paths` option to override this safety check. This
option has no effect when `--index` or `--cached` is in use.

The new test was stolen from Jeff King with slight enhancements.
Note that a few new tests for touching outside the working area by
following a symbolic link are still expected to fail at this step,
but will be fixed in later steps.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git-apply.txt |  12 +++-
 builtin/apply.c             |  26 ++++++++
 t/t4139-apply-escape.sh     | 141 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 178 insertions(+), 1 deletion(-)
 create mode 100755 t/t4139-apply-escape.sh

diff --git a/Documentation/git-apply.txt b/Documentation/git-apply.txt
index f605327..9489664 100644
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
@@ -229,6 +229,16 @@ For example, a patch that talks about updating `a/git-gui.sh` to `b/git-gui.sh`
 can be applied to the file in the working tree `modules/git-gui/git-gui.sh` by
 running `git apply --directory=modules/git-gui`.
 
+--unsafe-paths::
+	By default, a patch that affects outside the working area
+	(either a Git controlled working tree, or the current working
+	directory when "git apply" is used as a replacement of GNU
+	patch) is rejected as a mistake (or a mischief).
++
+When `git apply` is used as a "better GNU patch", the user can pass
+the `--unsafe-paths` option to override this safety check.  This option
+has no effect when `--index` or `--cached` is in use.
+
 Configuration
 -------------
 
diff --git a/builtin/apply.c b/builtin/apply.c
index ef32e4f..8561236 100644
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
+			N_("accept a patch that touches outside the working area")),
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
index 0000000..02b97b3
--- /dev/null
+++ b/t/t4139-apply-escape.sh
@@ -0,0 +1,141 @@
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
+mkpatch_add () {
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
+mkpatch_del () {
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
+mkpatch_symlink () {
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
+test_expect_success 'cannot create file containing ..' '
+	mkpatch_add ../foo >patch &&
+	test_must_fail git apply patch &&
+	test_path_is_missing ../foo
+'
+
+test_expect_success 'can create file containing .. with --unsafe-paths' '
+	mkpatch_add ../foo >patch &&
+	git apply --unsafe-paths patch &&
+	test_path_is_file ../foo
+'
+
+test_expect_success  'cannot create file containing .. (index)' '
+	mkpatch_add ../foo >patch &&
+	test_must_fail git apply --index patch &&
+	test_path_is_missing ../foo
+'
+
+test_expect_success  'cannot create file containing .. with --unsafe-paths (index)' '
+	mkpatch_add ../foo >patch &&
+	test_must_fail git apply --index --unsafe-paths patch &&
+	test_path_is_missing ../foo
+'
+
+test_expect_success 'cannot delete file containing ..' '
+	mkpatch_del ../foo >patch &&
+	test_must_fail git apply patch &&
+	test_path_is_file ../foo
+'
+
+test_expect_success 'can delete file containing .. with --unsafe-paths' '
+	mkpatch_del ../foo >patch &&
+	git apply --unsafe-paths patch &&
+	test_path_is_missing ../foo
+'
+
+test_expect_success 'cannot delete file containing .. (index)' '
+	mkpatch_del ../foo >patch &&
+	test_must_fail git apply --index patch &&
+	test_path_is_file ../foo
+'
+
+test_expect_failure SYMLINKS 'symlink escape via ..' '
+	{
+		mkpatch_symlink tmp .. &&
+		mkpatch_add tmp/foo ../foo
+	} >patch &&
+	test_must_fail git apply patch &&
+	test_path_is_missing tmp &&
+	test_path_is_missing ../foo
+'
+
+test_expect_failure SYMLINKS 'symlink escape via .. (index)' '
+	{
+		mkpatch_symlink tmp .. &&
+		mkpatch_add tmp/foo ../foo
+	} >patch &&
+	test_must_fail git apply --index patch &&
+	test_path_is_missing tmp &&
+	test_path_is_missing ../foo
+'
+
+test_expect_failure SYMLINKS 'symlink escape via absolute path' '
+	{
+		mkpatch_symlink tmp "$(pwd)" &&
+		mkpatch_add tmp/foo ../foo
+	} >patch &&
+	test_must_fail git apply patch &&
+	test_path_is_missing tmp &&
+	test_path_is_missing ../foo
+'
+
+test_expect_failure SYMLINKS 'symlink escape via absolute path (index)' '
+	{
+		mkpatch_symlink tmp "$(pwd)" &&
+		mkpatch_add tmp/foo ../foo
+	} >patch &&
+	test_must_fail git apply --index patch &&
+	test_path_is_missing tmp &&
+	test_path_is_missing ../foo
+'
+
+test_done
-- 
2.3.0-185-g073f588
