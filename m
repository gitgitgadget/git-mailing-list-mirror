X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 1/2] git-shortlog: fix common repository prefix abbreviation.
Date: Sat, 25 Nov 2006 00:10:57 -0800
Message-ID: <7vfyc854ku.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sat, 25 Nov 2006 08:11:06 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32265>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gnscp-00077w-Ks for gcvg-git@gmane.org; Sat, 25 Nov
 2006 09:11:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1757887AbWKYIK7 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 25 Nov 2006
 03:10:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757888AbWKYIK7
 (ORCPT <rfc822;git-outgoing>); Sat, 25 Nov 2006 03:10:59 -0500
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:21406 "EHLO
 fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP id S1757887AbWKYIK6
 (ORCPT <rfc822;git@vger.kernel.org>); Sat, 25 Nov 2006 03:10:58 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao06.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061125081058.YLEE5465.fed1rmmtao06.cox.net@fed1rmimpo02.cox.net>; Sat, 25
 Nov 2006 03:10:58 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id qwB51V00w1kojtg0000000; Sat, 25 Nov 2006
 03:11:06 -0500
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

The code to abbreviate the common repository prefix was totally
borked.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 builtin-shortlog.c |   13 +++++++++----
 1 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/builtin-shortlog.c b/builtin-shortlog.c
index b760b47..bdd952c 100644
--- a/builtin-shortlog.c
+++ b/builtin-shortlog.c
@@ -130,12 +130,17 @@ static void insert_author_oneline(struct path_list *list,
 	memcpy(buffer, oneline, onelinelen);
 	buffer[onelinelen] = '\0';
 
-	while ((p = strstr(buffer, dot3)) != NULL) {
-		memcpy(p, "...", 3);
-		strcpy(p + 2, p + sizeof(dot3) - 1);
+	if (dot3) {
+		int dot3len = strlen(dot3);
+		if (dot3len > 5) {
+			while ((p = strstr(buffer, dot3)) != NULL) {
+				int taillen = strlen(p) - dot3len;
+				memcpy(p, "/.../", 5);
+				memmove(p + 5, p + dot3len, taillen + 1);
+			}
+		}
 	}
 
-
 	onelines = item->util;
 	if (onelines->nr >= onelines->alloc) {
 		onelines->alloc = alloc_nr(onelines->nr);
-- 
1.4.4.1.g61fba

