From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [EGIT PATCH 2/9] Catch mmap errors and retry.
Date: Wed, 28 Feb 2007 23:26:16 +0100
Message-ID: <20070228222615.12021.4058.stgit@lathund.dewire.com>
References: <20070228222355.12021.13029.stgit@lathund.dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 28 23:32:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMXLc-0002xY-OC
	for gcvg-git@gmane.org; Wed, 28 Feb 2007 23:32:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932600AbXB1WcP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 28 Feb 2007 17:32:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932583AbXB1WcM
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Feb 2007 17:32:12 -0500
Received: from [83.140.172.130] ([83.140.172.130]:1424 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S932570AbXB1WcJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Feb 2007 17:32:09 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 3D814802E1C
	for <git@vger.kernel.org>; Wed, 28 Feb 2007 23:27:03 +0100 (CET)
Received: from dewire.com ([127.0.0.1])
 by localhost (torino [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 18378-03 for <git@vger.kernel.org>; Wed, 28 Feb 2007 23:27:02 +0100 (CET)
Received: from lathund.dewire.com (unknown [10.9.0.5])
	by dewire.com (Postfix) with ESMTP id 00AF48033A5
	for <git@vger.kernel.org>; Wed, 28 Feb 2007 23:27:00 +0100 (CET)
Received: from localhost (lathund.dewire.com [127.0.0.1])
	by lathund.dewire.com (Postfix) with ESMTP id 665E729867
	for <git@vger.kernel.org>; Wed, 28 Feb 2007 23:26:16 +0100 (CET)
X-Virus-Scanned: amavisd-new at localhost.localdomain
Received: from lathund.dewire.com ([127.0.0.1])
	by localhost (lathund.dewire.com [127.0.0.1]) (amavisd-new, port 10025)
	with LMTP id To9QeyS5kHeJ for <git@vger.kernel.org>;
	Wed, 28 Feb 2007 23:26:16 +0100 (CET)
Received: from lathund.dewire.com (lathund.dewire.com [127.0.0.1])
	by lathund.dewire.com (Postfix) with ESMTP id 3221929859
	for <git@vger.kernel.org>; Wed, 28 Feb 2007 23:26:16 +0100 (CET)
In-Reply-To: <20070228222355.12021.13029.stgit@lathund.dewire.com>
User-Agent: StGIT/0.11
X-Virus-Scanned: by amavisd-new at dewire.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41018>

At least JDK 1.4 and 1.5 versions can hit an IOException if
memory cannot be mapped. A workaround is to catch the exception
and retry once.

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---

 .../src/org/spearce/jgit/lib/Repository.java       |   19 ++++++++++++++++---
 1 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java b/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java
index c9e8a2d..5e0e89a 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java
@@ -145,9 +145,22 @@ public class Repository {
 						return ol;
 				} catch (IOException ioe) {
 					// This shouldn't happen unless the pack was corrupted
-					// after we opened it. We'll ignore the error as though
-					// the object does not exist in this pack.
-					//
+					// after we opened it or the VM runs out of memory. This is
+					// a know problem with memory mapped I/O in java and have
+					// been noticed with JDK < 1.6. Tell the gc that now is a good
+					// time to collect and try once more.
+					try {
+						System.gc();
+						final ObjectLoader ol = packs[k].get(id, tmp);
+						if (ol != null)
+							return ol;
+					} catch (IOException ioe2) {
+						ioe2.printStackTrace();
+						ioe.printStackTrace();
+						// Still fails.. that's BAD, maybe the pack has
+						// been corrupted after all, or the gc didn't manage
+						// to release enough previously mmaped areas.
+					}
 				}
 			} while (k > 0);
 		}
