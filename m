From: Junio C Hamano <junkio@cox.net>
Subject: Re: Add ".git/config" file parser
Date: Tue, 11 Oct 2005 17:25:57 -0700
Message-ID: <7vvf03r36y.fsf@assigned-by-dhcp.cox.net>
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
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Wed Oct 12 02:27:25 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EPURY-0003VX-5z
	for gcvg-git@gmane.org; Wed, 12 Oct 2005 02:26:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932364AbVJLAZ7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 11 Oct 2005 20:25:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932370AbVJLAZ7
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Oct 2005 20:25:59 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:7414 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S932364AbVJLAZ6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Oct 2005 20:25:58 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051012002558.BHPH9260.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 11 Oct 2005 20:25:58 -0400
To: Git Mailing List <git@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0510101415080.14597@g5.osdl.org> (Linus Torvalds's
	message of "Mon, 10 Oct 2005 14:35:36 -0700 (PDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9993>

This is a WIP to implement update-index that does not care the
filesystem mode change.  When you have the following in
.git/config:

        [core]
                filemode = false

the following things happen:

 * "git-update-index --refresh" does not consider the executable
   bit change significant.

 * "git-update-index" on an existing path takes executable bit
   from the existing index entry, if the blob types are the
   same.

 * "git-diff-files" pretends the path on the filesystem has the
   same executable bit as the existing index entry, if the blob
   types are the same.

Yet to be done items are:

 * Other programs from diff-* family that compares with the
   filesystem needs to be covered.

 * "git-update-index --chmod=+x" and "--chmod=-x".

 * Refector code that takes the executable bit change from an
   existing index entry.

WIP-not-worth-signing-off-yet-by: Junio C Hamano <junkio.cox.net>
---
cd /opt/packrat/playpen/public/in-place/git/git.junio/
git diff HEAD
diff --git a/diff-files.c b/diff-files.c
index 96d2c7f..014f74e 100644
--- a/diff-files.c
+++ b/diff-files.c
@@ -81,7 +81,7 @@ int main(int argc, const char **argv)
 
 	for (i = 0; i < entries; i++) {
 		struct stat st;
-		unsigned int oldmode;
+		unsigned int oldmode, newmode;
 		struct cache_entry *ce = active_cache[i];
 		int changed;
 
@@ -111,7 +111,12 @@ int main(int argc, const char **argv)
 		if (!changed && !diff_options.find_copies_harder)
 			continue;
 		oldmode = ntohl(ce->ce_mode);
-		show_modified(oldmode, DIFF_FILE_CANON_MODE(st.st_mode),
+
+		newmode = DIFF_FILE_CANON_MODE(st.st_mode);
+		if (!trust_executable_bit &&
+		    S_ISREG(newmode) && ((newmode ^ oldmode) == 0111))
+			newmode = oldmode;
+		show_modified(oldmode, newmode,
 			      ce->sha1, (changed ? null_sha1 : ce->sha1),
 			      ce->name);
 	}
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
index 01b4088..fd3a882 100644
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
@@ -328,6 +338,8 @@ int main(int argc, const char **argv)
 	const char *prefix = setup_git_directory();
 	int prefix_length = prefix ? strlen(prefix) : 0;
 
+	git_config(git_default_config);
+
 	newfd = hold_index_file_for_update(&cache_file, get_index_file());
 	if (newfd < 0)
 		die("unable to create new cachefile");
