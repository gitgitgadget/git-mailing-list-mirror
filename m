From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH] bisect: fix quoting TRIED revs when "bad" commit is also
 "skip"ped
Date: Thu, 26 Feb 2009 08:29:18 +0100
Message-ID: <20090226082918.6adbc565.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 26 08:31:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LcaiZ-0007Em-MX
	for gcvg-git-2@gmane.org; Thu, 26 Feb 2009 08:31:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752047AbZBZHaK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Feb 2009 02:30:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751948AbZBZHaK
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Feb 2009 02:30:10 -0500
Received: from smtp6-g21.free.fr ([212.27.42.6]:56446 "EHLO smtp6-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750818AbZBZHaJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Feb 2009 02:30:09 -0500
Received: from smtp6-g21.free.fr (localhost [127.0.0.1])
	by smtp6-g21.free.fr (Postfix) with ESMTP id 793D6E080C3;
	Thu, 26 Feb 2009 08:29:59 +0100 (CET)
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp6-g21.free.fr (Postfix) with SMTP id 3921EE0810D;
	Thu, 26 Feb 2009 08:29:57 +0100 (CET)
X-Mailer: Sylpheed 2.5.0 (GTK+ 2.12.11; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111537>

Before this patch, when the "bad" commit was also "skip"ped and
when more than one commit was skipped, the "filter_skipped" function
would have printed something like:

bisect_rev=<hash1>|<hash2>

(where <hash1> and <hash2> are hexadecimal sha1 hashes)

and this would have been evaled later as piping "bisect_rev=<hash1>"
into "<hash2>", which would have failed.

So this patch makes the "filter_skipped" function properly quote
what it outputs, so that it will print something like:

bisect_rev="<hash1>|<hash2>"

which will be properly evaled later.

A test case is added to the test suite.

And while at it, we also remove a spurious space where the
"exit_if_skipped_commits" function is defined.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 git-bisect.sh               |    4 ++--
 t/t6030-bisect-porcelain.sh |   25 +++++++++++++++++++++++++
 2 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/git-bisect.sh b/git-bisect.sh
index 85db4ba..105bc6a 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -309,7 +309,7 @@ filter_skipped() {
 			# This should happen only if the "bad"
 			# commit is also a "skip" commit.
 			,,*,bisect_rev*)
-				echo "bisect_rev=$TRIED"
+				echo "bisect_rev=\"$TRIED\""
 				VARS=1
 				;;
 
@@ -342,7 +342,7 @@ filter_skipped() {
 	done
 }
 
-exit_if_skipped_commits () {
+exit_if_skipped_commits() {
 	_tried=$1
 	if expr "$_tried" : ".*[|].*" > /dev/null ; then
 		echo "There are only 'skip'ped commit left to test."
diff --git a/t/t6030-bisect-porcelain.sh b/t/t6030-bisect-porcelain.sh
index dd7eac8..b5da16f 100755
--- a/t/t6030-bisect-porcelain.sh
+++ b/t/t6030-bisect-porcelain.sh
@@ -224,6 +224,31 @@ test_expect_success 'bisect skip: cannot tell between 2 commits' '
 	fi
 '
 
+# $HASH1 is good, $HASH4 is both skipped and bad, we skip $HASH3
+# and $HASH2 is good,
+# so we should not be able to tell the first bad commit
+# among $HASH3 and $HASH4
+test_expect_success 'bisect skip: with commit both bad and skipped' '
+	git bisect start &&
+	git bisect skip &&
+	git bisect bad &&
+	git bisect good $HASH1 &&
+	git bisect skip &&
+	if git bisect good > my_bisect_log.txt
+	then
+		echo Oops, should have failed.
+		false
+	else
+		test $? -eq 2 &&
+		grep "first bad commit could be any of" my_bisect_log.txt &&
+		test_must_fail grep $HASH1 my_bisect_log.txt &&
+		test_must_fail grep $HASH2 my_bisect_log.txt &&
+		grep $HASH3 my_bisect_log.txt &&
+		grep $HASH4 my_bisect_log.txt &&
+		git bisect reset
+	fi
+'
+
 # We want to automatically find the commit that
 # introduced "Another" into hello.
 test_expect_success \
-- 
1.6.2.rc1.20.g8c5b.dirty
