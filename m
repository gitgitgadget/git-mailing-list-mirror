From: Steffen Prohaska <prohaska@zib.de>
Subject: [PATCH 01/10] push: change push to fail if short refname does not exist
Date: Sun, 28 Oct 2007 18:46:12 +0100
Message-ID: <11935935812741-git-send-email-prohaska@zib.de>
References: <1193593581312-git-send-email-prohaska@zib.de>
Cc: Steffen Prohaska <prohaska@zib.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 28 18:51:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ImCI6-0000ou-EU
	for gcvg-git-2@gmane.org; Sun, 28 Oct 2007 18:51:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754596AbXJ1RuA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Oct 2007 13:50:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754214AbXJ1Rt7
	(ORCPT <rfc822;git-outgoing>); Sun, 28 Oct 2007 13:49:59 -0400
Received: from mailer.zib.de ([130.73.108.11]:63834 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754297AbXJ1Rtt (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Oct 2007 13:49:49 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id l9SHkMFI016193
	for <git@vger.kernel.org>; Sun, 28 Oct 2007 18:49:47 +0100 (CET)
Received: from localhost.localdomain (vss6.zib.de [130.73.69.7])
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id l9SHkLsV019730;
	Sun, 28 Oct 2007 18:46:21 +0100 (MET)
X-Mailer: git-send-email 1.5.2.4
In-Reply-To: <1193593581312-git-send-email-prohaska@zib.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62580>

Pushing a short refname used to create a new ref on on the
remote side if it did not yet exist. If you specified the wrong
branch accidentally it was created. A safety valve that pushes
only existing branches may help to avoid errors.

This commit changes push to fail if the remote ref does not yet
exist and the refspec does not start with refs/. Remote refs must
explicitly be created with their full name. If you specify a
branch name that does not yet exist on the remote side, git push
will print a suggestion to push the full refname instead.

The new behaviour is more defensive than the old one. You can
now explicitly distinguish between "push existing branch" and
"create new branch on the remote side". The old implementation
allowed the same command line in both cases.

A follow-up patch will add a flag '--create' that provides an
alternative to using full refnames if creation of new refs is
intended.

Another follow-up patch will support "push origin HEAD". In this
case, the existence check is important. If you're on the wrong
branch and push HEAD you may be surprised if a new branch is
created. This can be avoided by requiring either a full ref or
the '--create' flag.

The implementation in this patch is less "clever" and hopefully
better readable than an ealier version of the patch. Thanks for
the suggestions to Daniel Barkalow <barkalow@iabervon.org>.

Signed-off-by: Steffen Prohaska <prohaska@zib.de>
---
 remote.c              |   25 ++++++++++++++++---------
 t/t5516-fetch-push.sh |   34 ++++++++++++++++++++++++++++++++--
 2 files changed, 48 insertions(+), 11 deletions(-)

diff --git a/remote.c b/remote.c
index 170015a..cf6441a 100644
--- a/remote.c
+++ b/remote.c
@@ -610,7 +610,8 @@ static int match_explicit(struct ref *src, struct ref *dst,
 {
 	struct ref *matched_src, *matched_dst;
 
-	const char *dst_value = rs->dst;
+	const char *lit_dst_value;
+	const char *search_dst_value;
 
 	if (rs->pattern)
 		return errs;
@@ -637,27 +638,33 @@ static int match_explicit(struct ref *src, struct ref *dst,
 	if (!matched_src)
 		errs = 1;
 
-	if (!dst_value) {
+	if (rs->dst) {
+		lit_dst_value = search_dst_value = rs->dst;
+	} else {
 		if (!matched_src)
 			return errs;
-		dst_value = matched_src->name;
+		lit_dst_value = rs->src;
+		search_dst_value = matched_src->name;
 	}
 
-	switch (count_refspec_match(dst_value, dst, &matched_dst)) {
+	switch (count_refspec_match(search_dst_value, dst, &matched_dst)) {
 	case 1:
 		break;
 	case 0:
-		if (!memcmp(dst_value, "refs/", 5))
-			matched_dst = make_linked_ref(dst_value, dst_tail);
-		else
+		if (!memcmp(lit_dst_value , "refs/", 5))
+			matched_dst = make_linked_ref(lit_dst_value, dst_tail);
+		else {
 			error("dst refspec %s does not match any "
 			      "existing ref on the remote and does "
-			      "not start with refs/.", dst_value);
+			      "not start with refs/.", lit_dst_value);
+			if (!rs->dst)
+				error("Did you mean %s?\n", search_dst_value);
+		}
 		break;
 	default:
 		matched_dst = NULL;
 		error("dst refspec %s matches more than one.",
-		      dst_value);
+		      lit_dst_value);
 		break;
 	}
 	if (errs || !matched_dst)
diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index 4fbd5b1..5ba09e2 100755
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
1.5.3.4.439.ge8b49
