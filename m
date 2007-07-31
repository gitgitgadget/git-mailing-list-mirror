From: =?utf-8?q?Kristian=20H=C3=B8gsberg?= <krh@redhat.com>
Subject: [PATCH] Add test case for basic commit functionality.
Date: Tue, 31 Jul 2007 15:37:30 -0400
Message-ID: <11859106503866-git-send-email-krh@redhat.com>
References: <7vodhtgq99.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com,
	=?utf-8?q?Kristian=20H=C3=B8gsberg?= <krh@redhat.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 31 21:43:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IFxcS-0006gC-0w
	for gcvg-git@gmane.org; Tue, 31 Jul 2007 21:43:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754919AbXGaTmv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 31 Jul 2007 15:42:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754921AbXGaTmu
	(ORCPT <rfc822;git-outgoing>); Tue, 31 Jul 2007 15:42:50 -0400
Received: from mx1.redhat.com ([66.187.233.31]:39551 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754918AbXGaTmu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Jul 2007 15:42:50 -0400
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.1/8.13.1) with ESMTP id l6VJgjGa025545;
	Tue, 31 Jul 2007 15:42:45 -0400
Received: from pobox.corp.redhat.com (pobox.corp.redhat.com [10.11.255.20])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l6VJghUr027819;
	Tue, 31 Jul 2007 15:42:43 -0400
Received: from localhost.localdomain (dhcp83-9.boston.redhat.com [172.16.83.9])
	by pobox.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l6VJgfPg022955;
	Tue, 31 Jul 2007 15:42:42 -0400
X-Mailer: git-send-email 1.5.3.rc3.850.g6ae19-dirty
In-Reply-To: <7vodhtgq99.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54369>

Signed-off-by: Kristian H=C3=B8gsberg <krh@redhat.com>
---

Update: using test_tick now, create test files as part of tests, split
	amend failure and bad options failure into separate test cases.

 t/t7501-commit.sh |  133 +++++++++++++++++++++++++++++++++++++++++++++=
++++++++
 1 files changed, 133 insertions(+), 0 deletions(-)
 create mode 100644 t/t7501-commit.sh

diff --git a/t/t7501-commit.sh b/t/t7501-commit.sh
new file mode 100644
index 0000000..ef0aab5
--- /dev/null
+++ b/t/t7501-commit.sh
@@ -0,0 +1,133 @@
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
+test_tick
+
+test_expect_success \
+	"initial status" \
+	"echo 'bongo bongo' >file &&
+	 git-add file && \
+	 git-status | grep 'Initial commit'"
+
+test_expect_failure \
+	"fail initial amend" \
+	"git-commit --amend"
+
+test_expect_success \
+	"initial commit" \
+	"git-commit -m initial"
+
+test_expect_failure \
+	"invalid options 1" \
+	"git-commit --amend -F file"
+
+test_expect_failure \
+	"invalid options 2" \
+	"git-commit -C HEAD -m illegal"
+
+test_expect_failure \
+	"using invalid commit with -C" \
+	"git-commit -C bogus"
+
+test_expect_failure \
+	"testing nothing to commit" \
+	"git-commit -m initial"
+
+test_expect_success \
+	"next commit" \
+	"echo 'bongo bongo bongo' >file \
+	 git-commit -m next -a"
+
+test_expect_failure \
+	"commit message from non-existing file" \
+	"echo 'more bongo: bongo bongo bongo bongo' >file && \
+	 git-commit -F gah -a"
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
+test_expect_success \
+	"commit message from file" \
+	"echo 'this is the commit message, coming from a file' >msg && \
+	 git-commit -F msg -a"
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
+test_expect_failure \
+	"passing --amend and -F" \
+	"echo 'enough with the bongos' >file && \
+	 git-commit -F msg --amend ."
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
+test_expect_success \
+	"editing message from other commit" \
+	"echo 'hula hula' >file && \
+	 VISUAL=3D./editor git-commit -c HEAD^ -a"
+
+test_expect_success \
+	"message from stdin" \
+	"echo 'silly new contents' >file && \
+	 echo commit message from stdin | git-commit -F - -a"
+
+test_expect_success \
+	"overriding author from command line" \
+	"echo 'gak' >file && \
+	 git-commit -m 'author' --author 'Rubber Duck <rduck@convoy.org>' -a"
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
+72c0dc9855b0c9dadcbfd5a31cab072e0cb774ca
+9b88fc14ce6b32e3d9ee021531a54f18a5cf38a2
+3536bbb352c3a1ef9a420f5b4242d48578b92aa7
+d381ac431806e53f3dd7ac2f1ae0534f36d738b9
+4fd44095ad6334f3ef72e4c5ec8ddf108174b54a
+402702b49136e7587daa9280e91e4bb7cb2179f7
+EOF
+
+test_expect_success \
+    'validate git-rev-list output.' \
+    'diff current expected'
+
+test_done
--=20
1.5.2.GIT
