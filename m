From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] Fix "git clone" for git:// protocol
Date: Sat, 9 Feb 2008 16:58:07 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802091657000.11591@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org, gitster@pobox.com, barkalow@iabervon.org
X-From: git-owner@vger.kernel.org Sat Feb 09 17:58:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JNt2I-00008X-Eu
	for gcvg-git-2@gmane.org; Sat, 09 Feb 2008 17:58:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754603AbYBIQ6H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Feb 2008 11:58:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754302AbYBIQ6G
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Feb 2008 11:58:06 -0500
Received: from mail.gmx.net ([213.165.64.20]:33569 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754579AbYBIQ6E (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Feb 2008 11:58:04 -0500
Received: (qmail invoked by alias); 09 Feb 2008 16:58:01 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp022) with SMTP; 09 Feb 2008 17:58:01 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/pX1R0DMfpu1rkVJnsk0INZWbqoceDtqQCWFB5As
	hib8iUQRsNsjA4
X-X-Sender: gene099@racer.site
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73243>


In the commit "Reduce the number of connects when fetching", we checked 
the return value of git_connect() to see if the connection was successful.

However, for the git:// protocol, there is no need to have another 
process, so the return value is NULL.

The thing is: git_connect() does not return at all if it fails, so we need 
not check the return value of git_connect().

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin-fetch-pack.c |   16 ++++++----------
 1 files changed, 6 insertions(+), 10 deletions(-)

diff --git a/builtin-fetch-pack.c b/builtin-fetch-pack.c
index f401352..184782f 100644
--- a/builtin-fetch-pack.c
+++ b/builtin-fetch-pack.c
@@ -707,17 +707,13 @@ int cmd_fetch_pack(int argc, const char **argv, const char *prefix)
 
 	conn = git_connect(fd, (char *)dest, args.uploadpack,
 			   args.verbose ? CONNECT_VERBOSE : 0);
-	if (conn) {
-		get_remote_heads(fd[0], &ref, 0, NULL, 0);
-
-		ref = fetch_pack(&args, fd, conn, ref, dest, nr_heads, heads, NULL);
-		close(fd[0]);
-		close(fd[1]);
-		if (finish_connect(conn))
-			ref = NULL;
-	} else {
+	get_remote_heads(fd[0], &ref, 0, NULL, 0);
+
+	ref = fetch_pack(&args, fd, conn, ref, dest, nr_heads, heads, NULL);
+	close(fd[0]);
+	close(fd[1]);
+	if (finish_connect(conn))
 		ref = NULL;
-	}
 	ret = !ref;
 
 	if (!ret && nr_heads) {
-- 
1.5.4.1264.g42770c
