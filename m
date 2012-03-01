From: =?UTF-8?q?Zbigniew=20J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
Subject: [PATCH v7a 1/9] diff --stat: tests for long filenames and big change counts
Date: Thu,  1 Mar 2012 13:26:38 +0100
Message-ID: <1330604806-30288-1-git-send-email-zbyszek@in.waw.pl>
References: <7vfwdts6wj.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: pclouds@gmail.com, j.sixt@viscovery.net,
	=?UTF-8?q?Zbigniew=20J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Mar 01 13:27:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S356N-0004OF-3y
	for gcvg-git-2@plane.gmane.org; Thu, 01 Mar 2012 13:27:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030758Ab2CAM1F convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 1 Mar 2012 07:27:05 -0500
Received: from kawka.in.waw.pl ([178.63.212.103]:55367 "EHLO kawka.in.waw.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030483Ab2CAM1B (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Mar 2012 07:27:01 -0500
Received: from optyk25.fuw.edu.pl ([193.0.81.79] helo=ameba.fuw.edu.pl)
	by kawka.in.waw.pl with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <zbyszek@in.waw.pl>)
	id 1S3561-00026K-UI; Thu, 01 Mar 2012 13:26:58 +0100
X-Mailer: git-send-email 1.7.9.2.399.gdf4d.dirty
In-Reply-To: <7vfwdts6wj.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191918>

=46rom: Junio C Hamano <gitster@pobox.com>

In preparation for updates to the "diff --stat" that updates the logic
to split the allotted columns into the name part and the graph part to
make the output more readable, add a handful of tests to document the
corner case behaviour in which long filenames and big changes are shown=
=2E

When a pathname is so long that it cannot fit on the column, the curren=
t
code truncates it to make sure that the graph part has enough room to s=
how
a meaningful graph.  If the actual change is small (e.g. only one line
changed), this results in the final output that is shorter than the wid=
th
we aim for.

Signed-off-by: Zbigniew J=C4=99drzejewski-Szmek <zbyszek@in.waw.pl>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
v7a:

De-decuplicate new tests added in t4014 and t4052. Test descriptions
are taken from t4014, but the tests are all added in t4052.

This patch is a merge of 't4014: addtional format-patch test vectors'
from Junio C Hamano and v7 of my 'diff --stat: tests for long filenames
and big change counts'.

The rest of the series is only updated to apply cleanly after the chang=
es
to tests.

[This patch series does not include the additional patches to minimize
the number of columns used for the change count number.]

 t/t4052-stat-output.sh |  182 ++++++++++++++++++++++++++++++++++++++++=
++++++++
 1 file changed, 182 insertions(+)
 create mode 100755 t/t4052-stat-output.sh

diff --git a/t/t4052-stat-output.sh b/t/t4052-stat-output.sh
new file mode 100755
index 0000000..f766c47
--- /dev/null
+++ b/t/t4052-stat-output.sh
@@ -0,0 +1,182 @@
+#!/bin/sh
+#
+# Copyright (c) 2012 Zbigniew J=C4=99drzejewski-Szmek
+#
+
+test_description=3D'test --stat output of various commands'
+
+. ./test-lib.sh
+. "$TEST_DIRECTORY"/lib-terminal.sh
+
+# 120 character name
+name=3Daaaaaaaaaa
+name=3D$name$name$name$name$name$name$name$name$name$name$name$name
+test_expect_success 'preparation' '
+	>"$name" &&
+	git add "$name" &&
+	git commit -m message &&
+	echo a >"$name" &&
+	git commit -m message "$name"
+'
+
+while read cmd args
+do
+	cat >expect <<-'EOF'
+	 ...aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa |    1 +
+	EOF
+	test_expect_success "$cmd: a short graph bar does not extend to the f=
ull width" '
+		git $cmd $args >output &&
+		grep " | " output >actual &&
+		test_cmp expect actual
+	'
+
+	cat >expect <<-'EOF'
+	 ...aaaaaaaaaaaaaaaaaaaaaa |    1 +
+	EOF
+	test_expect_success "$cmd --stat=3Dwidth: name is chopped to leave ro=
om to the right of a short bar" '
+		git $cmd $args --stat=3D40 >output &&
+		grep " | " output >actual &&
+		test_cmp expect actual
+	'
+
+	test_expect_success "$cmd --stat-width=3Dwidth with long name" '
+		git $cmd $args --stat-width=3D40 >output &&
+		grep " | " output >actual &&
+		test_cmp expect actual
+	'
+
+	cat >expect <<-'EOF'
+	 ...aaaaaaaaaaaaaaaaaaaaaaaaaaa |    1 +
+	EOF
+	test_expect_success "$cmd --stat=3D...,name-width with long name" '
+		git $cmd $args --stat=3D60,30 >output &&
+		grep " | " output >actual &&
+		test_cmp expect actual
+	'
+
+	test_expect_success "$cmd --stat-name-width with long name" '
+		git $cmd $args --stat-name-width=3D30 >output &&
+		grep " | " output >actual &&
+		test_cmp expect actual
+	'
+done <<\EOF
+format-patch -1 --stdout
+diff HEAD^ HEAD --stat
+show --stat
+log -1 --stat
+EOF
+
+
+test_expect_success 'preparation for big change tests' '
+	>abcd &&
+	git add abcd &&
+	git commit -m message &&
+	i=3D0 &&
+	while test $i -lt 1000
+	do
+		echo $i && i=3D$(($i + 1))
+	done >abcd &&
+	git commit -m message abcd
+'
+
+cat >expect80 <<'EOF'
+ abcd | 1000 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
+++++++++
+EOF
+
+while read verb expect cmd args
+do
+	test_expect_success "$cmd $verb COLUMNS (big change)" '
+		COLUMNS=3D200 git $cmd $args >output
+		grep " | " output >actual &&
+		test_cmp "$expect" actual
+	'
+done <<\EOF
+ignores expect80 format-patch -1 --stdout
+ignores expect80 diff HEAD^ HEAD --stat
+ignores expect80 show --stat
+ignores expect80 log -1 --stat
+EOF
+
+cat >expect <<'EOF'
+ abcd | 1000 ++++++++++++++++++++++++++
+EOF
+while read cmd args
+do
+	test_expect_success "$cmd --stat=3Dwidth with big change" '
+		git $cmd $args --stat=3D40 >output
+		grep " | " output >actual &&
+		test_cmp expect actual
+	'
+
+	test_expect_success "$cmd --stat-width=3Dwidth with big change" '
+		git $cmd $args --stat-width=3D40 >output
+		grep " | " output >actual &&
+		test_cmp expect actual
+	'
+done <<\EOF
+format-patch -1 --stdout
+diff HEAD^ HEAD --stat
+show --stat
+log -1 --stat
+EOF
+
+test_expect_success 'preparation for long filename tests' '
+	cp abcd aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa &&
+	git add aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa &&
+	git commit -m message
+'
+
+cat >expect <<'EOF'
+ ...aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa | 1000 +++++
+EOF
+while read cmd args
+do
+	test_expect_success "$cmd --stat=3Dwidth with big change and long nam=
e favors name part" '
+		git $cmd $args --stat-width=3D60 >output &&
+		grep " | " output >actual &&
+		test_cmp expect actual
+	'
+done <<\EOF
+format-patch -1 --stdout
+diff HEAD^ HEAD --stat
+show --stat
+log -1 --stat
+EOF
+
+cat >expect80 <<'EOF'
+ ...aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa | 1000 +++++++++++=
+++++++++
+EOF
+while read verb expect cmd args
+do
+	test_expect_success "$cmd $verb COLUMNS (long filename)" '
+		COLUMNS=3D200 git $cmd $args >output
+		grep " | " output >actual &&
+		test_cmp "$expect" actual
+	'
+done <<\EOF
+ignores expect80 format-patch -1 --stdout
+ignores expect80 diff HEAD^ HEAD --stat
+ignores expect80 show --stat
+ignores expect80 log -1 --stat
+EOF
+
+cat >expect <<'EOF'
+ abcd | 1000 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
+++++++++
+EOF
+test_expect_success 'merge --stat ignores COLUMNS (big change)' '
+	git checkout -b branch HEAD^^ &&
+	COLUMNS=3D100 git merge --stat --no-ff master^ >output &&
+	grep " | " output >actual
+	test_cmp expect actual
+'
+
+cat >expect <<'EOF'
+ ...aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa | 1000 +++++++++++=
+++++++++
+EOF
+test_expect_success 'merge --stat ignores COLUMNS (long filename)' '
+	COLUMNS=3D100 git merge --stat --no-ff master >output &&
+	grep " | " output >actual
+	test_cmp expect actual
+'
+
+test_done
--=20
1.7.9.2.399.gdf4d.dirty
