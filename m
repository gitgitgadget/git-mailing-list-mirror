From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 11/19] Remove the map lookup for values in Config
Date: Sat, 25 Jul 2009 11:52:54 -0700
Message-ID: <1248547982-4003-12-git-send-email-spearce@spearce.org>
References: <1248547982-4003-1-git-send-email-spearce@spearce.org>
 <1248547982-4003-2-git-send-email-spearce@spearce.org>
 <1248547982-4003-3-git-send-email-spearce@spearce.org>
 <1248547982-4003-4-git-send-email-spearce@spearce.org>
 <1248547982-4003-5-git-send-email-spearce@spearce.org>
 <1248547982-4003-6-git-send-email-spearce@spearce.org>
 <1248547982-4003-7-git-send-email-spearce@spearce.org>
 <1248547982-4003-8-git-send-email-spearce@spearce.org>
 <1248547982-4003-9-git-send-email-spearce@spearce.org>
 <1248547982-4003-10-git-send-email-spearce@spearce.org>
 <1248547982-4003-11-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Sat Jul 25 20:54:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MUmO6-0002ZF-NX
	for gcvg-git-2@gmane.org; Sat, 25 Jul 2009 20:54:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752295AbZGYSxd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Jul 2009 14:53:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752201AbZGYSxb
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Jul 2009 14:53:31 -0400
Received: from george.spearce.org ([209.20.77.23]:35572 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752192AbZGYSxL (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Jul 2009 14:53:11 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 6CFDA381FF; Sat, 25 Jul 2009 18:53:11 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 6A3E838215;
	Sat, 25 Jul 2009 18:53:06 +0000 (UTC)
X-Mailer: git-send-email 1.6.4.rc2.216.g769fa
In-Reply-To: <1248547982-4003-11-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124042>

Update operations are already O(N) time in the config file, as we
scan through every entry in the file, in order, looking to see if
it matches the key we need to mutate.  As most configurations are
rather small in size the running time is trivial.  Doing the same
for lookup simplifies our code considerably.

Applications really want a different type of fast lookup strategy.
Instead of by key lookups they want something like CoreConfig
or RemoteConfig to be cached and quickly obtainable on demand,
where the all relevant values have been parsed from their string
content representation into the application specific data types.
This change does not provide that functionality, but rather assumes
we will do so in the near future.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../src/org/spearce/jgit/lib/Config.java           |  129 +++++---------------
 1 files changed, 30 insertions(+), 99 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/Config.java b/org.spearce.jgit/src/org/spearce/jgit/lib/Config.java
index d63e926..0f91412 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/Config.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/Config.java
@@ -43,10 +43,8 @@
 
 import java.util.ArrayList;
 import java.util.Collections;
-import java.util.HashMap;
 import java.util.HashSet;
 import java.util.List;
-import java.util.Map;
 import java.util.Set;
 
 import org.spearce.jgit.errors.ConfigInvalidException;
@@ -66,11 +64,6 @@
 	final Config baseConfig;
 
 	/**
-	 * Map from name to values
-	 */
-	private Map<String, Object> byName;
-
-	/**
 	 * Magic value indicating a missing entry.
 	 * <p>
 	 * This value is tested for reference equality in some contexts, so we
@@ -334,19 +327,9 @@ public String getString(final String section, String subsection,
 	 */
 	public String[] getStringList(final String section, String subsection,
 			final String name) {
-		final Object o = getRawEntry(section, subsection, name);
-		if (o instanceof List) {
-			final List lst = (List) o;
-			final String[] r = new String[lst.size()];
-			for (int i = 0; i < r.length; i++)
-				r[i] = ((Entry) lst.get(i)).value;
-			return r;
-		}
-
-		if (o instanceof Entry) {
-			return new String[] { ((Entry) o).value };
-		}
-
+		final List<String> lst = getRawStringList(section, subsection, name);
+		if (lst != null)
+			return lst.toArray(new String[lst.size()]);
 		if (baseConfig != null)
 			return baseConfig.getStringList(section, subsection, name);
 		return new String[0];
@@ -373,43 +356,36 @@ public String getString(final String section, String subsection,
 
 	private String getRawString(final String section, final String subsection,
 			final String name) {
-		final Object o = getRawEntry(section, subsection, name);
-		if (o instanceof List) {
-			return ((Entry) ((List) o).get(0)).value;
-		} else if (o instanceof Entry) {
-			return ((Entry) o).value;
-		} else if (baseConfig != null)
+		final List<String> lst = getRawStringList(section, subsection, name);
+		if (lst != null)
+			return lst.get(0);
+		else if (baseConfig != null)
 			return baseConfig.getRawString(section, subsection, name);
 		else
 			return null;
 	}
 
-	private Object getRawEntry(final String section, final String subsection,
-			final String name) {
-		return byName.get(concatenateKey(section, subsection, name));
+	private List<String> getRawStringList(final String section,
+			final String subsection, final String name) {
+		List<String> r = null;
+		for (final Entry e : entries) {
+			if (e.match(section, subsection, name))
+				r = add(r, e.value);
+		}
+		return r;
 	}
 
-	/**
-	 * Create simple a key name from the key components
-	 *
-	 * @param section
-	 *            the section name
-	 * @param subsection
-	 *            the subsection name
-	 * @param name
-	 *            the key name
-	 * @return a simple key name that have all components concatenated and the
-	 *         case converted
-	 */
-	private static String concatenateKey(final String section,
-			final String subsection, final String name) {
-		String ss;
-		if (subsection != null)
-			ss = "." + subsection;
-		else
-			ss = "";
-		return StringUtils.toLowerCase(section) + ss + "."
-				+ StringUtils.toLowerCase(name);
+	private static List<String> add(final List<String> curr, final String value) {
+		if (curr == null)
+			return Collections.singletonList(value);
+		if (curr.size() == 1) {
+			final List<String> r = new ArrayList<String>(2);
+			r.add(curr.get(0));
+			r.add(value);
+			return r;
+		}
+		curr.add(value);
+		return curr;
 	}
 
 	/**
@@ -551,31 +527,6 @@ public void unset(final String section, final String subsection,
 	 */
 	public void setStringList(final String section, final String subsection,
 			final String name, final List<String> values) {
-		// Update our parsed cache of values for future reference.
-		//
-		String key = concatenateKey(section, subsection, name);
-		if (values.size() == 0)
-			byName.remove(key);
-		else if (values.size() == 1) {
-			final Entry e = new Entry();
-			e.section = section;
-			e.subsection = subsection;
-			e.name = name;
-			e.value = values.get(0);
-			byName.put(key, e);
-		} else {
-			final ArrayList<Entry> eList = new ArrayList<Entry>(values.size());
-			for (final String v : values) {
-				final Entry e = new Entry();
-				e.section = section;
-				e.subsection = subsection;
-				e.name = name;
-				e.value = v;
-				eList.add(e);
-			}
-			byName.put(key, eList);
-		}
-
 		int entryIndex = 0;
 		int valueIndex = 0;
 		int insertPosition = -1;
@@ -697,9 +648,7 @@ public String toText() {
 	 *             made to {@code this}.
 	 */
 	public void fromText(final String text) throws ConfigInvalidException {
-		entries = new ArrayList<Entry>();
-		byName = new HashMap<String, Object>();
-
+		final List<Entry> newEntries = new ArrayList<Entry>();
 		final StringReader in = new StringReader(text);
 		Entry last = null;
 		Entry e = new Entry();
@@ -711,7 +660,7 @@ public void fromText(final String text) throws ConfigInvalidException {
 			final char c = (char) input;
 			if ('\n' == c) {
 				// End of this entry.
-				add(e);
+				newEntries.add(e);
 				if (e.section != null)
 					last = e;
 				e = new Entry();
@@ -757,6 +706,8 @@ public void fromText(final String text) throws ConfigInvalidException {
 			} else
 				throw new ConfigInvalidException("Invalid line in config file");
 		}
+
+		entries = newEntries;
 	}
 
 	/**
@@ -764,26 +715,6 @@ public void fromText(final String text) throws ConfigInvalidException {
 	 */
 	protected void clear() {
 		entries = new ArrayList<Entry>();
-		byName = new HashMap<String, Object>();
-	}
-
-	@SuppressWarnings("unchecked")
-	private void add(final Entry e) {
-		entries.add(e);
-		if (e.section != null && e.name != null) {
-			final String key = concatenateKey(e.section, e.subsection, e.name);
-			final Object o = byName.get(key);
-			if (o == null) {
-				byName.put(key, e);
-			} else if (o instanceof Entry) {
-				final ArrayList<Object> l = new ArrayList<Object>();
-				l.add(o);
-				l.add(e);
-				byName.put(key, l);
-			} else if (o instanceof List) {
-				((List<Entry>) o).add(e);
-			}
-		}
 	}
 
 	private static String readSectionName(final StringReader in)
-- 
1.6.4.rc2.216.g769fa
