From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [JGIT PATCH v2] Fix a race condition when loading non-mmapd
	byte windows
Date: Sat, 7 Mar 2009 17:24:15 -0800
Message-ID: <20090308012415.GT16213@spearce.org>
References: <1236471125-21382-1-git-send-email-spearce@spearce.org> <1236471435-21888-1-git-send-email-spearce@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Sun Mar 08 02:25:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lg7ly-0001wJ-HL
	for gcvg-git-2@gmane.org; Sun, 08 Mar 2009 02:25:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753153AbZCHBYS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Mar 2009 20:24:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753119AbZCHBYS
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Mar 2009 20:24:18 -0500
Received: from george.spearce.org ([209.20.77.23]:41445 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752931AbZCHBYR (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Mar 2009 20:24:17 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id 0017938211; Sun,  8 Mar 2009 01:24:15 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1236471435-21888-1-git-send-email-spearce@spearce.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112606>

"Shawn O. Pearce" <spearce@spearce.org> wrote:
>  Oh hell, I missed the fact that markLoaded(ByteWindow) may be
>  dropping the last reference and need to close the file.

*and* you need to squash this in to prevent a deadlock:

Frell.  What a Saturday.

diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/ByteArrayWindow.java b/org.spearce.jgit/src/org/spearce/jgit/lib/ByteArrayWindow.java
index 055a329..c07a260 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/ByteArrayWindow.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/ByteArrayWindow.java
@@ -100,16 +100,25 @@ void inflateVerify(final byte[] array, final int pos, final Inflater inf)
 			inf.inflate(verifyGarbageBuffer, 0, verifyGarbageBuffer.length);
 	}
 
-	synchronized void ensureLoaded(final byte[] array) {
-		if (!loaded) {
-			try {
-				provider.fd.getChannel().read(ByteBuffer.wrap(array), start);
-			} catch (IOException e) {
-				throw new RuntimeException("Cannot fault in window", e);
-			} finally {
+	void ensureLoaded(final byte[] array) {
+		boolean release = false;
+		try {
+			synchronized (this) {
+				if (!loaded) {
+					release = true;
+					try {
+						provider.fd.getChannel().read(ByteBuffer.wrap(array),
+								start);
+					} catch (IOException e) {
+						throw new RuntimeException("Cannot fault in window", e);
+					}
+					loaded = true;
+				}
+			}
+		} finally {
+			if (release) {
 				WindowCache.markLoaded(this);
 			}
-			loaded = true;
 		}
 	}
 }
\ No newline at end of file

-- 
Shawn.
