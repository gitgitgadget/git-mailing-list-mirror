From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH v2] Permit a wider range of repository names in jgit
	daemon requests
Date: Mon, 9 Feb 2009 07:23:37 -0800
Message-ID: <20090209152337.GH30949@spearce.org>
References: <1234151883-30479-1-git-send-email-spearce@spearce.org> <200902090847.40905.robin.rosenberg@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Mon Feb 09 16:25:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LWY0Q-0002zd-6V
	for gcvg-git-2@gmane.org; Mon, 09 Feb 2009 16:25:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754526AbZBIPXj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Feb 2009 10:23:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753266AbZBIPXj
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Feb 2009 10:23:39 -0500
Received: from george.spearce.org ([209.20.77.23]:35624 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752707AbZBIPXi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Feb 2009 10:23:38 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id A462F38210; Mon,  9 Feb 2009 15:23:37 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <200902090847.40905.robin.rosenberg@dewire.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109080>

The earlier restriction was too narrow for some applications, for
example repositories named "jgit.dev" and "jgit.test" are perfectly
valid Git repositories and should still be able to be served by
the daemon.

By blocking out only uses of ".." as a path component and Windows
UNC paths (by blocking "//") we can reasonably prevent the client
from escaping the base directories configured in the daemon.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
  Robin Rosenberg <robin.rosenberg@dewire.com> wrote:
  > Didn't I tell you // is also UNC-prefix? Windows treats / == \ at the API
  > level. Also why test for contains one "\"? And why in the middle? The
  > UNC prefix can only occur at the beginning of a path. You can use
  > File.isAbsolute to see if a name represents an absolute path. It is
  > platform-depdendent, so new File("//foo/bar").isAbsolute() yield
  > different results on Windows and unix platforms.

  *sigh*... so *that's* what happened to this patch.  I posted it,
  you sent me comments, and I forgot to correct it.  Doh.

  Sorry for blasting you with the same patch twice.  I just really
  forgot that I even posted it, let alone that you had sent me back
  comments and that was why its not in tree yet.

  I think I've addressed your concerns above in this version.
  
 .../src/org/spearce/jgit/transport/Daemon.java     |   56 ++++++++++++--------
 1 files changed, 34 insertions(+), 22 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/Daemon.java b/org.spearce.jgit/src/org/spearce/jgit/transport/Daemon.java
index 5087533..e5b446c 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/Daemon.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/Daemon.java
@@ -52,7 +52,6 @@
 import java.util.Collection;
 import java.util.HashMap;
 import java.util.Map;
-import java.util.regex.Pattern;
 
 import org.spearce.jgit.lib.PersonIdent;
 import org.spearce.jgit.lib.Repository;
@@ -64,9 +63,6 @@
 
 	private static final int BACKLOG = 5;
 
-	private static final Pattern SAFE_REPOSITORY_NAME = Pattern
-			.compile("^[A-Za-z][A-Za-z0-9/_ -]+(\\.git)?$");
-
 	private InetSocketAddress myAddress;
 
 	private final DaemonService[] services;
@@ -286,8 +282,26 @@ synchronized DaemonService matchService(final String cmd) {
 	}
 
 	Repository openRepository(String name) {
+		// Assume any attempt to use \ was by a Windows client
+		// and correct to the more typical / used in Git URIs.
+		//
+		name = name.replace('\\', '/');
+
+		// git://thishost/path should always be name="/path" here
+		//
 		if (!name.startsWith("/"))
 			return null;
+
+		// Forbid Windows UNC paths as they might escape the base
+		//
+		if (name.startsWith("//"))
+			return null;
+
+		// Forbid funny paths which contain an up-reference, they
+		// might be trying to escape and read /../etc/password.
+		//
+		if (name.contains("/../"))
+			return null;
 		name = name.substring(1);
 
 		Repository db;
@@ -301,24 +315,22 @@ synchronized (exports) {
 				return db;
 		}
 
-		if (SAFE_REPOSITORY_NAME.matcher(name).matches()) {
-			final File[] search;
-			synchronized (exportBase) {
-				search = exportBase.toArray(new File[exportBase.size()]);
-			}
-			for (final File f : search) {
-				db = openRepository(new File(f, name));
-				if (db != null)
-					return db;
-
-				db = openRepository(new File(f, name + ".git"));
-				if (db != null)
-					return db;
-
-				db = openRepository(new File(f, name + "/.git"));
-				if (db != null)
-					return db;
-			}
+		final File[] search;
+		synchronized (exportBase) {
+			search = exportBase.toArray(new File[exportBase.size()]);
+		}
+		for (final File f : search) {
+			db = openRepository(new File(f, name));
+			if (db != null)
+				return db;
+
+			db = openRepository(new File(f, name + ".git"));
+			if (db != null)
+				return db;
+
+			db = openRepository(new File(f, name + "/.git"));
+			if (db != null)
+				return db;
 		}
 		return null;
 	}
-- 
1.6.2.rc0.173.g5e148
