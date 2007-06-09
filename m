From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 5/5] remote.c: "git-push frotz" should update what matches at the source.
Date: Sat,  9 Jun 2007 02:21:36 -0700
Message-ID: <11813808973041-git-send-email-gitster@pobox.com>
References: <11813808962261-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 09 11:22:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hwx94-0000t8-5p
	for gcvg-git@gmane.org; Sat, 09 Jun 2007 11:22:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751637AbXFIJVo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 9 Jun 2007 05:21:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751486AbXFIJVn
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Jun 2007 05:21:43 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:59480 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751522AbXFIJVi (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Jun 2007 05:21:38 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070609092138.NFSH29545.fed1rmmtao104.cox.net@fed1rmimpo02.cox.net>
          for <git@vger.kernel.org>; Sat, 9 Jun 2007 05:21:38 -0400
Received: from localhost.localdomain ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id 9MMc1X00J1kojtg0000400; Sat, 09 Jun 2007 05:21:37 -0400
X-Mailer: git-send-email 1.5.2.1.144.gabc40
In-Reply-To: <11813808962261-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49562>

Earlier, when the local repository has a branch "frotz" and the
remote repository has a tag "frotz" (but not branch "frotz"),
"git-push frotz" mistakenly updated the tag at the remote side.
This was because the partial refname matching code was applied
independently on both source and destination side.

With this fix, when a colon-less refspec is given to git-push,
we first match it with the refs in the source repository, and
update the matching ref in the destination repository.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 remote.c              |    7 +-----
 t/t5516-fetch-push.sh |   52 +++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 53 insertions(+), 6 deletions(-)

diff --git a/remote.c b/remote.c
index 120df36..754d513 100644
--- a/remote.c
+++ b/remote.c
@@ -455,7 +455,7 @@ static int match_explicit(struct ref *src, struct ref *dst,
 		errs = 1;
 
 	if (dst_value == NULL)
-		dst_value = rs->src;
+		dst_value = matched_src->name;
 
 	switch (count_refspec_match(dst_value, dst, &matched_dst)) {
 	case 1:
@@ -463,11 +463,6 @@ static int match_explicit(struct ref *src, struct ref *dst,
 	case 0:
 		if (!memcmp(dst_value, "refs/", 5))
 			matched_dst = make_dst(dst_value, dst_tail);
-		else if (!strcmp(rs->src, dst_value) && matched_src)
-			/* pushing "master:master" when
-			 * remote does not have master yet.
-			 */
-			matched_dst = make_dst(matched_src->name, dst_tail);
 		else
 			error("dst refspec %s does not match any "
 			      "existing ref on the remote and does "
diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index b3b57fa..08d58e1 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -189,6 +189,58 @@ test_expect_success 'push with ambiguity (2)' '
 	else
 		check_push_result $the_first_commit heads/frotz tags/frotz
 	fi
+
+'
+
+test_expect_success 'push with colon-less refspec (1)' '
+
+	mk_test heads/frotz tags/frotz &&
+	git branch -f frotz master &&
+	git push testrepo frotz &&
+	check_push_result $the_commit heads/frotz &&
+	check_push_result $the_first_commit tags/frotz
+
+'
+
+test_expect_success 'push with colon-less refspec (2)' '
+
+	mk_test heads/frotz tags/frotz &&
+	if git show-ref --verify -q refs/heads/frotz
+	then
+		git branch -D frotz
+	fi &&
+	git tag -f frotz &&
+	git push testrepo frotz &&
+	check_push_result $the_commit tags/frotz &&
+	check_push_result $the_first_commit heads/frotz
+
+'
+
+test_expect_success 'push with colon-less refspec (3)' '
+
+	mk_test &&
+	if git show-ref --verify -q refs/tags/frotz
+	then
+		git tag -d frotz
+	fi &&
+	git branch -f frotz master &&
+	git push testrepo frotz &&
+	check_push_result $the_commit heads/frotz &&
+	test "$( cd testrepo && git show-ref | wc -l )" = 1
+'
+
+test_expect_success 'push with colon-less refspec (4)' '
+
+	mk_test &&
+	if git show-ref --verify -q refs/heads/frotz
+	then
+		git branch -D frotz
+	fi &&
+	git tag -f frotz &&
+	git push testrepo frotz &&
+	check_push_result $the_commit tags/frotz &&
+	test "$( cd testrepo && git show-ref | wc -l )" = 1
+
 '
 
 test_done
-- 
1.5.2.1.144.gabc40
