From: "Charles O'Farrell" <charleso@charleso.org>
Subject: [EGIT PATCH] Circumvent situations where Eclipse tries to decorate externally linked resources
Date: Thu, 22 Jan 2009 08:33:51 +1000
Message-ID: <1232577231-3944-1-git-send-email-charleso@charleso.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 21 23:40:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LPlkO-0004Ov-4A
	for gcvg-git-2@gmane.org; Wed, 21 Jan 2009 23:40:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753526AbZAUWjJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Jan 2009 17:39:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753483AbZAUWjH
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Jan 2009 17:39:07 -0500
Received: from mail1.mincom.com ([203.13.90.248]:3187 "EHLO
	bnepms03.mincom.oz.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753436AbZAUWjG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Jan 2009 17:39:06 -0500
X-Greylist: delayed 309 seconds by postgrey-1.27 at vger.kernel.org; Wed, 21 Jan 2009 17:39:06 EST
Received: from portal.mincom.oz.au (unverified [172.17.100.4]) by bnepms03.mincom.oz.au
 (Clearswift SMTPRS 5.2.3) with ESMTP id <T8c09e9d1a1cb0d5af8d80@bnepms03.mincom.oz.au>;
 Thu, 22 Jan 2009 08:42:19 +1000
Received: from bnesrv29.mincom.oz.au (bnesrv29.mincom.oz.au [172.17.65.232])
	by portal.mincom.oz.au (8.12.6/8.9.3/mincom) with ESMTP id n0LMXpKG011226;
	Thu, 22 Jan 2009 08:33:51 +1000 (EST)
	(envelope-from charleso@charleso.org)
Received: from localhost.localdomain (cendhcp119-68.mincom.oz.au [172.17.119.68])
	by bnesrv29.mincom.oz.au (8.11.7p2+Sun/8.11.6) with ESMTP id n0LMXpB09282;
	Thu, 22 Jan 2009 08:33:51 +1000 (EST)
X-Mailer: git-send-email 1.6.1.9.g97c34
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106693>

This occurs in one our projects which has an externally linked folder, which
causes the decorator to die on a NPE. Alternatively rsrc.isLinked() could
have been used, but we allow for linked resources to repository files.

Signed-off-by: Charles O'Farrell <charleso@charleso.org>
---
 .../internal/decorators/GitResourceDecorator.java  |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/decorators/GitResourceDecorator.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/decorators/GitResourceDecorator.java
index c3ae52d..f24b1eb 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/decorators/GitResourceDecorator.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/decorators/GitResourceDecorator.java
@@ -296,6 +296,12 @@ public void decorate(final Object element, final IDecoration decoration) {
 				Repository repository = mapped.getRepository();
 				GitIndex index = repository.getIndex();
 				String repoRelativePath = mapped.getRepoRelativePath(rsrc);
+
+				if (repoRelativePath == null) {
+					Activator.trace("Cannot decorate linked resource " + rsrc);
+					return;
+				}
+
 				Tree headTree = repository.mapTree(Constants.HEAD);
 				TreeEntry blob = headTree!=null ? headTree.findBlobMember(repoRelativePath) : null;
 				Entry entry = index.getEntry(repoRelativePath);
-- 
1.6.1.9.g97c34
