From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Re* [PATCH] Make git add -u honor --dry-run
Date: Thu, 22 May 2008 11:16:31 -0700
Message-ID: <7vskwauruo.fsf@gitster.siamese.dyndns.org>
References: <482C5FF8.1060200@isy.liu.se>
 <1210868459-9511-1-git-send-email-vmiklos@frugalware.org>
 <7vmymrf81x.fsf@gitster.siamese.dyndns.org> <4831FBD8.3050402@isy.liu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Miklos Vajna <vmiklos@frugalware.org>,
	Git Mailing List <git@vger.kernel.org>
To: Gustaf Hendeby <hendeby@isy.liu.se>
X-From: git-owner@vger.kernel.org Thu May 22 20:18:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JzFML-0000w2-6A
	for gcvg-git-2@gmane.org; Thu, 22 May 2008 20:17:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751074AbYEVSQt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 May 2008 14:16:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752864AbYEVSQt
	(ORCPT <rfc822;git-outgoing>); Thu, 22 May 2008 14:16:49 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:53135 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751698AbYEVSQr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 May 2008 14:16:47 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 8A1891608;
	Thu, 22 May 2008 14:16:45 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id B0C761002; Thu, 22 May 2008 14:16:39 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 3C8C8E76-282B-11DD-BB4F-80001473D85F-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82645>

Gustaf Hendeby <hendeby@isy.liu.se> writes:

> On 2008-05-16 01:42, Junio C Hamano wrote:
>> Miklos Vajna <vmiklos@frugalware.org> writes:
>>> On Thu, May 15, 2008 at 06:08:24PM +0200, Gustaf Hendeby <hendeby@isy.liu.se> wrote:
>>>> I'm not familiar enough with the code to see how to best fix it.
>>
>> That makes the whole thing noop, doesn't it?  We could do the surgery at a
>> bit lower layer, I guess.
>
> What is the status on this one?  I've been away for a while and when I
> got back I didn't see any more than this suggestion.

We need a slightly different patch for 'master' (for 1.5.6) and 'maint'
(for 1.5.5.X), due to recent introduction of add_to_index() API.  This is
an updated one for 'master'; I rolled your one-liner fix into it as well.

-- >8 --
Subject: "git-add -n -u" should not add but just report

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin-add.c         |   22 +++++++++++++---------
 builtin-checkout.c    |    2 +-
 builtin-commit.c      |    2 +-
 builtin-mv.c          |    2 +-
 cache.h               |   12 +++++++-----
 read-cache.c          |   23 +++++++++++++++++------
 t/t2200-add-update.sh |   17 +++++++++++++++++
 7 files changed, 57 insertions(+), 23 deletions(-)

diff --git a/builtin-add.c b/builtin-add.c
index 4a91e3e..05af57f 100644
--- a/builtin-add.c
+++ b/builtin-add.c
@@ -82,9 +82,9 @@ static void fill_directory(struct dir_struct *dir, const char **pathspec,
 static void update_callback(struct diff_queue_struct *q,
 			    struct diff_options *opt, void *cbdata)
 {
-	int i, verbose;
+	int i, flags;
 
-	verbose = *((int *)cbdata);
+	flags = *((int *)cbdata);
 	for (i = 0; i < q->nr; i++) {
 		struct diff_filepair *p = q->queue[i];
 		const char *path = p->one->path;
@@ -94,18 +94,19 @@ static void update_callback(struct diff_queue_struct *q,
 		case DIFF_STATUS_UNMERGED:
 		case DIFF_STATUS_MODIFIED:
 		case DIFF_STATUS_TYPE_CHANGED:
-			add_file_to_cache(path, verbose);
+			add_file_to_cache(path, flags);
 			break;
 		case DIFF_STATUS_DELETED:
-			remove_file_from_cache(path);
-			if (verbose)
+			if (!(flags & ADD_CACHE_PRETEND))
+				remove_file_from_cache(path);
+			if (flags)
 				printf("remove '%s'\n", path);
 			break;
 		}
 	}
 }
 
-void add_files_to_cache(int verbose, const char *prefix, const char **pathspec)
+void add_files_to_cache(const char *prefix, const char **pathspec, int flags)
 {
 	struct rev_info rev;
 	init_revisions(&rev, prefix);
@@ -113,7 +114,7 @@ void add_files_to_cache(int verbose, const char *prefix, const char **pathspec)
 	rev.prune_data = pathspec;
 	rev.diffopt.output_format = DIFF_FORMAT_CALLBACK;
 	rev.diffopt.format_callback = update_callback;
-	rev.diffopt.format_callback_data = &verbose;
+	rev.diffopt.format_callback_data = &flags;
 	run_diff_files(&rev, DIFF_RACY_IS_MODIFIED);
 }
 
@@ -209,10 +210,13 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 
 	if (take_worktree_changes) {
 		const char **pathspec;
+		int flags = ((verbose ? ADD_CACHE_VERBOSE : 0) |
+			     (show_only ? ADD_CACHE_PRETEND : 0));
+
 		if (read_cache() < 0)
 			die("index file corrupt");
 		pathspec = get_pathspec(prefix, argv);
-		add_files_to_cache(verbose, prefix, pathspec);
+		add_files_to_cache(prefix, pathspec, flags);
 		goto finish;
 	}
 
@@ -254,7 +258,7 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 	}
 
 	for (i = 0; i < dir.nr; i++)
-		add_file_to_cache(dir.entries[i]->name, verbose);
+		add_file_to_cache(dir.entries[i]->name, verbose ? ADD_CACHE_VERBOSE : 0);
 
  finish:
 	if (active_cache_changed) {
diff --git a/builtin-checkout.c b/builtin-checkout.c
index 10ec137..05c0642 100644
--- a/builtin-checkout.c
+++ b/builtin-checkout.c
@@ -282,7 +282,7 @@ static int merge_working_tree(struct checkout_opts *opts,
 			 * entries in the index.
 			 */
 
-			add_files_to_cache(0, NULL, NULL);
+			add_files_to_cache(NULL, NULL, 0);
 			work = write_tree_from_memory();
 
 			ret = reset_to_new(new->commit->tree, opts->quiet);
diff --git a/builtin-commit.c b/builtin-commit.c
index 0baec6d..924fca1 100644
--- a/builtin-commit.c
+++ b/builtin-commit.c
@@ -246,7 +246,7 @@ static char *prepare_index(int argc, const char **argv, const char *prefix)
 	 */
 	if (all || (also && pathspec && *pathspec)) {
 		int fd = hold_locked_index(&index_lock, 1);
-		add_files_to_cache(0, also ? prefix : NULL, pathspec);
+		add_files_to_cache(also ? prefix : NULL, pathspec, 0);
 		refresh_cache(REFRESH_QUIET);
 		if (write_cache(fd, active_cache, active_nr) ||
 		    close_lock_file(&index_lock))
diff --git a/builtin-mv.c b/builtin-mv.c
index 94f6dd2..df9ea97 100644
--- a/builtin-mv.c
+++ b/builtin-mv.c
@@ -256,7 +256,7 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 
 		for (i = 0; i < added.nr; i++) {
 			const char *path = added.items[i].path;
-			add_file_to_cache(path, verbose);
+			add_file_to_cache(path, verbose ? ADD_CACHE_VERBOSE : 0);
 		}
 
 		for (i = 0; i < deleted.nr; i++)
diff --git a/cache.h b/cache.h
index 093f04c..b1a8427 100644
--- a/cache.h
+++ b/cache.h
@@ -261,8 +261,8 @@ static inline void remove_name_hash(struct cache_entry *ce)
 #define add_cache_entry(ce, option) add_index_entry(&the_index, (ce), (option))
 #define remove_cache_entry_at(pos) remove_index_entry_at(&the_index, (pos))
 #define remove_file_from_cache(path) remove_file_from_index(&the_index, (path))
-#define add_to_cache(path, st, verbose) add_to_index(&the_index, (path), (st), (verbose))
-#define add_file_to_cache(path, verbose) add_file_to_index(&the_index, (path), (verbose))
+#define add_to_cache(path, st, flags) add_to_index(&the_index, (path), (st), (flags))
+#define add_file_to_cache(path, flags) add_file_to_index(&the_index, (path), (flags))
 #define refresh_cache(flags) refresh_index(&the_index, (flags), NULL, NULL)
 #define ce_match_stat(ce, st, options) ie_match_stat(&the_index, (ce), (st), (options))
 #define ce_modified(ce, st, options) ie_modified(&the_index, (ce), (st), (options))
@@ -366,8 +366,10 @@ extern int add_index_entry(struct index_state *, struct cache_entry *ce, int opt
 extern struct cache_entry *refresh_cache_entry(struct cache_entry *ce, int really);
 extern int remove_index_entry_at(struct index_state *, int pos);
 extern int remove_file_from_index(struct index_state *, const char *path);
-extern int add_to_index(struct index_state *, const char *path, struct stat *, int verbose);
-extern int add_file_to_index(struct index_state *, const char *path, int verbose);
+#define ADD_CACHE_VERBOSE 1
+#define ADD_CACHE_PRETEND 2
+extern int add_to_index(struct index_state *, const char *path, struct stat *, int flags);
+extern int add_file_to_index(struct index_state *, const char *path, int flags);
 extern struct cache_entry *make_cache_entry(unsigned int mode, const unsigned char *sha1, const char *path, int stage, int refresh);
 extern int ce_same_name(struct cache_entry *a, struct cache_entry *b);
 
@@ -782,7 +784,7 @@ extern int convert_to_git(const char *path, const char *src, size_t len,
 extern int convert_to_working_tree(const char *path, const char *src, size_t len, struct strbuf *dst);
 
 /* add */
-void add_files_to_cache(int verbose, const char *prefix, const char **pathspec);
+void add_files_to_cache(const char *prefix, const char **pathspec, int flags);
 
 /* diff.c */
 extern int diff_auto_refresh_index;
diff --git a/read-cache.c b/read-cache.c
index 0382804..5d967e8 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -462,12 +462,14 @@ static struct cache_entry *create_alias_ce(struct cache_entry *ce, struct cache_
 	return new;
 }
 
-int add_to_index(struct index_state *istate, const char *path, struct stat *st, int verbose)
+int add_to_index(struct index_state *istate, const char *path, struct stat *st, int flags)
 {
-	int size, namelen;
+	int size, namelen, was_same;
 	mode_t st_mode = st->st_mode;
 	struct cache_entry *ce, *alias;
 	unsigned ce_option = CE_MATCH_IGNORE_VALID|CE_MATCH_RACY_IS_DIRTY;
+	int verbose = flags & (ADD_CACHE_VERBOSE | ADD_CACHE_PRETEND);
+	int pretend = flags & ADD_CACHE_PRETEND;
 
 	if (!S_ISREG(st_mode) && !S_ISLNK(st_mode) && !S_ISDIR(st_mode))
 		die("%s: can only add regular files, symbolic links or git-directories", path);
@@ -509,19 +511,28 @@ int add_to_index(struct index_state *istate, const char *path, struct stat *st,
 	if (ignore_case && alias && different_name(ce, alias))
 		ce = create_alias_ce(ce, alias);
 	ce->ce_flags |= CE_ADDED;
-	if (add_index_entry(istate, ce, ADD_CACHE_OK_TO_ADD|ADD_CACHE_OK_TO_REPLACE))
+
+	/* It was suspected to be recily clean, but it turns out to be Ok */
+	was_same = (alias &&
+		    !ce_stage(alias) &&
+		    !hashcmp(alias->sha1, ce->sha1) &&
+		    ce->ce_mode == alias->ce_mode);
+
+	if (pretend)
+		;
+	else if (add_index_entry(istate, ce, ADD_CACHE_OK_TO_ADD|ADD_CACHE_OK_TO_REPLACE))
 		die("unable to add %s to index",path);
-	if (verbose)
+	if (verbose && !was_same)
 		printf("add '%s'\n", path);
 	return 0;
 }
 
-int add_file_to_index(struct index_state *istate, const char *path, int verbose)
+int add_file_to_index(struct index_state *istate, const char *path, int flags)
 {
 	struct stat st;
 	if (lstat(path, &st))
 		die("%s: unable to stat (%s)", path, strerror(errno));
-	return add_to_index(istate, path, &st, verbose);
+	return add_to_index(istate, path, &st, flags);
 }
 
 struct cache_entry *make_cache_entry(unsigned int mode,
diff --git a/t/t2200-add-update.sh b/t/t2200-add-update.sh
index b664341..f57a6e0 100755
--- a/t/t2200-add-update.sh
+++ b/t/t2200-add-update.sh
@@ -111,4 +111,21 @@ test_expect_success 'touch and then add explicitly' '
 
 '
 
+test_expect_success 'add -n -u should not add but just report' '
+
+	(
+		echo "add '\''check'\''" &&
+		echo "remove '\''top'\''"
+	) >expect &&
+	before=$(git ls-files -s check top) &&
+	echo changed >>check &&
+	rm -f top &&
+	git add -n -u >actual &&
+	after=$(git ls-files -s check top) &&
+
+	test "$before" = "$after" &&
+	test_cmp expect actual
+
+'
+
 test_done
