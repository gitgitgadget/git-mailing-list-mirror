From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH] Handle broken vsnprintf implementations in strbuf
Date: Tue, 13 Nov 2007 03:22:44 -0500
Message-ID: <20071113082244.GA12565@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 13 09:23:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Irr35-0004pC-Rm
	for gcvg-git-2@gmane.org; Tue, 13 Nov 2007 09:23:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750964AbXKMIWt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Nov 2007 03:22:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750982AbXKMIWt
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Nov 2007 03:22:49 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:57725 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750956AbXKMIWt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Nov 2007 03:22:49 -0500
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1Irr2j-0000AO-EK; Tue, 13 Nov 2007 03:22:45 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id AA6BE20FBAE; Tue, 13 Nov 2007 03:22:44 -0500 (EST)
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64766>

Solaris 9's vsnprintf implementation returns -1 if we pass it a
buffer of length 0.  The only way to get it to give us the actual
length necessary for the formatted string is to grow the buffer
out to have at least 1 byte available in the strbuf and then ask
it to compute the length.

If the available space is 0 I'm growing it out by 64 to ensure
we will get an accurate length estimate from all implementations.
Some callers may need to grow the strbuf again but 64 should be a
reasonable enough initial growth.

We also no longer silently fail to append to the string when we are
faced with a broken vsnprintf implementation.  On Solaris 9 this
silent failure caused me to no longer be able to execute "git clone"
as we tried to exec the empty string rather than "git-clone".

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 strbuf.c |    7 ++++---
 trace.c  |    4 ++--
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/strbuf.c b/strbuf.c
index dbd8c4b..b9b194b 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -118,12 +118,13 @@ void strbuf_addf(struct strbuf *sb, const char *fmt, ...)
 	int len;
 	va_list ap;
 
+	if (!strbuf_avail(sb))
+		strbuf_grow(sb, 64);
 	va_start(ap, fmt);
 	len = vsnprintf(sb->buf + sb->len, sb->alloc - sb->len, fmt, ap);
 	va_end(ap);
-	if (len < 0) {
-		len = 0;
-	}
+	if (len < 0)
+		die("your vsnprintf is broken");
 	if (len > strbuf_avail(sb)) {
 		strbuf_grow(sb, len);
 		va_start(ap, fmt);
diff --git a/trace.c b/trace.c
index 69fa05e..0d89dbe 100644
--- a/trace.c
+++ b/trace.c
@@ -72,7 +72,7 @@ void trace_printf(const char *fmt, ...)
 	if (!fd)
 		return;
 
-	strbuf_init(&buf, 0);
+	strbuf_init(&buf, 64);
 	va_start(ap, fmt);
 	len = vsnprintf(buf.buf, strbuf_avail(&buf), fmt, ap);
 	va_end(ap);
@@ -103,7 +103,7 @@ void trace_argv_printf(const char **argv, int count, const char *fmt, ...)
 	if (!fd)
 		return;
 
-	strbuf_init(&buf, 0);
+	strbuf_init(&buf, 64);
 	va_start(ap, fmt);
 	len = vsnprintf(buf.buf, strbuf_avail(&buf), fmt, ap);
 	va_end(ap);
-- 
1.5.3.5.1661.gcbf0
