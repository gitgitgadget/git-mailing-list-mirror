From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [PATCH 4/4] Add a method to listen to changes in any repository
Date: Fri, 11 Jul 2008 11:48:39 +0200
Message-ID: <1215769719-5238-1-git-send-email-robin.rosenberg@dewire.com>
References: <20080711042822.GC32633@spearce.org>
Cc: git@vger.kernel.org, Marek Zawirski <marek.zawirski@gmail.com>,
	Robin Rosenberg <robin.rosenberg@dewire.com>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Jul 11 11:54:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KHFKz-0000K1-Lc
	for gcvg-git-2@gmane.org; Fri, 11 Jul 2008 11:54:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752515AbYGKJxx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jul 2008 05:53:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752430AbYGKJxx
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Jul 2008 05:53:53 -0400
Received: from [83.140.172.130] ([83.140.172.130]:15325 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1752278AbYGKJxw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jul 2008 05:53:52 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 199318027F7;
	Fri, 11 Jul 2008 11:53:51 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id j37R8Bu7vWEJ; Fri, 11 Jul 2008 11:53:50 +0200 (CEST)
Received: from localhost.localdomain (unknown [10.9.0.3])
	by dewire.com (Postfix) with ESMTP id 65CC28006B7;
	Fri, 11 Jul 2008 11:53:48 +0200 (CEST)
X-Mailer: git-send-email 1.5.6.2.220.g44701
In-Reply-To: <20080711042822.GC32633@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88104>

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---
 .../src/org/spearce/jgit/lib/Repository.java       |   39 ++++++++++++++++++--
 1 files changed, 35 insertions(+), 4 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java b/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java
index 52f6750..af860b3 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java
@@ -95,6 +95,7 @@ public class Repository {
 	private GitIndex index;
 
 	private List<RepositoryListener> listeners = new Vector<RepositoryListener>(); // thread safe
+	static private List<RepositoryListener> allListeners = new Vector<RepositoryListener>(); // thread safe
 
 	/**
 	 * Construct a representation of a Git repository.
@@ -1051,12 +1052,36 @@ public class Repository {
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
-				listeners.toArray(new RepositoryListener[0])) {
+			List<RepositoryListener> all;
+			synchronized (listeners) {
+				all = new ArrayList<RepositoryListener>(listeners);
+			}
+			synchronized (allListeners) {
+				all.addAll(allListeners);
+			}
+			for (final RepositoryListener l : all) {
 				l.refsChanged(event);
 			}
 		}
@@ -1064,8 +1089,14 @@ public class Repository {
 
 	void fireIndexChanged() {
 		final IndexChangedEvent event = new IndexChangedEvent(this);
-		for (final RepositoryListener l :
-			listeners.toArray(new RepositoryListener[0])) {
+		List<RepositoryListener> all;
+		synchronized (listeners) {
+			all = new ArrayList<RepositoryListener>(listeners);
+		}
+		synchronized (allListeners) {
+			all.addAll(allListeners);
+		}
+		for (final RepositoryListener l : all) {
 			l.indexChanged(event);
 		}
 	}
-- 
1.5.6.2.220.g44701
