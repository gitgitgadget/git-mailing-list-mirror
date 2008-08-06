From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [EGIT PATCH 2/5] Don't crash the decorator update loop when resources are deleted
Date: Tue,  5 Aug 2008 20:09:37 -0700
Message-ID: <1217992180-5697-3-git-send-email-spearce@spearce.org>
References: <1217992180-5697-1-git-send-email-spearce@spearce.org>
 <1217992180-5697-2-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>,
	Marek Zawirski <marek.zawirski@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 06 05:10:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KQZQJ-0005ZC-8M
	for gcvg-git-2@gmane.org; Wed, 06 Aug 2008 05:10:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753644AbYHFDJr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Aug 2008 23:09:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761577AbYHFDJp
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Aug 2008 23:09:45 -0400
Received: from george.spearce.org ([209.20.77.23]:47471 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752387AbYHFDJn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Aug 2008 23:09:43 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 8C73138446; Wed,  6 Aug 2008 03:09:42 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id D2EC438420;
	Wed,  6 Aug 2008 03:09:41 +0000 (UTC)
X-Mailer: git-send-email 1.6.0.rc1.250.g9b5e2
In-Reply-To: <1217992180-5697-2-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91478>

If a resource is deleted from the workspace we don't need to clear
its GITFOLDERDIRTYSTATEPROPERTY from the item because it is gone.
There won't be anyone else to query for that flag, so the flag is
not relevant anymore.  Further trying to call accept() on those
resources throws an exception because Eclipse won't let you touch
a deleted resource.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../internal/decorators/GitResourceDecorator.java  |   11 +++++++++--
 1 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/decorators/GitResourceDecorator.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/decorators/GitResourceDecorator.java
index 6d2f88e..84ad949 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/decorators/GitResourceDecorator.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/decorators/GitResourceDecorator.java
@@ -126,6 +126,14 @@ public class GitResourceDecorator extends LabelProvider implements
 						Iterator<IResource> i = resources.iterator();
 						m = i.next();
 						i.remove();
+
+						while (!m.isAccessible()) {
+							if (!i.hasNext())
+								return Status.OK_STATUS;
+							m = i.next();
+							i.remove();
+						}
+
 						if (resources.size() > 0)
 							schedule();
 					}
@@ -188,8 +196,7 @@ public class GitResourceDecorator extends LabelProvider implements
 	} // End ResCL
 
 	void clearDecorationState(IResource r) throws CoreException {
-		if (r.isAccessible())
-			r.setSessionProperty(GITFOLDERDIRTYSTATEPROPERTY, null);
+		r.setSessionProperty(GITFOLDERDIRTYSTATEPROPERTY, null);
 		fireLabelProviderChanged(new LabelProviderChangedEvent(this, r));
 	}
 
-- 
1.6.0.rc1.250.g9b5e2
