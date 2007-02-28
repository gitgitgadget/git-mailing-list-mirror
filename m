From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [EGIT PATCH 3/9] Use mmap per default.
Date: Wed, 28 Feb 2007 23:26:21 +0100
Message-ID: <20070228222621.12021.65339.stgit@lathund.dewire.com>
References: <20070228222355.12021.13029.stgit@lathund.dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 28 23:33:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMXMw-0003dk-C4
	for gcvg-git@gmane.org; Wed, 28 Feb 2007 23:33:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750970AbXB1Wca (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 28 Feb 2007 17:32:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752163AbXB1Wc1
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Feb 2007 17:32:27 -0500
Received: from [83.140.172.130] ([83.140.172.130]:1435 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S932580AbXB1WcK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Feb 2007 17:32:10 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id E9D018033A4
	for <git@vger.kernel.org>; Wed, 28 Feb 2007 23:27:04 +0100 (CET)
Received: from dewire.com ([127.0.0.1])
 by localhost (torino [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 18351-07 for <git@vger.kernel.org>; Wed, 28 Feb 2007 23:27:04 +0100 (CET)
Received: from lathund.dewire.com (unknown [10.9.0.5])
	by dewire.com (Postfix) with ESMTP id 1442D8033A9
	for <git@vger.kernel.org>; Wed, 28 Feb 2007 23:27:02 +0100 (CET)
Received: from localhost (lathund.dewire.com [127.0.0.1])
	by lathund.dewire.com (Postfix) with ESMTP id B3A0E29868
	for <git@vger.kernel.org>; Wed, 28 Feb 2007 23:26:21 +0100 (CET)
X-Virus-Scanned: amavisd-new at localhost.localdomain
Received: from lathund.dewire.com ([127.0.0.1])
	by localhost (lathund.dewire.com [127.0.0.1]) (amavisd-new, port 10025)
	with LMTP id n5HO2Zd5OK1a for <git@vger.kernel.org>;
	Wed, 28 Feb 2007 23:26:21 +0100 (CET)
Received: from lathund.dewire.com (lathund.dewire.com [127.0.0.1])
	by lathund.dewire.com (Postfix) with ESMTP id 7C0F229859
	for <git@vger.kernel.org>; Wed, 28 Feb 2007 23:26:21 +0100 (CET)
In-Reply-To: <20070228222355.12021.13029.stgit@lathund.dewire.com>
User-Agent: StGIT/0.11
X-Virus-Scanned: by amavisd-new at dewire.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41020>

A small test of mine show a tenfold speed improvemnt looking for a blob
while scanning the history (11K commit, blob three trees down). This was
on a x86 platform. For other platforms Shawn noted that memory mapping
was about 10% slower than normall reading of files.

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---

 .../src/org/spearce/jgit/lib/PackFile.java         |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/PackFile.java b/org.spearce.jgit/src/org/spearce/jgit/lib/PackFile.java
index ee4b8a1..d33aa97 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/PackFile.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/PackFile.java
@@ -42,7 +42,7 @@ public class PackFile {
 		repo = parentRepo;
 		// FIXME window size and mmap type should be configurable
 		pack = new WindowedFile(repo.getWindowCache(), packFile,
-				64 * 1024 * 1024, false);
+				64 * 1024 * 1024, true);
 		try {
 			readPackHeader();
 
@@ -53,7 +53,7 @@ public class PackFile {
 					+ ".idx");
 			// FIXME window size and mmap type should be configurable
 			idx = new WindowedFile(repo.getWindowCache(), idxFile,
-					64 * 1024 * 1024, false);
+					64 * 1024 * 1024, true);
 			try {
 				idxHeader = readIndexHeader();
 			} catch (IOException ioe) {
