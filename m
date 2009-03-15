From: Kjetil Barvik <barvik@broadpark.no>
Subject: [PATCH 2/2] make the ST_{C,M}TIME_NSEC macros more function like
Date: Sun, 15 Mar 2009 12:38:56 +0100
Message-ID: <0681248ac5c9cedf5f42adeeae89966a89e6d42a.1237115791.git.barvik@broadpark.no>
References: <cover.1237115791.git.barvik@broadpark.no>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>,
	Kjetil Barvik <barvik@broadpark.no>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 15 12:40:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Liohl-0001dx-IK
	for gcvg-git-2@gmane.org; Sun, 15 Mar 2009 12:40:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756921AbZCOLjI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Mar 2009 07:39:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754267AbZCOLjH
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Mar 2009 07:39:07 -0400
Received: from osl1smout1.broadpark.no ([80.202.4.58]:57828 "EHLO
	osl1smout1.broadpark.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755417AbZCOLjC (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Mar 2009 07:39:02 -0400
Received: from osl1sminn1.broadpark.no ([80.202.4.59])
 by osl1smout1.broadpark.no
 (Sun Java(tm) System Messaging Server 6.3-3.01 (built Jul 12 2007; 32bit))
 with ESMTP id <0KGJ00A83POZ1PA0@osl1smout1.broadpark.no> for
 git@vger.kernel.org; Sun, 15 Mar 2009 12:38:59 +0100 (CET)
Received: from localhost.localdomain ([80.203.106.191])
 by osl1sminn1.broadpark.no
 (Sun Java(tm) System Messaging Server 6.3-3.01 (built Jul 12 2007; 32bit))
 with ESMTPA id <0KGJ001V7POXJX50@osl1sminn1.broadpark.no> for
 git@vger.kernel.org; Sun, 15 Mar 2009 12:38:59 +0100 (CET)
X-Mailer: git-send-email 1.6.2.GIT
In-reply-to: <cover.1237115791.git.barvik@broadpark.no>
In-reply-to: <cover.1237115791.git.barvik@broadpark.no>
References: <cover.1237115791.git.barvik@broadpark.no>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113283>

Make the macros take a pointer to a 'struct stat'. This is so that it
should be easier to understand what is going on, and that the macros
can later be implemented as a inline function if we want to.

Impact: cosmetic change

Signed-off-by: Kjetil Barvik <barvik@broadpark.no>
---
 builtin-fetch-pack.c |    4 ++--
 git-compat-util.h    |    8 ++++----
 read-cache.c         |   12 ++++++------
 3 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/builtin-fetch-pack.c b/builtin-fetch-pack.c
index d571253..0cd50f3 100644
--- a/builtin-fetch-pack.c
+++ b/builtin-fetch-pack.c
@@ -800,13 +800,13 @@ struct ref *fetch_pack(struct fetch_pack_args *my_args,
 		int fd;
 
 		mtime.sec = st.st_mtime;
-		mtime.nsec = ST_MTIME_NSEC(st);
+		mtime.nsec = ST_MTIME_NSEC(&st);
 		if (stat(shallow, &st)) {
 			if (mtime.sec)
 				die("shallow file was removed during fetch");
 		} else if (st.st_mtime != mtime.sec
 #ifdef USE_NSEC
-				|| ST_MTIME_NSEC(st) != mtime.nsec
+				|| ST_MTIME_NSEC(&st) != mtime.nsec
 #endif
 			  )
 			die("shallow file was changed during fetch");
diff --git a/git-compat-util.h b/git-compat-util.h
index 1906253..4a633be 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -394,11 +394,11 @@ void git_qsort(void *base, size_t nmemb, size_t size,
 #define ST_MTIME_NSEC(st) 0
 #else
 #ifdef USE_ST_TIMESPEC
-#define ST_CTIME_NSEC(st) ((unsigned int)((st).st_ctimespec.tv_nsec))
-#define ST_MTIME_NSEC(st) ((unsigned int)((st).st_mtimespec.tv_nsec))
+#define ST_CTIME_NSEC(st) ((unsigned int)((st)->st_ctimespec.tv_nsec))
+#define ST_MTIME_NSEC(st) ((unsigned int)((st)->st_mtimespec.tv_nsec))
 #else
-#define ST_CTIME_NSEC(st) ((unsigned int)((st).st_ctim.tv_nsec))
-#define ST_MTIME_NSEC(st) ((unsigned int)((st).st_mtim.tv_nsec))
+#define ST_CTIME_NSEC(st) ((unsigned int)((st)->st_ctim.tv_nsec))
+#define ST_MTIME_NSEC(st) ((unsigned int)((st)->st_mtim.tv_nsec))
 #endif
 #endif
 
diff --git a/read-cache.c b/read-cache.c
index 3f58711..cff85e3 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -69,8 +69,8 @@ void fill_stat_cache_info(struct cache_entry *ce, struct stat *st)
 {
 	ce->ce_ctime.sec = (unsigned int)st->st_ctime;
 	ce->ce_mtime.sec = (unsigned int)st->st_mtime;
-	ce->ce_ctime.nsec = ST_CTIME_NSEC(*st);
-	ce->ce_mtime.nsec = ST_MTIME_NSEC(*st);
+	ce->ce_ctime.nsec = ST_CTIME_NSEC(st);
+	ce->ce_mtime.nsec = ST_MTIME_NSEC(st);
 	ce->ce_dev = st->st_dev;
 	ce->ce_ino = st->st_ino;
 	ce->ce_uid = st->st_uid;
@@ -204,9 +204,9 @@ static int ce_match_stat_basic(struct cache_entry *ce, struct stat *st)
 		changed |= CTIME_CHANGED;
 
 #ifdef USE_NSEC
-	if (ce->ce_mtime.nsec != ST_MTIME_NSEC(*st))
+	if (ce->ce_mtime.nsec != ST_MTIME_NSEC(st))
 		changed |= MTIME_CHANGED;
-	if (trust_ctime && ce->ce_ctime.nsec != ST_CTIME_NSEC(*st))
+	if (trust_ctime && ce->ce_ctime.nsec != ST_CTIME_NSEC(st))
 		changed |= CTIME_CHANGED;
 #endif
 
@@ -1299,7 +1299,7 @@ int read_index_from(struct index_state *istate, const char *path)
 		dst_offset += ce_size(ce);
 	}
 	istate->timestamp.sec = st.st_mtime;
-	istate->timestamp.nsec = ST_MTIME_NSEC(st);
+	istate->timestamp.nsec = ST_MTIME_NSEC(&st);
 
 	while (src_offset <= mmap_size - 20 - 8) {
 		/* After an array of active_nr index entries,
@@ -1564,7 +1564,7 @@ int write_index(struct index_state *istate, int newfd)
 	if (ce_flush(&c, newfd) || fstat(newfd, &st))
 		return -1;
 	istate->timestamp.sec = (unsigned int)st.st_mtime;
-	istate->timestamp.nsec = ST_MTIME_NSEC(st);
+	istate->timestamp.nsec = ST_MTIME_NSEC(&st);
 	return 0;
 }
 
-- 
1.6.2.GIT
