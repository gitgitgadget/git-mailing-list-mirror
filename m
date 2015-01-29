From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/1] apply: reject input that touches outside $cwd
Date: Thu, 29 Jan 2015 15:48:14 -0800
Message-ID: <xmqqzj91cfnl.fsf_-_@gitster.dls.corp.google.com>
References: <CA+5PVA7rVy6Li_1haj1QmGG0D6avLB5Xej=2YGt6K-11kKHR5A@mail.gmail.com>
	<CA+5PVA4bs6CYU8MHn1JqBjnb-5wYJT2Tjqa65=v2uSPL8c7dYw@mail.gmail.com>
	<CA+55aFxbY21vBbPs5qCFPT1HSBbaeS+Z2Fr9So1r3rXrMWe_ZQ@mail.gmail.com>
	<xmqqzj94lx7z.fsf@gitster.dls.corp.google.com>
	<xmqqa914klg0.fsf@gitster.dls.corp.google.com>
	<xmqqfvauf7ej.fsf@gitster.dls.corp.google.com>
	<xmqqtwzadrj8.fsf@gitster.dls.corp.google.com>
	<xmqqa911e2ot.fsf_-_@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>, Josh Boyer <jwboyer@fedoraproject.org>,
	"Linux-Kernel\@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
	twaugh@redhat.com, Linus Torvalds <torvalds@linux-foundation.org>
To: Git Mailing List <git@vger.kernel.org>
X-From: linux-kernel-owner@vger.kernel.org Fri Jan 30 00:48:31 2015
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1YGyp2-0000r4-5K
	for glk-linux-kernel-3@plane.gmane.org; Fri, 30 Jan 2015 00:48:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759092AbbA2XsV (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Thu, 29 Jan 2015 18:48:21 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:56454 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751213AbbA2XsR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jan 2015 18:48:17 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 947D434B26;
	Thu, 29 Jan 2015 18:48:16 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=jFEPvDTt1vboLstWzRL1gA6ofJQ=; b=PQadQR
	YRaCbSyrJs5Uyc3QtnfZUwIOYgNa4Po5lBUEfowA6l98pQ0Vmu3YCetrf3JQZKHy
	RGxCMBj/2sqvd+5AbDxai9hLxo4up4HLho4eLVqgLy/j+il99+YnAEb/X12JOLjv
	/zZquJrbdzOXYmtRJW+Wxut4y0uHXVaEaf5f8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=W8cGHEq25RamnWXydSXZznkYwQIPBI1t
	AdqZ4Vr9Th3Nj0bZxim5A2viizat6fQa/3Pdtr0nWTCXAxCiG6DV5QWM39uGAnqT
	bY9BOJLdpxp5QzpKfcS0th9KJymcV3DzJDsrmf0z2f388I0RVJePopMrlV63y1HR
	OpJ4qD4mSgw=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 8AC3934B25;
	Thu, 29 Jan 2015 18:48:16 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id CFD7834B24;
	Thu, 29 Jan 2015 18:48:15 -0500 (EST)
In-Reply-To: <xmqqa911e2ot.fsf_-_@gitster.dls.corp.google.com> (Junio
	C. Hamano's message of "Thu, 29 Jan 2015 12:45:22 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 4B4E4842-A811-11E4-8986-7BA29F42C9D4-77302942!pb-smtp1.pobox.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263166>

By default, a patch that affects outside the working area is
rejected as a mistake; Git itself never creates such a patch
unless the user bends backwards and specifies nonstandard
prefix to "git diff" and friends.

When `git apply` is used without either `--index` or `--cached`
option as a "better GNU patch", the user can pass `--allow-uplevel`
option to override this safety check.  This cannot be used to escape
outside the working tree when using `--index` or `--cached` to apply
the patch to the index.

The new test was stolen from Jeff King with slight enhancements.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * Meant to apply on top of the previous one, but these two are
   about separate and orthogonal issues.

 Documentation/git-apply.txt |  14 ++++-
 builtin/apply.c             |  26 +++++++++
 t/t4139-apply-escape.sh     | 137 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 176 insertions(+), 1 deletion(-)
 create mode 100755 t/t4139-apply-escape.sh

diff --git a/Documentation/git-apply.txt b/Documentation/git-apply.txt
index f605327..20c3a6f 100644
--- a/Documentation/git-apply.txt
+++ b/Documentation/git-apply.txt
@@ -16,7 +16,7 @@ SYNOPSIS
 	  [--ignore-space-change | --ignore-whitespace ]
 	  [--whitespace=(nowarn|warn|fix|error|error-all)]
 	  [--exclude=<path>] [--include=<path>] [--directory=<root>]
-	  [--verbose] [<patch>...]
+	  [--verbose] [--allow-uplevel] [<patch>...]
 
 DESCRIPTION
 -----------
@@ -229,6 +229,18 @@ For example, a patch that talks about updating `a/git-gui.sh` to `b/git-gui.sh`
 can be applied to the file in the working tree `modules/git-gui/git-gui.sh` by
 running `git apply --directory=modules/git-gui`.
 
+--allow-uplevel::
+	By default, a patch that affects outside the working area is
+	rejected as a mistake; Git itself never creates such a patch
+	unless the user bends backwards and specifies nonstandard
+	prefix to "git diff" and friends.
++
+When `git apply` is used without either `--index` or `--cached`
+option as a "better GNU patch", the user can pass `--allow-uplevel`
+option to override this safety check.  This cannot be used to escape
+outside the working tree when using `--index` or `--cached` to apply
+the patch to the index.
+
 Configuration
 -------------
 
diff --git a/builtin/apply.c b/builtin/apply.c
index dcb44fb..ce5a594 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -50,6 +50,7 @@ static int apply_verbosely;
 static int allow_overlap;
 static int no_add;
 static int threeway;
+static int allow_uplevel;
 static const char *fake_ancestor;
 static int line_termination = '\n';
 static unsigned int p_context = UINT_MAX;
@@ -3523,6 +3524,23 @@ symlink_found:
 
 }
 
+static void die_on_uplevel_path(struct patch *patch)
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
@@ -3614,6 +3632,9 @@ static int check_patch(struct patch *patch)
 		return error(_("affected file '%s' is beyond a symbolic link"),
 			     patch->new_name);
 
+	if (!allow_uplevel)
+		die_on_uplevel_path(patch);
+
 	if (apply_data(patch, &st, ce) < 0)
 		return error(_("%s: patch does not apply"), name);
 	patch->rejected = 0;
@@ -4423,6 +4444,8 @@ int cmd_apply(int argc, const char **argv, const char *prefix_)
 			N_("make sure the patch is applicable to the current index")),
 		OPT_BOOL(0, "cached", &cached,
 			N_("apply a patch without touching the working tree")),
+		OPT_BOOL(0, "allow-uplevel", &allow_uplevel,
+			N_("accept a patch to touch outside the current directory")),
 		OPT_BOOL(0, "apply", &force_apply,
 			N_("also apply the patch (use with --stat/--summary/--check)")),
 		OPT_BOOL('3', "3way", &threeway,
@@ -4495,6 +4518,9 @@ int cmd_apply(int argc, const char **argv, const char *prefix_)
 			die(_("--cached outside a repository"));
 		check_index = 1;
 	}
+	if (check_index)
+		allow_uplevel = 0;
+
 	for (i = 0; i < argc; i++) {
 		const char *arg = argv[i];
 		int fd;
diff --git a/t/t4139-apply-escape.sh b/t/t4139-apply-escape.sh
new file mode 100755
index 0000000..39de838
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
+test_expect_success 'can add file containing .. with --allow-uplevel' '
+	mkpatch_add ../foo >patch &&
+	git apply --allow-uplevel patch &&
+	test_path_is_file ../foo
+'
+
+test_expect_success  'cannot add file containing .. (index)' '
+	mkpatch_add ../foo >patch &&
+	test_must_fail git apply --index patch &&
+	test_path_is_missing ../foo
+'
+
+test_expect_success  'cannot add file containing .. with --allow-uplevel (index)' '
+	mkpatch_add ../foo >patch &&
+	test_must_fail git apply --index --allow-uplevel patch &&
+	test_path_is_missing ../foo
+'
+
+test_expect_success 'cannot del file containing ..' '
+	mkpatch_del ../foo >patch &&
+	test_must_fail git apply patch &&
+	test_path_is_file ../foo
+'
+
+test_expect_success 'can del file containing .. with --allow-uplevel' '
+	mkpatch_del ../foo >patch &&
+	git apply --allow-uplevel patch &&
+	test_path_is_missing ../foo
+'
+
+test_expect_success 'cannot del file containing .. (index)' '
+	mkpatch_del ../foo >patch &&
+	test_must_fail git apply --index patch &&
+	test_path_is_file ../foo
+'
+
+test_expect_success 'symlink escape via ..' '
+	{
+		mkpatch_symlink tmp .. &&
+		mkpatch_add tmp/foo ../foo
+	} >patch &&
+	test_must_fail git apply patch &&
+	test_path_is_missing ../foo
+'
+
+test_expect_success 'symlink escape via .. (index)' '
+	{
+		mkpatch_symlink tmp .. &&
+		mkpatch_add tmp/foo ../foo
+	} >patch &&
+	test_must_fail git apply --index patch &&
+	test_path_is_missing ../foo
+'
+
+test_expect_success 'symlink escape via absolute path' '
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
2.3.0-rc2-158-g17413e7
