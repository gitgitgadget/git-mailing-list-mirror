From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] add: refuse to add paths beyond repository
 boundaries
Date: Tue, 09 Apr 2013 10:54:44 -0700
Message-ID: <7vmwt7si6z.fsf@alter.siamese.dyndns.org>
References: <CALkWK0m_82ThYKxcr=YHGBnOaHr9yBpYFHxx2KrnQkWD_zjp1A@mail.gmail.com>
 <1365499297-8667-1-git-send-email-artagnon@gmail.com>
 <1365499297-8667-3-git-send-email-artagnon@gmail.com>
 <7v4nfftyu3.fsf@alter.siamese.dyndns.org>
 <7vvc7vsj4p.fsf@alter.siamese.dyndns.org>
 <CALkWK0k0YMWjhJQFWLv6b7kAHqRm8-Dq23gMVHYfatq1SLUDhQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Duy Nguyen <pclouds@gmail.com>,
	Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 09 19:54:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UPckv-0004YJ-K7
	for gcvg-git-2@plane.gmane.org; Tue, 09 Apr 2013 19:54:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935102Ab3DIRyt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Apr 2013 13:54:49 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44421 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934630Ab3DIRys (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Apr 2013 13:54:48 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DDE2115576;
	Tue,  9 Apr 2013 17:54:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Ckoc7jsh8w6g2j5Kx2DyD4+gIBo=; b=ce7Bvc
	SENyJj+D89ENK+0J6dRDcQZSd6n4Mj9VyNG5MFmmNL/cQoA6KA3c+8BXoFgwxwet
	SjGBed4m2ipslXZCXBefMeluJ0KQyaEguKNLNT3aWMaWnKNu5NMD/rhMRYdAC7iS
	4gSPROXE3HGx+9sxqvaBrQsiYOV079YB7NoAE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=XRuZP52kqjhWTfWgL/aydsW2IfexXPGy
	UtJ2nr9XrPZ1qghYNrAwg98QINgPZT4cbZSpX20fC+JpMRRo7mfswvm/Igw9j+4P
	P7VAK26YAfzugl8B/VRTLVQOktsLdEBIJ4kxc6NY0HTHiLmnIXRPl+A++cOV/lu7
	/NLIJobvsIw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D36B315575;
	Tue,  9 Apr 2013 17:54:47 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6A53115573; Tue,  9 Apr
 2013 17:54:46 +0000 (UTC)
In-Reply-To: <CALkWK0k0YMWjhJQFWLv6b7kAHqRm8-Dq23gMVHYfatq1SLUDhQ@mail.gmail.com>
 (Ramkumar Ramachandra's message of "Tue, 9 Apr 2013 23:11:28 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 90D4F8A6-A13E-11E2-909C-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220601>

Sorry for repeated rerolls.  I had missed another instance in t0008
and also the explanation was lacking.

-- >8 --
Subject: [PATCH] symlinks: rename has_symlink_leading_path() to
 path_outside_our_project()

The purpose of the function is to prevent a path from getting added
to our project when its path component steps outside our working
tree, like this:

	ln -s /etc myetc
	git add myetc/passwd

We do not want to end up with "myetc/passwd" in our index.  To make
sure an attempt to add such a path is caught, the implementation
checks if there is any leading symbolic link in the given path
(adding "myetc" itself as a symbolic link to our project is
accepted).

But there are other cases to attempt to add a path that do not
belong to our project, which do not have to involve a symbolic link
in the leading path.

Rename the function, and die_if_path_beyond_symlink() function, to
clarify what they are really checking, not how they are checking.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/add.c          |  6 +++---
 builtin/apply.c        |  8 ++++++--
 builtin/check-ignore.c |  2 +-
 builtin/update-index.c |  4 ++--
 cache.h                |  4 ++--
 diff-lib.c             |  2 +-
 dir.c                  |  2 +-
 pathspec.c             |  6 +++---
 pathspec.h             |  2 +-
 preload-index.c        |  2 +-
 symlinks.c             | 10 +++++-----
 t/t0008-ignores.sh     |  4 ++--
 12 files changed, 28 insertions(+), 24 deletions(-)

diff --git a/builtin/add.c b/builtin/add.c
index ab1c9e8..7cb80ef 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -155,8 +155,8 @@ static void refresh(int verbose, const char **pathspec)
 
 /*
  * Normalizes argv relative to prefix, via get_pathspec(), and then
- * runs die_if_path_beyond_symlink() on each path in the normalized
- * list.
+ * runs die_if_path_outside_our_project() on each path in the
+ * normalized list.
  */
 static const char **validate_pathspec(const char **argv, const char *prefix)
 {
@@ -165,7 +165,7 @@ static const char **validate_pathspec(const char **argv, const char *prefix)
 	if (pathspec) {
 		const char **p;
 		for (p = pathspec; *p; p++) {
-			die_if_path_beyond_symlink(*p, prefix);
+			die_if_path_outside_our_project(*p, prefix);
 		}
 	}
 
diff --git a/builtin/apply.c b/builtin/apply.c
index 5b882d0..d0b408e 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -3469,10 +3469,14 @@ static int check_to_create(const char *new_name, int ok_if_exists)
 		 * A leading component of new_name might be a symlink
 		 * that is going to be removed with this patch, but
 		 * still pointing at somewhere that has the path.
-		 * In such a case, path "new_name" does not exist as
+		 * Or it could be the top-level of a working tree of
+		 * a different project that is embedded in our working
+		 * tree.
+		 *
+		 * In such cases, path "new_name" does not exist as
 		 * far as git is concerned.
 		 */
-		if (has_symlink_leading_path(new_name, strlen(new_name)))
+		if (path_outside_our_project(new_name, strlen(new_name)))
 			return 0;
 
 		return EXISTS_IN_WORKTREE;
diff --git a/builtin/check-ignore.c b/builtin/check-ignore.c
index 0240f99..bce378d 100644
--- a/builtin/check-ignore.c
+++ b/builtin/check-ignore.c
@@ -88,7 +88,7 @@ static int check_ignore(const char *prefix, const char **pathspec)
 		full_path = prefix_path(prefix, prefix
 					? strlen(prefix) : 0, path);
 		full_path = check_path_for_gitlink(full_path);
-		die_if_path_beyond_symlink(full_path, prefix);
+		die_if_path_outside_our_project(full_path, prefix);
 		if (!seen[i]) {
 			exclude = last_exclude_matching_path(&check, full_path,
 							     -1, &dtype);
diff --git a/builtin/update-index.c b/builtin/update-index.c
index 5c7762e..7c47fa2 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -186,8 +186,8 @@ static int process_path(const char *path)
 	struct cache_entry *ce;
 
 	len = strlen(path);
-	if (has_symlink_leading_path(path, len))
-		return error("'%s' is beyond a symbolic link", path);
+	if (path_outside_our_project(path, len))
+		return error("'%s' is outside our working tree", path);
 
 	pos = cache_name_pos(path, len);
 	ce = pos < 0 ? NULL : active_cache[pos];
diff --git a/cache.h b/cache.h
index e1e8ce8..f6359b5 100644
--- a/cache.h
+++ b/cache.h
@@ -960,8 +960,8 @@ struct cache_def {
 	int prefix_len_stat_func;
 };
 
-extern int has_symlink_leading_path(const char *name, int len);
-extern int threaded_has_symlink_leading_path(struct cache_def *, const char *, int);
+extern int path_outside_our_project(const char *name, int len);
+extern int threaded_path_outside_our_project(struct cache_def *, const char *, int);
 extern int check_leading_path(const char *name, int len);
 extern int has_dirs_only_path(const char *name, int len, int prefix_len);
 extern void schedule_dir_for_removal(const char *name, int len);
diff --git a/diff-lib.c b/diff-lib.c
index f35de0f..8aff906 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -32,7 +32,7 @@ static int check_removed(const struct cache_entry *ce, struct stat *st)
 			return -1;
 		return 1;
 	}
-	if (has_symlink_leading_path(ce->name, ce_namelen(ce)))
+	if (path_outside_our_project(ce->name, ce_namelen(ce)))
 		return 1;
 	if (S_ISDIR(st->st_mode)) {
 		unsigned char sub[20];
diff --git a/dir.c b/dir.c
index 91cfd99..b90b57b 100644
--- a/dir.c
+++ b/dir.c
@@ -1479,7 +1479,7 @@ int read_directory(struct dir_struct *dir, const char *path, int len, const char
 {
 	struct path_simplify *simplify;
 
-	if (has_symlink_leading_path(path, len))
+	if (path_outside_our_project(path, len))
 		return dir->nr;
 
 	simplify = create_simplify(pathspec);
diff --git a/pathspec.c b/pathspec.c
index 284f397..336149f 100644
--- a/pathspec.c
+++ b/pathspec.c
@@ -92,10 +92,10 @@ const char *check_path_for_gitlink(const char *path)
  * Dies if the given path refers to a file inside a symlinked
  * directory in the index.
  */
-void die_if_path_beyond_symlink(const char *path, const char *prefix)
+void die_if_path_outside_our_project(const char *path, const char *prefix)
 {
-	if (has_symlink_leading_path(path, strlen(path))) {
+	if (path_outside_our_project(path, strlen(path))) {
 		int len = prefix ? strlen(prefix) : 0;
-		die(_("'%s' is beyond a symbolic link"), path + len);
+		die(_("'%s' is outside the working tree"), path + len);
 	}
 }
diff --git a/pathspec.h b/pathspec.h
index db0184a..ef816a8 100644
--- a/pathspec.h
+++ b/pathspec.h
@@ -4,6 +4,6 @@
 extern char *find_pathspecs_matching_against_index(const char **pathspec);
 extern void add_pathspec_matches_against_index(const char **pathspec, char *seen, int specs);
 extern const char *check_path_for_gitlink(const char *path);
-extern void die_if_path_beyond_symlink(const char *path, const char *prefix);
+extern void die_if_path_outside_our_project(const char *path, const char *prefix);
 
 #endif /* PATHSPEC_H */
diff --git a/preload-index.c b/preload-index.c
index 49cb08d..b3e57d4 100644
--- a/preload-index.c
+++ b/preload-index.c
@@ -55,7 +55,7 @@ static void *preload_thread(void *_data)
 			continue;
 		if (!ce_path_match(ce, &pathspec))
 			continue;
-		if (threaded_has_symlink_leading_path(&cache, ce->name, ce_namelen(ce)))
+		if (threaded_path_outside_our_project(&cache, ce->name, ce_namelen(ce)))
 			continue;
 		if (lstat(ce->name, &st))
 			continue;
diff --git a/symlinks.c b/symlinks.c
index c2b41a8..baed93f 100644
--- a/symlinks.c
+++ b/symlinks.c
@@ -196,19 +196,19 @@ static int lstat_cache(struct cache_def *cache, const char *name, int len,
 #define USE_ONLY_LSTAT  0
 
 /*
- * Return non-zero if path 'name' has a leading symlink component
+ * Return non-zero if path 'name' points outside the working tree
  */
-int threaded_has_symlink_leading_path(struct cache_def *cache, const char *name, int len)
+int threaded_path_outside_our_project(struct cache_def *cache, const char *name, int len)
 {
 	return lstat_cache(cache, name, len, FL_SYMLINK|FL_DIR, USE_ONLY_LSTAT) & FL_SYMLINK;
 }
 
 /*
- * Return non-zero if path 'name' has a leading symlink component
+ * Return non-zero if path 'name' points outside the working tree
  */
-int has_symlink_leading_path(const char *name, int len)
+int path_outside_our_project(const char *name, int len)
 {
-	return threaded_has_symlink_leading_path(&default_cache, name, len);
+	return threaded_path_outside_our_project(&default_cache, name, len);
 }
 
 /*
diff --git a/t/t0008-ignores.sh b/t/t0008-ignores.sh
index 9c1bde1..a00ee75 100755
--- a/t/t0008-ignores.sh
+++ b/t/t0008-ignores.sh
@@ -397,7 +397,7 @@ test_expect_success_multi SYMLINKS 'symlink' '' '
 
 test_expect_success_multi SYMLINKS 'beyond a symlink' '' '
 	test_check_ignore "a/symlink/foo" 128 &&
-	test_stderr "fatal: '\''a/symlink/foo'\'' is beyond a symbolic link"
+	test_stderr "fatal: '\''a/symlink/foo'\'' is outside the working tree"
 '
 
 test_expect_success_multi SYMLINKS 'beyond a symlink from subdirectory' '' '
@@ -405,7 +405,7 @@ test_expect_success_multi SYMLINKS 'beyond a symlink from subdirectory' '' '
 		cd a &&
 		test_check_ignore "symlink/foo" 128
 	) &&
-	test_stderr "fatal: '\''symlink/foo'\'' is beyond a symbolic link"
+	test_stderr "fatal: '\''symlink/foo'\'' is outside the working tree"
 '
 
 ############################################################################
-- 
1.8.2.1-465-gf55e5b3
