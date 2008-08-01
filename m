From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] git mv: try harder to keep index entries intact
Date: Fri, 1 Aug 2008 18:49:57 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0808011847560.9611@pacific.mpi-cbg.de.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org, gitster@pobox.com, pasky@suse.cz
X-From: git-owner@vger.kernel.org Fri Aug 01 18:47:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KOxmY-0004sN-CA
	for gcvg-git-2@gmane.org; Fri, 01 Aug 2008 18:47:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756138AbYHAQpj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Aug 2008 12:45:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752293AbYHAQpi
	(ORCPT <rfc822;git-outgoing>); Fri, 1 Aug 2008 12:45:38 -0400
Received: from mail.gmx.net ([213.165.64.20]:37014 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756138AbYHAQpg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Aug 2008 12:45:36 -0400
Received: (qmail invoked by alias); 01 Aug 2008 16:45:34 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp038) with SMTP; 01 Aug 2008 18:45:34 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19g3g1h5YtgNjQR2y9zpJGZdeow9B1H6ilMAlI0tt
	Eyk8F5Dg7NUEan
X-X-Sender: schindelin@pacific.mpi-cbg.de.mpi-cbg.de
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.43
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91074>


Some filesystems change the ctime during a rename(), for technical
reasons.  Since this is the only change, the contents need not be
rehashed.  So just update the ctime after renaming the entry.

This change requires rename_index_entry_at() to return the new
position.

As git-mv assumes that it runs in a non-bare repository, and is
marked as such in the cmd_struct in git.c, the changes do not have
to be guarded against running in a bare repository.

To test this properly, you need to run t7001 with the environment
variable TEST_CTIME_WITH_SLEEP set non-empty, since there is no way
to manipulate the ctime directly; we have to sleep.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

 builtin-mv.c  |   15 +++++++++++++--
 cache.h       |    2 +-
 read-cache.c  |    4 ++--
 t/t7001-mv.sh |   10 ++++++++--
 4 files changed, 24 insertions(+), 7 deletions(-)

diff --git a/builtin-mv.c b/builtin-mv.c
index 4f65b5a..166a019 100644
--- a/builtin-mv.c
+++ b/builtin-mv.c
@@ -214,8 +214,19 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 
 		pos = cache_name_pos(src, strlen(src));
 		assert(pos >= 0);
-		if (!show_only)
-			rename_cache_entry_at(pos, dst);
+		if (!show_only) {
+			struct stat st;
+			pos = rename_cache_entry_at(pos, dst);
+
+			/*
+			 * Renaming can update the ctime.  Do not force
+			 * a complete rehash just because of that.
+			 */
+			if (!lstat(dst, &st))
+				active_cache[pos]->ce_ctime = st.st_ctime;
+			else if (!ignore_errors)
+				die ("Could not stat '%s'", dst);
+		}
 	}
 
 	if (active_cache_changed) {
diff --git a/cache.h b/cache.h
index 8155ab8..4b6876b 100644
--- a/cache.h
+++ b/cache.h
@@ -371,7 +371,7 @@ extern int index_name_pos(const struct index_state *, const char *name, int name
 #define ADD_CACHE_JUST_APPEND 8		/* Append only; tree.c::read_tree() */
 extern int add_index_entry(struct index_state *, struct cache_entry *ce, int option);
 extern struct cache_entry *refresh_cache_entry(struct cache_entry *ce, int really);
-extern void rename_index_entry_at(struct index_state *, int pos, const char *new_name);
+extern int rename_index_entry_at(struct index_state *, int pos, const char *new_name);
 extern int remove_index_entry_at(struct index_state *, int pos);
 extern int remove_file_from_index(struct index_state *, const char *path);
 #define ADD_CACHE_VERBOSE 1
diff --git a/read-cache.c b/read-cache.c
index c5aa5bc..4454686 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -43,7 +43,7 @@ static void replace_index_entry(struct index_state *istate, int nr, struct cache
 	istate->cache_changed = 1;
 }
 
-void rename_index_entry_at(struct index_state *istate, int nr, const char *new_name)
+int rename_index_entry_at(struct index_state *istate, int nr, const char *new_name)
 {
 	struct cache_entry *old = istate->cache[nr], *new;
 	int namelen = strlen(new_name);
@@ -56,7 +56,7 @@ void rename_index_entry_at(struct index_state *istate, int nr, const char *new_n
 
 	cache_tree_invalidate_path(istate->cache_tree, old->name);
 	remove_index_entry_at(istate, nr);
-	add_index_entry(istate, new, ADD_CACHE_OK_TO_ADD|ADD_CACHE_OK_TO_REPLACE);
+	return add_index_entry(istate, new, ADD_CACHE_OK_TO_ADD|ADD_CACHE_OK_TO_REPLACE);
 }
 
 /*
diff --git a/t/t7001-mv.sh b/t/t7001-mv.sh
index 910a28c..5f6cee5 100755
--- a/t/t7001-mv.sh
+++ b/t/t7001-mv.sh
@@ -180,12 +180,15 @@ test_expect_success 'git mv should overwrite symlink to a file' '
 	echo 1 >moved &&
 	ln -s moved symlink &&
 	git add moved symlink &&
+	if test ! -z "$TEST_CTIME_WITH_SLEEP"
+	then
+		sleep 1
+	fi &&
 	test_must_fail git mv moved symlink &&
 	git mv -f moved symlink &&
 	! test -e moved &&
 	test -f symlink &&
 	test "$(cat symlink)" = 1 &&
-	git update-index --refresh &&
 	git diff-files --quiet
 
 '
@@ -199,11 +202,14 @@ test_expect_success 'git mv should overwrite file with a symlink' '
 	echo 1 >moved &&
 	ln -s moved symlink &&
 	git add moved symlink &&
+	if test ! -z "$TEST_CTIME_WITH_SLEEP"
+	then
+		sleep 1
+	fi &&
 	test_must_fail git mv symlink moved &&
 	git mv -f symlink moved &&
 	! test -e symlink &&
 	test -h moved &&
-	git update-index --refresh &&
 	git diff-files --quiet
 
 '
-- 
1.6.0.rc1.55.g69db8
