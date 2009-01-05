From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH] Permit a wider range of repository names in jgit daemon
	requests
Date: Sun, 4 Jan 2009 18:46:22 -0800
Message-ID: <20090105024622.GC20973@spearce.org>
References: <1229992043-1053-1-git-send-email-spearce@spearce.org> <1229992043-1053-13-git-send-email-spearce@spearce.org> <1229992043-1053-14-git-send-email-spearce@spearce.org> <200901040048.01520.robin.rosenberg@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Mon Jan 05 03:47:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LJfVJ-00035F-Lv
	for gcvg-git-2@gmane.org; Mon, 05 Jan 2009 03:47:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752035AbZAECqZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Jan 2009 21:46:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752015AbZAECqZ
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Jan 2009 21:46:25 -0500
Received: from george.spearce.org ([209.20.77.23]:44675 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751985AbZAECqY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Jan 2009 21:46:24 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id B4A3F38210; Mon,  5 Jan 2009 02:46:22 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <200901040048.01520.robin.rosenberg@dewire.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104559>

The earlier restriction was too narrow for some applications, for
example repositories named "jgit.dev" and "jgit.test" are perfectly
valid Git repositories and should still be able to be served by
the daemon.

By blocking out only uses of ".." as a path component and Windows
UNC paths (by blocking "\") we can reasonably prevent the client
from escaping the base dirctories configured in the daemon.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
  Robin Rosenberg <robin.rosenberg@dewire.com> wrote:
  > tisdag 23 december 2008 01:27:23 skrev Shawn O. Pearce:
  > > +	private static final Pattern SAFE_REPOSITORY_NAME = Pattern
  > > +			.compile("^[A-Za-z][A-Za-z0-9/_ -]+(\\.git)?$");
  > 
  > This restriction is too strict. Wouldn't any path not containing ".." be valid? In particular this did not work with my "EGIT.contrib" repo. I
  > have a lot of repos with names llike "name.purpose". Just adding
  > '.' to the character set isn't really enough.

  Yup.
  
 .../src/org/spearce/jgit/transport/Daemon.java     |   42 +++++++++----------
 1 files changed, 20 insertions(+), 22 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/Daemon.java b/org.spearce.jgit/src/org/spearce/jgit/transport/Daemon.java
index 646c88d..d39fd04 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/Daemon.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/Daemon.java
@@ -51,7 +51,6 @@
 import java.util.Collection;
 import java.util.HashMap;
 import java.util.Map;
-import java.util.regex.Pattern;
 
 import org.spearce.jgit.lib.Repository;
 
@@ -62,9 +61,6 @@
 
 	private static final int BACKLOG = 5;
 
-	private static final Pattern SAFE_REPOSITORY_NAME = Pattern
-			.compile("^[A-Za-z][A-Za-z0-9/_ -]+(\\.git)?$");
-
 	private InetSocketAddress myAddress;
 
 	private final DaemonService[] services;
@@ -292,24 +288,26 @@ synchronized (exports) {
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
+		if (name.startsWith("../") || name.contains("/../")
+				|| name.contains("\\"))
+			return null;
+
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
1.6.1.94.g9388

-- 
Shawn.
