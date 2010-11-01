From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH 2/2] Work around EMFILE when there are too many pack files
Date: Mon,  1 Nov 2010 15:54:21 -0700
Message-ID: <1288652061-19614-3-git-send-email-spearce@spearce.org>
References: <1288652061-19614-1-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 01 23:54:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PD3Gv-0005GX-Eg
	for gcvg-git-2@lo.gmane.org; Mon, 01 Nov 2010 23:54:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752432Ab0KAWyc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Nov 2010 18:54:32 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:65378 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751950Ab0KAWy3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Nov 2010 18:54:29 -0400
Received: by gyg4 with SMTP id 4so3605356gyg.19
        for <git@vger.kernel.org>; Mon, 01 Nov 2010 15:54:28 -0700 (PDT)
Received: by 10.42.214.138 with SMTP id ha10mr5556764icb.401.1288652067769;
        Mon, 01 Nov 2010 15:54:27 -0700 (PDT)
Received: from localhost (yellowpostit.mtv.corp.google.com [172.18.74.25])
        by mx.google.com with ESMTPS id 34sm9000053ibi.14.2010.11.01.15.54.26
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 01 Nov 2010 15:54:27 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.2.191.g2d0e5
In-Reply-To: <1288652061-19614-1-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160501>

When opening any files in the object database, release unused pack
windows if the open(2) syscall fails due to EMFILE (too many open
files in this process).  This allows Git to degrade gracefully on
a repository with thousands of pack files, and a commit stored in
a loose object in the middle of the history.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 sha1_file.c |   43 +++++++++++++++++++++++++++----------------
 1 files changed, 27 insertions(+), 16 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index a6c1934..43d68e0 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -35,7 +35,7 @@ static size_t sz_fmt(size_t s) { return s; }
 
 const unsigned char null_sha1[20];
 
-static int git_open_noatime(const char *name);
+static int git_open_noatime(const char *name, struct packed_git *p);
 
 int safe_create_leading_directories(char *path)
 {
@@ -300,7 +300,7 @@ static void read_info_alternates(const char * relative_base, int depth)
 	int fd;
 
 	sprintf(path, "%s/%s", relative_base, alt_file_name);
-	fd = git_open_noatime(path);
+	fd = git_open_noatime(path, NULL);
 	if (fd < 0)
 		return;
 	if (fstat(fd, &st) || (st.st_size == 0)) {
@@ -413,7 +413,7 @@ static int check_packed_git_idx(const char *path,  struct packed_git *p)
 	struct pack_idx_header *hdr;
 	size_t idx_size;
 	uint32_t version, nr, i, *index;
-	int fd = git_open_noatime(path);
+	int fd = git_open_noatime(path, p);
 	struct stat st;
 
 	if (fd < 0)
@@ -657,9 +657,7 @@ static int open_packed_git_1(struct packed_git *p)
 	if (!p->index_data && open_pack_index(p))
 		return error("packfile %s index unavailable", p->pack_name);
 
-	p->pack_fd = git_open_noatime(p->pack_name);
-	while (p->pack_fd < 0 && errno == EMFILE && unuse_one_window(p, -1))
-		p->pack_fd = git_open_noatime(p->pack_name);
+	p->pack_fd = git_open_noatime(p->pack_name, p);
 	if (p->pack_fd < 0 || fstat(p->pack_fd, &st))
 		return -1;
 
@@ -876,7 +874,7 @@ static void prepare_packed_git_one(char *objdir, int local)
 	sprintf(path, "%s/pack", objdir);
 	len = strlen(path);
 	dir = opendir(path);
-	while (!dir && errno == EMFILE && unuse_one_window(packed_git, -1))
+	while (!dir && errno == EMFILE && unuse_one_window(NULL, -1))
 		dir = opendir(path);
 	if (!dir) {
 		if (errno != ENOENT)
@@ -1024,18 +1022,31 @@ int check_sha1_signature(const unsigned char *sha1, void *map, unsigned long siz
 	return hashcmp(sha1, real_sha1) ? -1 : 0;
 }
 
-static int git_open_noatime(const char *name)
+static int git_open_noatime(const char *name, struct packed_git *p)
 {
 	static int sha1_file_open_flag = O_NOATIME;
-	int fd = open(name, O_RDONLY | sha1_file_open_flag);
 
-	/* Might the failure be due to O_NOATIME? */
-	if (fd < 0 && errno != ENOENT && sha1_file_open_flag) {
-		fd = open(name, O_RDONLY);
+	for (;;) {
+		int fd = open(name, O_RDONLY | sha1_file_open_flag);
 		if (fd >= 0)
+			return fd;
+
+		/* Might the failure be insufficient file descriptors? */
+		if (errno == EMFILE) {
+			if (unuse_one_window(p, -1))
+				continue;
+			else
+				return -1;
+		}
+
+		/* Might the failure be due to O_NOATIME? */
+		if (errno != ENOENT && sha1_file_open_flag) {
 			sha1_file_open_flag = 0;
+			continue;
+		}
+
+		return -1;
 	}
-	return fd;
 }
 
 static int open_sha1_file(const unsigned char *sha1)
@@ -1044,7 +1055,7 @@ static int open_sha1_file(const unsigned char *sha1)
 	char *name = sha1_file_name(sha1);
 	struct alternate_object_database *alt;
 
-	fd = git_open_noatime(name);
+	fd = git_open_noatime(name, NULL);
 	if (fd >= 0)
 		return fd;
 
@@ -1053,7 +1064,7 @@ static int open_sha1_file(const unsigned char *sha1)
 	for (alt = alt_odb_list; alt; alt = alt->next) {
 		name = alt->name;
 		fill_sha1_path(name, sha1);
-		fd = git_open_noatime(alt->base);
+		fd = git_open_noatime(alt->base, NULL);
 		if (fd >= 0)
 			return fd;
 	}
@@ -2314,7 +2325,7 @@ static int write_loose_object(const unsigned char *sha1, char *hdr, int hdrlen,
 
 	filename = sha1_file_name(sha1);
 	fd = create_tmpfile(tmpfile, sizeof(tmpfile), filename);
-	while (fd < 0 && errno == EMFILE && unuse_one_window(packed_git, -1))
+	while (fd < 0 && errno == EMFILE && unuse_one_window(NULL, -1))
 		fd = create_tmpfile(tmpfile, sizeof(tmpfile), filename);
 	if (fd < 0) {
 		if (errno == EACCES)
-- 
1.7.3.2.191.g2d0e5
