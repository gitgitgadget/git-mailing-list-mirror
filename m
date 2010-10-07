From: David Barr <david.barr@cordelta.com>
Subject: [PATCH] fast-import: Allow filemodify to set the root
Date: Thu,  7 Oct 2010 21:55:06 +1100
Message-ID: <1286448906-1424-1-git-send-email-david.barr@cordelta.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	David Barr <david.barr@cordelta.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Oct 07 12:56:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P3o8w-0007fm-Tq
	for gcvg-git-2@lo.gmane.org; Thu, 07 Oct 2010 12:56:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760268Ab0JGK4E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Oct 2010 06:56:04 -0400
Received: from mail05.syd.optusnet.com.au ([211.29.132.186]:58836 "EHLO
	mail05.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751690Ab0JGK4E (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 7 Oct 2010 06:56:04 -0400
Received: from localhost.localdomain (d110-33-95-167.mit3.act.optusnet.com.au [110.33.95.167])
	by mail05.syd.optusnet.com.au (8.13.1/8.13.1) with ESMTP id o97AtsgF018639;
	Thu, 7 Oct 2010 21:55:55 +1100
X-Mailer: git-send-email 1.7.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158395>

Most git commands do their writing to the object db via the index and
loose objects.  When you just have a pile of trees you want to convert
into commits, this is wasteful; for performance-critical operations
like filter-branch --subdirectory-filter, one might want a sort of
hash-object --batch-to-pack to write a pack directly.

Fortunately we have fast-import (which is one of the only git commands
that will write to a pack directly) but there is not an advertised way
to tell fast-import to use a given tree for its commits.  So in
current git, one has the unpleasant choice of writing loose objects
without parsing the trees or writing straight to pack but having to
parse trees to do it.

This patch changes that, by allowing

	M 040000 <tree id> ""

as a filemodify line in a commit to reset to a particular tree without
any need to unpack it.  For example,

	M 040000 4b825dc642cb6eb9a060e54bf8d69288fbee4904 ""

is a synonym for the deleteall command.

Commit-message-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: David Barr <david.barr@cordelta.com>
---
 fast-import.c |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index 2317b0f..8f68a89 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -1454,6 +1454,15 @@ static int tree_content_set(
 		n = slash1 - p;
 	else
 		n = strlen(p);
+	if (!slash1 && !n) {
+		if (!S_ISDIR(mode))
+			die("Root cannot be a non-directory");
+		hashcpy(root->versions[1].sha1, sha1);
+		if (root->tree)
+			release_tree_content_recursive(root->tree);
+		root->tree = subtree;
+		return 1;
+	}
 	if (!n)
 		die("Empty path component found in input");
 	if (!slash1 && !S_ISDIR(mode) && subtree)
-- 
1.7.3
