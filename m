From: Frank Terbeck <ft@bewatermyfriend.org>
Subject: [PATCH v2 3/4] Add tests for coverauto, coverletter and --cover-letter
Date: Mon,  4 May 2009 11:59:01 +0200
Message-ID: <1241431142-8444-4-git-send-email-ft@bewatermyfriend.org>
References: <7v8wlxx18c.fsf@gitster.siamese.dyndns.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Frank Terbeck <ft@bewatermyfriend.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 04 11:59:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M0uxd-0007gz-5V
	for gcvg-git-2@gmane.org; Mon, 04 May 2009 11:59:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753639AbZEDJ7d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 May 2009 05:59:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751706AbZEDJ7c
	(ORCPT <rfc822;git-outgoing>); Mon, 4 May 2009 05:59:32 -0400
Received: from smtprelay09.ispgateway.de ([80.67.29.23]:34060 "EHLO
	smtprelay09.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751323AbZEDJ7a (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 May 2009 05:59:30 -0400
Received: from [212.117.84.176] (helo=fsst.voodoo.lan)
	by smtprelay09.ispgateway.de with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.68)
	(envelope-from <ft@bewatermyfriend.org>)
	id 1M0uxL-0000Hz-2e; Mon, 04 May 2009 11:59:27 +0200
Received: from hawk by fsst.voodoo.lan with local (Exim 4.69)
	(envelope-from <ft@bewatermyfriend.org>)
	id 1M0uwy-0002Cs-91; Mon, 04 May 2009 11:59:04 +0200
X-Mailer: git-send-email 1.6.2.2.446.gfbdc0
In-Reply-To: <7v8wlxx18c.fsf@gitster.siamese.dyndns.org>
X-Df-Sender: 430444
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118221>

Very much based on Jeff King's suggestion from
<20090421033213.GA14881@coredump.intra.peff.net>

This change also makes sure that one major user of --stdout
(git-rebase.sh) works with format.coverauto set to true.

Signed-off-by: Frank Terbeck <ft@bewatermyfriend.org>
---
 t/t3400-rebase.sh       |    1 +
 t/t4014-format-patch.sh |   58 +++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 57 insertions(+), 2 deletions(-)

diff --git a/t/t3400-rebase.sh b/t/t3400-rebase.sh
index 6e391a3..48d8360 100755
--- a/t/t3400-rebase.sh
+++ b/t/t3400-rebase.sh
@@ -15,6 +15,7 @@ export GIT_AUTHOR_EMAIL
 test_expect_success \
     'prepare repository with topic branches' \
     'git config core.logAllRefUpdates true &&
+     git config format.coverauto true &&
      echo First > A &&
      git update-index --add A &&
      git commit -m "Add A." &&
diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index 11061dd..3f431ff 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -151,6 +151,60 @@ test_expect_success 'multiple files' '
 	ls patches/0001-Side-changes-1.patch patches/0002-Side-changes-2.patch patches/0003-Side-changes-3-with-n-backslash-n-in-it.patch
 '
 
+test_expect_success '--cover-letter generates cover letter' '
+
+	rm -rf patches &&
+	git config format.coverletter 1
+	git format-patch --cover-letter -o patches/ master &&
+	test -f patches/0000-cover-letter.patch
+'
+
+test_expect_success 'format.coverletter=number > 1 generates cover letter' '
+
+	rm -rf patches &&
+	git config format.coverletter 3 &&
+	git format-patch --cover-letter -o patches/ master &&
+	test -f patches/0000-cover-letter.patch
+'
+
+test_expect_success 'format.coverletter respects minimum patchset size' '
+
+	rm -rf patches &&
+	git config format.coverletter 4 &&
+	git format-patch --cover-letter -o patches/ master &&
+	! test -f patches/0000-cover-letter.patch
+'
+
+test_expect_success '--cover-letter=never disables cover letters' '
+
+	rm -rf patches &&
+	git config format.coverletter 2 &&
+	git format-patch --cover-letter=never -o patches/ master &&
+	! test -f patches/0000-cover-letter.patch
+'
+
+test_expect_success '--cover-letter=always forces cover letters' '
+
+	rm -rf patches &&
+	git format-patch --cover-letter=always -o patches/ master &&
+	test -f patches/0000-cover-letter.patch
+'
+
+test_expect_success 'format.coverauto works (1)' '
+
+	rm -rf patches &&
+	git config format.coverauto true &&
+	git format-patch -1 -o patches/ master &&
+	! test -f patches/0000-cover-letter.patch
+'
+
+test_expect_success 'format.coverauto works (2)' '
+
+	rm -rf patches &&
+	git format-patch -2 -o patches/ master &&
+	test -f patches/0000-cover-letter.patch
+'
+
 check_threading () {
 	expect="$1" &&
 	shift &&
@@ -405,9 +459,9 @@ test_expect_success 'cover-letter inherits diff options' '
 
 	git mv file foo &&
 	git commit -m foo &&
-	git format-patch --cover-letter -1 &&
+	git format-patch --cover-letter=always -1 &&
 	! grep "file => foo .* 0 *$" 0000-cover-letter.patch &&
-	git format-patch --cover-letter -1 -M &&
+	git format-patch --cover-letter=always -1 -M &&
 	grep "file => foo .* 0 *$" 0000-cover-letter.patch
 
 '
-- 
1.6.2.2.446.gfbdc0
