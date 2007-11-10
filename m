From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/2] ce_match_stat, run_diff_files: use symbolic constants for readability
Date: Sat, 10 Nov 2007 01:01:33 -0800
Message-ID: <7v1waypj82.fsf_-_@gitster.siamese.dyndns.org>
References: <1194626427-2419-1-git-send-email-krh@redhat.com>
	<Pine.LNX.4.64.0711091702190.4362@racer.site>
	<7vhcjvtgz5.fsf@gitster.siamese.dyndns.org>
	<7vzlxmq1oj.fsf_-_@gitster.siamese.dyndns.org>
	<alpine.LFD.0.999.0711091840120.15101@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Kristian =?utf-8?Q?H=C3=B8gsberg?= <krh@redhat.com>,
	git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sat Nov 10 10:02:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IqmEE-00032g-RT
	for gcvg-git-2@gmane.org; Sat, 10 Nov 2007 10:02:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750805AbXKJJBs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Nov 2007 04:01:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750766AbXKJJBs
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Nov 2007 04:01:48 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:56875 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750695AbXKJJBq (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Nov 2007 04:01:46 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 560742F9;
	Sat, 10 Nov 2007 04:02:03 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id EADA392479;
	Sat, 10 Nov 2007 04:01:57 -0500 (EST)
In-Reply-To: <alpine.LFD.0.999.0711091840120.15101@woody.linux-foundation.org>
	(Linus Torvalds's message of "Fri, 9 Nov 2007 18:43:07 -0800 (PST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64316>

ce_match_stat() can be told:

 (1) to ignore CE_VALID bit (used under "assume unchanged" mode)
     and perform the stat comparison anyway;

 (2) not to perform the contents comparison for racily clean
     entries and report mismatch of cached stat information;

using its "option" parameter.  Give them symbolic constants.

Similarly, run_diff_files() can be told not to report anything
on removed paths.  Also give it a symbolic constant for that.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 Linus Torvalds <torvalds@linux-foundation.org> writes:

 > On Fri, 9 Nov 2007, Junio C Hamano wrote:
 >>  
 >> -int run_diff_files(struct rev_info *revs, int silent_on_removed)
 >> +int run_diff_files(struct rev_info *revs, int option)
 >
 > Wouldn't it be much better to now 
 >  - make it "unsigned int flags"
 >  - create a few enums or #define's to make the usage be more readable?
 >
 > Because this:
 >
 >>-       run_diff_files(&rev, 0);
 >>+       run_diff_files(&rev, 2);
 >> -	    !ie_modified(istate, istate->cache[pos], &st, 1)) {
 >> +	    !ie_match_stat(istate, istate->cache[pos], &st, 3)) {
 >
 > just went from subtle to "incredibly non-obvious".

 That really is true.  Apparently I am getting much slower
 lately.  This is to just introduce the constants and change the
 types.

 builtin-apply.c |    2 +-
 cache.h         |   14 ++++++++++----
 check-racy.c    |    2 +-
 diff-lib.c      |   16 +++++++++-------
 diff.h          |    4 +++-
 entry.c         |    2 +-
 read-cache.c    |   47 ++++++++++++++++++++++++++++++-----------------
 unpack-trees.c  |    4 ++--
 8 files changed, 57 insertions(+), 34 deletions(-)

diff --git a/builtin-apply.c b/builtin-apply.c
index 5cc90e6..0fff02e 100644
--- a/builtin-apply.c
+++ b/builtin-apply.c
@@ -2099,7 +2099,7 @@ static int verify_index_match(struct cache_entry *ce, struct stat *st)
 			return -1;
 		return 0;
 	}
-	return ce_match_stat(ce, st, 1);
+	return ce_match_stat(ce, st, CE_MATCH_IGNORE_VALID);
 }
 
 static int check_patch(struct patch *patch, struct patch *prev_patch)
diff --git a/cache.h b/cache.h
index fc195bc..31af16a 100644
--- a/cache.h
+++ b/cache.h
@@ -174,8 +174,8 @@ extern struct index_state the_index;
 #define remove_file_from_cache(path) remove_file_from_index(&the_index, (path))
 #define add_file_to_cache(path, verbose) add_file_to_index(&the_index, (path), (verbose))
 #define refresh_cache(flags) refresh_index(&the_index, (flags), NULL, NULL)
-#define ce_match_stat(ce, st, really) ie_match_stat(&the_index, (ce), (st), (really))
-#define ce_modified(ce, st, really) ie_modified(&the_index, (ce), (st), (really))
+#define ce_match_stat(ce, st, options) ie_match_stat(&the_index, (ce), (st), (options))
+#define ce_modified(ce, st, options) ie_modified(&the_index, (ce), (st), (options))
 #endif
 
 enum object_type {
@@ -266,8 +266,14 @@ extern int remove_file_from_index(struct index_state *, const char *path);
 extern int add_file_to_index(struct index_state *, const char *path, int verbose);
 extern struct cache_entry *make_cache_entry(unsigned int mode, const unsigned char *sha1, const char *path, int stage, int refresh);
 extern int ce_same_name(struct cache_entry *a, struct cache_entry *b);
-extern int ie_match_stat(struct index_state *, struct cache_entry *, struct stat *, int);
-extern int ie_modified(struct index_state *, struct cache_entry *, struct stat *, int);
+
+/* do stat comparison even if CE_VALID is true */
+#define CE_MATCH_IGNORE_VALID		01
+/* do not check the contents but report dirty on racily-clean entries */
+#define CE_MATCH_RACY_IS_DIRTY	02
+extern int ie_match_stat(struct index_state *, struct cache_entry *, struct stat *, unsigned int);
+extern int ie_modified(struct index_state *, struct cache_entry *, struct stat *, unsigned int);
+
 extern int ce_path_match(const struct cache_entry *ce, const char **pathspec);
 extern int index_fd(unsigned char *sha1, int fd, struct stat *st, int write_object, enum object_type type, const char *path);
 extern int read_fd(int fd, char **return_buf, unsigned long *return_size);
diff --git a/check-racy.c b/check-racy.c
index d6a08b4..00d92a1 100644
--- a/check-racy.c
+++ b/check-racy.c
@@ -18,7 +18,7 @@ int main(int ac, char **av)
 
 		if (ce_match_stat(ce, &st, 0))
 			dirty++;
-		else if (ce_match_stat(ce, &st, 2))
+		else if (ce_match_stat(ce, &st, CE_MATCH_RACY_IS_DIRTY))
 			racy++;
 		else
 			clean++;
diff --git a/diff-lib.c b/diff-lib.c
index da55713..9f8afbe 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -173,9 +173,10 @@ static int is_in_index(const char *path)
 }
 
 static int handle_diff_files_args(struct rev_info *revs,
-		int argc, const char **argv, int *silent)
+				  int argc, const char **argv,
+				  unsigned int *options)
 {
-	*silent = 0;
+	*options = 0;
 
 	/* revs->max_count == -2 means --no-index */
 	while (1 < argc && argv[1][0] == '-') {
@@ -192,7 +193,7 @@ static int handle_diff_files_args(struct rev_info *revs,
 			revs->diffopt.no_index = 1;
 		}
 		else if (!strcmp(argv[1], "-q"))
-			*silent = 1;
+			*options |= DIFF_SILENT_ON_REMOVED;
 		else
 			return error("invalid option: %s", argv[1]);
 		argv++; argc--;
@@ -305,9 +306,9 @@ int setup_diff_no_index(struct rev_info *revs,
 
 int run_diff_files_cmd(struct rev_info *revs, int argc, const char **argv)
 {
-	int silent_on_removed;
+	unsigned int options;
 
-	if (handle_diff_files_args(revs, argc, argv, &silent_on_removed))
+	if (handle_diff_files_args(revs, argc, argv, &options))
 		return -1;
 
 	if (revs->diffopt.no_index) {
@@ -329,13 +330,14 @@ int run_diff_files_cmd(struct rev_info *revs, int argc, const char **argv)
 		perror("read_cache");
 		return -1;
 	}
-	return run_diff_files(revs, silent_on_removed);
+	return run_diff_files(revs, options);
 }
 
-int run_diff_files(struct rev_info *revs, int silent_on_removed)
+int run_diff_files(struct rev_info *revs, unsigned int option)
 {
 	int entries, i;
 	int diff_unmerged_stage = revs->max_count;
+	int silent_on_removed = option & DIFF_SILENT_ON_REMOVED;
 
 	if (diff_unmerged_stage < 0)
 		diff_unmerged_stage = 2;
diff --git a/diff.h b/diff.h
index 4546aad..de533da 100644
--- a/diff.h
+++ b/diff.h
@@ -224,7 +224,9 @@ extern void diff_flush(struct diff_options*);
 
 extern const char *diff_unique_abbrev(const unsigned char *, int);
 
-extern int run_diff_files(struct rev_info *revs, int silent_on_removed);
+/* do not report anything on removed paths */
+#define DIFF_SILENT_ON_REMOVED 01
+extern int run_diff_files(struct rev_info *revs, unsigned int option);
 extern int setup_diff_no_index(struct rev_info *revs,
 		int argc, const char ** argv, int nongit, const char *prefix);
 extern int run_diff_files_cmd(struct rev_info *revs, int argc, const char **argv);
diff --git a/entry.c b/entry.c
index fc3a506..ef88f62 100644
--- a/entry.c
+++ b/entry.c
@@ -200,7 +200,7 @@ int checkout_entry(struct cache_entry *ce, const struct checkout *state, char *t
 	strcpy(path + len, ce->name);
 
 	if (!lstat(path, &st)) {
-		unsigned changed = ce_match_stat(ce, &st, 1);
+		unsigned changed = ce_match_stat(ce, &st, CE_MATCH_IGNORE_VALID);
 		if (!changed)
 			return 0;
 		if (!state->force) {
diff --git a/read-cache.c b/read-cache.c
index 928e8fa..9e4d4a9 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -194,11 +194,12 @@ static int ce_match_stat_basic(struct cache_entry *ce, struct stat *st)
 }
 
 int ie_match_stat(struct index_state *istate,
-		  struct cache_entry *ce, struct stat *st, int options)
+		  struct cache_entry *ce, struct stat *st,
+		  unsigned int options)
 {
 	unsigned int changed;
-	int ignore_valid = options & 01;
-	int assume_racy_is_modified = options & 02;
+	int ignore_valid = options & CE_MATCH_IGNORE_VALID;
+	int assume_racy_is_modified = options & CE_MATCH_RACY_IS_DIRTY;
 
 	/*
 	 * If it's marked as always valid in the index, it's
@@ -238,10 +239,11 @@ int ie_match_stat(struct index_state *istate,
 }
 
 int ie_modified(struct index_state *istate,
-		struct cache_entry *ce, struct stat *st, int really)
+		struct cache_entry *ce, struct stat *st, unsigned int options)
 {
 	int changed, changed_fs;
-	changed = ie_match_stat(istate, ce, st, really);
+
+	changed = ie_match_stat(istate, ce, st, options);
 	if (!changed)
 		return 0;
 	/*
@@ -420,7 +422,7 @@ int add_file_to_index(struct index_state *istate, const char *path, int verbose)
 	pos = index_name_pos(istate, ce->name, namelen);
 	if (0 <= pos &&
 	    !ce_stage(istate->cache[pos]) &&
-	    !ie_modified(istate, istate->cache[pos], &st, 1)) {
+	    !ie_modified(istate, istate->cache[pos], &st, CE_MATCH_IGNORE_VALID)) {
 		/* Nothing changed, really */
 		free(ce);
 		return 0;
@@ -782,11 +784,13 @@ int add_index_entry(struct index_state *istate, struct cache_entry *ce, int opti
  * to link up the stat cache details with the proper files.
  */
 static struct cache_entry *refresh_cache_ent(struct index_state *istate,
-					     struct cache_entry *ce, int really, int *err)
+					     struct cache_entry *ce,
+					     unsigned int options, int *err)
 {
 	struct stat st;
 	struct cache_entry *updated;
 	int changed, size;
+	int ignore_valid = options & CE_MATCH_IGNORE_VALID;
 
 	if (lstat(ce->name, &st) < 0) {
 		if (err)
@@ -794,16 +798,23 @@ static struct cache_entry *refresh_cache_ent(struct index_state *istate,
 		return NULL;
 	}
 
-	changed = ie_match_stat(istate, ce, &st, really);
+	changed = ie_match_stat(istate, ce, &st, options);
 	if (!changed) {
-		if (really && assume_unchanged &&
+		/*
+		 * The path is unchanged.  If we were told to ignore
+		 * valid bit, then we did the actual stat check and
+		 * found that the entry is unmodified.  If the entry
+		 * is not marked VALID, this is the place to mark it
+		 * valid again, under "assume unchanged" mode.
+		 */
+		if (ignore_valid && assume_unchanged &&
 		    !(ce->ce_flags & htons(CE_VALID)))
 			; /* mark this one VALID again */
 		else
 			return ce;
 	}
 
-	if (ie_modified(istate, ce, &st, really)) {
+	if (ie_modified(istate, ce, &st, options)) {
 		if (err)
 			*err = EINVAL;
 		return NULL;
@@ -814,13 +825,14 @@ static struct cache_entry *refresh_cache_ent(struct index_state *istate,
 	memcpy(updated, ce, size);
 	fill_stat_cache_info(updated, &st);
 
-	/* In this case, if really is not set, we should leave
-	 * CE_VALID bit alone.  Otherwise, paths marked with
-	 * --no-assume-unchanged (i.e. things to be edited) will
-	 * reacquire CE_VALID bit automatically, which is not
-	 * really what we want.
+	/*
+	 * If ignore_valid is not set, we should leave CE_VALID bit
+	 * alone.  Otherwise, paths marked with --no-assume-unchanged
+	 * (i.e. things to be edited) will reacquire CE_VALID bit
+	 * automatically, which is not really what we want.
 	 */
-	if (!really && assume_unchanged && !(ce->ce_flags & htons(CE_VALID)))
+	if (!ignore_valid && assume_unchanged &&
+	    !(ce->ce_flags & htons(CE_VALID)))
 		updated->ce_flags &= ~htons(CE_VALID);
 
 	return updated;
@@ -834,6 +846,7 @@ int refresh_index(struct index_state *istate, unsigned int flags, const char **p
 	int allow_unmerged = (flags & REFRESH_UNMERGED) != 0;
 	int quiet = (flags & REFRESH_QUIET) != 0;
 	int not_new = (flags & REFRESH_IGNORE_MISSING) != 0;
+	unsigned int options = really ? CE_MATCH_IGNORE_VALID : 0;
 
 	for (i = 0; i < istate->cache_nr; i++) {
 		struct cache_entry *ce, *new;
@@ -855,7 +868,7 @@ int refresh_index(struct index_state *istate, unsigned int flags, const char **p
 		if (pathspec && !match_pathspec(pathspec, ce->name, strlen(ce->name), 0, seen))
 			continue;
 
-		new = refresh_cache_ent(istate, ce, really, &cache_errno);
+		new = refresh_cache_ent(istate, ce, options, &cache_errno);
 		if (new == ce)
 			continue;
 		if (!new) {
diff --git a/unpack-trees.c b/unpack-trees.c
index ccfeb6e..9411c67 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -406,7 +406,7 @@ static void verify_uptodate(struct cache_entry *ce,
 		return;
 
 	if (!lstat(ce->name, &st)) {
-		unsigned changed = ce_match_stat(ce, &st, 1);
+		unsigned changed = ce_match_stat(ce, &st, CE_MATCH_IGNORE_VALID);
 		if (!changed)
 			return;
 		/*
@@ -927,7 +927,7 @@ int oneway_merge(struct cache_entry **src,
 		if (o->reset) {
 			struct stat st;
 			if (lstat(old->name, &st) ||
-			    ce_match_stat(old, &st, 1))
+			    ce_match_stat(old, &st, CE_MATCH_IGNORE_VALID))
 				old->ce_flags |= htons(CE_UPDATE);
 		}
 		return keep_entry(old, o);
-- 
1.5.3.5.1651.g30bf0
