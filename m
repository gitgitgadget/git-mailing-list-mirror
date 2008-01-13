From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] builtin-commit.c: do not lstat(2) partially committed paths twice.
Date: Sun, 13 Jan 2008 02:54:59 -0800
Message-ID: <7v3at2q9ks.fsf_-_@gitster.siamese.dyndns.org>
References: <alpine.LFD.1.00.0801121426510.2806@woody.linux-foundation.org>
	<alpine.LFD.1.00.0801121735020.2806@woody.linux-foundation.org>
	<alpine.LFD.1.00.0801121949180.2806@woody.linux-foundation.org>
	<7vtzliqh3u.fsf@gitster.siamese.dyndns.org>
	<7vd4s6qal0.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Kristian =?utf-8?Q?H=C3=B8gsb?= =?utf-8?Q?erg?= 
	<krh@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sun Jan 13 11:55:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JE0VP-0000Al-Rk
	for gcvg-git-2@gmane.org; Sun, 13 Jan 2008 11:55:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751183AbYAMKzQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Jan 2008 05:55:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751186AbYAMKzQ
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Jan 2008 05:55:16 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:64157 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751024AbYAMKzO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Jan 2008 05:55:14 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id B6C6F3052;
	Sun, 13 Jan 2008 05:55:12 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id C23943051;
	Sun, 13 Jan 2008 05:55:06 -0500 (EST)
In-Reply-To: <7vd4s6qal0.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
	message of "Sun, 13 Jan 2008 02:33:15 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70378>

Junio C Hamano <gitster@pobox.com> writes:

>  * In the partial commit codepath, we run one file_exists() and
>    then one add_file_to_index(), each of which has lstat(2) on
>    the same pathname, for the paths to be committed.  This can
>    be reduced to one trivially by changing the calling
>    convention of add_file_to_index()....

And this is the "trivial" lstat(2) reduction.

I do not know if it is worth it, though.  Majority of lstat(2)
must be coming from the paths in the index (and not committed),
not from the paths that are listed on the command line to be
partially committed.

---
 builtin-commit.c |    6 ++++--
 cache.h          |    2 ++
 read-cache.c     |   34 ++++++++++++++++++++++------------
 3 files changed, 28 insertions(+), 14 deletions(-)

diff --git a/builtin-commit.c b/builtin-commit.c
index 6d2ca80..770bd25 100644
--- a/builtin-commit.c
+++ b/builtin-commit.c
@@ -170,9 +170,11 @@ static void add_remove_files(struct path_list *list)
 {
 	int i;
 	for (i = 0; i < list->nr; i++) {
+		struct stat st;
 		struct path_list_item *p = &(list->items[i]);
-		if (file_exists(p->path))
-			add_file_to_cache(p->path, 0);
+
+		if (!lstat(p->path, &st))
+			add_file_to_cache_with_stat(p->path, &st, 0);
 		else
 			remove_file_from_cache(p->path);
 	}
diff --git a/cache.h b/cache.h
index 39331c2..73cc83b 100644
--- a/cache.h
+++ b/cache.h
@@ -174,6 +174,7 @@ extern struct index_state the_index;
 #define remove_cache_entry_at(pos) remove_index_entry_at(&the_index, (pos))
 #define remove_file_from_cache(path) remove_file_from_index(&the_index, (path))
 #define add_file_to_cache(path, verbose) add_file_to_index(&the_index, (path), (verbose))
+#define add_file_to_cache_with_stat(path, st, verbose) add_file_to_index_with_stat(&the_index, (path), (st), (verbose))
 #define refresh_cache(flags) refresh_index(&the_index, (flags), NULL, NULL)
 #define ce_match_stat(ce, st, options) ie_match_stat(&the_index, (ce), (st), (options))
 #define ce_modified(ce, st, options) ie_modified(&the_index, (ce), (st), (options))
@@ -273,6 +274,7 @@ extern struct cache_entry *refresh_cache_entry(struct cache_entry *ce, int reall
 extern int remove_index_entry_at(struct index_state *, int pos);
 extern int remove_file_from_index(struct index_state *, const char *path);
 extern int add_file_to_index(struct index_state *, const char *path, int verbose);
+extern int add_file_to_index_with_stat(struct index_state *, const char *path, struct stat *, int verbose);
 extern struct cache_entry *make_cache_entry(unsigned int mode, const unsigned char *sha1, const char *path, int stage, int refresh);
 extern int ce_same_name(struct cache_entry *a, struct cache_entry *b);
 
diff --git a/read-cache.c b/read-cache.c
index 7db5588..928f49b 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -384,21 +384,22 @@ static int index_name_pos_also_unmerged(struct index_state *istate,
 	return pos;
 }
 
-int add_file_to_index(struct index_state *istate, const char *path, int verbose)
+int add_file_to_index_with_stat(struct index_state *istate,
+				const char *path,
+				struct stat *st,
+				int verbose)
 {
 	int size, namelen, pos;
-	struct stat st;
 	struct cache_entry *ce;
 	unsigned ce_option = CE_MATCH_IGNORE_VALID|CE_MATCH_RACY_IS_DIRTY;
 
-	if (lstat(path, &st))
-		die("%s: unable to stat (%s)", path, strerror(errno));
-
-	if (!S_ISREG(st.st_mode) && !S_ISLNK(st.st_mode) && !S_ISDIR(st.st_mode))
+	if (!S_ISREG(st->st_mode) &&
+	    !S_ISLNK(st->st_mode) &&
+	    !S_ISDIR(st->st_mode))
 		die("%s: can only add regular files, symbolic links or git-directories", path);
 
 	namelen = strlen(path);
-	if (S_ISDIR(st.st_mode)) {
+	if (S_ISDIR(st->st_mode)) {
 		while (namelen && path[namelen-1] == '/')
 			namelen--;
 	}
@@ -406,10 +407,10 @@ int add_file_to_index(struct index_state *istate, const char *path, int verbose)
 	ce = xcalloc(1, size);
 	memcpy(ce->name, path, namelen);
 	ce->ce_flags = htons(namelen);
-	fill_stat_cache_info(ce, &st);
+	fill_stat_cache_info(ce, st);
 
 	if (trust_executable_bit && has_symlinks)
-		ce->ce_mode = create_ce_mode(st.st_mode);
+		ce->ce_mode = create_ce_mode(st->st_mode);
 	else {
 		/* If there is an existing entry, pick the mode bits and type
 		 * from it, otherwise assume unexecutable regular file.
@@ -418,19 +419,19 @@ int add_file_to_index(struct index_state *istate, const char *path, int verbose)
 		int pos = index_name_pos_also_unmerged(istate, path, namelen);
 
 		ent = (0 <= pos) ? istate->cache[pos] : NULL;
-		ce->ce_mode = ce_mode_from_stat(ent, st.st_mode);
+		ce->ce_mode = ce_mode_from_stat(ent, st->st_mode);
 	}
 
 	pos = index_name_pos(istate, ce->name, namelen);
 	if (0 <= pos &&
 	    !ce_stage(istate->cache[pos]) &&
-	    !ie_match_stat(istate, istate->cache[pos], &st, ce_option)) {
+	    !ie_match_stat(istate, istate->cache[pos], st, ce_option)) {
 		/* Nothing changed, really */
 		free(ce);
 		return 0;
 	}
 
-	if (index_path(ce->sha1, path, &st, 1))
+	if (index_path(ce->sha1, path, st, 1))
 		die("unable to index file %s", path);
 	if (add_index_entry(istate, ce, ADD_CACHE_OK_TO_ADD|ADD_CACHE_OK_TO_REPLACE))
 		die("unable to add %s to index",path);
@@ -439,6 +440,15 @@ int add_file_to_index(struct index_state *istate, const char *path, int verbose)
 	return 0;
 }
 
+int add_file_to_index(struct index_state *istate, const char *path, int verbose)
+{
+	struct stat st;
+	if (lstat(path, &st))
+		die("%s: unable to stat (%s)", path, strerror(errno));
+
+	return add_file_to_index_with_stat(istate, path, &st, verbose);
+}
+
 struct cache_entry *make_cache_entry(unsigned int mode,
 		const unsigned char *sha1, const char *path, int stage,
 		int refresh)
