From: Alex Vandiver <alex@chmrr.net>
Subject: [PATCH] Failing test; renaming sections can lose assignments on the same line
Date: Wed,  8 Jul 2009 16:40:41 -0400
Message-ID: <1247085641-14772-1-git-send-email-alex@chmrr.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 08 23:14:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MOeSz-00037f-Qz
	for gcvg-git-2@gmane.org; Wed, 08 Jul 2009 23:14:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755523AbZGHVOG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jul 2009 17:14:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755479AbZGHVOG
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Jul 2009 17:14:06 -0400
Received: from chmrr.net ([209.67.253.66]:44348 "EHLO utwig.chmrr.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755097AbZGHVOF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jul 2009 17:14:05 -0400
X-Greylist: delayed 1990 seconds by postgrey-1.27 at vger.kernel.org; Wed, 08 Jul 2009 17:14:05 EDT
Received: from 75-147-59-54-newengland.hfc.comcastbusiness.net ([75.147.59.54] helo=localhost.localdomain)
	by utwig.chmrr.net with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.69)
	(envelope-from <alex@chmrr.net>)
	id 1MOdwf-0000cQ-2f
	for git@vger.kernel.org; Wed, 08 Jul 2009 16:40:54 -0400
X-Mailer: git-send-email 1.6.3.3.473.gb74fc4.dirty
X-Authenticated-User: chmrr
X-Authenticator: plain
X-Sender-Verify: SUCCEEDED (sender exists & accepts mail)
X-Spam-Score: -4.4
X-Spam-Score-Int: -43
X-Exim-Version: 4.69 (build at 07-Feb-2009 20:08:51)
X-Date: 2009-07-08 16:40:54
X-Connected-IP: 75.147.59.54:49722
X-Message-Linecount: 59
X-Body-Linecount: 52
X-Message-Size: 1473
X-Body-Size: 1172
X-Received-Count: 1
X-Recipient-Count: 1
X-Local-Recipient-Count: 1
X-Local-Recipient-Defer-Count: 0
X-Local-Recipient-Fail-Count: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122921>


Signed-off-by: Alex Vandiver <alex@chmrr.net>
---

I noticed the following bug recently:

    echo "[foo] x = 1" > testfile
    git config --file=testfile --rename-section foo bar
    cat testfile
    # [bar]

This is at least a failing test, and I'll look at how complex the
fix is when I get a few spare tuits.

 t/t1300-repo-config.sh |   21 +++++++++++++++++++++
 1 files changed, 21 insertions(+), 0 deletions(-)

diff --git a/t/t1300-repo-config.sh b/t/t1300-repo-config.sh
index 43ea283..4d576c6 100755
--- a/t/t1300-repo-config.sh
+++ b/t/t1300-repo-config.sh
@@ -460,6 +460,27 @@ EOF
 test_expect_success "rename succeeded" "test_cmp expect .git/config"
 
 cat >> .git/config << EOF
+[branch "vier"] z = 1
+EOF
+
+test_expect_success "rename a section with a var on the same line" \
+	'git config --rename-section branch.vier branch.zwei'
+
+cat > expect << EOF
+# Hallo
+	#Bello
+[branch "zwei"]
+	x = 1
+[branch "zwei"]
+	y = 1
+[branch "drei"]
+weird
+[branch "zwei"] z = 1
+EOF
+
+test_expect_success "rename succeeded" "test_cmp expect .git/config"
+
+cat >> .git/config << EOF
   [branch "zwei"] a = 1 [branch "vier"]
 EOF
 
-- 
1.6.3.3.473.gb74fc4.dirty
