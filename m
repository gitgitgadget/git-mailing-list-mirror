From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [EGIT PATCH 2/6] Cleanup unboxing/boxing
Date: Tue,  5 Feb 2008 01:15:30 +0100
Message-ID: <1202170534-15788-3-git-send-email-robin.rosenberg@dewire.com>
References: <1202170534-15788-1-git-send-email-robin.rosenberg@dewire.com>
 <1202170534-15788-2-git-send-email-robin.rosenberg@dewire.com>
Cc: "Roger C. Soares" <rogersoares@intelinet.com.br>,
	Dave Watson <dwatson@mimvista.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Robin Rosenberg <robin.rosenberg@dewire.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 05 01:43:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JMBtr-0001DL-Tg
	for gcvg-git-2@gmane.org; Tue, 05 Feb 2008 01:43:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757412AbYBEAmN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Feb 2008 19:42:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757330AbYBEAmN
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Feb 2008 19:42:13 -0500
Received: from [83.140.172.130] ([83.140.172.130]:18378 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1757542AbYBEAmF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Feb 2008 19:42:05 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id AC153800692;
	Tue,  5 Feb 2008 01:15:42 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id a6xCH3lLsaQ5; Tue,  5 Feb 2008 01:15:40 +0100 (CET)
Received: from lathund.dewire.com (unknown [10.9.0.4])
	by dewire.com (Postfix) with ESMTP id 1E33B80068F;
	Tue,  5 Feb 2008 01:15:34 +0100 (CET)
Received: by lathund.dewire.com (Postfix, from userid 500)
	id 1B256290EE; Tue,  5 Feb 2008 01:15:34 +0100 (CET)
X-Mailer: git-send-email 1.5.4.rc4.25.g81cc
In-Reply-To: <1202170534-15788-2-git-send-email-robin.rosenberg@dewire.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72595>

These operation are relatively expensive in general so it is good to make them
visible, but when they are needed a lot we just want to do without explicit conversion
so we ignore the warning there.

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---
 .../src/org/spearce/egit/ui/GitHistoryPage.java    |    1 +
 .../internal/decorators/GitResourceDecorator.java  |   10 +++++-----
 .../tst/org/spearce/jgit/lib/LaneTest.java         |    1 +
 .../tst/org/spearce/jgit/lib/SuperListTest.java    |    1 +
 .../src/org/spearce/jgit/lib/PersonIdent.java      |    2 +-
 5 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/GitHistoryPage.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/GitHistoryPage.java
index 812747d..2fc7afa 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/GitHistoryPage.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/GitHistoryPage.java
@@ -864,6 +864,7 @@ public class GitHistoryPage extends HistoryPage implements IAdaptable,
 //				SWT.COLOR_WHITE,
 				SWT.COLOR_YELLOW
 			};
+			@SuppressWarnings("boxing")
 			public void handleEvent(Event event) {
 				TableItem item = (TableItem) event.item;
 				if (event.index == 0) {
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/decorators/GitResourceDecorator.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/decorators/GitResourceDecorator.java
index c13c38a..7eb008b 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/decorators/GitResourceDecorator.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/decorators/GitResourceDecorator.java
@@ -207,7 +207,7 @@ public class GitResourceDecorator extends LabelProvider implements
 					return Boolean.FALSE;
 				}
 
-				return mapped.isResourceChanged(rsrc);
+				return new Boolean(mapped.isResourceChanged(rsrc));
 			}
 			return null; // not mapped
 		} catch (CoreException e) {
@@ -244,8 +244,8 @@ public class GitResourceDecorator extends LabelProvider implements
 						if (rsrc instanceof IContainer) {
 							Integer df = (Integer) rsrc
 									.getSessionProperty(GITFOLDERDIRTYSTATEPROPERTY);
-							Boolean f = df == null ? isDirty(rsrc) : df
-									.intValue() == CHANGED;
+							Boolean f = df == null ? isDirty(rsrc)
+									: new Boolean(df.intValue() == CHANGED);
 							if (f != null) {
 								if (f.booleanValue()) {
 									decoration.addPrefix(">"); // Have not
@@ -358,7 +358,7 @@ public class GitResourceDecorator extends LabelProvider implements
 		try {
 			Integer dirty = (Integer) rsrc.getSessionProperty(GITFOLDERDIRTYSTATEPROPERTY);
 			if (dirty == null) {
-				rsrc.setSessionProperty(GITFOLDERDIRTYSTATEPROPERTY, flag);
+				rsrc.setSessionProperty(GITFOLDERDIRTYSTATEPROPERTY, new Integer(flag));
 				Activator.trace("SETTING:"+rsrc.getFullPath().toOSString()+" => "+flag);
 				orState(rsrc.getParent(), flag);
 				Display.getDefault().asyncExec(new Runnable() {
@@ -375,7 +375,7 @@ public class GitResourceDecorator extends LabelProvider implements
 				});
 			} else {
 				if ((dirty.intValue() | flag) != dirty.intValue()) {
-					dirty = dirty | flag;
+					dirty = new Integer(dirty.intValue() | flag);
 					rsrc.setSessionProperty(GITFOLDERDIRTYSTATEPROPERTY, dirty);
 					Activator.trace("SETTING:"+rsrc.getFullPath().toOSString()+" => "+dirty);
 					orState(rsrc.getParent(), dirty.intValue());
diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/LaneTest.java b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/LaneTest.java
index 0f57075..707fb86 100644
--- a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/LaneTest.java
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/LaneTest.java
@@ -498,6 +498,7 @@ public class LaneTest extends TestCase {
 				, road);
 	}
 
+	@SuppressWarnings("boxing")
 	private String drawAsAscii(TopologicalSorter<Data> counter) {
 		StringWriter w = new StringWriter();
 		List<Data> entries = counter.getEntries();
diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/SuperListTest.java b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/SuperListTest.java
index 121bf9c..79f4da6 100644
--- a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/SuperListTest.java
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/SuperListTest.java
@@ -28,6 +28,7 @@ public class SuperListTest extends TestCase {
 		assertEquals(0, l.size());
 	}
 
+	@SuppressWarnings("boxing")
 	public void testNonEmpty() {
 		List<Integer> l = new SuperList<Integer>();
 		List<Integer> sl1 = Arrays.asList(new Integer[] { 3,4 });
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/PersonIdent.java b/org.spearce.jgit/src/org/spearce/jgit/lib/PersonIdent.java
index 5857cb7..6879eb7 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/PersonIdent.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/PersonIdent.java
@@ -62,7 +62,7 @@ public class PersonIdent {
 
 		name = username;
 		emailAddress = email;
-		when = Calendar.getInstance().getTimeInMillis();
+		when = new Long(Calendar.getInstance().getTimeInMillis());
 		tzOffset = TimeZone.getDefault().getOffset(when.longValue())
 				/ (60 * 1000);
 	}
-- 
1.5.4.rc4.25.g81cc
