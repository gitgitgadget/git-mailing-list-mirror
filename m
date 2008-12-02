From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 1/2 v2] bisect: fix "git bisect skip <commit>" and add tests
 cases
Date: Tue, 2 Dec 2008 14:53:47 +0100
Message-ID: <20081202145347.90403957.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>
To: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Tue Dec 02 14:53:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L7Vh9-0006hr-38
	for gcvg-git-2@gmane.org; Tue, 02 Dec 2008 14:53:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754514AbYLBNwX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Dec 2008 08:52:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754442AbYLBNwW
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Dec 2008 08:52:22 -0500
Received: from smtp4-g19.free.fr ([212.27.42.30]:46942 "EHLO smtp4-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754075AbYLBNwU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Dec 2008 08:52:20 -0500
Received: from smtp4-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp4-g19.free.fr (Postfix) with ESMTP id 6F4C23EA145;
	Tue,  2 Dec 2008 14:52:16 +0100 (CET)
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp4-g19.free.fr (Postfix) with SMTP id 72A7B3EA0D3;
	Tue,  2 Dec 2008 14:52:15 +0100 (CET)
X-Mailer: Sylpheed 2.5.0 (GTK+ 2.12.11; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102134>

The patch that allows "git bisect skip" to be passed a range of
commits using the "<commit1>..<commit2>" notation is flawed because
it introduces a regression when it was passed a simple rev or commit.

"git bisect skip <commit>" doesn't work any more, because <commit>
is quoted but not properly unquoted.

This patch fixes that and add tests cases to better check when it is
passed commits and range of commits.

While at it, this patch also properly quotes the non range arguments
using the "sq" function.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 git-bisect.sh               |    4 ++--
 t/t6030-bisect-porcelain.sh |   19 ++++++++++++++++++-
 2 files changed, 20 insertions(+), 3 deletions(-)

	Change since previous version: now properly quote any non
	range argument using "sq" (in patch 1/2).

diff --git a/git-bisect.sh b/git-bisect.sh
index 6706bc1..ddbdba8 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -199,11 +199,11 @@ bisect_skip() {
             *..*)
                 revs=$(git rev-list "$arg") || die "Bad rev input: $arg" ;;
             *)
-                revs="'$arg'" ;;
+                revs=$(sq "$arg") ;;
 	    esac
             all="$all $revs"
         done
-        bisect_state 'skip' $all
+        eval bisect_state 'skip' $all
 }
 
 bisect_state() {
diff --git a/t/t6030-bisect-porcelain.sh b/t/t6030-bisect-porcelain.sh
index 85fa39c..dd7eac8 100755
--- a/t/t6030-bisect-porcelain.sh
+++ b/t/t6030-bisect-porcelain.sh
@@ -313,8 +313,25 @@ test_expect_success 'bisect run & skip: find first bad' '
 	grep "$HASH6 is first bad commit" my_bisect_log.txt
 '
 
-test_expect_success 'bisect starting with a detached HEAD' '
+test_expect_success 'bisect skip only one range' '
+	git bisect reset &&
+	git bisect start $HASH7 $HASH1 &&
+	git bisect skip $HASH1..$HASH5 &&
+	test "$HASH6" = "$(git rev-parse --verify HEAD)" &&
+	test_must_fail git bisect bad > my_bisect_log.txt &&
+	grep "first bad commit could be any of" my_bisect_log.txt
+'
 
+test_expect_success 'bisect skip many ranges' '
+	git bisect start $HASH7 $HASH1 &&
+	test "$HASH4" = "$(git rev-parse --verify HEAD)" &&
+	git bisect skip $HASH2 $HASH2.. ..$HASH5 &&
+	test "$HASH6" = "$(git rev-parse --verify HEAD)" &&
+	test_must_fail git bisect bad > my_bisect_log.txt &&
+	grep "first bad commit could be any of" my_bisect_log.txt
+'
+
+test_expect_success 'bisect starting with a detached HEAD' '
 	git bisect reset &&
 	git checkout master^ &&
 	HEAD=$(git rev-parse --verify HEAD) &&
-- 
1.6.0.4.838.g4ea49
