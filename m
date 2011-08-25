From: Brad King <brad.king@kitware.com>
Subject: [PATCH] rev-list: Demonstrate breakage with --ancestry-path --all
Date: Thu, 25 Aug 2011 12:49:13 -0400
Message-ID: <438ea0b254ccafb3fc9f3431f8f86007cc03132b.1314290439.git.brad.king@kitware.com>
References: <20110824213205.GI45292@book.hvoigt.net>
Cc: Heiko Voigt <hvoigt@hvoigt.net>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Aug 25 18:49:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qwd7K-0001Z3-7N
	for gcvg-git-2@lo.gmane.org; Thu, 25 Aug 2011 18:49:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753938Ab1HYQtQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Aug 2011 12:49:16 -0400
Received: from 66-194-253-20.static.twtelecom.net ([66.194.253.20]:45834 "EHLO
	public.kitware.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753485Ab1HYQtP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Aug 2011 12:49:15 -0400
Received: from vesper (vesper.kitwarein.com [192.168.1.207])
	by public.kitware.com (Postfix) with ESMTP id BFB3336158;
	Thu, 25 Aug 2011 12:49:13 -0400 (EDT)
Received: by vesper (Postfix, from userid 1000)
	id AA55B6098; Thu, 25 Aug 2011 12:49:13 -0400 (EDT)
X-Mailer: git-send-email 1.7.4.4
In-Reply-To: <20110824213205.GI45292@book.hvoigt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180090>

The option added by commit ebdc94f3 (revision: --ancestry-path,
2010-04-20) does not work properly in combination with --all, at least
in the case of a criss-cross merge:

    b---bc
   / \ /
  a   X
   \ / \
    c---cb

There are no descendants of 'cb' in the history.  The command

  git rev-list --ancestry-path cb..bc

correctly reports no commits.  However, the command

  git rev-list --ancestry-path --all ^cb

reports 'bc'.  Add a test case to t6019-rev-list-ancestry-path
demonstrating this breakage.

Signed-off-by: Brad King <brad.king@kitware.com>
---

I tried to fix the submodule merge search during a recursive merge by
only doing it when o->call_depth is zero.  While testing the fix I
noticed that the merge search was reporting an incorrect commit as a
suggested submodule merge resolution.  Internally the merge search uses
"rev-list --merges --ancestry-path --all ^a" to find all merges that
contain 'a'.  The rev-list incorrectly reports the other side of the
criss-cross history.  I narrowed the problem down to this test case.

Brad

 t/t6019-rev-list-ancestry-path.sh |   35 +++++++++++++++++++++++++++++++++++
 1 files changed, 35 insertions(+), 0 deletions(-)

diff --git a/t/t6019-rev-list-ancestry-path.sh b/t/t6019-rev-list-ancestry-path.sh
index 7641029..aa4674f 100755
--- a/t/t6019-rev-list-ancestry-path.sh
+++ b/t/t6019-rev-list-ancestry-path.sh
@@ -70,4 +70,39 @@ test_expect_success 'rev-list --ancestry-patch D..M -- M.t' '
 	test_cmp expect actual
 '
 
+#   b---bc
+#  / \ /
+# a   X
+#  \ / \
+#   c---cb
+test_expect_success 'setup criss-cross' '
+	mkdir criss-cross &&
+	(cd criss-cross &&
+	 git init &&
+	 test_commit A &&
+	 git checkout -b b master &&
+	 test_commit B &&
+	 git checkout -b c master &&
+	 test_commit C &&
+	 git checkout -b bc b -- &&
+	 git merge c &&
+	 git checkout -b cb c -- &&
+	 git merge b &&
+	 git checkout master)
+'
+
+# no commits in bc descend from cb
+test_expect_success 'criss-cross: rev-list --ancestry-path cb..bc' '
+	(cd criss-cross &&
+	 git rev-list --ancestry-path cb..bc > actual &&
+	 test -z "$(cat actual)")
+'
+
+# no commits in repository descend from cb
+test_expect_failure 'criss-cross: rev-list --ancestry-path --all ^cb' '
+	(cd criss-cross &&
+	 git rev-list --ancestry-path --all ^cb > actual &&
+	 test -z "$(cat actual)")
+'
+
 test_done
-- 
1.7.4.4
