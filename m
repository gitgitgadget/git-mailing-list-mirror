From: Max Kirillov <max@max630.net>
Subject: [PATCH v4 1/3] Add test to describe expectation of blame --reverse with branched history
Date: Mon, 26 Oct 2015 07:26:55 +0200
Message-ID: <1445837217-4252-3-git-send-email-max@max630.net>
References: <1445837217-4252-1-git-send-email-max@max630.net>
Cc: Max Kirillov <max@max630.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Mon Oct 26 06:27:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZqaJT-0000pA-0g
	for gcvg-git-2@plane.gmane.org; Mon, 26 Oct 2015 06:27:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752179AbbJZF1M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Oct 2015 01:27:12 -0400
Received: from p3plsmtpa09-05.prod.phx3.secureserver.net ([173.201.193.234]:56576
	"EHLO p3plsmtpa09-05.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751254AbbJZF1J (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 26 Oct 2015 01:27:09 -0400
Received: from wheezy.local ([82.181.81.240])
	by p3plsmtpa09-05.prod.phx3.secureserver.net with 
	id ZhSy1r00P5B68XE01hT7vg; Sun, 25 Oct 2015 22:27:09 -0700
X-Mailer: git-send-email 2.3.4.2801.g3d0809b
In-Reply-To: <1445837217-4252-1-git-send-email-max@max630.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280175>

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
