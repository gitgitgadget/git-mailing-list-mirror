From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: [EGIT RFC PATCH(was Re: egit problem with sym linked eclipse project dirs)] Add some support for symlinked projects.
Date: Wed, 11 Mar 2009 23:17:41 +0100
Message-ID: <200903112317.41380.robin.rosenberg.lists@dewire.com>
References: <p0624081cc5928e2885fd@[192.168.1.114]> <p06240812c59ed365d694@[192.168.1.106]> <200901232233.59232.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Stephen Bannasch <stephen.bannasch@deanbrook.org>
X-From: git-owner@vger.kernel.org Wed Mar 11 23:26:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LhWs7-0003cD-Iv
	for gcvg-git-2@gmane.org; Wed, 11 Mar 2009 23:25:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753112AbZCKWYI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Mar 2009 18:24:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752322AbZCKWYG
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Mar 2009 18:24:06 -0400
Received: from mail.dewire.com ([83.140.172.130]:1160 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751759AbZCKWYF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Mar 2009 18:24:05 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id D9317139A44A;
	Wed, 11 Mar 2009 23:23:57 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9rJIgZvUwkDf; Wed, 11 Mar 2009 23:23:56 +0100 (CET)
Received: from sleipner.localnet (unknown [10.9.0.2])
	by dewire.com (Postfix) with ESMTP id C05318006B8;
	Wed, 11 Mar 2009 23:23:56 +0100 (CET)
User-Agent: KMail/1.11.1 (Linux/2.6.27-12-generic; KDE/4.2.1; i686; ; )
In-Reply-To: <200901232233.59232.robin.rosenberg.lists@dewire.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112985>

If a project is not in therepository via the path we found it,  we look for its canonical path and
see if that path is in the repository.

We only do this lookup at the project level. Odd linking at resource level
will not be recognized because this lookup is expensive.
---
 .../egit/core/project/RepositoryMapping.java       |   54 ++++++++++++++++++-
 1 files changed, 51 insertions(+), 3 deletions(-)

fredag 23 januari 2009 22:33:59 skrev Robin Rosenberg <robin.rosenberg.lists@dewire.com>:
> fredag 23 januari 2009 02:56:16 skrev Stephen Bannasch:
> > At 6:27 PM -0500 1/13/09, Stephen Bannasch wrote:
> ...
> > >Done: http://code.google.com/p/egit/issues/detail?id=52
> > >
> > >Fxing this will make using Eclipse and Git together SO much nicer!

Since I started looking at this, I may as well post what I came up with before
I lost interest in the issue.

This patch solved some of the problem. I'm not sure it doesn't cause more
problem than it solves, e.g. should the solution support more fine grained
handling of links, be faster or.. 

Shawn: don't  push in this state. 
Stephen: come up with a test suite and pro's cons, potholes etc.

-- robin

diff --git a/org.spearce.egit.core/src/org/spearce/egit/core/project/RepositoryMapping.java b/org.spearce.egit.core/src/org/spearce/egit/core/project/RepositoryMapping.java
index e9df630..f2a0977 100644
--- a/org.spearce.egit.core/src/org/spearce/egit/core/project/RepositoryMapping.java
+++ b/org.spearce.egit.core/src/org/spearce/egit/core/project/RepositoryMapping.java
@@ -23,6 +23,7 @@
 import org.eclipse.core.runtime.IPath;
 import org.eclipse.core.runtime.Path;
 import org.eclipse.team.core.RepositoryProvider;
+import org.spearce.egit.core.Activator;
 import org.spearce.egit.core.GitProvider;
 import org.spearce.jgit.lib.Constants;
 import org.spearce.jgit.lib.GitIndex;
@@ -49,6 +50,10 @@ static boolean isInitialKey(final String key) {
 
 	private IContainer container;
 
+	private String replace;
+
+	private String replaceWith;
+
 	/**
 	 * Construct a {@link RepositoryMapping} for a previously connected project.
 	 *
@@ -97,6 +102,45 @@ public RepositoryMapping(final IContainer mappedContainer, final File gitDir) {
 		}
 	}
 
+	private void checkIsLinked() {
+		File containerFile = container.getLocation().toFile();
+		String absoluteContainer = containerFile.getAbsoluteFile().getPath();
+		String canonicalContainer;
+		try {
+			canonicalContainer = containerFile.getCanonicalFile().getPath();
+			if (!absoluteContainer.equals(canonicalContainer)) {
+				int ic = canonicalContainer.length() - 1;
+				int ac = absoluteContainer.length() - 1;
+				char lastCh = File.separatorChar;
+				while (ic >= 0 && ac >= 0) {
+					char curchar = canonicalContainer.charAt(ic);
+					if (curchar != absoluteContainer.charAt(ac)) {
+						if (lastCh == File.separatorChar) {
+							String linkPointSrc = absoluteContainer.substring(
+									0, ac + 1);
+							String linkPointDest = canonicalContainer
+									.substring(workdirPrefix.length(), ic + 1);
+							replace = linkPointSrc.substring(
+									workdirPrefix.length()).replace(
+									File.separatorChar, '/');
+							replaceWith = linkPointDest.replace(
+									File.separatorChar, '/');
+							break;
+						}
+					}
+					lastCh = curchar;
+					ic--;
+					ac--;
+				}
+				if (ic == 0 || ac == 0)
+					Activator.logError(String.format("Cannot find the canonical location of %s within the repo %s", containerFile.toString(), gitdirPath), null);
+
+			}
+		} catch (IOException e) {
+			Activator.logError("Cannot get canonical path for container " + container.toString(), e);
+		}
+	}
+
 	IPath getContainerPath() {
 		return Path.fromPortableString(containerPath);
 	}
@@ -136,6 +180,7 @@ synchronized void setRepository(final Repository r) {
 		workdirPrefix = workdirPrefix.replace('\\', '/');
 		if (!workdirPrefix.endsWith("/"))
 			workdirPrefix += "/";
+		checkIsLinked();
 	}
 
 	/**
@@ -209,9 +254,12 @@ public String getRepoRelativePath(final IResource rsrc) {
 		final int pfxLen = workdirPrefix.length();
 		final String p = rsrc.getLocation().toString();
 		final int pLen = p.length();
-		if (pLen > pfxLen)
+		if (pLen > pfxLen) {
+			if (replace != null) {
+				return replaceWith + "/" + p.substring(pfxLen + replace.length() + 1);
+			}
 			return p.substring(pfxLen);
-		else if (p.length() == pfxLen - 1)
+		} else if (p.length() == pfxLen - 1)
 			return "";
 		return null;
 	}
-- 
1.6.1.285.g35d8b
