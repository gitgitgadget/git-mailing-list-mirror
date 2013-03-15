From: Peter Eisentraut <peter@eisentraut.org>
Subject: [PATCH] pull: Apply -q and -v options to rebase mode as well
Date: Thu, 14 Mar 2013 22:26:08 -0400
Message-ID: <1363314368.14066.3.camel@vanquo.pezone.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Mar 15 03:36:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UGKVt-00015I-Kq
	for gcvg-git-2@plane.gmane.org; Fri, 15 Mar 2013 03:36:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753631Ab3COCg3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Mar 2013 22:36:29 -0400
Received: from eisentraut.org ([85.214.91.16]:38638 "EHLO gattler.pezone.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753609Ab3COCg1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Mar 2013 22:36:27 -0400
X-Greylist: delayed 613 seconds by postgrey-1.27 at vger.kernel.org; Thu, 14 Mar 2013 22:36:26 EDT
Received: from [192.168.1.5] (pool-108-52-108-60.phlapa.fios.verizon.net [108.52.108.60])
	by gattler.pezone.net (Postfix) with ESMTPSA id E7EE05A87B6;
	Fri, 15 Mar 2013 02:26:10 +0000 (UTC)
X-Mailer: Evolution 3.4.4-2 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218184>

git pull passed -q and -v only to git merge, but they can be useful for
git rebase as well, so pass them there, too.  In particular, using -q
shuts up the "Already up-to-date." message.  Add test cases to prove it.

Signed-off-by: Peter Eisentraut <peter@eisentraut.org>
---
 git-pull.sh             |    2 +-
 t/t5521-pull-options.sh |   27 +++++++++++++++++++++++++++
 2 files changed, 28 insertions(+), 1 deletion(-)

diff --git a/git-pull.sh b/git-pull.sh
index 266e682..5d97e97 100755
--- a/git-pull.sh
+++ b/git-pull.sh
@@ -279,7 +279,7 @@ fi
 merge_name=$(git fmt-merge-msg $log_arg <"$GIT_DIR/FETCH_HEAD") || exit
 case "$rebase" in
 true)
-	eval="git-rebase $diffstat $strategy_args $merge_args"
+	eval="git-rebase $diffstat $strategy_args $merge_args $verbosity"
 	eval="$eval --onto $merge_head ${oldremoteref:-$merge_head}"
 	;;
 *)
diff --git a/t/t5521-pull-options.sh b/t/t5521-pull-options.sh
index 1b06691..aa31abe 100755
--- a/t/t5521-pull-options.sh
+++ b/t/t5521-pull-options.sh
@@ -19,6 +19,17 @@ test_expect_success 'git pull -q' '
 	test ! -s out)
 '
 
+test_expect_success 'git pull -q --rebase' '
+	mkdir clonedqrb &&
+	(cd clonedqrb && git init &&
+	git pull -q --rebase "../parent" >out 2>err &&
+	test ! -s err &&
+	test ! -s out &&
+	git pull -q --rebase "../parent" >out 2>err &&
+	test ! -s err &&
+	test ! -s out)
+'
+
 test_expect_success 'git pull' '
 	mkdir cloned &&
 	(cd cloned && git init &&
@@ -27,6 +38,14 @@ test_expect_success 'git pull' '
 	test ! -s out)
 '
 
+test_expect_success 'git pull --rebase' '
+	mkdir clonedrb &&
+	(cd clonedrb && git init &&
+	git pull --rebase "../parent" >out 2>err &&
+	test -s err &&
+	test ! -s out)
+'
+
 test_expect_success 'git pull -v' '
 	mkdir clonedv &&
 	(cd clonedv && git init &&
@@ -35,6 +54,14 @@ test_expect_success 'git pull -v' '
 	test ! -s out)
 '
 
+test_expect_success 'git pull -v --rebase' '
+	mkdir clonedvrb &&
+	(cd clonedvrb && git init &&
+	git pull -v --rebase "../parent" >out 2>err &&
+	test -s err &&
+	test ! -s out)
+'
+
 test_expect_success 'git pull -v -q' '
 	mkdir clonedvq &&
 	(cd clonedvq && git init &&
-- 
1.7.10.4
