From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH v4 07/11] Introduce close_pack_index to permit replacement
Date: Mon, 19 Apr 2010 07:23:06 -0700
Message-ID: <1271686990-16363-3-git-send-email-spearce@spearce.org>
References: <20100418115744.0000238b@unknown>
Cc: git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Christian Halstrick <christian.halstrick@gmail.com>,
	jan.sievers@sap.com, Matthias Sohn <matthias.sohn@sap.com>,
	Junio C Hamano <gitster@pobox.com>
To: Junio C Hamano <gitster@pobox.com>,
	Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 19 16:23:37 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O3rsu-0000jt-Jn
	for gcvg-git-2@lo.gmane.org; Mon, 19 Apr 2010 16:23:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754492Ab0DSOX1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Apr 2010 10:23:27 -0400
Received: from mail-bw0-f225.google.com ([209.85.218.225]:48685 "EHLO
	mail-bw0-f225.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753811Ab0DSOX0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Apr 2010 10:23:26 -0400
Received: by mail-bw0-f225.google.com with SMTP id 25so5648036bwz.28
        for <git@vger.kernel.org>; Mon, 19 Apr 2010 07:23:25 -0700 (PDT)
Received: by 10.86.126.4 with SMTP id y4mr2661604fgc.47.1271687005433;
        Mon, 19 Apr 2010 07:23:25 -0700 (PDT)
Received: from localhost (yellowpostit.mtv.corp.google.com [172.18.104.34])
        by mx.google.com with ESMTPS id 1sm10701778fkt.41.2010.04.19.07.23.23
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 19 Apr 2010 07:23:24 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.rc1.279.g22727
In-Reply-To: <20100418115744.0000238b@unknown>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145299>

By closing the pack index, a caller can later overwrite the index
with an updated index file, possibly after converting from v1 to
the v2 format.  Because p->index_data is NULL after close, on the
next access the index will be opened again and the other members
will be updated with new data.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 No change from v3.

 cache.h     |    1 +
 sha1_file.c |   11 +++++++++--
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/cache.h b/cache.h
index 6e54993..0eba039 100644
--- a/cache.h
+++ b/cache.h
@@ -911,6 +911,7 @@ extern struct packed_git *find_sha1_pack(const unsigned char *sha1,
 
 extern void pack_report(void);
 extern int open_pack_index(struct packed_git *);
+extern void close_pack_index(struct packed_git *);
 extern unsigned char *use_pack(struct packed_git *, struct pack_window **, off_t, unsigned int *);
 extern void close_pack_windows(struct packed_git *);
 extern void unuse_pack(struct pack_window **);
diff --git a/sha1_file.c b/sha1_file.c
index c23cc5e..4e82654 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -606,6 +606,14 @@ void unuse_pack(struct pack_window **w_cursor)
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
@@ -627,8 +635,7 @@ void free_pack_by_name(const char *pack_name)
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
1.7.1.rc1.279.g22727
