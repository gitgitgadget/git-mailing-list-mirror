From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 1/2] Avoid some unnecessary lstat() calls
Date: Fri, 9 May 2008 09:11:43 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0805090904100.3142@woody.linux-foundation.org>
References: <alpine.LFD.1.10.0805090856350.3142@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri May 09 18:14:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JuVDT-0000oo-9Q
	for gcvg-git-2@gmane.org; Fri, 09 May 2008 18:13:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752078AbYEIQMO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 May 2008 12:12:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754991AbYEIQMO
	(ORCPT <rfc822;git-outgoing>); Fri, 9 May 2008 12:12:14 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:56025 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751656AbYEIQML (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 9 May 2008 12:12:11 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m49GBi3B024381
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 9 May 2008 09:11:45 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m49GBhJQ014602;
	Fri, 9 May 2008 09:11:44 -0700
In-Reply-To: <alpine.LFD.1.10.0805090856350.3142@woody.linux-foundation.org>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-Spam-Status: No, hits=-3.93 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81619>


The commit sequence used to do

	if (file_exists(p->path))
		add_file_to_cache(p->path, 0);

where both "file_exists()" and "add_file_to_cache()" needed to do a 
lstat() on the path to do their work.

This cuts down 'lstat()' calls for the partial commit case by two 
for each path we know about (because we do this twice per path).

Just move the lstat() to the caller instead (that's all that 
"file_exists()" really does), and pass the stat information down to the 
add_to_cache() function.

This essentially makes 'add_to_index()' the core function that adds a path 
to the index, getting the index pointer, the pathname and the stat 
information as arguments. There are then shorthand helper functions that 
use this core function:

 - 'add_to_cache()' is just 'add_to_index()' with the default index

 - 'add_file_to_cache/index()' is the same, but does the lstat() call 
   itself, so you can pass just the pathname if you don't already have the 
   stat information available.

So old users of the 'add_file_to_xyzzy()' are essentially left unchanged, 
and this just exposes the more generic helper function that can take 
existing stat information into account.

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---
 builtin-commit.c |    6 ++++--
 cache.h          |    2 ++
 read-cache.c     |   29 +++++++++++++++++------------
 3 files changed, 23 insertions(+), 14 deletions(-)

diff --git a/builtin-commit.c b/builtin-commit.c
index 256181a..6433f86 100644
--- a/builtin-commit.c
+++ b/builtin-commit.c
@@ -175,9 +175,11 @@ static void add_remove_files(struct path_list *list)
 {
 	int i;
 	for (i = 0; i < list->nr; i++) {
+		struct stat st;
 		struct path_list_item *p = &(list->items[i]);
-		if (file_exists(p->path))
-			add_file_to_cache(p->path, 0);
+
+		if (!lstat(p->path, &st))
+			add_to_cache(p->path, &st, 0);
 		else
 			remove_file_from_cache(p->path);
 	}
diff --git a/cache.h b/cache.h
index 80a8842..4803b03 100644
--- a/cache.h
+++ b/cache.h
@@ -261,6 +261,7 @@ static inline void remove_name_hash(struct cache_entry *ce)
 #define add_cache_entry(ce, option) add_index_entry(&the_index, (ce), (option))
 #define remove_cache_entry_at(pos) remove_index_entry_at(&the_index, (pos))
 #define remove_file_from_cache(path) remove_file_from_index(&the_index, (path))
+#define add_to_cache(path, st, verbose) add_to_index(&the_index, (path), (st), (verbose))
 #define add_file_to_cache(path, verbose) add_file_to_index(&the_index, (path), (verbose))
 #define refresh_cache(flags) refresh_index(&the_index, (flags), NULL, NULL)
 #define ce_match_stat(ce, st, options) ie_match_stat(&the_index, (ce), (st), (options))
@@ -365,6 +366,7 @@ extern int add_index_entry(struct index_state *, struct cache_entry *ce, int opt
 extern struct cache_entry *refresh_cache_entry(struct cache_entry *ce, int really);
 extern int remove_index_entry_at(struct index_state *, int pos);
 extern int remove_file_from_index(struct index_state *, const char *path);
+extern int add_to_index(struct index_state *, const char *path, struct stat *, int verbose);
 extern int add_file_to_index(struct index_state *, const char *path, int verbose);
 extern struct cache_entry *make_cache_entry(unsigned int mode, const unsigned char *sha1, const char *path, int stage, int refresh);
 extern int ce_same_name(struct cache_entry *a, struct cache_entry *b);
diff --git a/read-cache.c b/read-cache.c
index e71c3b7..f0d74b3 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -461,21 +461,18 @@ static struct cache_entry *create_alias_ce(struct cache_entry *ce, struct cache_
 	return new;
 }
 
-int add_file_to_index(struct index_state *istate, const char *path, int verbose)
+int add_to_index(struct index_state *istate, const char *path, struct stat *st, int verbose)
 {
 	int size, namelen;
-	struct stat st;
+	mode_t st_mode = st->st_mode;
 	struct cache_entry *ce, *alias;
 	unsigned ce_option = CE_MATCH_IGNORE_VALID|CE_MATCH_RACY_IS_DIRTY;
 
-	if (lstat(path, &st))
-		die("%s: unable to stat (%s)", path, strerror(errno));
-
-	if (!S_ISREG(st.st_mode) && !S_ISLNK(st.st_mode) && !S_ISDIR(st.st_mode))
+	if (!S_ISREG(st_mode) && !S_ISLNK(st_mode) && !S_ISDIR(st_mode))
 		die("%s: can only add regular files, symbolic links or git-directories", path);
 
 	namelen = strlen(path);
-	if (S_ISDIR(st.st_mode)) {
+	if (S_ISDIR(st_mode)) {
 		while (namelen && path[namelen-1] == '/')
 			namelen--;
 	}
@@ -483,10 +480,10 @@ int add_file_to_index(struct index_state *istate, const char *path, int verbose)
 	ce = xcalloc(1, size);
 	memcpy(ce->name, path, namelen);
 	ce->ce_flags = namelen;
-	fill_stat_cache_info(ce, &st);
+	fill_stat_cache_info(ce, st);
 
 	if (trust_executable_bit && has_symlinks)
-		ce->ce_mode = create_ce_mode(st.st_mode);
+		ce->ce_mode = create_ce_mode(st_mode);
 	else {
 		/* If there is an existing entry, pick the mode bits and type
 		 * from it, otherwise assume unexecutable regular file.
@@ -495,18 +492,18 @@ int add_file_to_index(struct index_state *istate, const char *path, int verbose)
 		int pos = index_name_pos_also_unmerged(istate, path, namelen);
 
 		ent = (0 <= pos) ? istate->cache[pos] : NULL;
-		ce->ce_mode = ce_mode_from_stat(ent, st.st_mode);
+		ce->ce_mode = ce_mode_from_stat(ent, st_mode);
 	}
 
 	alias = index_name_exists(istate, ce->name, ce_namelen(ce), ignore_case);
-	if (alias && !ce_stage(alias) && !ie_match_stat(istate, alias, &st, ce_option)) {
+	if (alias && !ce_stage(alias) && !ie_match_stat(istate, alias, st, ce_option)) {
 		/* Nothing changed, really */
 		free(ce);
 		ce_mark_uptodate(alias);
 		alias->ce_flags |= CE_ADDED;
 		return 0;
 	}
-	if (index_path(ce->sha1, path, &st, 1))
+	if (index_path(ce->sha1, path, st, 1))
 		die("unable to index file %s", path);
 	if (ignore_case && alias && different_name(ce, alias))
 		ce = create_alias_ce(ce, alias);
@@ -518,6 +515,14 @@ int add_file_to_index(struct index_state *istate, const char *path, int verbose)
 	return 0;
 }
 
+int add_file_to_index(struct index_state *istate, const char *path, int verbose)
+{
+	struct stat st;
+	if (lstat(path, &st))
+		die("%s: unable to stat (%s)", path, strerror(errno));
+	return add_to_index(istate, path, &st, verbose);
+}
+
 struct cache_entry *make_cache_entry(unsigned int mode,
 		const unsigned char *sha1, const char *path, int stage,
 		int refresh)
