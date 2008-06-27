From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH 08/15] Add new test to ensure git-merge handles more than 25 refs.
Date: Fri, 27 Jun 2008 18:22:01 +0200
Message-ID: <d600b25cb1d8f3b6bce12b2a479d4b68b1935dfd.1214581610.git.vmiklos@frugalware.org>
References: <cover.1214581610.git.vmiklos@frugalware.org>
 <58b2c36de6a6f51a562da303695482bea567f4bf.1214581610.git.vmiklos@frugalware.org>
 <4a9a3a34d8c42b60f002acb20083cb9e187c262f.1214581610.git.vmiklos@frugalware.org>
 <876e733753999f116bfd975d9a262a5c1b3855a1.1214581610.git.vmiklos@frugalware.org>
 <99b931de28ab3017269d15c334c83e242d025489.1214581610.git.vmiklos@frugalware.org>
 <5c33ca94d6edb203bd2fbbb949f834b3771470ed.1214581610.git.vmiklos@frugalware.org>
 <25a8ffde9783638080d2b998d8f2579e6ed6c8e7.1214581610.git.vmiklos@frugalware.org>
 <715117f89992568500bd26b1a4e1357c0a570c4a.1214581610.git.vmiklos@frugalware.org>
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Olivier Marin <dkr@freesurf.fr>,
	Junio C Hamano <gitster@pobox.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 27 18:24:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KCGk8-0004E3-GL
	for gcvg-git-2@gmane.org; Fri, 27 Jun 2008 18:24:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758258AbYF0QWo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Jun 2008 12:22:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757856AbYF0QWl
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Jun 2008 12:22:41 -0400
Received: from yugo.dsd.sztaki.hu ([195.111.2.114]:45345 "EHLO
	yugo.frugalware.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760571AbYF0QWM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jun 2008 12:22:12 -0400
Received: from vmobile.example.net (dsl5401C209.pool.t-online.hu [84.1.194.9])
	by yugo.frugalware.org (Postfix) with ESMTP id 5B54C1DDC66;
	Fri, 27 Jun 2008 18:22:07 +0200 (CEST)
Received: by vmobile.example.net (Postfix, from userid 1003)
	id 5422018E82F; Fri, 27 Jun 2008 18:22:09 +0200 (CEST)
X-Mailer: git-send-email 1.5.6
In-Reply-To: <715117f89992568500bd26b1a4e1357c0a570c4a.1214581610.git.vmiklos@frugalware.org>
In-Reply-To: <cover.1214581610.git.vmiklos@frugalware.org>
References: <cover.1214581610.git.vmiklos@frugalware.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86579>

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
index 0000000..f3a4bb2
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
+test_expect_failure 'merge c1 with c2, c3, c4, ... c29' '
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
