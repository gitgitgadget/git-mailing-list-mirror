From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] "Assume unchanged" git
Date: Wed, 08 Feb 2006 21:15:24 -0800
Message-ID: <7vek2di043.fsf@assigned-by-dhcp.cox.net>
References: <46a038f90601251810m1086d353ne8c7147edee4962a@mail.gmail.com>
	<Pine.LNX.4.64.0601272345540.2909@evo.osdl.org>
	<46a038f90601272133o53438987ka6b97c21d0cdf921@mail.gmail.com>
	<1138446030.9919.112.camel@evo.keithp.com>
	<7vzmlgt5zt.fsf@assigned-by-dhcp.cox.net>
	<1138529385.9919.185.camel@evo.keithp.com>
	<43DCA495.9040301@gorzow.mm.pl> <20060130225107.GA3857@limbo.home>
	<Pine.LNX.4.64.0601311314030.7301@g5.osdl.org>
	<20060131220148.GA19411@steel.home> <20060201013901.GA16832@mail.com>
	<Pine.LNX.4.64.0601311747360.7301@g5.osdl.org>
	<Pine.LNX.4.64.0601311807470.7301@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alex Riesen <raa.lkml@gmail.com>,
	Radoslaw Szkodzinski <astralstorm@gorzow.mm.pl>,
	Keith Packard <keithp@keithp.com>, cworth@cworth.org,
	Martin Langhoff <martin.langhoff@gmail.com>,
	Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Thu Feb 09 06:15:38 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F749V-0002QT-IB
	for gcvg-git@gmane.org; Thu, 09 Feb 2006 06:15:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750756AbWBIFPb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 9 Feb 2006 00:15:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750798AbWBIFPb
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Feb 2006 00:15:31 -0500
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:4822 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S1750756AbWBIFPa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Feb 2006 00:15:30 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060209051309.LCKT17006.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 9 Feb 2006 00:13:09 -0500
To: git@vger.kernel.org
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15788>

Linus Torvalds <torvalds@osdl.org> writes:

> The real meat is just making sure that CE_VALID gets set/cleared properly.

Setting is easier part.  Deciding when to ignore/clear for the
sake of safety and usability is harder.  I think I got the
basics right but we might want to pass "really" from more places.

This is _not_ 1.2 material, but I think it is ready to be tested
by people who asked for this feature.  It applies on top of the
recent master branch.

-- >8 --
[PATCH] "Assume unchanged" git

This adds "assume unchanged" logic, started by this message in the list
discussion recently:

	<Pine.LNX.4.64.0601311807470.7301@g5.osdl.org>

This is a workaround for filesystems that do not have lstat()
that is quick enough for the index mechanism to take advantage
of.  On the paths marked as "assumed to be unchanged", the user
needs to explicitly use update-index to register the object name
to be in the next commit.

You can use two new options to update-index to set and reset the
CE_VALID bit:

	git-update-index --assume-unchanged path...
	git-update-index --no-assume-unchanged path...

These forms manipulate only the CE_VALID bit; it does not change
the object name recorded in the index file.  Nor they add a new
entry to the index.

When the configuration variable "core.ignorestat = true" is set,
the index entries are marked with CE_VALID bit automatically
after:

 - update-index to explicitly register the current object name to the
   index file.

 - when update-index --refresh finds the path to be up-to-date.

 - when tools like read-tree -u and apply --index update the working
   tree file and register the current object name to the index file.

The flag is dropped upon read-tree that does not check out the index
entry.  This happens regardless of the core.ignorestat settings.

Index entries marked with CE_VALID bit are assumed to be
unchanged most of the time.  However, there are cases that
CE_VALID bit is ignored for the sake of safety and usability:

 - while "git-read-tree -m" or git-apply need to make sure
   that the paths involved in the merge do not have local
   modifications.  This sacrifices performance for safety.

 - when git-checkout-index -f -q -u -a tries to see if it needs
   to checkout the paths.  Otherwise you can never check
   anything out ;-).

 - when git-update-index --really-refresh (a new flag) tries to
   see if the index entry is up to date.  You can start with
   everything marked as CE_VALID and run this once to drop
   CE_VALID bit for paths that are modified.

Most notably, "update-index --refresh" honours CE_VALID and does
not actively stat, so after you modified a file in the working
tree, update-index --refresh would not notice until you tell the
index about it with "git-update-index path" or "git-update-index
--no-assume-unchanged path".

This version is not expected to be perfect.  I think diff
between index and/or tree and working files may need some
adjustment, and there probably needs other cases we should
automatically unmark paths that are marked to be CE_VALID.

But the basics seem to work, and ready to be tested by people
who asked for this feature.

Signed-off-by: Junio C Hamano <junkio@cox.net>

---

 apply.c          |    2 +-
 cache.h          |    6 +++--
 checkout-index.c |    1 +
 config.c         |    5 ++++
 diff-files.c     |    2 +-
 diff-index.c     |    2 +-
 diff.c           |    2 +-
 entry.c          |    2 +-
 environment.c    |    1 +
 read-cache.c     |   28 +++++++++++++++++++----
 read-tree.c      |    2 +-
 update-index.c   |   65 ++++++++++++++++++++++++++++++++++++++++++++++++------
 write-tree.c     |    2 +-
 13 files changed, 99 insertions(+), 21 deletions(-)

b169290f100cfa67b785c361bcae83f807487f5e
diff --git a/apply.c b/apply.c
index 2ad47fb..35ae48e 100644
--- a/apply.c
+++ b/apply.c
@@ -1309,7 +1309,7 @@ static int check_patch(struct patch *pat
 					return -1;
 			}
 
-			changed = ce_match_stat(active_cache[pos], &st);
+			changed = ce_match_stat(active_cache[pos], &st, 1);
 			if (changed)
 				return error("%s: does not match index",
 					     old_name);
diff --git a/cache.h b/cache.h
index bdbe2d6..cd58fad 100644
--- a/cache.h
+++ b/cache.h
@@ -91,6 +91,7 @@ struct cache_entry {
 #define CE_NAMEMASK  (0x0fff)
 #define CE_STAGEMASK (0x3000)
 #define CE_UPDATE    (0x4000)
+#define CE_VALID     (0x8000)
 #define CE_STAGESHIFT 12
 
 #define create_ce_flags(len, stage) htons((len) | ((stage) << CE_STAGESHIFT))
@@ -144,8 +145,8 @@ extern int add_cache_entry(struct cache_
 extern int remove_cache_entry_at(int pos);
 extern int remove_file_from_cache(const char *path);
 extern int ce_same_name(struct cache_entry *a, struct cache_entry *b);
-extern int ce_match_stat(struct cache_entry *ce, struct stat *st);
-extern int ce_modified(struct cache_entry *ce, struct stat *st);
+extern int ce_match_stat(struct cache_entry *ce, struct stat *st, int);
+extern int ce_modified(struct cache_entry *ce, struct stat *st, int);
 extern int ce_path_match(const struct cache_entry *ce, const char **pathspec);
 extern int index_fd(unsigned char *sha1, int fd, struct stat *st, int write_object, const char *type);
 extern int index_pipe(unsigned char *sha1, int fd, const char *type, int write_object);
@@ -161,6 +162,7 @@ extern int commit_index_file(struct cach
 extern void rollback_index_file(struct cache_file *);
 
 extern int trust_executable_bit;
+extern int assume_unchanged;
 extern int only_use_symrefs;
 extern int diff_rename_limit_default;
 extern int shared_repository;
diff --git a/checkout-index.c b/checkout-index.c
index 53dd8cb..957b4a8 100644
--- a/checkout-index.c
+++ b/checkout-index.c
@@ -116,6 +116,7 @@ int main(int argc, char **argv)
 	int all = 0;
 
 	prefix = setup_git_directory();
+	git_config(git_default_config);
 	prefix_length = prefix ? strlen(prefix) : 0;
 
 	if (read_cache() < 0) {
diff --git a/config.c b/config.c
index 8355224..7dbdce1 100644
--- a/config.c
+++ b/config.c
@@ -222,6 +222,11 @@ int git_default_config(const char *var, 
 		return 0;
 	}
 
+	if (!strcmp(var, "core.ignorestat")) {
+		assume_unchanged = git_config_bool(var, value);
+		return 0;
+	}
+
 	if (!strcmp(var, "core.symrefsonly")) {
 		only_use_symrefs = git_config_bool(var, value);
 		return 0;
diff --git a/diff-files.c b/diff-files.c
index d24d11c..c96ad35 100644
--- a/diff-files.c
+++ b/diff-files.c
@@ -191,7 +191,7 @@ int main(int argc, const char **argv)
 			show_file('-', ce);
 			continue;
 		}
-		changed = ce_match_stat(ce, &st);
+		changed = ce_match_stat(ce, &st, 0);
 		if (!changed && !diff_options.find_copies_harder)
 			continue;
 		oldmode = ntohl(ce->ce_mode);
diff --git a/diff-index.c b/diff-index.c
index f8a102e..12a9418 100644
--- a/diff-index.c
+++ b/diff-index.c
@@ -33,7 +33,7 @@ static int get_stat_data(struct cache_en
 			}
 			return -1;
 		}
-		changed = ce_match_stat(ce, &st);
+		changed = ce_match_stat(ce, &st, 0);
 		if (changed) {
 			mode = create_ce_mode(st.st_mode);
 			if (!trust_executable_bit &&
diff --git a/diff.c b/diff.c
index ec51e7d..c72064e 100644
--- a/diff.c
+++ b/diff.c
@@ -311,7 +311,7 @@ static int work_tree_matches(const char 
 	ce = active_cache[pos];
 	if ((lstat(name, &st) < 0) ||
 	    !S_ISREG(st.st_mode) || /* careful! */
-	    ce_match_stat(ce, &st) ||
+	    ce_match_stat(ce, &st, 0) ||
 	    memcmp(sha1, ce->sha1, 20))
 		return 0;
 	/* we return 1 only when we can stat, it is a regular file,
diff --git a/entry.c b/entry.c
index 6c47c3a..8fb99bc 100644
--- a/entry.c
+++ b/entry.c
@@ -123,7 +123,7 @@ int checkout_entry(struct cache_entry *c
 	strcpy(path + len, ce->name);
 
 	if (!lstat(path, &st)) {
-		unsigned changed = ce_match_stat(ce, &st);
+		unsigned changed = ce_match_stat(ce, &st, 1);
 		if (!changed)
 			return 0;
 		if (!state->force) {
diff --git a/environment.c b/environment.c
index 0596fc6..251e53c 100644
--- a/environment.c
+++ b/environment.c
@@ -12,6 +12,7 @@
 char git_default_email[MAX_GITNAME];
 char git_default_name[MAX_GITNAME];
 int trust_executable_bit = 1;
+int assume_unchanged = 0;
 int only_use_symrefs = 0;
 int repository_format_version = 0;
 char git_commit_encoding[MAX_ENCODING_LENGTH] = "utf-8";
diff --git a/read-cache.c b/read-cache.c
index c5474d4..efbb1be 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -27,6 +27,9 @@ void fill_stat_cache_info(struct cache_e
 	ce->ce_uid = htonl(st->st_uid);
 	ce->ce_gid = htonl(st->st_gid);
 	ce->ce_size = htonl(st->st_size);
+
+	if (assume_unchanged)
+		ce->ce_flags |= htons(CE_VALID);
 }
 
 static int ce_compare_data(struct cache_entry *ce, struct stat *st)
@@ -146,9 +149,18 @@ static int ce_match_stat_basic(struct ca
 	return changed;
 }
 
-int ce_match_stat(struct cache_entry *ce, struct stat *st)
+int ce_match_stat(struct cache_entry *ce, struct stat *st, int ignore_valid)
 {
-	unsigned int changed = ce_match_stat_basic(ce, st);
+	unsigned int changed;
+
+	/*
+	 * If it's marked as always valid in the index, it's
+	 * valid whatever the checked-out copy says.
+	 */
+	if (!ignore_valid && (ce->ce_flags & htons(CE_VALID)))
+		return 0;
+
+	changed = ce_match_stat_basic(ce, st);
 
 	/*
 	 * Within 1 second of this sequence:
@@ -164,7 +176,7 @@ int ce_match_stat(struct cache_entry *ce
 	 * effectively mean we can make at most one commit per second,
 	 * which is not acceptable.  Instead, we check cache entries
 	 * whose mtime are the same as the index file timestamp more
-	 * careful than others.
+	 * carefully than others.
 	 */
 	if (!changed &&
 	    index_file_timestamp &&
@@ -174,10 +186,10 @@ int ce_match_stat(struct cache_entry *ce
 	return changed;
 }
 
-int ce_modified(struct cache_entry *ce, struct stat *st)
+int ce_modified(struct cache_entry *ce, struct stat *st, int really)
 {
 	int changed, changed_fs;
-	changed = ce_match_stat(ce, st);
+	changed = ce_match_stat(ce, st, really);
 	if (!changed)
 		return 0;
 	/*
@@ -233,6 +245,11 @@ int cache_name_compare(const char *name1
 		return -1;
 	if (len1 > len2)
 		return 1;
+
+	/* Differences between "assume up-to-date" should not matter. */
+	flags1 &= ~CE_VALID;
+	flags2 &= ~CE_VALID;
+
 	if (flags1 < flags2)
 		return -1;
 	if (flags1 > flags2)
@@ -430,6 +447,7 @@ int add_cache_entry(struct cache_entry *
 	int ok_to_add = option & ADD_CACHE_OK_TO_ADD;
 	int ok_to_replace = option & ADD_CACHE_OK_TO_REPLACE;
 	int skip_df_check = option & ADD_CACHE_SKIP_DFCHECK;
+
 	pos = cache_name_pos(ce->name, ntohs(ce->ce_flags));
 
 	/* existing match? Just replace it. */
diff --git a/read-tree.c b/read-tree.c
index 5580f15..52f06e3 100644
--- a/read-tree.c
+++ b/read-tree.c
@@ -349,7 +349,7 @@ static void verify_uptodate(struct cache
 		return;
 
 	if (!lstat(ce->name, &st)) {
-		unsigned changed = ce_match_stat(ce, &st);
+		unsigned changed = ce_match_stat(ce, &st, 1);
 		if (!changed)
 			return;
 		errno = 0;
diff --git a/update-index.c b/update-index.c
index afec98d..767fd49 100644
--- a/update-index.c
+++ b/update-index.c
@@ -23,6 +23,10 @@ static int quiet; /* --refresh needing u
 static int info_only;
 static int force_remove;
 static int verbose;
+static int mark_valid_only = 0;
+#define MARK_VALID 1
+#define UNMARK_VALID 2
+
 
 /* Three functions to allow overloaded pointer return; see linux/err.h */
 static inline void *ERR_PTR(long error)
@@ -53,6 +57,25 @@ static void report(const char *fmt, ...)
 	va_end(vp);
 }
 
+static int mark_valid(const char *path)
+{
+	int namelen = strlen(path);
+	int pos = cache_name_pos(path, namelen);
+	if (0 <= pos) {
+		switch (mark_valid_only) {
+		case MARK_VALID:
+			active_cache[pos]->ce_flags |= htons(CE_VALID);
+			break;
+		case UNMARK_VALID:
+			active_cache[pos]->ce_flags &= ~htons(CE_VALID);
+			break;
+		}
+		active_cache_changed = 1;
+		return 0;
+	}
+	return -1;
+}
+
 static int add_file_to_cache(const char *path)
 {
 	int size, namelen, option, status;
@@ -94,6 +117,7 @@ static int add_file_to_cache(const char 
 	ce = xmalloc(size);
 	memset(ce, 0, size);
 	memcpy(ce->name, path, namelen);
+	ce->ce_flags = htons(namelen);
 	fill_stat_cache_info(ce, &st);
 
 	ce->ce_mode = create_ce_mode(st.st_mode);
@@ -105,7 +129,6 @@ static int add_file_to_cache(const char 
 		if (0 <= pos)
 			ce->ce_mode = active_cache[pos]->ce_mode;
 	}
-	ce->ce_flags = htons(namelen);
 
 	if (index_path(ce->sha1, path, &st, !info_only))
 		return -1;
@@ -128,7 +151,7 @@ static int add_file_to_cache(const char 
  * For example, you'd want to do this after doing a "git-read-tree",
  * to link up the stat cache details with the proper files.
  */
-static struct cache_entry *refresh_entry(struct cache_entry *ce)
+static struct cache_entry *refresh_entry(struct cache_entry *ce, int really)
 {
 	struct stat st;
 	struct cache_entry *updated;
@@ -137,21 +160,22 @@ static struct cache_entry *refresh_entry
 	if (lstat(ce->name, &st) < 0)
 		return ERR_PTR(-errno);
 
-	changed = ce_match_stat(ce, &st);
+	changed = ce_match_stat(ce, &st, really);
 	if (!changed)
 		return NULL;
 
-	if (ce_modified(ce, &st))
+	if (ce_modified(ce, &st, really))
 		return ERR_PTR(-EINVAL);
 
 	size = ce_size(ce);
 	updated = xmalloc(size);
 	memcpy(updated, ce, size);
 	fill_stat_cache_info(updated, &st);
+
 	return updated;
 }
 
-static int refresh_cache(void)
+static int refresh_cache(int really)
 {
 	int i;
 	int has_errors = 0;
@@ -171,12 +195,19 @@ static int refresh_cache(void)
 			continue;
 		}
 
-		new = refresh_entry(ce);
+		new = refresh_entry(ce, really);
 		if (!new)
 			continue;
 		if (IS_ERR(new)) {
 			if (not_new && PTR_ERR(new) == -ENOENT)
 				continue;
+			if (really && PTR_ERR(new) == -EINVAL) {
+				/* If we are doing --really-refresh that
+				 * means the index is not valid anymore.
+				 */
+				ce->ce_flags &= ~htons(CE_VALID);
+				active_cache_changed = 1;
+			}
 			if (quiet)
 				continue;
 			printf("%s: needs update\n", ce->name);
@@ -274,6 +305,8 @@ static int add_cacheinfo(unsigned int mo
 	memcpy(ce->name, path, len);
 	ce->ce_flags = create_ce_flags(len, stage);
 	ce->ce_mode = create_ce_mode(mode);
+	if (assume_unchanged)
+		ce->ce_flags |= htons(CE_VALID);
 	option = allow_add ? ADD_CACHE_OK_TO_ADD : 0;
 	option |= allow_replace ? ADD_CACHE_OK_TO_REPLACE : 0;
 	if (add_cache_entry(ce, option))
@@ -317,6 +350,12 @@ static void update_one(const char *path,
 		fprintf(stderr, "Ignoring path %s\n", path);
 		return;
 	}
+	if (mark_valid_only) {
+		if (mark_valid(p))
+			die("Unable to mark file %s", path);
+		return;
+	}
+
 	if (force_remove) {
 		if (remove_file_from_cache(p))
 			die("git-update-index: unable to remove %s", path);
@@ -467,7 +506,11 @@ int main(int argc, const char **argv)
 				continue;
 			}
 			if (!strcmp(path, "--refresh")) {
-				has_errors |= refresh_cache();
+				has_errors |= refresh_cache(0);
+				continue;
+			}
+			if (!strcmp(path, "--really-refresh")) {
+				has_errors |= refresh_cache(1);
 				continue;
 			}
 			if (!strcmp(path, "--cacheinfo")) {
@@ -493,6 +536,14 @@ int main(int argc, const char **argv)
 					die("git-update-index: %s cannot chmod %s", path, argv[i]);
 				continue;
 			}
+			if (!strcmp(path, "--assume-unchanged")) {
+				mark_valid_only = MARK_VALID;
+				continue;
+			}
+			if (!strcmp(path, "--no-assume-unchanged")) {
+				mark_valid_only = UNMARK_VALID;
+				continue;
+			}
 			if (!strcmp(path, "--info-only")) {
 				info_only = 1;
 				continue;
diff --git a/write-tree.c b/write-tree.c
index f866059..addb5de 100644
--- a/write-tree.c
+++ b/write-tree.c
@@ -111,7 +111,7 @@ int main(int argc, char **argv)
 	funny = 0;
 	for (i = 0; i < entries; i++) {
 		struct cache_entry *ce = active_cache[i];
-		if (ntohs(ce->ce_flags) & ~CE_NAMEMASK) {
+		if (ce_stage(ce)) {
 			if (10 < ++funny) {
 				fprintf(stderr, "...\n");
 				break;
-- 
1.1.6.gbb042
