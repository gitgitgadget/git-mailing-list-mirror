From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH 1/2] Use git_open_noatime when accessing pack data
Date: Mon,  1 Nov 2010 15:54:20 -0700
Message-ID: <1288652061-19614-2-git-send-email-spearce@spearce.org>
References: <1288652061-19614-1-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 01 23:54:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PD3Gu-0005GX-CY
	for gcvg-git-2@lo.gmane.org; Mon, 01 Nov 2010 23:54:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752286Ab0KAWy3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Nov 2010 18:54:29 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:64082 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751183Ab0KAWy0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Nov 2010 18:54:26 -0400
Received: by pwj3 with SMTP id 3so1408225pwj.19
        for <git@vger.kernel.org>; Mon, 01 Nov 2010 15:54:26 -0700 (PDT)
Received: by 10.142.245.11 with SMTP id s11mr5149689wfh.392.1288652065882;
        Mon, 01 Nov 2010 15:54:25 -0700 (PDT)
Received: from localhost (yellowpostit.mtv.corp.google.com [172.18.74.25])
        by mx.google.com with ESMTPS id w15sm6742891wfd.21.2010.11.01.15.54.24
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 01 Nov 2010 15:54:25 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.2.191.g2d0e5
In-Reply-To: <1288652061-19614-1-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160499>

This utility function avoids an unnecessary update of the access time
for a loose object file.  Just as the atime isn't useful on a loose
object, its not useful on the pack or the corresonding idx file.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 sha1_file.c |   10 ++++++----
 1 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index f709ed6..a6c1934 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -35,6 +35,8 @@ static size_t sz_fmt(size_t s) { return s; }
 
 const unsigned char null_sha1[20];
 
+static int git_open_noatime(const char *name);
+
 int safe_create_leading_directories(char *path)
 {
 	char *pos = path + offset_1st_component(path);
@@ -298,7 +300,7 @@ static void read_info_alternates(const char * relative_base, int depth)
 	int fd;
 
 	sprintf(path, "%s/%s", relative_base, alt_file_name);
-	fd = open(path, O_RDONLY);
+	fd = git_open_noatime(path);
 	if (fd < 0)
 		return;
 	if (fstat(fd, &st) || (st.st_size == 0)) {
@@ -411,7 +413,7 @@ static int check_packed_git_idx(const char *path,  struct packed_git *p)
 	struct pack_idx_header *hdr;
 	size_t idx_size;
 	uint32_t version, nr, i, *index;
-	int fd = open(path, O_RDONLY);
+	int fd = git_open_noatime(path);
 	struct stat st;
 
 	if (fd < 0)
@@ -655,9 +657,9 @@ static int open_packed_git_1(struct packed_git *p)
 	if (!p->index_data && open_pack_index(p))
 		return error("packfile %s index unavailable", p->pack_name);
 
-	p->pack_fd = open(p->pack_name, O_RDONLY);
+	p->pack_fd = git_open_noatime(p->pack_name);
 	while (p->pack_fd < 0 && errno == EMFILE && unuse_one_window(p, -1))
-		p->pack_fd = open(p->pack_name, O_RDONLY);
+		p->pack_fd = git_open_noatime(p->pack_name);
 	if (p->pack_fd < 0 || fstat(p->pack_fd, &st))
 		return -1;
 
-- 
1.7.3.2.191.g2d0e5
