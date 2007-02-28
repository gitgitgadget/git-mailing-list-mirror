From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [EGIT PATCH 9/9] Performance test for jgit.
Date: Wed, 28 Feb 2007 23:26:53 +0100
Message-ID: <20070228222653.12021.55186.stgit@lathund.dewire.com>
References: <20070228222355.12021.13029.stgit@lathund.dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 28 23:32:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMXLg-0002xY-3l
	for gcvg-git@gmane.org; Wed, 28 Feb 2007 23:32:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752129AbXB1Wce (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 28 Feb 2007 17:32:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750977AbXB1Wcc
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Feb 2007 17:32:32 -0500
Received: from [83.140.172.130] ([83.140.172.130]:1438 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S932569AbXB1WcL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Feb 2007 17:32:11 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 86532802E1C
	for <git@vger.kernel.org>; Wed, 28 Feb 2007 23:27:05 +0100 (CET)
Received: from dewire.com ([127.0.0.1])
 by localhost (torino [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 18351-08 for <git@vger.kernel.org>; Wed, 28 Feb 2007 23:27:05 +0100 (CET)
Received: from lathund.dewire.com (unknown [10.9.0.5])
	by dewire.com (Postfix) with ESMTP id 7D7CD8033A8
	for <git@vger.kernel.org>; Wed, 28 Feb 2007 23:27:01 +0100 (CET)
Received: from localhost (lathund.dewire.com [127.0.0.1])
	by lathund.dewire.com (Postfix) with ESMTP id 98C9D2987E
	for <git@vger.kernel.org>; Wed, 28 Feb 2007 23:26:53 +0100 (CET)
X-Virus-Scanned: amavisd-new at localhost.localdomain
Received: from lathund.dewire.com ([127.0.0.1])
	by localhost (lathund.dewire.com [127.0.0.1]) (amavisd-new, port 10025)
	with LMTP id M7GkhC1SOBhH for <git@vger.kernel.org>;
	Wed, 28 Feb 2007 23:26:53 +0100 (CET)
Received: from lathund.dewire.com (lathund.dewire.com [127.0.0.1])
	by lathund.dewire.com (Postfix) with ESMTP id 18F232987A
	for <git@vger.kernel.org>; Wed, 28 Feb 2007 23:26:53 +0100 (CET)
In-Reply-To: <20070228222355.12021.13029.stgit@lathund.dewire.com>
User-Agent: StGIT/0.11
X-Virus-Scanned: by amavisd-new at dewire.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41012>

Having these things is a test suite is dubious, but useful
anyway.

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---

 .../tst/org/spearce/jgit/lib/SpeedTestBase.java    |   48 ++++++++++++++++
 .../spearce/jgit/lib/T0005_ShallowSpeedTest.java   |   67 ++++++++++++++++++++++
 .../org/spearce/jgit/lib/T0006_DeepSpeedTest.java  |   70 +++++++++++++++++++++++
 3 files changed, 185 insertions(+), 0 deletions(-)

diff --git a/org.spearce.jgit/tst/org/spearce/jgit/lib/SpeedTestBase.java b/org.spearce.jgit/tst/org/spearce/jgit/lib/SpeedTestBase.java
new file mode 100644
index 0000000..6601407
--- /dev/null
+++ b/org.spearce.jgit/tst/org/spearce/jgit/lib/SpeedTestBase.java
@@ -0,0 +1,48 @@
+package org.spearce.jgit.lib;
+
+import java.io.BufferedReader;
+import java.io.File;
+import java.io.FileReader;
+import java.io.IOException;
+import java.io.InputStream;
+
+import junit.framework.TestCase;
+
+public abstract class SpeedTestBase extends TestCase {
+	protected long nativeTime;
+	protected String kernelrepo;
+
+	protected void prepare(String[] refcmd) throws Exception {
+		try {
+			BufferedReader bufferedReader = new BufferedReader(new FileReader("kernel.ref"));
+			kernelrepo = bufferedReader.readLine();
+			bufferedReader.close();
+			timeNativeGit(kernelrepo, refcmd);
+			nativeTime = timeNativeGit(kernelrepo, refcmd);
+		} catch (Exception e) {
+			System.out.println("Create a file named kernel.ref and put the path to the Linux kernels repository there");
+			throw e;
+		}
+	}
+
+	private static long timeNativeGit(String kernelrepo, String[] refcmd) throws IOException,
+			InterruptedException, Exception {
+		long start = System.currentTimeMillis();
+		Process p = Runtime.getRuntime().exec(refcmd, null, new File(kernelrepo,".."));
+		InputStream inputStream = p.getInputStream();
+		InputStream errorStream = p.getErrorStream();
+		byte[] buf=new byte[1024*1024];
+		while (inputStream.read(buf)>=0)
+			; // empty
+		if (p.waitFor()!=0) {
+			int c;
+			while ((c=errorStream.read())!=-1)
+				System.err.print((char)c);
+			throw new Exception("git log failed");
+		}
+		inputStream.close();
+		errorStream.close();
+		long stop = System.currentTimeMillis();
+		return stop - start;
+	}
+}
diff --git a/org.spearce.jgit/tst/org/spearce/jgit/lib/T0005_ShallowSpeedTest.java b/org.spearce.jgit/tst/org/spearce/jgit/lib/T0005_ShallowSpeedTest.java
new file mode 100644
index 0000000..7187e9a
--- /dev/null
+++ b/org.spearce.jgit/tst/org/spearce/jgit/lib/T0005_ShallowSpeedTest.java
@@ -0,0 +1,67 @@
+/*
+ *  Copyright (C) 2006  Robin Rosenberg <robin.rosenberg@dewire.com>
+ *
+ *  This library is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU Lesser General Public
+ *  License, version 2.1, as published by the Free Software Foundation.
+ *
+ *  This library is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  Lesser General Public License for more details.
+ *
+ *  You should have received a copy of the GNU Lesser General Public
+ *  License along with this library; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301
+ */
+package org.spearce.jgit.lib;
+
+import java.io.File;
+import java.io.IOException;
+import java.util.List;
+
+import junit.textui.TestRunner;
+
+public class T0005_ShallowSpeedTest extends SpeedTestBase {
+
+	protected void setUp() throws Exception {
+		prepare(new String[] { "git", "rev-list", "365bbe0d0caaf2ba74d56556827babf0bc66965d" });
+	}
+
+	public void testShallowHistoryScan() throws IOException {
+		long start = System.currentTimeMillis();
+		Repository db = new Repository(new File(kernelrepo));
+		Commit commit = db.mapCommit("365bbe0d0caaf2ba74d56556827babf0bc66965d");
+		int n = 1;
+		do {
+			// System.out.println("commit="+commit.getCommitId());
+			List parent = commit.getParentIds();
+			if (parent.size() > 0) {
+				ObjectId parentId = (ObjectId) parent.get(0);
+				commit = db.mapCommit(parentId);
+				commit.getCommitId().toString();
+				++n;
+			} else {
+				commit = null;
+			}
+		} while (commit != null);
+		assertEquals(12275, n);
+		long stop = System.currentTimeMillis();
+		long time = stop - start;
+		System.out.println("native="+nativeTime);
+		System.out.println("jgit="+time);
+		// ~0.750s (hot cache), ok
+		/*
+native=1748
+jgit=774
+		 */
+		// native git seems to run SLOWER than jgit here, at roughly half the speed
+		// creating the git process is not the issue here, btw. 
+		long factor10 = (nativeTime*110/time+50)/100;
+		assertEquals(2, factor10);
+	}
+
+	public static void main(String[] args) {
+		TestRunner.run(T0005_ShallowSpeedTest.class);
+	}
+}
diff --git a/org.spearce.jgit/tst/org/spearce/jgit/lib/T0006_DeepSpeedTest.java b/org.spearce.jgit/tst/org/spearce/jgit/lib/T0006_DeepSpeedTest.java
new file mode 100644
index 0000000..5bd480c
--- /dev/null
+++ b/org.spearce.jgit/tst/org/spearce/jgit/lib/T0006_DeepSpeedTest.java
@@ -0,0 +1,70 @@
+/*
+ *  Copyright (C) 2006  Shawn Pearce <spearce@spearce.org>
+ *
+ *  This library is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU Lesser General Public
+ *  License, version 2.1, as published by the Free Software Foundation.
+ *
+ *  This library is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  Lesser General Public License for more details.
+ *
+ *  You should have received a copy of the GNU Lesser General Public
+ *  License along with this library; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301
+ */
+package org.spearce.jgit.lib;
+
+import java.io.File;
+import java.io.IOException;
+import java.util.List;
+
+import junit.textui.TestRunner;
+
+public class T0006_DeepSpeedTest extends SpeedTestBase {
+
+	protected void setUp() throws Exception {
+		prepare(new String[] { "git", "rev-list", "365bbe0d0caaf2ba74d56556827babf0bc66965d","--","net/netfilter/nf_queue.c" });
+	}
+
+	public void testDeepHistoryScan() throws IOException {	
+		long start = System.currentTimeMillis();
+		Repository db = new Repository(new File(kernelrepo));
+		Commit commit = db.mapCommit("365bbe0d0caaf2ba74d56556827babf0bc66965d");
+		int n = 1;
+		do {
+			// System.out.println("commit="+commit.getCommitId());
+			List parent = commit.getParentIds();
+			if (parent.size() > 0) {
+				ObjectId parentId = (ObjectId) parent.get(0);
+				commit = db.mapCommit(parentId);
+				TreeEntry m = commit.getTree().findMember("net/netfilter/nf_queue.c");
+				if (m != null)
+					commit.getCommitId().toString();
+				++n;
+			} else {
+				commit = null;
+			}
+		} while (commit != null);
+		// 
+		assertEquals(12275, n);
+		long stop = System.currentTimeMillis();
+		long time = stop - start;
+		System.out.println("native="+nativeTime);
+		System.out.println("jgit="+time);
+		/*
+		native=1355
+		jgit=5449
+		 */
+		// This is not an exact factor, but we'd expect native git to perform this 
+		// about 4 times quicker. If for some reason we find jgit to be faster than
+		// this the cause should be found and secured.
+		long factor = (time*110/nativeTime+50)/100;
+		assertEquals(4, factor);
+	}
+
+	public static void main(String[] args) {
+		TestRunner.run(T0006_DeepSpeedTest.class);
+	}
+}
