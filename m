From: Kjetil Barvik <barvik@broadpark.no>
Subject: [PATCH] write_index(): update index_stat->timestamp after flushing to
 disk
Date: Sun, 22 Feb 2009 15:09:21 +0100
Message-ID: <1235311761-30776-1-git-send-email-barvik@broadpark.no>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>,
	Kjetil Barvik <barvik@broadpark.no>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 22 15:13:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LbF5U-0000yv-UK
	for gcvg-git-2@gmane.org; Sun, 22 Feb 2009 15:13:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752212AbZBVOJ1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Feb 2009 09:09:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752071AbZBVOJ0
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Feb 2009 09:09:26 -0500
Received: from osl1smout1.broadpark.no ([80.202.4.58]:59768 "EHLO
	osl1smout1.broadpark.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752069AbZBVOJZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Feb 2009 09:09:25 -0500
Received: from osl1sminn1.broadpark.no ([80.202.4.59])
 by osl1smout1.broadpark.no
 (Sun Java(tm) System Messaging Server 6.3-3.01 (built Jul 12 2007; 32bit))
 with ESMTP id <0KFH002650NNH590@osl1smout1.broadpark.no> for
 git@vger.kernel.org; Sun, 22 Feb 2009 15:09:23 +0100 (CET)
Received: from localhost.localdomain ([80.203.78.15])
 by osl1sminn1.broadpark.no
 (Sun Java(tm) System Messaging Server 6.3-3.01 (built Jul 12 2007; 32bit))
 with ESMTPA id <0KFH009V80NLVZ70@osl1sminn1.broadpark.no> for
 git@vger.kernel.org; Sun, 22 Feb 2009 15:09:23 +0100 (CET)
X-Mailer: git-send-email 1.6.1.349.g99fa5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111006>

Since this timestamp is used to check for racy-clean files, it is
important to keep it uptodate.

For the 'git checkout' command without the '-q' option, this make a
huge difference.  Before, each and every file which was updated, was
racy-clean after the call to unpack_trees() and write_index() but
before the GIT process ended.

And because of the call to show_local_changes() in builtin-checkout.c,
we ended up reading those files back into memory, doing a SHA1 to
check if the files was really different from the index.  And, of
course, no file was different.

With this fix, 'git checkout' without the '-q' option should now be
almost as fast as with the '-q' option, but not quite, as we still do
some few lstat(2) calls more without the '-q' option.

Signed-off-by: Kjetil Barvik <barvik@broadpark.no>
---
  patch aginst the 'next' branch this time!  :-)

 cache.h      |    2 +-
 read-cache.c |   11 +++++++++--
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/cache.h b/cache.h
index 20446c1..7e454a7 100644
--- a/cache.h
+++ b/cache.h
@@ -430,7 +430,7 @@ extern int read_index_preload(struct index_state *, const char **pathspec);
 extern int read_index_from(struct index_state *, const char *path);
 extern int is_index_unborn(struct index_state *);
 extern int read_index_unmerged(struct index_state *);
-extern int write_index(const struct index_state *, int newfd);
+extern int write_index(struct index_state *, int newfd);
 extern int discard_index(struct index_state *);
 extern int unmerged_index(const struct index_state *);
 extern int verify_path(const char *path);
diff --git a/read-cache.c b/read-cache.c
index bb07371..4212719 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1528,13 +1528,14 @@ static int ce_write_entry(git_SHA_CTX *c, int fd, struct cache_entry *ce)
 	return ce_write(c, fd, ondisk, size);
 }
 
-int write_index(const struct index_state *istate, int newfd)
+int write_index(struct index_state *istate, int newfd)
 {
 	git_SHA_CTX c;
 	struct cache_header hdr;
 	int i, err, removed, extended;
 	struct cache_entry **cache = istate->cache;
 	int entries = istate->cache_nr;
+	struct stat st;
 
 	for (i = removed = extended = 0; i < entries; i++) {
 		if (cache[i]->ce_flags & CE_REMOVE)
@@ -1578,7 +1579,13 @@ int write_index(const struct index_state *istate, int newfd)
 		if (err)
 			return -1;
 	}
-	return ce_flush(&c, newfd);
+	if (ce_flush(&c, newfd) || fstat(newfd, &st))
+		return -1;
+	istate->timestamp.sec = (unsigned int)st.st_ctime;
+#ifdef USE_NSEC
+	istate->timestamp.nsec = (unsigned int)st.st_ctim.tv_nsec;
+#endif
+	return 0;
 }
 
 /*
-- 
1.6.1.349.g99fa5
