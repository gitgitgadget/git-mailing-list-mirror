From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 3/6] t5516 (fetch-push): introduce mk_test_with_name()
Date: Wed, 20 Mar 2013 18:14:58 +0530
Message-ID: <1363783501-27981-4-git-send-email-artagnon@gmail.com>
References: <1363783501-27981-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Mar 20 13:44:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UIINh-0001sM-NX
	for gcvg-git-2@plane.gmane.org; Wed, 20 Mar 2013 13:44:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932898Ab3CTMoG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Mar 2013 08:44:06 -0400
Received: from mail-pd0-f178.google.com ([209.85.192.178]:57527 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932496Ab3CTMoE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Mar 2013 08:44:04 -0400
Received: by mail-pd0-f178.google.com with SMTP id u10so597989pdi.37
        for <git@vger.kernel.org>; Wed, 20 Mar 2013 05:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=0KOj/dY2phqOdhQD2Hg3BrnRJhWbTacleZvkV35rbcg=;
        b=ZjZfYAQ2ORqoDWyD5zB4XMu4yNSr8SEEMpuAeSDPT9YuCy16tLVKqXYfbjMwT58m64
         afl6GZPZd1xRf0gAvOnl5SOLjo5ouuD36lXBEntYgTBb5mNN/MsQIyzAvuy4XTsUmL4m
         qKwLpV8ETp/qW/fXyldzbhU5T4wEMBs1MWMPVNis6sFfb4w3tV1Go3qYl4M0gFvgGmPY
         /dSyhvP7X/U+lAUl9qM+zbyy6aOxdG0LFvyTu4f5WC16J5+KcqYZ25Y238hEi/EQkJQZ
         iRmcIcRgCtCsCi9pcHkCsrXK4JwquoBU6Bl9rUePyD9LN6Ijpzfw6eL6aoSYORna3yfW
         6TFQ==
X-Received: by 10.68.224.196 with SMTP id re4mr8960718pbc.0.1363783443819;
        Wed, 20 Mar 2013 05:44:03 -0700 (PDT)
Received: from luneth.maa.corp.collab.net ([182.71.239.158])
        by mx.google.com with ESMTPS id y13sm2031559pbv.0.2013.03.20.05.44.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 20 Mar 2013 05:44:02 -0700 (PDT)
X-Mailer: git-send-email 1.8.2
In-Reply-To: <1363783501-27981-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218602>

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
1.8.2
