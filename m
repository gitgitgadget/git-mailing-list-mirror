From: David Turner <dturner@twopensource.com>
Subject: [PATCH v4 1/1] receive-pack: optionally deny case clone refs
Date: Wed, 11 Jun 2014 18:30:38 -0400
Message-ID: <1402525838-31975-2-git-send-email-dturner@twitter.com>
References: <1402525838-31975-1-git-send-email-dturner@twitter.com>
Cc: David Turner <dturner@twitter.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 12 00:31:09 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wur2y-00071n-Db
	for gcvg-git-2@plane.gmane.org; Thu, 12 Jun 2014 00:31:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754207AbaFKWa7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Jun 2014 18:30:59 -0400
Received: from mail-qc0-f172.google.com ([209.85.216.172]:41009 "EHLO
	mail-qc0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752849AbaFKWa5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jun 2014 18:30:57 -0400
Received: by mail-qc0-f172.google.com with SMTP id o8so712953qcw.3
        for <git@vger.kernel.org>; Wed, 11 Jun 2014 15:30:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=5L7HvNMJkQT9pfZeMKgBXf22VP3ewOgNh/VV7O8Yr0M=;
        b=SGblP7g3Qs+CZP7uWyAELuNEhbqjZjzfeAtnUv8ktrSZtoNjyQxGzKdODpD/g7lGYp
         QSEUE/AjmriMNEWzjohBbWC+RrfXhy2saV9H17Jlaqx2huG0+Kd0qzXQrTTTjeN98x2a
         ZjDejbRZPa92s9O8PEMATPOhvB00uI59V4kZAPZzCeq/rp89zvNNYVC/dd28rVtiQypU
         vWLRPdA7fxWYCzYvp8EGM7VSWi37/mjuPJBFouGtodZPJ7sKjYhMWUYXVukDEj9kbuQv
         m1G16Ae0sxji6xhe5wlo+DRZe1XBAsypRxyJ5gqyR3IVeFV8STt7GEGeoBrDCBUZkz++
         aghQ==
X-Gm-Message-State: ALoCoQmRliYTlBSdGT6AVSmvLao409ETzHOxcHdwopGZXteECd2tv64FqXxnw4RiBIeMAxJxy4+R
X-Received: by 10.224.63.194 with SMTP id c2mr26986906qai.21.1402525856928;
        Wed, 11 Jun 2014 15:30:56 -0700 (PDT)
Received: from stross.twitter.corp ([38.104.173.198])
        by mx.google.com with ESMTPSA id l33sm3676899qgd.6.2014.06.11.15.30.55
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 11 Jun 2014 15:30:55 -0700 (PDT)
X-Google-Original-From: David Turner <dturner@twitter.com>
X-Mailer: git-send-email 2.0.0.rc1.24.g0588c94.dirty
In-Reply-To: <1402525838-31975-1-git-send-email-dturner@twitter.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251389>

It is possible to have two refs which are the same but for case.
This works great on the case-sensitive filesystems, but not so well on
case-insensitive filesystems.  It is fairly typical to have
case-insensitive clients (Macs, say) with a case-sensitive server
(GNU/Linux).

Should a user attempt to pull on a Mac when there are case clone refs
with differing contents, they'll get an error message containing
something like "Ref refs/remotes/origin/lower is at
[sha-of-lowercase-ref] but expected [sha-of-uppercase-ref]....
(unable to update local ref)".

With a case-insensitive git server, if a branch called capital-M
Master (that differs from lowercase-m-master) is pushed, nobody else
can push to (lowercase-m) master until the branch is removed.

Create the option receive.denycaseclonerefs, which checks pushed
refs to ensure that they are not case clones of an existing
ref.  This setting is turned on by default if core.ignorecase is
set, but not otherwise.

Signed-off-by: David Turner <dturner@twitter.com>
---
 Documentation/config.txt           |   6 ++
 Documentation/git-push.txt         |   5 +-
 Documentation/glossary-content.txt |   9 +++
 builtin/receive-pack.c             | 147 ++++++++++++++++++++++++++++++++++++-
 refs.c                             |   7 +-
 refs.h                             |   6 ++
 t/t5400-send-pack.sh               |  90 +++++++++++++++++++++++
 7 files changed, 261 insertions(+), 9 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 1932e9b..b24b117 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -2053,6 +2053,12 @@ receive.unpackLimit::
 	especially on slow filesystems.  If not set, the value of
 	`transfer.unpackLimit` is used instead.
 
+receive.denyCaseCloneRefs::
+	If set to true, git-receive-pack will deny a ref update that creates
+	a ref which is the same but for case as an existing ref.  This is
+	useful when clients are on a case-insensitive filesystem, which
+	will cause errors when given refs which differ only in case.
+
 receive.denyDeletes::
 	If set to true, git-receive-pack will deny a ref update that deletes
 	the ref. Use this to prevent such a ref deletion via a push.
diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
index 21cd455..c92c3a6 100644
--- a/Documentation/git-push.txt
+++ b/Documentation/git-push.txt
@@ -323,8 +323,9 @@ remote rejected::
 	of the following safety options in effect:
 	`receive.denyCurrentBranch` (for pushes to the checked out
 	branch), `receive.denyNonFastForwards` (for forced
-	non-fast-forward updates), `receive.denyDeletes` or
-	`receive.denyDeleteCurrent`.  See linkgit:git-config[1].
+	non-fast-forward updates), `receive.denyDeletes`,
+	`receive.denyCaseCloneRefs` or `receive.denyDeleteCurrent`.
+	See linkgit:git-config[1].
 
 remote failure::
 	The remote end did not report the successful update of the ref,
diff --git a/Documentation/glossary-content.txt b/Documentation/glossary-content.txt
index be0858c..d1f24bf 100644
--- a/Documentation/glossary-content.txt
+++ b/Documentation/glossary-content.txt
@@ -31,6 +31,15 @@
 [[def_cache]]cache::
 	Obsolete for: <<def_index,index>>.
 
+[[def_case_clone]]case clone::
+	Two entities (e.g. filenames or refs) that differ only in case.
+	These can cause problems on case-insensitive filesystems, and
+	Git has machinery to prevent these problems in various cases.
+	Case clone refs also include the situation where one ref has
+	a path component which is a case-clone of a different ref's path
+	component in the same directory e.g. refs/heads/case/a is a case
+	clone of refs/heads/CASE/b
+
 [[def_chain]]chain::
 	A list of objects, where each <<def_object,object>> in the list contains
 	a reference to its successor (for example, the successor of a
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index c323081..6431758 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -27,6 +27,7 @@ enum deny_action {
 
 static int deny_deletes;
 static int deny_non_fast_forwards;
+static int deny_case_clone_refs = DENY_UNCONFIGURED;
 static enum deny_action deny_current_branch = DENY_UNCONFIGURED;
 static enum deny_action deny_delete_current = DENY_UNCONFIGURED;
 static int receive_fsck_objects = -1;
@@ -69,6 +70,11 @@ static int receive_pack_config(const char *var, const char *value, void *cb)
 	if (status)
 		return status;
 
+	if (strcmp(var, "receive.denycaseclonerefs") == 0) {
+		deny_case_clone_refs = parse_deny_action(var, value);
+		return 0;
+	}
+
 	if (strcmp(var, "receive.denydeletes") == 0) {
 		deny_deletes = git_config_bool(var, value);
 		return 0;
@@ -468,6 +474,138 @@ static int update_shallow_ref(struct command *cmd, struct shallow_info *si)
 	return 0;
 }
 
+/*
+ * This contains not just refs, but ref prefixes -- i.e. not just
+ * refs/heads/foo/bar, but refs, refs/heads, and refs/heads/foo
+ */
+struct ref_cache_entry {
+	struct hashmap_entry ent;
+	unsigned int count; /* count of refs having this as a component */
+	char ref[FLEX_ARRAY];
+};
+
+static struct hashmap *ref_case_clone_cache;
+
+static int ref_cache_entry_cmp(const struct ref_cache_entry *e1,
+			       const struct ref_cache_entry *e2, const char *ref)
+{
+	return strcasecmp(e1->ref, ref ? ref : e2->ref);
+}
+
+/*
+ * Insert a ref into the ref cache, as well as all of its ancestor
+ * directory names -- so if we insert refs/heads/something/other,
+ * refs, refs/heads, refs/heads/something/other will be included.
+ */
+static int ref_cache_insert(const char *refname, struct hashmap *map)
+{
+	int total_len = 0, comp_len;
+
+	while ((comp_len = check_refname_component(refname + total_len, 0)) >= 0) {
+		struct ref_cache_entry *old;
+		struct ref_cache_entry *entry = xmalloc(sizeof(*entry) + total_len + comp_len + 1);
+		total_len += comp_len;
+		memcpy(entry->ref, refname, total_len);
+		entry->ref[total_len] = 0;
+		entry->count = 1;
+		hashmap_entry_init(entry, memihash(entry->ref, total_len));
+		old = hashmap_get(map, entry, entry->ref);
+		if (old) {
+			old->count ++;
+			free(entry);
+		} else
+			hashmap_add(map, entry);
+		total_len ++;
+	}
+}
+
+/*
+ * Remove a ref from the ref cache, as well as any of its ancestor
+ * directory names that no longer contain any refs.
+ */
+static int ref_cache_delete(const char *refname, struct hashmap *map)
+{
+	int total_len = 0, comp_len;
+
+	struct ref_cache_entry *entry = xmalloc(sizeof(*entry) + strlen(refname));
+
+	while ((comp_len = check_refname_component(refname + total_len, 0)) >= 0) {
+		struct ref_cache_entry *old;
+		total_len += comp_len;
+		memcpy(entry->ref, refname, total_len);
+		entry->ref[total_len] = 0;
+		hashmap_entry_init(entry, memihash(entry->ref, total_len));
+		old = hashmap_get(map, entry, entry->ref);
+		if (old) {
+			old->count --;
+			if (old->count == 0) {
+				hashmap_remove(map, old, old->ref);
+				free(old);
+			}
+		} else {
+			warn("Ref cache coherency failure: %s from %s", entry->ref, refname);
+			break;
+		}
+		total_len ++;
+	}
+	free(entry);
+}
+
+
+static int ref_cache_insert_cb(const char *refname, const unsigned char *sha1,
+			       int flags, void *cb_data)
+{
+	ref_cache_insert(refname, cb_data);
+}
+
+static void ensure_ref_case_clone_cache(void)
+{
+	if (ref_case_clone_cache)
+		return;
+	ref_case_clone_cache = xmalloc(sizeof(*ref_case_clone_cache));
+	hashmap_init(ref_case_clone_cache,
+		     (hashmap_cmp_fn)ref_cache_entry_cmp, 1000);
+
+	for_each_ref(ref_cache_insert_cb, (void *)ref_case_clone_cache);
+}
+
+/*
+ * Search the ref cache for a ref that is a case clone of this
+ * incoming ref; this includes prefix case clones so that
+ * refs/heads/case/clone will conflict with refs/heads/CASE/other
+ */
+static int ref_is_case_clone(const char *name) {
+	struct ref_cache_entry key;
+	struct ref_cache_entry *existing;
+	int total_len = 0, comp_len;
+	char *name_so_far = strdup(name);
+
+	while ((comp_len = check_refname_component(name + total_len, 0)) >= 0) {
+		total_len += comp_len;
+		name_so_far[total_len] = 0;
+		hashmap_entry_init(&key, memihash(name_so_far, total_len));
+		existing = hashmap_get(ref_case_clone_cache, &key, name_so_far);
+		if (!existing)
+			return 0;
+		if (memcmp(existing->ref, name_so_far, total_len))
+			return 1;
+		name_so_far[total_len] = '/';
+		total_len ++;
+	}
+
+	free(name_so_far);
+	return 0;
+}
+
+static int ref_is_denied_case_clone(const char *name)
+{
+	if (!deny_case_clone_refs)
+		return 0;
+	ensure_ref_case_clone_cache();
+
+	return ref_is_case_clone(name);
+}
+
 static const char *update(struct command *cmd, struct shallow_info *si)
 {
 	const char *name = cmd->ref_name;
@@ -478,7 +616,8 @@ static const char *update(struct command *cmd, struct shallow_info *si)
 	struct ref_lock *lock;
 
 	/* only refs/... are allowed */
-	if (!starts_with(name, "refs/") || check_refname_format(name + 5, 0)) {
+	if (!starts_with(name, "refs/") || check_refname_format(name + 5, 0) ||
+	    ref_is_denied_case_clone(name)) {
 		rp_error("refusing to create funny ref '%s' remotely", name);
 		return "funny refname";
 	}
@@ -573,6 +712,8 @@ static const char *update(struct command *cmd, struct shallow_info *si)
 			rp_error("failed to delete %s", name);
 			return "failed to delete";
 		}
+		if (deny_case_clone_refs)
+			ref_cache_delete(name, ref_case_clone_cache);
 		return NULL; /* good */
 	}
 	else {
@@ -589,6 +730,8 @@ static const char *update(struct command *cmd, struct shallow_info *si)
 		if (write_ref_sha1(lock, new_sha1, "push")) {
 			return "failed to write"; /* error() already called */
 		}
+		if (deny_case_clone_refs)
+			ref_cache_insert(name, ref_case_clone_cache);
 		return NULL; /* good */
 	}
 }
@@ -1171,6 +1314,8 @@ int cmd_receive_pack(int argc, const char **argv, const char *prefix)
 		die("'%s' does not appear to be a git repository", dir);
 
 	git_config(receive_pack_config, NULL);
+	if (deny_case_clone_refs == DENY_UNCONFIGURED)
+		deny_case_clone_refs = ignore_case;
 
 	if (0 <= transfer_unpack_limit)
 		unpack_limit = transfer_unpack_limit;
diff --git a/refs.c b/refs.c
index 28d5eca..7d534cc 100644
--- a/refs.c
+++ b/refs.c
@@ -29,12 +29,7 @@ static inline int bad_ref_char(int ch)
 	return 0;
 }
 
-/*
- * Try to read one refname component from the front of refname.  Return
- * the length of the component found, or -1 if the component is not
- * legal.
- */
-static int check_refname_component(const char *refname, int flags)
+int check_refname_component(const char *refname, int flags)
 {
 	const char *cp;
 	char last = '\0';
diff --git a/refs.h b/refs.h
index 87a1a79..38f3272 100644
--- a/refs.h
+++ b/refs.h
@@ -200,6 +200,12 @@ extern int for_each_reflog(each_ref_fn, void *);
  * "." or "..").
  */
 extern int check_refname_format(const char *refname, int flags);
+/*
+ * Try to read one refname component from the front of refname.  Return
+ * the length of the component found, or -1 if the component is not
+ * legal.
+ */
+extern int check_refname_component(const char *refname, int flags);
 
 extern const char *prettify_refname(const char *refname);
 extern char *shorten_unambiguous_ref(const char *refname, int strict);
diff --git a/t/t5400-send-pack.sh b/t/t5400-send-pack.sh
index 0736bcb..de0a88d 100755
--- a/t/t5400-send-pack.sh
+++ b/t/t5400-send-pack.sh
@@ -129,6 +129,96 @@ test_expect_success 'denyNonFastforwards trumps --force' '
 	test "$victim_orig" = "$victim_head"
 '
 
+test_expect_success 'denyCaseCloneRefs works' '
+	(
+	    cd victim &&
+	    git config receive.denyCaseCloneRefs true &&
+	    git config receive.denyDeletes false
+	) &&
+	git send-pack ./victim HEAD:refs/heads/case/clone &&
+	orig_ver=$(git rev-parse HEAD) &&
+	test_must_fail git send-pack ./victim HEAD^:refs/heads/Case/Clone &&
+	# confirm that this had no effect upstream
+	(
+	    cd victim &&
+	    ref=$(git for-each-ref --format="%(refname)" refs/heads/Case/Clone) &&
+	    echo "$ref" | test_must_fail grep -q Case/Clone &&
+	    remote_ver=$(git rev-parse case/clone) &&
+	    test "$orig_ver" = "$remote_ver"
+	) &&
+	git send-pack ./victim HEAD^:refs/heads/notacase/clone &&
+	test_must_fail git send-pack ./victim :Case/Clone &&
+	# confirm that this had no effect upstream
+	(
+	    cd victim &&
+	    ref=$(git for-each-ref --format="%(refname)" refs/heads/Case/Clone) &&
+	    echo "$ref" | test_must_fail grep -q Case/Clone &&
+	    remote_ver=$(git rev-parse case/clone) &&
+	    test "$orig_ver" = "$remote_ver"
+	) &&
+	git send-pack ./victim :case/clone &&
+	# confirm that this took effect upstream
+	(
+	    cd victim &&
+	    test_must_fail git rev-parse case/clone
+	) &&
+	# check that we can recreate a branch after deleting a
+	# case-clone of it
+	case_clone_ver=$(git rev-parse HEAD^) &&
+	git send-pack ./victim HEAD^:refs/heads/Case/Clone &&
+	(
+	    cd victim &&
+	    ref=$(git for-each-ref --format="%(refname)" refs/heads/case/clone) &&
+	    echo "$ref" | test_must_fail grep -q case/clone  &&
+	    remote_ver=$(git rev-parse Case/Clone) &&
+	    test "$case_clone_ver" = "$remote_ver"
+	) &&
+	# check subdirectory
+	test_must_fail git send-pack ./victim HEAD:refs/heads/case/clone/morx &&
+	# confirm that this had no effect upstream
+	(
+	    cd victim &&
+	    ref=$(git for-each-ref --format="%(refname)" refs/heads/case/clone/morx) &&
+	    echo "$ref" | test_must_fail grep -q case/clone/morx &&
+	    remote_ver=$(git rev-parse Case/Clone) &&
+	    test "$case_clone_ver" = "$remote_ver"
+	) &&
+	#check parent directory
+	test_must_fail git send-pack ./victim HEAD:refs/heads/case/other &&
+	# confirm that this had no effect upstream
+	(
+	    cd victim &&
+	    ref=$(git for-each-ref --format="%(refname)" refs/heads/case/other) &&
+	    echo "$ref" | test_must_fail grep -q case/other &&
+	    remote_ver=$(git rev-parse Case/Clone) &&
+	    test "$case_clone_ver" = "$remote_ver"
+	)
+'
+test_expect_success 'denyCaseCloneRefs works in same send-pack case' '
+	(
+	    cd victim &&
+	    git config receive.denyCaseCloneRefs true &&
+	    git config receive.denyDeletes false
+	) &&
+	test_must_fail git send-pack ./victim HEAD:refs/heads/case2 HEAD~:refs/heads/CASE2 &&
+	(
+	    cd victim &&
+	    ref=$(git for-each-ref --format="%(refname)" refs/heads/CASE2) &&
+	    echo "$ref" | test_must_fail grep -q CASE2 &&
+	    remote_ver=$(git rev-parse case2) &&
+	    test "$orig_ver" = "$remote_ver"
+	) &&
+	case_clone_ver=$(git rev-parse HEAD^) &&
+	git send-pack ./victim :refs/heads/case2 HEAD~:refs/heads/CASE2 &&
+	(
+	    cd victim &&
+	    ref=$(git for-each-ref --format="%(refname)" refs/heads/case2) &&
+	    echo "$ref" | test_must_fail grep -q case2 &&
+	    remote_ver=$(git rev-parse CASE2) &&
+	    test "$case_clone_ver" = "$remote_ver"
+	)
+'
+
 test_expect_success 'push --all excludes remote-tracking hierarchy' '
 	mkdir parent &&
 	(
-- 
2.0.0.rc1.24.g0588c94.dirty
