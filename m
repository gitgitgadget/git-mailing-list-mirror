From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH v3 07/11] Introduce close_pack_index to permit replacement
Date: Sat, 17 Apr 2010 13:07:40 -0700
Message-ID: <1271534864-31944-7-git-send-email-spearce@spearce.org>
References: <20100416100307.0000423f@unknown>
Cc: git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Christian Halstrick <christian.halstrick@gmail.com>,
	jan.sievers@sap.com, Matthias Sohn <matthias.sohn@sap.com>
To: Junio C Hamano <gitster@pobox.com>,
	Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 17 22:08:20 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O3EJQ-0005ew-0M
	for gcvg-git-2@lo.gmane.org; Sat, 17 Apr 2010 22:08:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754842Ab0DQUIK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Apr 2010 16:08:10 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:43145 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754516Ab0DQUH7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Apr 2010 16:07:59 -0400
Received: by mail-gw0-f46.google.com with SMTP id a18so1946168gwa.19
        for <git@vger.kernel.org>; Sat, 17 Apr 2010 13:07:59 -0700 (PDT)
Received: by 10.100.222.12 with SMTP id u12mr5443745ang.113.1271534879267;
        Sat, 17 Apr 2010 13:07:59 -0700 (PDT)
Received: from localhost (yellowpostit.mtv.corp.google.com [172.18.104.34])
        by mx.google.com with ESMTPS id n2sm26785381ann.2.2010.04.17.13.07.58
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 17 Apr 2010 13:07:58 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.rc1.269.ga27c7
In-Reply-To: <20100416100307.0000423f@unknown>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145178>

By closing the pack index, a caller can later overwrite the index
with an updated index file, possibly after converting from v1 to
the v2 format.  Because p->index_data is NULL after close, on the
next access the index will be opened again and the other members
will be updated with new data.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 cache.h     |    1 +
 sha1_file.c |   11 +++++++++--
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/cache.h b/cache.h
index 5eb0573..4150603 100644
--- a/cache.h
+++ b/cache.h
@@ -916,6 +916,7 @@ extern struct packed_git *find_sha1_pack(const unsigned char *sha1,
 
 extern void pack_report(void);
 extern int open_pack_index(struct packed_git *);
+extern void close_pack_index(struct packed_git *);
 extern unsigned char *use_pack(struct packed_git *, struct pack_window **, off_t, unsigned int *);
 extern void close_pack_windows(struct packed_git *);
 extern void unuse_pack(struct pack_window **);
diff --git a/sha1_file.c b/sha1_file.c
index ff65328..820063e 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -599,6 +599,14 @@ void unuse_pack(struct pack_window **w_cursor)
 	}
 }
 
+void close_pack_index(struct packed_git *p)
+{
+	if (p->index_data) {
+		munmap((void *)p->index_data, p->index_size);
+		p->index_data = NULL;
+	}
+}
+
 /*
  * This is used by git-repack in case a newly created pack happens to
  * contain the same set of objects as an existing one.  In that case
@@ -620,8 +628,7 @@ void free_pack_by_name(const char *pack_name)
 			close_pack_windows(p);
 			if (p->pack_fd != -1)
 				close(p->pack_fd);
-			if (p->index_data)
-				munmap((void *)p->index_data, p->index_size);
+			close_pack_index(p);
 			free(p->bad_object_sha1);
 			*pp = p->next;
 			free(p);
-- 
1.7.1.rc1.269.ga27c7
