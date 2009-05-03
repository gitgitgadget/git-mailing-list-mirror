From: Ferry Huberts <ferry.huberts@pelagic.nl>
Subject: [EGIT PATCH 1/1] Micro optimise getting ignored status of a resource
Date: Sun,  3 May 2009 10:41:56 +0200
Message-ID: <9850c6445ac62a8ed8c76282b07f8a2cf8064e8f.1241339812.git.ferry.huberts@pelagic.nl>
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Robin Rosenberg <robin.rosenberg@dewire.com>,
	Ferry Huberts <ferry.huberts@pelagic.nl>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 03 10:43:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M0XIV-0005Po-Nh
	for gcvg-git-2@gmane.org; Sun, 03 May 2009 10:43:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753711AbZECImA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 May 2009 04:42:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752971AbZECIl7
	(ORCPT <rfc822;git-outgoing>); Sun, 3 May 2009 04:41:59 -0400
Received: from hupie.xs4all.nl ([82.95.241.251]:40260 "EHLO
	Lighthouse.internal.Hupie.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752845AbZECIl6 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 3 May 2009 04:41:58 -0400
Received: from localhost.localdomain (Paul.internal.Hupie.com [192.168.0.50])
	by Lighthouse.internal.Hupie.com (Postfix) with ESMTP id 40FC058BD9F;
	Sun,  3 May 2009 10:41:57 +0200 (CEST)
X-Mailer: git-send-email 1.6.0.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118170>

Do not evaluate getting the ignored status of a resource twice
when once is enough.

Signed-off-by: Ferry Huberts <ferry.huberts@pelagic.nl>
---
 .../org/spearce/egit/core/op/TrackOperation.java   |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/org.spearce.egit.core/src/org/spearce/egit/core/op/TrackOperation.java b/org.spearce.egit.core/src/org/spearce/egit/core/op/TrackOperation.java
index 29b4344..5f80698 100644
--- a/org.spearce.egit.core/src/org/spearce/egit/core/op/TrackOperation.java
+++ b/org.spearce.egit.core/src/org/spearce/egit/core/op/TrackOperation.java
@@ -94,14 +94,15 @@ public boolean visit(IResource resource) throws CoreException {
 									// first. If a resource within a ignored folder is marked
 									// we ignore it here, i.e. there is no way to unmark it expect
 									// by explicitly selecting and invoking track on it.
+									boolean isIgnored = Team.isIgnoredHint(resource);
 									if (resource.getType() == IResource.FILE) {
 										Entry entry = index.getEntry(repoPath);
-										if (!Team.isIgnoredHint(resource) || entry != null && entry.isAssumedValid()) {
+										if (!isIgnored || entry != null && entry.isAssumedValid()) {
 											entry = index.add(rm.getWorkDir(), new File(rm.getWorkDir(), repoPath));
 											entry.setAssumeValid(false);
 										}
 									}
-									if (Team.isIgnoredHint(resource))
+									if (isIgnored)
 										return false;
 
 								} catch (IOException e) {
-- 
1.6.0.6
