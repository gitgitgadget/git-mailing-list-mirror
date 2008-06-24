From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH] factorize pack structure allocation
Date: Tue, 24 Jun 2008 18:58:06 -0400 (EDT)
Message-ID: <alpine.LFD.1.10.0806241851420.2979@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Teemu Likonen <tlikonen@iki.fi>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 25 00:59:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBHTe-00024u-9f
	for gcvg-git-2@gmane.org; Wed, 25 Jun 2008 00:59:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755003AbYFXW6J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jun 2008 18:58:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755011AbYFXW6I
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jun 2008 18:58:08 -0400
Received: from relais.videotron.ca ([24.201.245.36]:46495 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754961AbYFXW6H (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jun 2008 18:58:07 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0K2Z00C5YP4UJKG0@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 24 Jun 2008 18:58:06 -0400 (EDT)
X-X-Sender: nico@xanadu.home
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86174>

New pack structures are currently allocated in 2 different places
and all members have to be initialized explicitly.  This is prone
to errors leading to segmentation faults as found by Teemu Likonen.

Let's have a common place where this structure is allocated, and have 
all members implicitly initialized to zero.

Signed-off-by: Nicolas Pitre <nico@cam.org>
---
diff --git a/sha1_file.c b/sha1_file.c
index a92f023..c56f674 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -792,18 +792,28 @@ unsigned char* use_pack(struct packed_git *p,
 	return win->base + offset;
 }
 
+static struct packed_git *alloc_packed_git(int extra)
+{
+	struct packed_git *p = xmalloc(sizeof(*p) + extra);
+	memset(p, 0, sizeof(*p));
+	p->pack_fd = -1;
+	return p;
+}
+
 struct packed_git *add_packed_git(const char *path, int path_len, int local)
 {
 	struct stat st;
-	struct packed_git *p = xmalloc(sizeof(*p) + path_len + 2);
+	struct packed_git *p = alloc_packed_git(path_len + 2);
 
 	/*
 	 * Make sure a corresponding .pack file exists and that
 	 * the index looks sane.
 	 */
 	path_len -= strlen(".idx");
-	if (path_len < 1)
+	if (path_len < 1) {
+		free(p);
 		return NULL;
+	}
 	memcpy(p->pack_name, path, path_len);
 	strcpy(p->pack_name + path_len, ".pack");
 	if (stat(p->pack_name, &st) || !S_ISREG(st.st_mode)) {
@@ -814,16 +824,7 @@ struct packed_git *add_packed_git(const char *path, int path_len, int local)
 	/* ok, it looks sane as far as we can check without
 	 * actually mapping the pack file.
 	 */
-	p->index_version = 0;
-	p->index_data = NULL;
-	p->index_size = 0;
-	p->num_objects = 0;
-	p->num_bad_objects = 0;
-	p->bad_object_sha1 = NULL;
 	p->pack_size = st.st_size;
-	p->next = NULL;
-	p->windows = NULL;
-	p->pack_fd = -1;
 	p->pack_local = local;
 	p->mtime = st.st_mtime;
 	if (path_len < 40 || get_sha1_hex(path + path_len - 40, p->sha1))
@@ -835,19 +836,15 @@ struct packed_git *parse_pack_index(unsigned char *sha1)
 {
 	const char *idx_path = sha1_pack_index_name(sha1);
 	const char *path = sha1_pack_name(sha1);
-	struct packed_git *p = xmalloc(sizeof(*p) + strlen(path) + 2);
+	struct packed_git *p = alloc_packed_git(strlen(path) + 1);
 
+	strcpy(p->pack_name, path);
+	hashcpy(p->sha1, sha1);
 	if (check_packed_git_idx(idx_path, p)) {
 		free(p);
 		return NULL;
 	}
 
-	strcpy(p->pack_name, path);
-	p->pack_size = 0;
-	p->next = NULL;
-	p->windows = NULL;
-	p->pack_fd = -1;
-	hashcpy(p->sha1, sha1);
 	return p;
 }
 
