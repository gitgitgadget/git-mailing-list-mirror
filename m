From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH 15/17] Support unmapping windows on 'temporary' packfiles.
Date: Sat, 23 Dec 2006 02:34:44 -0500
Message-ID: <20061223073444.GP9837@spearce.org>
References: <53b67707929c7f051f6d384c5d96e653bfa8419c.1166857884.git.spearce@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 23 08:34:55 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1Gy1PC-0001vX-I5
	for gcvg-git@gmane.org; Sat, 23 Dec 2006 08:34:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752878AbWLWHet (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Dec 2006 02:34:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752881AbWLWHet
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Dec 2006 02:34:49 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:38826 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752878AbWLWHes (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Dec 2006 02:34:48 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1Gy1Of-0003Dr-RT; Sat, 23 Dec 2006 02:34:21 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 8381820FB65; Sat, 23 Dec 2006 02:34:44 -0500 (EST)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35295>

If a command opens a packfile for only temporary access and does not
install the struct packed_git* into the global packed_git list then
we are unable to unmap any inactive windows within that packed_git,
causing the overall process to exceed core.packedGitLimit.

We cannot force the callers to install their temporary packfile
into the packed_git chain as doing so would allow that (possibly
corrupt but currently being verified) temporary packfile to become
part of the local ODB, which may allow it to be considered for
object resolution when it may not actually be a valid packfile.

So to support unmapping the windows of these temporary packfiles we
also scan the windows of the struct packed_git which was supplied
to use_pack().  Since commands only work with one temporary packfile
at a time scanning the one supplied to use_pack() and all packs
installed into packed_git should cover everything available in
memory.

We also have to be careful to not close the file descriptor of
the packed_git which was handed to use_pack() when all of that
packfile's windows have been unmapped, as we are already past the
open call that would open the packfile and need the file descriptor
to be ready for mmap() after unuse_one_window returns.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 sha1_file.c |   44 ++++++++++++++++++++++++++++----------------
 1 files changed, 28 insertions(+), 16 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index 7872c2d..a8a6c10 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -451,23 +451,34 @@ static int check_packed_git_idx(const char *path, unsigned long *idx_size_,
 	return 0;
 }
 
-static int unuse_one_window(void)
-{
-	struct packed_git *p, *lru_p = NULL;
-	struct pack_window *w, *w_l, *lru_w = NULL, *lru_l = NULL;
-
-	for (p = packed_git; p; p = p->next) {
-		for (w_l = NULL, w = p->windows; w; w = w->next) {
-			if (!w->inuse_cnt) {
-				if (!lru_w || w->last_used < lru_w->last_used) {
-					lru_p = p;
-					lru_w = w;
-					lru_l = w_l;
-				}
+static void scan_windows(struct packed_git *p,
+	struct packed_git **lru_p,
+	struct pack_window **lru_w,
+	struct pack_window **lru_l)
+{
+	struct pack_window *w, *w_l;
+
+	for (w_l = NULL, w = p->windows; w; w = w->next) {
+		if (!w->inuse_cnt) {
+			if (!*lru_w || w->last_used < (*lru_w)->last_used) {
+				*lru_p = p;
+				*lru_w = w;
+				*lru_l = w_l;
 			}
-			w_l = w;
 		}
+		w_l = w;
 	}
+}
+
+static int unuse_one_window(struct packed_git *current)
+{
+	struct packed_git *p, *lru_p = NULL;
+	struct pack_window *lru_w = NULL, *lru_l = NULL;
+
+	if (current)
+		scan_windows(current, &lru_p, &lru_w, &lru_l);
+	for (p = packed_git; p; p = p->next)
+		scan_windows(p, &lru_p, &lru_w, &lru_l);
 	if (lru_p) {
 		munmap(lru_w->base, lru_w->len);
 		pack_mapped -= lru_w->len;
@@ -475,7 +486,7 @@ static int unuse_one_window(void)
 			lru_l->next = lru_w->next;
 		else {
 			lru_p->windows = lru_w->next;
-			if (!lru_p->windows) {
+			if (!lru_p->windows && lru_p != current) {
 				close(lru_p->pack_fd);
 				lru_p->pack_fd = -1;
 			}
@@ -584,7 +595,8 @@ unsigned char* use_pack(struct packed_git *p,
 			if (win->len > packed_git_window_size)
 				win->len = packed_git_window_size;
 			pack_mapped += win->len;
-			while (packed_git_limit < pack_mapped && unuse_one_window())
+			while (packed_git_limit < pack_mapped
+				&& unuse_one_window(p))
 				; /* nothing */
 			win->base = mmap(NULL, win->len,
 				PROT_READ, MAP_PRIVATE,
-- 
1.4.4.3.g87d8
