From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH (RESEND) 2/3] Work around Sun javac compiler error in RefUpdate
Date: Tue,  1 Sep 2009 16:16:49 -0700
Message-ID: <1251847010-9992-2-git-send-email-spearce@spearce.org>
References: <1251847010-9992-1-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org, "Shawn O. Pearce" <sop@google.com>
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Wed Sep 02 01:17:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Micb0-0003vt-BZ
	for gcvg-git-2@lo.gmane.org; Wed, 02 Sep 2009 01:17:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755367AbZIAXQu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Sep 2009 19:16:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755362AbZIAXQu
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Sep 2009 19:16:50 -0400
Received: from george.spearce.org ([209.20.77.23]:40838 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755361AbZIAXQt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Sep 2009 19:16:49 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id A471638222; Tue,  1 Sep 2009 23:16:51 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id C9CA138200;
	Tue,  1 Sep 2009 23:16:50 +0000 (UTC)
X-Mailer: git-send-email 1.6.4.1.341.gf2a44
In-Reply-To: <1251847010-9992-1-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127566>

Sun's javac, version 5 and 6, apparently miscompiles the for loop
which is looking for a conflicting ref name in the existing set of
refs for this repository.

Debugging this code showed the control flow to return LOCK_FAILURE
when startsWith returned false, which is highly illogical and the
exact opposite of what we have written here.

Sun's javap tool was unable to disassemble the compiled method.
Instead it simply failed to produce anything about updateImpl.
So my remark about the code being compiled wrong is only a guess
based on how I observed the behavior, and not by actually studying
the resulting instructions.

Eclipse's JDT appears to have compiled the updateImpl method
correctly, and produces a working executable.  But this is a
much less common compiler to build Java libraries with.

This refactoring to extract the name conflicting test out into
its own method appears to work around the Sun javac bug, and the
resulting class works correctly with either compiler.  The code is
also more clear, so its a gain either way.

Signed-off-by: Shawn O. Pearce <sop@google.com>
Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../src/org/spearce/jgit/lib/RefUpdate.java        |   26 +++++++++++++-------
 1 files changed, 17 insertions(+), 9 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/RefUpdate.java b/org.spearce.jgit/src/org/spearce/jgit/lib/RefUpdate.java
index 8dffed2..8226e10 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/RefUpdate.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/RefUpdate.java
@@ -449,15 +449,8 @@ private Result updateImpl(final RevWalk walk, final Store store)
 		RevObject newObj;
 		RevObject oldObj;
 
-		int lastSlash = getName().lastIndexOf('/');
-		if (lastSlash > 0)
-			if (db.getRepository().getRef(getName().substring(0, lastSlash)) != null)
-				return Result.LOCK_FAILURE;
-		String rName = getName() + "/";
-		for (Ref r : db.getAllRefs().values()) {
-			if (r.getName().startsWith(rName))
-				return Result.LOCK_FAILURE;
-		}
+		if (isNameConflicting())
+			return Result.LOCK_FAILURE;
 		lock = new LockFile(looseFile);
 		if (!lock.lock())
 			return Result.LOCK_FAILURE;
@@ -490,6 +483,21 @@ private Result updateImpl(final RevWalk walk, final Store store)
 		}
 	}
 
+	private boolean isNameConflicting() throws IOException {
+		final String myName = getName();
+		final int lastSlash = myName.lastIndexOf('/');
+		if (lastSlash > 0)
+			if (db.getRepository().getRef(myName.substring(0, lastSlash)) != null)
+				return true;
+
+		final String rName = myName + "/";
+		for (Ref r : db.getAllRefs().values()) {
+			if (r.getName().startsWith(rName))
+				return true;
+		}
+		return false;
+	}
+
 	private static RevObject safeParse(final RevWalk rw, final AnyObjectId id)
 			throws IOException {
 		try {
-- 
1.6.4.1.341.gf2a44
