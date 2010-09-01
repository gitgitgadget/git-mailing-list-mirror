From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: [PATCH] t7405: cd inside subshell instead of around
Date: Wed, 01 Sep 2010 23:01:49 +0200
Message-ID: <4C7EBF3D.9030806@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Heiko Voigt <hvoigt@hvoigt.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 01 23:02:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OquRe-00008I-LT
	for gcvg-git-2@lo.gmane.org; Wed, 01 Sep 2010 23:02:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752109Ab0IAVBv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Sep 2010 17:01:51 -0400
Received: from fmmailgate02.web.de ([217.72.192.227]:33325 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751762Ab0IAVBv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Sep 2010 17:01:51 -0400
Received: from smtp08.web.de  ( [172.20.5.216])
	by fmmailgate02.web.de (Postfix) with ESMTP id F137C16F18B1D;
	Wed,  1 Sep 2010 23:01:49 +0200 (CEST)
Received: from [93.240.114.167] (helo=[192.168.178.29])
	by smtp08.web.de with asmtp (WEB.DE 4.110 #24)
	id 1OquRJ-0001FH-00; Wed, 01 Sep 2010 23:01:49 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.2.8) Gecko/20100802 Thunderbird/3.1.2
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX18y6scGIZ19uipo86QAzYn9Q8fI8lbFsX0nzLp1
	aoYzKJ/gD0dPyXqwCPh2fSKV/xoehJ8ls8pyrc4aTZ+uvgb9Xp
	cbihTEogSIAY7nJdLLRQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155093>

Instead of using `cd dir && (...) && cd..` use `(cd dir && ...)`

This ensures that the test doesn't get caught in the subdirectory if there
is an error in the subshell.

Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
---
 t/t7405-submodule-merge.sh |   17 ++++++-----------
 1 files changed, 6 insertions(+), 11 deletions(-)

diff --git a/t/t7405-submodule-merge.sh b/t/t7405-submodule-merge.sh
index 6ec559d..7e2e258 100755
--- a/t/t7405-submodule-merge.sh
+++ b/t/t7405-submodule-merge.sh
@@ -67,7 +67,7 @@ test_expect_success setup '
 # b in the main repository.
 test_expect_success 'setup for merge search' '
 	mkdir merge-search &&
-	cd merge-search &&
+	(cd merge-search &&
 	git init &&
 	mkdir sub &&
 	(cd sub &&
@@ -101,8 +101,7 @@ test_expect_success 'setup for merge search' '
 	 git checkout -b sub-d sub-b &&
 	 git merge sub-c) &&
 	git commit -a -m "d" &&
-	git branch test b &&
-	cd ..
+	git branch test b)
 '

 test_expect_success 'merge with one side as a fast-forward of the other' '
@@ -126,7 +125,7 @@ test_expect_success 'merging should conflict for non fast-forward' '
 '

 test_expect_success 'merging should fail for ambiguous common parent' '
-	cd merge-search &&
+	(cd merge-search &&
 	git checkout -b test-ambiguous b &&
 	(cd sub &&
 	 git checkout -b ambiguous sub-b &&
@@ -136,8 +135,7 @@ test_expect_success 'merging should fail for ambiguous common parent' '
 	test_must_fail git merge c 2> actual &&
 	grep $(cat expect1) actual > /dev/null &&
 	grep $(cat expect2) actual > /dev/null &&
-	git reset --hard &&
-	cd ..
+	git reset --hard)
 '

 # in a situation like this
@@ -158,7 +156,7 @@ test_expect_success 'merging should fail for ambiguous common parent' '
 # commits (sub-a) does not descend from the submodule merge-base (sub-b).
 #
 test_expect_success 'merging should fail for changes that are backwards' '
-	cd merge-search &&
+	(cd merge-search &&
 	git checkout -b bb a &&
 	(cd sub &&
 	 git checkout sub-b) &&
@@ -175,16 +173,13 @@ test_expect_success 'merging should fail for changes that are backwards' '
 	git commit -a -m "f" &&

 	git checkout -b test-backward e &&
-	test_must_fail git merge f &&
-	cd ..
+	test_must_fail git merge f)
 '

 test_expect_success 'merging with a modify/modify conflict between merge bases' '
-
 	git reset --hard HEAD &&
 	git checkout -b test2 c &&
 	git merge d
-
 '

 test_done
-- 
1.7.2.2.552.gabce9
