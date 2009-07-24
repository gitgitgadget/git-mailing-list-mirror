From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH] Ensure Config readers handle case insensitive names
	correctly
Date: Fri, 24 Jul 2009 14:34:16 -0700
Message-ID: <20090724213416.GX11191@spearce.org>
References: <1248207570-13880-1-git-send-email-spearce@spearce.org> <1248207570-13880-11-git-send-email-spearce@spearce.org> <85647ef50907220411w356000bcuda21e9318eab094@mail.gmail.com> <200907222337.56238.robin.rosenberg@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Constantine Plotnikov <constantine.plotnikov@gmail.com>,
	git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Fri Jul 24 23:34:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MUSPN-0000iF-Aq
	for gcvg-git-2@gmane.org; Fri, 24 Jul 2009 23:34:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754615AbZGXVeT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Jul 2009 17:34:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754364AbZGXVeS
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Jul 2009 17:34:18 -0400
Received: from george.spearce.org ([209.20.77.23]:37354 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754295AbZGXVeR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Jul 2009 17:34:17 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id ECC8C381FD; Fri, 24 Jul 2009 21:34:16 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <200907222337.56238.robin.rosenberg@dewire.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123950>

In some locales (e.g. Turkish) String toLowerCase() and
equalsIgnoreCase() can produce different results.  For example,
in that locale:

  i = U+0069   LC(I, tr_TR) = U+0131
  I = U+0049   UC(i, tr_TR) = U+0130

C Git and network protocols prefer to operate in the "C" locale,
which does not translate to different codepoints like this, but
instead stays within the US-ASCII character set, U+0069 and U+0049.
When reading a Git configuration file in a Turkish locale we should
honor the US-ASCII interpretation as C Git would, rather than the
native Turkish locale's rules.

By using our own toLowerCase and equalsIgnoreCase implementations we
can ensure we always use the US-ASCII (aka "C" locale) definition of
this 'i' <-> 'I' translation.  A custom table based translation is
used instead of relying on Locale.US to avoid accidental translation
of codepoints > U+007f, as these are not typically translated in the
"C" locale but might still be translated in Java's en_US locale.

CC: Constantine Plotnikov <constantine.plotnikov@gmail.com>
Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 Robin Rosenberg <robin.rosenberg@dewire.com> wrote:
 > onsdag 22 juli 2009 13:11:07 skrev Constantine Plotnikov <constantine.plotnikov@gmail.com>:
 > > Also I'm somewhat bothered by usage of toLowerCase() without locale
 > > specified and equalsIgnoreCase(). When turkish locale is default one
 > > there could be surprising results with the letter "I".  The program:
 ...
 > Good catch.
 ...
 > As you say we should make this a separate patch.
 
 And here is a patch!  :-)
 
 .../tst/org/spearce/jgit/util/StringUtilsTest.java |   78 +++++++++++++
 .../findBugs/FindBugsExcludeFilter.xml             |   18 +++-
 .../src/org/spearce/jgit/lib/Config.java           |   25 +++--
 .../src/org/spearce/jgit/transport/AmazonS3.java   |   15 ++--
 .../org/spearce/jgit/transport/OpenSshConfig.java  |   19 ++--
 .../src/org/spearce/jgit/util/FS_Win32.java        |    2 +-
 .../org/spearce/jgit/util/RawSubStringPattern.java |    2 +-
 .../src/org/spearce/jgit/util/StringUtils.java     |  115 ++++++++++++++++++++
 8 files changed, 243 insertions(+), 31 deletions(-)
 create mode 100644 org.spearce.jgit.test/tst/org/spearce/jgit/util/StringUtilsTest.java
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/util/StringUtils.java

diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/util/StringUtilsTest.java b/org.spearce.jgit.test/tst/org/spearce/jgit/util/StringUtilsTest.java
new file mode 100644
index 0000000..0710844
--- /dev/null
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/util/StringUtilsTest.java
@@ -0,0 +1,78 @@
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
+package org.spearce.jgit.util;
+
+import junit.framework.TestCase;
+
+public class StringUtilsTest extends TestCase {
+	public void testToLowerCaseChar() {
+		assertEquals('a', StringUtils.toLowerCase('A'));
+		assertEquals('z', StringUtils.toLowerCase('Z'));
+
+		assertEquals('a', StringUtils.toLowerCase('a'));
+		assertEquals('z', StringUtils.toLowerCase('z'));
+
+		assertEquals((char) 0, StringUtils.toLowerCase((char) 0));
+		assertEquals((char) 0xffff, StringUtils.toLowerCase((char) 0xffff));
+	}
+
+	public void testToLowerCaseString() {
+		assertEquals("\n abcdefghijklmnopqrstuvwxyz\n", StringUtils
+				.toLowerCase("\n ABCDEFGHIJKLMNOPQRSTUVWXYZ\n"));
+	}
+
+	public void testEqualsIgnoreCase1() {
+		final String a = "FOO";
+		assertTrue(StringUtils.equalsIgnoreCase(a, a));
+	}
+
+	public void testEqualsIgnoreCase2() {
+		assertFalse(StringUtils.equalsIgnoreCase("a", ""));
+	}
+
+	public void testEqualsIgnoreCase3() {
+		assertFalse(StringUtils.equalsIgnoreCase("a", "b"));
+		assertFalse(StringUtils.equalsIgnoreCase("ac", "ab"));
+	}
+
+	public void testEqualsIgnoreCase4() {
+		assertTrue(StringUtils.equalsIgnoreCase("a", "a"));
+		assertTrue(StringUtils.equalsIgnoreCase("A", "a"));
+		assertTrue(StringUtils.equalsIgnoreCase("a", "A"));
+	}
+}
diff --git a/org.spearce.jgit/findBugs/FindBugsExcludeFilter.xml b/org.spearce.jgit/findBugs/FindBugsExcludeFilter.xml
index 598197c..6809568 100644
--- a/org.spearce.jgit/findBugs/FindBugsExcludeFilter.xml
+++ b/org.spearce.jgit/findBugs/FindBugsExcludeFilter.xml
@@ -8,10 +8,20 @@
        <Method name="mmap" />
        <Bug pattern="DM_GC" />
      </Match>
-	 <!-- Silence the construction of our magic String instance. 
-	  -->
+
+	   <!-- Silence the construction of our magic String instance. 
+	     -->
      <Match>
-     	<Class name="org.spearce.jgit.lib.Config" />
-     	<Bug pattern="DM_STRING_VOID_CTOR"/>
+     	 <Class name="org.spearce.jgit.lib.Config" />
+     	 <Bug pattern="DM_STRING_VOID_CTOR"/>
+     </Match>
+
+     <!-- Silence comparison of string by == or !=.  This class is built
+          only to provide compare of string values, we won't make a mistake
+          here with == assuming .equals() style equality.
+       -->
+     <Match>
+       <Class name="org.spearce.jgit.lib.util.StringUtils" />
+       <Bug pattern="ES_COMPARING_PARAMETER_STRING_WITH_EQ" />
      </Match>
 </FindBugsFilter>
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/Config.java b/org.spearce.jgit/src/org/spearce/jgit/lib/Config.java
index fc1a2a3..258dba5 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/Config.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/Config.java
@@ -55,6 +55,8 @@
 import java.util.Map;
 import java.util.Set;
 
+import org.spearce.jgit.util.StringUtils;
+
 /**
  * The configuration file stored in the format similar to the ".git/config"
  * file.
@@ -236,7 +238,7 @@ public long getLong(final String section, String subsection,
 			return defaultValue;
 
 		long mul = 1;
-		switch (Character.toLowerCase(n.charAt(n.length() - 1))) {
+		switch (StringUtils.toLowerCase(n.charAt(n.length() - 1))) {
 		case 'g':
 			mul = GiB;
 			break;
@@ -297,13 +299,16 @@ public boolean getBoolean(final String section, String subsection,
 		if (n == null)
 			return defaultValue;
 
-		if (MAGIC_EMPTY_VALUE == n || "yes".equalsIgnoreCase(n)
-				|| "true".equalsIgnoreCase(n) || "1".equals(n)
-				|| "on".equalsIgnoreCase(n)) {
+		if (MAGIC_EMPTY_VALUE == n || StringUtils.equalsIgnoreCase("yes", n)
+				|| StringUtils.equalsIgnoreCase("true", n)
+				|| StringUtils.equalsIgnoreCase("1", n)
+				|| StringUtils.equalsIgnoreCase("on", n)) {
 			return true;
 
-		} else if ("no".equalsIgnoreCase(n) || "false".equalsIgnoreCase(n)
-				|| "0".equals(n) || "off".equalsIgnoreCase(n)) {
+		} else if (StringUtils.equalsIgnoreCase("no", n)
+				|| StringUtils.equalsIgnoreCase("false", n)
+				|| StringUtils.equalsIgnoreCase("0", n)
+				|| StringUtils.equalsIgnoreCase("off", n)) {
 			return false;
 
 		} else {
@@ -371,7 +376,8 @@ public String getString(final String section, String subsection,
 		ensureLoaded();
 
 		for (final Entry e : entries) {
-			if (section.equalsIgnoreCase(e.section) && e.subsection != null)
+			if (StringUtils.equalsIgnoreCase(section, e.section)
+					&& e.subsection != null)
 				result.add(e.subsection);
 		}
 		if (baseConfig != null)
@@ -441,7 +447,8 @@ private static String concatenateKey(final String section,
 			ss = "." + subsection;
 		else
 			ss = "";
-		return section.toLowerCase() + ss + "." + name.toLowerCase();
+		return StringUtils.toLowerCase(section) + ss + "."
+				+ StringUtils.toLowerCase(name);
 	}
 
 	/**
@@ -1033,7 +1040,7 @@ private static boolean eqIgnoreCase(final String a, final String b) {
 				return true;
 			if (a == null || b == null)
 				return false;
-			return a.equalsIgnoreCase(b);
+			return StringUtils.equalsIgnoreCase(a, b);
 		}
 
 		private static boolean eqSameCase(final String a, final String b) {
diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/AmazonS3.java b/org.spearce.jgit/src/org/spearce/jgit/transport/AmazonS3.java
index 3d8bdca..d27f37d 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/AmazonS3.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/AmazonS3.java
@@ -79,6 +79,7 @@
 import org.spearce.jgit.lib.ProgressMonitor;
 import org.spearce.jgit.util.Base64;
 import org.spearce.jgit.util.HttpSupport;
+import org.spearce.jgit.util.StringUtils;
 import org.spearce.jgit.util.TemporaryBuffer;
 import org.xml.sax.Attributes;
 import org.xml.sax.InputSource;
@@ -122,7 +123,7 @@
 	}
 
 	private static boolean isSignedHeader(final String name) {
-		final String nameLC = name.toLowerCase();
+		final String nameLC = StringUtils.toLowerCase(name);
 		return SIGNED_HEADERS.contains(nameLC) || nameLC.startsWith("x-amz-");
 	}
 
@@ -214,13 +215,13 @@ public AmazonS3(final Properties props) {
 		privateKey = new SecretKeySpec(Constants.encodeASCII(secret), HMAC);
 
 		final String pacl = props.getProperty("acl", "PRIVATE");
-		if ("PRIVATE".equalsIgnoreCase(pacl))
+		if (StringUtils.equalsIgnoreCase("PRIVATE", pacl))
 			acl = "private";
-		else if ("PUBLIC".equalsIgnoreCase(pacl))
+		else if (StringUtils.equalsIgnoreCase("PUBLIC", pacl))
 			acl = "public-read";
-		else if ("PUBLIC-READ".equalsIgnoreCase(pacl))
+		else if (StringUtils.equalsIgnoreCase("PUBLIC-READ", pacl))
 			acl = "public-read";
-		else if ("PUBLIC_READ".equalsIgnoreCase(pacl))
+		else if (StringUtils.equalsIgnoreCase("PUBLIC_READ", pacl))
 			acl = "public-read";
 		else
 			throw new IllegalArgumentException("Invalid acl: " + pacl);
@@ -575,7 +576,7 @@ private void authorize(final HttpURLConnection c) throws IOException {
 		for (final Map.Entry<String, List<String>> entry : reqHdr.entrySet()) {
 			final String hdr = entry.getKey();
 			if (isSignedHeader(hdr))
-				sigHdr.put(hdr.toLowerCase(), toCleanString(entry.getValue()));
+				sigHdr.put(StringUtils.toLowerCase(hdr), toCleanString(entry.getValue()));
 		}
 
 		final StringBuilder s = new StringBuilder();
@@ -781,7 +782,7 @@ public void endElement(final String uri, final String name,
 			if ("Key".equals(name))
 				entries.add(data.toString().substring(prefix.length()));
 			else if ("IsTruncated".equals(name))
-				truncated = "true".equalsIgnoreCase(data.toString());
+				truncated = StringUtils.equalsIgnoreCase("true", data.toString());
 			data = null;
 		}
 	}
diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/OpenSshConfig.java b/org.spearce.jgit/src/org/spearce/jgit/transport/OpenSshConfig.java
index 92a1bfc..acd1a45 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/OpenSshConfig.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/OpenSshConfig.java
@@ -55,6 +55,7 @@
 import org.spearce.jgit.errors.InvalidPatternException;
 import org.spearce.jgit.fnmatch.FileNameMatcher;
 import org.spearce.jgit.util.FS;
+import org.spearce.jgit.util.StringUtils;
 
 /**
  * Simple configuration parser for the OpenSSH ~/.ssh/config file.
@@ -176,7 +177,7 @@ public Host lookup(final String hostName) {
 			final String keyword = parts[0].trim();
 			final String argValue = parts[1].trim();
 
-			if ("Host".equalsIgnoreCase(keyword)) {
+			if (StringUtils.equalsIgnoreCase("Host", keyword)) {
 				current.clear();
 				for (final String pattern : argValue.split("[ \t]")) {
 					final String name = dequote(pattern);
@@ -197,15 +198,15 @@ public Host lookup(final String hostName) {
 				continue;
 			}
 
-			if ("HostName".equalsIgnoreCase(keyword)) {
+			if (StringUtils.equalsIgnoreCase("HostName", keyword)) {
 				for (final Host c : current)
 					if (c.hostName == null)
 						c.hostName = dequote(argValue);
-			} else if ("User".equalsIgnoreCase(keyword)) {
+			} else if (StringUtils.equalsIgnoreCase("User", keyword)) {
 				for (final Host c : current)
 					if (c.user == null)
 						c.user = dequote(argValue);
-			} else if ("Port".equalsIgnoreCase(keyword)) {
+			} else if (StringUtils.equalsIgnoreCase("Port", keyword)) {
 				try {
 					final int port = Integer.parseInt(dequote(argValue));
 					for (final Host c : current)
@@ -214,19 +215,19 @@ public Host lookup(final String hostName) {
 				} catch (NumberFormatException nfe) {
 					// Bad port number. Don't set it.
 				}
-			} else if ("IdentityFile".equalsIgnoreCase(keyword)) {
+			} else if (StringUtils.equalsIgnoreCase("IdentityFile", keyword)) {
 				for (final Host c : current)
 					if (c.identityFile == null)
 						c.identityFile = toFile(dequote(argValue));
-			} else if ("PreferredAuthentications".equalsIgnoreCase(keyword)) {
+			} else if (StringUtils.equalsIgnoreCase("PreferredAuthentications", keyword)) {
 				for (final Host c : current)
 					if (c.preferredAuthentications == null)
 						c.preferredAuthentications = nows(dequote(argValue));
-			} else if ("BatchMode".equalsIgnoreCase(keyword)) {
+			} else if (StringUtils.equalsIgnoreCase("BatchMode", keyword)) {
 				for (final Host c : current)
 					if (c.batchMode == null)
 						c.batchMode = yesno(dequote(argValue));
-			} else if ("StrictHostKeyChecking".equalsIgnoreCase(keyword)) {
+			} else if (StringUtils.equalsIgnoreCase("StrictHostKeyChecking", keyword)) {
 				String value = dequote(argValue);
 				for (final Host c : current)
 					if (c.strictHostKeyChecking == null)
@@ -268,7 +269,7 @@ private static String nows(final String value) {
 	}
 
 	private static Boolean yesno(final String value) {
-		if ("yes".equalsIgnoreCase(value))
+		if (StringUtils.equalsIgnoreCase("yes", value))
 			return Boolean.TRUE;
 		return Boolean.FALSE;
 	}
diff --git a/org.spearce.jgit/src/org/spearce/jgit/util/FS_Win32.java b/org.spearce.jgit/src/org/spearce/jgit/util/FS_Win32.java
index ef589bc..009b338 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/util/FS_Win32.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/util/FS_Win32.java
@@ -50,7 +50,7 @@ public String run() {
 					}
 				});
 		return osDotName != null
-				&& osDotName.toLowerCase().indexOf("windows") != -1;
+				&& StringUtils.toLowerCase(osDotName).indexOf("windows") != -1;
 	}
 
 	public boolean supportsExecute() {
diff --git a/org.spearce.jgit/src/org/spearce/jgit/util/RawSubStringPattern.java b/org.spearce.jgit/src/org/spearce/jgit/util/RawSubStringPattern.java
index a81bf7f..5ed071c 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/util/RawSubStringPattern.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/util/RawSubStringPattern.java
@@ -117,7 +117,7 @@ private static final boolean neq(final byte a, final byte b) {
 	}
 
 	private static final byte lc(final byte q) {
-		return (byte) Character.toLowerCase((char) (q & 0xff));
+		return (byte) StringUtils.toLowerCase((char) (q & 0xff));
 	}
 
 	/**
diff --git a/org.spearce.jgit/src/org/spearce/jgit/util/StringUtils.java b/org.spearce.jgit/src/org/spearce/jgit/util/StringUtils.java
new file mode 100644
index 0000000..81d293a
--- /dev/null
+++ b/org.spearce.jgit/src/org/spearce/jgit/util/StringUtils.java
@@ -0,0 +1,115 @@
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
+package org.spearce.jgit.util;
+
+/** Miscellaneous string comparison utility methods. */
+public final class StringUtils {
+	private static final char[] LC;
+
+	static {
+		LC = new char['Z' + 1];
+		for (char c = 0; c < LC.length; c++)
+			LC[c] = c;
+		for (char c = 'A'; c <= 'Z'; c++)
+			LC[c] = (char) ('a' + (c - 'A'));
+	}
+
+	/**
+	 * Convert the input to lowercase.
+	 * <p>
+	 * This method does not honor the JVM locale, but instead always behaves as
+	 * though it is in the US-ASCII locale. Only characters in the range 'A'
+	 * through 'Z' are converted. All other characters are left as-is, even if
+	 * they otherwise would have a lowercase character equivilant.
+	 * 
+	 * @param c
+	 *            the input character.
+	 * @return lowercase version of the input.
+	 */
+	public static char toLowerCase(final char c) {
+		return c <= 'Z' ? LC[c] : c;
+	}
+
+	/**
+	 * Convert the input string to lower case, according to the "C" locale.
+	 * <p>
+	 * This method does not honor the JVM locale, but instead always behaves as
+	 * though it is in the US-ASCII locale. Only characters in the range 'A'
+	 * through 'Z' are converted, all other characters are left as-is, even if
+	 * they otherwise would have a lowercase character equivilant.
+	 * 
+	 * @param in
+	 *            the input string. Must not be null.
+	 * @return a copy of the input string, after converting characters in the
+	 *         range 'A'..'Z' to 'a'..'z'.
+	 */
+	public static String toLowerCase(final String in) {
+		final StringBuilder r = new StringBuilder(in.length());
+		for (int i = 0; i < in.length(); i++)
+			r.append(toLowerCase(in.charAt(i)));
+		return r.toString();
+	}
+
+	/**
+	 * Test if two strings are equal, ignoring case.
+	 * <p>
+	 * This method does not honor the JVM locale, but instead always behaves as
+	 * though it is in the US-ASCII locale.
+	 * 
+	 * @param a
+	 *            first string to compare.
+	 * @param b
+	 *            second string to compare.
+	 * @return true if a equals b
+	 */
+	public static boolean equalsIgnoreCase(final String a, final String b) {
+		if (a == b)
+			return true;
+		if (a.length() != b.length())
+			return false;
+		for (int i = 0; i < a.length(); i++) {
+			if (toLowerCase(a.charAt(i)) != toLowerCase(b.charAt(i)))
+				return false;
+		}
+		return true;
+	}
+
+	private StringUtils() {
+		// Do not create instances
+	}
+}
-- 
1.6.4.rc2.182.g24de1
