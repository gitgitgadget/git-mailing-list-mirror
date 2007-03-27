From: Jeff King <peff@peff.net>
Subject: [PATCH] --pretty=format: fix broken %ct and %at interpolation
Date: Tue, 27 Mar 2007 19:26:28 -0400
Message-ID: <20070327232628.GA9981@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes.Schindelin@gmx.de, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed Mar 28 01:26:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HWL3i-0007Hk-G8
	for gcvg-git@gmane.org; Wed, 28 Mar 2007 01:26:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933364AbXC0X0c (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Mar 2007 19:26:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933413AbXC0X0c
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Mar 2007 19:26:32 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2394 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933364AbXC0X0b (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Mar 2007 19:26:31 -0400
Received: (qmail 5881 invoked from network); 27 Mar 2007 23:27:01 -0000
Received: from coredump.intra.peff.net (10.0.0.2)
  by peff.net with (DHE-RSA-AES128-SHA encrypted) SMTP; 27 Mar 2007 23:27:01 -0000
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 27 Mar 2007 19:26:29 -0400
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43320>

A pointer arithmetic error in fill_person caused random data
from the commit object to be included with the timestamp,
which looked something like:

    $ git-rev-list --pretty=format:%ct origin/next | head
    commit 98453bdb3db10db26099749bc4f2dc029bed9aa9
    1174977948 -0700

    Merge branch 'master' into next

    * master:
      Bisect: Use
    commit c0ce981f5ebfd02463ff697b2fca52c7a54b0625
    1174889646 -0700

Signed-off-by: Jeff King <peff@peff.net>
---
 commit.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/commit.c b/commit.c
index 718e568..a92958c 100644
--- a/commit.c
+++ b/commit.c
@@ -760,7 +760,7 @@ static void fill_person(struct interp *table, const char *msg, int len)
 	if (msg + start == ep)
 		return;
 
-	table[5].value = xstrndup(msg + start, ep - msg + start);
+	table[5].value = xstrndup(msg + start, ep - (msg + start));
 
 	/* parse tz */
 	for (start = ep - msg + 1; start < len && isspace(msg[start]); start++)
-- 
1.5.1.rc2.618.g98453b
