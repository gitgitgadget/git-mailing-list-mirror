From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [PATCH] Permit refspec source side to parse as a sha1
Date: Thu, 20 Mar 2008 20:54:54 -0400 (EDT)
Message-ID: <alpine.LNX.1.00.0803202049090.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Samuel Tardieu <sam@rfc1149.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 21 01:55:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JcVXl-0007IC-Fk
	for gcvg-git-2@gmane.org; Fri, 21 Mar 2008 01:55:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752416AbYCUAy5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Mar 2008 20:54:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752403AbYCUAy5
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Mar 2008 20:54:57 -0400
Received: from iabervon.org ([66.92.72.58]:52550 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752214AbYCUAy4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Mar 2008 20:54:56 -0400
Received: (qmail 26986 invoked by uid 1000); 21 Mar 2008 00:54:54 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 21 Mar 2008 00:54:54 -0000
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77692>

This fixes "git push origin HEAD~1:foo". "git fetch origin HEAD~1:foo"
will report "Couldn't find remote ref HEAD~1", while
"git fetch origin HEAD**1:foo" reports "Invalid refspec 'HEAD**1:foo'"

That is, HEAD~1 is something you're not allowed to ask the remote for, 
while HEAD**1 doesn't mean anything.

Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
---
Note that this actually tries to look up the source side, so "git 
fetch origin HEAD^3:foo" usually gives a wrongish error message. But this 
only applies to error cases which nobody is likely to attempt anyway, and 
they still come out as errors regardless.

 remote.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/remote.c b/remote.c
index 9700a33..d737579 100644
--- a/remote.c
+++ b/remote.c
@@ -434,8 +434,10 @@ struct refspec *parse_ref_spec(int nr_refspec, const char **refspec)
 		rs[i].src = xstrndup(sp, ep - sp);
 
 		if (*rs[i].src) {
+			unsigned char sha1[20];
 			st = check_ref_format(rs[i].src);
-			if (st && st != CHECK_REF_FORMAT_ONELEVEL)
+			if (st && st != CHECK_REF_FORMAT_ONELEVEL &&
+			    get_sha1(rs[i].src, sha1))
 				die("Invalid refspec '%s'", refspec[i]);
 		}
 		if (rs[i].dst && *rs[i].dst) {
-- 
1.5.4.3.610.gea6cd
