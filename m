From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH 09/13] Add new test to ensure git-merge handles more than 25 refs.
Date: Sat, 21 Jun 2008 19:00:46 +0200
Message-ID: <0b7ea424b3d5ea18a5a8660c6aead51adcc6a40f.1214066799.git.vmiklos@frugalware.org>
References: <cover.1214066798.git.vmiklos@frugalware.org>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jun 21 19:02:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KA6TP-0000Zo-Ot
	for gcvg-git-2@gmane.org; Sat, 21 Jun 2008 19:02:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751617AbYFURAx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Jun 2008 13:00:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751037AbYFURAw
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Jun 2008 13:00:52 -0400
Received: from yugo.dsd.sztaki.hu ([195.111.2.114]:33721 "EHLO
	yugo.frugalware.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751365AbYFURAw (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Jun 2008 13:00:52 -0400
Received: from vmobile.example.net (dsl5402CEE1.pool.t-online.hu [84.2.206.225])
	by yugo.frugalware.org (Postfix) with ESMTP id 8BFC91DDC5D;
	Sat, 21 Jun 2008 19:00:49 +0200 (CEST)
Received: by vmobile.example.net (Postfix, from userid 1003)
	id F0DE918E0E4; Sat, 21 Jun 2008 19:00:50 +0200 (CEST)
X-Mailer: git-send-email 1.5.6
In-Reply-To: <cover.1214066798.git.vmiklos@frugalware.org>
In-Reply-To: <cover.1214066798.git.vmiklos@frugalware.org>
References: <cover.1214066798.git.vmiklos@frugalware.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85716>

The old shell version handled only 25 refs but we no longer have this
limitation. Add a test to make sure this limitation will not be
introduced again in the future.

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
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
