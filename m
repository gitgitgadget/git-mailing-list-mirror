From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] filter-branch: when dwim'ing a ref, only allow heads and
 tags
Date: Tue, 24 Jul 2007 12:27:59 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707241227140.14781@racer.site>
References: <Pine.LNX.4.64.0707231829210.14781@racer.site> 
 <46A5C615.24C24F0F@eudaptics.com> <Pine.LNX.4.64.0707241134330.14781@racer.site>
 <46A5DCBC.E585A69D@eudaptics.com> <Pine.LNX.4.64.0707241218270.14781@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: gitster@pobox.com, git@vger.kernel.org
To: Johannes Sixt <J.Sixt@eudaptics.com>
X-From: git-owner@vger.kernel.org Tue Jul 24 13:28:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IDIYv-0004f7-EU
	for gcvg-git@gmane.org; Tue, 24 Jul 2007 13:28:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764128AbXGXL2S (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 Jul 2007 07:28:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762583AbXGXL2S
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jul 2007 07:28:18 -0400
Received: from mail.gmx.net ([213.165.64.20]:50385 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1764128AbXGXL2R (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jul 2007 07:28:17 -0400
Received: (qmail invoked by alias); 24 Jul 2007 11:28:16 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp051) with SMTP; 24 Jul 2007 13:28:16 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+PqVoXb+qP7Uh/badRYRFatPsp7Uzg6VLqPTY8Gw
	FMyPzDvOyv4Zlg
X-X-Sender: gene099@racer.site
In-Reply-To: <Pine.LNX.4.64.0707241218270.14781@racer.site>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53574>


Previously, we matched all refs that had /$ref in them.  And tried to
verify the result as a ref.  If more than one match was found, the result
was not a ref, though.

So only allow tags and heads to be dwim'ed.  If both a tag and a head with
that name exist, it will be ignored again.

Caught by Johannes Sixt.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	Heh.  I just realised that I managed to fsck up a one-line patch.  
	D'oh!  Thanks for fixing it, Hannes.

 git-filter-branch.sh     |    2 +-
 t/t7003-filter-branch.sh |    5 +++++
 2 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/git-filter-branch.sh b/git-filter-branch.sh
index 0ff3475..4fb3abe 100755
--- a/git-filter-branch.sh
+++ b/git-filter-branch.sh
@@ -193,7 +193,7 @@ do
 	;;
 	*)
 		ref="$(git for-each-ref --format='%(refname)' |
-			grep /"$ref")"
+			grep -e "^refs/heads/$ref$" -e "^refs/tags/$ref$")"
 	esac
 
 	git check-ref-format "$ref" && echo "$ref"
diff --git a/t/t7003-filter-branch.sh b/t/t7003-filter-branch.sh
index bc6e2dd..c9a820d 100755
--- a/t/t7003-filter-branch.sh
+++ b/t/t7003-filter-branch.sh
@@ -159,4 +159,9 @@ test_expect_success 'barf on invalid name' '
 	! git filter-branch -f HEAD^
 '
 
+test_expect_success 'only dwim refs/heads/$ref or refs/tags/$ref' '
+	git update-ref refs/remotes/origin/master HEAD &&
+	git filter-branch -f master
+'
+
 test_done
-- 
1.5.3.rc2.32.g35c5b-dirty
