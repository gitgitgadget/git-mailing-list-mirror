From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: Re: [jgit] index v2 pull request
Date: Wed, 12 Mar 2008 08:07:01 +0100
Message-ID: <200803120807.01715.robin.rosenberg@dewire.com>
References: <20080308025027.GZ8410@spearce.org> <200803102253.28469.robin.rosenberg@dewire.com> <7bfdc29a0803111952h3cd37b78jd884cec94afe1bc4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org,
	"Dave Watson" <dwatson@mimvista.com>,
	"Roger C. Soares" <rogersoares@intelinet.com.br>
To: "Imran M Yousuf" <imyousuf@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 12 08:08:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZL4W-00045r-FM
	for gcvg-git-2@gmane.org; Wed, 12 Mar 2008 08:08:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752772AbYCLHHQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Mar 2008 03:07:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750905AbYCLHHP
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Mar 2008 03:07:15 -0400
Received: from [83.140.172.130] ([83.140.172.130]:19746 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1751138AbYCLHHN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 12 Mar 2008 03:07:13 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 6DAE9802671;
	Wed, 12 Mar 2008 08:07:11 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id P+l4jcoQlq-9; Wed, 12 Mar 2008 08:07:10 +0100 (CET)
Received: from svgx13ar-gw-100.teliamobile (unknown [10.9.0.3])
	by dewire.com (Postfix) with ESMTP id B7E36800784;
	Wed, 12 Mar 2008 08:07:06 +0100 (CET)
User-Agent: KMail/1.9.9
In-Reply-To: <7bfdc29a0803111952h3cd37b78jd884cec94afe1bc4@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76932>

Den Wednesday 12 March 2008 03.52.05 skrev Imran M Yousuf:
> Maven: Does this mean mavenizing the project? If so I would start it
> this weekend. If you were referring to GIT Maven SCM please also let
> me know.
Not to build using, but create SCM functions for those so thay can use
git without <exec> tasks. Git isn't available in any of those, while much
worse SCM's have support.

> I am currently looking into .git/config format as Shawn suggested.

That's a good one too. I have code for parsing the remotes specs, though
e.g. "+refs/heads/master/*:refs/remotes/origin/*", but nothing for the "branch" config. I haven't used it yet, so it's a rip-out.	

-- robin

>From 042fa0bef8b5d3ec8f5b1e385766ca61528e72aa Mon Sep 17 00:00:00 2001
From: Robin Rosenberg <robin.rosenberg@dewire.com>
Date: Wed, 5 Mar 2008 23:27:57 +0100
Subject: [PATCH] Add support for parsing remote specs

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---
 .../tst/org/spearce/jgit/lib/RemoteSpecTest.java   |   95 +++++++++++++
 .../src/org/spearce/jgit/lib/RemoteSpec.java       |  142 ++++++++++++++++++++
 .../src/org/spearce/jgit/lib/Repository.java       |   12 ++
 3 files changed, 249 insertions(+), 0 deletions(-)
 create mode 100644 org.spearce.jgit.test/tst/org/spearce/jgit/lib/RemoteSpecTest.java
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/lib/RemoteSpec.java

diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/RemoteSpecTest.java b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/RemoteSpecTest.java
new file mode 100644
index 0000000..817e697
--- /dev/null
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/RemoteSpecTest.java
@@ -0,0 +1,95 @@
+/*
+ *  Copyright (C) 2007  Robin Rosenberg
+ *
+ *  This library is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU General Public
+ *  License, version 2, as published by the Free Software Foundation.
+ *
+ *  This library is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public
+ *  License along with this library; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301
+ */
+package org.spearce.jgit.lib;
+
+import java.io.File;
+import java.io.FileOutputStream;
+
+/**
+ * Test parsing of git remotes
+ */
+public class RemoteSpecTest extends RepositoryTestCase {
+
+	/**
+	 * Test simplest case
+	 *
+	 * @throws Exception
+	 *
+	 */
+	public void testSimplestOk() throws Exception {
+		RemoteSpec spec = new RemoteSpec("their", "git://foo.bar/zip.git",
+				"refs/heads/master:refs/heads/origin",null);
+		assertEquals("refs/heads/master", spec.getFetchRemoteRef());
+		assertEquals("refs/heads/origin", spec.getFetchLocalRef());
+		assertFalse(spec.isFetchMatchAny());
+		assertFalse(spec.isFetchOverwriteAlways());
+	}
+
+	/**
+	 * Test a standard case
+	 *
+	 * @throws Exception
+	 */
+	public void testStandardOk() throws Exception {
+		RemoteSpec spec = new RemoteSpec("their", "git://example.com/zip.git",
+				"+refs/heads/master/*:refs/remotes/origin/*",null);
+		assertEquals("git://example.com/zip.git", spec.getUrl());
+		assertEquals("refs/heads/master", spec.getFetchRemoteRef());
+		assertEquals("refs/remotes/origin", spec.getFetchLocalRef());
+		assertTrue(spec.isFetchMatchAny());
+		assertTrue(spec.isFetchOverwriteAlways());
+	}
+
+	/**
+	 * Test a <quote>safer</quote> almost standard case
+	 *
+	 * @throws Exception
+	 */
+	public void testNonStandardSaferOk() throws Exception {
+		RemoteSpec spec = new RemoteSpec("their", "git://example.com/zip.git",
+				"refs/heads/master/*:refs/remotes/origin/*",null);
+		assertEquals("git://example.com/zip.git", spec.getUrl());
+		assertEquals("refs/heads/master", spec.getFetchRemoteRef());
+		assertEquals("refs/remotes/origin", spec.getFetchLocalRef());
+		assertTrue(spec.isFetchMatchAny());
+		assertFalse(spec.isFetchOverwriteAlways());
+	}
+
+	/**
+	 * Test a case copied from a real Git repo
+	 *
+	 * @throws Exception
+	 */
+	public void testReadFromConfig() throws Exception {
+		File file = new File(db.getDirectory(),"config");
+		FileOutputStream stream = new FileOutputStream(file,true);
+		try {
+			stream.write(("[remote \"spearce\"]\n"+
+		"url = http://www.spearce.org/projects/scm/egit.git\n"+
+		"fetch = +refs/heads/*:refs/remotes/spearce/*\n").getBytes());
+		} finally {
+			stream.close();
+		}
+		db.getConfig().load();
+		RemoteSpec remoteSpec = db.getRemoteSpec("spearce");
+		assertEquals("http://www.spearce.org/projects/scm/egit.git", remoteSpec.getUrl());
+		assertEquals("refs/heads", remoteSpec.getFetchRemoteRef());
+		assertEquals("refs/remotes/spearce", remoteSpec.getFetchLocalRef());
+		assertTrue(remoteSpec.isFetchMatchAny());
+		assertTrue(remoteSpec.isFetchOverwriteAlways());
+	}
+}
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/RemoteSpec.java b/org.spearce.jgit/src/org/spearce/jgit/lib/RemoteSpec.java
new file mode 100644
index 0000000..a6a3b6c
--- /dev/null
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/RemoteSpec.java
@@ -0,0 +1,142 @@
+/*
+ *  Copyright (C) 2007  Robin Rosenberg
+ *
+ *  This library is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU General Public
+ *  License, version 2, as published by the Free Software Foundation.
+ *
+ *  This library is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public
+ *  License along with this library; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301
+ */
+package org.spearce.jgit.lib;
+
+/**
+ * Information about how to synchronize with a remote Git repository.
+ *
+ * A remote is stored in the <GIT_DIR>/config as
+ *
+ * <pre>
+ *  [remote &quot;name&quot;]
+ *     url = URL:ish
+ *     fetch = [+]remoteref:localref
+ * </pre>
+ *
+ * There are more variants but we do not support them here yet.
+ */
+public class RemoteSpec {
+
+	static class Info {
+		boolean overwriteAlways;
+
+		boolean matchAny;
+
+		String remoteRef;
+
+		String localRef;
+	}
+
+	Info fetch = new Info();
+
+	Info push = null;
+
+	private final String name;
+
+	private final String url;
+
+	/**
+	 * @return name of remote. This is a local short identifier
+	 */
+	public String getName() {
+		return name;
+	}
+
+	/**
+	 * @return the URL:ish location of the remote Git repository
+	 */
+	public String getUrl() {
+		return url;
+	}
+
+	/**
+	 * @return the local ref part used for fetch heads info
+	 */
+	public String getFetchLocalRef() {
+		return fetch.localRef;
+	}
+
+	/**
+	 * @return the remote ref part used for fetching refs from the remote repo
+	 */
+	public String getFetchRemoteRef() {
+		return fetch.remoteRef;
+	}
+
+	/**
+	 * @return whether the fetch matches all branches under the ref or just the
+	 *         named ref
+	 */
+	public boolean isFetchMatchAny() {
+		return fetch.matchAny;
+	}
+
+	/**
+	 * @return whether the tracking branch is always updated, or only when the
+	 *         update is a fast forward
+	 */
+	public boolean isFetchOverwriteAlways() {
+		return fetch.overwriteAlways;
+	}
+
+	/**
+	 * Create a representation of a git remote specification.
+	 *
+	 * @param name A local short identifier
+	 * @param url The URL:ish used for fetching / pushing
+	 * @param fetchPattern refspec for fetching
+	 * @param pushPattern refspec for pushing or null
+	 */
+	public RemoteSpec(String name, String url, String fetchPattern,
+			String pushPattern) {
+		this.name = name;
+		this.url = url;
+		parse(fetchPattern, fetch);
+		if (pushPattern != null) {
+			push = new Info();
+			parse(pushPattern, push);
+		}
+	}
+
+	private void parse(String fetchSpec, Info info) {
+		int p = 0;
+		if (fetchSpec.charAt(p) == '+') {
+			info.overwriteAlways = true;
+			++p;
+		}
+		int cp = fetchSpec.indexOf(':');
+		if (cp < 0)
+			throw new IllegalArgumentException("Bad remote format " + fetchSpec);
+		info.remoteRef = fetchSpec.substring(p, cp);
+		info.localRef = fetchSpec.substring(cp + 1);
+		if (info.remoteRef.endsWith("/*")) {
+			info.matchAny = true;
+			info.remoteRef = info.remoteRef.substring(0, info.remoteRef
+					.length() - 2);
+		}
+		if (info.localRef.endsWith("/*")) {
+			if (!info.matchAny)
+				throw new IllegalArgumentException("Bad remote format "
+						+ fetchSpec);
+			info.localRef = info.localRef.substring(0,
+					info.localRef.length() - 2);
+		} else
+			if (info.matchAny)
+				throw new IllegalArgumentException("Bad remote format " + fetchSpec);
+
+	}
+}
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java b/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java
index b3fa12e..821633d 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java
@@ -1132,4 +1132,16 @@ public class Repository {
 		relName = relName.replace(File.separatorChar, '/');
 		return relName;
 	}
+
+	/**
+	 * @param name
+	 *            The "remote" name in this repo
+	 * @return information about how a remote repository is beging tracked
+	 */
+	public RemoteSpec getRemoteSpec(String name) {
+		String url = getConfig().getString("remote."+name, null, "url");
+		String fetchPattern = getConfig().getString("remote."+name, null, "fetch");
+		String pushPattern = getConfig().getString("remote."+name, null, "push");
+		return new RemoteSpec(name, url, fetchPattern, pushPattern);
+	}
 }
-- 
1.5.4.3
