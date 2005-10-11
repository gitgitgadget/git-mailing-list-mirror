From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Remove empty directories after read-tree -u.
Date: Mon, 10 Oct 2005 17:35:01 -0700
Message-ID: <7vu0fo28ne.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Tue Oct 11 02:35:46 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EP86m-00055j-Kz
	for gcvg-git@gmane.org; Tue, 11 Oct 2005 02:35:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751312AbVJKAfE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 10 Oct 2005 20:35:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751317AbVJKAfE
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Oct 2005 20:35:04 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:58600 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S1751312AbVJKAfD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Oct 2005 20:35:03 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051011003453.BLQM9394.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 10 Oct 2005 20:34:53 -0400
To: git@vger.kernel.org
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9949>

This fixes everybody's favorite gripe that switching branche with
'git checkout' leaves empty directories.

Signed-off-by: Junio C Hamano <junkio@cox.net>

---

 read-tree.c |   31 ++++++++++++++++++++++++++++++-
 1 files changed, 30 insertions(+), 1 deletions(-)

applies-to: 0c8b9e1023f9c5fbaaa7151bcc105783b98c9f10
340e4f88c083b0692e6554b1c2c27fd43c7cc8d3
diff --git a/read-tree.c b/read-tree.c
index 5fdf58d..6a456ae 100644
--- a/read-tree.c
+++ b/read-tree.c
@@ -237,6 +237,35 @@ static void reject_merge(struct cache_en
 	    ce->name);
 }
 
+/* Unlink the last component and attempt to remove leading
+ * directories, in case this unlink is the removal of the
+ * last entry in the directory -- empty directories are removed.
+ */
+static void unlink_entry(char *name)
+{
+	char *cp, *prev;
+
+	if (unlink(name))
+		return;
+	prev = NULL;
+	while (1) {
+		int status;
+		cp = strrchr(name, '/');
+		if (prev)
+			*prev = '/';
+		if (!cp)
+			break;
+
+		*cp = 0;
+		status = rmdir(name);
+		if (status) {
+			*cp = '/';
+			break;
+		}
+		prev = cp;
+	}
+}
+
 static void check_updates(struct cache_entry **src, int nr)
 {
 	static struct checkout state = {
@@ -250,7 +279,7 @@ static void check_updates(struct cache_e
 		struct cache_entry *ce = *src++;
 		if (!ce->ce_mode) {
 			if (update)
-				unlink(ce->name);
+				unlink_entry(ce->name);
 			continue;
 		}
 		if (ce->ce_flags & mask) {
---
0.99.8.GIT
