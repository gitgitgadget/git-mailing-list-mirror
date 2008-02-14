From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH 3/6] Refactor packet_write to prepare to integrate with sideband
Date: Thu, 14 Feb 2008 01:22:39 -0500
Message-ID: <20080214062239.GC30516@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 14 07:23:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JPXVB-0002zA-2d
	for gcvg-git-2@gmane.org; Thu, 14 Feb 2008 07:23:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753188AbYBNGWn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Feb 2008 01:22:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753452AbYBNGWn
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Feb 2008 01:22:43 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:58385 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753001AbYBNGWm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Feb 2008 01:22:42 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1JPXUX-0003o7-9a
	for git@vger.kernel.org; Thu, 14 Feb 2008 01:22:41 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id DA82720FBAE; Thu, 14 Feb 2008 01:22:39 -0500 (EST)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73852>

Simple refactoring to move the actual formatting into a
helper function.  Later we'll integrate this new helper
with sideband support, so we can embed a packet line
within a multiplexed sideband stream.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 pkt-line.c |   17 +++++++++++++----
 1 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/pkt-line.c b/pkt-line.c
index 355546a..5917e1d 100644
--- a/pkt-line.c
+++ b/pkt-line.c
@@ -43,16 +43,16 @@ void packet_flush(int fd)
 }
 
 #define hex(a) (hexchar[(a) & 15])
-void packet_write(int fd, const char *fmt, ...)
+static void packet_vwrite(
+	int fd,
+	const char *fmt,
+	va_list args)
 {
 	static char buffer[1000];
 	static char hexchar[] = "0123456789abcdef";
-	va_list args;
 	unsigned n;
 
-	va_start(args, fmt);
 	n = vsnprintf(buffer + 4, sizeof(buffer) - 4, fmt, args);
-	va_end(args);
 	if (n >= sizeof(buffer)-4)
 		die("protocol error: impossibly long line");
 	n += 4;
@@ -63,6 +63,15 @@ void packet_write(int fd, const char *fmt, ...)
 	safe_write(fd, buffer, n);
 }
 
+void packet_write(int fd, const char *fmt, ...)
+{
+	va_list args;
+
+	va_start(args, fmt);
+	packet_vwrite(fd, fmt, args);
+	va_end(args);
+}
+
 static void safe_read(int fd, void *buffer, unsigned size)
 {
 	size_t n = 0;
-- 
1.5.4.1.1309.g833c2
