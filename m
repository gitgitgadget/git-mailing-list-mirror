From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH/RFH] pp_header(): work around possible memory corruption
Date: Fri, 15 Jun 2007 13:19:07 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0706151318210.4059@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Jun 15 14:22:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HzAp1-00088z-Ea
	for gcvg-git@gmane.org; Fri, 15 Jun 2007 14:22:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752844AbXFOMWe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 15 Jun 2007 08:22:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752192AbXFOMWe
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Jun 2007 08:22:34 -0400
Received: from mail.gmx.net ([213.165.64.20]:56283 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752185AbXFOMWd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jun 2007 08:22:33 -0400
Received: (qmail invoked by alias); 15 Jun 2007 12:22:32 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp031) with SMTP; 15 Jun 2007 14:22:32 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+3eUpFB7y3RUOI2uYd4tDwoFrbDTStmgodAqVy2B
	52lNUpMcXTzJXR
X-X-Sender: gene099@racer.site
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50259>


add_user_info() possibly adds way more than just the commit header line. 
In fact, it sometimes needs so much more space that there is a buffer 
overrun, leading to an ugly crash. For example, the date is printed in its 
own line, and usually takes up more space than the equivalent Unix epoch.

So, for good measure, add 80 characters (a full line) to the allocated 
space, in addition to the header line length.

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>

---

	I have no idea if 80 is a good value, and if other places
	need an equivalent fix up, too.

	But I needed this patch in a hurry...

 commit.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/commit.c b/commit.c
index f778bf4..03436b1 100644
--- a/commit.c
+++ b/commit.c
@@ -997,7 +997,7 @@ static void pp_header(enum cmit_fmt fmt,
 			len = linelen;
 			if (fmt == CMIT_FMT_EMAIL)
 				len = bound_rfc2047(linelen, encoding);
-			ALLOC_GROW(*buf_p, *ofs_p + len, *space_p);
+			ALLOC_GROW(*buf_p, *ofs_p + len + 80, *space_p);
 			dst = *buf_p + *ofs_p;
 			*ofs_p += add_user_info("Author", fmt, dst,
 						line + 7, dmode, encoding);
@@ -1008,7 +1008,7 @@ static void pp_header(enum cmit_fmt fmt,
 			len = linelen;
 			if (fmt == CMIT_FMT_EMAIL)
 				len = bound_rfc2047(linelen, encoding);
-			ALLOC_GROW(*buf_p, *ofs_p + len, *space_p);
+			ALLOC_GROW(*buf_p, *ofs_p + len + 80, *space_p);
 			dst = *buf_p + *ofs_p;
 			*ofs_p += add_user_info("Commit", fmt, dst,
 						line + 10, dmode, encoding);
