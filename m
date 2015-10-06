From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v3 3/4] Add a function to release all packs
Date: Tue, 06 Oct 2015 15:18:34 +0200
Organization: gmx
Message-ID: <9953f8ed40d0cf99f1be7cfe2fa0b699b7769645.1444131898.git.johannes.schindelin@gmx.de>
References: <682991036f1e8e974ed8ecd7d20dbcc6fb86c344.1443469464.git.johannes.schindelin@gmx.de>
 <cover.1444131898.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Max Kirillov <max@max630.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 06 15:18:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZjS8k-0004sv-FM
	for gcvg-git-2@plane.gmane.org; Tue, 06 Oct 2015 15:18:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752579AbbJFNSm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Oct 2015 09:18:42 -0400
Received: from mout.gmx.net ([212.227.17.20]:50496 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752487AbbJFNSl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Oct 2015 09:18:41 -0400
Received: from dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0MVZuV-1a7u6P2frL-00Z2K8; Tue, 06 Oct 2015 15:18:34
 +0200
In-Reply-To: <cover.1444131898.git.johannes.schindelin@gmx.de>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.2
X-Provags-ID: V03:K0:qwZQWIBa6F+IqPcOMOpAjvDPWTuDy2NUCQxfRLhKOtLiKdN+qC0
 qCjKoPCnM4uB1wpB81/ADfyy2lZ9vaGR6lu5l3oGiVdhga+8lokWl6aiBPbU4JsmMLIGAc1
 RlxgzCEE/i5ESe+Ci/iuucnlUo27MXRUYt5JeCM526Cv0BDg1Vic5dphJSPQZEc+6u1Kmkw
 n0qdLuMWgHKX025pg2TiQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:XAv4zXezMmM=:8EiHUmK96FdcwmQOwTek/k
 wHviBm5AUivaGwj+6pUKQ3B6P5LYDIFvQQKUNg/tkqUF2IYOH7uuBVGhsWF2GW3jjtYVSlpKc
 vd1DM5Nu4LvIcoQ+IOW546SGr8IGK15SOyUcNnKM9RubOw0mvzGcGm8KePOi1sAaspUEbG8zy
 H+uzAY94hz/3kq6khRGxi32mZHYhyruCDkSiOfCLrYCtV3DJ+hNVMT5z0NPD/7Mp22Mnx9q7G
 1pAkmARtxc2CW2jFKeFJ/AMhCQQFCHTKMhguu8xUkhh4doaQlVGSaMzWrNSyHw3DAT+xR9j+2
 WDQLo5EGRbL4pkyprzRpl4l7by8q/W8b4hJSDWW9ew4pAM7idQXZeQrTL0wTyyqp3TlNqTjQZ
 68+cji8xqEvopnezMkkihLf+ea0O2QgYF5zvzRujaV1b8gRGhEICWzRKNw4FUH7n6R/N0T4MD
 hJfgA5n+ON8sXj5M+t1e6eO7b523uX4X3QDPbF4EJkUQA8q6Mh2WJZ+Txd7dvJZbjzXpfFALn
 Ycsn5FoQwm6wsnKQkHvaMGC1Te3kW6XfnRa+GdXr9fKaWjWcKBamr+F9rhIbPUIGBR49xLt16
 PwCm3c2wFIJLKAgRtSn5Pc1DfkQXDIlmd6A/BggaSEkNvCnF0+09pfJl2Db2CJegfbxyVyFHM
 Hn7OkZBf9duHMuE7Z0yAV79n34koRPyA102aOT8aTOMThpJt0Pcexzb8A79ZjYxgb1iGO1al4
 jj3CsA1P27rGDJCXH6tzTTVVUZsijz2WTkKQo6756M2SXBSbtFqR28uR5SnQc32zW+Hk9HSp 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279139>

On Windows, files that are in use cannot be removed or renamed. That
means that we have to release pack files when we are about to, say,
repack them. Let's introduce a convenient function to close them
pack files.

While at it, we consolidate the close windows/close fd/close index
stanza in `free_pack_by_name()` into the `close_pack()` function that
is used by the new `close_all_packs()` function to avoid repeated code.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 cache.h     |  1 +
 sha1_file.c | 23 ++++++++++++++++++++---
 2 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/cache.h b/cache.h
index 752031e..57f6a74 100644
--- a/cache.h
+++ b/cache.h
@@ -1275,6 +1275,7 @@ extern void close_pack_index(struct packed_git *);
 
 extern unsigned char *use_pack(struct packed_git *, struct pack_window **, off_t, unsigned long *);
 extern void close_pack_windows(struct packed_git *);
+extern void close_all_packs(void);
 extern void unuse_pack(struct pack_window **);
 extern void free_pack_by_name(const char *);
 extern void clear_delta_base_cache(void);
diff --git a/sha1_file.c b/sha1_file.c
index 8c3c913..ca699d7 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -798,6 +798,25 @@ static int close_pack_fd(struct packed_git *p)
 	return 1;
 }
 
+static void close_pack(struct packed_git *p)
+{
+	close_pack_windows(p);
+	close_pack_fd(p);
+	close_pack_index(p);
+}
+
+void close_all_packs(void)
+{
+	struct packed_git *p;
+
+	for (p = packed_git; p; p = p->next)
+		if (p->do_not_close)
+			die("BUG! Want to close pack marked 'do-not-close'");
+		else
+			close_pack(p);
+}
+
+
 /*
  * The LRU pack is the one with the oldest MRU window, preferring packs
  * with no used windows, or the oldest mtime if it has no windows allocated.
@@ -906,9 +925,7 @@ void free_pack_by_name(const char *pack_name)
 		p = *pp;
 		if (strcmp(pack_name, p->pack_name) == 0) {
 			clear_delta_base_cache();
-			close_pack_windows(p);
-			close_pack_fd(p);
-			close_pack_index(p);
+			close_pack(p);
 			free(p->bad_object_sha1);
 			*pp = p->next;
 			if (last_found_pack == p)
-- 
2.6.1.windows.1
