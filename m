From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v3 2/4] Consolidate code to close a pack's file descriptor
Date: Tue, 06 Oct 2015 15:18:19 +0200
Organization: gmx
Message-ID: <93c67c6cb4a30e68e2bfdb759a1e29661231b186.1444131898.git.johannes.schindelin@gmx.de>
References: <682991036f1e8e974ed8ecd7d20dbcc6fb86c344.1443469464.git.johannes.schindelin@gmx.de>
 <cover.1444131898.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Max Kirillov <max@max630.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 06 15:18:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZjS8T-0004fj-Rc
	for gcvg-git-2@plane.gmane.org; Tue, 06 Oct 2015 15:18:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752101AbbJFNS0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Oct 2015 09:18:26 -0400
Received: from mout.gmx.net ([212.227.17.21]:56793 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751382AbbJFNSZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Oct 2015 09:18:25 -0400
Received: from dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0MUkxk-1a8jJo0azc-00YCji; Tue, 06 Oct 2015 15:18:20
 +0200
In-Reply-To: <cover.1444131898.git.johannes.schindelin@gmx.de>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.2
X-Provags-ID: V03:K0:EDJhOIldhzozm2Ex993Qb9wCLqLpnV/bnGtvsZBWT7GzZyX6KYB
 RE1/wVWGqjC8G+GB1j8N0J7Vi6UFyvqBrv+17A2zlyRr9qGhBK4ND9PaBtaHREqSKp24Gpd
 LIhk2tMe4GhscyYt2OPXC/Cx29LsJQZWygg46Bz3+REWtEP/r08T5DgEUIZmLN4Rzs3Rf7B
 XZTaKEUBdri/EmgnZ753g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:oxut6NVppaU=:Qsyt9fan+W7R1WCgDyx7hO
 eKC5e/4U8v7pLETFGl/D34Wp1O0YrOvEXDWTVjMupNCuRT/gTTAG/7p7VLjoBe+azZ2b9+Ir2
 WPeWbzU/25TORc7LUIwd6PhI0gCnGDdt/uQPh5wZlgFqFvHaBYgxojHSGkeTTe5PlxFkUVazi
 tKOcB0n4dbccthlFnPgV56yR6gssp4RlLNc6df88DwCbU+3Fv0tdRekeGWVTFACEDvvgAMAPM
 Q/uLRVSbvlwqxI7WLJV3q4kAXC8hL5OeKNpQNmQww42C3YWk4uRpkVAVjFDk0MnI3gjCNsGGz
 6LydDwePjkaIgUzicV+2CDNJzwioCkPEk5Y+fHNT1p7TTb7NksLdRrZPRTcaJc0owAPHe26ly
 hik4q1nK4Km8n72XYDYMBlFA3cNp0gEmGC/ts09gw0iEobJnJnuaeYQYOSsY6n7FFGiQozoCD
 9Y7heJyhMGV8MX8wolADhyPa57YxLdLYS6Vby5oZDtyYTL8H2WQEitd/aTOwfwyC1uSbBtSEu
 NpCNIeP/V6q7VcKOLGqZxysjL6nZcwZ+XoxmD3fFyiYOSMQrzuVNZUVZBPE5AC4GF1eqHymiL
 8D9ClaveZIRuHRbEGMMuXnPDLYSy5dA8XO1vII08GheuBXZy9zk8cEIHn4bKZu+dVz5MJX/QB
 8TkXjiZVntfbEE64eVhk9bGemqaKiCJRT6PUxVczdQRiKQx9glQdKli25BJ7a/KTPjja0rWMe
 wqBQSkkZIrflS1yTLDi9UGiphg8UkRT8mkFpGKf3HNf/D9Fk+WJNVvXiPyLCDHc0+t7iJtIM 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279137>

There was a lot of repeated code to close the file descriptor of
a given pack. Let's just refactor this code into a single function.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 sha1_file.c | 38 ++++++++++++++++++--------------------
 1 file changed, 18 insertions(+), 20 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index d295a32..8c3c913 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -786,6 +786,18 @@ void close_pack_windows(struct packed_git *p)
 	}
 }
 
+static int close_pack_fd(struct packed_git *p)
+{
+	if (p->pack_fd < 0)
+		return 0;
+
+	close(p->pack_fd);
+	pack_open_fds--;
+	p->pack_fd = -1;
+
+	return 1;
+}
+
 /*
  * The LRU pack is the one with the oldest MRU window, preferring packs
  * with no used windows, or the oldest mtime if it has no windows allocated.
@@ -853,12 +865,8 @@ static int close_one_pack(void)
 		find_lru_pack(p, &lru_p, &mru_w, &accept_windows_inuse);
 	}
 
-	if (lru_p) {
-		close(lru_p->pack_fd);
-		pack_open_fds--;
-		lru_p->pack_fd = -1;
-		return 1;
-	}
+	if (lru_p)
+		return close_pack_fd(lru_p);
 
 	return 0;
 }
@@ -899,10 +907,7 @@ void free_pack_by_name(const char *pack_name)
 		if (strcmp(pack_name, p->pack_name) == 0) {
 			clear_delta_base_cache();
 			close_pack_windows(p);
-			if (p->pack_fd != -1) {
-				close(p->pack_fd);
-				pack_open_fds--;
-			}
+			close_pack_fd(p);
 			close_pack_index(p);
 			free(p->bad_object_sha1);
 			*pp = p->next;
@@ -1037,11 +1042,7 @@ static int open_packed_git(struct packed_git *p)
 {
 	if (!open_packed_git_1(p))
 		return 0;
-	if (p->pack_fd != -1) {
-		close(p->pack_fd);
-		pack_open_fds--;
-		p->pack_fd = -1;
-	}
+	close_pack_fd(p);
 	return -1;
 }
 
@@ -1107,11 +1108,8 @@ unsigned char *use_pack(struct packed_git *p,
 					p->pack_name,
 					strerror(errno));
 			if (!win->offset && win->len == p->pack_size
-				&& !p->do_not_close) {
-				close(p->pack_fd);
-				pack_open_fds--;
-				p->pack_fd = -1;
-			}
+				&& !p->do_not_close)
+				close_pack_fd(p);
 			pack_mmap_calls++;
 			pack_open_windows++;
 			if (pack_mapped > peak_pack_mapped)
-- 
2.6.1.windows.1
