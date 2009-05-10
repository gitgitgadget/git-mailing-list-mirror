From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH] Create $GIT_DIR/objects/pack if missing during
	renameAndOpenPack
Date: Sun, 10 May 2009 14:30:46 -0700
Message-ID: <20090510213046.GC30527@spearce.org>
References: <693615.98383.qm@web27802.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Mark Struberg <struberg@yahoo.de>,
	Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Sun May 10 23:30:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M3Gbm-0005Um-SR
	for gcvg-git-2@gmane.org; Sun, 10 May 2009 23:30:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755202AbZEJVar (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 May 2009 17:30:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754186AbZEJVaq
	(ORCPT <rfc822;git-outgoing>); Sun, 10 May 2009 17:30:46 -0400
Received: from george.spearce.org ([209.20.77.23]:45338 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754645AbZEJVap (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 May 2009 17:30:45 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 8628B381D5; Sun, 10 May 2009 21:30:46 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <693615.98383.qm@web27802.mail.ukl.yahoo.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118749>

Its OK for the objects/pack directory to be missing, an empty
repository doesn't have to have it.  C Git's `git repack` will
automatically create the directory if it is not present, so we
need to do the same behavior here.

When the directory doesn't exist, we try to create it, but we
may have creation fail if another concurrent thread/process also
made the directory at the same time, hence we test once more after
creation failure before throwing the exception.

Found-by: Mark Struberg <struberg@yahoo.de>
Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
  Mark Struberg <struberg@yahoo.de> wrote:
  > 
  > If I use jgit to push to this repo it crashes because it cannot write to the pack folder. If I
  > mkdir the object/pack folder in my origin repo, everything runs smooth.
  
  Yea, that's legal.  This patch should fix it.
  
 .../src/org/spearce/jgit/transport/IndexPack.java  |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/IndexPack.java b/org.spearce.jgit/src/org/spearce/jgit/transport/IndexPack.java
index b2bcbb7..1eb40d4 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/IndexPack.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/IndexPack.java
@@ -1037,6 +1037,14 @@ public PackLock renameAndOpenPack(final String lockMessage)
 		final File finalIdx = new File(packDir, "pack-" + name + ".idx");
 		final PackLock keep = new PackLock(finalPack);
 
+		if (!packDir.exists() && !packDir.mkdir() && !packDir.exists()) {
+			// The objects/pack directory isn't present, and we are unable
+			// to create it. There is no way to move this pack in.
+			//
+			cleanupTemporaryFiles();
+			throw new IOException("Cannot create " + packDir.getAbsolutePath());
+		}
+
 		if (finalPack.exists()) {
 			// If the pack is already present we should never replace it.
 			//
-- 
1.6.3.195.gad81
