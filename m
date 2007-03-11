From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [EGIT PATCH 07/10] Return nothing if no version exists for a commit.
Date: Sun, 11 Mar 2007 19:15:53 +0100
Message-ID: <20070311181553.18012.62004.stgit@lathund.dewire.com>
References: <20070311180608.18012.13767.stgit@lathund.dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: spearce@spearce.org
X-From: git-owner@vger.kernel.org Sun Mar 11 19:14:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HQSYp-0006Mj-OM
	for gcvg-git@gmane.org; Sun, 11 Mar 2007 19:14:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933946AbXCKSOP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Mar 2007 14:14:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933947AbXCKSOP
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Mar 2007 14:14:15 -0400
Received: from [83.140.172.130] ([83.140.172.130]:1631 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S933946AbXCKSON (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Mar 2007 14:14:13 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 775F0802841;
	Sun, 11 Mar 2007 19:08:58 +0100 (CET)
Received: from dewire.com ([127.0.0.1])
 by localhost (torino [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 26266-03; Sun, 11 Mar 2007 19:08:56 +0100 (CET)
Received: from lathund.dewire.com (unknown [10.9.0.4])
	by dewire.com (Postfix) with ESMTP id C4580802848;
	Sun, 11 Mar 2007 19:08:56 +0100 (CET)
Received: from localhost (lathund.dewire.com [127.0.0.1])
	by lathund.dewire.com (Postfix) with ESMTP id E9EB1291D6;
	Sun, 11 Mar 2007 19:16:10 +0100 (CET)
X-Virus-Scanned: amavisd-new at localhost.localdomain
Received: from lathund.dewire.com ([127.0.0.1])
	by localhost (lathund.dewire.com [127.0.0.1]) (amavisd-new, port 10025)
	with LMTP id rFVADj6S4cun; Sun, 11 Mar 2007 19:15:59 +0100 (CET)
Received: from lathund.dewire.com (lathund.dewire.com [127.0.0.1])
	by lathund.dewire.com (Postfix) with ESMTP id 28B7E291D8;
	Sun, 11 Mar 2007 19:15:53 +0100 (CET)
In-Reply-To: <20070311180608.18012.13767.stgit@lathund.dewire.com>
User-Agent: StGIT/0.12
X-Virus-Scanned: by amavisd-new at dewire.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41956>

I used a null reference to mean two things, which meant the
working directory version was retrieved for comparing files
when a commit did not include a named blob.

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---

 .../src/org/spearce/egit/core/GitStorage.java      |   17 ++++++++++++-----
 1 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/org.spearce.egit.core/src/org/spearce/egit/core/GitStorage.java b/org.spearce.egit.core/src/org/spearce/egit/core/GitStorage.java
index e53fd83..ce4ff71 100644
--- a/org.spearce.egit.core/src/org/spearce/egit/core/GitStorage.java
+++ b/org.spearce.egit.core/src/org/spearce/egit/core/GitStorage.java
@@ -41,7 +41,10 @@ public class GitStorage implements IStorage {
 
 	private TreeEntry entry;
 
+	private ObjectId treeId;
+
 	public GitStorage(ObjectId treeId, IResource resource) {
+		this.treeId = treeId;
 		this.resource = resource;
 		if (treeId == null)
 			return;
@@ -68,13 +71,17 @@ public class GitStorage implements IStorage {
 
 	public InputStream getContents() throws CoreException {
 		try {
-			if (entry == null) {
+			if (treeId == null) {
 				return ((IFile) resource).getContents();
 			} else {
-				ObjectId id = entry.getId();
-				ObjectLoader reader = entry.getRepository().openBlob(id);
-				byte[] bytes = reader.getBytes();
-				return new ByteArrayInputStream(bytes);
+				if (entry == null)
+					return new ByteArrayInputStream(new byte[0]);
+				else {
+					ObjectId id = entry.getId();
+					ObjectLoader reader = entry.getRepository().openBlob(id);
+					byte[] bytes = reader.getBytes();
+					return new ByteArrayInputStream(bytes);
+				}
 			}
 		} catch (FileNotFoundException e) {
 			throw new ResourceException(IResourceStatus.FAILED_READ_LOCAL,
