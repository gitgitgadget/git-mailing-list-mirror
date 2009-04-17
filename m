From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH 5/5] archive test: test new --fix-attributes feature
Date: Fri, 17 Apr 2009 21:53:52 +0200
Message-ID: <49E8DE50.5000908@lsrfire.ath.cx>
References: <1239848917-14399-1-git-send-email-gitster@pobox.com> <1239848917-14399-2-git-send-email-gitster@pobox.com> <1239848917-14399-3-git-send-email-gitster@pobox.com> <1239848917-14399-4-git-send-email-gitster@pobox.com> <1239848917-14399-5-git-send-email-gitster@pobox.com> <1239848917-14399-6-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 17 21:55:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Luu9r-00034t-PY
	for gcvg-git-2@gmane.org; Fri, 17 Apr 2009 21:55:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753734AbZDQTx6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Apr 2009 15:53:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753582AbZDQTx5
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Apr 2009 15:53:57 -0400
Received: from india601.server4you.de ([85.25.151.105]:60675 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753449AbZDQTx5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Apr 2009 15:53:57 -0400
Received: from [10.0.1.101] (p57B7F146.dip.t-dialin.net [87.183.241.70])
	by india601.server4you.de (Postfix) with ESMTPSA id 905592F8044;
	Fri, 17 Apr 2009 21:53:55 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
In-Reply-To: <1239848917-14399-6-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116784>

Could you please squash in the following, which adds test cases for bare repos
and gives every export-ignore file existence test its own test case?  And also

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>

?

 t/t5001-archive-attr.sh |   46 ++++++++++++++++++++++++++++++++++++++--------
 1 files changed, 38 insertions(+), 8 deletions(-)

diff --git a/t/t5001-archive-attr.sh b/t/t5001-archive-attr.sh
index b754f21..dd93c3f 100755
--- a/t/t5001-archive-attr.sh
+++ b/t/t5001-archive-attr.sh
@@ -6,6 +6,14 @@ test_description='git archive attribute tests'
 
 SUBSTFORMAT=%H%n
 
+test_expect_exists() {
+	test_expect_success " $1 exists" "test -e $1"
+}
+
+test_expect_missing() {
+	test_expect_success " $1 does not exist" "test ! -e $1"
+}
+
 test_expect_success 'setup' '
 	echo ignored >ignored &&
 	echo ignored export-ignore >>.git/info/attributes &&
@@ -25,7 +33,10 @@ test_expect_success 'setup' '
 	echo "substfile?" export-subst >>.git/info/attributes &&
 	git add nosubstfile substfile1 substfile2 &&
 
-	git commit -m.
+	git commit -m. &&
+
+	git clone --bare . bare &&
+	cp .git/info/attributes bare/info/attributes
 '
 
 test_expect_success 'git archive' '
@@ -33,20 +44,34 @@ test_expect_success 'git archive' '
 	(mkdir archive && cd archive && "$TAR" xf -) <archive.tar
 '
 
+test_expect_missing	archive/ignored
+test_expect_missing	archive/ignored-by-tree
+test_expect_exists	archive/ignored-by-worktree
+
 test_expect_success 'git archive with worktree attributes' '
 	git archive --fix-attributes HEAD >worktree.tar &&
 	(mkdir worktree && cd worktree && "$TAR" xf -) <worktree.tar
 '
 
-test_expect_success 'export-ignore' '
-	test ! -e archive/ignored &&
-	test ! -e archive/ignored-by-tree &&
-	test   -e archive/ignored-by-worktree &&
-	test ! -e worktree/ignored &&
-	test   -e worktree/ignored-by-tree &&
-	test ! -e worktree/ignored-by-worktree
+test_expect_missing	worktree/ignored
+test_expect_exists	worktree/ignored-by-tree
+test_expect_missing	worktree/ignored-by-worktree
+
+test_expect_success 'git archive vs. bare' '
+	(cd bare && git archive HEAD) >bare-archive.tar &&
+	test_cmp archive.tar bare-archive.tar
+'
+
+test_expect_success 'git archive with worktree attributes, bare' '
+	(cd bare && git archive --fix-attributes HEAD) >bare-worktree.tar &&
+	(mkdir bare-worktree && cd bare-worktree && "$TAR" xf -
+	) <bare-worktree.tar
 '
 
+test_expect_missing	bare-worktree/ignored
+test_expect_exists	bare-worktree/ignored-by-tree
+test_expect_exists	bare-worktree/ignored-by-worktree
+
 test_expect_success 'export-subst' '
 	git log "--pretty=format:A${SUBSTFORMAT}O" HEAD >substfile1.expected &&
 	test_cmp nosubstfile archive/nosubstfile &&
@@ -59,4 +84,9 @@ test_expect_success 'git tar-tree vs. git archive with worktree attributes' '
 	test_cmp worktree.tar tar-tree.tar
 '
 
+test_expect_success 'git tar-tree vs. git archive with worktree attrs, bare' '
+	(cd bare && git tar-tree HEAD) >bare-tar-tree.tar &&
+	test_cmp bare-worktree.tar bare-tar-tree.tar
+'
+
 test_done
