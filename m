From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Use core.filemode.
Date: Wed, 12 Oct 2005 00:43:21 -0700
Message-ID: <7v1x2rji3q.fsf@assigned-by-dhcp.cox.net>
References: <20051008180023.GC28875@diku.dk>
	<7vfyrbrgdw.fsf@assigned-by-dhcp.cox.net>
	<20051008213612.GA5794@steel.home>
	<7vzmpjoa32.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0510081909250.31407@g5.osdl.org>
	<Pine.LNX.4.63.0510100220330.23242@iabervon.org>
	<7vu0fpbz43.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0510101354520.23242@iabervon.org>
	<Pine.LNX.4.64.0510101120410.14597@g5.osdl.org>
	<Pine.LNX.4.64.0510101415080.14597@g5.osdl.org>
	<7vvf03r36y.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Wed Oct 12 09:44:50 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EPbH5-0006BK-3w
	for gcvg-git@gmane.org; Wed, 12 Oct 2005 09:43:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751343AbVJLHnX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 12 Oct 2005 03:43:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751342AbVJLHnX
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Oct 2005 03:43:23 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:5260 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S1751343AbVJLHnX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Oct 2005 03:43:23 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051012074300.GXQS24014.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 12 Oct 2005 03:43:00 -0400
To: git@vger.kernel.org
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10013>

Junio C Hamano <junkio@cox.net> writes:

> This is a WIP to implement update-index that does not care the
> filesystem mode change...

I finished this one and have it in the master branch.  I'd
appreciate feedback from folks on affected platforms, most
notably Cygwin.

It might not be a bad idea to populate a new repository with a
default .git/config file that sets "core.filemode = false" on
Cygwin platform, using the templates mechanism.  People on NTFS
might not like that -- I do not know.

Anyway, that is a separate topic.

 -- >8 -- cut here -- >8 --

With "[core] filemode = false", you can tell git to ignore
differences in the working tree file only in executable bit.

 * "git-update-index --refresh" does not say "needs update" if index
   entry and working tree file differs only in executable bit.

 * "git-update-index" on an existing path takes executable bit
   from the existing index entry, if the path and index entry are
   both regular files.

 * "git-diff-files" and "git-diff-index" without --cached flag
   pretend the path on the filesystem has the same executable
   bit as the existing index entry, if the path and index entry
   are both regular files.

If you are on a filesystem with unreliable mode bits, you may need to
force the executable bit after registering the path in the index.

 * "git-update-index --chmod=+x foo" flips the executable bit of the
   index file entry for path "foo" on.  Use "--chmod=-x" to flip it
   off.

Note that --chmod only works in index file and does not look at nor
update the working tree.

So if you are on a filesystem and do not have working executable bit,
you would do:

 1. set the appropriate .git/config option;

 2. "git-update-index --add new-file.c"

 3. "git-ls-files --stage new-file.c" to see if it has the desired
   mode bits.  If not, e.g. to drop executable bit picked up from the
   filesystem, say "git-update-index --chmod=-x new-file.c".

Signed-off-by: Junio C Hamano <junkio@cox.net>

---

 diff-files.c   |   10 ++++++++--
 diff-index.c   |   11 +++++++++--
 read-cache.c   |   12 ++++++++----
 update-index.c |   46 +++++++++++++++++++++++++++++++++++++++++++++-
 4 files changed, 70 insertions(+), 9 deletions(-)

applies-to: 8c8a7c6987bcb0eeab559a58170fccd767ce0218
3e09cdfd114651fc61656dbd45d5ec3d9352cb2b
diff --git a/diff-files.c b/diff-files.c
index 96d2c7f..8a8f9b6 100644
--- a/diff-files.c
+++ b/diff-files.c
@@ -81,7 +81,7 @@ int main(int argc, const char **argv)
 
 	for (i = 0; i < entries; i++) {
 		struct stat st;
-		unsigned int oldmode;
+		unsigned int oldmode, newmode;
 		struct cache_entry *ce = active_cache[i];
 		int changed;
 
@@ -111,7 +111,13 @@ int main(int argc, const char **argv)
 		if (!changed && !diff_options.find_copies_harder)
 			continue;
 		oldmode = ntohl(ce->ce_mode);
-		show_modified(oldmode, DIFF_FILE_CANON_MODE(st.st_mode),
+
+		newmode = DIFF_FILE_CANON_MODE(st.st_mode);
+		if (!trust_executable_bit &&
+		    S_ISREG(newmode) && S_ISREG(oldmode) &&
+		    ((newmode ^ oldmode) == 0111))
+			newmode = oldmode;
+		show_modified(oldmode, newmode,
 			      ce->sha1, (changed ? null_sha1 : ce->sha1),
 			      ce->name);
 	}
diff --git a/diff-index.c b/diff-index.c
index 62b36cc..c9a9f4c 100644
--- a/diff-index.c
+++ b/diff-index.c
@@ -15,7 +15,7 @@ static void show_file(const char *prefix
 }
 
 static int get_stat_data(struct cache_entry *ce,
-			 unsigned char **sha1p, unsigned int *modep)
+			 unsigned char ** sha1p, unsigned int *modep)
 {
 	unsigned char *sha1 = ce->sha1;
 	unsigned int mode = ce->ce_mode;
@@ -35,6 +35,10 @@ static int get_stat_data(struct cache_en
 		changed = ce_match_stat(ce, &st);
 		if (changed) {
 			mode = create_ce_mode(st.st_mode);
+			if (!trust_executable_bit &&
+			    S_ISREG(mode) && S_ISREG(ce->ce_mode) &&
+			    ((mode ^ ce->ce_mode) == 0111))
+				mode = ce->ce_mode;
 			sha1 = no_sha1;
 		}
 	}
@@ -49,7 +53,9 @@ static void show_new_file(struct cache_e
 	unsigned char *sha1;
 	unsigned int mode;
 
-	/* New file in the index: it might actually be different in the working copy */
+	/* New file in the index: it might actually be different in
+	 * the working copy.
+	 */
 	if (get_stat_data(new, &sha1, &mode) < 0)
 		return;
 
@@ -174,6 +180,7 @@ int main(int argc, const char **argv)
 	int allow_options = 1;
 	int i;
 
+	git_config(git_default_config);
 	diff_setup(&diff_options);
 	for (i = 1; i < argc; i++) {
 		const char *arg = argv[i];
diff --git a/read-cache.c b/read-cache.c
index c7f3b26..4ed369a 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -36,8 +36,11 @@ int ce_match_stat(struct cache_entry *ce
 	switch (ntohl(ce->ce_mode) & S_IFMT) {
 	case S_IFREG:
 		changed |= !S_ISREG(st->st_mode) ? TYPE_CHANGED : 0;
-		/* We consider only the owner x bit to be relevant for "mode changes" */
-		if (0100 & (ntohl(ce->ce_mode) ^ st->st_mode))
+		/* We consider only the owner x bit to be relevant for
+		 * "mode changes"
+		 */
+		if (trust_executable_bit &&
+		    (0100 & (ntohl(ce->ce_mode) ^ st->st_mode)))
 			changed |= MODE_CHANGED;
 		break;
 	case S_IFLNK:
@@ -393,7 +396,7 @@ int add_cache_entry(struct cache_entry *
 	int skip_df_check = option & ADD_CACHE_SKIP_DFCHECK;
 	pos = cache_name_pos(ce->name, ntohs(ce->ce_flags));
 
-	/* existing match? Just replace it */
+	/* existing match? Just replace it. */
 	if (pos >= 0) {
 		active_cache_changed = 1;
 		active_cache[pos] = ce;
@@ -416,7 +419,8 @@ int add_cache_entry(struct cache_entry *
 	if (!ok_to_add)
 		return -1;
 
-	if (!skip_df_check && check_file_directory_conflict(ce, pos, ok_to_replace)) {
+	if (!skip_df_check &&
+	    check_file_directory_conflict(ce, pos, ok_to_replace)) {
 		if (!ok_to_replace)
 			return -1;
 		pos = cache_name_pos(ce->name, ntohs(ce->ce_flags));
diff --git a/update-index.c b/update-index.c
index 01b4088..1eeb45d 100644
--- a/update-index.c
+++ b/update-index.c
@@ -67,13 +67,23 @@ static int add_file_to_cache(const char 
 			return error("lstat(\"%s\"): %s", path,
 				     strerror(errno));
 	}
+
 	namelen = strlen(path);
 	size = cache_entry_size(namelen);
 	ce = xmalloc(size);
 	memset(ce, 0, size);
 	memcpy(ce->name, path, namelen);
 	fill_stat_cache_info(ce, &st);
+
 	ce->ce_mode = create_ce_mode(st.st_mode);
+	if (!trust_executable_bit) {
+		/* If there is an existing entry, pick the mode bits
+		 * from it.
+		 */
+		int pos = cache_name_pos(path, namelen);
+		if (0 <= pos)
+			ce->ce_mode = active_cache[pos]->ce_mode;
+	}
 	ce->ce_flags = htons(namelen);
 
 	if (index_path(ce->sha1, path, &st, !info_only))
@@ -253,8 +263,32 @@ static int add_cacheinfo(const char *arg
 	return add_cache_entry(ce, option);
 }
 
-static struct cache_file cache_file;
+static int chmod_path(int flip, const char *path)
+{
+	int pos;
+	struct cache_entry *ce;
+	unsigned int mode;
+
+	pos = cache_name_pos(path, strlen(path));
+	if (pos < 0)
+		return -1;
+	ce = active_cache[pos];
+	mode = ntohl(ce->ce_mode);
+	if (!S_ISREG(mode))
+		return -1;
+	switch (flip) {
+	case '+':
+		ce->ce_mode |= htonl(0111); break;
+	case '-':
+		ce->ce_mode &= htonl(~0111); break;
+	default:
+		return -1;
+	}
+	active_cache_changed = 1;
+	return 0;
+}
 
+static struct cache_file cache_file;
 
 static void update_one(const char *path, const char *prefix, int prefix_length)
 {
@@ -328,6 +362,8 @@ int main(int argc, const char **argv)
 	const char *prefix = setup_git_directory();
 	int prefix_length = prefix ? strlen(prefix) : 0;
 
+	git_config(git_default_config);
+
 	newfd = hold_index_file_for_update(&cache_file, get_index_file());
 	if (newfd < 0)
 		die("unable to create new cachefile");
@@ -376,6 +412,14 @@ int main(int argc, const char **argv)
 				i += 3;
 				continue;
 			}
+			if (!strcmp(path, "--chmod=-x") ||
+			    !strcmp(path, "--chmod=+x")) {
+				if (argc <= i+1)
+					die("git-update-index: %s <path>", path);
+				if (chmod_path(path[8], argv[++i]))
+					die("git-update-index: %s cannot chmod %s", path, argv[i]);
+				continue;
+			}
 			if (!strcmp(path, "--info-only")) {
 				info_only = 1;
 				continue;
---
0.99.8.GIT
