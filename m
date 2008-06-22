From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [jgit PATCH] Paper bag fix quoting for SSH transport commands
Date: Sat, 21 Jun 2008 21:36:40 -0400
Message-ID: <20080622013640.GA18629@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Robin Rosenberg <robin.rosenberg@dewire.com>,
	Marek Zawirski <marek.zawirski@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 22 03:38:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KAEX9-0004gj-L7
	for gcvg-git-2@gmane.org; Sun, 22 Jun 2008 03:38:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752497AbYFVBgp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Jun 2008 21:36:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752407AbYFVBgp
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Jun 2008 21:36:45 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:49116 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752074AbYFVBgo (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Jun 2008 21:36:44 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.69)
	(envelope-from <spearce@spearce.org>)
	id 1KAEVL-000770-Bc; Sat, 21 Jun 2008 21:36:31 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 9AE6320FBAE; Sat, 21 Jun 2008 21:36:40 -0400 (EDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85744>

Not all Git-over-SSH servers run a Bourne shell on the remote side
to evaluate the command we are sending.  Some servers run git-shell,
which will fail to execute git-upload-pack if we feed it a quoted
string for the name git-upload-pack.

Testing concludes that git-shell requires the command name to never
be quoted, and the argument name to always be single quoted.  As
this is a long-standing behavior in the wild jgit needs to conform,
as git-shell and all git-shell work-a-likes such as gitosis may be
following the same convention.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---

 If there are no arguments I'll push this into the public tree.
 It seems right on the surface, and is necessary to use jgit against
 repo.or.cz, and probably many other sites like it.

 .../spearce/jgit/transport/TransportGitSsh.java    |   22 ++++++++++++++++++-
 1 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/TransportGitSsh.java b/org.spearce.jgit/src/org/spearce/jgit/transport/TransportGitSsh.java
index d31c525..8944df7 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/TransportGitSsh.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/TransportGitSsh.java
@@ -88,6 +88,24 @@ class TransportGitSsh extends PackTransport {
 		return new SshFetchConnection();
 	}
 
+	private static void sqMinimal(final StringBuilder cmd, final String val) {
+		if (val.matches("^[a-zA-Z0-9._/-]*$")) {
+			// If the string matches only generally safe characters
+			// that the shell is not going to evaluate specially we
+			// should leave the string unquoted. Not all systems
+			// actually run a shell and over-quoting confuses them
+			// when it comes to the command name.
+			//
+			cmd.append(val);
+		} else {
+			sq(cmd, val);
+		}
+	}
+
+	private static void sqAlways(final StringBuilder cmd, final String val) {
+		sq(cmd, val);
+	}
+
 	private static void sq(final StringBuilder cmd, final String val) {
 		int i = 0;
 
@@ -157,9 +175,9 @@ class TransportGitSsh extends PackTransport {
 				path = (uri.getPath().substring(1));
 
 			final StringBuilder cmd = new StringBuilder();
-			sq(cmd, exe);
+			sqMinimal(cmd, exe);
 			cmd.append(' ');
-			sq(cmd, path);
+			sqAlways(cmd, path);
 			channel.setCommand(cmd.toString());
 			channel.setErrStream(System.err);
 			channel.connect();
-- 
1.5.6.74.g8a5e
