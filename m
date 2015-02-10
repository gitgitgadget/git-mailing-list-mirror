From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v4 4/4] apply: do not touch a file beyond a symbolic link
Date: Tue, 10 Feb 2015 14:36:11 -0800
Message-ID: <1423607771-27157-5-git-send-email-gitster@pobox.com>
References: <1423010662-26497-1-git-send-email-gitster@pobox.com>
 <1423607771-27157-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 10 23:36:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YLJPv-000540-Nu
	for gcvg-git-2@plane.gmane.org; Tue, 10 Feb 2015 23:36:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754318AbbBJWgZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Feb 2015 17:36:25 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:64316 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752370AbbBJWgY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Feb 2015 17:36:24 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 72979374AD;
	Tue, 10 Feb 2015 17:36:23 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=qi6q
	L66CvL/KLuLCbGrDqTdoGCo=; b=ooUNQJgAiKqhy7atQs0aqoRb07DM6+mg5MW1
	mK2tdYj4l6lcFLWI6Tvqa9yTTcmFuLmUsQJRMWvrJzTAr5PFMeu+qXFvIWcKUpa+
	PAaWpkVTG2aNdzD5BspACIzxTa22AQkGaIyS0bgKl8PEEP1vA3CJQQGP/j2unSTq
	3z1Mi/4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=YgrYz8
	iakC35H4POySrc7rAcSDzB2LqG/qMa7GhBftXO0YyoNLQNQuSsxKrStqFdRPsrVw
	LRB2FXy5FyrFAOe8YGsBcyEqlP1Cy1Tw8kkL5zDy6DOou48IK5VbLoQkOpgahe6/
	lwuC715v6qTLCUov/RYOPq69Gvl31PDHYx5tw=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 67E7B374A6;
	Tue, 10 Feb 2015 17:36:23 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A7B95374A4;
	Tue, 10 Feb 2015 17:36:19 -0500 (EST)
X-Mailer: git-send-email 2.3.0-185-g073f588
In-Reply-To: <1423607771-27157-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 3B966002-B175-11E4-956F-38A39F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263653>

Because Git tracks symbolic links as symbolic links, a path that
has a symbolic link in its leading part (e.g. path/to/dir/file,
where path/to/dir is a symbolic link to somewhere else, be it
inside or outside the working tree) can never appear in a patch
that validly applies, unless the same patch first removes the
symbolic link to allow a directory to be created there.

Detect and reject such a patch.

Things to note:

 - Unfortunately, we cannot reuse the has_symlink_leading_path()
   from dir.c, as that is only about the working tree, but "git
   apply" can be told to apply the patch only to the index or to
   both the index and to the working tree.

 - We cannot directly use has_symlink_leading_path() even when we
   are applying only to the working tree, as an early patch of a
   valid input may remove a symbolic link path/to/dir and then a
   later patch of the input may create a path path/to/dir/file, but
   "git apply" first checks the input without touching either the
   index or the working tree.  The leading symbolic link check must
   be done on the interim result we compute in-core (i.e. after the
   first patch, there is no path/to/dir symbolic link and it is
   perfectly valid to create path/to/dir/file).

   Similarly, when an input creates a symbolic link path/to/dir and
   then creates a file path/to/dir/file, we need to flag it as an
   error without actually creating path/to/dir symbolic link in the
   filesystem.

Instead, for any patch in the input that leaves a path (i.e. a non
deletion) in the result, we check all leading paths against the
resulting tree that the patch would create by inspecting all the
patches in the input and then the target of patch application
(either the index or the working tree).

This way, we catch a mischief or a mistake to add a symbolic link
path/to/dir and a file path/to/dir/file at the same time, while
allowing a valid patch that removes a symbolic link path/to/dir and
then adds a file path/to/dir/file.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/apply.c                 | 112 ++++++++++++++++++++++++++++++++++++++++
 t/t4122-apply-symlink-inside.sh |  87 +++++++++++++++++++++++++++++++
 t/t4139-apply-escape.sh         |   8 +--
 3 files changed, 203 insertions(+), 4 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 422e4ce..c2c6fda 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -3486,6 +3486,104 @@ static int check_to_create(const char *new_name, int ok_if_exists)
 	return 0;
 }
 
+/*
+ * We need to keep track of how symlinks in the preimage are
+ * manipulated by the patches.  A patch to add a/b/c where a/b
+ * is a symlink should not be allowed to affect the directory
+ * the symlink points at, but if the same patch removes a/b,
+ * it is perfectly fine, as the patch removes a/b to make room
+ * to create a directory a/b so that a/b/c can be created.
+ */
+static struct string_list symlink_changes;
+#define SYMLINK_GOES_AWAY 01
+#define SYMLINK_IN_RESULT 02
+
+static uintptr_t register_symlink_changes(const char *path, uintptr_t what)
+{
+	struct string_list_item *ent;
+
+	ent = string_list_lookup(&symlink_changes, path);
+	if (!ent) {
+		ent = string_list_insert(&symlink_changes, path);
+		ent->util = (void *)0;
+	}
+	ent->util = (void *)(what | ((uintptr_t)ent->util));
+	return (uintptr_t)ent->util;
+}
+
+static uintptr_t check_symlink_changes(const char *path)
+{
+	struct string_list_item *ent;
+
+	ent = string_list_lookup(&symlink_changes, path);
+	if (!ent)
+		return 0;
+	return (uintptr_t)ent->util;
+}
+
+static void prepare_symlink_changes(struct patch *patch)
+{
+	for ( ; patch; patch = patch->next) {
+		if ((patch->old_name && S_ISLNK(patch->old_mode)) &&
+		    (patch->is_rename || patch->is_delete))
+			/* the symlink at patch->old_name is removed */
+			register_symlink_changes(patch->old_name, SYMLINK_GOES_AWAY);
+
+		if (patch->new_name && S_ISLNK(patch->new_mode))
+			/* the symlink at patch->new_name is created or remains */
+			register_symlink_changes(patch->new_name, SYMLINK_IN_RESULT);
+	}
+}
+
+static int path_is_beyond_symlink_1(struct strbuf *name)
+{
+	do {
+		unsigned int change;
+
+		while (--name->len && name->buf[name->len] != '/')
+			; /* scan backwards */
+		if (!name->len)
+			break;
+		name->buf[name->len] = '\0';
+		change = check_symlink_changes(name->buf);
+		if (change & SYMLINK_IN_RESULT)
+			return 1;
+		if (change & SYMLINK_GOES_AWAY)
+			/*
+			 * This cannot be "return 0", because we may
+			 * see a new one created at a higher level.
+			 */
+			continue;
+
+		/* otherwise, check the preimage */
+		if (check_index) {
+			struct cache_entry *ce;
+
+			ce = cache_file_exists(name->buf, name->len, ignore_case);
+			if (ce && S_ISLNK(ce->ce_mode))
+				return 1;
+		} else {
+			struct stat st;
+			if (!lstat(name->buf, &st) && S_ISLNK(st.st_mode))
+				return 1;
+		}
+	} while (1);
+	return 0;
+}
+
+static int path_is_beyond_symlink(const char *name_)
+{
+	int ret;
+	struct strbuf name = STRBUF_INIT;
+
+	assert(*name_ != '\0');
+	strbuf_addstr(&name, name_);
+	ret = path_is_beyond_symlink_1(&name);
+	strbuf_release(&name);
+
+	return ret;
+}
+
 static void die_on_unsafe_path(struct patch *patch)
 {
 	const char *old_name = NULL;
@@ -3593,6 +3691,19 @@ static int check_patch(struct patch *patch)
 	if (!unsafe_paths)
 		die_on_unsafe_path(patch);
 
+	/*
+	 * An attempt to read from or delete a path that is beyond a
+	 * symbolic link will be prevented by load_patch_target() that
+	 * is called at the beginning of apply_data() so we do not
+	 * have to worry about a patch marked with "is_delete" bit
+	 * here.  We however need to make sure that the patch result
+	 * is not deposited to a path that is beyond a symbolic link
+	 * here.
+	 */
+	if (!patch->is_delete && path_is_beyond_symlink(patch->new_name))
+		return error(_("affected file '%s' is beyond a symbolic link"),
+			     patch->new_name);
+
 	if (apply_data(patch, &st, ce) < 0)
 		return error(_("%s: patch does not apply"), name);
 	patch->rejected = 0;
@@ -3603,6 +3714,7 @@ static int check_patch_list(struct patch *patch)
 {
 	int err = 0;
 
+	prepare_symlink_changes(patch);
 	prepare_fn_table(patch);
 	while (patch) {
 		if (apply_verbosely)
diff --git a/t/t4122-apply-symlink-inside.sh b/t/t4122-apply-symlink-inside.sh
index 035c080..1779c0a 100755
--- a/t/t4122-apply-symlink-inside.sh
+++ b/t/t4122-apply-symlink-inside.sh
@@ -71,4 +71,91 @@ test_expect_success SYMLINKS 'do not read from beyond symbolic link' '
 
 '
 
+test_expect_success SYMLINKS 'do not follow symbolic link (setup)' '
+
+	rm -rf arch/i386/dir arch/x86_64/dir &&
+	git reset --hard &&
+	ln -s ../i386/dir arch/x86_64/dir &&
+	git add arch/x86_64/dir &&
+	git diff HEAD >add_symlink.patch &&
+	git reset --hard &&
+
+	mkdir arch/x86_64/dir &&
+	>arch/x86_64/dir/file &&
+	git add arch/x86_64/dir/file &&
+	git diff HEAD >add_file.patch &&
+	git diff -R HEAD >del_file.patch &&
+	git reset --hard &&
+	rm -fr arch/x86_64/dir &&
+
+	cat add_symlink.patch add_file.patch >patch &&
+	cat add_symlink.patch del_file.patch >tricky_del &&
+
+	mkdir arch/i386/dir
+'
+
+test_expect_success SYMLINKS 'do not follow symbolic link (same input)' '
+
+	# same input creates a confusing symbolic link
+	test_must_fail git apply patch 2>error-wt &&
+	test_i18ngrep "beyond a symbolic link" error-wt &&
+	test_path_is_missing arch/x86_64/dir &&
+	test_path_is_missing arch/i386/dir/file &&
+
+	test_must_fail git apply --index patch 2>error-ix &&
+	test_i18ngrep "beyond a symbolic link" error-ix &&
+	test_path_is_missing arch/x86_64/dir &&
+	test_path_is_missing arch/i386/dir/file &&
+	test_must_fail git ls-files --error-unmatch arch/x86_64/dir &&
+	test_must_fail git ls-files --error-unmatch arch/i386/dir &&
+
+	test_must_fail git apply --cached patch 2>error-ct &&
+	test_i18ngrep "beyond a symbolic link" error-ct &&
+	test_must_fail git ls-files --error-unmatch arch/x86_64/dir &&
+	test_must_fail git ls-files --error-unmatch arch/i386/dir &&
+
+	>arch/i386/dir/file &&
+	git add arch/i386/dir/file &&
+
+	test_must_fail git apply tricky_del &&
+	test_path_is_file arch/i386/dir/file &&
+
+	test_must_fail git apply --index tricky_del &&
+	test_path_is_file arch/i386/dir/file &&
+	test_must_fail git ls-files --error-unmatch arch/x86_64/dir &&
+	git ls-files --error-unmatch arch/i386/dir &&
+
+	test_must_fail git apply --cached tricky_del &&
+	test_must_fail git ls-files --error-unmatch arch/x86_64/dir &&
+	git ls-files --error-unmatch arch/i386/dir
+'
+
+test_expect_success SYMLINKS 'do not follow symbolic link (existing)' '
+
+	# existing symbolic link
+	git reset --hard &&
+	ln -s ../i386/dir arch/x86_64/dir &&
+	git add arch/x86_64/dir &&
+
+	test_must_fail git apply add_file.patch 2>error-wt-add &&
+	test_i18ngrep "beyond a symbolic link" error-wt-add &&
+	test_path_is_missing arch/i386/dir/file &&
+
+	mkdir arch/i386/dir &&
+	>arch/i386/dir/file &&
+	test_must_fail git apply del_file.patch 2>error-wt-del &&
+	test_i18ngrep "beyond a symbolic link" error-wt-del &&
+	test_path_is_file arch/i386/dir/file &&
+	rm arch/i386/dir/file &&
+
+	test_must_fail git apply --index add_file.patch 2>error-ix-add &&
+	test_i18ngrep "beyond a symbolic link" error-ix-add &&
+	test_path_is_missing arch/i386/dir/file &&
+	test_must_fail git ls-files --error-unmatch arch/i386/dir &&
+
+	test_must_fail git apply --cached add_file.patch 2>error-ct-file &&
+	test_i18ngrep "beyond a symbolic link" error-ct-file &&
+	test_must_fail git ls-files --error-unmatch arch/i386/dir
+'
+
 test_done
diff --git a/t/t4139-apply-escape.sh b/t/t4139-apply-escape.sh
index 02b97b3..45b5660 100755
--- a/t/t4139-apply-escape.sh
+++ b/t/t4139-apply-escape.sh
@@ -98,7 +98,7 @@ test_expect_success 'cannot delete file containing .. (index)' '
 	test_path_is_file ../foo
 '
 
-test_expect_failure SYMLINKS 'symlink escape via ..' '
+test_expect_success SYMLINKS 'symlink escape via ..' '
 	{
 		mkpatch_symlink tmp .. &&
 		mkpatch_add tmp/foo ../foo
@@ -108,7 +108,7 @@ test_expect_failure SYMLINKS 'symlink escape via ..' '
 	test_path_is_missing ../foo
 '
 
-test_expect_failure SYMLINKS 'symlink escape via .. (index)' '
+test_expect_success SYMLINKS 'symlink escape via .. (index)' '
 	{
 		mkpatch_symlink tmp .. &&
 		mkpatch_add tmp/foo ../foo
@@ -118,7 +118,7 @@ test_expect_failure SYMLINKS 'symlink escape via .. (index)' '
 	test_path_is_missing ../foo
 '
 
-test_expect_failure SYMLINKS 'symlink escape via absolute path' '
+test_expect_success SYMLINKS 'symlink escape via absolute path' '
 	{
 		mkpatch_symlink tmp "$(pwd)" &&
 		mkpatch_add tmp/foo ../foo
@@ -128,7 +128,7 @@ test_expect_failure SYMLINKS 'symlink escape via absolute path' '
 	test_path_is_missing ../foo
 '
 
-test_expect_failure SYMLINKS 'symlink escape via absolute path (index)' '
+test_expect_success SYMLINKS 'symlink escape via absolute path (index)' '
 	{
 		mkpatch_symlink tmp "$(pwd)" &&
 		mkpatch_add tmp/foo ../foo
-- 
2.3.0-185-g073f588
