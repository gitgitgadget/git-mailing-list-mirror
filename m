From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 08/12] Extract a struct stat_data from cache_entry
Date: Wed, 19 Jun 2013 09:51:29 +0200
Message-ID: <1371628293-28824-9-git-send-email-mhagger@alum.mit.edu>
References: <1371628293-28824-1-git-send-email-mhagger@alum.mit.edu>
Cc: Jeff King <peff@peff.net>, Johan Herland <johan@herland.net>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 19 09:52:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UpDC5-0003fT-An
	for gcvg-git-2@plane.gmane.org; Wed, 19 Jun 2013 09:52:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756666Ab3FSHwE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Jun 2013 03:52:04 -0400
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:45880 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756422Ab3FSHwB (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 19 Jun 2013 03:52:01 -0400
X-AuditID: 1207440f-b7f786d000001f20-1b-51c163204ae4
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id 73.49.07968.02361C15; Wed, 19 Jun 2013 03:52:00 -0400 (EDT)
Received: from michael.berlin.jpk.com (mx.berlin.jpk.com [212.222.128.135] (may be forged))
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r5J7pZWa002453
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 19 Jun 2013 03:51:59 -0400
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1371628293-28824-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrAIsWRmVeSWpSXmKPExsUixO6iqKuQfDDQ4Mx6OYuuK91MFg29V5gt
	5t3dxWRxe8V8ZosfLT3MFrunLWBzYPP4+/4Dk8ell9/ZPJ717mH0uHhJ2ePxxBOsHp83yQWw
	RXHbJCWWlAVnpufp2yVwZ3y+PIm9YH9Exe9d11kbGP94dDFyckgImEjMX9XMDmGLSVy4t56t
	i5GLQ0jgMqPEuxlnmCCc20wSsxa/YwapYhPQlVjU08wEYosIqElMbDvEAlLELLCbUWL56VNA
	ozg4hAVcJbbsUgSpYRFQlTj34DpYPa+Ai0TDm4msENsUJKY8fM8MUs4JVH52mSdIWAioZN6p
	yawTGHkXMDKsYpRLzCnN1c1NzMwpTk3WLU5OzMtLLdI10cvNLNFLTSndxAgJM/4djF3rZQ4x
	CnAwKvHwGq47ECjEmlhWXJl7iFGSg0lJlJc96WCgEF9SfkplRmJxRnxRaU5q8SFGCQ5mJRFe
	PQegHG9KYmVValE+TEqag0VJnFd9ibqfkEB6YklqdmpqQWoRTFaGg0NJglcMZKhgUWp6akVa
	Zk4JQpqJgxNEcIFs4AHacCQRZENxQWJucWY6RNEpRkUpcd57IAkBkERGaR7cAFhCeMUoDvSP
	MC8ryB4eYDKB634FNJgJaLDQ930gg0sSEVJSDYxbngU8fJ8tP4et7Lbm58h2ZX93Vu5DHJkr
	dDkPsix0yp2ncjlzF8uOqR7xf14sljTb6OYVqaM5p+OyfdvkykxdySeSZmJ3InLmp5bvu32f
	5ZjRnfgl55MfBHcprvN/wHlqyqTZV5PXGbe82qumMvPWY1k5hp4NlkqsLl2WqzZu 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228368>

Add public functions fill_stat_data() and match_stat_data() to work
with it.  This infrastructure will later be used to check the validity
of other types of file.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 builtin/ls-files.c |  12 +++--
 cache.h            |  33 +++++++++---
 read-cache.c       | 151 +++++++++++++++++++++++++++++------------------------
 3 files changed, 116 insertions(+), 80 deletions(-)

diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index 2202072..6a0730f 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -165,11 +165,13 @@ static void show_ce_entry(const char *tag, struct cache_entry *ce)
 	}
 	write_name(ce->name, ce_namelen(ce));
 	if (debug_mode) {
-		printf("  ctime: %d:%d\n", ce->ce_ctime.sec, ce->ce_ctime.nsec);
-		printf("  mtime: %d:%d\n", ce->ce_mtime.sec, ce->ce_mtime.nsec);
-		printf("  dev: %d\tino: %d\n", ce->ce_dev, ce->ce_ino);
-		printf("  uid: %d\tgid: %d\n", ce->ce_uid, ce->ce_gid);
-		printf("  size: %d\tflags: %x\n", ce->ce_size, ce->ce_flags);
+		struct stat_data *sd = &ce->ce_stat_data;
+
+		printf("  ctime: %d:%d\n", sd->sd_ctime.sec, sd->sd_ctime.nsec);
+		printf("  mtime: %d:%d\n", sd->sd_mtime.sec, sd->sd_mtime.nsec);
+		printf("  dev: %d\tino: %d\n", sd->sd_dev, sd->sd_ino);
+		printf("  uid: %d\tgid: %d\n", sd->sd_uid, sd->sd_gid);
+		printf("  size: %d\tflags: %x\n", sd->sd_size, ce->ce_flags);
 	}
 }
 
diff --git a/cache.h b/cache.h
index 820aa05..f158fed 100644
--- a/cache.h
+++ b/cache.h
@@ -119,15 +119,19 @@ struct cache_time {
 	unsigned int nsec;
 };
 
+struct stat_data {
+	struct cache_time sd_ctime;
+	struct cache_time sd_mtime;
+	unsigned int sd_dev;
+	unsigned int sd_ino;
+	unsigned int sd_uid;
+	unsigned int sd_gid;
+	unsigned int sd_size;
+};
+
 struct cache_entry {
-	struct cache_time ce_ctime;
-	struct cache_time ce_mtime;
-	unsigned int ce_dev;
-	unsigned int ce_ino;
+	struct stat_data ce_stat_data;
 	unsigned int ce_mode;
-	unsigned int ce_uid;
-	unsigned int ce_gid;
-	unsigned int ce_size;
 	unsigned int ce_flags;
 	unsigned int ce_namelen;
 	unsigned char sha1[20];
@@ -511,6 +515,21 @@ extern int limit_pathspec_to_literal(void);
 #define HASH_FORMAT_CHECK 2
 extern int index_fd(unsigned char *sha1, int fd, struct stat *st, enum object_type type, const char *path, unsigned flags);
 extern int index_path(unsigned char *sha1, const char *path, struct stat *st, unsigned flags);
+
+/*
+ * Record to sd the data from st that we use to check whether a file
+ * might have changed.
+ */
+extern void fill_stat_data(struct stat_data *sd, struct stat *st);
+
+/*
+ * Return 0 if st is consistent with a file not having been changed
+ * since sd was filled.  If there are differences, return a
+ * combination of MTIME_CHANGED, CTIME_CHANGED, OWNER_CHANGED,
+ * INODE_CHANGED, and DATA_CHANGED.
+ */
+extern int match_stat_data(const struct stat_data *sd, struct stat *st);
+
 extern void fill_stat_cache_info(struct cache_entry *ce, struct stat *st);
 
 #define REFRESH_REALLY		0x0001	/* ignore_valid */
diff --git a/read-cache.c b/read-cache.c
index 5e30746..5660b37 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -67,6 +67,61 @@ void rename_index_entry_at(struct index_state *istate, int nr, const char *new_n
 	add_index_entry(istate, new, ADD_CACHE_OK_TO_ADD|ADD_CACHE_OK_TO_REPLACE);
 }
 
+void fill_stat_data(struct stat_data *sd, struct stat *st)
+{
+	sd->sd_ctime.sec = (unsigned int)st->st_ctime;
+	sd->sd_mtime.sec = (unsigned int)st->st_mtime;
+	sd->sd_ctime.nsec = ST_CTIME_NSEC(*st);
+	sd->sd_mtime.nsec = ST_MTIME_NSEC(*st);
+	sd->sd_dev = st->st_dev;
+	sd->sd_ino = st->st_ino;
+	sd->sd_uid = st->st_uid;
+	sd->sd_gid = st->st_gid;
+	sd->sd_size = st->st_size;
+}
+
+int match_stat_data(const struct stat_data *sd, struct stat *st)
+{
+	int changed = 0;
+
+	if (sd->sd_mtime.sec != (unsigned int)st->st_mtime)
+		changed |= MTIME_CHANGED;
+	if (trust_ctime && check_stat &&
+	    sd->sd_ctime.sec != (unsigned int)st->st_ctime)
+		changed |= CTIME_CHANGED;
+
+#ifdef USE_NSEC
+	if (check_stat && sd->sd_mtime.nsec != ST_MTIME_NSEC(*st))
+		changed |= MTIME_CHANGED;
+	if (trust_ctime && check_stat &&
+	    sd->sd_ctime.nsec != ST_CTIME_NSEC(*st))
+		changed |= CTIME_CHANGED;
+#endif
+
+	if (check_stat) {
+		if (sd->sd_uid != (unsigned int) st->st_uid ||
+			sd->sd_gid != (unsigned int) st->st_gid)
+			changed |= OWNER_CHANGED;
+		if (sd->sd_ino != (unsigned int) st->st_ino)
+			changed |= INODE_CHANGED;
+	}
+
+#ifdef USE_STDEV
+	/*
+	 * st_dev breaks on network filesystems where different
+	 * clients will have different views of what "device"
+	 * the filesystem is on
+	 */
+	if (check_stat && sd->sd_dev != (unsigned int) st->st_dev)
+			changed |= INODE_CHANGED;
+#endif
+
+	if (sd->sd_size != (unsigned int) st->st_size)
+		changed |= DATA_CHANGED;
+
+	return changed;
+}
+
 /*
  * This only updates the "non-critical" parts of the directory
  * cache, ie the parts that aren't tracked by GIT, and only used
@@ -74,15 +129,7 @@ void rename_index_entry_at(struct index_state *istate, int nr, const char *new_n
  */
 void fill_stat_cache_info(struct cache_entry *ce, struct stat *st)
 {
-	ce->ce_ctime.sec = (unsigned int)st->st_ctime;
-	ce->ce_mtime.sec = (unsigned int)st->st_mtime;
-	ce->ce_ctime.nsec = ST_CTIME_NSEC(*st);
-	ce->ce_mtime.nsec = ST_MTIME_NSEC(*st);
-	ce->ce_dev = st->st_dev;
-	ce->ce_ino = st->st_ino;
-	ce->ce_uid = st->st_uid;
-	ce->ce_gid = st->st_gid;
-	ce->ce_size = st->st_size;
+	fill_stat_data(&ce->ce_stat_data, st);
 
 	if (assume_unchanged)
 		ce->ce_flags |= CE_VALID;
@@ -195,43 +242,11 @@ static int ce_match_stat_basic(const struct cache_entry *ce, struct stat *st)
 	default:
 		die("internal error: ce_mode is %o", ce->ce_mode);
 	}
-	if (ce->ce_mtime.sec != (unsigned int)st->st_mtime)
-		changed |= MTIME_CHANGED;
-	if (trust_ctime && check_stat &&
-	    ce->ce_ctime.sec != (unsigned int)st->st_ctime)
-		changed |= CTIME_CHANGED;
 
-#ifdef USE_NSEC
-	if (check_stat && ce->ce_mtime.nsec != ST_MTIME_NSEC(*st))
-		changed |= MTIME_CHANGED;
-	if (trust_ctime && check_stat &&
-	    ce->ce_ctime.nsec != ST_CTIME_NSEC(*st))
-		changed |= CTIME_CHANGED;
-#endif
-
-	if (check_stat) {
-		if (ce->ce_uid != (unsigned int) st->st_uid ||
-			ce->ce_gid != (unsigned int) st->st_gid)
-			changed |= OWNER_CHANGED;
-		if (ce->ce_ino != (unsigned int) st->st_ino)
-			changed |= INODE_CHANGED;
-	}
-
-#ifdef USE_STDEV
-	/*
-	 * st_dev breaks on network filesystems where different
-	 * clients will have different views of what "device"
-	 * the filesystem is on
-	 */
-	if (check_stat && ce->ce_dev != (unsigned int) st->st_dev)
-			changed |= INODE_CHANGED;
-#endif
-
-	if (ce->ce_size != (unsigned int) st->st_size)
-		changed |= DATA_CHANGED;
+	changed |= match_stat_data(&ce->ce_stat_data, st);
 
 	/* Racily smudged entry? */
-	if (!ce->ce_size) {
+	if (!ce->ce_stat_data.sd_size) {
 		if (!is_empty_blob_sha1(ce->sha1))
 			changed |= DATA_CHANGED;
 	}
@@ -246,11 +261,11 @@ static int is_racy_timestamp(const struct index_state *istate,
 		istate->timestamp.sec &&
 #ifdef USE_NSEC
 		 /* nanosecond timestamped files can also be racy! */
-		(istate->timestamp.sec < ce->ce_mtime.sec ||
-		 (istate->timestamp.sec == ce->ce_mtime.sec &&
-		  istate->timestamp.nsec <= ce->ce_mtime.nsec))
+		(istate->timestamp.sec < ce->ce_stat_data.sd_mtime.sec ||
+		 (istate->timestamp.sec == ce->ce_stat_data.sd_mtime.sec &&
+		  istate->timestamp.nsec <= ce->ce_stat_data.sd_mtime.nsec))
 #else
-		istate->timestamp.sec <= ce->ce_mtime.sec
+		istate->timestamp.sec <= ce->ce_stat_data.sd_mtime.sec
 #endif
 		 );
 }
@@ -342,7 +357,7 @@ int ie_modified(const struct index_state *istate,
 	 * then we know it is.
 	 */
 	if ((changed & DATA_CHANGED) &&
-	    (S_ISGITLINK(ce->ce_mode) || ce->ce_size != 0))
+	    (S_ISGITLINK(ce->ce_mode) || ce->ce_stat_data.sd_size != 0))
 		return changed;
 
 	changed_fs = ce_modified_check_fs(ce, st);
@@ -1324,16 +1339,16 @@ static struct cache_entry *cache_entry_from_ondisk(struct ondisk_cache_entry *on
 {
 	struct cache_entry *ce = xmalloc(cache_entry_size(len));
 
-	ce->ce_ctime.sec = ntoh_l(ondisk->ctime.sec);
-	ce->ce_mtime.sec = ntoh_l(ondisk->mtime.sec);
-	ce->ce_ctime.nsec = ntoh_l(ondisk->ctime.nsec);
-	ce->ce_mtime.nsec = ntoh_l(ondisk->mtime.nsec);
-	ce->ce_dev   = ntoh_l(ondisk->dev);
-	ce->ce_ino   = ntoh_l(ondisk->ino);
+	ce->ce_stat_data.sd_ctime.sec = ntoh_l(ondisk->ctime.sec);
+	ce->ce_stat_data.sd_mtime.sec = ntoh_l(ondisk->mtime.sec);
+	ce->ce_stat_data.sd_ctime.nsec = ntoh_l(ondisk->ctime.nsec);
+	ce->ce_stat_data.sd_mtime.nsec = ntoh_l(ondisk->mtime.nsec);
+	ce->ce_stat_data.sd_dev   = ntoh_l(ondisk->dev);
+	ce->ce_stat_data.sd_ino   = ntoh_l(ondisk->ino);
 	ce->ce_mode  = ntoh_l(ondisk->mode);
-	ce->ce_uid   = ntoh_l(ondisk->uid);
-	ce->ce_gid   = ntoh_l(ondisk->gid);
-	ce->ce_size  = ntoh_l(ondisk->size);
+	ce->ce_stat_data.sd_uid   = ntoh_l(ondisk->uid);
+	ce->ce_stat_data.sd_gid   = ntoh_l(ondisk->gid);
+	ce->ce_stat_data.sd_size  = ntoh_l(ondisk->size);
 	ce->ce_flags = flags & ~CE_NAMEMASK;
 	ce->ce_namelen = len;
 	hashcpy(ce->sha1, ondisk->sha1);
@@ -1610,7 +1625,7 @@ static void ce_smudge_racily_clean_entry(struct cache_entry *ce)
 	 * The only thing we care about in this function is to smudge the
 	 * falsely clean entry due to touch-update-touch race, so we leave
 	 * everything else as they are.  We are called for entries whose
-	 * ce_mtime match the index file mtime.
+	 * ce_stat_data.sd_mtime match the index file mtime.
 	 *
 	 * Note that this actually does not do much for gitlinks, for
 	 * which ce_match_stat_basic() always goes to the actual
@@ -1649,7 +1664,7 @@ static void ce_smudge_racily_clean_entry(struct cache_entry *ce)
 		 * file, and never calls us, so the cached size information
 		 * for "frotz" stays 6 which does not match the filesystem.
 		 */
-		ce->ce_size = 0;
+		ce->ce_stat_data.sd_size = 0;
 	}
 }
 
@@ -1659,16 +1674,16 @@ static char *copy_cache_entry_to_ondisk(struct ondisk_cache_entry *ondisk,
 {
 	short flags;
 
-	ondisk->ctime.sec = htonl(ce->ce_ctime.sec);
-	ondisk->mtime.sec = htonl(ce->ce_mtime.sec);
-	ondisk->ctime.nsec = htonl(ce->ce_ctime.nsec);
-	ondisk->mtime.nsec = htonl(ce->ce_mtime.nsec);
-	ondisk->dev  = htonl(ce->ce_dev);
-	ondisk->ino  = htonl(ce->ce_ino);
+	ondisk->ctime.sec = htonl(ce->ce_stat_data.sd_ctime.sec);
+	ondisk->mtime.sec = htonl(ce->ce_stat_data.sd_mtime.sec);
+	ondisk->ctime.nsec = htonl(ce->ce_stat_data.sd_ctime.nsec);
+	ondisk->mtime.nsec = htonl(ce->ce_stat_data.sd_mtime.nsec);
+	ondisk->dev  = htonl(ce->ce_stat_data.sd_dev);
+	ondisk->ino  = htonl(ce->ce_stat_data.sd_ino);
 	ondisk->mode = htonl(ce->ce_mode);
-	ondisk->uid  = htonl(ce->ce_uid);
-	ondisk->gid  = htonl(ce->ce_gid);
-	ondisk->size = htonl(ce->ce_size);
+	ondisk->uid  = htonl(ce->ce_stat_data.sd_uid);
+	ondisk->gid  = htonl(ce->ce_stat_data.sd_gid);
+	ondisk->size = htonl(ce->ce_stat_data.sd_size);
 	hashcpy(ondisk->sha1, ce->sha1);
 
 	flags = ce->ce_flags;
-- 
1.8.3.1
