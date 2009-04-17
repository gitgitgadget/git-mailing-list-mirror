From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH v2 5/5] archive test: attributes
Date: Sat, 18 Apr 2009 00:18:10 +0200
Message-ID: <49E90022.20700@lsrfire.ath.cx>
References: <1239848917-14399-1-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Apr 18 00:20:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LuwQ4-0000iT-RG
	for gcvg-git-2@gmane.org; Sat, 18 Apr 2009 00:20:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762044AbZDQWSS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Apr 2009 18:18:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762204AbZDQWSQ
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Apr 2009 18:18:16 -0400
Received: from india601.server4you.de ([85.25.151.105]:46220 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762149AbZDQWSP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Apr 2009 18:18:15 -0400
Received: from [10.0.1.101] (p57B7DF1E.dip.t-dialin.net [87.183.223.30])
	by india601.server4you.de (Postfix) with ESMTPSA id 9A3562F8044;
	Sat, 18 Apr 2009 00:18:13 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
In-Reply-To: <1239848917-14399-1-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116796>

Add a test script for all archive attributes and their handling in
normal and bare repositories.  export-ignore and export-subst are
tested, as well as the effect of the option --worktree-attributes.

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
Any attribute related tests in t5000 can eventually be removed if
there is an equivalent test in t5001 -- and there should be.

 t/t5001-archive-attr.sh |   91 +++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 91 insertions(+), 0 deletions(-)
 create mode 100755 t/t5001-archive-attr.sh

diff --git a/t/t5001-archive-attr.sh b/t/t5001-archive-attr.sh
new file mode 100755
index 0000000..426b319
--- /dev/null
+++ b/t/t5001-archive-attr.sh
@@ -0,0 +1,91 @@
+#!/bin/sh
+
+test_description='git archive attribute tests'
+
+. ./test-lib.sh
+
+SUBSTFORMAT=%H%n
+
+test_expect_exists() {
+	test_expect_success " $1 exists" "test -e $1"
+}
+
+test_expect_missing() {
+	test_expect_success " $1 does not exist" "test ! -e $1"
+}
+
+test_expect_success 'setup' '
+	echo ignored >ignored &&
+	echo ignored export-ignore >>.git/info/attributes &&
+	git add ignored &&
+
+	echo ignored by tree >ignored-by-tree &&
+	echo ignored-by-tree export-ignore >.gitattributes &&
+	git add ignored-by-tree .gitattributes &&
+
+	echo ignored by worktree >ignored-by-worktree &&
+	echo ignored-by-worktree export-ignore >.gitattributes &&
+	git add ignored-by-worktree &&
+
+	printf "A\$Format:%s\$O" "$SUBSTFORMAT" >nosubstfile &&
+	printf "A\$Format:%s\$O" "$SUBSTFORMAT" >substfile1 &&
+	printf "A not substituted O" >substfile2 &&
+	echo "substfile?" export-subst >>.git/info/attributes &&
+	git add nosubstfile substfile1 substfile2 &&
+
+	git commit -m. &&
+
+	git clone --bare . bare &&
+	cp .git/info/attributes bare/info/attributes
+'
+
+test_expect_success 'git archive' '
+	git archive HEAD >archive.tar &&
+	(mkdir archive && cd archive && "$TAR" xf -) <archive.tar
+'
+
+test_expect_missing	archive/ignored
+test_expect_missing	archive/ignored-by-tree
+test_expect_exists	archive/ignored-by-worktree
+
+test_expect_success 'git archive with worktree attributes' '
+	git archive --worktree-attributes HEAD >worktree.tar &&
+	(mkdir worktree && cd worktree && "$TAR" xf -) <worktree.tar
+'
+
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
+	(cd bare && git archive --worktree-attributes HEAD) >bare-worktree.tar &&
+	(mkdir bare-worktree && cd bare-worktree && "$TAR" xf -) <bare-worktree.tar
+'
+
+test_expect_missing	bare-worktree/ignored
+test_expect_exists	bare-worktree/ignored-by-tree
+test_expect_exists	bare-worktree/ignored-by-worktree
+
+test_expect_success 'export-subst' '
+	git log "--pretty=format:A${SUBSTFORMAT}O" HEAD >substfile1.expected &&
+	test_cmp nosubstfile archive/nosubstfile &&
+	test_cmp substfile1.expected archive/substfile1 &&
+	test_cmp substfile2 archive/substfile2
+'
+
+test_expect_success 'git tar-tree vs. git archive with worktree attributes' '
+	git tar-tree HEAD >tar-tree.tar &&
+	test_cmp worktree.tar tar-tree.tar
+'
+
+test_expect_success 'git tar-tree vs. git archive with worktree attrs, bare' '
+	(cd bare && git tar-tree HEAD) >bare-tar-tree.tar &&
+	test_cmp bare-worktree.tar bare-tar-tree.tar
+'
+
+test_done
-- 
1.6.3.rc0
