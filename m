From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH 6/17] Refactor how we open pack files to prepare for multiple windows.
Date: Sat, 23 Dec 2006 02:34:01 -0500
Message-ID: <20061223073401.GG9837@spearce.org>
References: <53b67707929c7f051f6d384c5d96e653bfa8419c.1166857884.git.spearce@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 23 08:34:21 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1Gy1OV-0001qM-7e
	for gcvg-git@gmane.org; Sat, 23 Dec 2006 08:34:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752647AbWLWHeI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Dec 2006 02:34:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752674AbWLWHeH
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Dec 2006 02:34:07 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:38770 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752647AbWLWHeG (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Dec 2006 02:34:06 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1Gy1Ny-00037r-SD; Sat, 23 Dec 2006 02:33:39 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 8A36720FB65; Sat, 23 Dec 2006 02:34:01 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <53b67707929c7f051f6d384c5d96e653bfa8419c.1166857884.git.spearce@spearce.org>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35287>

To efficiently support mmaping of multiple regions of the same pack
file we want to keep the pack's file descriptor open while we are
actively working with that pack.  So we are now keeping that file
descriptor in packed_git.pack_fd and closing it only after we unmap
the last window.

This is going to increase the number of file descriptors that are
in use at once, however that will be bounded by the total number of
pack files present and therefore should not be very high.  It is
a small tradeoff which we may need to revisit after some testing
can be done on various repositories and systems.

For code clarity we also want to seperate out the implementation
of how we open a pack file from the implementation which locates
a suitable window (or makes a new one) from the given pack file.
Since this is a rather large delta I'm taking advantage of doing
it now, in a fairly isolated change.

When we open a pack file we need to examine the header and trailer
without having a mmap in place, as we may only need to mmap
the middle section of this particular pack.  Consequently the
verification code has been refactored to make use of the new
read_or_die function.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 cache.h     |    1 +
 sha1_file.c |   86 +++++++++++++++++++++++++++++++---------------------------
 2 files changed, 47 insertions(+), 40 deletions(-)

diff --git a/cache.h b/cache.h
index 77f2338..0afc55e 100644
--- a/cache.h
+++ b/cache.h
@@ -351,6 +351,7 @@ extern struct packed_git {
 	unsigned int *index_base;
 	off_t index_size;
 	off_t pack_size;
+	int pack_fd;
 	int pack_local;
 	unsigned char sha1[20];
 	/* something like ".git/objects/pack/xxxxx.pack" */
diff --git a/sha1_file.c b/sha1_file.c
index 8377874..cc68a8b 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -465,6 +465,8 @@ static int unuse_one_packed_git(void)
 	munmap(lru->windows->base, lru->windows->len);
 	free(lru->windows);
 	lru->windows = NULL;
+	close(p->pack_fd);
+	p->pack_fd = -1;
 	return 1;
 }
 
@@ -474,62 +476,64 @@ void unuse_packed_git(struct packed_git *p)
 		p->windows->inuse_cnt--;
 }
 
-int use_packed_git(struct packed_git *p)
+static void open_packed_git(struct packed_git *p)
 {
+	struct stat st;
+	struct pack_header hdr;
+	unsigned char sha1[20];
+	unsigned char *idx_sha1;
+
+	p->pack_fd = open(p->pack_name, O_RDONLY);
+	if (p->pack_fd < 0 || fstat(p->pack_fd, &st))
+		die("packfile %s cannot be opened", p->pack_name);
+
+	/* If we created the struct before we had the pack we lack size. */
 	if (!p->pack_size) {
-		struct stat st;
-		/* We created the struct before we had the pack */
-		stat(p->pack_name, &st);
 		if (!S_ISREG(st.st_mode))
 			die("packfile %s not a regular file", p->pack_name);
 		p->pack_size = st.st_size;
-	}
+	} else if (p->pack_size != st.st_size)
+		die("packfile %s size changed", p->pack_name);
+
+	/* Verify we recognize this pack file format. */
+	read_or_die(p->pack_fd, &hdr, sizeof(hdr));
+	if (hdr.hdr_signature != htonl(PACK_SIGNATURE))
+		die("file %s is not a GIT packfile", p->pack_name);
+	if (!pack_version_ok(hdr.hdr_version))
+		die("packfile %s is version %u and not supported"
+			" (try upgrading GIT to a newer version)",
+			p->pack_name, ntohl(hdr.hdr_version));
+
+	/* Verify the pack matches its index. */
+	if (num_packed_objects(p) != ntohl(hdr.hdr_entries))
+		die("packfile %s claims to have %u objects"
+			" while index size indicates %u objects",
+			p->pack_name, ntohl(hdr.hdr_entries),
+			num_packed_objects(p));
+	if (lseek(p->pack_fd, p->pack_size - sizeof(sha1), SEEK_SET) == -1)
+		die("end of packfile %s is unavailable", p->pack_name);
+	read_or_die(p->pack_fd, sha1, sizeof(sha1));
+	idx_sha1 = ((unsigned char *)p->index_base) + p->index_size - 40;
+	if (hashcmp(sha1, idx_sha1))
+		die("packfile %s does not match index", p->pack_name);
+}
+
+int use_packed_git(struct packed_git *p)
+{
+	if (p->pack_fd == -1)
+		open_packed_git(p);
 	if (!p->windows) {
-		int fd;
-		struct stat st;
 		struct pack_window *win;
-		struct pack_header *hdr;
 
 		pack_mapped += p->pack_size;
 		while (packed_git_limit < pack_mapped && unuse_one_packed_git())
 			; /* nothing */
-		fd = open(p->pack_name, O_RDONLY);
-		if (fd < 0)
-			die("packfile %s cannot be opened", p->pack_name);
-		if (fstat(fd, &st)) {
-			close(fd);
-			die("packfile %s cannot be opened", p->pack_name);
-		}
-		if (st.st_size != p->pack_size)
-			die("packfile %s size mismatch.", p->pack_name);
 		win = xcalloc(1, sizeof(*win));
 		win->len = p->pack_size;
-		win->base = mmap(NULL, p->pack_size, PROT_READ, MAP_PRIVATE, fd, 0);
-		close(fd);
+		win->base = mmap(NULL, p->pack_size, PROT_READ, MAP_PRIVATE, p->pack_fd, 0);
 		if (win->base == MAP_FAILED)
 			die("packfile %s cannot be mapped.", p->pack_name);
 		p->windows = win;
-
-		/* Check if we understand this pack file.  If we don't we're
-		 * likely too old to handle it.
-		 */
-		hdr = (struct pack_header*)win->base;
-		if (hdr->hdr_signature != htonl(PACK_SIGNATURE))
-			die("packfile %s isn't actually a pack.", p->pack_name);
-		if (!pack_version_ok(hdr->hdr_version))
-			die("packfile %s is version %i and not supported"
-				" (try upgrading GIT to a newer version)",
-				p->pack_name, ntohl(hdr->hdr_version));
-
-		/* Check if the pack file matches with the index file.
-		 * this is cheap.
-		 */
-		if (hashcmp((unsigned char *)(p->index_base) +
-			    p->index_size - 40,
-			    p->windows->base +
-			    p->pack_size - 20)) {
-			die("packfile %s does not match index.", p->pack_name);
-		}
 	}
 	p->windows->last_used = pack_used_ctr++;
 	p->windows->inuse_cnt++;
@@ -562,6 +566,7 @@ struct packed_git *add_packed_git(char *path, int path_len, int local)
 	p->pack_size = st.st_size;
 	p->index_base = idx_map;
 	p->windows = NULL;
+	p->pack_fd = -1;
 	p->pack_local = local;
 	if ((path_len > 44) && !get_sha1_hex(path + path_len - 44, sha1))
 		hashcpy(p->sha1, sha1);
@@ -592,6 +597,7 @@ struct packed_git *parse_pack_index_file(const unsigned char *sha1, char *idx_pa
 	p->pack_size = 0;
 	p->index_base = idx_map;
 	p->windows = NULL;
+	p->pack_fd = -1;
 	hashcpy(p->sha1, sha1);
 	return p;
 }
-- 
1.4.4.3.g87d8
