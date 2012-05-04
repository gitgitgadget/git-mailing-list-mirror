From: Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH 1/2] t2020-checkout-detach: check for the number of orphaned
 commits
Date: Fri, 04 May 2012 20:13:14 +0200
Message-ID: <4FA41C3A.9080002@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 04 20:13:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SQN0N-0002T3-AG
	for gcvg-git-2@plane.gmane.org; Fri, 04 May 2012 20:13:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753726Ab2EDSNT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 May 2012 14:13:19 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:48276 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753495Ab2EDSNS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 May 2012 14:13:18 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 4FA45A7EBB;
	Fri,  4 May 2012 20:14:44 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id D653219F6CE;
	Fri,  4 May 2012 20:13:14 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; de; rv:1.9.2.28) Gecko/20120306 SUSE/3.1.20 Thunderbird/3.1.20
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197044>

Change the test that orphans commits to leave 2 commits behind. Add a test
that leaves only one of these behind.

The next patch will truncate the list of orphaned commits earlier. With
this preliminary update, its effect will become more obvious.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 I noticed that when you have a detached history, and walk back only part
 of it, the warning lists all of the detached history even if the part
 that ends at the new HEAD is not orphaned. This patch prepares the tests,
 and the next patch changes git-checkout.

 t/t2020-checkout-detach.sh | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/t/t2020-checkout-detach.sh b/t/t2020-checkout-detach.sh
index b37ce25..1839b32 100755
--- a/t/t2020-checkout-detach.sh
+++ b/t/t2020-checkout-detach.sh
@@ -11,14 +11,13 @@ check_not_detached () {
 	git symbolic-ref -q HEAD >/dev/null
 }
 
-ORPHAN_WARNING='you are leaving .* commit.*behind'
 PREV_HEAD_DESC='Previous HEAD position was'
 check_orphan_warning() {
-	test_i18ngrep "$ORPHAN_WARNING" "$1" &&
+	test_i18ngrep "you are leaving $2 behind" "$1" &&
 	test_i18ngrep ! "$PREV_HEAD_DESC" "$1"
 }
 check_no_orphan_warning() {
-	test_i18ngrep ! "$ORPHAN_WARNING" "$1" &&
+	test_i18ngrep ! "you are leaving .* commit.*behind" "$1" &&
 	test_i18ngrep "$PREV_HEAD_DESC" "$1"
 }
 
@@ -110,12 +109,24 @@ test_expect_success 'checkout warns on orphan commits' '
 	git checkout --detach two &&
 	echo content >orphan &&
 	git add orphan &&
-	git commit -a -m orphan &&
+	git commit -a -m orphan1 &&
+	echo new content >orphan &&
+	git commit -a -m orphan2 &&
+	orphan2=$(git rev-parse HEAD) &&
 	git checkout master 2>stderr
 '
 
 test_expect_success 'checkout warns on orphan commits: output' '
-	check_orphan_warning stderr
+	check_orphan_warning stderr "2 commits"
+'
+
+test_expect_success 'checkout warns orphaning 1 of 2 commits' '
+	git checkout "$orphan2" &&
+	git checkout HEAD^ 2>stderr
+'
+
+test_expect_success 'checkout warns orphaning 1 of 2 commits: output' '
+	check_orphan_warning stderr "2 commits"
 '
 
 test_expect_success 'checkout does not warn leaving ref tip' '
-- 
1.7.10.1.462.g199f411
