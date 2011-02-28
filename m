From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH] Limit file descriptors used by packs
Date: Mon, 28 Feb 2011 12:27:15 -0800
Message-ID: <1298924835-23413-1-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 28 21:27:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pu9gi-00046p-CQ
	for gcvg-git-2@lo.gmane.org; Mon, 28 Feb 2011 21:27:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754834Ab1B1U1T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Feb 2011 15:27:19 -0500
Received: from mail-pv0-f174.google.com ([74.125.83.174]:54807 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754124Ab1B1U1S (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Feb 2011 15:27:18 -0500
Received: by pvg12 with SMTP id 12so685583pvg.19
        for <git@vger.kernel.org>; Mon, 28 Feb 2011 12:27:17 -0800 (PST)
Received: by 10.142.195.12 with SMTP id s12mr3580051wff.6.1298924837760;
        Mon, 28 Feb 2011 12:27:17 -0800 (PST)
Received: from localhost (sop.mtv.corp.google.com [172.18.74.69])
        by mx.google.com with ESMTPS id z8sm6441609wfj.1.2011.02.28.12.27.16
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 28 Feb 2011 12:27:17 -0800 (PST)
X-Mailer: git-send-email 1.7.4.1.249.g4aa7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168137>

Rather than using 'errno == EMFILE' after a failed open() call
to indicate the process is out of file descriptors and an LRU
pack window should be closed, place a hard upper limit on the
number of open packs based on the actual rlimit of the process.

By using a hard upper limit that is below the rlimit of the current
process, it is not necessary to check for EMFILE on every single
fd-allocating system call.  Instead reserving 8 file descriptors
makes it safe to assume the system call won't fail due to being
over limit in the filedescriptor limit.

This fixes a case where running `git gc --auto` in a repository
with more than 1024 packs (but an rlimit of 1024 open fds) fails
due to the temporary output file not being able to allocate a
file descriptor.  The output file is opened by pack-objects after
object enumeration and delete compression are done, both of which
have already opened all of the packs and fully populated the file
descriptor table.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 sha1_file.c |   49 ++++++++++++++++++++++++++++++++++++-------------
 1 files changed, 36 insertions(+), 13 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index d949b35..8863ff6 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -418,6 +418,8 @@ static unsigned int pack_used_ctr;
 static unsigned int pack_mmap_calls;
 static unsigned int peak_pack_open_windows;
 static unsigned int pack_open_windows;
+static unsigned int pack_open_fds;
+static unsigned int pack_max_fds;
 static size_t peak_pack_mapped;
 static size_t pack_mapped;
 struct packed_git *packed_git;
@@ -597,6 +599,7 @@ static int unuse_one_window(struct packed_git *current, int keep_fd)
 			lru_p->windows = lru_w->next;
 			if (!lru_p->windows && lru_p->pack_fd != keep_fd) {
 				close(lru_p->pack_fd);
+				pack_open_fds--;
 				lru_p->pack_fd = -1;
 			}
 		}
@@ -681,8 +684,10 @@ void free_pack_by_name(const char *pack_name)
 		if (strcmp(pack_name, p->pack_name) == 0) {
 			clear_delta_base_cache();
 			close_pack_windows(p);
-			if (p->pack_fd != -1)
+			if (p->pack_fd != -1) {
 				close(p->pack_fd);
+				pack_open_fds--;
+			}
 			close_pack_index(p);
 			free(p->bad_object_sha1);
 			*pp = p->next;
@@ -708,9 +713,35 @@ static int open_packed_git_1(struct packed_git *p)
 	if (!p->index_data && open_pack_index(p))
 		return error("packfile %s index unavailable", p->pack_name);
 
+	if (!pack_max_fds) {
+		struct rlimit lim;
+		unsigned int max_fds;
+
+		if (getrlimit(RLIMIT_NOFILE, &lim))
+			die_errno("cannot get RLIMIT_NOFILE");
+
+		max_fds = lim.rlim_cur;
+
+		if (lim.rlim_cur < lim.rlim_max) {
+			lim.rlim_cur = lim.rlim_max;
+			if (!setrlimit(RLIMIT_NOFILE, &lim))
+				max_fds = lim.rlim_max;
+		}
+
+		/* Save 3 for stdin/stdout/stderr, 5 for work */
+		if (8 < max_fds)
+			pack_max_fds = max_fds - 8;
+		else
+			pack_max_fds = 1;
+	}
+
+	while (pack_max_fds <= pack_open_fds && unuse_one_window(NULL, -1))
+	  /* nothing */;
+
 	p->pack_fd = git_open_noatime(p->pack_name, p);
 	if (p->pack_fd < 0 || fstat(p->pack_fd, &st))
 		return -1;
+	pack_open_fds++;
 
 	/* If we created the struct before we had the pack we lack size. */
 	if (!p->pack_size) {
@@ -762,6 +793,7 @@ static int open_packed_git(struct packed_git *p)
 		return 0;
 	if (p->pack_fd != -1) {
 		close(p->pack_fd);
+		pack_open_fds--;
 		p->pack_fd = -1;
 	}
 	return -1;
@@ -919,6 +951,9 @@ struct packed_git *parse_pack_index(unsigned char *sha1, const char *idx_path)
 
 void install_packed_git(struct packed_git *pack)
 {
+	if (pack->pack_fd != -1)
+		pack_open_fds++;
+
 	pack->next = packed_git;
 	packed_git = pack;
 }
@@ -936,8 +971,6 @@ static void prepare_packed_git_one(char *objdir, int local)
 	sprintf(path, "%s/pack", objdir);
 	len = strlen(path);
 	dir = opendir(path);
-	while (!dir && errno == EMFILE && unuse_one_window(NULL, -1))
-		dir = opendir(path);
 	if (!dir) {
 		if (errno != ENOENT)
 			error("unable to open object pack directory: %s: %s",
@@ -1093,14 +1126,6 @@ static int git_open_noatime(const char *name, struct packed_git *p)
 		if (fd >= 0)
 			return fd;
 
-		/* Might the failure be insufficient file descriptors? */
-		if (errno == EMFILE) {
-			if (unuse_one_window(p, -1))
-				continue;
-			else
-				return -1;
-		}
-
 		/* Might the failure be due to O_NOATIME? */
 		if (errno != ENOENT && sha1_file_open_flag) {
 			sha1_file_open_flag = 0;
@@ -2360,8 +2385,6 @@ static int write_loose_object(const unsigned char *sha1, char *hdr, int hdrlen,
 
 	filename = sha1_file_name(sha1);
 	fd = create_tmpfile(tmpfile, sizeof(tmpfile), filename);
-	while (fd < 0 && errno == EMFILE && unuse_one_window(NULL, -1))
-		fd = create_tmpfile(tmpfile, sizeof(tmpfile), filename);
 	if (fd < 0) {
 		if (errno == EACCES)
 			return error("insufficient permission for adding an object to repository database %s\n", get_object_directory());
-- 
1.7.4.1.249.g4aa7
