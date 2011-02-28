From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH v2] Limit file descriptors used by packs
Date: Mon, 28 Feb 2011 12:52:39 -0800
Message-ID: <1298926359-26438-1-git-send-email-spearce@spearce.org>
References: <20110228204727.GB26052@spearce.org>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 28 21:53:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PuA5e-00033w-2e
	for gcvg-git-2@lo.gmane.org; Mon, 28 Feb 2011 21:53:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755258Ab1B1Uwn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Feb 2011 15:52:43 -0500
Received: from mail-pv0-f174.google.com ([74.125.83.174]:55871 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753420Ab1B1Uwm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Feb 2011 15:52:42 -0500
Received: by pvg12 with SMTP id 12so689205pvg.19
        for <git@vger.kernel.org>; Mon, 28 Feb 2011 12:52:41 -0800 (PST)
Received: by 10.142.151.4 with SMTP id y4mr4389713wfd.331.1298926361613;
        Mon, 28 Feb 2011 12:52:41 -0800 (PST)
Received: from localhost (sop.mtv.corp.google.com [172.18.74.69])
        by mx.google.com with ESMTPS id w27sm6460555wfd.4.2011.02.28.12.52.40
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 28 Feb 2011 12:52:40 -0800 (PST)
X-Mailer: git-send-email 1.7.4.1.249.g4aa7
In-Reply-To: <20110228204727.GB26052@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168142>

Rather than using 'errno == EMFILE' after a failed open() call
to indicate the process is out of file descriptors and an LRU
pack window should be closed, place a hard upper limit on the
number of open packs based on the actual rlimit of the process.

By using a hard upper limit that is below the rlimit of the current
process it is not necessary to check for EMFILE on every single
fd-allocating system call.  Instead reserving 25 file descriptors
makes it safe to assume the system call won't fail due to being over
the filedescriptor limit.  Here 25 is chosen as a WAG, but considers
3 for stdin/stdout/stderr, and at least a few for other Git code
to operate on temporary files.  An additional 20 is reserved as it
is not known what the C library needs to perform other services on
Git's behalf, such as nsswitch or name resolution.

This fixes a case where running `git gc --auto` in a repository
with more than 1024 packs (but an rlimit of 1024 open fds) fails
due to the temporary output file not being able to allocate a
file descriptor.  The output file is opened by pack-objects after
object enumeration and delta compression are done, both of which
have already opened all of the packs and fully populated the file
descriptor table.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 sha1_file.c |   43 ++++++++++++++++++++++++++++++-------------
 1 files changed, 30 insertions(+), 13 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index d949b35..7850c18 100644
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
@@ -708,9 +713,29 @@ static int open_packed_git_1(struct packed_git *p)
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
+		/* Save 3 for stdin/stdout/stderr, 22 for work */
+		if (25 < max_fds)
+			pack_max_fds = max_fds - 25;
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
@@ -762,6 +787,7 @@ static int open_packed_git(struct packed_git *p)
 		return 0;
 	if (p->pack_fd != -1) {
 		close(p->pack_fd);
+		pack_open_fds--;
 		p->pack_fd = -1;
 	}
 	return -1;
@@ -919,6 +945,9 @@ struct packed_git *parse_pack_index(unsigned char *sha1, const char *idx_path)
 
 void install_packed_git(struct packed_git *pack)
 {
+	if (pack->pack_fd != -1)
+		pack_open_fds++;
+
 	pack->next = packed_git;
 	packed_git = pack;
 }
@@ -936,8 +965,6 @@ static void prepare_packed_git_one(char *objdir, int local)
 	sprintf(path, "%s/pack", objdir);
 	len = strlen(path);
 	dir = opendir(path);
-	while (!dir && errno == EMFILE && unuse_one_window(NULL, -1))
-		dir = opendir(path);
 	if (!dir) {
 		if (errno != ENOENT)
 			error("unable to open object pack directory: %s: %s",
@@ -1093,14 +1120,6 @@ static int git_open_noatime(const char *name, struct packed_git *p)
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
@@ -2360,8 +2379,6 @@ static int write_loose_object(const unsigned char *sha1, char *hdr, int hdrlen,
 
 	filename = sha1_file_name(sha1);
 	fd = create_tmpfile(tmpfile, sizeof(tmpfile), filename);
-	while (fd < 0 && errno == EMFILE && unuse_one_window(NULL, -1))
-		fd = create_tmpfile(tmpfile, sizeof(tmpfile), filename);
 	if (fd < 0) {
 		if (errno == EACCES)
 			return error("insufficient permission for adding an object to repository database %s\n", get_object_directory());
-- 
1.7.4.1.249.g4aa7
