From: Kjetil Barvik <barvik@broadpark.no>
Subject: [PATCH 2/2] better introduction of GIT with USE_NSEC defined
Date: Wed, 04 Mar 2009 18:47:40 +0100
Message-ID: <6d937a859ca499f534eea08720fca84f3d4ded2f.1236187259.git.barvik@broadpark.no>
References: <cover.1236187259.git.barvik@broadpark.no>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>,
	Kjetil Barvik <barvik@broadpark.no>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 04 18:49:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LevDW-0000US-GH
	for gcvg-git-2@gmane.org; Wed, 04 Mar 2009 18:49:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754429AbZCDRrt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Mar 2009 12:47:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753421AbZCDRrt
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Mar 2009 12:47:49 -0500
Received: from osl1smout1.broadpark.no ([80.202.4.58]:44530 "EHLO
	osl1smout1.broadpark.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753963AbZCDRrp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Mar 2009 12:47:45 -0500
Received: from osl1sminn1.broadpark.no ([80.202.4.59])
 by osl1smout1.broadpark.no
 (Sun Java(tm) System Messaging Server 6.3-3.01 (built Jul 12 2007; 32bit))
 with ESMTP id <0KFZ00CFJTFIM710@osl1smout1.broadpark.no> for
 git@vger.kernel.org; Wed, 04 Mar 2009 18:47:42 +0100 (CET)
Received: from localhost.localdomain ([80.202.166.182])
 by osl1sminn1.broadpark.no
 (Sun Java(tm) System Messaging Server 6.3-3.01 (built Jul 12 2007; 32bit))
 with ESMTPA id <0KFZ00BZKTFGLP50@osl1sminn1.broadpark.no> for
 git@vger.kernel.org; Wed, 04 Mar 2009 18:47:42 +0100 (CET)
X-Mailer: git-send-email 1.6.1.GIT
In-reply-to: <cover.1236187259.git.barvik@broadpark.no>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112228>

Change the source code such that when USE_NSEC is not defined,
possible nanosecond timestamps will still be saved in the index file,
but not used inside if-test's, and will therefore not affect the
outcome of GIT commands, other than the saved nanosecond timestamps in
the index file.

This will make it easier to use a system with 2 versions of GIT, one
with and one without USE_NSEC defined.

Signed-off-by: Kjetil Barvik <barvik@broadpark.no>
---
 read-cache.c   |   23 +----------------------
 unpack-trees.c |    2 --
 2 files changed, 1 insertions(+), 24 deletions(-)

diff --git a/read-cache.c b/read-cache.c
index 91f1d03..7fca804 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -69,13 +69,8 @@ void fill_stat_cache_info(struct cache_entry *ce, struct stat *st)
 {
 	ce->ce_ctime.sec = (unsigned int)st->st_ctime;
 	ce->ce_mtime.sec = (unsigned int)st->st_mtime;
-#ifdef USE_NSEC
 	ce->ce_ctime.nsec = (unsigned int)st->st_ctim.tv_nsec;
 	ce->ce_mtime.nsec = (unsigned int)st->st_mtim.tv_nsec;
-#else
-	ce->ce_ctime.nsec = 0;
-	ce->ce_mtime.nsec = 0;
-#endif
 	ce->ce_dev = st->st_dev;
 	ce->ce_ino = st->st_ino;
 	ce->ce_uid = st->st_uid;
@@ -1183,13 +1178,8 @@ static void convert_from_disk(struct ondisk_cache_entry *ondisk, struct cache_en
 
 	ce->ce_ctime.sec = ntohl(ondisk->ctime.sec);
 	ce->ce_mtime.sec = ntohl(ondisk->mtime.sec);
-#ifdef USE_NSEC
 	ce->ce_ctime.nsec = ntohl(ondisk->ctime.nsec);
 	ce->ce_mtime.nsec = ntohl(ondisk->mtime.nsec);
-#else
-	ce->ce_ctime.nsec = 0;
-	ce->ce_mtime.nsec = 0;
-#endif
 	ce->ce_dev   = ntohl(ondisk->dev);
 	ce->ce_ino   = ntohl(ondisk->ino);
 	ce->ce_mode  = ntohl(ondisk->mode);
@@ -1308,12 +1298,8 @@ int read_index_from(struct index_state *istate, const char *path)
 		src_offset += ondisk_ce_size(ce);
 		dst_offset += ce_size(ce);
 	}
-	istate->timestamp.sec = st.st_mtime;
-#ifdef USE_NSEC
+	istate->timestamp.sec = (unsigned int)st.st_mtime;
 	istate->timestamp.nsec = (unsigned int)st.st_mtim.tv_nsec;
-#else
-	istate->timestamp.nsec = 0;
-#endif
 
 	while (src_offset <= mmap_size - 20 - 8) {
 		/* After an array of active_nr index entries,
@@ -1500,13 +1486,8 @@ static int ce_write_entry(git_SHA_CTX *c, int fd, struct cache_entry *ce)
 
 	ondisk->ctime.sec = htonl(ce->ce_ctime.sec);
 	ondisk->mtime.sec = htonl(ce->ce_mtime.sec);
-#ifdef USE_NSEC
 	ondisk->ctime.nsec = htonl(ce->ce_ctime.nsec);
 	ondisk->mtime.nsec = htonl(ce->ce_mtime.nsec);
-#else
-	ondisk->ctime.nsec = 0;
-	ondisk->mtime.nsec = 0;
-#endif
 	ondisk->dev  = htonl(ce->ce_dev);
 	ondisk->ino  = htonl(ce->ce_ino);
 	ondisk->mode = htonl(ce->ce_mode);
@@ -1583,9 +1564,7 @@ int write_index(struct index_state *istate, int newfd)
 	if (ce_flush(&c, newfd) || fstat(newfd, &st))
 		return -1;
 	istate->timestamp.sec = (unsigned int)st.st_ctime;
-#ifdef USE_NSEC
 	istate->timestamp.nsec = (unsigned int)st.st_ctim.tv_nsec;
-#endif
 	return 0;
 }
 
diff --git a/unpack-trees.c b/unpack-trees.c
index 9fe0cd5..da2e3c0 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -362,9 +362,7 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
 	o->result.initialized = 1;
 	if (o->src_index) {
 		o->result.timestamp.sec = o->src_index->timestamp.sec;
-#ifdef USE_NSEC
 		o->result.timestamp.nsec = o->src_index->timestamp.nsec;
-#endif
 	}
 	o->merge_size = len;
 
-- 
1.6.1.GIT
