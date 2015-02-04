From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 1/4] apply: reject input that touches outside the working area
Date: Tue,  3 Feb 2015 16:44:19 -0800
Message-ID: <1423010662-26497-2-git-send-email-gitster@pobox.com>
References: <1422919650-13346-1-git-send-email-gitster@pobox.com>
 <1423010662-26497-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 04 01:44:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YIo57-0004Wn-5q
	for gcvg-git-2@plane.gmane.org; Wed, 04 Feb 2015 01:44:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966827AbbBDAo3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Feb 2015 19:44:29 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:60028 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752562AbbBDAo0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Feb 2015 19:44:26 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 7E511365D6;
	Tue,  3 Feb 2015 19:44:25 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=pxOY
	6OsjFiL+MCf9OacQpk3Gu3Y=; b=QAmfTq+y6pcPdl1w6vhDcXnxRnsRQuWounKS
	/vgFe+DigJy7uZbD+qqPE9Vmv8tZoCRmqjLdIYdxII0I0JmVX9ewzN5F7PyU0tIo
	eVwAYF1HBZoi9lm/gITUXOed68HlFiz0X5JNQ2xOMsYhagM1Ajo96k84FOPRJFrL
	HcqNxzY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=K2/nPH
	aLuz1aGfpNp3wg+N+Ay++iYo7xC6ONXFiFAvvKDhTsH+JKV508dzqFQ7tyQ8qUFA
	jN2BESICSBFLXgOz9ums7yPAlRUc7rLw2t9Uyg4pfZo+pCoj5mklzwZ1J+zooeqR
	N2G29D20v9UhHhKAImnUsXFjCrLtS/dvBwyMg=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 74B43365D5;
	Tue,  3 Feb 2015 19:44:25 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C5C87365D4;
	Tue,  3 Feb 2015 19:44:24 -0500 (EST)
X-Mailer: git-send-email 2.3.0-rc2-168-g106c876
In-Reply-To: <1423010662-26497-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: F762E7DE-AC06-11E4-8C1E-7BA29F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263343>

By default, a patch that affects outside the working area
(either a Git controlled working tree, or the current working
directory when "git apply" is used as a replacement of GNU
patch) rejected as a mistake (or a mischief); Git itself does
not create such a patch, unless the user bends over backwards
and specifies a non-standard prefix to "git diff" and friends.

When `git apply` is used without either the `--index` or the
`--cached` option as a "better GNU patch", the user can pass
the `--unsafe-paths` option to override this safety check. This
option has no effect when `--index` or `--cached` is in use.

The new test was stolen from Jeff King with slight enhancements.
Note that a few new tests for touching outside the working area by
following a symbolic link are still expected to fail at this step,
but will be fixed in later steps.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * Documentation rephrased with grammofixes courtesy of Peff.

 Documentation/git-apply.txt |  15 ++++-
 builtin/apply.c             |  26 +++++++++
 t/t4139-apply-escape.sh     | 137 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 177 insertions(+), 1 deletion(-)
 create mode 100755 t/t4139-apply-escape.sh

diff --git a/Documentation/git-apply.txt b/Documentation/git-apply.txt
index f605327..a2cdc4a 100644
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
@@ -229,6 +229,19 @@ For example, a patch that talks about updating `a/git-gui.sh` to `b/git-gui.sh`
 can be applied to the file in the working tree `modules/git-gui/git-gui.sh` by
 running `git apply --directory=modules/git-gui`.
 
+--unsafe-paths::
+	By default, a patch that affects outside the working area
+	(either a Git controlled working tree, or the current working
+	directory when "git apply" is used as a replacement of GNU
+	patch) rejected as a mistake (or a mischief); Git itself does
+	not create such a patch, unless the user bends over backwards
+	and specifies a nonstandard prefix to "git diff" and friends.
++
+When `git apply` is used without either the `--index` or the `--cached`
+option as a "better GNU patch", the user can pass the `--unsafe-paths`
+option to override this safety check.  This option has no effect when
+`--index` or `--cached` is in use.
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
2.3.0-rc2-168-g106c876
