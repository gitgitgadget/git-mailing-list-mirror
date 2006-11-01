X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH 5/6] have index-pack create .keep file more carefully
Date: Wed, 01 Nov 2006 17:06:24 -0500
Message-ID: <11624187871572-git-send-email-nico@cam.org>
References: <11624187853116-git-send-email-nico@cam.org>
 <11624187853865-git-send-email-nico@cam.org>
 <1162418786895-git-send-email-nico@cam.org>
 <1162418786390-git-send-email-nico@cam.org>
Content-Transfer-Encoding: 7BIT
NNTP-Posting-Date: Wed, 1 Nov 2006 22:06:56 +0000 (UTC)
Cc: git@vger.kernel.org, Nicolas Pitre <nico@cam.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-reply-to: <1162418786390-git-send-email-nico@cam.org>
X-Mailer: git-send-email 1.4.3.3.g87b2-dirty
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30665>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GfOEQ-0005ag-Fz for gcvg-git@gmane.org; Wed, 01 Nov
 2006 23:06:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1752516AbWKAWGd (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 1 Nov 2006
 17:06:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752517AbWKAWGc
 (ORCPT <rfc822;git-outgoing>); Wed, 1 Nov 2006 17:06:32 -0500
Received: from relais.videotron.ca ([24.201.245.36]:63137 "EHLO
 relais.videotron.ca") by vger.kernel.org with ESMTP id S1752514AbWKAWG3
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 1 Nov 2006 17:06:29 -0500
Received: from localhost.localdomain ([74.56.106.175]) by
 VL-MH-MR002.ip.videotron.ca (Sun Java System Messaging Server 6.2-2.05 (built
 Apr 28 2005)) with ESMTP id <0J8200BN9O2PMF20@VL-MH-MR002.ip.videotron.ca>
 for git@vger.kernel.org; Wed, 01 Nov 2006 17:06:28 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

If by chance we receive a pack which content (list of objects) matches
another pack that we already have, and if that pack is marked with a
.keep file, then we should not overwrite it.

Signed-off-by: Nicolas Pitre <nico@cam.org>
---
 index-pack.c |   17 ++++++++++-------
 1 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/index-pack.c b/index-pack.c
index a3b55f9..8d64a88 100644
--- a/index-pack.c
+++ b/index-pack.c
@@ -788,14 +788,17 @@ static void final(const char *final_pack
 				 get_object_directory(), sha1_to_hex(sha1));
 			keep_name = name;
 		}
-		keep_fd = open(keep_name, O_RDWR | O_CREAT, 0600);
-		if (keep_fd < 0)
-			die("cannot write keep file");
-		if (keep_msg_len > 0) {
-			write_or_die(keep_fd, keep_msg, keep_msg_len);
-			write_or_die(keep_fd, "\n", 1);
+		keep_fd = open(keep_name, O_RDWR|O_CREAT|O_EXCL, 0600);
+		if (keep_fd < 0) {
+			if (errno != EEXIST)
+				die("cannot write keep file");
+		} else {
+			if (keep_msg_len > 0) {
+				write_or_die(keep_fd, keep_msg, keep_msg_len);
+				write_or_die(keep_fd, "\n", 1);
+			}
+			close(keep_fd);
 		}
-		close(keep_fd);
 	}
 
 	if (final_pack_name != curr_pack_name) {
-- 
1.4.3.3.g87b2-dirty
