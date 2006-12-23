From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH 10/17] Unmap individual windows rather than entire files.
Date: Sat, 23 Dec 2006 02:34:23 -0500
Message-ID: <20061223073423.GK9837@spearce.org>
References: <53b67707929c7f051f6d384c5d96e653bfa8419c.1166857884.git.spearce@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 23 08:34:32 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1Gy1Op-0001so-4j
	for gcvg-git@gmane.org; Sat, 23 Dec 2006 08:34:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752724AbWLWHe1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Dec 2006 02:34:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752753AbWLWHe1
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Dec 2006 02:34:27 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:38795 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752724AbWLWHe0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Dec 2006 02:34:26 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1Gy1OK-0003AI-Dx; Sat, 23 Dec 2006 02:34:00 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 1A90A20FB65; Sat, 23 Dec 2006 02:34:23 -0500 (EST)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35288>

To support multiple windows per packfile we need to unmap only one
window at a time from that packfile, leaving any other windows in
place and available for reference.

We treat all windows from all packfiles equally; the least recently
used, not-in-use window across all packfiles will always be closed
first.

If we have unmapped all windows in a packfile then we can also close
the packfile's file descriptor as its possible we won't need to map
any window from that file in the near future.  This decision about
when to close the pack file descriptor may need to be revisited in
the future after additional testing on several different platforms
can be performed.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 sha1_file.c |   45 ++++++++++++++++++++++++++++++---------------
 1 files changed, 30 insertions(+), 15 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index 6c34482..49dd4b7 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -450,24 +450,39 @@ static int check_packed_git_idx(const char *path, unsigned long *idx_size_,
 	return 0;
 }
 
-static int unuse_one_packed_git(void)
+static int unuse_one_window(void)
 {
-	struct packed_git *p, *lru = NULL;
+	struct packed_git *p, *lru_p = NULL;
+	struct pack_window *w, *w_l, *lru_w = NULL, *lru_l = NULL;
 
 	for (p = packed_git; p; p = p->next) {
-		if (!p->windows || p->windows->inuse_cnt)
-			continue;
-		if (!lru || p->windows->last_used < lru->windows->last_used)
-			lru = p;
+		for (w_l = NULL, w = p->windows; w; w = w->next) {
+			if (!w->inuse_cnt) {
+				if (!lru_w || w->last_used < lru_w->last_used) {
+					lru_p = p;
+					lru_w = w;
+					lru_l = w_l;
+				}
+			}
+			w_l = w;
+		}
 	}
-	if (!lru)
-		return 0;
-	munmap(lru->windows->base, lru->windows->len);
-	free(lru->windows);
-	lru->windows = NULL;
-	close(p->pack_fd);
-	p->pack_fd = -1;
-	return 1;
+	if (lru_p) {
+		munmap(lru_w->base, lru_w->len);
+		pack_mapped -= lru_w->len;
+		if (lru_l)
+			lru_l->next = lru_w->next;
+		else {
+			lru_p->windows = lru_w->next;
+			if (!lru_p->windows) {
+				close(lru_p->pack_fd);
+				lru_p->pack_fd = -1;
+			}
+		}
+		free(lru_w);
+		return 1;
+	}
+	return 0;
 }
 
 void unuse_pack(struct pack_window **w_cursor)
@@ -532,7 +547,7 @@ unsigned char* use_pack(struct packed_git *p,
 		open_packed_git(p);
 	if (!win) {
 		pack_mapped += p->pack_size;
-		while (packed_git_limit < pack_mapped && unuse_one_packed_git())
+		while (packed_git_limit < pack_mapped && unuse_one_window())
 			; /* nothing */
 		win = xcalloc(1, sizeof(*win));
 		win->len = p->pack_size;
-- 
1.4.4.3.g87d8
