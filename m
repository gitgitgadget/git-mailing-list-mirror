From: =?utf-8?q?Kristian=20H=C3=B8gsberg?= <krh@redhat.com>
Subject: [PATCH 1/5] Add test case for basic commit functionality.
Date: Mon, 30 Jul 2007 17:28:42 -0400
Message-ID: <11858309261111-git-send-email-krh@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?q?Kristian=20H=C3=B8gsberg?= <krh@redhat.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 30 23:34:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IFcsN-0003SK-V2
	for gcvg-git@gmane.org; Mon, 30 Jul 2007 23:34:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S968013AbXG3Vd6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 30 Jul 2007 17:33:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967760AbXG3Vd4
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Jul 2007 17:33:56 -0400
Received: from mx1.redhat.com ([66.187.233.31]:51410 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S967598AbXG3Vd4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jul 2007 17:33:56 -0400
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.1/8.13.1) with ESMTP id l6ULXtDs015511
	for <git@vger.kernel.org>; Mon, 30 Jul 2007 17:33:55 -0400
Received: from pobox.corp.redhat.com (pobox.corp.redhat.com [10.11.255.20])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l6ULXtGg026636;
	Mon, 30 Jul 2007 17:33:55 -0400
Received: from localhost.localdomain (dhcp83-9.boston.redhat.com [172.16.83.9])
	by pobox.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l6ULXs9v018718;
	Mon, 30 Jul 2007 17:33:54 -0400
X-Mailer: git-send-email 1.5.3.rc3.848.g198b7-dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54272>

Signed-off-by: Kristian H=C3=B8gsberg <krh@redhat.com>
---
 t/t7501-commit.sh |  126 +++++++++++++++++++++++++++++++++++++++++++++=
++++++++
 1 files changed, 126 insertions(+), 0 deletions(-)
 create mode 100644 t/t7501-commit.sh

diff --git a/t/t7501-commit.sh b/t/t7501-commit.sh
new file mode 100644
index 0000000..eba19da
--- /dev/null
+++ b/t/t7501-commit.sh
@@ -0,0 +1,126 @@
+#!/bin/sh
+#
+# Copyright (c) 2007 Kristian H=C3=B8gsberg <krh@redhat.com>
+#
+
+# FIXME: Test the various index usages, -i and -o, test reflog,
+# signoff, hooks
+
+test_description=3D'git-commit'
+. ./test-lib.sh
+
+# Pick a date so we get consistent commits. 7/7/07 means good luck!
+export GIT_AUTHOR_DATE=3D"July 7, 2007"
+export GIT_COMMITTER_DATE=3D"July 7, 2007"
+
+echo "bongo bongo" >file
+test_expect_success \
+	"initial status" \
+	"git-add file && \
+	 git-status | grep 'Initial commit'"
+
+test_expect_failure \
+	"fail initial amend" \
+	"git-commit -m initial --amend"
+
+test_expect_success \
+	"initial commit" \
+	"git-commit -m initial"
+
+test_expect_failure \
+	"testing nothing to commit" \
+	"git-commit -m initial"
+
+echo "bongo bongo bongo" >file
+
+test_expect_success \
+	"next commit" \
+	"git-commit -m next -a"
+
+echo "more bongo: bongo bongo bongo bongo" >file
+
+test_expect_failure \
+	"commit message from non-existing file" \
+	"git-commit -F gah -a"
+
+cat >msg <<EOF
+	=09
+
+ =20
+Signed-off-by: hula
+EOF
+test_expect_failure \
+	"empty commit message" \
+	"git-commit -F msg -a"
+
+echo "this is the commit message, coming from a file" >msg
+test_expect_success \
+	"commit message from file" \
+	"git-commit -F msg -a"
+
+cat >editor <<\EOF
+#!/bin/sh
+sed -i -e "s/a file/an amend commit/g" $1
+EOF
+chmod 755 editor
+
+test_expect_success \
+	"amend commit" \
+	"VISUAL=3D./editor git-commit --amend"
+
+echo "enough with the bongos" >file
+test_expect_failure \
+	"passing --amend and -F" \
+	"git-commit -F msg --amend ."
+
+test_expect_success \
+	"using message from other commit" \
+	"git-commit -C HEAD^ ."
+
+cat >editor <<\EOF
+#!/bin/sh
+sed -i -e "s/amend/older/g" $1
+EOF
+chmod 755 editor
+
+echo "hula hula" >file
+test_expect_success \
+	"editing message from other commit" \
+	"VISUAL=3D./editor git-commit -c HEAD^ -a"
+
+echo "silly new contents" >file
+test_expect_success \
+	"message from stdin" \
+	"echo commit message from stdin | git-commit -F - -a"
+
+echo "gak" >file
+test_expect_success \
+	"overriding author from command line" \
+	"git-commit -m 'author' --author 'Rubber Duck <rduck@convoy.org>' -a"
+
+test_expect_success \
+	"interactive add" \
+	"echo 7 | git-commit --interactive | grep 'What now'"
+
+test_expect_success \
+	"showing committed revisions" \
+	"git-rev-list HEAD >current"
+
+# We could just check the head sha1, but checking each commit makes it
+# easier to isolate bugs.
+
+cat >expected <<\EOF
+b19013342b676054179a1685d62b07f56b354331
+763fd16cd476920986129b09672915be44847d90
+b97ce6debb52cbb541d798ce4c2cefa3c9f20332
+720cebf2e443885c6325a0a602ddb9922376452c
+19db513255cc049feee9c107e60297a48c6b0df4
+4cd324560cd9dcac18f17bac227b17238ad458f9
+821776fc6a0699927268feb5e157d245cdcd102a
+EOF
+
+test_expect_success \
+    'validate git-rev-list output.' \
+    'diff current expected'
+
+test_done
--=20
1.5.2.GIT
