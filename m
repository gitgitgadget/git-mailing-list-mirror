From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH] status: add advice on how to push/pull to tracking branch
Date: Thu, 15 Nov 2012 11:45:00 +0100
Message-ID: <1352976300-20159-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Nov 15 11:45:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TYwwu-00078X-Kr
	for gcvg-git-2@plane.gmane.org; Thu, 15 Nov 2012 11:45:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2993077Ab2KOKpS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Nov 2012 05:45:18 -0500
Received: from mx2.imag.fr ([129.88.30.17]:56317 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S2992967Ab2KOKpQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Nov 2012 05:45:16 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id qAFAaICX016493
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 15 Nov 2012 11:36:18 +0100
Received: from anie.imag.fr ([129.88.7.32] helo=anie)
	by mail-veri.imag.fr with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1TYwwR-0005cA-9G; Thu, 15 Nov 2012 11:45:03 +0100
Received: from moy by anie with local (Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1TYwwR-0005G7-4r; Thu, 15 Nov 2012 11:45:03 +0100
X-Mailer: git-send-email 1.8.0.319.g8abfee4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Thu, 15 Nov 2012 11:36:18 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: qAFAaICX016493
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1353580582.22352@TXbLMM27mRJauxNaepUnOA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209814>


Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
I thought this was obvious enough not to deserve an advice, but a
colleague of mine had troubles with "commited but not pushed" changes.
Maybe an additional advice would have helped. After all, it's an
advice, and can be deactivated ...

 remote.c                   | 13 ++++++++++---
 t/t2020-checkout-detach.sh |  1 +
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/remote.c b/remote.c
index 04fd9ea..9c19689 100644
--- a/remote.c
+++ b/remote.c
@@ -1627,13 +1627,15 @@ int format_tracking_info(struct branch *branch, struct strbuf *sb)
 
 	base = branch->merge[0]->dst;
 	base = shorten_unambiguous_ref(base, 0);
-	if (!num_theirs)
+	if (!num_theirs) {
 		strbuf_addf(sb,
 			Q_("Your branch is ahead of '%s' by %d commit.\n",
 			   "Your branch is ahead of '%s' by %d commits.\n",
 			   num_ours),
 			base, num_ours);
-	else if (!num_ours)
+		strbuf_addf(sb,
+			_("  (use \"git push\" to publish your local commits)\n"));
+	} else if (!num_ours) {
 		strbuf_addf(sb,
 			Q_("Your branch is behind '%s' by %d commit, "
 			       "and can be fast-forwarded.\n",
@@ -1641,7 +1643,9 @@ int format_tracking_info(struct branch *branch, struct strbuf *sb)
 			       "and can be fast-forwarded.\n",
 			   num_theirs),
 			base, num_theirs);
-	else
+		strbuf_addf(sb,
+			_("  (use \"git pull\" to update your local branch)\n"));
+	} else {
 		strbuf_addf(sb,
 			Q_("Your branch and '%s' have diverged,\n"
 			       "and have %d and %d different commit each, "
@@ -1651,6 +1655,9 @@ int format_tracking_info(struct branch *branch, struct strbuf *sb)
 			       "respectively.\n",
 			   num_theirs),
 			base, num_ours, num_theirs);
+		strbuf_addf(sb,
+			_("  (use \"git pull\" to merge the remote branch into yours)\n"));
+	}
 	return 1;
 }
 
diff --git a/t/t2020-checkout-detach.sh b/t/t2020-checkout-detach.sh
index 8100537..5d68729 100755
--- a/t/t2020-checkout-detach.sh
+++ b/t/t2020-checkout-detach.sh
@@ -151,6 +151,7 @@ test_expect_success 'checkout does not warn leaving reachable commit' '
 
 cat >expect <<'EOF'
 Your branch is behind 'master' by 1 commit, and can be fast-forwarded.
+  (use "git pull" to update your local branch)
 EOF
 test_expect_success 'tracking count is accurate after orphan check' '
 	reset &&
-- 
1.8.0.319.g8abfee4
