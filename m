From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 15/19] Cache Config subsection names when requested by application code
Date: Sat, 25 Jul 2009 11:52:58 -0700
Message-ID: <1248547982-4003-16-git-send-email-spearce@spearce.org>
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
 <1248547982-4003-12-git-send-email-spearce@spearce.org>
 <1248547982-4003-13-git-send-email-spearce@spearce.org>
 <1248547982-4003-14-git-send-email-spearce@spearce.org>
 <1248547982-4003-15-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Sat Jul 25 20:54:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MUmOB-0002ZF-N0
	for gcvg-git-2@gmane.org; Sat, 25 Jul 2009 20:54:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752340AbZGYSxl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Jul 2009 14:53:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752215AbZGYSxj
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Jul 2009 14:53:39 -0400
Received: from george.spearce.org ([209.20.77.23]:35578 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752213AbZGYSxN (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Jul 2009 14:53:13 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id B00A8381FF; Sat, 25 Jul 2009 18:53:13 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id B25B4381FD;
	Sat, 25 Jul 2009 18:53:07 +0000 (UTC)
X-Mailer: git-send-email 1.6.4.rc2.216.g769fa
In-Reply-To: <1248547982-4003-15-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124052>

Using the SectionParser based cache allows us to read through the
configuration once to produce the set of available subsections,
but then reuse that set in the future.  This makes lookups like
"find all remotes" more efficient.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../src/org/spearce/jgit/lib/Config.java           |   42 +++++++++++++++----
 1 files changed, 33 insertions(+), 9 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/Config.java b/org.spearce.jgit/src/org/spearce/jgit/lib/Config.java
index 6036c4c..1668a3f 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/Config.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/Config.java
@@ -366,15 +366,7 @@ public String getString(final String section, String subsection,
 	 *         subsection exists.
 	 */
 	public Set<String> getSubsections(final String section) {
-		final Set<String> result = new HashSet<String>();
-		for (final Entry e : state.get().entryList) {
-			if (StringUtils.equalsIgnoreCase(section, e.section)
-					&& e.subsection != null)
-				result.add(e.subsection);
-		}
-		if (baseConfig != null)
-			result.addAll(baseConfig.getSubsections(section));
-		return result;
+		return get(new SubsectionNames(section));
 	}
 
 	/**
@@ -1013,6 +1005,38 @@ private static String readValue(final StringReader in, boolean quote,
 		T parse(Config cfg);
 	}
 
+	private static class SubsectionNames implements SectionParser<Set<String>> {
+		private final String section;
+
+		SubsectionNames(final String sectionName) {
+			section = sectionName;
+		}
+
+		public int hashCode() {
+			return section.hashCode();
+		}
+
+		public boolean equals(Object other) {
+			if (other instanceof SubsectionNames) {
+				return section.equals(((SubsectionNames) other).section);
+			}
+			return false;
+		}
+
+		public Set<String> parse(Config cfg) {
+			final Set<String> result = new HashSet<String>();
+			while (cfg != null) {
+				for (final Entry e : cfg.state.get().entryList) {
+					if (e.subsection != null && e.name == null
+							&& StringUtils.equalsIgnoreCase(section, e.section))
+						result.add(e.subsection);
+				}
+				cfg = cfg.baseConfig;
+			}
+			return Collections.unmodifiableSet(result);
+		}
+	}
+
 	private static class State {
 		final List<Entry> entryList;
 
-- 
1.6.4.rc2.216.g769fa
