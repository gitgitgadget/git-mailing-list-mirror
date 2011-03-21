From: David Barr <david.barr@cordelta.com>
Subject: [PATCH 06/11] vcs-svn: use switch rather than cascading ifs
Date: Tue, 22 Mar 2011 10:49:55 +1100
Message-ID: <1300751400-7427-7-git-send-email-david.barr@cordelta.com>
References: <1300518231-20008-1-git-send-email-david.barr@cordelta.com>
 <1300751400-7427-1-git-send-email-david.barr@cordelta.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Sam Vilain <sam@vilain.net>, Stephen Bash <bash@genarts.com>,
	Tomas Carnecky <tom@dbservice.com>,
	David Barr <david.barr@cordelta.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Mar 22 00:50:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q1orv-0006bP-VY
	for gcvg-git-2@lo.gmane.org; Tue, 22 Mar 2011 00:50:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755887Ab1CUXu3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Mar 2011 19:50:29 -0400
Received: from mailhost.cordelta.com ([119.15.97.146]:54480 "EHLO
	mailhost.cordelta" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755906Ab1CUXuV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Mar 2011 19:50:21 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mailhost.cordelta (Postfix) with ESMTP id 20DDFC066;
	Tue, 22 Mar 2011 10:46:54 +1100 (EST)
X-Virus-Scanned: amavisd-new at mailhost.cordelta
Received: from mailhost.cordelta ([127.0.0.1])
	by localhost (mailhost.cordelta [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Tv3Bw39oRcf8; Tue, 22 Mar 2011 10:46:46 +1100 (EST)
Received: from dba.cordelta (unknown [192.168.123.140])
	by mailhost.cordelta (Postfix) with ESMTP id 91C33C057;
	Tue, 22 Mar 2011 10:46:38 +1100 (EST)
X-Mailer: git-send-email 1.7.3.2.846.gf4b062
In-Reply-To: <1300751400-7427-1-git-send-email-david.barr@cordelta.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169683>

In the spirit of the last two changes:
Switch on length and use constcmp for parsing headers with restricted values.

Signed-off-by: David Barr <david.barr@cordelta.com>
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
---
 vcs-svn/svndump.c |   40 ++++++++++++++++++++++++++++++----------
 1 files changed, 30 insertions(+), 10 deletions(-)

diff --git a/vcs-svn/svndump.c b/vcs-svn/svndump.c
index 3ad48e5..7b5b5ec 100644
--- a/vcs-svn/svndump.c
+++ b/vcs-svn/svndump.c
@@ -343,25 +343,45 @@ void svndump_read(const char *url)
 			}
 			if (constcmp(t + strlen("Node-"), "kind"))
 				continue;
-			if (!strcmp(val, "dir"))
+			switch (strlen(val) + 1) {
+			case sizeof("dir"):
+				if (constcmp(val, "dir"))
+					break;
 				node_ctx.type = REPO_MODE_DIR;
-			else if (!strcmp(val, "file"))
+				break;
+			case sizeof("file"):
+				if (constcmp(val, "file"))
+					break;
 				node_ctx.type = REPO_MODE_BLB;
-			else
+				break;
+			default:
 				fprintf(stderr, "Unknown node-kind: %s\n", val);
+			}
 			break;
 		case sizeof("Node-action"):
 			if (constcmp(t, "Node-action"))
 				continue;
-			if (!strcmp(val, "delete")) {
-				node_ctx.action = NODEACT_DELETE;
-			} else if (!strcmp(val, "add")) {
+			switch (strlen(val) + 1) {
+			case sizeof("add"):
+				if (constcmp(val, "add"))
+					break;
 				node_ctx.action = NODEACT_ADD;
-			} else if (!strcmp(val, "change")) {
-				node_ctx.action = NODEACT_CHANGE;
-			} else if (!strcmp(val, "replace")) {
+				break;
+			case sizeof("change"):
+				if (!constcmp(val, "change")) {
+					node_ctx.action = NODEACT_CHANGE;
+					break;
+				}
+				if (constcmp(val, "delete"))
+					break;
+				node_ctx.action = NODEACT_DELETE;
+				break;
+			case sizeof("replace"):
+				if (constcmp(val, "replace"))
+					break;
 				node_ctx.action = NODEACT_REPLACE;
-			} else {
+				break;
+			default:
 				fprintf(stderr, "Unknown node-action: %s\n", val);
 				node_ctx.action = NODEACT_UNKNOWN;
 			}
-- 
1.7.3.2.846.gf4b062
