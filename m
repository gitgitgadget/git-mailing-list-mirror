From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: [JGIT PATCH] Egit move/delete bugfix, do not lose files when moving folders
Date: Tue, 8 Jul 2008 23:51:47 +0200
Message-ID: <200807082351.47636.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "'Marek Zawirski'" <marek.zawirski@gmail.com>
To: "'Shawn O. Pearce'" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Jul 08 23:57:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KGLC5-0001mk-AW
	for gcvg-git-2@gmane.org; Tue, 08 Jul 2008 23:57:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751813AbYGHV4q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jul 2008 17:56:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751639AbYGHV4q
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Jul 2008 17:56:46 -0400
Received: from av9-1-sn3.vrr.skanova.net ([81.228.9.185]:37152 "EHLO
	av9-1-sn3.vrr.skanova.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751597AbYGHV4p (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jul 2008 17:56:45 -0400
Received: by av9-1-sn3.vrr.skanova.net (Postfix, from userid 502)
	id 8371137F76; Tue,  8 Jul 2008 23:56:43 +0200 (CEST)
Received: from smtp3-1-sn3.vrr.skanova.net (smtp3-1-sn3.vrr.skanova.net [81.228.9.101])
	by av9-1-sn3.vrr.skanova.net (Postfix) with ESMTP
	id 5153737E5C; Tue,  8 Jul 2008 23:56:43 +0200 (CEST)
Received: from [10.3.4.244] (h250n1fls32o811.telia.com [213.67.100.250])
	by smtp3-1-sn3.vrr.skanova.net (Postfix) with ESMTP id 3628837E46;
	Tue,  8 Jul 2008 23:56:42 +0200 (CEST)
User-Agent: KMail/1.9.9
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87800>

We lied to Eclipse in the move/delete hook and told it we had already
moved a folder. That wasn't true so the original was lost. With this
patch Eclipse will move the code for us, but it is not added to the index.

This is an intermediate fix until we actually manipulate the index properly.

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---

 .../org/spearce/egit/core/GitMoveDeleteHook.java   |   20 +++++++-------------
 1 files changed, 7 insertions(+), 13 deletions(-)

diff --git a/org.spearce.egit.core/src/org/spearce/egit/core/GitMoveDeleteHook.java b/org.spearce.egit.core/src/org/spearce/egit/core/GitMoveDeleteHook.java
index 22a14c4..cc4059c 100644
--- a/org.spearce.egit.core/src/org/spearce/egit/core/GitMoveDeleteHook.java
+++ b/org.spearce.egit.core/src/org/spearce/egit/core/GitMoveDeleteHook.java
@@ -27,7 +27,6 @@ import org.spearce.jgit.lib.GitIndex;
 import org.spearce.jgit.lib.Repository;
 
 class GitMoveDeleteHook implements IMoveDeleteHook {
-	private static final boolean NOT_ALLOWED = true;
 	private static final boolean I_AM_DONE = true;
 
 	private static final boolean FINISH_FOR_ME = false;
@@ -54,7 +53,7 @@ class GitMoveDeleteHook implements IMoveDeleteHook {
 			e.printStackTrace();
 			tree.failed(new Status(IStatus.ERROR, Activator.getPluginId(), 0,
 					CoreText.MoveDeleteHook_operationError, e));
-			return NOT_ALLOWED;
+			return I_AM_DONE;
 		}
 	}
 
@@ -97,7 +96,7 @@ class GitMoveDeleteHook implements IMoveDeleteHook {
 				}
 				tree.failed(new Status(IStatus.ERROR, Activator.getPluginId(),
 						0, "Destination not in a git versioned project", null));
-				return NOT_ALLOWED;
+				return FINISH_FOR_ME;
 			}
 			GitIndex index2 = map2.getRepository().getIndex();
 			tree.standardMoveFile(source, destination, updateFlags, monitor);
@@ -114,7 +113,7 @@ class GitMoveDeleteHook implements IMoveDeleteHook {
 			e.printStackTrace();
 			tree.failed(new Status(IStatus.ERROR, Activator.getPluginId(), 0,
 					CoreText.MoveDeleteHook_operationError, e));
-			return NOT_ALLOWED;
+			return I_AM_DONE;
 
 		}
 	}
@@ -124,25 +123,20 @@ class GitMoveDeleteHook implements IMoveDeleteHook {
 			final IProgressMonitor monitor) {
 		// TODO: Implement this. Should be relatively easy, but consider that
 		// Eclipse thinks folders are real thinsgs, while Git does not care.
-		return NOT_ALLOWED;
+		return FINISH_FOR_ME;
 	}
 
 	public boolean moveProject(final IResourceTree tree, final IProject source,
 			final IProjectDescription description, final int updateFlags,
 			final IProgressMonitor monitor) {
-		// Never allow moving a project as it can complicate updating our
-		// project data with the new repository mappings. To move a project
-		// disconnect the GIT team provider, move the project, then reconnect
-		// the GIT team provider.
-		// We should be able to do this without too much effort when the
+		// TODO: We should be able to do this without too much effort when the
 		// projects belong to the same Git repository.
-		//
-		return NOT_ALLOWED;
+		return FINISH_FOR_ME;
 	}
 
 	private boolean cannotModifyRepository(final IResourceTree tree) {
 		tree.failed(new Status(IStatus.ERROR, Activator.getPluginId(), 0,
 				CoreText.MoveDeleteHook_cannotModifyFolder, null));
-		return NOT_ALLOWED;
+		return I_AM_DONE;
 	}
 }
\ No newline at end of file
-- 
1.5.6.2.220.g44701
