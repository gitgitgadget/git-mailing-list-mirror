From: Junio C Hamano <gitster@pobox.com>
Subject: Re* [PATCH] Make git add -u honor --dry-run
Date: Thu, 15 May 2008 16:42:50 -0700
Message-ID: <7vmymrf81x.fsf@gitster.siamese.dyndns.org>
References: <482C5FF8.1060200@isy.liu.se>
 <1210868459-9511-1-git-send-email-vmiklos@frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Gustaf Hendeby <hendeby@isy.liu.se>,
	Git Mailing List <git@vger.kernel.org>
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Fri May 16 01:44:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jwn7E-0000lM-4G
	for gcvg-git-2@gmane.org; Fri, 16 May 2008 01:44:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754162AbYEOXnB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 May 2008 19:43:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753126AbYEOXnB
	(ORCPT <rfc822;git-outgoing>); Thu, 15 May 2008 19:43:01 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:43195 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751090AbYEOXnA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 May 2008 19:43:00 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 76C5C377A;
	Thu, 15 May 2008 19:42:57 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 075E13779; Thu, 15 May 2008 19:42:52 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: A56E5120-22D8-11DD-9EFC-80001473D85F-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82243>

Miklos Vajna <vmiklos@frugalware.org> writes:

> Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
> ---
>
> On Thu, May 15, 2008 at 06:08:24PM +0200, Gustaf Hendeby <hendeby@isy.liu.se> wrote:
>> I'm not familiar enough with the code to see how to best fix it.
>
> Something like this?
>
>  builtin-add.c         |    3 ++-
>  t/t2200-add-update.sh |    7 +++++++
>  2 files changed, 9 insertions(+), 1 deletions(-)
>
> diff --git a/builtin-add.c b/builtin-add.c
> index 4a91e3e..222497d 100644
> --- a/builtin-add.c
> +++ b/builtin-add.c
> @@ -212,7 +212,8 @@ int cmd_add(int argc, const char **argv, const char *prefix)
>  		if (read_cache() < 0)
>  			die("index file corrupt");
>  		pathspec = get_pathspec(prefix, argv);
> -		add_files_to_cache(verbose, prefix, pathspec);
> +		if(!show_only)
> +			add_files_to_cache(verbose, prefix, pathspec);
>  		goto finish;
>  	}

That makes the whole thing noop, doesn't it?  We could do the surgery at a
bit lower layer, I guess.


 cache.h          |    8 +++++---
 builtin-add.c    |   22 +++++++++++++---------
 builtin-commit.c |    2 +-
 builtin-mv.c     |    2 +-
 read-cache.c     |   20 ++++++++++++++++----
 5 files changed, 36 insertions(+), 18 deletions(-)

diff --git a/cache.h b/cache.h
index 98cfed6..cf30e53 100644
--- a/cache.h
+++ b/cache.h
@@ -173,7 +173,7 @@ extern struct index_state the_index;
 #define add_cache_entry(ce, option) add_index_entry(&the_index, (ce), (option))
 #define remove_cache_entry_at(pos) remove_index_entry_at(&the_index, (pos))
 #define remove_file_from_cache(path) remove_file_from_index(&the_index, (path))
-#define add_file_to_cache(path, verbose) add_file_to_index(&the_index, (path), (verbose))
+#define add_file_to_cache(path, flags) add_file_to_index(&the_index, (path), (flags))
 #define refresh_cache(flags) refresh_index(&the_index, (flags), NULL, NULL)
 #define ce_match_stat(ce, st, options) ie_match_stat(&the_index, (ce), (st), (options))
 #define ce_modified(ce, st, options) ie_modified(&the_index, (ce), (st), (options))
@@ -272,7 +272,9 @@ extern int add_index_entry(struct index_state *, struct cache_entry *ce, int opt
 extern struct cache_entry *refresh_cache_entry(struct cache_entry *ce, int really);
 extern int remove_index_entry_at(struct index_state *, int pos);
 extern int remove_file_from_index(struct index_state *, const char *path);
-extern int add_file_to_index(struct index_state *, const char *path, int verbose);
+#define ADD_CACHE_VERBOSE 1
+#define ADD_CACHE_PRETEND 2
+extern int add_file_to_index(struct index_state *, const char *path, int flags);
 extern struct cache_entry *make_cache_entry(unsigned int mode, const unsigned char *sha1, const char *path, int stage, int refresh);
 extern int ce_same_name(struct cache_entry *a, struct cache_entry *b);
 
@@ -640,7 +642,7 @@ extern int convert_to_git(const char *path, const char *src, size_t len, struct
 extern int convert_to_working_tree(const char *path, const char *src, size_t len, struct strbuf *dst);
 
 /* add */
-void add_files_to_cache(int verbose, const char *prefix, const char **pathspec);
+void add_files_to_cache(const char *prefix, const char **pathspec, int flags);
 
 /* diff.c */
 extern int diff_auto_refresh_index;
diff --git a/builtin-add.c b/builtin-add.c
index 4a91e3e..cb61366 100644
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
+		add_file_to_cache(dir.entries[i]->name, ADD_CACHE_VERBOSE);
 
  finish:
 	if (active_cache_changed) {
diff --git a/builtin-commit.c b/builtin-commit.c
index 2f4d6cc..f31bf59 100644
--- a/builtin-commit.c
+++ b/builtin-commit.c
@@ -239,7 +239,7 @@ static char *prepare_index(int argc, const char **argv, const char *prefix)
 	 */
 	if (all || (also && pathspec && *pathspec)) {
 		int fd = hold_locked_index(&index_lock, 1);
-		add_files_to_cache(0, also ? prefix : NULL, pathspec);
+		add_files_to_cache(also ? prefix : NULL, pathspec, 0);
 		refresh_cache(REFRESH_QUIET);
 		if (write_cache(fd, active_cache, active_nr) ||
 		    close_lock_file(&index_lock))
diff --git a/builtin-mv.c b/builtin-mv.c
index 990e213..1ad3178 100644
--- a/builtin-mv.c
+++ b/builtin-mv.c
@@ -256,7 +256,7 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 
 		for (i = 0; i < added.nr; i++) {
 			const char *path = added.items[i].path;
-			add_file_to_cache(path, verbose);
+			add_file_to_cache(path, verbose ? ADD_CACHE_VERBOSE : 0);
 		}
 
 		for (i = 0; i < deleted.nr; i++)
diff --git a/read-cache.c b/read-cache.c
index 7db5588..a95861b 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -384,12 +384,14 @@ static int index_name_pos_also_unmerged(struct index_state *istate,
 	return pos;
 }
 
-int add_file_to_index(struct index_state *istate, const char *path, int verbose)
+int add_file_to_index(struct index_state *istate, const char *path, int flags)
 {
-	int size, namelen, pos;
+	int size, namelen, pos, was_same;
 	struct stat st;
 	struct cache_entry *ce;
 	unsigned ce_option = CE_MATCH_IGNORE_VALID|CE_MATCH_RACY_IS_DIRTY;
+	int verbose = flags & (ADD_CACHE_VERBOSE|ADD_CACHE_PRETEND);
+	int pretend = flags & ADD_CACHE_PRETEND;
 
 	if (lstat(path, &st))
 		die("%s: unable to stat (%s)", path, strerror(errno));
@@ -432,9 +434,19 @@ int add_file_to_index(struct index_state *istate, const char *path, int verbose)
 
 	if (index_path(ce->sha1, path, &st, 1))
 		die("unable to index file %s", path);
-	if (add_index_entry(istate, ce, ADD_CACHE_OK_TO_ADD|ADD_CACHE_OK_TO_REPLACE))
+
+	/* It was suspected to be racily clean but it turns out to be Ok */
+	was_same = (0 <= pos &&
+		    !ce_stage(istate->cache[pos]) &&
+		    !hashcmp(ce->sha1, istate->cache[pos]->sha1) &&
+		    ce->ce_mode == istate->cache[pos]->ce_mode);
+
+	if (pretend)
+		;
+	else if (add_index_entry(istate, ce,
+				 ADD_CACHE_OK_TO_ADD|ADD_CACHE_OK_TO_REPLACE))
 		die("unable to add %s to index",path);
-	if (verbose)
+	if (verbose && !was_same)
 		printf("add '%s'\n", path);
 	return 0;
 }
