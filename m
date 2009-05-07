From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: Re: [JGIT PATCH 2/2] Make Repository.isValidRefName compatible with Git 1.6.3
Date: Fri, 8 May 2009 01:02:43 +0200
Message-ID: <200905080102.44053.robin.rosenberg@dewire.com>
References: <1241708714-20326-1-git-send-email-spearce@spearce.org> <1241708714-20326-2-git-send-email-spearce@spearce.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri May 08 01:02:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M2CcC-0003eS-Dn
	for gcvg-git-2@gmane.org; Fri, 08 May 2009 01:02:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753578AbZEGXCw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 May 2009 19:02:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753316AbZEGXCw
	(ORCPT <rfc822;git-outgoing>); Thu, 7 May 2009 19:02:52 -0400
Received: from mail.dewire.com ([83.140.172.130]:21872 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752012AbZEGXCv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 7 May 2009 19:02:51 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 7867F144414E;
	Fri,  8 May 2009 01:02:48 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zLI4uq9zEmkp; Fri,  8 May 2009 01:02:45 +0200 (CEST)
Received: from sleipner.localnet (unknown [10.9.0.4])
	by dewire.com (Postfix) with ESMTP id 86A6880026C;
	Fri,  8 May 2009 01:02:45 +0200 (CEST)
User-Agent: KMail/1.11.2 (Linux/2.6.28-11-generic; KDE/4.2.2; i686; ; )
In-Reply-To: <1241708714-20326-2-git-send-email-spearce@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118535>

NAK, ammended patch follows.

Disallows @{, names that end with '.', '\' (that's the "almost" part) plus explicitly
allows unicode names.

-- robin

>From 0854d96e2774bd084cc673ab16cf61c489f0562e Mon Sep 17 00:00:00 2001
From: Shawn O. Pearce <spearce@spearce.org>
Date: Thu, 7 May 2009 08:05:14 -0700
Subject: [EGIT PATCH] Make Repository.isValidRefName almost compatible with Git 1.6.3

In 3e262b95c509 I taught C Git to disallow refs whose names end in
".lock".  This suffix is used by the atomic update mechanism as a
signal that the ref is being modified.  When reading a loose ref
directory both JGit and C Git skip over any files whose names end
with this suffix, as the file is assumed to be one of these magic
locking files from another concurrent process.  Consequently, any
ref that ends with this name will become invisible once created.

In cbdffe4093be Junio disallows names that looks like reflog queries
as well as names that ends with periods.

We also add a suite of tests for the isValidRefName function, fix
its formatting to better conform to current style conventions, and
correct the result for "master"; this is not a valid ref name as it
has only 1 path component.  At least 2 path components is required.

In addition to 1.6.3 we disallow names with a '\' (backslash) since
that is a directory separator in Windows. Allowing JGit users to
create such names is just asking for trouble. This does not necessarily
prevent JGit from working with such refs in other situations.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---
 .../tst/org/spearce/jgit/lib/ValidRefNameTest.java |  171 ++++++++++++++++++++
 .../src/org/spearce/jgit/lib/Repository.java       |   33 +++--
 2 files changed, 191 insertions(+), 13 deletions(-)
 create mode 100644 org.spearce.jgit.test/tst/org/spearce/jgit/lib/ValidRefNameTest.java

diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/ValidRefNameTest.java b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/ValidRefNameTest.java
new file mode 100644
index 0000000..cb6b9a7
--- /dev/null
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/ValidRefNameTest.java
@@ -0,0 +1,171 @@
+/*
+ * Copyright (C) 2009, Google Inc.
+ *
+ * All rights reserved.
+ *
+ * Redistribution and use in source and binary forms, with or
+ * without modification, are permitted provided that the following
+ * conditions are met:
+ *
+ * - Redistributions of source code must retain the above copyright
+ *   notice, this list of conditions and the following disclaimer.
+ *
+ * - Redistributions in binary form must reproduce the above
+ *   copyright notice, this list of conditions and the following
+ *   disclaimer in the documentation and/or other materials provided
+ *   with the distribution.
+ *
+ * - Neither the name of the Git Development Community nor the
+ *   names of its contributors may be used to endorse or promote
+ *   products derived from this software without specific prior
+ *   written permission.
+ *
+ * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND
+ * CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES,
+ * INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
+ * OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
+ * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
+ * CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
+ * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
+ * NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
+ * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
+ * CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
+ * STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
+ * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
+ * ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ */
+
+package org.spearce.jgit.lib;
+
+import junit.framework.TestCase;
+
+public class ValidRefNameTest extends TestCase {
+	private static void assertValid(final boolean exp, final String name) {
+		assertEquals("\"" + name + "\"", exp, Repository.isValidRefName(name));
+	}
+
+	public void testEmptyString() {
+		assertValid(false, "");
+		assertValid(false, "/");
+	}
+
+	public void testMustHaveTwoComponents() {
+		assertValid(false, "master");
+		assertValid(true, "heads/master");
+	}
+
+	public void testValidHead() {
+		assertValid(true, "refs/heads/master");
+		assertValid(true, "refs/heads/pu");
+		assertValid(true, "refs/heads/z");
+		assertValid(true, "refs/heads/FoO");
+	}
+
+	public void testValidTag() {
+		assertValid(true, "refs/tags/v1.0");
+	}
+
+	public void testNoLockSuffix() {
+		assertValid(false, "refs/heads/master.lock");
+	}
+
+	public void testNoDirectorySuffix() {
+		assertValid(false, "refs/heads/master/");
+	}
+
+	public void testNoSpace() {
+		assertValid(false, "refs/heads/i haz space");
+	}
+
+	public void testNoAsciiControlCharacters() {
+		for (char c = '\0'; c < ' '; c++)
+			assertValid(false, "refs/heads/mast" + c + "er");
+	}
+
+	public void testNoBareDot() {
+		assertValid(false, "refs/heads/.");
+		assertValid(false, "refs/heads/..");
+		assertValid(false, "refs/heads/./master");
+		assertValid(false, "refs/heads/../master");
+	}
+
+	public void testNoLeadingOrTrailingDot() {
+		assertValid(false, ".");
+		assertValid(false, "refs/heads/.bar");
+		assertValid(false, "refs/heads/..bar");
+		assertValid(false, "refs/heads/bar.");
+	}
+
+	public void testContainsDot() {
+		assertValid(true, "refs/heads/m.a.s.t.e.r");
+		assertValid(false, "refs/heads/master..pu");
+	}
+
+	public void testNoMagicRefCharacters() {
+		assertValid(false, "refs/heads/master^");
+		assertValid(false, "refs/heads/^master");
+		assertValid(false, "^refs/heads/master");
+
+		assertValid(false, "refs/heads/master~");
+		assertValid(false, "refs/heads/~master");
+		assertValid(false, "~refs/heads/master");
+
+		assertValid(false, "refs/heads/master:");
+		assertValid(false, "refs/heads/:master");
+		assertValid(false, ":refs/heads/master");
+	}
+
+	public void testShellGlob() {
+		assertValid(false, "refs/heads/master?");
+		assertValid(false, "refs/heads/?master");
+		assertValid(false, "?refs/heads/master");
+
+		assertValid(false, "refs/heads/master[");
+		assertValid(false, "refs/heads/[master");
+		assertValid(false, "[refs/heads/master");
+
+		assertValid(false, "refs/heads/master*");
+		assertValid(false, "refs/heads/*master");
+		assertValid(false, "*refs/heads/master");
+	}
+
+	public void testValidSpecialCharacters() {
+		assertValid(true, "refs/heads/!");
+		assertValid(true, "refs/heads/\"");
+		assertValid(true, "refs/heads/#");
+		assertValid(true, "refs/heads/$");
+		assertValid(true, "refs/heads/%");
+		assertValid(true, "refs/heads/&");
+		assertValid(true, "refs/heads/'");
+		assertValid(true, "refs/heads/(");
+		assertValid(true, "refs/heads/)");
+		assertValid(true, "refs/heads/+");
+		assertValid(true, "refs/heads/,");
+		assertValid(true, "refs/heads/-");
+		assertValid(true, "refs/heads/;");
+		assertValid(true, "refs/heads/<");
+		assertValid(true, "refs/heads/=");
+		assertValid(true, "refs/heads/>");
+		assertValid(true, "refs/heads/@");
+		assertValid(true, "refs/heads/]");
+		assertValid(true, "refs/heads/_");
+		assertValid(true, "refs/heads/`");
+		assertValid(true, "refs/heads/{");
+		assertValid(true, "refs/heads/|");
+		assertValid(true, "refs/heads/}");
+
+		// This is valid on UNIX, but not on Windows
+		// hence we make in invalid due to non-portability
+		//
+		assertValid(false, "refs/heads/\\");
+	}
+
+	public void testUnicodeNames() {
+		assertValid(true, "refs/heads/\u00e5ngstr\u00f6m");
+	}
+
+	public void testRefLogQueryIsValidRef() {
+		assertValid(false, "refs/heads/master@{1}");
+		assertValid(false, "refs/heads/master@{1.hour.ago}");
+	}
+}
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java b/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java
index 5baa7a0..a47207d 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java
@@ -931,6 +931,8 @@ public RepositoryState getRepositoryState() {
 	 * a special meaning in a Git object reference expression. Some other
 	 * dangerous characters are also excluded.
 	 *
+	 * For portability reasons '\' is excluded
+	 *
 	 * @param refName
 	 *
 	 * @return true if refName is a valid ref name
@@ -939,36 +941,41 @@ public static boolean isValidRefName(final String refName) {
 		final int len = refName.length();
 		if (len == 0)
 			return false;
+		if (refName.endsWith(".lock"))
+			return false;
 
+		int components = 1;
 		char p = '\0';
-		for (int i=0; i<len; ++i) {
-			char c = refName.charAt(i);
+		for (int i = 0; i < len; i++) {
+			final char c = refName.charAt(i);
 			if (c <= ' ')
 				return false;
-			switch(c) {
+			switch (c) {
 			case '.':
-				if (i == 0)
-					return false;
-				if (p == '/')
+				switch (p) {
+				case '\0': case '/': case '.':
 					return false;
-				if (p == '.')
+				}
+				if (i == len -1)
 					return false;
 				break;
 			case '/':
-				if (i == 0)
+				if (i == 0 || i == len - 1)
 					return false;
-				if (i == len -1)
+				components++;
+				break;
+			case '@':
+				if (p == '{')
 					return false;
 				break;
 			case '~': case '^': case ':':
-			case '?': case '[':
-				return false;
-			case '*':
+			case '?': case '[': case '*':
+			case '\\':
 				return false;
 			}
 			p = c;
 		}
-		return true;
+		return components > 1;
 	}
 
 	/**
-- 
1.6.3
