From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 1/1] Use 'git upload-pack' for local transport and not 'git-upload-pack'
Date: Wed,  2 Jul 2008 23:58:09 -0400
Message-ID: <1215057489-10415-1-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>,
	Marek Zawirski <marek.zawirski@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 03 09:02:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KEIpa-0003HF-5h
	for gcvg-git-2@gmane.org; Thu, 03 Jul 2008 09:02:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755480AbYGCG7c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Jul 2008 02:59:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753554AbYGCG5r
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Jul 2008 02:57:47 -0400
Received: from george.spearce.org ([209.20.77.23]:57743 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754731AbYGCD6L (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jul 2008 23:58:11 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 47F4538267; Thu,  3 Jul 2008 03:58:10 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id AA2B438262;
	Thu,  3 Jul 2008 03:58:09 +0000 (UTC)
X-Mailer: git-send-email 1.5.6.74.g8a5e
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87226>

Since Git 1.6.0 and later is heading towards moving the dash form
of commands out of the user's $PATH and into the libexec directory
we may not have 'git-upload-pack' or 'git-receive-pack' in $PATH
when the JRE tries to startup C Git for a local transport.  Instead
we should use the git wrapper, as it can select the right libexec
directory and start the correct helper program, or perform the task
internally if it is a builtin command.

In the future we should eliminate this reliance on C Git for any
sort of local transport operation.  We have direct filesystem IO
available to read from the source repository, so there is little
execuse for us to be invoking C Git for this special case.  Until
we fix it, we should at least try to ensure it works for any user.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../org/spearce/jgit/transport/TransportLocal.java |   25 ++++++++++++++++---
 1 files changed, 21 insertions(+), 4 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/TransportLocal.java b/org.spearce.jgit/src/org/spearce/jgit/transport/TransportLocal.java
index b112267..b41d4af 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/TransportLocal.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/TransportLocal.java
@@ -59,13 +59,15 @@ import org.spearce.jgit.util.FS;
  * process.
  */
 class TransportLocal extends PackTransport {
+	private static final String PWD = ".";
+
 	static boolean canHandle(final URIish uri) {
 		if (uri.getHost() != null || uri.getPort() > 0 || uri.getUser() != null
 				|| uri.getPass() != null || uri.getPath() == null)
 			return false;
 
 		if ("file".equals(uri.getScheme()) || uri.getScheme() == null)
-			return FS.resolve(new File("."), uri.getPath()).isDirectory();
+			return FS.resolve(new File(PWD), uri.getPath()).isDirectory();
 		return false;
 	}
 
@@ -74,7 +76,7 @@ class TransportLocal extends PackTransport {
 	TransportLocal(final Repository local, final URIish uri) {
 		super(local, uri);
 
-		File d = FS.resolve(new File("."), uri.getPath()).getAbsoluteFile();
+		File d = FS.resolve(new File(PWD), uri.getPath()).getAbsoluteFile();
 		if (new File(d, ".git").isDirectory())
 			d = new File(d, ".git");
 		remoteGitDir = d;
@@ -94,8 +96,23 @@ class TransportLocal extends PackTransport {
 	protected Process startProcessWithErrStream(final String cmd)
 			throws TransportException {
 		try {
-			final Process proc = Runtime.getRuntime().exec(
-					new String[] { cmd, "." }, null, remoteGitDir);
+			final String[] args;
+			final Process proc;
+
+			if (cmd.startsWith("git-")) {
+				args = new String[] { "git", cmd.substring(4), PWD };
+			} else {
+				final int gitspace = cmd.indexOf("git ");
+				if (gitspace >= 0) {
+					final String git = cmd.substring(0, gitspace + 3);
+					final String subcmd = cmd.substring(gitspace + 4);
+					args = new String[] { git, subcmd, PWD };
+				} else {
+					args = new String[] { cmd, PWD };
+				}
+			}
+
+			proc = Runtime.getRuntime().exec(args, null, remoteGitDir);
 			new StreamRewritingThread(cmd, proc.getErrorStream()).start();
 			return proc;
 		} catch (IOException err) {
-- 
1.5.6.74.g8a5e
