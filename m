From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 12/19] Return base values first from Config.getStringList()
Date: Sat, 25 Jul 2009 11:52:55 -0700
Message-ID: <1248547982-4003-13-git-send-email-spearce@spearce.org>
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
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Sat Jul 25 20:54:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MUmO5-0002ZF-Uw
	for gcvg-git-2@gmane.org; Sat, 25 Jul 2009 20:54:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752204AbZGYSxc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Jul 2009 14:53:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751877AbZGYSxa
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Jul 2009 14:53:30 -0400
Received: from george.spearce.org ([209.20.77.23]:35575 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752201AbZGYSxL (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Jul 2009 14:53:11 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id C95EC38215; Sat, 25 Jul 2009 18:53:11 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id AA74638221;
	Sat, 25 Jul 2009 18:53:06 +0000 (UTC)
X-Mailer: git-send-email 1.6.4.rc2.216.g769fa
In-Reply-To: <1248547982-4003-12-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124044>

C Git's `git config --get-all foo.bar` returns the base configuration
values for foo.bar (aka those found in /etc/gitconfig or ~/.gitconfig)
before the repository specific configuration values for foo.bar.  To
better match C Git behavior when processing a multi-value key we must
do the same in our getStringList() method.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../src/org/spearce/jgit/lib/Config.java           |   24 +++++++++++++++----
 1 files changed, 19 insertions(+), 5 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/Config.java b/org.spearce.jgit/src/org/spearce/jgit/lib/Config.java
index 0f91412..f4e78f3 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/Config.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/Config.java
@@ -55,6 +55,7 @@
  * Git style {@code .config}, {@code .gitconfig}, {@code .gitmodules} file.
  */
 public class Config {
+	private static final String[] EMPTY_STRING_ARRAY = {};
 	private static final long KiB = 1024;
 	private static final long MiB = 1024 * KiB;
 	private static final long GiB = 1024 * MiB;
@@ -316,6 +317,9 @@ public String getString(final String section, String subsection,
 
 	/**
 	 * Get a list of string values
+	 * <p>
+	 * If this instance was created with a base, the base's values are returned
+	 * first (if any).
 	 *
 	 * @param section
 	 *            the section
@@ -327,12 +331,22 @@ public String getString(final String section, String subsection,
 	 */
 	public String[] getStringList(final String section, String subsection,
 			final String name) {
-		final List<String> lst = getRawStringList(section, subsection, name);
-		if (lst != null)
-			return lst.toArray(new String[lst.size()]);
+		final String[] baseList;
 		if (baseConfig != null)
-			return baseConfig.getStringList(section, subsection, name);
-		return new String[0];
+			baseList = baseConfig.getStringList(section, subsection, name);
+		else
+			baseList = EMPTY_STRING_ARRAY;
+
+		final List<String> lst = getRawStringList(section, subsection, name);
+		if (lst != null) {
+			final String[] res = new String[baseList.length + lst.size()];
+			int idx = baseList.length;
+			System.arraycopy(baseList, 0, res, 0, idx);
+			for (final String val : lst)
+				res[idx++] = val;
+			return res;
+		}
+		return baseList;
 	}
 
 	/**
-- 
1.6.4.rc2.216.g769fa
