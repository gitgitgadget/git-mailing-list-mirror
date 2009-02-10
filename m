From: "Pat Notz" <pknotz@sandia.gov>
Subject: [PATCH] Fix contrib/hooks/post-receive-email for new branch
 with no new commits
Date: Tue, 10 Feb 2009 06:48:15 -0700
Message-ID: <1234273695-4981-1-git-send-email-pknotz@sandia.gov>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: "Pat Notz" <pknotz@sandia.gov>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 10 15:00:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LWt9X-0006s8-JD
	for gcvg-git-2@gmane.org; Tue, 10 Feb 2009 14:59:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754523AbZBJN6S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Feb 2009 08:58:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754205AbZBJN6R
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Feb 2009 08:58:17 -0500
Received: from mm03snlnto.sandia.gov ([132.175.109.20]:4261 "EHLO
	sentry.sandia.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753949AbZBJN6R (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Feb 2009 08:58:17 -0500
X-Greylist: delayed 589 seconds by postgrey-1.27 at vger.kernel.org; Tue, 10 Feb 2009 08:58:16 EST
Received: from [132.175.109.1] by sentry.sandia.gov with ESMTP (SMTP
 Relay 01 (Email Firewall v6.3.2)); Tue, 10 Feb 2009 06:48:20 -0700
X-Server-Uuid: 6BFC7783-7E22-49B4-B610-66D6BE496C0E
Received: from mail.sandia.gov (cas1.sandia.gov [134.253.165.159] (may
 be forged)) by mailgate.sandia.gov (8.14.1/8.14.1) with ESMTP id
 n1ADmJlV018465 for <git@vger.kernel.org>; Tue, 10 Feb 2009 06:48:20
 -0700
Received: from localhost.localdomain (134.253.112.110) by
 cas1.srn.sandia.gov (134.253.165.189) with Microsoft SMTP Server id
 8.1.336.0; Tue, 10 Feb 2009 06:48:19 -0700
X-Mailer: git-send-email 1.6.1.2
X-TMWD-Spam-Summary: TS=20090210134820; ID=1; SEV=2.3.1;
 DFV=B2009021010; IFV=NA; AIF=B2009021010; RPD=5.03.0010; ENG=NA;
 RPDID=7374723D303030312E30413031303230332E34393931383541342E303136413A534346535441543838363133332C73733D312C6667733D30;
 CAT=NONE; CON=NONE; SIG=AAABAKR1FwAAAAAAAAAAAAAAAAAAAH0=
X-MMS-Spam-Filter-ID: B2009021010_5.03.0010
X-WSS-ID: 658F5A2E2G8166937-01-01
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109240>

In the show_new_revisions function, the original code:

   git rev-parse --not --branches | grep -v $(git rev-parse $refname) |

isn't quite right since one can create a new branch and push it without
any new commits.  In that case, two refs will have the same sha1 but
both would get filtered by the 'grep'.  In the end, we'll show ALL the
history which is not what we want.  Instead, we should list the branches
by name and remove the branch being updated and THEN pass that list
through rev-parse.

Signed-off-by: Pat Notz <pknotz@sandia.gov>
---
 contrib/hooks/post-receive-email |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/contrib/hooks/post-receive-email b/contrib/hooks/post-receive-email
index 28a3c0e..116f89c 100644
--- a/contrib/hooks/post-receive-email
+++ b/contrib/hooks/post-receive-email
@@ -615,7 +615,9 @@ show_new_revisions()
 		revspec=$oldrev..$newrev
 	fi
 
-	git rev-parse --not --branches | grep -v $(git rev-parse $refname) |
+	this_branch=$(echo $refname | sed 's@refs/heads/@@')
+	other_branches=$(git branch | sed 's/\*//g' | grep -v $this_branch)
+	git rev-parse --not $other_branches |
 	if [ -z "$custom_showrev" ]
 	then
 		git rev-list --pretty --stdin $revspec
-- 
1.6.1.2
