From: Kjetil Barvik <barvik@broadpark.no>
Subject: [PATCH/RFC v2 2/3] make USE_NSEC work as expected
Date: Thu, 19 Feb 2009 21:08:29 +0100
Message-ID: <24cefa55a62e2c898f9bd75ff7a6fe8e70836cf0.1235071656.git.barvik@broadpark.no>
References: <cover.1235071656.git.barvik@broadpark.no>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>,
	Kjetil Barvik <barvik@broadpark.no>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 19 21:10:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LaFDg-0003Qc-85
	for gcvg-git-2@gmane.org; Thu, 19 Feb 2009 21:10:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752490AbZBSUIk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Feb 2009 15:08:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752411AbZBSUIi
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Feb 2009 15:08:38 -0500
Received: from osl1smout1.broadpark.no ([80.202.4.58]:52173 "EHLO
	osl1smout1.broadpark.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752165AbZBSUIf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Feb 2009 15:08:35 -0500
Received: from osl1sminn1.broadpark.no ([80.202.4.59])
 by osl1smout1.broadpark.no
 (Sun Java(tm) System Messaging Server 6.3-3.01 (built Jul 12 2007; 32bit))
 with ESMTP id <0KFB00FW4XA9LA20@osl1smout1.broadpark.no> for
 git@vger.kernel.org; Thu, 19 Feb 2009 21:08:33 +0100 (CET)
Received: from localhost.localdomain ([80.203.78.205])
 by osl1sminn1.broadpark.no
 (Sun Java(tm) System Messaging Server 6.3-3.01 (built Jul 12 2007; 32bit))
 with ESMTPA id <0KFB00L04XA6CY10@osl1sminn1.broadpark.no> for
 git@vger.kernel.org; Thu, 19 Feb 2009 21:08:33 +0100 (CET)
X-Mailer: git-send-email 1.6.1.349.g99fa5
In-reply-to: <cover.1235071656.git.barvik@broadpark.no>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110740>

Since the filesystem ext4 is now defined as stable in Linux v2.6.28,
and ext4 supports nanonsecond resolution timestamps natively, it is
time to make USE_NSEC work as expected.

This will make racy git situations less likely to happen.  For 'git
checkout' this means it will be less likely that we have to open, read
the contents of the file into RAM, and check if file is really
modified or not.  The result sould be a litle less used CPU time, less
pagefaults and a litle faster program, at least for 'git checkout'.

Since the number of possible racy git situations would increase when
disks gets faster, this patch would be more and more helpfull as times
go by.  For a fast Solid State Disk, this patch should be helpfull.

Note that, when file operations starts to take less than 1 nanosecond,
one would again start to get more racy git situations.

For more info on racy git, see Documentation/technical/racy-git.txt
For more info on ext4, see http://kernelnewbies.org/Ext4

Signed-off-by: Kjetil Barvik <barvik@broadpark.no>
---
 cache.h        |    6 ++--
 read-cache.c   |   70 ++++++++++++++++++++++++++++++++++++++++++++-----------
 unpack-trees.c |    8 ++++-
 3 files changed, 65 insertions(+), 19 deletions(-)

diff --git a/cache.h b/cache.h
index 37dfb1c..309053d 100644
--- a/cache.h
+++ b/cache.h
@@ -140,8 +140,8 @@ struct ondisk_cache_entry_extended {
 };
 
 struct cache_entry {
-	unsigned int ce_ctime;
-	unsigned int ce_mtime;
+	struct cache_time ce_ctime;
+	struct cache_time ce_mtime;
 	unsigned int ce_dev;
 	unsigned int ce_ino;
 	unsigned int ce_mode;
@@ -282,7 +282,7 @@ struct index_state {
 	struct cache_entry **cache;
 	unsigned int cache_nr, cache_alloc, cache_changed;
 	struct cache_tree *cache_tree;
-	time_t timestamp;
+	struct cache_time timestamp;
 	void *alloc;
 	unsigned name_hash_initialized : 1,
 		 initialized : 1;
diff --git a/read-cache.c b/read-cache.c
index 940ec76..ca4bec2 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -67,8 +67,15 @@ void rename_index_entry_at(struct index_state *istate, int nr, const char *new_n
  */
 void fill_stat_cache_info(struct cache_entry *ce, struct stat *st)
 {
-	ce->ce_ctime = st->st_ctime;
-	ce->ce_mtime = st->st_mtime;
+	ce->ce_ctime.sec = (unsigned int)st->st_ctime;
+	ce->ce_mtime.sec = (unsigned int)st->st_mtime;
+#ifdef USE_NSEC
+	ce->ce_ctime.nsec = (unsigned int)st->st_ctim.tv_nsec;
+	ce->ce_mtime.nsec = (unsigned int)st->st_mtim.tv_nsec;
+#else
+	ce->ce_ctime.nsec = 0;
+	ce->ce_mtime.nsec = 0;
+#endif
 	ce->ce_dev = st->st_dev;
 	ce->ce_ino = st->st_ino;
 	ce->ce_uid = st->st_uid;
@@ -196,11 +203,18 @@ static int ce_match_stat_basic(struct cache_entry *ce, struct stat *st)
 	default:
 		die("internal error: ce_mode is %o", ce->ce_mode);
 	}
-	if (ce->ce_mtime != (unsigned int) st->st_mtime)
+	if (ce->ce_mtime.sec != (unsigned int)st->st_mtime)
 		changed |= MTIME_CHANGED;
-	if (trust_ctime && ce->ce_ctime != (unsigned int) st->st_ctime)
+	if (trust_ctime && ce->ce_ctime.sec != (unsigned int)st->st_ctime)
 		changed |= CTIME_CHANGED;
 
+#ifdef USE_NSEC
+	if (ce->ce_mtime.nsec != (unsigned int)st->st_mtim.tv_nsec)
+		changed |= MTIME_CHANGED;
+	if (trust_ctime && ce->ce_ctime.nsec != (unsigned int)st->st_ctim.tv_nsec)
+		changed |= CTIME_CHANGED;
+#endif
+
 	if (ce->ce_uid != (unsigned int) st->st_uid ||
 	    ce->ce_gid != (unsigned int) st->st_gid)
 		changed |= OWNER_CHANGED;
@@ -232,8 +246,16 @@ static int ce_match_stat_basic(struct cache_entry *ce, struct stat *st)
 static int is_racy_timestamp(const struct index_state *istate, struct cache_entry *ce)
 {
 	return (!S_ISGITLINK(ce->ce_mode) &&
-		istate->timestamp &&
-		((unsigned int)istate->timestamp) <= ce->ce_mtime);
+		istate->timestamp.sec &&
+#ifdef USE_NSEC
+		 /* nanosecond timestamped files can also be racy! */
+		(istate->timestamp.sec < ce->ce_mtime.sec ||
+		 (istate->timestamp.sec == ce->ce_mtime.sec &&
+		  istate->timestamp.nsec <= ce->ce_mtime.nsec))
+#else
+		istate->timestamp.sec <= ce->ce_mtime.sec
+#endif
+		 );
 }
 
 int ie_match_stat(const struct index_state *istate,
@@ -1139,8 +1161,15 @@ static void convert_from_disk(struct ondisk_cache_entry *ondisk, struct cache_en
 	size_t len;
 	const char *name;
 
-	ce->ce_ctime = ntohl(ondisk->ctime.sec);
-	ce->ce_mtime = ntohl(ondisk->mtime.sec);
+	ce->ce_ctime.sec = ntohl(ondisk->ctime.sec);
+	ce->ce_mtime.sec = ntohl(ondisk->mtime.sec);
+#ifdef USE_NSEC
+	ce->ce_ctime.nsec = ntohl(ondisk->ctime.nsec);
+	ce->ce_mtime.nsec = ntohl(ondisk->mtime.nsec);
+#else
+	ce->ce_ctime.nsec = 0;
+	ce->ce_mtime.nsec = 0;
+#endif
 	ce->ce_dev   = ntohl(ondisk->dev);
 	ce->ce_ino   = ntohl(ondisk->ino);
 	ce->ce_mode  = ntohl(ondisk->mode);
@@ -1206,7 +1235,8 @@ int read_index_from(struct index_state *istate, const char *path)
 		return istate->cache_nr;
 
 	errno = ENOENT;
-	istate->timestamp = 0;
+	istate->timestamp.sec = 0;
+	istate->timestamp.nsec = 0;
 	fd = open(path, O_RDONLY);
 	if (fd < 0) {
 		if (errno == ENOENT)
@@ -1258,7 +1288,13 @@ int read_index_from(struct index_state *istate, const char *path)
 		src_offset += ondisk_ce_size(ce);
 		dst_offset += ce_size(ce);
 	}
-	istate->timestamp = st.st_mtime;
+	istate->timestamp.sec = st.st_mtime;
+#ifdef USE_NSEC
+	istate->timestamp.nsec = (unsigned int)st.st_mtim.tv_nsec;
+#else
+	istate->timestamp.nsec = 0;
+#endif
+
 	while (src_offset <= mmap_size - 20 - 8) {
 		/* After an array of active_nr index entries,
 		 * there can be arbitrary number of extended
@@ -1288,14 +1324,15 @@ unmap:
 
 int is_index_unborn(struct index_state *istate)
 {
-	return (!istate->cache_nr && !istate->alloc && !istate->timestamp);
+	return (!istate->cache_nr && !istate->alloc && !istate->timestamp.sec);
 }
 
 int discard_index(struct index_state *istate)
 {
 	istate->cache_nr = 0;
 	istate->cache_changed = 0;
-	istate->timestamp = 0;
+	istate->timestamp.sec = 0;
+	istate->timestamp.nsec = 0;
 	istate->name_hash_initialized = 0;
 	free_hash(&istate->name_hash);
 	cache_tree_free(&(istate->cache_tree));
@@ -1441,10 +1478,15 @@ static int ce_write_entry(git_SHA_CTX *c, int fd, struct cache_entry *ce)
 	struct ondisk_cache_entry *ondisk = xcalloc(1, size);
 	char *name;
 
-	ondisk->ctime.sec = htonl(ce->ce_ctime);
+	ondisk->ctime.sec = htonl(ce->ce_ctime.sec);
+	ondisk->mtime.sec = htonl(ce->ce_mtime.sec);
+#ifdef USE_NSEC
+	ondisk->ctime.nsec = htonl(ce->ce_ctime.nsec);
+	ondisk->mtime.nsec = htonl(ce->ce_mtime.nsec);
+#else
 	ondisk->ctime.nsec = 0;
-	ondisk->mtime.sec = htonl(ce->ce_mtime);
 	ondisk->mtime.nsec = 0;
+#endif
 	ondisk->dev  = htonl(ce->ce_dev);
 	ondisk->ino  = htonl(ce->ce_ino);
 	ondisk->mode = htonl(ce->ce_mode);
diff --git a/unpack-trees.c b/unpack-trees.c
index e547282..44714cc 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -380,8 +380,12 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
 
 	memset(&o->result, 0, sizeof(o->result));
 	o->result.initialized = 1;
-	if (o->src_index)
-		o->result.timestamp = o->src_index->timestamp;
+	if (o->src_index) {
+		o->result.timestamp.sec = o->src_index->timestamp.sec;
+#ifdef USE_NSEC
+		o->result.timestamp.nsec = o->src_index->timestamp.nsec;
+#endif
+	}
 	o->merge_size = len;
 
 	if (!dfc)
-- 
1.6.1.349.g99fa5
