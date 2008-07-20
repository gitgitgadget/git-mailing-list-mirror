From: Junio C Hamano <gitster@pobox.com>
Subject: [RFC variant 1 of 2] "needs update" considered harmful
Date: Sun, 20 Jul 2008 00:48:07 -0700
Message-ID: <7vd4l9dmiw.fsf@gitster.siamese.dyndns.org>
References: <7vtzelf4mf.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 20 09:49:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KKTg2-0004q4-9F
	for gcvg-git-2@gmane.org; Sun, 20 Jul 2008 09:49:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752568AbYGTHsS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Jul 2008 03:48:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752612AbYGTHsS
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Jul 2008 03:48:18 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:48160 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752223AbYGTHsS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Jul 2008 03:48:18 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 8FC652E781;
	Sun, 20 Jul 2008 03:48:16 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id BC9942E780; Sun, 20 Jul 2008 03:48:14 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 369E7FBE-5630-11DD-A741-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89169>

"git update-index --refresh", "git reset" and "git add --refresh" have
reported paths that have local modifications as "needs update" since the
beginning of git.

Although this is logically correct in that you need to update the index at
that path before you can commit that change, it is now becoming more and
more clear, especially with the continuous push for user friendliness
since 1.5.0 series, that the message is suboptimal.  After all, the change
may be something the user might want to get rid of, and "updating" would
be absolutely a wrong thing to do if that is the case.

I prepared two alternatives to solve this.  Both aim to reword the message
to more neutral "locally modified".

This patch is a more intrusive variant that changes the message for only
Porcelain commands ("add" and "reset") while keeping the plumbing
"update-index" intact.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin-add.c    |    3 ++-
 builtin-reset.c  |    2 +-
 cache.h          |    1 +
 read-cache.c     |    5 ++++-
 t/t7102-reset.sh |    2 +-
 5 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/builtin-add.c b/builtin-add.c
index 9930cf5..5ffe4da 100644
--- a/builtin-add.c
+++ b/builtin-add.c
@@ -142,7 +142,8 @@ static void refresh(int verbose, const char **pathspec)
 	seen = xcalloc(specs, 1);
 	if (read_cache() < 0)
 		die("index file corrupt");
-	refresh_index(&the_index, verbose ? 0 : REFRESH_QUIET, pathspec, seen);
+	refresh_index(&the_index, verbose ? REFRESH_SAY_CHANGED : REFRESH_QUIET,
+		      pathspec, seen);
 	for (i = 0; i < specs; i++) {
 		if (!seen[i])
 			die("pathspec '%s' did not match any files", pathspec[i]);
diff --git a/builtin-reset.c b/builtin-reset.c
index a032169..98dbe1c 100644
--- a/builtin-reset.c
+++ b/builtin-reset.c
@@ -96,7 +96,7 @@ static int update_index_refresh(int fd, struct lock_file *index_lock)
 
 	if (read_cache() < 0)
 		return error("Could not read index");
-	result = refresh_cache(0) ? 1 : 0;
+	result = refresh_cache(REFRESH_SAY_CHANGED) ? 1 : 0;
 	if (write_cache(fd, active_cache, active_nr) ||
 			commit_locked_index(index_lock))
 		return error ("Could not refresh index");
diff --git a/cache.h b/cache.h
index 9735b66..da87c72 100644
--- a/cache.h
+++ b/cache.h
@@ -397,6 +397,7 @@ extern void fill_stat_cache_info(struct cache_entry *ce, struct stat *st);
 #define REFRESH_QUIET		0x0004	/* be quiet about it */
 #define REFRESH_IGNORE_MISSING	0x0008	/* ignore non-existent */
 #define REFRESH_IGNORE_SUBMODULES	0x0010	/* ignore submodules */
+#define REFRESH_SAY_CHANGED	0x0020	/* say "changed" not "needs update" */
 extern int refresh_index(struct index_state *, unsigned int flags, const char **pathspec, char *seen);
 
 struct lock_file {
diff --git a/read-cache.c b/read-cache.c
index f83de8c..9839362 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -980,7 +980,10 @@ int refresh_index(struct index_state *istate, unsigned int flags, const char **p
 	int not_new = (flags & REFRESH_IGNORE_MISSING) != 0;
 	int ignore_submodules = (flags & REFRESH_IGNORE_SUBMODULES) != 0;
 	unsigned int options = really ? CE_MATCH_IGNORE_VALID : 0;
+	const char *needs_update_message;
 
+	needs_update_message = ((flags & REFRESH_SAY_CHANGED)
+				? "locally modified" : "needs update");
 	for (i = 0; i < istate->cache_nr; i++) {
 		struct cache_entry *ce, *new;
 		int cache_errno = 0;
@@ -1019,7 +1022,7 @@ int refresh_index(struct index_state *istate, unsigned int flags, const char **p
 			}
 			if (quiet)
 				continue;
-			printf("%s: needs update\n", ce->name);
+			printf("%s: %s\n", ce->name, needs_update_message);
 			has_errors = 1;
 			continue;
 		}
diff --git a/t/t7102-reset.sh b/t/t7102-reset.sh
index 96d1508..da4b142 100755
--- a/t/t7102-reset.sh
+++ b/t/t7102-reset.sh
@@ -419,7 +419,7 @@ test_expect_success 'resetting an unmodified path is a no-op' '
 '
 
 cat > expect << EOF
-file2: needs update
+file2: locally modified
 EOF
 
 test_expect_success '--mixed refreshes the index' '
