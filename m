From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Git performance on OS X
Date: Sat, 19 Apr 2008 15:50:29 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0804191547320.2779@woody.linux-foundation.org>
References: <1208633300-74603-1-git-send-email-pdebie@ai.rug.nl> <alpine.LFD.1.10.0804191443550.2779@woody.linux-foundation.org> <FEFAB19F-742A-452E-87C1-CD55AD0996DB@ai.rug.nl> <m3od85qxcl.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Pieter de Bie <pdebie@ai.rug.nl>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 20 00:51:56 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JnLuV-0002l3-KR
	for gcvg-git-2@gmane.org; Sun, 20 Apr 2008 00:51:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753425AbYDSWvK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Apr 2008 18:51:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753421AbYDSWvJ
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Apr 2008 18:51:09 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:36058 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753403AbYDSWvG (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 19 Apr 2008 18:51:06 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m3JMoUI2031824
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 19 Apr 2008 15:50:32 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m3JMoUAx003745;
	Sat, 19 Apr 2008 15:50:30 -0700
In-Reply-To: <m3od85qxcl.fsf@localhost.localdomain>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-Spam-Status: No, hits=-3.442 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79931>



On Sat, 19 Apr 2008, Jakub Narebski wrote:
> 
> By the way, what version of git do you use? Because in RelNotes for
> 1.5.5 there is:
> 
>  * "git commit" does not run lstat(2) more than necessary
>    anymore.
> 
> which I guess also apply to git status.  This change was written by
> Linus if I remember correctly...

That's only true for a plain "git status" (and even there it does *one* 
superfluous lstat()).

If you do "git status ." it still does a _lot_ of unnecessary commits.

This patch will help. It removes the one superfluous lstat() from "git 
status", and for "git status ." it removes two of them. Basically the old 
pattern

	if (file_exists(..))
		add_file_to_cache(..)

now uses just one lstat() and shares the data between the two.

		Linus

---
 builtin-commit.c |    6 ++++--
 cache.h          |    2 ++
 read-cache.c     |   29 +++++++++++++++++------------
 3 files changed, 23 insertions(+), 14 deletions(-)

diff --git a/builtin-commit.c b/builtin-commit.c
index bcb7aaa..fb3e359 100644
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
index 1b66cc0..c058125 100644
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
@@ -364,6 +365,7 @@ extern int add_index_entry(struct index_state *, struct cache_entry *ce, int opt
 extern struct cache_entry *refresh_cache_entry(struct cache_entry *ce, int really);
 extern int remove_index_entry_at(struct index_state *, int pos);
 extern int remove_file_from_index(struct index_state *, const char *path);
+extern int add_to_index(struct index_state *, const char *path, struct stat *, int verbose);
 extern int add_file_to_index(struct index_state *, const char *path, int verbose);
 extern struct cache_entry *make_cache_entry(unsigned int mode, const unsigned char *sha1, const char *path, int stage, int refresh);
 extern int ce_same_name(struct cache_entry *a, struct cache_entry *b);
diff --git a/read-cache.c b/read-cache.c
index 15d3d72..4c1a9f4 100644
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
