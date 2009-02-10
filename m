From: "Pat Notz" <pknotz@sandia.gov>
Subject: [PATCH] Fix contrib/hooks/post-receive-email for new duplicate
 branch
Date: Tue, 10 Feb 2009 09:18:27 -0700
Message-ID: <1234282707-6295-1-git-send-email-pknotz@sandia.gov>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: "Pat Notz" <pknotz@sandia.gov>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 10 17:20:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LWvLJ-0004hS-9f
	for gcvg-git-2@gmane.org; Tue, 10 Feb 2009 17:20:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754088AbZBJQSq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Feb 2009 11:18:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754024AbZBJQSp
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Feb 2009 11:18:45 -0500
Received: from sentry.sandia.gov ([132.175.109.20]:2094 "EHLO
	sentry.sandia.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753184AbZBJQSp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Feb 2009 11:18:45 -0500
Received: from [134.253.165.159] by sentry.sandia.gov with ESMTP (SMTP
 Relay 01 (Email Firewall v6.3.2)); Tue, 10 Feb 2009 09:18:33 -0700
X-Server-Uuid: AF72F651-81B1-4134-BA8C-A8E1A4E620FF
Received: from localhost.localdomain (134.253.112.110) by
 cas1.srn.sandia.gov (134.253.165.189) with Microsoft SMTP Server id
 8.1.336.0; Tue, 10 Feb 2009 09:18:32 -0700
X-Mailer: git-send-email 1.6.1.2
X-TMWD-Spam-Summary: TS=20090210161833; ID=1; SEV=2.3.1;
 DFV=B2009021012; IFV=NA; AIF=B2009021012; RPD=5.03.0010; ENG=NA;
 RPDID=7374723D303030312E30413031303230342E34393931413844412E303033452C73733D312C6667733D30;
 CAT=NONE; CON=NONE; SIG=AAABAKR1FwAAAAAAAAAAAAAAAAAAAH0=
X-MMS-Spam-Filter-ID: B2009021012_5.03.0010
X-WSS-ID: 658F77532D4187508-01-01
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109264>

In the show_new_revisions function, the original code:

  git rev-parse --not --branches | grep -v $(git rev-parse $refname) |

isn't quite right since one can create a new branch and push it
without any new commits.  In that case, two refs will have the same
sha1 but both would get filtered by the 'grep'.  In the end, we'll
show ALL the history which is not what we want.  Instead, we should
list the branches by name and remove the branch being updated and THEN
pass that list through rev-parse.

Revised as suggested by Jakub Narebski <jnareb@gmail.com> to use
git-for-each-ref instead of git-branch.  (Thanks!)

Signed-off-by: Pat Notz <pknotz@sandia.gov>
---
 contrib/hooks/post-receive-email |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/contrib/hooks/post-receive-email b/contrib/hooks/post-receive-email
index 28a3c0e..ec52751 100644
--- a/contrib/hooks/post-receive-email
+++ b/contrib/hooks/post-receive-email
@@ -615,7 +615,9 @@ show_new_revisions()
 		revspec=$oldrev..$newrev
 	fi
 
-	git rev-parse --not --branches | grep -v $(git rev-parse $refname) |
+	other_branches=$(git for-each-ref --format='%(refname)' refs/heads/ |
+	    grep -v $refname)
+	git rev-parse --not $other_branches |
 	if [ -z "$custom_showrev" ]
 	then
 		git rev-list --pretty --stdin $revspec
-- 
1.6.1.2
