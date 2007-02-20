From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] name-rev: avoid "^0" when unneeded
Date: Tue, 20 Feb 2007 01:08:48 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702200108250.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org, junkio@cox.net
X-From: git-owner@vger.kernel.org Tue Feb 20 01:11:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HJIb5-00082S-Q0
	for gcvg-git@gmane.org; Tue, 20 Feb 2007 01:11:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965608AbXBTAKO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Feb 2007 19:10:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965600AbXBTAJm
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Feb 2007 19:09:42 -0500
Received: from mail.gmx.net ([213.165.64.20]:57324 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S965603AbXBTAIv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Feb 2007 19:08:51 -0500
Received: (qmail invoked by alias); 20 Feb 2007 00:08:49 -0000
X-Provags-ID: V01U2FsdGVkX1+6Cu0l5Bu6IvxKlEbIHYWvwZ/kfR9W4VsOn8H6k8
	1O9Q==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40167>


When naming by a tag, we used to add "^0" even if this was not really
necessary. For example, `git name-rev de6f0def` now outputs

	de6f0def tags/v1.5.0.1~9

instead of

	de6f0def tags/v1.5.0.1^0~9

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
---
 builtin-name-rev.c |   23 ++++++++++++++++-------
 1 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/builtin-name-rev.c b/builtin-name-rev.c
index bb6cfe7..cf666d1 100644
--- a/builtin-name-rev.c
+++ b/builtin-name-rev.c
@@ -58,13 +58,17 @@ copy_data:
 			parents;
 			parents = parents->next, parent_number++) {
 		if (parent_number > 1) {
-			char *new_name = xmalloc(strlen(tip_name)+8);
+			int len = strlen(tip_name);
+			char *new_name = xmalloc(len + 8);
 
+			if (len > 2 && !strcmp(tip_name + len - 2, "^0"))
+				len -= 2;
 			if (generation > 0)
-				sprintf(new_name, "%s~%d^%d", tip_name,
+				sprintf(new_name, "%.*s~%d^%d", len, tip_name,
 						generation, parent_number);
 			else
-				sprintf(new_name, "%s^%d", tip_name, parent_number);
+				sprintf(new_name, "%.*s^%d", len, tip_name,
+						parent_number);
 
 			name_rev(parents->item, new_name,
 				merge_traversals + 1 , 0, 0);
@@ -128,10 +132,15 @@ static const char* get_rev_name(struct object *o)
 
 	if (!n->generation)
 		return n->tip_name;
-
-	snprintf(buffer, sizeof(buffer), "%s~%d", n->tip_name, n->generation);
-
-	return buffer;
+	else {
+		int len = strlen(n->tip_name);
+		if (len > 2 && !strcmp(n->tip_name + len - 2, "^0"))
+			len -= 2;
+		snprintf(buffer, sizeof(buffer), "%.*s~%d", len, n->tip_name,
+				n->generation);
+
+		return buffer;
+	}
 }
 
 int cmd_name_rev(int argc, const char **argv, const char *prefix)
-- 
1.5.0.1.2139.ge3fc7
