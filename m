From: Steffen Prohaska <prohaska@zib.de>
Subject: [PATCH 1/6 v2] push, send-pack: fix test if remote branch exists for colon-less refspec
Date: Sun, 14 Oct 2007 11:04:41 +0200
Message-ID: <1192352681389-git-send-email-prohaska@zib.de>
References: <1192352085653-git-send-email-prohaska@zib.de>
Cc: Steffen Prohaska <prohaska@zib.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 14 11:04:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IgzP8-0008Aj-5d
	for gcvg-git-2@gmane.org; Sun, 14 Oct 2007 11:04:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754650AbXJNJEq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Oct 2007 05:04:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754644AbXJNJEp
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Oct 2007 05:04:45 -0400
Received: from mailer.zib.de ([130.73.108.11]:58757 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754619AbXJNJEo (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Oct 2007 05:04:44 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id l9E94gHE026331
	for <git@vger.kernel.org>; Sun, 14 Oct 2007 11:04:43 +0200 (CEST)
Received: from localhost.localdomain (vss6.zib.de [130.73.69.7])
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id l9E94glR022610;
	Sun, 14 Oct 2007 11:04:42 +0200 (MEST)
X-Mailer: git-send-email 1.5.2.4
In-Reply-To: <1192352085653-git-send-email-prohaska@zib.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60814>

A push must fail if the remote ref does not yet exist and the refspec
does not start with refs/. Remote refs must explicitly be created with
their full name.

This commit adds some tests and fixes the existence check in send-pack.

Signed-off-by: Steffen Prohaska <prohaska@zib.de>
---
 remote.c              |    5 +++--
 t/t5516-fetch-push.sh |   34 ++++++++++++++++++++++++++++++++--
 2 files changed, 35 insertions(+), 4 deletions(-)

diff --git a/remote.c b/remote.c
index bb774d0..f26f0e0 100644
--- a/remote.c
+++ b/remote.c
@@ -475,6 +475,7 @@ static int match_explicit(struct ref *src, struct ref *dst,
 	struct ref *matched_src, *matched_dst;
 
 	const char *dst_value = rs->dst;
+	const char * const orig_dst_value = rs->dst ? rs->dst : rs->src;
 
 	if (rs->pattern)
 		return errs;
@@ -511,12 +512,12 @@ static int match_explicit(struct ref *src, struct ref *dst,
 	case 1:
 		break;
 	case 0:
-		if (!memcmp(dst_value, "refs/", 5))
+		if (!memcmp(orig_dst_value , "refs/", 5))
 			matched_dst = make_linked_ref(dst_value, dst_tail);
 		else
 			error("dst refspec %s does not match any "
 			      "existing ref on the remote and does "
-			      "not start with refs/.", dst_value);
+			      "not start with refs/.", orig_dst_value);
 		break;
 	default:
 		matched_dst = NULL;
diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index ca46aaf..8629cf2 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -126,6 +126,36 @@ test_expect_success 'push with wildcard' '
 	)
 '
 
+test_expect_success 'push nonexisting (1)' '
+
+	mk_test &&
+	if git push testrepo master
+	then
+		echo "Oops, should have failed"
+		false
+	fi
+
+'
+
+test_expect_success 'push nonexisting (2)' '
+
+	mk_test &&
+	if git push testrepo heads/master
+	then
+		echo "Oops, should have failed"
+		false
+	fi
+
+'
+
+test_expect_success 'push nonexisting (3)' '
+
+	mk_test &&
+	git push testrepo refs/heads/master &&
+	check_push_result $the_commit heads/master
+
+'
+
 test_expect_success 'push with matching heads' '
 
 	mk_test heads/master &&
@@ -225,7 +255,7 @@ test_expect_success 'push with colon-less refspec (3)' '
 		git tag -d frotz
 	fi &&
 	git branch -f frotz master &&
-	git push testrepo frotz &&
+	git push testrepo refs/heads/frotz &&
 	check_push_result $the_commit heads/frotz &&
 	test 1 = $( cd testrepo && git show-ref | wc -l )
 '
@@ -238,7 +268,7 @@ test_expect_success 'push with colon-less refspec (4)' '
 		git branch -D frotz
 	fi &&
 	git tag -f frotz &&
-	git push testrepo frotz &&
+	git push testrepo refs/tags/frotz &&
 	check_push_result $the_commit tags/frotz &&
 	test 1 = $( cd testrepo && git show-ref | wc -l )
 
-- 
1.5.3.4.224.gc6b84
