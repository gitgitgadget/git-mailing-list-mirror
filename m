From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [EGIT PATCH 4/9] Add a method to listen to changes in any repository
Date: Fri, 11 Jul 2008 00:40:46 +0200
Message-ID: <1215729651-26781-5-git-send-email-robin.rosenberg@dewire.com>
References: <1215729651-26781-1-git-send-email-robin.rosenberg@dewire.com>
 <1215729651-26781-2-git-send-email-robin.rosenberg@dewire.com>
 <1215729651-26781-3-git-send-email-robin.rosenberg@dewire.com>
 <1215729651-26781-4-git-send-email-robin.rosenberg@dewire.com>
Cc: git@vger.kernel.org, Marek Zawirski <marek.zawirski@gmail.com>,
	Robin Rosenberg <robin.rosenberg@dewire.com>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Jul 11 00:47:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KH4vU-0004Lo-Hd
	for gcvg-git-2@gmane.org; Fri, 11 Jul 2008 00:47:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754436AbYGJWqH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jul 2008 18:46:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754383AbYGJWqG
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Jul 2008 18:46:06 -0400
Received: from [83.140.172.130] ([83.140.172.130]:13125 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1754256AbYGJWqB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jul 2008 18:46:01 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id ABE0C802E18;
	Fri, 11 Jul 2008 00:46:00 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id W2nXZeGZqwA1; Fri, 11 Jul 2008 00:45:59 +0200 (CEST)
Received: from localhost.localdomain (unknown [10.9.0.3])
	by dewire.com (Postfix) with ESMTP id 4C7948030C5;
	Fri, 11 Jul 2008 00:45:58 +0200 (CEST)
X-Mailer: git-send-email 1.5.6.2.220.g44701
In-Reply-To: <1215729651-26781-4-git-send-email-robin.rosenberg@dewire.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88030>

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---
 .../src/org/spearce/jgit/lib/Repository.java       |   31 +++++++++++++++++--
 1 files changed, 27 insertions(+), 4 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java b/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java
index 6f78652..dfa3045 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java
@@ -95,6 +95,7 @@ public class Repository {
 	private GitIndex index;
 
 	private List<RepositoryListener> listeners = new Vector<RepositoryListener>(); // thread safe
+	static private List<RepositoryListener> allListeners = new Vector<RepositoryListener>(); // thread safe
 
 	/**
 	 * Construct a representation of a Git repository.
@@ -1051,12 +1052,32 @@ public class Repository {
 		listeners.remove(l);
 	}
 
+	/**
+	 * Register a global {@link RepositoryListener} which will be notified
+	 * when a ref changes in any repository are detected.
+	 *
+	 * @param l
+	 */
+	public static void addAnyRepositoryChangedListener(final RepositoryListener l) {
+		allListeners.add(l);
+	}
+
+	/**
+	 * Remove a globally registered {@link RepositoryListener}
+	 * @param l
+	 */
+	public static void removeAnyRepositoryChangedListener(final RepositoryListener l) {
+		allListeners.remove(l);
+	}
+
 	void fireRefsMaybeChanged() {
 		if (refs.lastRefModification != refs.lastNotifiedRefModification) {
 			refs.lastNotifiedRefModification = refs.lastRefModification;
 			final RefsChangedEvent event = new RefsChangedEvent(this);
-			for (final RepositoryListener l :
-				listeners.toArray(new RepositoryListener[listeners.size()])) {
+			List<RepositoryListener> all = new ArrayList<RepositoryListener>(
+					listeners);
+			all.addAll(allListeners);
+			for (final RepositoryListener l : all) {
 				l.refsChanged(event);
 			}
 		}
@@ -1064,8 +1085,10 @@ public class Repository {
 
 	void fireIndexChanged() {
 		final IndexChangedEvent event = new IndexChangedEvent(this);
-		for (final RepositoryListener l :
-			listeners.toArray(new RepositoryListener[listeners.size()])) {
+		List<RepositoryListener> all = new ArrayList<RepositoryListener>(
+				listeners);
+		all.addAll(allListeners);
+		for (final RepositoryListener l : all) {
 			l.indexChanged(event);
 		}
 	}
-- 
1.5.6.2.220.g44701
