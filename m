From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [PATCH] Fix compare at project level, non-root project
Date: Mon, 19 Mar 2007 01:19:09 +0100
Message-ID: <20070319001909.29489.55145.stgit@lathund.dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: spearce@spearce.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 19 01:17:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HT5Z9-0004sp-Ue
	for gcvg-git@gmane.org; Mon, 19 Mar 2007 01:17:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964838AbXCSARe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 18 Mar 2007 20:17:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964930AbXCSARe
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Mar 2007 20:17:34 -0400
Received: from [83.140.172.130] ([83.140.172.130]:8104 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S964838AbXCSARe (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Mar 2007 20:17:34 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id A77B0802855;
	Mon, 19 Mar 2007 01:12:11 +0100 (CET)
Received: from dewire.com ([127.0.0.1])
 by localhost (torino [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 20131-01; Mon, 19 Mar 2007 01:12:06 +0100 (CET)
Received: from lathund.dewire.com (unknown [10.9.0.3])
	by dewire.com (Postfix) with ESMTP id 53988800199;
	Mon, 19 Mar 2007 01:12:01 +0100 (CET)
Received: from localhost (lathund.dewire.com [127.0.0.1])
	by lathund.dewire.com (Postfix) with ESMTP id 92A2229059;
	Mon, 19 Mar 2007 01:19:35 +0100 (CET)
X-Virus-Scanned: amavisd-new at localhost.localdomain
Received: from lathund.dewire.com ([127.0.0.1])
	by localhost (lathund.dewire.com [127.0.0.1]) (amavisd-new, port 10025)
	with LMTP id BTmp-E0pVv18; Mon, 19 Mar 2007 01:19:14 +0100 (CET)
Received: from lathund.dewire.com (lathund.dewire.com [127.0.0.1])
	by lathund.dewire.com (Postfix) with ESMTP id E095F29030;
	Mon, 19 Mar 2007 01:19:09 +0100 (CET)
User-Agent: StGIT/0.12
X-Virus-Scanned: by amavisd-new at dewire.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42547>

Compare didn't work at the project level when the project wasn't
the same as the git working directory, i.e. egit itself.

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---

 .../core/internal/mapping/GitFileRevision.java     |   11 ++++++++---
 1 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/org.spearce.egit.core/src/org/spearce/egit/core/internal/mapping/GitFileRevision.java b/org.spearce.egit.core/src/org/spearce/egit/core/internal/mapping/GitFileRevision.java
index 7b726f7..def142f 100644
--- a/org.spearce.egit.core/src/org/spearce/egit/core/internal/mapping/GitFileRevision.java
+++ b/org.spearce.egit.core/src/org/spearce/egit/core/internal/mapping/GitFileRevision.java
@@ -150,9 +150,14 @@ public class GitFileRevision extends FileRevision {
 			tree = repositoryMapping.getRepository().mapTree(getCommit().getTreeId());
 			String prefix = repositoryMapping.getSubset();
 			if (prefix != null) {
-				prefix = prefix + "/";
-				String name = prefix + resource.getProjectRelativePath().toString();
-				return tree.findMember(name);
+				String relPath = resource.getProjectRelativePath().toString();
+				if (relPath.equals(""))
+					return tree;
+				else {
+					prefix = prefix + "/";
+					String name = prefix + relPath;
+					return tree.findMember(name);
+				}
 			} else
 				return tree;
 		} catch (IOException e) {
