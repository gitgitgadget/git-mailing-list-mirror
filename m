From: David Barr <david.barr@cordelta.com>
Subject: [PATCH 3/3] vcs-svn: use switch rather than cascading ifs
Date: Mon, 21 Mar 2011 12:26:17 +1100
Message-ID: <1300670777-17197-3-git-send-email-david.barr@cordelta.com>
References: <20110319085138.GB6706@elie>
 <1300670777-17197-1-git-send-email-david.barr@cordelta.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Sam Vilain <sam@vilain.net>, Stephen Bash <bash@genarts.com>,
	Tomas Carnecky <tom@dbservice.com>,
	David Barr <david.barr@cordelta.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Mar 21 02:27:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q1Ttc-0002pY-FU
	for gcvg-git-2@lo.gmane.org; Mon, 21 Mar 2011 02:27:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752536Ab1CUB0u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Mar 2011 21:26:50 -0400
Received: from mailhost.cordelta.com ([119.15.97.146]:52628 "EHLO
	mailhost.cordelta" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752384Ab1CUB0r (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Mar 2011 21:26:47 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mailhost.cordelta (Postfix) with ESMTP id DADE8C05A;
	Mon, 21 Mar 2011 12:23:10 +1100 (EST)
X-Virus-Scanned: amavisd-new at mailhost.cordelta
Received: from mailhost.cordelta ([127.0.0.1])
	by localhost (mailhost.cordelta [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id g0ETUw3mMX3k; Mon, 21 Mar 2011 12:23:07 +1100 (EST)
Received: from dba.cordelta (unknown [192.168.123.140])
	by mailhost.cordelta (Postfix) with ESMTP id 74784C054;
	Mon, 21 Mar 2011 12:23:07 +1100 (EST)
X-Mailer: git-send-email 1.7.3.2.846.gf4b062
In-Reply-To: <1300670777-17197-1-git-send-email-david.barr@cordelta.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169547>

In the spirit of the last two changes:
Switch on length and use constcmp for parsing headers with restricted values.

Signed-off-by: David Barr <david.barr@cordelta.com>
---
 vcs-svn/svndump.c |   38 +++++++++++++++++++++++++++++---------
 1 files changed, 29 insertions(+), 9 deletions(-)

diff --git a/vcs-svn/svndump.c b/vcs-svn/svndump.c
index f03e8cf..fe14ce2 100644
--- a/vcs-svn/svndump.c
+++ b/vcs-svn/svndump.c
@@ -350,25 +350,45 @@ void svndump_read(const char *url)
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
+				break;
+			case sizeof("change"):
+				if (constcmp(val, "change"))
+					break;
 				node_ctx.action = NODEACT_CHANGE;
-			} else if (!strcmp(val, "replace")) {
+				break;
+			case sizeof("delete"):
+				if (!constcmp(val, "delete")) {
+					node_ctx.action = NODEACT_DELETE;
+					break;
+				}
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
