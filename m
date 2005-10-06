From: robfitz@273k.net
Subject: [PATCH] Reduce memory usage in git-update-server-info.
Date: Thu, 6 Oct 2005 22:49:03 +0000
Message-ID: <11286389433926-git-send-email-robfitz@273k.net>
Reply-To: robfitz@273k.net
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Robert Fitzsimons <robfitz@273k.net>
X-From: git-owner@vger.kernel.org Fri Oct 07 00:40:40 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ENePU-00030P-5b
	for gcvg-git@gmane.org; Fri, 07 Oct 2005 00:40:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751132AbVJFWkR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 6 Oct 2005 18:40:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751137AbVJFWkR
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Oct 2005 18:40:17 -0400
Received: from igraine.blacknight.ie ([217.114.173.147]:64176 "EHLO
	igraine.blacknight.ie") by vger.kernel.org with ESMTP
	id S1751132AbVJFWkP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Oct 2005 18:40:15 -0400
Received: from [212.17.39.138] (helo=earth)
	by igraine.blacknight.ie with smtp (Exim 4.42)
	id 1ENeP9-0001UO-JK; Thu, 06 Oct 2005 23:39:59 +0100
In-Reply-To: 
X-Mailer: git-send-email
To: git@vger.kernel.org
X-blacknight-igraine-MailScanner-Information: Please contact the ISP for more information
X-blacknight-igraine-MailScanner: Found to be clean
X-blacknight-igraine-MailScanner-SpamCheck: not spam,
	SpamAssassin (score=0.178, required 7.5, NO_REAL_NAME 0.18)
X-MailScanner-From: robfitz@273k.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9788>

Modify parse_object_cheap() to also free all the entries from the tree
data structures.

Signed-off-by: Robert Fitzsimons <robfitz@273k.net>

---

 server-info.c |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

applies-to: fc843c89d12160dfe9704e7a0dd678cc729459cb
67be887f195205e36c7eec39b9caea249a435e95
diff --git a/server-info.c b/server-info.c
--- a/server-info.c
+++ b/server-info.c
@@ -59,6 +59,16 @@ static struct object *parse_object_cheap
 		struct commit *commit = (struct commit *)o;
 		free(commit->buffer);
 		commit->buffer = NULL;
+	} else if (o->type == tree_type) {
+		struct tree *tree = (struct tree *)o;
+		struct tree_entry_list *e, *n;
+		for (e = tree->entries; e; e = n) {
+			free(e->name);
+			e->name = NULL;
+			n = e->next;
+			free(e);
+		}
+		tree->entries = NULL;
 	}
 	return o;
 }
---
0.99.8.GIT
