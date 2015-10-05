From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v2 2/4] Consolidate code to close a pack's file descriptor
Date: Mon, 05 Oct 2015 22:30:24 +0200
Organization: gmx
Message-ID: <a1f0d9339a9de95ba3f5eaaaf2e1a712629ad5d4.1444076827.git.johannes.schindelin@gmx.de>
References: <682991036f1e8e974ed8ecd7d20dbcc6fb86c344.1443469464.git.johannes.schindelin@gmx.de>
 <cover.1444076827.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Max Kirillov <max@max630.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Oct 05 22:30:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZjCP2-00084F-2g
	for gcvg-git-2@plane.gmane.org; Mon, 05 Oct 2015 22:30:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751665AbbJEUa2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Oct 2015 16:30:28 -0400
Received: from mout.gmx.net ([212.227.15.18]:57504 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751568AbbJEUa1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Oct 2015 16:30:27 -0400
Received: from dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0MdaCy-1ZzbCO2N0G-00PNBg; Mon, 05 Oct 2015 22:30:24
 +0200
In-Reply-To: <cover.1444076827.git.johannes.schindelin@gmx.de>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.2
X-Provags-ID: V03:K0:/hiW5lHWQsRwwPdxnijl1nG56LDhY55eMCADjodKvBLowVGEhYB
 b6049dm1H0rBDKkdRq44tlSrTBd2nXUhykkIB1SWE5BBrDX6ZryYvspZ1Zp7mMiHJ9ix2qL
 iykDvNdrGtCiY8lsWoqaPygj1BipiXwmMqL2U8mvufUQl+zg3kCdk8uwm+rTY35sIjN5cXD
 +6ll8RYN8aXEM4WFnixEg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:+9kLPZtletk=:ibo8XZxbQRMOvfCsiO2JRC
 HjZcLQM+G4NFZj/OWUaBhAlztsKzKF/23HLb9/go96OjOuSIfR4rWKZbgiK/6+niE8RpSmr5y
 3PKjHroq43c7PYX2uAUlWlE77+znSqICNlW+EEztXHLhxSAiQt+wGlJ8XiMzluycZDvOQiLTO
 Uy45t++fkOXhE4z7xg9tDSTgYRllq3aCsoQwBx+zOWSkmRaGZVpXy+LqqnSehmXsKAAZTCrgD
 wnqfDEq5QLeAivwIxu3tBu4SVC89K9nXmpN/dkz2IcWhKhZETnSNYSLlPvOMa3/YjHxeZUNO+
 Lcvw6g2yxRY0Nfzhkp+gZ3m6uaEz5oeW8BOYgnWmsRJjl+xfktHGqOEXaF4Aa0Yt60cGYh01U
 VVAEHKGbKutuPkBalSVjP619RNB4lrW/ZTzhRrb+tO5k4rZnEGcofjxSo7inaiPRyx/J9gm/N
 K99Dp7OT6uIDGAoTV/8H9tqqZkrGXiumlio7F/PESkFDH53Kyher3VZRUDWJIuElOJf5dS+8I
 PTYxOu4NlN+DLEYRux3bno6vlyf1MtF93VXPdG3t9sFkBJrsgKhOvc/8l+egD0b9NtlzQLUHj
 SxKxZ8Ww9IDwwxNyAya8EuyTriNbqWuEMACqnaiVc8AME8hFCa7i4Kz6BrvlmSTQXl/muRPbS
 1bcl2yFNrbQ9IJJJPzMk2ADo0LplDzlGj0OOA+9zVqNe3CFJtmhbAvm4CQrHqBzRllozxxxuL
 RzHUiy4aZ8OxIw5EsSdTcLGCZqE8VwbkJoa6inq7d/SkieUQf2rMwCdp5DoIZr4JwAZmBmXw 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279082>

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
2.5.3.windows.1.3.gc322723
