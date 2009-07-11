From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 02/11] Make Daemon's exportAll check not require synchronization
Date: Sat, 11 Jul 2009 13:19:17 -0700
Message-ID: <1247343566-19025-3-git-send-email-spearce@spearce.org>
References: <1247343566-19025-1-git-send-email-spearce@spearce.org>
 <1247343566-19025-2-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Sat Jul 11 22:19:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MPj2x-0003MO-Rx
	for gcvg-git-2@gmane.org; Sat, 11 Jul 2009 22:19:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751691AbZGKUTh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 Jul 2009 16:19:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750716AbZGKUTf
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Jul 2009 16:19:35 -0400
Received: from george.spearce.org ([209.20.77.23]:39694 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750729AbZGKUT2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Jul 2009 16:19:28 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 648053821F; Sat, 11 Jul 2009 20:19:28 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id A415F38194;
	Sat, 11 Jul 2009 20:19:27 +0000 (UTC)
X-Mailer: git-send-email 1.6.4.rc0.117.g28cb
In-Reply-To: <1247343566-19025-2-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123118>

A volatile boolean can be read more efficiently than using a
synchronized monitor on "this", as it only requires that the
load of the boolean be examining the most recent copy from the
memory bus.  Since the value of the boolean has no further
impact on the object state, we don't need to worry about more
than ensuring we see the current value of it.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../src/org/spearce/jgit/transport/Daemon.java     |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/Daemon.java b/org.spearce.jgit/src/org/spearce/jgit/transport/Daemon.java
index d3f7b2e..7b4c138 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/Daemon.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/Daemon.java
@@ -67,7 +67,7 @@
 
 	private final ThreadGroup processors;
 
-	private boolean exportAll;
+	private volatile boolean exportAll;
 
 	private Map<String, Repository> exports;
 
@@ -164,7 +164,7 @@ public synchronized DaemonService getService(String name) {
 	 *         ignored.
 	 * @see #setExportAll(boolean)
 	 */
-	public synchronized boolean isExportAll() {
+	public boolean isExportAll() {
 		return exportAll;
 	}
 
@@ -180,7 +180,7 @@ public synchronized boolean isExportAll() {
 	 *
 	 * @param export
 	 */
-	public synchronized void setExportAll(final boolean export) {
+	public void setExportAll(final boolean export) {
 		exportAll = export;
 	}
 
-- 
1.6.4.rc0.117.g28cb
