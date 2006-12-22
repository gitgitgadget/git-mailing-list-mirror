From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 3/3] Don't crash during repack of a reflog with pruned commits.
Date: Fri, 22 Dec 2006 00:16:23 -0800
Message-ID: <7vodpw5ors.fsf@assigned-by-dhcp.cox.net>
References: <be6b1443171482e1930bd7744a0218db0c03d611.1166748450.git.spearce@spearce.org>
	<20061222004906.GC14789@spearce.org>
	<20061222005606.GA14773@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 22 09:16:31 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GxfZt-0004ct-FL
	for gcvg-git@gmane.org; Fri, 22 Dec 2006 09:16:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945965AbWLVIQ0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Dec 2006 03:16:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945967AbWLVIQ0
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Dec 2006 03:16:26 -0500
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:48857 "EHLO
	fed1rmmtao02.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1945965AbWLVIQZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Dec 2006 03:16:25 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20061222081624.UVTK97.fed1rmmtao02.cox.net@fed1rmimpo01.cox.net>;
          Fri, 22 Dec 2006 03:16:24 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 1kFh1W00A1kojtg0000000; Fri, 22 Dec 2006 03:15:41 -0500
To: Shawn Pearce <spearce@spearce.org>
In-Reply-To: <20061222005606.GA14773@spearce.org> (Shawn Pearce's message of
	"Thu, 21 Dec 2006 19:56:06 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35140>

Shawn Pearce <spearce@spearce.org> writes:

> Just because the commit has not been pruned does not mean that a blob
> or tree referenced by that commit has not been pruned.

True.  How about this?

---

 builtin-reflog.c |   43 ++++++++++++++++++++++++++++++++++++++++---
 1 files changed, 40 insertions(+), 3 deletions(-)

diff --git a/builtin-reflog.c b/builtin-reflog.c
index d4f7353..4097c32 100644
--- a/builtin-reflog.c
+++ b/builtin-reflog.c
@@ -3,7 +3,7 @@
 #include "commit.h"
 #include "refs.h"
 #include "dir.h"
-#include <time.h>
+#include "tree-walk.h"
 
 struct expire_reflog_cb {
 	FILE *newlog;
@@ -13,13 +13,50 @@ struct expire_reflog_cb {
 	unsigned long expire_unreachable;
 };
 
+static int tree_is_complete(const unsigned char *sha1)
+{
+	struct tree_desc desc;
+	void *buf;
+	char type[20];
+
+	buf = read_sha1_file(sha1, type, &desc.size);
+	if (!buf)
+		return 0;
+	desc.buf = buf;
+	while (desc.size) {
+		const unsigned char *elem;
+		const char *name;
+		unsigned mode;
+
+		elem = tree_entry_extract(&desc, &name, &mode);
+		if (!has_sha1_file(elem) ||
+		    (S_ISDIR(mode) && !tree_is_complete(elem))) {
+			free(buf);
+			return 0;
+		}
+		update_tree_entry(&desc);
+	}
+	free(buf);
+	return 1;
+}
+
 static int keep_entry(struct commit **it, unsigned char *sha1)
 {
+	struct commit *commit;
+
 	*it = NULL;
 	if (is_null_sha1(sha1))
 		return 1;
-	*it = lookup_commit_reference_gently(sha1, 1);
-	return (*it != NULL);
+	commit = lookup_commit_reference_gently(sha1, 1);
+	if (!commit)
+		return 0;
+
+	/* Make sure everything in this commit exists. */
+	parse_object(commit->object.sha1);
+	if (!tree_is_complete(commit->tree->object.sha1))
+		return 0;
+	*it = commit;
+	return 1;
 }
 
 static int expire_reflog_ent(unsigned char *osha1, unsigned char *nsha1,
