From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 3/6] t5516 (fetch-push): introduce mk_test_with_name()
Date: Fri, 22 Mar 2013 13:22:33 +0530
Message-ID: <1363938756-13722-4-git-send-email-artagnon@gmail.com>
References: <1363938756-13722-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Mar 22 08:52:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UIwld-0002Ky-UT
	for gcvg-git-2@plane.gmane.org; Fri, 22 Mar 2013 08:52:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754538Ab3CVHvf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Mar 2013 03:51:35 -0400
Received: from mail-da0-f50.google.com ([209.85.210.50]:52552 "EHLO
	mail-da0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754463Ab3CVHve (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Mar 2013 03:51:34 -0400
Received: by mail-da0-f50.google.com with SMTP id t1so619349dae.37
        for <git@vger.kernel.org>; Fri, 22 Mar 2013 00:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=aKViplUyZip7ENDzDSjURyNrc6nGty/rSWL0GZlRlrA=;
        b=lx8AwbyQBwLIEtWN0m/83lw7551XkI0OAchWNGEhkl+Cz8eqKHf9VuBlE+pBgnG8zO
         fN49UF8Ol75ffvMmSB8gL4D8VamzOqQcj5JuuoG2cnPZUjfOOqX4GgjN0akNsFT2baLZ
         QlpTh4w3rJGPEpwwevMQsquFlCOopNrcZnddpPz0Oy09JkFBy+HFye2MQWUUt22xiuLl
         p4V7h0szTQVjuDydED78puxO8IF6pb8OeIjkOBdp51rw3OoBxxXPuiKbr0v3ro5fe2yX
         X75HVPtrixqxbhSGdOqyZBiq0mEGa+dC/hbWGSiq0GZAbVuj0TTeTfvHRT3AH11ili52
         SoHQ==
X-Received: by 10.68.179.1 with SMTP id dc1mr1147851pbc.128.1363938694127;
        Fri, 22 Mar 2013 00:51:34 -0700 (PDT)
Received: from luneth.maa.corp.collab.net ([182.71.239.158])
        by mx.google.com with ESMTPS id fh1sm2025227pac.1.2013.03.22.00.51.31
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 22 Mar 2013 00:51:33 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.62.ga35d936.dirty
In-Reply-To: <1363938756-13722-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218779>

mk_test() creates a repository with the constant name "testrepo", and
this may be limiting for tests that need to create more than one
repository for testing.  To fix this, create a new mk_test_with_name()
which accepts the repository name as $1.  Reimplement mk_test() as a
special case of this function, making sure that no tests need to be
rewritten.  Do the same thing for check_push_result().

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 t/t5516-fetch-push.sh | 34 +++++++++++++++++++++++++---------
 1 file changed, 25 insertions(+), 9 deletions(-)

diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index bfeec60..a546c2c 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -7,27 +7,32 @@ test_description='fetching and pushing'
 D=`pwd`
 
 mk_empty () {
-	rm -fr testrepo &&
-	mkdir testrepo &&
+	repo_name="$1"
+	test -z "$repo_name" && repo_name=testrepo
+	rm -fr $repo_name &&
+	mkdir $repo_name &&
 	(
-		cd testrepo &&
+		cd $repo_name &&
 		git init &&
 		git config receive.denyCurrentBranch warn &&
 		mv .git/hooks .git/hooks-disabled
 	)
 }
 
-mk_test () {
-	mk_empty &&
+mk_test_with_name () {
+	repo_name="$1"
+	shift
+
+	mk_empty $repo_name &&
 	(
 		for ref in "$@"
 		do
-			git push testrepo $the_first_commit:refs/$ref || {
+			git push $repo_name $the_first_commit:refs/$ref || {
 				echo "Oops, push refs/$ref failure"
 				exit 1
 			}
 		done &&
-		cd testrepo &&
+		cd $repo_name &&
 		for ref in "$@"
 		do
 			r=$(git show-ref -s --verify refs/$ref) &&
@@ -40,6 +45,10 @@ mk_test () {
 	)
 }
 
+mk_test () {
+	mk_test_with_name testrepo "$@"
+}
+
 mk_test_with_hooks() {
 	mk_test "$@" &&
 	(
@@ -79,9 +88,12 @@ mk_child() {
 	git clone testrepo "$1"
 }
 
-check_push_result () {
+check_push_result_with_name () {
+	repo_name="$1"
+	shift
+
 	(
-		cd testrepo &&
+		cd $repo_name &&
 		it="$1" &&
 		shift
 		for ref in "$@"
@@ -96,6 +108,10 @@ check_push_result () {
 	)
 }
 
+check_push_result () {
+	check_push_result_with_name testrepo "$@"
+}
+
 test_expect_success setup '
 
 	>path1 &&
-- 
1.8.2.62.ga35d936.dirty
