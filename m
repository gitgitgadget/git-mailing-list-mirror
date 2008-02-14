From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 1/3] http-push: avoid invalid memory accesses
Date: Thu, 14 Feb 2008 23:25:33 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802142325120.30505@racer.site>
References: <alpine.LSU.1.00.0802142319340.30505@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org, gitster@pobox.com, mh@glandium.org
X-From: git-owner@vger.kernel.org Fri Feb 15 00:26:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JPnSy-0000rL-Ov
	for gcvg-git-2@gmane.org; Fri, 15 Feb 2008 00:26:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757742AbYBNXZh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Feb 2008 18:25:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757120AbYBNXZh
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Feb 2008 18:25:37 -0500
Received: from mail.gmx.net ([213.165.64.20]:42568 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757011AbYBNXZg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Feb 2008 18:25:36 -0500
Received: (qmail invoked by alias); 14 Feb 2008 23:25:34 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp017) with SMTP; 15 Feb 2008 00:25:34 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19KBuYsJYlKrqakcwQUt5me7an4fqNVEmvn8wiD3E
	eDazf+CDFAJQHj
X-X-Sender: gene099@racer.site
In-Reply-To: <alpine.LSU.1.00.0802142319340.30505@racer.site>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73924>


Before objects are sent, the respective ref is locked.  However,
without this patch, the lock is lifted before the last object for
that ref was sent.  As a consequence, the lock data was accessed
after the lock structure was free()d.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 http-push.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/http-push.c b/http-push.c
index b2b410d..7a6c669 100644
--- a/http-push.c
+++ b/http-push.c
@@ -2398,7 +2398,10 @@ int main(int argc, char **argv)
 		fill_active_slots();
 		add_fill_function(NULL, fill_active_slot);
 #endif
-		finish_all_active_slots();
+		do {
+			finish_all_active_slots();
+			fill_active_slots();
+		} while (request_queue_head && !aborted);
 
 		/* Update the remote branch if all went well */
 		if (aborted || !update_remote(ref->new_sha1, ref_lock)) {
-- 
1.5.4.1.1353.g0d5dd
