From: Constantine Plotnikov <constantine.plotnikov@gmail.com>
Subject: [JGIT PATCH] Removed conversion of subsection to the lowecase when accessing subsection names in config files
Date: Wed, 22 Jul 2009 16:53:41 +0400
Message-ID: <1248267221-2312-1-git-send-email-constantine.plotnikov@gmail.com>
Cc: Constantine Plotnikov <constantine.plotnikov@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 22 14:53:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MTbKU-0005Hx-54
	for gcvg-git-2@gmane.org; Wed, 22 Jul 2009 14:53:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754521AbZGVMxp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Jul 2009 08:53:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754150AbZGVMxp
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Jul 2009 08:53:45 -0400
Received: from mail.intellij.net ([213.182.181.98]:47206 "EHLO
	mail.intellij.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752148AbZGVMxo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Jul 2009 08:53:44 -0400
Received: (qmail 1151 invoked by uid 89); 22 Jul 2009 12:53:41 -0000
Received: by simscan 1.1.0 ppid: 1101, pid: 1136, t: 0.0074s
         scanners: regex: 1.1.0
Received: from unknown (HELO localhost.localdomain) (Constantine.Plotnikov@jetbrains.com@172.26.240.76)
  by mail.intellij.net with ESMTPA; 22 Jul 2009 12:53:41 -0000
X-Mailer: git-send-email 1.6.1.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123749>

The entries are stored in Config.byName without coversion of
the subsection name to the lowercase. But the methods
setStringList(...) and getRawEntry(...) were converting subsection
names to the lowercase, thus making it impossible to access
values in subsection with names that contained upppercase characters.
This patch removes conversion to the lowercase and introduce
the methods that appropriately concatentates the key. This key
is now used for all map accesses.

Signed-off-by: Constantine Plotnikov <constantine.plotnikov@gmail.com>
---
The patch assumes the current head "FindBugs: don't use new String(String) in RefDatabase".

To apply above the series "[JGIT PATCH 00/12] Cleanup Config class" the
field names in the method add(final Entry e) should be changed. Possibly 
the patch should be merged into the patch 

 "[JGIT PATCH 10/12] Match config subsection names using case sensitive search".
                                   
 .../src/org/spearce/jgit/lib/Config.java           |   61 ++++++++++----------
 1 files changed, 31 insertions(+), 30 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/Config.java b/org.spearce.jgit/src/org/spearce/jgit/lib/Config.java
index c2d5c6e..a8639ff 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/Config.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/Config.java
@@ -419,15 +419,29 @@ private void ensureLoaded() {
 	private Object getRawEntry(final String section, final String subsection,
 			final String name) {
 		ensureLoaded();
+		return byName.get(concatenateKey(section, subsection, name));
+	}
 
+	/**
+	 * Create simple a key name from the key components
+	 *
+	 * @param section
+	 *            the section name
+	 * @param subsection
+	 *            the subsection name
+	 * @param name
+	 *            the key name
+	 * @return a simple key name that have all components concatenated and the
+	 *         case converted
+	 */
+	private static String concatenateKey(final String section,
+			final String subsection, final String name) {
 		String ss;
 		if (subsection != null)
-			ss = "." + subsection.toLowerCase();
+			ss = "." + subsection;
 		else
 			ss = "";
-		final Object o;
-		o = byName.get(section.toLowerCase() + ss + "." + name.toLowerCase());
-		return o;
+		return section.toLowerCase() + ss + "." + name.toLowerCase();
 	}
 
 	/**
@@ -548,10 +562,7 @@ public void setStringList(final String section, final String subsection,
 			final String name, final List<String> values) {
 		// Update our parsed cache of values for future reference.
 		//
-		String key = section.toLowerCase();
-		if (subsection != null)
-			key += "." + subsection.toLowerCase();
-		key += "." + name.toLowerCase();
+		String key = concatenateKey(section, subsection, name);
 		if (values.size() == 0)
 			byName.remove(key);
 		else if (values.size() == 1) {
@@ -787,28 +798,18 @@ protected void clear() {
 	@SuppressWarnings("unchecked")
 	private void add(final Entry e) {
 		entries.add(e);
-		if (e.base != null) {
-			final String b = e.base.toLowerCase();
-			final String group;
-			if (e.extendedBase != null) {
-				group = b + "." + e.extendedBase;
-			} else {
-				group = b;
-			}
-			if (e.name != null) {
-				final String n = e.name.toLowerCase();
-				final String key = group + "." + n;
-				final Object o = byName.get(key);
-				if (o == null) {
-					byName.put(key, e);
-				} else if (o instanceof Entry) {
-					final ArrayList<Object> l = new ArrayList<Object>();
-					l.add(o);
-					l.add(e);
-					byName.put(key, l);
-				} else if (o instanceof List) {
-					((List<Entry>) o).add(e);
-				}
+		if (e.base != null && e.name != null) {
+			final String key = concatenateKey(e.base, e.extendedBase, e.name);
+			final Object o = byName.get(key);
+			if (o == null) {
+				byName.put(key, e);
+			} else if (o instanceof Entry) {
+				final ArrayList<Object> l = new ArrayList<Object>();
+				l.add(o);
+				l.add(e);
+				byName.put(key, l);
+			} else if (o instanceof List) {
+				((List<Entry>) o).add(e);
 			}
 		}
 	}
-- 
1.6.1.2
