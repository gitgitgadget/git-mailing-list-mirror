From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 04/12] Fix Config setInt(..., 0) to store "0" not "0 g"
Date: Tue, 21 Jul 2009 13:19:22 -0700
Message-ID: <1248207570-13880-5-git-send-email-spearce@spearce.org>
References: <1248207570-13880-1-git-send-email-spearce@spearce.org>
 <1248207570-13880-2-git-send-email-spearce@spearce.org>
 <1248207570-13880-3-git-send-email-spearce@spearce.org>
 <1248207570-13880-4-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Tue Jul 21 22:21:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MTLpt-0001jT-1m
	for gcvg-git-2@gmane.org; Tue, 21 Jul 2009 22:21:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756132AbZGUUTf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Jul 2009 16:19:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756123AbZGUUTe
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Jul 2009 16:19:34 -0400
Received: from george.spearce.org ([209.20.77.23]:59248 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756115AbZGUUTd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jul 2009 16:19:33 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 6664638260; Tue, 21 Jul 2009 20:19:33 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 4717438215;
	Tue, 21 Jul 2009 20:19:32 +0000 (UTC)
X-Mailer: git-send-email 1.6.4.rc1.186.g60aa0c
In-Reply-To: <1248207570-13880-4-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123694>

If the value is less than the unit's minimum value, we don't want to
store the value with the unit suffix, but instead must try the next
lower unit's value.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../src/org/spearce/jgit/lib/Config.java           |   24 +++++++++++--------
 1 files changed, 14 insertions(+), 10 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/Config.java b/org.spearce.jgit/src/org/spearce/jgit/lib/Config.java
index 6fbdab9..20f42c4 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/Config.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/Config.java
@@ -60,6 +60,10 @@
  * file.
  */
 public abstract class Config {
+	private static final long KiB = 1024;
+	private static final long MiB = 1024 * KiB;
+	private static final long GiB = 1024 * MiB;
+
 	private boolean fileRead;
 
 	private List<Entry> entries;
@@ -230,13 +234,13 @@ public long getLong(final String section, String subsection,
 		long mul = 1;
 		switch (Character.toLowerCase(n.charAt(n.length() - 1))) {
 		case 'g':
-			mul = 1024 * 1024 * 1024;
+			mul = GiB;
 			break;
 		case 'm':
-			mul = 1024 * 1024;
+			mul = MiB;
 			break;
 		case 'k':
-			mul = 1024;
+			mul = KiB;
 			break;
 		}
 		if (mul > 1)
@@ -473,13 +477,13 @@ public void setInt(final String section, final String subsection,
 	public void setLong(final String section, final String subsection,
 			final String name, final long value) {
 		final String s;
-
-		if ((value % (1024 * 1024 * 1024)) == 0)
-			s = String.valueOf(value / (1024 * 1024 * 1024)) + " g";
-		else if ((value % (1024 * 1024)) == 0)
-			s = String.valueOf(value / (1024 * 1024)) + " m";
-		else if ((value % 1024) == 0)
-			s = String.valueOf(value / 1024) + " k";
+		
+		if (value >= GiB && (value % GiB) == 0)
+			s = String.valueOf(value / GiB) + " g";
+		else if (value >= MiB && (value % MiB) == 0)
+			s = String.valueOf(value / MiB) + " m";
+		else if (value >= KiB && (value % KiB) == 0)
+			s = String.valueOf(value / KiB) + " k";
 		else
 			s = String.valueOf(value);
 
-- 
1.6.4.rc1.186.g60aa0c
