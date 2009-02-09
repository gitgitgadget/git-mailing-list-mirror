From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/6] t5400: allow individual tests to fail
Date: Mon,  9 Feb 2009 01:09:21 -0800
Message-ID: <1234170565-6740-3-git-send-email-gitster@pobox.com>
References: <1234170565-6740-1-git-send-email-gitster@pobox.com>
 <1234170565-6740-2-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 09 10:11:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LWSAt-0004Zb-2i
	for gcvg-git-2@gmane.org; Mon, 09 Feb 2009 10:11:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752221AbZBIJJh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Feb 2009 04:09:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752242AbZBIJJh
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Feb 2009 04:09:37 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:61124 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751661AbZBIJJe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Feb 2009 04:09:34 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id F3C3A984C8
	for <git@vger.kernel.org>; Mon,  9 Feb 2009 04:09:32 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 067BE984C7 for
 <git@vger.kernel.org>; Mon,  9 Feb 2009 04:09:31 -0500 (EST)
X-Mailer: git-send-email 1.6.2.rc0.28.g2593d
In-Reply-To: <1234170565-6740-2-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 5D72E022-F689-11DD-A3A3-8B21C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109053>

Each test chdir'ed around and ended up in a random place if any of the
test in the sequence failed but the entire test script was allowed to
run.  This wrapps each in a subshell as necessary.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t5400-send-pack.sh |   37 ++++++++++++++++++++++++-------------
 1 files changed, 24 insertions(+), 13 deletions(-)

diff --git a/t/t5400-send-pack.sh b/t/t5400-send-pack.sh
index b21317d..013aced 100755
--- a/t/t5400-send-pack.sh
+++ b/t/t5400-send-pack.sh
@@ -10,6 +10,7 @@ test_description='See why rewinding head breaks send-pack
 
 cnt=64
 test_expect_success setup '
+    (
 	test_tick &&
 	mkdir mozart mozart/is &&
 	echo "Commit #0" >mozart/is/pink &&
@@ -51,7 +52,9 @@ test_expect_success setup '
 	done &&
 	git update-ref HEAD "$commit" &&
 	echo Rebase &&
-	git log'
+	git log
+    )
+'
 
 test_expect_success 'pack the source repository' '
 	git repack -a -d &&
@@ -59,10 +62,12 @@ test_expect_success 'pack the source repository' '
 '
 
 test_expect_success 'pack the destination repository' '
+    (
 	cd victim &&
 	git repack -a -d &&
 	git prune &&
 	cd ..
+    )
 '
 
 test_expect_success \
@@ -89,49 +94,53 @@ test_expect_success \
 	cmp victim/.git/refs/heads/master .git/refs/heads/master
 '
 
-test_expect_success \
-        'push can be used to delete a ref' '
+test_expect_success 'push can be used to delete a ref' '
+    (
 	cd victim &&
 	git branch extra master &&
 	cd .. &&
 	test -f victim/.git/refs/heads/extra &&
 	git send-pack ./victim/.git/ :extra master &&
 	! test -f victim/.git/refs/heads/extra
+    )
 '
 
 unset GIT_CONFIG
 HOME=`pwd`/no-such-directory
 export HOME ;# this way we force the victim/.git/config to be used.
 
-test_expect_success \
-	'pushing a delete should be denied with denyDeletes' '
+test_expect_success 'pushing a delete should be denied with denyDeletes' '
+    (
 	cd victim &&
 	git config receive.denyDeletes true &&
 	git branch extra master &&
 	cd .. &&
 	test -f victim/.git/refs/heads/extra &&
 	test_must_fail git send-pack ./victim/.git/ :extra master
+    )
 '
 rm -f victim/.git/refs/heads/extra
 
-test_expect_success \
-        'pushing with --force should be denied with denyNonFastforwards' '
+test_expect_success 'pushing with --force should be denied with denyNonFastforwards' '
+    (
 	cd victim &&
 	git config receive.denyNonFastforwards true &&
 	cd .. &&
 	git update-ref refs/heads/master master^ || return 1
 	git send-pack --force ./victim/.git/ master && return 1
 	! test_cmp .git/refs/heads/master victim/.git/refs/heads/master
+    )
 '
 
-test_expect_success \
-	'pushing does not include non-head refs' '
+test_expect_success 'pushing does not include non-head refs' '
+    (
 	mkdir parent && cd parent &&
 	git init && touch file && git add file && git commit -m add &&
 	cd .. &&
 	git clone parent child && cd child && git push --all &&
 	cd ../parent &&
 	git branch -a >branches && ! grep origin/master branches
+    )
 '
 
 rewound_push_setup() {
@@ -156,8 +165,8 @@ rewound_push_failed() {
 	fi
 }
 
-test_expect_success \
-	'pushing explicit refspecs respects forcing' '
+test_expect_success 'pushing explicit refspecs respects forcing' '
+    (
 	rewound_push_setup &&
 	if git send-pack ../parent/.git refs/heads/master:refs/heads/master
 	then
@@ -167,10 +176,11 @@ test_expect_success \
 	fi && rewound_push_failed &&
 	git send-pack ../parent/.git +refs/heads/master:refs/heads/master &&
 	rewound_push_succeeded
+    )
 '
 
-test_expect_success \
-	'pushing wildcard refspecs respects forcing' '
+test_expect_success 'pushing wildcard refspecs respects forcing' '
+    (
 	rewound_push_setup &&
 	if git send-pack ../parent/.git refs/heads/*:refs/heads/*
 	then
@@ -180,6 +190,7 @@ test_expect_success \
 	fi && rewound_push_failed &&
 	git send-pack ../parent/.git +refs/heads/*:refs/heads/* &&
 	rewound_push_succeeded
+    )
 '
 
 test_done
-- 
1.6.2.rc0.28.g2593d
