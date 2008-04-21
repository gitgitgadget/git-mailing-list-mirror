From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 01/02/RFC] implement a stat cache
Date: Sun, 20 Apr 2008 20:15:20 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0804201959590.2779@woody.linux-foundation.org>
References: <1208633300-74603-1-git-send-email-pdebie@ai.rug.nl> <alpine.LFD.1.10.0804191443550.2779@woody.linux-foundation.org> <FEFAB19F-742A-452E-87C1-CD55AD0996DB@ai.rug.nl> <alpine.LFD.1.10.0804191515120.2779@woody.linux-foundation.org>
 <20080420111346.GA13411@bit.office.eurotux.com> <alpine.LFD.1.10.0804200836310.2779@woody.linux-foundation.org> <20080420215700.GA18626@bit.office.eurotux.com> <alpine.LFD.1.10.0804201520370.2779@woody.linux-foundation.org>
 <alpine.LFD.1.10.0804201556290.2779@woody.linux-foundation.org> <7vk5isatpe.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Luciano Rocha <luciano@eurotux.com>,
	Pieter de Bie <pdebie@ai.rug.nl>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 21 05:16:37 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JnmW5-0002Uk-IB
	for gcvg-git-2@gmane.org; Mon, 21 Apr 2008 05:16:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754390AbYDUDPm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Apr 2008 23:15:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754398AbYDUDPm
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Apr 2008 23:15:42 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:35484 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754377AbYDUDPl (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 20 Apr 2008 23:15:41 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m3L3FNkq017020
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 20 Apr 2008 20:15:24 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m3L3FL9r029581;
	Sun, 20 Apr 2008 20:15:22 -0700
In-Reply-To: <7vk5isatpe.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-Spam-Status: No, hits=-3.93 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80010>



On Sun, 20 Apr 2008, Junio C Hamano wrote:
> Linus Torvalds <torvalds@linux-foundation.org> writes:
> 
> > Junio, what was the logic for that whole "has_symlink_leading_path()" 
> > thing?
> 
> If you have a tracked path a/b/c/d/e, and you changed your work tree to
> make a/b to a symlink that points at a random directory, potentially
> even outside work tree, that has c/d/e in it, we should not be fooled by
> the fact that lstat("a/b/c/d/e") says "yup, the file exists".  As far as
> git is concerned, that path does _not_ exist, as "a/b" is a symlink now.

Ok, I can see the logic behind that, but the code is really dense and hard 
to read. And obviously very inefficient.

Here's a trial balloon patch that totally revamps how that whole function 
works. Instead of passing in a "symlink_cache" thing that it modifies for 
the caller, it just has its totally *internal* cache of where it found the 
last symlink, and what the last directory it found last time was.

So now the logic becomes:

 - if a pathname that is passed in matches the last known symlink prefix, 
   we don't even need to do anything else - it is known to have a symlink 
   prefix.

 - if the pathname that is passed in matches the last known directory 
   prefix, we start looking just from that point onward (since we know 
   that the leading part is a directory without symlinks)

and this not only speeds things up regardless, it also cuts down lstat() 
calls by a huge amount.

On that WebKit repo, and a "git status .", it used to do 338132 lstat() 
calls. With this patch, it only does 141411. Which is still three per 
pathname we know about, plus roughly one per directory we look at, but 
that's a *lot* better.

It also improves performance from 1.125s to under one second for me on 
Linux. 

But more fundamentally, I think it's more readable.

Caveat: I do think we should add a way to invalidate the pathname caches 
when we turn a symlink into a directory or vice versa, so this patch isn't 
really complete as-is, but I think it's a good start.

And once we do that, I think the code is actually understandable. It was 
really hard to see what the point of that "last_symlink" thing was.

Hmm?

		Linus
---
 builtin-apply.c |    2 +-
 cache.h         |    2 +-
 diff-lib.c      |   10 +++---
 symlinks.c      |   78 +++++++++++++++++++++++++++++++++----------------------
 unpack-trees.c  |   12 +++-----
 5 files changed, 59 insertions(+), 45 deletions(-)

diff --git a/builtin-apply.c b/builtin-apply.c
index caa3f2a..1103625 100644
--- a/builtin-apply.c
+++ b/builtin-apply.c
@@ -2247,7 +2247,7 @@ static int check_to_create_blob(const char *new_name, int ok_if_exists)
 		 * In such a case, path "new_name" does not exist as
 		 * far as git is concerned.
 		 */
-		if (has_symlink_leading_path(new_name, NULL))
+		if (has_symlink_leading_path(strlen(new_name), new_name))
 			return 0;
 
 		return error("%s: already exists in working directory", new_name);
diff --git a/cache.h b/cache.h
index c058125..6dc6543 100644
--- a/cache.h
+++ b/cache.h
@@ -587,7 +587,7 @@ struct checkout {
 };
 
 extern int checkout_entry(struct cache_entry *ce, const struct checkout *state, char *topath);
-extern int has_symlink_leading_path(const char *name, char *last_symlink);
+extern int has_symlink_leading_path(int len, const char *name);
 
 extern struct alternate_object_database {
 	struct alternate_object_database *next;
diff --git a/diff-lib.c b/diff-lib.c
index 069e450..6a26b53 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -338,14 +338,14 @@ int run_diff_files_cmd(struct rev_info *revs, int argc, const char **argv)
  * See if work tree has an entity that can be staged.  Return 0 if so,
  * return 1 if not and return -1 if error.
  */
-static int check_work_tree_entity(const struct cache_entry *ce, struct stat *st, char *symcache)
+static int check_work_tree_entity(const struct cache_entry *ce, struct stat *st)
 {
 	if (lstat(ce->name, st) < 0) {
 		if (errno != ENOENT && errno != ENOTDIR)
 			return -1;
 		return 1;
 	}
-	if (has_symlink_leading_path(ce->name, symcache))
+	if (has_symlink_leading_path(ce_namelen(ce), ce->name))
 		return 1;
 	if (S_ISDIR(st->st_mode)) {
 		unsigned char sub[20];
@@ -399,7 +399,7 @@ int run_diff_files(struct rev_info *revs, unsigned int option)
 			memset(&(dpath->parent[0]), 0,
 			       sizeof(struct combine_diff_parent)*5);
 
-			changed = check_work_tree_entity(ce, &st, symcache);
+			changed = check_work_tree_entity(ce, &st);
 			if (!changed)
 				dpath->mode = ce_mode_from_stat(ce, st.st_mode);
 			else {
@@ -463,7 +463,7 @@ int run_diff_files(struct rev_info *revs, unsigned int option)
 		if (ce_uptodate(ce))
 			continue;
 
-		changed = check_work_tree_entity(ce, &st, symcache);
+		changed = check_work_tree_entity(ce, &st);
 		if (changed) {
 			if (changed < 0) {
 				perror(ce->name);
@@ -521,7 +521,7 @@ static int get_stat_data(struct cache_entry *ce,
 	if (!cached) {
 		int changed;
 		struct stat st;
-		changed = check_work_tree_entity(ce, &st, cbdata->symcache);
+		changed = check_work_tree_entity(ce, &st);
 		if (changed < 0)
 			return -1;
 		else if (changed) {
diff --git a/symlinks.c b/symlinks.c
index be9ace6..04ce2d4 100644
--- a/symlinks.c
+++ b/symlinks.c
@@ -1,48 +1,64 @@
 #include "cache.h"
 
-int has_symlink_leading_path(const char *name, char *last_symlink)
-{
+struct pathname {
+	int len;
 	char path[PATH_MAX];
-	const char *sp, *ep;
-	char *dp;
+};
 
-	sp = name;
-	dp = path;
+/* Return matching pathname prefix length, or zero if not matching */
+static inline int match_pathname(int len, const char *name, struct pathname *match)
+{
+	int match_len = match->len;
+	return (len > match_len &&
+		name[match_len] == '/' &&
+		!memcmp(name, match->path, match_len)) ? match_len : 0;
+}
 
-	if (last_symlink && *last_symlink) {
-		size_t last_len = strlen(last_symlink);
-		size_t len = strlen(name);
-		if (last_len < len &&
-		    !strncmp(name, last_symlink, last_len) &&
-		    name[last_len] == '/')
-			return 1;
-		*last_symlink = '\0';
+static inline void set_pathname(int len, const char *name, struct pathname *match)
+{
+	if (len < PATH_MAX) {
+		match->len = len;
+		memcpy(match->path, name, len);
+		match->path[len] = 0;
 	}
+}
 
-	while (1) {
-		size_t len;
-		struct stat st;
+int has_symlink_leading_path(int len, const char *name)
+{
+	static struct pathname link, nonlink;
+	char path[PATH_MAX];
+	struct stat st;
+	char *sp;
+	int known_dir;
+
+	/*
+	 * See if the last known symlink cache matches.
+	 */
+	if (match_pathname(len, name, &link))
+		return 1;
 
-		ep = strchr(sp, '/');
-		if (!ep)
-			break;
-		len = ep - sp;
-		if (PATH_MAX <= dp + len - path + 2)
-			return 0; /* new name is longer than that??? */
-		memcpy(dp, sp, len);
-		dp[len] = 0;
+	/*
+	 * Get rid of the last known directory part
+	 */
+	known_dir = match_pathname(len, name, &nonlink);
+	    	
+	while ((sp = strchr(name + known_dir + 1, '/')) != NULL) {
+		int thislen = sp - name ;
+		memcpy(path, name, thislen);
+		path[thislen] = 0;
 
 		if (lstat(path, &st))
 			return 0;
+		if (S_ISDIR(st.st_mode)) {
+			set_pathname(thislen, path, &nonlink);
+			known_dir = thislen;
+			continue;
+		}
 		if (S_ISLNK(st.st_mode)) {
-			if (last_symlink)
-				strcpy(last_symlink, path);
+			set_pathname(thislen, path, &link);
 			return 1;
 		}
-
-		dp[len++] = '/';
-		dp = dp + len;
-		sp = ep + 1;
+		break;
 	}
 	return 0;
 }
diff --git a/unpack-trees.c b/unpack-trees.c
index feae846..1ab28fd 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -26,11 +26,12 @@ static void add_entry(struct unpack_trees_options *o, struct cache_entry *ce,
  * directories, in case this unlink is the removal of the
  * last entry in the directory -- empty directories are removed.
  */
-static void unlink_entry(char *name, char *last_symlink)
+static void unlink_entry(struct cache_entry *ce)
 {
 	char *cp, *prev;
+	char *name = ce->name;
 
-	if (has_symlink_leading_path(name, last_symlink))
+	if (has_symlink_leading_path(ce_namelen(ce), ce->name))
 		return;
 	if (unlink(name))
 		return;
@@ -58,7 +59,6 @@ static int check_updates(struct unpack_trees_options *o)
 {
 	unsigned cnt = 0, total = 0;
 	struct progress *progress = NULL;
-	char last_symlink[PATH_MAX];
 	struct index_state *index = &o->result;
 	int i;
 	int errs = 0;
@@ -75,14 +75,13 @@ static int check_updates(struct unpack_trees_options *o)
 		cnt = 0;
 	}
 
-	*last_symlink = '\0';
 	for (i = 0; i < index->cache_nr; i++) {
 		struct cache_entry *ce = index->cache[i];
 
 		if (ce->ce_flags & CE_REMOVE) {
 			display_progress(progress, ++cnt);
 			if (o->update)
-				unlink_entry(ce->name, last_symlink);
+				unlink_entry(ce);
 			remove_index_entry_at(&o->result, i);
 			i--;
 			continue;
@@ -97,7 +96,6 @@ static int check_updates(struct unpack_trees_options *o)
 			ce->ce_flags &= ~CE_UPDATE;
 			if (o->update) {
 				errs |= checkout_entry(ce, &state, NULL);
-				*last_symlink = '\0';
 			}
 		}
 	}
@@ -553,7 +551,7 @@ static int verify_absent(struct cache_entry *ce, const char *action,
 	if (o->index_only || o->reset || !o->update)
 		return 0;
 
-	if (has_symlink_leading_path(ce->name, NULL))
+	if (has_symlink_leading_path(ce_namelen(ce), ce->name))
 		return 0;
 
 	if (!lstat(ce->name, &st)) {
