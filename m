From: Constantine Plotnikov <constantine.plotnikov@gmail.com>
Subject: [JGIT PATCH 2/3] Config.getSubsections(...) now loads the file if it has not been loaded
Date: Wed, 24 Jun 2009 21:48:04 +0400
Message-ID: <1245865685-1288-3-git-send-email-constantine.plotnikov@gmail.com>
References: <1245865685-1288-1-git-send-email-constantine.plotnikov@gmail.com>
 <1245865685-1288-2-git-send-email-constantine.plotnikov@gmail.com>
Cc: Constantine Plotnikov <constantine.plotnikov@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 24 19:48:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MJWac-0003ms-1Z
	for gcvg-git-2@gmane.org; Wed, 24 Jun 2009 19:48:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761374AbZFXRsL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Jun 2009 13:48:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761203AbZFXRsK
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Jun 2009 13:48:10 -0400
Received: from mail.intellij.net ([213.182.181.98]:51266 "EHLO
	mail.intellij.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760141AbZFXRsJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Jun 2009 13:48:09 -0400
Received: (qmail 32352 invoked by uid 89); 24 Jun 2009 17:48:05 -0000
Received: by simscan 1.1.0 ppid: 32219, pid: 32337, t: 0.0049s
         scanners: regex: 1.1.0
Received: from unknown (HELO localhost.localdomain) (Constantine.Plotnikov@jetbrains.com@172.26.240.76)
  by mail.intellij.net with ESMTPA; 24 Jun 2009 17:48:05 -0000
X-Mailer: git-send-email 1.6.1.2
In-Reply-To: <1245865685-1288-2-git-send-email-constantine.plotnikov@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122149>

If method getSubsections() is invoked before any entry in the config
file is accessed via get*(section, subsection, name) methods,
NPE is thrown because file is not yet loaded. This patch fixes the
problem by ensuring that file is loaded before iterating entries
in this method.

Signed-off-by: Constantine Plotnikov <constantine.plotnikov@gmail.com>
---
 .../src/org/spearce/jgit/lib/Config.java           |    9 +++++++--
 1 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/Config.java b/org.spearce.jgit/src/org/spearce/jgit/lib/Config.java
index 62daef3..4220c37 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/Config.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/Config.java
@@ -367,6 +367,7 @@ public String getString(final String section, String subsection,
 	 */
 	public Set<String> getSubsections(final String section) {
 		final Set<String> result = new HashSet<String>();
+		ensureLoaded();
 
 		for (final Entry e : entries) {
 			if (section.equalsIgnoreCase(e.base) && e.extendedBase != null)
@@ -401,8 +402,7 @@ private String getRawString(final String section, final String subsection,
 			return null;
 	}
 
-	private Object getRawEntry(final String section, final String subsection,
-			final String name) {
+	private void ensureLoaded() {
 		if (!readFile) {
 			try {
 				load();
@@ -413,6 +413,11 @@ private Object getRawEntry(final String section, final String subsection,
 				err.printStackTrace();
 			}
 		}
+	}
+
+	private Object getRawEntry(final String section, final String subsection,
+			final String name) {
+		ensureLoaded();
 
 		String ss;
 		if (subsection != null)
-- 
1.6.1.2
