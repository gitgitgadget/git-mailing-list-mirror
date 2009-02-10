From: "Pat Notz" <pknotz@sandia.gov>
Subject: [PATCH] Fix contrib/hooks/post-receive-email for new duplicate
 branch
Date: Tue, 10 Feb 2009 09:43:30 -0700
Message-ID: <1234284210-7122-1-git-send-email-pknotz@sandia.gov>
References: <7vbptantj2.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: "Pat Notz" <pknotz@sandia.gov>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 10 17:45:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LWvjU-0006VO-J9
	for gcvg-git-2@gmane.org; Tue, 10 Feb 2009 17:45:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753103AbZBJQnr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Feb 2009 11:43:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752728AbZBJQnq
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Feb 2009 11:43:46 -0500
Received: from sentry.sandia.gov ([132.175.109.20]:3285 "EHLO
	sentry.sandia.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750887AbZBJQnp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Feb 2009 11:43:45 -0500
Received: from [134.253.165.159] by sentry.sandia.gov with ESMTP (SMTP
 Relay 01 (Email Firewall v6.3.2)); Tue, 10 Feb 2009 09:43:36 -0700
X-Server-Uuid: AF72F651-81B1-4134-BA8C-A8E1A4E620FF
Received: from localhost.localdomain (134.253.112.110) by
 cas1.srn.sandia.gov (134.253.165.189) with Microsoft SMTP Server id
 8.1.336.0; Tue, 10 Feb 2009 09:43:35 -0700
X-Mailer: git-send-email 1.6.1.2
In-Reply-To: <7vbptantj2.fsf@gitster.siamese.dyndns.org>
X-TMWD-Spam-Summary: TS=20090210164338; ID=1; SEV=2.3.1;
 DFV=B2009021013; IFV=NA; AIF=B2009021013; RPD=5.03.0010; ENG=NA;
 RPDID=7374723D303030312E30413031303230332E34393931414542412E303042302C73733D312C6667733D30;
 CAT=NONE; CON=NONE; SIG=AAABAKR1FwAAAAAAAAAAAAAAAAAAAH0=
X-MMS-Spam-Filter-ID: B2009021013_5.03.0010
X-WSS-ID: 658F713C2D4191065-02-01
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109269>

In the show_new_revisions function, the original code:

  git rev-parse --not --branches | grep -v $(git rev-parse $refname) |

isn't quite right since one can create a new branch and push it
without any new commits.  In that case, two refs will have the same
sha1 but both would get filtered by the 'grep'.  In the end, we'll
show ALL the history which is not what we want.  Instead, we should
list the branches by name and remove the branch being updated and THEN
pass that list through rev-parse.

Revised as suggested by Jakub Narebski and Junio C Hamano to use
git-for-each-ref instead of git-branch.  (Thanks!)

Signed-off-by: Pat Notz <pknotz@sandia.gov>
---
 contrib/hooks/post-receive-email |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/contrib/hooks/post-receive-email b/contrib/hooks/post-receive-email
index 28a3c0e..60cbab6 100644
--- a/contrib/hooks/post-receive-email
+++ b/contrib/hooks/post-receive-email
@@ -615,7 +615,9 @@ show_new_revisions()
 		revspec=$oldrev..$newrev
 	fi
 
-	git rev-parse --not --branches | grep -v $(git rev-parse $refname) |
+	other_branches=$(git for-each-ref --format='%(refname)' refs/heads/ |
+	    grep -F -v $refname)
+	git rev-parse --not $other_branches |
 	if [ -z "$custom_showrev" ]
 	then
 		git rev-list --pretty --stdin $revspec
-- 
1.6.1.2
