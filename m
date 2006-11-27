X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] sha1_object_info(): be consistent with read_sha1_file()
Date: Tue, 28 Nov 2006 00:18:55 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0611280016150.30004@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Mon, 27 Nov 2006 23:19:04 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32458>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gopkb-0004mp-Fk for gcvg-git@gmane.org; Tue, 28 Nov
 2006 00:19:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1758599AbWK0XS6 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 27 Nov 2006
 18:18:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758602AbWK0XS5
 (ORCPT <rfc822;git-outgoing>); Mon, 27 Nov 2006 18:18:57 -0500
Received: from mail.gmx.de ([213.165.64.20]:48826 "HELO mail.gmx.net") by
 vger.kernel.org with SMTP id S1758599AbWK0XS5 (ORCPT
 <rfc822;git@vger.kernel.org>); Mon, 27 Nov 2006 18:18:57 -0500
Received: (qmail invoked by alias); 27 Nov 2006 23:18:55 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2)
 [132.187.25.13] by mail.gmx.net (mp012) with SMTP; 28 Nov 2006 00:18:55 +0100
To: git@vger.kernel.org, junkio@cox.net
Sender: git-owner@vger.kernel.org


We used to try loose objects first with sha1_object_info(), but packed
objects first with read_sha1_file(). Now, prefer packed objects over loose
ones with sha1_object_info(), too.

Usually the old behaviour would pose no problem, but when you tried to fix 
a fscked up repository by inserting a known-good pack,

	git cat-file $(git cat-file -t <sha1>) <sha1>

could fail, even when

	git cat-file blob <sha1>

would _not_ fail. Worse, a repack would fail, too.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 sha1_file.c |   35 ++++++++++++++++++++---------------
 1 files changed, 20 insertions(+), 15 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index 09456d2..63f416b 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1261,7 +1261,7 @@ struct packed_git *find_sha1_pack(const unsigned char *sha1,
 	
 }
 
-int sha1_object_info(const unsigned char *sha1, char *type, unsigned long *sizep)
+static int sha1_loose_object_info(const unsigned char *sha1, char *type, unsigned long *sizep)
 {
 	int status;
 	unsigned long mapsize, size;
@@ -1270,20 +1270,8 @@ int sha1_object_info(const unsigned char *sha1, char *type, unsigned long *sizep
 	char hdr[128];
 
 	map = map_sha1_file(sha1, &mapsize);
-	if (!map) {
-		struct pack_entry e;
-
-		if (!find_pack_entry(sha1, &e, NULL)) {
-			reprepare_packed_git();
-			if (!find_pack_entry(sha1, &e, NULL))
-				return error("unable to find %s", sha1_to_hex(sha1));
-		}
-		if (use_packed_git(e.p))
-			die("cannot map packed file");
-		status = packed_object_info(e.p, e.offset, type, sizep);
-		unuse_packed_git(e.p);
-		return status;
-	}
+	if (!map)
+		return error("unable to find %s", sha1_to_hex(sha1));
 	if (unpack_sha1_header(&stream, map, mapsize, hdr, sizeof(hdr)) < 0)
 		status = error("unable to unpack %s header",
 			       sha1_to_hex(sha1));
@@ -1299,6 +1287,23 @@ int sha1_object_info(const unsigned char *sha1, char *type, unsigned long *sizep
 	return status;
 }
 
+int sha1_object_info(const unsigned char *sha1, char *type, unsigned long *sizep)
+{
+	int status;
+	struct pack_entry e;
+
+	if (!find_pack_entry(sha1, &e, NULL)) {
+		reprepare_packed_git();
+		if (!find_pack_entry(sha1, &e, NULL))
+			return sha1_loose_object_info(sha1, type, sizep);
+	}
+	if (use_packed_git(e.p))
+		die("cannot map packed file");
+	status = packed_object_info(e.p, e.offset, type, sizep);
+	unuse_packed_git(e.p);
+	return status;
+}
+
 static void *read_packed_sha1(const unsigned char *sha1, char *type, unsigned long *size)
 {
 	struct pack_entry e;
-- 
1.4.4.1.gfac7-dirty
