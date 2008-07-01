From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH 08/14] Add new test to ensure git-merge handles more than 25 refs.
Date: Tue,  1 Jul 2008 04:37:48 +0200
Message-ID: <9201d4e13e574c10b1674cf1f6da23a44a73f8b2.1214879690.git.vmiklos@frugalware.org>
References: <cover.1214879690.git.vmiklos@frugalware.org>
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Olivier Marin <dkr@freesurf.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 01 04:38:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KDVlW-0004mN-Hm
	for gcvg-git-2@gmane.org; Tue, 01 Jul 2008 04:38:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754130AbYGAChu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jun 2008 22:37:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754177AbYGACht
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Jun 2008 22:37:49 -0400
Received: from yugo.dsd.sztaki.hu ([195.111.2.114]:44508 "EHLO
	yugo.frugalware.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753616AbYGAChs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jun 2008 22:37:48 -0400
Received: from vmobile.example.net (catv-5062e651.catv.broadband.hu [80.98.230.81])
	by yugo.frugalware.org (Postfix) with ESMTP id 317F81DDC5E;
	Tue,  1 Jul 2008 04:37:47 +0200 (CEST)
Received: by vmobile.example.net (Postfix, from userid 1003)
	id C43661A990A; Tue,  1 Jul 2008 04:37:50 +0200 (CEST)
X-Mailer: git-send-email 1.5.6.1
In-Reply-To: <cover.1214879690.git.vmiklos@frugalware.org>
In-Reply-To: <cover.1214879690.git.vmiklos@frugalware.org>
References: <cover.1214879690.git.vmiklos@frugalware.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86981>

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
1.5.6.1
