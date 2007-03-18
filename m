From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [PATCH 3/4] Decode message when encoding line is present
Date: Sun, 18 Mar 2007 23:16:07 +0100
Message-ID: <20070318221607.24742.44802.stgit@lathund.dewire.com>
References: <20070318220711.24742.90943.stgit@lathund.dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: spearce@spearce.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 18 23:14:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HT3dm-0000W6-BT
	for gcvg-git@gmane.org; Sun, 18 Mar 2007 23:14:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933332AbXCRWOI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 18 Mar 2007 18:14:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933344AbXCRWOI
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Mar 2007 18:14:08 -0400
Received: from [83.140.172.130] ([83.140.172.130]:7602 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S933332AbXCRWOH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Mar 2007 18:14:07 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 2B9A6802855;
	Sun, 18 Mar 2007 23:08:45 +0100 (CET)
Received: from dewire.com ([127.0.0.1])
 by localhost (torino [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 18505-05; Sun, 18 Mar 2007 23:08:44 +0100 (CET)
Received: from lathund.dewire.com (unknown [10.9.0.3])
	by dewire.com (Postfix) with ESMTP id D6609802664;
	Sun, 18 Mar 2007 23:08:44 +0100 (CET)
Received: from localhost (lathund.dewire.com [127.0.0.1])
	by lathund.dewire.com (Postfix) with ESMTP id DA61B28D37;
	Sun, 18 Mar 2007 23:16:20 +0100 (CET)
X-Virus-Scanned: amavisd-new at localhost.localdomain
Received: from lathund.dewire.com ([127.0.0.1])
	by localhost (lathund.dewire.com [127.0.0.1]) (amavisd-new, port 10025)
	with LMTP id 04WLAUPRHcbi; Sun, 18 Mar 2007 23:16:08 +0100 (CET)
Received: from lathund.dewire.com (lathund.dewire.com [127.0.0.1])
	by lathund.dewire.com (Postfix) with ESMTP id 9CB7F28E10;
	Sun, 18 Mar 2007 23:16:07 +0100 (CET)
In-Reply-To: <20070318220711.24742.90943.stgit@lathund.dewire.com>
User-Agent: StGIT/0.12
X-Virus-Scanned: by amavisd-new at dewire.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42533>

Seems we left the newline between the encoding and the rest
of the message

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---

 .../src/org/spearce/jgit/lib/Commit.java           |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/Commit.java b/org.spearce.jgit/src/org/spearce/jgit/lib/Commit.java
index 4356149..c5c65c4 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/Commit.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/Commit.java
@@ -161,16 +161,18 @@ public class Commit implements Treeish {
 				}
 				byte[] readBuf = new byte[br.available()]; // in-memory stream so this is all bytes left
 				br.read(readBuf);
+				int msgstart = readBuf[0] == '\n' ? 1 : 0;
+					
 				if (encoding != null) {
 					// TODO: this isn't reliable so we need to guess the encoding from the actual content
 					author = new PersonIdent(new String(rawAuthor.getBytes(),encoding.name()));
 					committer = new PersonIdent(new String(rawCommitter.getBytes(),encoding.name()));
-					message = new String(readBuf,encoding.name());
+					message = new String(readBuf,msgstart, readBuf.length-msgstart, encoding.name());
 				} else {
 					// TODO: use config setting / platform / ascii / iso-latin
 					author = new PersonIdent(new String(rawAuthor.getBytes()));
 					committer = new PersonIdent(new String(rawCommitter.getBytes()));
-					message = new String(readBuf);
+					message = new String(readBuf, msgstart, readBuf.length-msgstart);
 				}
 			} catch (IOException e) {
 				e.printStackTrace();
