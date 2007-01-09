From: Jeff King <peff@peff.net>
Subject: [PATCH] get_tree_entry: map blank requested entry to tree root
Date: Tue, 9 Jan 2007 11:11:47 -0500
Message-ID: <20070109161147.GA9313@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 09 17:12:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H4JZp-0003EL-DW
	for gcvg-git@gmane.org; Tue, 09 Jan 2007 17:11:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932186AbXAIQLu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 9 Jan 2007 11:11:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932189AbXAIQLu
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Jan 2007 11:11:50 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3622 "HELO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932186AbXAIQLu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jan 2007 11:11:50 -0500
Received: (qmail 5397 invoked from network); 9 Jan 2007 11:12:01 -0500
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by 66-23-211-5.clients.speedfactory.net with SMTP; 9 Jan 2007 11:12:01 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 09 Jan 2007 11:11:47 -0500
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36372>

This means that
  git show HEAD:
will now return HEAD^{tree}, which is logically consistent with
  git show HEAD:Documentation

Signed-off-by: Jeff King <peff@peff.net>
---
 tree-walk.c |    9 ++++++++-
 1 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/tree-walk.c b/tree-walk.c
index 22f4550..70f8999 100644
--- a/tree-walk.c
+++ b/tree-walk.c
@@ -199,10 +199,17 @@ int get_tree_entry(const unsigned char *tree_sha1, const char *name, unsigned ch
 	int retval;
 	void *tree;
 	struct tree_desc t;
+	unsigned char root[20];
 
-	tree = read_object_with_reference(tree_sha1, tree_type, &t.size, NULL);
+	tree = read_object_with_reference(tree_sha1, tree_type, &t.size, root);
 	if (!tree)
 		return -1;
+
+	if (name[0] == '\0') {
+		hashcpy(sha1, root);
+		return 0;
+	}
+
 	t.buf = tree;
 	retval = find_tree_entry(&t, name, sha1, mode);
 	free(tree);
-- 
1.4.4.4.g9612-dirty
