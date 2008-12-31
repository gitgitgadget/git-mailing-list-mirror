From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH] Improve the sideband progress scaper to be more
	accurate
Date: Wed, 31 Dec 2008 11:04:01 -0800
Message-ID: <20081231190401.GI29071@spearce.org>
References: <1230055423-9944-1-git-send-email-spearce@spearce.org> <1230055423-9944-4-git-send-email-spearce@spearce.org> <1230055423-9944-5-git-send-email-spearce@spearce.org> <200812310812.15305.robin.rosenberg@dewire.com> <20081231073505.GA22551@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Wed Dec 31 20:06:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LI6Ni-0003ln-Ma
	for gcvg-git-2@gmane.org; Wed, 31 Dec 2008 20:05:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756208AbYLaTEF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Dec 2008 14:04:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756065AbYLaTEE
	(ORCPT <rfc822;git-outgoing>); Wed, 31 Dec 2008 14:04:04 -0500
Received: from george.spearce.org ([209.20.77.23]:55426 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755889AbYLaTEC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Dec 2008 14:04:02 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id 4641C38200; Wed, 31 Dec 2008 19:04:01 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20081231073505.GA22551@spearce.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104283>

By matching only whole lines we should be able to improve the
progress scaper so we avoid ugly output like we had been seeing:

  EGIT.contrib/jgit clone git://repo.or.cz/libgit2.git LIBGIT2
  Initialized empty Git repository in /home/me/SW/LIBGIT2/.git
  Counting objects:       547
  Compressing objects:    100% (192/192)
  ts:                     100% (192/192)
  Compressing objects:    100% (192/192)
  ng objects:             100% (192/192)

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 Robin Rosenberg <robin.rosenberg@dewire.com> wrote:
 > Would it be hard to get the progress look better?

 Maybe this does the trick.  Its hard to reproduce so its hard to
 come up with the condition that was giving us the problem before.
 I suspect its because we were getting line fragments on the sideband
 channel, but I'm not sure that was really the case.

 .../jgit/transport/SideBandInputStream.java        |   37 +++++++++++++++++--
 1 files changed, 33 insertions(+), 4 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/SideBandInputStream.java b/org.spearce.jgit/src/org/spearce/jgit/transport/SideBandInputStream.java
index 3ec9bff..f0ba3d3 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/SideBandInputStream.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/SideBandInputStream.java
@@ -73,10 +73,10 @@
 	private static final int CH_ERROR = 3;
 
 	private static Pattern P_UNBOUNDED = Pattern.compile(
-			".*?([\\w ]+): (\\d+)(, done)?.*", Pattern.DOTALL);
+			"^([\\w ]+): (\\d+)( |, done)?.*", Pattern.DOTALL);
 
 	private static Pattern P_BOUNDED = Pattern.compile(
-			".*?([\\w ]+):.*\\((\\d+)/(\\d+)\\).*", Pattern.DOTALL);
+			"^([\\w ]+):.*\\((\\d+)/(\\d+)\\).*", Pattern.DOTALL);
 
 	private final PacketLineIn pckIn;
 
@@ -84,6 +84,8 @@
 
 	private final ProgressMonitor monitor;
 
+	private String progressBuffer = "";
+
 	private String currentTask;
 
 	private int lastCnt;
@@ -160,7 +162,31 @@ private void needDataPacket() throws IOException {
 		}
 	}
 
-	private void progress(final String msg) {
+	private void progress(String pkt) {
+		pkt = progressBuffer + pkt;
+		for (;;) {
+			final int lf = pkt.indexOf('\n');
+			final int cr = pkt.indexOf('\r');
+			final int s;
+			if (0 <= lf && 0 <= cr)
+				s = Math.min(lf, cr);
+			else if (0 <= lf)
+				s = lf;
+			else if (0 <= cr)
+				s = cr;
+			else
+				break;
+
+			final String msg = pkt.substring(0, s);
+			if (doProgressLine(msg))
+				pkt = pkt.substring(s + 1);
+			else
+				break;
+		}
+		progressBuffer = pkt;
+	}
+
+	private boolean doProgressLine(final String msg) {
 		Matcher matcher;
 
 		matcher = P_BOUNDED.matcher(msg);
@@ -175,7 +201,7 @@ private void progress(final String msg) {
 			final int cnt = Integer.parseInt(matcher.group(2));
 			monitor.update(cnt - lastCnt);
 			lastCnt = cnt;
-			return;
+			return true;
 		}
 
 		matcher = P_UNBOUNDED.matcher(msg);
@@ -189,7 +215,10 @@ private void progress(final String msg) {
 			final int cnt = Integer.parseInt(matcher.group(2));
 			monitor.update(cnt - lastCnt);
 			lastCnt = cnt;
+			return true;
 		}
+
+		return false;
 	}
 
 	private String readString(final int len) throws IOException {
-- 
1.6.1.59.g6f6746


-- 
Shawn.
