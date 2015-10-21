From: Max Kirillov <max@max630.net>
Subject: [PATCH 1/2] Add test to describe expectation of blame --reverse with branched history
Date: Wed, 21 Oct 2015 07:08:01 +0300
Message-ID: <1445400482-1977-2-git-send-email-max@max630.net>
References: <1445400482-1977-1-git-send-email-max@max630.net>
Cc: Max Kirillov <max@max630.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Oct 21 06:16:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zokoh-0005tw-Cl
	for gcvg-git-2@plane.gmane.org; Wed, 21 Oct 2015 06:15:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750843AbbJUEPb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Oct 2015 00:15:31 -0400
Received: from p3plsmtpa11-01.prod.phx3.secureserver.net ([68.178.252.102]:60924
	"EHLO p3plsmtpa11-01.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750758AbbJUEPY (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 21 Oct 2015 00:15:24 -0400
X-Greylist: delayed 428 seconds by postgrey-1.27 at vger.kernel.org; Wed, 21 Oct 2015 00:15:23 EDT
Received: from wheezy.local ([82.181.81.240])
	by p3plsmtpa11-01.prod.phx3.secureserver.net with 
	id Xg861r0045B68XE01g8EiE; Tue, 20 Oct 2015 21:08:15 -0700
X-Mailer: git-send-email 2.3.4.2801.g3d0809b
In-Reply-To: <1445400482-1977-1-git-send-email-max@max630.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279963>

If history contains merges from feature branches, `blame --reverse`
reports not the commit when the line was actually edited, but head of
the last merged branch which was created before the edit.

As a workaround, `blame --reverse --first-parent` could be used to find
the merge of branch containing the edit, but it was disabled in
95a4fb0eac, because incorrectly specified range could produce in
unexpected and meaningless result.

Add tests which describe ideal functionality with and without
`--first-parent`.

Signed-off-by: Max Kirillov <max@max630.net>
---
 t/t8009-blame-reverse.sh | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)
 create mode 100755 t/t8009-blame-reverse.sh

diff --git a/t/t8009-blame-reverse.sh b/t/t8009-blame-reverse.sh
new file mode 100755
index 0000000..9f40613
--- /dev/null
+++ b/t/t8009-blame-reverse.sh
@@ -0,0 +1,34 @@
+#!/bin/sh
+
+test_description='git blame reverse'
+. ./test-lib.sh
+
+test_expect_success setup '
+	test_commit A0 file.t line0 &&
+	test_commit A1 &&
+	git reset --hard A0 &&
+	test_commit B1 &&
+	test_commit B2 file.t line0changed &&
+	git reset --hard A1 &&
+	test_merge A2 B2 &&
+	git reset --hard A1 &&
+	test_commit C1 &&
+	git reset --hard A2 &&
+	test_merge A3 C1
+	'
+
+test_expect_failure 'blame --reverse finds B1, not C1' '
+	git blame --porcelain --reverse A0..A3 -- file.t >actual_full &&
+	head -1 <actual_full | sed -e "sX .*XX" >actual &&
+	git rev-parse B1 >expect &&
+	test_cmp expect actual
+	'
+
+test_expect_failure 'blame --reverse --first-parent finds A1' '
+	git blame --porcelain --reverse --first-parent A0..A3 -- file.t >actual_full &&
+	head -1 <actual_full | sed -e "sX .*XX" >actual &&
+	git rev-parse A1 >expect &&
+	test_cmp expect actual
+	'
+
+test_done
-- 
2.3.4.2801.g3d0809b
