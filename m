From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [PATCH] Distignuish between commit id and key in commit cache
Date: Mon, 12 Mar 2007 18:51:15 +0100
Message-ID: <20070312175115.10884.87646.stgit@lathund.dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: spearce@spearce.org
X-From: git-owner@vger.kernel.org Mon Mar 12 18:49:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HQoeL-0002nx-5C
	for gcvg-git@gmane.org; Mon, 12 Mar 2007 18:49:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751963AbXCLRta (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Mar 2007 13:49:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751880AbXCLRta
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Mar 2007 13:49:30 -0400
Received: from [83.140.172.130] ([83.140.172.130]:9821 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1752119AbXCLRt3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Mar 2007 13:49:29 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 22D5B802841;
	Mon, 12 Mar 2007 18:44:13 +0100 (CET)
Received: from dewire.com ([127.0.0.1])
 by localhost (torino [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 06592-01; Mon, 12 Mar 2007 18:44:12 +0100 (CET)
Received: from lathund.dewire.com (unknown [10.9.0.3])
	by dewire.com (Postfix) with ESMTP id BC4AF802651;
	Mon, 12 Mar 2007 18:44:10 +0100 (CET)
Received: from localhost (lathund.dewire.com [127.0.0.1])
	by lathund.dewire.com (Postfix) with ESMTP id 4917328D96;
	Mon, 12 Mar 2007 18:51:26 +0100 (CET)
X-Virus-Scanned: amavisd-new at localhost.localdomain
Received: from lathund.dewire.com ([127.0.0.1])
	by localhost (lathund.dewire.com [127.0.0.1]) (amavisd-new, port 10025)
	with LMTP id nVrw6+Tiz9Ws; Mon, 12 Mar 2007 18:51:15 +0100 (CET)
Received: from lathund.dewire.com (lathund.dewire.com [127.0.0.1])
	by lathund.dewire.com (Postfix) with ESMTP id 9496428CD4;
	Mon, 12 Mar 2007 18:51:15 +0100 (CET)
User-Agent: StGIT/0.12
X-Virus-Scanned: by amavisd-new at dewire.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42050>

See WeakHashMap documentation. If the key is the same object
as the objectid the keys can never be collected.

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---

 .../src/org/spearce/jgit/lib/Repository.java       |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java b/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java
index f7c470d..8b1f42c 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java
@@ -199,7 +199,9 @@ public class Repository {
 		final byte[] raw = or.getBytes();
 		if (Constants.TYPE_COMMIT.equals(or.getType())) {
 			ret = new Commit(this, id, raw);
-			cache.put(id, ret);
+			// The key must not be the referenced strongly
+			// by the value in WeakHashMaps
+			cache.put(new ObjectId(id.getBytes()), ret);
 			return ret;
 		}
 		throw new IncorrectObjectTypeException(id, Constants.TYPE_COMMIT);
