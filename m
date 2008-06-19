From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH 11/11] Add new test to ensure git-merge handles more than 25 refs.
Date: Fri, 20 Jun 2008 01:22:36 +0200
Message-ID: <ac678179d9dcee24fbf5606f8650f2dd21549e40.1213917600.git.vmiklos@frugalware.org>
References: <cover.1213917600.git.vmiklos@frugalware.org>
 <b9fc7f1cc6c36ba197ed2c0394a6b89ed33c4b96.1213917600.git.vmiklos@frugalware.org>
 <45f73cd0355a5375dcd8a123dd0facf5cad99061.1213917600.git.vmiklos@frugalware.org>
 <f41fbf4630e6341ae89eacad52c465cecc605e42.1213917600.git.vmiklos@frugalware.org>
 <702cfa09fdf6203e1199415af21de787c4a19ead.1213917600.git.vmiklos@frugalware.org>
 <adba33a239d99b30fcccedc0638b060daec1016e.1213917600.git.vmiklos@frugalware.org>
 <6323597c45d409498ce231b063737bb36c52ef9f.1213917600.git.vmiklos@frugalware.org>
 <172740d7c998269dd0c454a1365a429acdf7cae2.1213917600.git.vmiklos@frugalware.org>
 <c83288c0995a7b4463b66e2f45d1a14839f0901c.1213917600.git.vmiklos@frugalware.org>
 <0d95a099ad6e47c60894983ab7bfd94a3aeddce7.1213917600.git.vmiklos@frugalware.org>
 <a750360c92c30e05c686c454c0e5df2223b08f99.1213917600.git.vmiklos@frugalware.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 20 01:24:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K9TUT-0006Vg-BN
	for gcvg-git-2@gmane.org; Fri, 20 Jun 2008 01:24:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754031AbYFSXW6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Jun 2008 19:22:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753702AbYFSXW4
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jun 2008 19:22:56 -0400
Received: from yugo.dsd.sztaki.hu ([195.111.2.114]:46952 "EHLO
	yugo.frugalware.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753624AbYFSXWp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jun 2008 19:22:45 -0400
Received: from vmobile.example.net (catv-5062e651.catv.broadband.hu [80.98.230.81])
	by yugo.frugalware.org (Postfix) with ESMTP id 0845B1DDC5B
	for <git@vger.kernel.org>; Fri, 20 Jun 2008 01:22:44 +0200 (CEST)
Received: by vmobile.example.net (Postfix, from userid 1003)
	id CCC1C18E0F0; Fri, 20 Jun 2008 01:22:36 +0200 (CEST)
X-Mailer: git-send-email 1.5.6
In-Reply-To: <a750360c92c30e05c686c454c0e5df2223b08f99.1213917600.git.vmiklos@frugalware.org>
In-Reply-To: <cover.1213917600.git.vmiklos@frugalware.org>
References: <cover.1213917600.git.vmiklos@frugalware.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85568>

The old shell version handled only 25 refs but we no longer have this
limitation. Add a test to make sure this limitation will not be
introduced again in the future.

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---
 t/t7602-merge-octopus-many.sh |   52 +++++++++++++++++++++++++++++++++++++++++
 1 files changed, 52 insertions(+), 0 deletions(-)
 create mode 100755 t/t7602-merge-octopus-many.sh

diff --git a/t/t7602-merge-octopus-many.sh b/t/t7602-merge-octopus-many.sh
new file mode 100755
index 0000000..fcb8285
--- /dev/null
+++ b/t/t7602-merge-octopus-many.sh
@@ -0,0 +1,52 @@
+#!/bin/sh
+
+test_description='git-merge
+
+Testing octopus merge with more than 25 refs.'
+
+. ./test-lib.sh
+
+test_expect_success 'setup' '
+	echo c0 > c0.c &&
+	git add c0.c &&
+	git commit -m c0 &&
+	git tag c0 &&
+	i=1 &&
+	while test $i -le 30
+	do
+		git reset --hard c0 &&
+		echo c$i > c$i.c &&
+		git add c$i.c &&
+		git commit -m c$i &&
+		git tag c$i &&
+		i=`expr $i + 1` || return 1
+	done
+'
+
+test_expect_success 'merge c1 with c2, c3, c4, ... c29' '
+	git reset --hard c1 &&
+	i=2 &&
+	refs="" &&
+	while test $i -le 30
+	do
+		refs="$refs c$i"
+		i=`expr $i + 1`
+	done
+	git merge $refs &&
+	test "$(git rev-parse c1)" != "$(git rev-parse HEAD)" &&
+	i=1 &&
+	while test $i -le 30
+	do
+		test "$(git rev-parse c$i)" = "$(git rev-parse HEAD^$i)" &&
+		i=`expr $i + 1` || return 1
+	done &&
+	git diff --exit-code &&
+	i=1 &&
+	while test $i -le 30
+	do
+		test -f c$i.c &&
+		i=`expr $i + 1` || return 1
+	done
+'
+
+test_done
-- 
1.5.6
