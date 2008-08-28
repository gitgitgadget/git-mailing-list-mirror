From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 1/2 v2] Ignore unreadable SSH private keys when
	autoloading identities
Date: Wed, 27 Aug 2008 17:24:06 -0700
Message-ID: <20080828002406.GU26523@spearce.org>
References: <1219878126-18622-1-git-send-email-spearce@spearce.org> <48B5E2A1.3030007@gmail.com> <20080827232946.GS26523@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>,
	Marek Zawirski <marek.zawirski@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 28 02:25:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYVK6-0004eO-O0
	for gcvg-git-2@gmane.org; Thu, 28 Aug 2008 02:25:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753971AbYH1AYK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Aug 2008 20:24:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752359AbYH1AYJ
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Aug 2008 20:24:09 -0400
Received: from george.spearce.org ([209.20.77.23]:47984 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751976AbYH1AYI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Aug 2008 20:24:08 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id EBDB838375; Thu, 28 Aug 2008 00:24:06 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20080827232946.GS26523@spearce.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94000>

During SSH startup we read all keys in the user's ~/.ssh, even
if we may not need them for this particular transport session.

If a file is not really a key, or it contains a key that JSch
doesn't recognize we shouldn't crash the transport.  Instead
we should skip the file and move on.  Later on we just don't
have that identity available to us, or we'll crash if we try
to add that identity file explicitly from ~/.ssh/config.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---

  "Shawn O. Pearce" <spearce@spearce.org> wrote:
  > Marek Zawirski <marek.zawirski@gmail.com> wrote:
  > > Shawn O. Pearce wrote:
  > >> diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/DefaultSshSessionFactory.java b/org.spearce.jgit/src/org/spearce/jgit/transport/DefaultSshSessionFactory.java
  > > (...)
  > >> +			try {
  > >> +				addIdentity(k);
  > >> +			} catch (JSchException e) {
  > >> +				if (e.getMessage().startsWith("invalid privatekey: "))
  > >> +					continue;
  > >> +				throw e;
  > >> +			}
  > >
  > > That's extreme error handling with JSch;) Do you really think it's  
  > > better to rely on internal error message instead of continuing in any  
  > > case? Which other exceptions we would like to pass level up?
  > 
  > I guess I can just change this to ignore everything.

 .../jgit/transport/DefaultSshSessionFactory.java   |   11 +++++++++--
 1 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/DefaultSshSessionFactory.java b/org.spearce.jgit/src/org/spearce/jgit/transport/DefaultSshSessionFactory.java
index a2437c2..74fca66 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/DefaultSshSessionFactory.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/DefaultSshSessionFactory.java
@@ -165,14 +165,21 @@ private void identities() throws JSchException {
 			final File k = new File(sshdir, n.substring(0, n.length() - 4));
 			if (!k.isFile())
 				continue;
-			addIdentity(k);
+
+			try {
+				addIdentity(k);
+			} catch (JSchException e) {
+				continue;
+			}
 		}
 	}
 
 	private void addIdentity(final File identityFile) throws JSchException {
 		final String path = identityFile.getAbsolutePath();
-		if (loadedIdentities.add(path))
+		if (!loadedIdentities.contains(path)) {
 			userJSch.addIdentity(path);
+			loadedIdentities.add(path);
+		}
 	}
 
 	private static class AWT_UserInfo implements UserInfo,
-- 
1.6.0.174.gd789c
