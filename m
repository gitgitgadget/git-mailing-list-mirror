From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 4/4] apply: do not touch a file beyond a symbolic link
Date: Tue,  3 Feb 2015 16:44:22 -0800
Message-ID: <1423010662-26497-5-git-send-email-gitster@pobox.com>
References: <1422919650-13346-1-git-send-email-gitster@pobox.com>
 <1423010662-26497-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 04 01:44:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YIo5E-0004an-92
	for gcvg-git-2@plane.gmane.org; Wed, 04 Feb 2015 01:44:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966835AbbBDAoh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Feb 2015 19:44:37 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:51052 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754651AbbBDAob (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Feb 2015 19:44:31 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id F1505365DF;
	Tue,  3 Feb 2015 19:44:30 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=oUWu
	cdzLFrNJZLZGyDpGgSyKWJ4=; b=B0aUkPrsCwENSNiVXDBRTBInI1zmcQg1RkOr
	NyUvlGPKsQ7kNarg0PQcwFp1l3nTDzu0vnLCTyEZYdj0nVzCI2PFMUqrBV5aYPep
	rS8rCWzZB76yp/GzL6dOOFlT5k2+CJtH3uD7NYJqW9J89DIp+2FsjEtxdSHKpjuq
	fjxaHUQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=bOuVhT
	WZ0/0NLmkSXQsfTnEaJALzieUcnsT9ev2MARE4nZjg9XQIWpgcvJwmDM2nCRwZWM
	oE+Uk6fj9TE8XYvI6lBab8Lywm5k9E4b09CU5kvfxP5iouk1UtUX1grhlTEGC5hR
	8Ij1DhTcAGi4xmABALXOfebGU5ZjxV78f5izc=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E6097365DE;
	Tue,  3 Feb 2015 19:44:30 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 17C36365DD;
	Tue,  3 Feb 2015 19:44:29 -0500 (EST)
X-Mailer: git-send-email 2.3.0-rc2-168-g106c876
In-Reply-To: <1423010662-26497-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: F9F148F6-AC06-11E4-9829-7BA29F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263345>

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

 * In code comment to check_patch() rephrased to clarify why we
   don't have to check a is_delete patch there while we have to
   check others.

   An additional test case stolen from Peff.

 builtin/apply.c                 | 111 ++++++++++++++++++++++++++++++++++++++++
 t/t4122-apply-symlink-inside.sh |  87 +++++++++++++++++++++++++++++++
 t/t4139-apply-escape.sh         |   6 +--
 3 files changed, 201 insertions(+), 3 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 60d821c..28975e6 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -3486,6 +3486,103 @@ static int check_to_create(const char *new_name, int ok_if_exists)
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
+			int pos = cache_name_pos(name->buf, name->len);
+			if (0 <= pos &&
+			    S_ISLNK(active_cache[pos]->ce_mode))
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
@@ -3593,6 +3690,19 @@ static int check_patch(struct patch *patch)
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
@@ -3603,6 +3713,7 @@ static int check_patch_list(struct patch *patch)
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
index 5e67179..25917cc 100755
--- a/t/t4139-apply-escape.sh
+++ b/t/t4139-apply-escape.sh
@@ -98,7 +98,7 @@ test_expect_success 'cannot del file containing .. (index)' '
 	test_path_is_file ../foo
 '
 
-test_expect_failure 'symlink escape via ..' '
+test_expect_success 'symlink escape via ..' '
 	{
 		mkpatch_symlink tmp .. &&
 		mkpatch_add tmp/foo ../foo
@@ -107,7 +107,7 @@ test_expect_failure 'symlink escape via ..' '
 	test_path_is_missing ../foo
 '
 
-test_expect_failure 'symlink escape via .. (index)' '
+test_expect_success 'symlink escape via .. (index)' '
 	{
 		mkpatch_symlink tmp .. &&
 		mkpatch_add tmp/foo ../foo
@@ -116,7 +116,7 @@ test_expect_failure 'symlink escape via .. (index)' '
 	test_path_is_missing ../foo
 '
 
-test_expect_failure 'symlink escape via absolute path' '
+test_expect_success 'symlink escape via absolute path' '
 	{
 		mkpatch_symlink tmp "$(pwd)" &&
 		mkpatch_add tmp/foo ../foo
-- 
2.3.0-rc2-168-g106c876
