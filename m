From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Re* [PATCH] Make git add -u honor --dry-run
Date: Thu, 22 May 2008 13:38:23 -0700
Message-ID: <7vfxsaula8.fsf@gitster.siamese.dyndns.org>
References: <482C5FF8.1060200@isy.liu.se>
 <1210868459-9511-1-git-send-email-vmiklos@frugalware.org>
 <7vmymrf81x.fsf@gitster.siamese.dyndns.org> <4831FBD8.3050402@isy.liu.se>
 <7vskwauruo.fsf@gitster.siamese.dyndns.org> <4835CACE.1070006@isy.liu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Miklos Vajna <vmiklos@frugalware.org>,
	Git Mailing List <git@vger.kernel.org>
To: Gustaf Hendeby <hendeby@isy.liu.se>
X-From: git-owner@vger.kernel.org Thu May 22 22:39:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JzHZO-0000yl-1x
	for gcvg-git-2@gmane.org; Thu, 22 May 2008 22:39:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754925AbYEVUie (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 May 2008 16:38:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755091AbYEVUie
	(ORCPT <rfc822;git-outgoing>); Thu, 22 May 2008 16:38:34 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:51045 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754925AbYEVUid (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 May 2008 16:38:33 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id B2D3A4047;
	Thu, 22 May 2008 16:38:31 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 389E34046; Thu, 22 May 2008 16:38:27 -0400 (EDT)
In-Reply-To: <4835CACE.1070006@isy.liu.se> (Gustaf Hendeby's message of "Thu,
 22 May 2008 21:34:38 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 0A9E8C0C-283F-11DD-9F4A-80001473D85F-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82651>

Gustaf Hendeby <hendeby@isy.liu.se> writes:

> On 2008-05-22 20:16, Junio C Hamano wrote:
>> ...
>> We need a slightly different patch for 'master' (for 1.5.6) and 'maint'
>> (for 1.5.5.X), due to recent introduction of add_to_index() API.  This is
>> an updated one for 'master'; I rolled your one-liner fix into it as well.
>
> I'm sorry, but I don't get this to apply cleanly at all.  Did I
> misunderstand you, or is it actually meant for master (1af8bca)?  The
> merge is too complicated for me to do anything sensible with.

Oh, sorry about that.  I prepared the patch and the message before
yesterday's merge binge, and one of the topics graduated to 'master'
somewhat conflicts with the patch.

The attached patch should apply cleanly to 1af8bca (Merge branch 'maint',
2008-05-21).

Side note.  The patch is already merged to 'next', so if you can try it to
see if it fixes your issue, we are hopefully in a good shape.

Side note2.  I applied the patch with "git-am -3" to 'master', which reused
the recorded resolution I previously had to make when I merged the topic
to 'next' to resolve the conflict fully.  This patch was created by taking
the diff between that result and 'master'.

---

 builtin-add.c         |   22 ++++++++++------------
 builtin-mv.c          |    2 +-
 cache.h               |   13 +++++++------
 read-cache.c          |   23 +++++++++++++++++------
 t/t2200-add-update.sh |   17 +++++++++++++++++
 5 files changed, 52 insertions(+), 25 deletions(-)

diff --git a/builtin-add.c b/builtin-add.c
index 73235ed..dd2ca4b 100644
--- a/builtin-add.c
+++ b/builtin-add.c
@@ -100,15 +100,16 @@ static void update_callback(struct diff_queue_struct *q,
 		case DIFF_STATUS_UNMERGED:
 		case DIFF_STATUS_MODIFIED:
 		case DIFF_STATUS_TYPE_CHANGED:
-			if (add_file_to_cache(path, data->flags & ADD_FILES_VERBOSE)) {
-				if (!(data->flags & ADD_FILES_IGNORE_ERRORS))
+			if (add_file_to_cache(path, data->flags)) {
+				if (!(data->flags & ADD_CACHE_IGNORE_ERRORS))
 					die("updating files failed");
 				data->add_errors++;
 			}
 			break;
 		case DIFF_STATUS_DELETED:
-			remove_file_from_cache(path);
-			if (data->flags & ADD_FILES_VERBOSE)
+			if (!(data->flags & ADD_CACHE_PRETEND))
+				remove_file_from_cache(path);
+			if (data->flags & (ADD_CACHE_PRETEND|ADD_CACHE_VERBOSE))
 				printf("remove '%s'\n", path);
 			break;
 		}
@@ -234,17 +235,14 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 	newfd = hold_locked_index(&lock_file, 1);
 
 	if (take_worktree_changes) {
-		int flags = 0;
 		const char **pathspec;
+		int flags = ((verbose ? ADD_CACHE_VERBOSE : 0) |
+			     (show_only ? ADD_CACHE_PRETEND : 0) |
+			     (ignore_add_errors ? ADD_CACHE_IGNORE_ERRORS : 0));
+
 		if (read_cache() < 0)
 			die("index file corrupt");
 		pathspec = get_pathspec(prefix, argv);
-
-		if (verbose)
-			flags |= ADD_FILES_VERBOSE;
-		if (ignore_add_errors)
-			flags |= ADD_FILES_IGNORE_ERRORS;
-
 		exit_status = add_files_to_cache(prefix, pathspec, flags);
 		goto finish;
 	}
@@ -287,7 +285,7 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 	}
 
 	for (i = 0; i < dir.nr; i++)
-		if (add_file_to_cache(dir.entries[i]->name, verbose)) {
+		if (add_file_to_cache(dir.entries[i]->name, verbose ? ADD_CACHE_VERBOSE : 0)) {
 			if (!ignore_add_errors)
 				die("adding files failed");
 			exit_status = 1;
diff --git a/builtin-mv.c b/builtin-mv.c
index fb8ffb4..fb906b3 100644
--- a/builtin-mv.c
+++ b/builtin-mv.c
@@ -256,7 +256,7 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 
 		for (i = 0; i < added.nr; i++) {
 			const char *path = added.items[i].path;
-			if (add_file_to_cache(path, verbose))
+			if (add_file_to_cache(path, verbose ? ADD_CACHE_VERBOSE : 0))
 				die("updating index entries failed");
 		}
 
diff --git a/cache.h b/cache.h
index 0f89f15..123d6cc 100644
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
@@ -366,8 +366,11 @@ extern int add_index_entry(struct index_state *, struct cache_entry *ce, int opt
 extern struct cache_entry *refresh_cache_entry(struct cache_entry *ce, int really);
 extern int remove_index_entry_at(struct index_state *, int pos);
 extern int remove_file_from_index(struct index_state *, const char *path);
-extern int add_to_index(struct index_state *, const char *path, struct stat *, int verbose);
-extern int add_file_to_index(struct index_state *, const char *path, int verbose);
+#define ADD_CACHE_VERBOSE 1
+#define ADD_CACHE_PRETEND 2
+#define ADD_CACHE_IGNORE_ERRORS	4
+extern int add_to_index(struct index_state *, const char *path, struct stat *, int flags);
+extern int add_file_to_index(struct index_state *, const char *path, int flags);
 extern struct cache_entry *make_cache_entry(unsigned int mode, const unsigned char *sha1, const char *path, int stage, int refresh);
 extern int ce_same_name(struct cache_entry *a, struct cache_entry *b);
 
@@ -782,8 +785,6 @@ extern int convert_to_git(const char *path, const char *src, size_t len,
 extern int convert_to_working_tree(const char *path, const char *src, size_t len, struct strbuf *dst);
 
 /* add */
-#define ADD_FILES_VERBOSE	01
-#define ADD_FILES_IGNORE_ERRORS	02
 /*
  * return 0 if success, 1 - if addition of a file failed and
  * ADD_FILES_IGNORE_ERRORS was specified in flags
diff --git a/read-cache.c b/read-cache.c
index 8b467f8..c90cbb9 100644
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
 		return error("%s: can only add regular files, symbolic links or git-directories", path);
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
 		return error("unable to add %s to index",path);
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
