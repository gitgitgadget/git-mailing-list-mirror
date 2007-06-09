From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 4/5] remote.c: fix "git push" weak match disambiguation
Date: Sat,  9 Jun 2007 02:21:35 -0700
Message-ID: <11813808973622-git-send-email-gitster@pobox.com>
References: <11813808962261-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 09 11:22:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hwx93-0000t8-NG
	for gcvg-git@gmane.org; Sat, 09 Jun 2007 11:22:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751940AbXFIJVn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 9 Jun 2007 05:21:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751486AbXFIJVm
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Jun 2007 05:21:42 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:44394 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751514AbXFIJVh (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Jun 2007 05:21:37 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070609092137.CYAW18396.fed1rmmtao105.cox.net@fed1rmimpo02.cox.net>
          for <git@vger.kernel.org>; Sat, 9 Jun 2007 05:21:37 -0400
Received: from localhost.localdomain ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id 9MMc1X00J1kojtg0000300; Sat, 09 Jun 2007 05:21:37 -0400
X-Mailer: git-send-email 1.5.2.1.144.gabc40
In-Reply-To: <11813808962261-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49564>

When "git push A:B" is given, and A (or B) is not a full refname
that begins with refs/, we require an unambiguous match with an
existing ref.  For this purpose, a match with a local branch or
a tag (i.e. refs/heads/A and refs/tags/A) is called a "strong
match", and any other match is called a "weak match".  A partial
refname is unambiguous when there is only one strong match with
any number of weak matches, or when there is only one weak match
and no other match.

However, as reported by Sparse with Ramsay Jones recently,
count_refspec_match() function had a bug where a variable in an
inner block masked a different variable of the same name, which
caused the weak matches to be ignored.

This fixes it, and adds tests for the fix.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 remote.c              |    1 -
 t/t5516-fetch-push.sh |  112 +++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 112 insertions(+), 1 deletions(-)

diff --git a/remote.c b/remote.c
index 30abdbb..120df36 100644
--- a/remote.c
+++ b/remote.c
@@ -333,7 +333,6 @@ static int count_refspec_match(const char *pattern,
 	for (weak_match = match = 0; refs; refs = refs->next) {
 		char *name = refs->name;
 		int namelen = strlen(name);
-		int weak_match;
 
 		if (namelen < patlen ||
 		    memcmp(name + namelen - patlen, pattern, patlen))
diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index dba018f..b3b57fa 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -15,12 +15,58 @@ mk_empty () {
 	)
 }
 
+mk_test () {
+	mk_empty &&
+	(
+		for ref in "$@"
+		do
+			git push testrepo $the_first_commit:refs/$ref || {
+				echo "Oops, push refs/$ref failure"
+				exit 1
+			}
+		done &&
+		cd testrepo &&
+		for ref in "$@"
+		do
+			r=$(git show-ref -s --verify refs/$ref) &&
+			test "z$r" = "z$the_first_commit" || {
+				echo "Oops, refs/$ref is wrong"
+				exit 1
+			}
+		done &&
+		git fsck --full
+	)
+}
+
+check_push_result () {
+	(
+		cd testrepo &&
+		it="$1" &&
+		shift
+		for ref in "$@"
+		do
+			r=$(git show-ref -s --verify refs/$ref) &&
+			test "z$r" = "z$it" || {
+				echo "Oops, refs/$ref is wrong"
+				exit 1
+			}
+		done &&
+		git fsck --full
+	)
+}
+
 test_expect_success setup '
 
 	: >path1 &&
 	git add path1 &&
 	test_tick &&
 	git commit -a -m repo &&
+	the_first_commit=$(git show-ref -s --verify refs/heads/master) &&
+
+	: >path2 &&
+	git add path2 &&
+	test_tick &&
+	git commit -a -m second &&
 	the_commit=$(git show-ref -s --verify refs/heads/master)
 
 '
@@ -79,4 +125,70 @@ test_expect_success 'push with wildcard' '
 	)
 '
 
+test_expect_success 'push with matching heads' '
+
+	mk_test heads/master &&
+	git push testrepo &&
+	check_push_result $the_commit heads/master
+
+'
+
+test_expect_success 'push with no ambiguity (1)' '
+
+	mk_test heads/master &&
+	git push testrepo master:master &&
+	check_push_result $the_commit heads/master
+
+'
+
+test_expect_success 'push with no ambiguity (2)' '
+
+	mk_test remotes/origin/master &&
+	git push testrepo master:master &&
+	check_push_result $the_commit remotes/origin/master
+
+'
+
+test_expect_success 'push with weak ambiguity (1)' '
+
+	mk_test heads/master remotes/origin/master &&
+	git push testrepo master:master &&
+	check_push_result $the_commit heads/master &&
+	check_push_result $the_first_commit remotes/origin/master
+
+'
+
+test_expect_success 'push with weak ambiguity (2)' '
+
+	mk_test heads/master remotes/origin/master remotes/another/master &&
+	git push testrepo master:master &&
+	check_push_result $the_commit heads/master &&
+	check_push_result $the_first_commit remotes/origin/master remotes/another/master
+
+'
+
+test_expect_success 'push with ambiguity (1)' '
+
+	mk_test remotes/origin/master remotes/frotz/master &&
+	if git push testrepo master:master
+	then
+		echo "Oops, should have failed"
+		false
+	else
+		check_push_result $the_first_commit remotes/origin/master remotes/frotz/master
+	fi
+'
+
+test_expect_success 'push with ambiguity (2)' '
+
+	mk_test heads/frotz tags/frotz &&
+	if git push testrepo master:frotz
+	then
+		echo "Oops, should have failed"
+		false
+	else
+		check_push_result $the_first_commit heads/frotz tags/frotz
+	fi
+'
+
 test_done
-- 
1.5.2.1.144.gabc40
