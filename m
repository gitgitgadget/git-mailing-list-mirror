From: Max Kirillov <max@max630.net>
Subject: [PATCH/RFC 2/2] sha1_file: set packfile to O_CLOEXEC at open
Date: Thu,  1 Oct 2015 06:29:23 +0300
Message-ID: <1443670163-31193-3-git-send-email-max@max630.net>
References: <1443670163-31193-1-git-send-email-max@max630.net>
Cc: Max Kirillov <max@max630.net>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 01 05:30:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZhUZd-0001TF-Ob
	for gcvg-git-2@plane.gmane.org; Thu, 01 Oct 2015 05:30:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755305AbbJADaW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Sep 2015 23:30:22 -0400
Received: from p3plsmtpa07-09.prod.phx3.secureserver.net ([173.201.192.238]:54471
	"EHLO p3plsmtpa07-09.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755159AbbJAD3v (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 30 Sep 2015 23:29:51 -0400
Received: from wheezy.local ([82.181.81.240])
	by p3plsmtpa07-09.prod.phx3.secureserver.net with 
	id PfVh1r0055B68XE01fVpsZ; Wed, 30 Sep 2015 20:29:51 -0700
X-Mailer: git-send-email 2.3.4.2801.g3d0809b
In-Reply-To: <1443670163-31193-1-git-send-email-max@max630.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278881>

Windows does not support setting O_CLOEXEC by fcntl,
but there is an open flag O_NOINHERIT which results in same
behaviour. Use it in git_open_noatime() and also bring
setting O_CLOEXEC there also to make it consistent. Rename
the function to git_open_noatime_cloexec(), to avoid confusion.

Signed-off-by: Max Kirillov <max@max630.net>
---
 builtin/pack-objects.c |  2 +-
 cache.h                |  2 +-
 pack-bitmap.c          |  2 +-
 sha1_file.c            | 48 ++++++++++++++++++++++++++++--------------------
 4 files changed, 31 insertions(+), 23 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 1c63f8f..a8052f4 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -714,7 +714,7 @@ static off_t write_reused_pack(struct sha1file *f)
 	if (!is_pack_valid(reuse_packfile))
 		die("packfile is invalid: %s", reuse_packfile->pack_name);
 
-	fd = git_open_noatime(reuse_packfile->pack_name);
+	fd = git_open_noatime_cloexec(reuse_packfile->pack_name);
 	if (fd < 0)
 		die_errno("unable to open packfile for reuse: %s",
 			  reuse_packfile->pack_name);
diff --git a/cache.h b/cache.h
index 153bc46..77ef5ca 100644
--- a/cache.h
+++ b/cache.h
@@ -972,7 +972,7 @@ extern int write_sha1_file(const void *buf, unsigned long len, const char *type,
 extern int hash_sha1_file_literally(const void *buf, unsigned long len, const char *type, unsigned char *sha1, unsigned flags);
 extern int pretend_sha1_file(void *, unsigned long, enum object_type, unsigned char *);
 extern int force_object_loose(const unsigned char *sha1, time_t mtime);
-extern int git_open_noatime(const char *name);
+extern int git_open_noatime_cloexec(const char *name);
 extern void *map_sha1_file(const unsigned char *sha1, unsigned long *size);
 extern int unpack_sha1_header(git_zstream *stream, unsigned char *map, unsigned long mapsize, void *buffer, unsigned long bufsiz);
 extern int parse_sha1_header(const char *hdr, unsigned long *sizep);
diff --git a/pack-bitmap.c b/pack-bitmap.c
index 637770a..4a3b23c 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -274,7 +274,7 @@ static int open_pack_bitmap_1(struct packed_git *packfile)
 		return -1;
 
 	idx_name = pack_bitmap_filename(packfile);
-	fd = git_open_noatime(idx_name);
+	fd = git_open_noatime_cloexec(idx_name);
 	free(idx_name);
 
 	if (fd < 0)
diff --git a/sha1_file.c b/sha1_file.c
index 62f1dad..2da5de2 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -385,7 +385,7 @@ void read_info_alternates(const char * relative_base, int depth)
 	int fd;
 
 	sprintf(path, "%s/%s", relative_base, alt_file_name);
-	fd = git_open_noatime(path);
+	fd = git_open_noatime_cloexec(path);
 	if (fd < 0)
 		return;
 	if (fstat(fd, &st) || (st.st_size == 0)) {
@@ -575,7 +575,7 @@ static int check_packed_git_idx(const char *path, struct packed_git *p)
 	struct pack_idx_header *hdr;
 	size_t idx_size;
 	uint32_t version, nr, i, *index;
-	int fd = git_open_noatime(path);
+	int fd = git_open_noatime_cloexec(path);
 	struct stat st;
 
 	if (fd < 0)
@@ -995,7 +995,6 @@ static int open_packed_git_1(struct packed_git *p)
 	struct pack_header hdr;
 	unsigned char sha1[20];
 	unsigned char *idx_sha1;
-	long fd_flag;
 
 	if (!p->index_data && open_pack_index(p))
 		return error("packfile %s index unavailable", p->pack_name);
@@ -1013,7 +1012,7 @@ static int open_packed_git_1(struct packed_git *p)
 	while (pack_max_fds <= pack_open_fds && close_one_pack())
 		; /* nothing */
 
-	p->pack_fd = git_open_noatime(p->pack_name);
+	p->pack_fd = git_open_noatime_cloexec(p->pack_name);
 	if (p->pack_fd < 0 || fstat(p->pack_fd, &st))
 		return -1;
 	pack_open_fds++;
@@ -1026,16 +1025,6 @@ static int open_packed_git_1(struct packed_git *p)
 	} else if (p->pack_size != st.st_size)
 		return error("packfile %s size changed", p->pack_name);
 
-	/* We leave these file descriptors open with sliding mmap;
-	 * there is no point keeping them open across exec(), though.
-	 */
-	fd_flag = fcntl(p->pack_fd, F_GETFD, 0);
-	if (fd_flag < 0)
-		return error("cannot determine file descriptor flags");
-	fd_flag |= FD_CLOEXEC;
-	if (fcntl(p->pack_fd, F_SETFD, fd_flag) == -1)
-		return error("cannot set FD_CLOEXEC");
-
 	/* Verify we recognize this pack file format. */
 	if (read_in_full(p->pack_fd, &hdr, sizeof(hdr)) != sizeof(hdr))
 		return error("file %s is far too short to be a packfile", p->pack_name);
@@ -1515,17 +1504,21 @@ int check_sha1_signature(const unsigned char *sha1, void *map,
 	return hashcmp(sha1, real_sha1) ? -1 : 0;
 }
 
-int git_open_noatime(const char *name)
+int git_open_noatime_cloexec(const char *name)
 {
+#ifdef __WIN32__
+	static int sha1_file_open_flag = O_NOATIME | O_NOINHERIT;
+#else
 	static int sha1_file_open_flag = O_NOATIME;
+	long fd_flag;
+#endif
+	int fd;
 
 	for (;;) {
-		int fd;
-
 		errno = 0;
 		fd = open(name, O_RDONLY | sha1_file_open_flag);
 		if (fd >= 0)
-			return fd;
+			break;
 
 		/* Might the failure be due to O_NOATIME? */
 		if (errno != ENOENT && sha1_file_open_flag) {
@@ -1535,6 +1528,21 @@ int git_open_noatime(const char *name)
 
 		return -1;
 	}
+
+#ifndef __WIN32__
+	fd_flag = fcntl(fd, F_GETFD, 0);
+	if (fd_flag < 0) {
+		close(fd);
+		return error("cannot determine file descriptor flags");
+	}
+	fd_flag |= FD_CLOEXEC;
+	if (fcntl(fd, F_SETFD, fd_flag) == -1) {
+		close(fd);
+		return error("cannot set FD_CLOEXEC");
+	}
+#endif
+
+	return fd;
 }
 
 static int stat_sha1_file(const unsigned char *sha1, struct stat *st)
@@ -1561,7 +1569,7 @@ static int open_sha1_file(const unsigned char *sha1)
 	struct alternate_object_database *alt;
 	int most_interesting_errno;
 
-	fd = git_open_noatime(sha1_file_name(sha1));
+	fd = git_open_noatime_cloexec(sha1_file_name(sha1));
 	if (fd >= 0)
 		return fd;
 	most_interesting_errno = errno;
@@ -1569,7 +1577,7 @@ static int open_sha1_file(const unsigned char *sha1)
 	prepare_alt_odb();
 	for (alt = alt_odb_list; alt; alt = alt->next) {
 		fill_sha1_path(alt->name, sha1);
-		fd = git_open_noatime(alt->base);
+		fd = git_open_noatime_cloexec(alt->base);
 		if (fd >= 0)
 			return fd;
 		if (most_interesting_errno == ENOENT)
-- 
2.3.4.2801.g3d0809b
