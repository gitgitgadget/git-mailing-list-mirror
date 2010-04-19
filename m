From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH v4 08/11] Extract verify_pack_index for reuse from verify_pack
Date: Mon, 19 Apr 2010 07:23:07 -0700
Message-ID: <1271686990-16363-4-git-send-email-spearce@spearce.org>
References: <20100418115744.0000238b@unknown>
Cc: git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Christian Halstrick <christian.halstrick@gmail.com>,
	jan.sievers@sap.com, Matthias Sohn <matthias.sohn@sap.com>,
	Junio C Hamano <gitster@pobox.com>
To: Junio C Hamano <gitster@pobox.com>,
	Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 19 16:24:35 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O3rti-0001ST-Bt
	for gcvg-git-2@lo.gmane.org; Mon, 19 Apr 2010 16:24:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754840Ab0DSOXe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Apr 2010 10:23:34 -0400
Received: from ey-out-2122.google.com ([74.125.78.27]:10037 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754800Ab0DSOXc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Apr 2010 10:23:32 -0400
Received: by ey-out-2122.google.com with SMTP id d26so356969eyd.19
        for <git@vger.kernel.org>; Mon, 19 Apr 2010 07:23:30 -0700 (PDT)
Received: by 10.87.9.11 with SMTP id m11mr4150400fgi.73.1271687009879;
        Mon, 19 Apr 2010 07:23:29 -0700 (PDT)
Received: from localhost (yellowpostit.mtv.corp.google.com [172.18.104.34])
        by mx.google.com with ESMTPS id 3sm4394856fge.0.2010.04.19.07.23.28
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 19 Apr 2010 07:23:29 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.rc1.279.g22727
In-Reply-To: <20100418115744.0000238b@unknown>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145301>

The dumb HTTP transport should verify an index is completely valid
before trying to use it.  That requires checking the header/footer
but also checking the complete content SHA-1.  All of this logic is
already in the front half of verify_pack, so pull it out into a new
function that can be reused.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 No change from v3.

 pack-check.c |   15 ++++++++++++---
 pack.h       |    1 +
 2 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/pack-check.c b/pack-check.c
index 166ca70..395fb95 100644
--- a/pack-check.c
+++ b/pack-check.c
@@ -133,14 +133,13 @@ static int verify_packfile(struct packed_git *p,
 	return err;
 }
 
-int verify_pack(struct packed_git *p)
+int verify_pack_index(struct packed_git *p)
 {
 	off_t index_size;
 	const unsigned char *index_base;
 	git_SHA_CTX ctx;
 	unsigned char sha1[20];
 	int err = 0;
-	struct pack_window *w_curs = NULL;
 
 	if (open_pack_index(p))
 		return error("packfile %s index not opened", p->pack_name);
@@ -154,8 +153,18 @@ int verify_pack(struct packed_git *p)
 	if (hashcmp(sha1, index_base + index_size - 20))
 		err = error("Packfile index for %s SHA1 mismatch",
 			    p->pack_name);
+	return err;
+}
+
+int verify_pack(struct packed_git *p)
+{
+	int err = 0;
+	struct pack_window *w_curs = NULL;
+
+	err |= verify_pack_index(p);
+	if (!p->index_data)
+		return -1;
 
-	/* Verify pack file */
 	err |= verify_packfile(p, &w_curs);
 	unuse_pack(&w_curs);
 
diff --git a/pack.h b/pack.h
index b759a23..880f9c2 100644
--- a/pack.h
+++ b/pack.h
@@ -57,6 +57,7 @@ struct pack_idx_entry {
 
 extern const char *write_idx_file(const char *index_name, struct pack_idx_entry **objects, int nr_objects, unsigned char *sha1);
 extern int check_pack_crc(struct packed_git *p, struct pack_window **w_curs, off_t offset, off_t len, unsigned int nr);
+extern int verify_pack_index(struct packed_git *);
 extern int verify_pack(struct packed_git *);
 extern void fixup_pack_header_footer(int, unsigned char *, const char *, uint32_t, unsigned char *, off_t);
 extern char *index_pack_lockfile(int fd);
-- 
1.7.1.rc1.279.g22727
