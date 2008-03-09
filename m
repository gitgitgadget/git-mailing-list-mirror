From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [EGIT PATCH] Circument situations where Eclipse tries to decorate resources that do not exist
Date: Mon, 10 Mar 2008 00:33:53 +0100
Message-ID: <200803100033.53905.robin.rosenberg@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Mar 10 00:34:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JYV2P-0005uc-21
	for gcvg-git-2@gmane.org; Mon, 10 Mar 2008 00:34:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753318AbYCIXd5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Mar 2008 19:33:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752848AbYCIXd5
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Mar 2008 19:33:57 -0400
Received: from [83.140.172.130] ([83.140.172.130]:28721 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1752464AbYCIXd4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Mar 2008 19:33:56 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 034A7802671;
	Mon, 10 Mar 2008 00:33:55 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GoJWaJ3RJOnr; Mon, 10 Mar 2008 00:33:54 +0100 (CET)
Received: from [10.9.0.7] (unknown [10.9.0.7])
	by dewire.com (Postfix) with ESMTP id 64CFA802655;
	Mon, 10 Mar 2008 00:33:54 +0100 (CET)
User-Agent: KMail/1.9.9
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76685>

This happens when the workspace has not been refreshed properly, e.g.
when switching branches behind Eclipse's back.

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---
 .../internal/decorators/GitResourceDecorator.java  |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

This one seems hard to replicate though I think it shouldn't. Maybe Eclipse refereshes on demand
sometime and sometimes not.  This stacktrace suggests this is the right thing to do.

java.lang.RuntimeException: Resource decorator failed to load tree contents on demand.
        at org.spearce.egit.ui.internal.decorators.GitResourceDecorator.decorate(GitResourceDecorator.java:347)
        at org.eclipse.ui.internal.decorators.LightweightDecoratorDefinition.decorate(LightweightDecoratorDefinition.java:253)
        at org.eclipse.ui.internal.decorators.LightweightDecoratorManager$LightweightRunnable.run(LightweightDecoratorManager.java:71)
        at org.eclipse.core.runtime.SafeRunner.run(SafeRunner.java:37)
        at org.eclipse.core.runtime.Platform.run(Platform.java:857)
        at org.eclipse.ui.internal.decorators.LightweightDecoratorManager.decorate(LightweightDecoratorManager.java:336)
        at org.eclipse.ui.internal.decorators.LightweightDecoratorManager.getDecorations(LightweightDecoratorManager.java:322)
        at org.eclipse.ui.internal.decorators.DecorationScheduler$1.ensureResultCached(DecorationScheduler.java:369)
        at org.eclipse.ui.internal.decorators.DecorationScheduler$1.run(DecorationScheduler.java:329)
        at org.eclipse.core.internal.jobs.Worker.run(Worker.java:55)
Caused by: org.eclipse.core.internal.resources.ResourceException: Resource '/org.spearce.jgit/src/org/spearce/jgit/stgit' does not exist.
        at org.eclipse.core.internal.resources.Resource.checkExists(Resource.java:310)
        at org.eclipse.core.internal.resources.Resource.checkAccessible(Resource.java:193)
        at org.eclipse.core.internal.resources.Resource.getSessionProperty(Resource.java:1079)
        at org.spearce.egit.ui.internal.decorators.GitResourceDecorator.decorate(GitResourceDecorator.java:246)
        ... 9 more

-- robin

diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/decorators/GitResourceDecorator.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/decorators/GitResourceDecorator.java
index 7eb008b..d0f9864 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/decorators/GitResourceDecorator.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/decorators/GitResourceDecorator.java
@@ -225,6 +225,13 @@ public class GitResourceDecorator extends LabelProvider implements
 		if (rsrc == null)
 			return;
 
+		// If the workspace has not been refreshed properly a resource might
+		// not actually exist, so we ignore these and do not decorate them
+		if (!rsrc.exists() && !rsrc.isPhantom()) {
+			Activator.trace("Tried to decorate non-existent resource "+rsrc);
+			return;
+		}
+
 		RepositoryMapping mapped = RepositoryMapping.getMapping(rsrc);
 
 		Activator.trace("decorate: " + element);
-- 
1.5.4.3
