From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] Optimize prefixcmp()
Date: Sat, 29 Dec 2007 20:22:14 +0100 (CET)
Message-ID: <Pine.LNX.4.64.0712292019450.14355@wbgn129.biozentrum.uni-wuerzburg.de>
References: <e5bfff550712291001q5f246ceah6700b98308fb96f1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: Marco Costalba <mcostalba@gmail.com>
X-From: git-owner@vger.kernel.org Sat Dec 29 20:22:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J8hGc-0006c2-JY
	for gcvg-git-2@gmane.org; Sat, 29 Dec 2007 20:22:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750993AbXL2TWS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Dec 2007 14:22:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751122AbXL2TWR
	(ORCPT <rfc822;git-outgoing>); Sat, 29 Dec 2007 14:22:17 -0500
Received: from mail.gmx.net ([213.165.64.20]:33855 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750978AbXL2TWR (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Dec 2007 14:22:17 -0500
Received: (qmail invoked by alias); 29 Dec 2007 19:22:14 -0000
Received: from wbgn128.biozentrum.uni-wuerzburg.de (EHLO wrzx67.rz.uni-wuerzburg.de) [132.187.25.128]
  by mail.gmx.net (mp046) with SMTP; 29 Dec 2007 20:22:14 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18DYo0q/Q0Dolx48WUWMCFGCy4FRTw1/WwSgUiv9N
	OQiEEersASFiih
X-X-Sender: gene099@wbgn129.biozentrum.uni-wuerzburg.de
In-Reply-To: <e5bfff550712291001q5f246ceah6700b98308fb96f1@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69325>


Certain codepaths (notably "git log --pretty=format...") use
prefixcmp() extensively, with very short prefixes.  In those cases,
calling strlen() is a wasteful operation, so avoid it.

Initial patch by Marco Costalba.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	On Sat, 29 Dec 2007, Marco Costalba wrote:

	> In case the prefix string is a single char avoid a costly call 
	> to strlen() + strncmp()

	Could you test this patch, please?

	Not only does it avoid the strlen() call also for longer prefixes; 
	it also avoids a C++ comment.

 git-compat-util.h |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/git-compat-util.h b/git-compat-util.h
index 79eb10e..7059cbd 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -398,7 +398,11 @@ static inline int sane_case(int x, int high)
 
 static inline int prefixcmp(const char *str, const char *prefix)
 {
-	return strncmp(str, prefix, strlen(prefix));
+	for (; ; str++, prefix++)
+		if (!*prefix)
+			return 0;
+		else if (*str != *prefix)
+			return (unsigned char)*prefix - (unsigned char)*str;
 }
 
 static inline int strtoul_ui(char const *s, int base, unsigned int *result)
-- 
1.5.2.rc0.4321.gd618
