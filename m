From: David Barr <david.barr@cordelta.com>
Subject: [PATCH] fast-import: Allow filemodify to set the root
Date: Fri,  8 Oct 2010 10:46:59 +1100
Message-ID: <1286495219-14414-1-git-send-email-david.barr@cordelta.com>
References: <201010081045.46642.david.barr@cordelta.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	David Barr <david.barr@cordelta.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Oct 08 01:47:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P40BJ-0004c2-Iv
	for gcvg-git-2@lo.gmane.org; Fri, 08 Oct 2010 01:47:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752098Ab0JGXrV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Oct 2010 19:47:21 -0400
Received: from static-198-196.grapevine.transact.net.au ([121.127.198.196]:63444
	"EHLO mailhost.cordelta" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751601Ab0JGXrU (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 7 Oct 2010 19:47:20 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mailhost.cordelta (Postfix) with ESMTP id 95882C043;
	Fri,  8 Oct 2010 10:47:25 +1100 (EST)
X-Virus-Scanned: amavisd-new at mailhost.cordelta
Received: from mailhost.cordelta ([127.0.0.1])
	by localhost (mailhost.cordelta [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3aGLCqpRSky9; Fri,  8 Oct 2010 10:47:23 +1100 (EST)
Received: from dba.cordelta (unknown [192.168.123.127])
	by mailhost.cordelta (Postfix) with ESMTP id 49A99C03F;
	Fri,  8 Oct 2010 10:47:23 +1100 (EST)
X-Mailer: git-send-email 1.7.3.4.g45608.dirty
In-Reply-To: <201010081045.46642.david.barr@cordelta.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158463>

For a command (like filter-branch --subdirectory-filter) that wants
to commit a lot of trees that already exist in the object db, writing
undeltified objects as loose files only to repack them later can
involve a significant amount of overhead.
(23% slow-down observed on Linux 2.6.35, worse on Mac OS X 10.6)

Fortunately we have fast-import (which is one of the only git commands
that will write to a pack directly) but there is not an advertised way
to tell fast-import to commit a given tree without unpacking it.

This patch changes that, by allowing

	M 040000 <tree id> ""

as a filemodify line in a commit to reset to a particular tree without
any need to parse it.  For example,

	M 040000 4b825dc642cb6eb9a060e54bf8d69288fbee4904 ""

is a synonym for the deleteall command and the fast-import equivalent of

	git read-tree 4b825dc642cb6eb9a060e54bf8d69288fbee4904

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
1.7.3.4.g45608.dirty
