From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 11/12] Cleanup Config's MAGIC_EMPTY_VALUE to be more safe
Date: Tue, 21 Jul 2009 13:19:29 -0700
Message-ID: <1248207570-13880-12-git-send-email-spearce@spearce.org>
References: <1248207570-13880-1-git-send-email-spearce@spearce.org>
 <1248207570-13880-2-git-send-email-spearce@spearce.org>
 <1248207570-13880-3-git-send-email-spearce@spearce.org>
 <1248207570-13880-4-git-send-email-spearce@spearce.org>
 <1248207570-13880-5-git-send-email-spearce@spearce.org>
 <1248207570-13880-6-git-send-email-spearce@spearce.org>
 <1248207570-13880-7-git-send-email-spearce@spearce.org>
 <1248207570-13880-8-git-send-email-spearce@spearce.org>
 <1248207570-13880-9-git-send-email-spearce@spearce.org>
 <1248207570-13880-10-git-send-email-spearce@spearce.org>
 <1248207570-13880-11-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Tue Jul 21 22:21:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MTLpy-0001jT-Ay
	for gcvg-git-2@gmane.org; Tue, 21 Jul 2009 22:21:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756155AbZGUUTn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Jul 2009 16:19:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756147AbZGUUTm
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Jul 2009 16:19:42 -0400
Received: from george.spearce.org ([209.20.77.23]:59254 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756123AbZGUUTg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jul 2009 16:19:36 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 525D23821F; Tue, 21 Jul 2009 20:19:36 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 6960B381FD;
	Tue, 21 Jul 2009 20:19:34 +0000 (UTC)
X-Mailer: git-send-email 1.6.4.rc1.186.g60aa0c
In-Reply-To: <1248207570-13880-11-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123702>

The magic value "%%magic%%empty%%" is just too magic; if it ever
did appear as a value in a key string Config would have treated
it as a true value instead of as a string value.  We also had to
special case conversions of it to the empty string in a string
context.  Instead we create a special String object using the
empty string as a template, and use reference equality against
that to indicate the magic empty value.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../src/org/spearce/jgit/lib/Config.java           |   28 +++++++++----------
 1 files changed, 13 insertions(+), 15 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/Config.java b/org.spearce.jgit/src/org/spearce/jgit/lib/Config.java
index 974ffea..e4528b1 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/Config.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/Config.java
@@ -76,9 +76,14 @@
 	private Map<String, Object> byName;
 
 	/**
-	 * Magic value indicating a missing entry
+	 * Magic value indicating a missing entry.
+	 * <p>
+	 * This value is tested for reference equality in some contexts, so we
+	 * must ensure it is a special copy of the empty string.  It also must
+	 * be treated like the empty string.
 	 */
-	private static final String MAGIC_EMPTY_VALUE = "%%magic%%empty%%";
+	private static final String MAGIC_EMPTY_VALUE = new StringBuilder(0)
+			.toString();
 
 	/**
 	 * The constructor for configuration file
@@ -293,7 +298,7 @@ public boolean getBoolean(final String section, String subsection,
 		if (n == null)
 			return defaultValue;
 
-		if (MAGIC_EMPTY_VALUE.equals(n) || "yes".equalsIgnoreCase(n)
+		if (MAGIC_EMPTY_VALUE == n || "yes".equalsIgnoreCase(n)
 				|| "true".equalsIgnoreCase(n) || "1".equals(n)
 				|| "on".equalsIgnoreCase(n)) {
 			return true;
@@ -321,11 +326,7 @@ public boolean getBoolean(final String section, String subsection,
 	 */
 	public String getString(final String section, String subsection,
 			final String name) {
-		String val = getRawString(section, subsection, name);
-		if (MAGIC_EMPTY_VALUE.equals(val)) {
-			return "";
-		}
-		return val;
+		return getRawString(section, subsection, name);
 	}
 
 	/**
@@ -345,16 +346,13 @@ public String getString(final String section, String subsection,
 		if (o instanceof List) {
 			final List lst = (List) o;
 			final String[] r = new String[lst.size()];
-			for (int i = 0; i < r.length; i++) {
-				final String val = ((Entry) lst.get(i)).value;
-				r[i] = MAGIC_EMPTY_VALUE.equals(val) ? "" : val;
-			}
+			for (int i = 0; i < r.length; i++)
+				r[i] = ((Entry) lst.get(i)).value;
 			return r;
 		}
 
 		if (o instanceof Entry) {
-			final String val = ((Entry) o).value;
-			return new String[] { MAGIC_EMPTY_VALUE.equals(val) ? "" : val };
+			return new String[] { ((Entry) o).value };
 		}
 
 		if (baseConfig != null)
@@ -700,7 +698,7 @@ protected void printConfig(final PrintWriter r) {
 				}
 				r.print(e.name);
 				if (e.value != null) {
-					if (!MAGIC_EMPTY_VALUE.equals(e.value)) {
+					if (MAGIC_EMPTY_VALUE != e.value) {
 						r.print(" = ");
 						r.print(escapeValue(e.value));
 					}
-- 
1.6.4.rc1.186.g60aa0c
