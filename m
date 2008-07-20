From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 3/4] git-add --all: tests
Date: Sat, 19 Jul 2008 23:09:03 -0700
Message-ID: <1216534144-23826-3-git-send-email-gitster@pobox.com>
References: <1216534144-23826-1-git-send-email-gitster@pobox.com>
 <1216534144-23826-2-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 20 08:10:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KKS7o-0004W9-Re
	for gcvg-git-2@gmane.org; Sun, 20 Jul 2008 08:10:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751536AbYGTGJR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Jul 2008 02:09:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751951AbYGTGJQ
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Jul 2008 02:09:16 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:33726 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751728AbYGTGJO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Jul 2008 02:09:14 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id DAD643CC3E
	for <git@vger.kernel.org>; Sun, 20 Jul 2008 02:09:13 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 004DF3CC3D for <git@vger.kernel.org>; Sun, 20 Jul 2008 02:09:12
 -0400 (EDT)
X-Mailer: git-send-email 1.5.6.4.570.g052e6
In-Reply-To: <1216534144-23826-2-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 607D8C98-5622-11DD-A869-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89161>

And here is a small test script that makes sure that:

 - both modified and new files are included,
 - removed file is noticed, and
 - no ignored file is included.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * This option has to be a superset of -u, so it must also notice removed
   files.  v2 adds that to the test.

 t/t2202-add-addremove.sh |   44 ++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 44 insertions(+), 0 deletions(-)
 create mode 100755 t/t2202-add-addremove.sh

diff --git a/t/t2202-add-addremove.sh b/t/t2202-add-addremove.sh
new file mode 100755
index 0000000..6a81510
--- /dev/null
+++ b/t/t2202-add-addremove.sh
@@ -0,0 +1,44 @@
+#!/bin/sh
+
+test_description='git add --all'
+
+. ./test-lib.sh
+
+test_expect_success setup '
+	(
+		echo .gitignore
+		echo will-remove
+	) >expect &&
+	(
+		echo actual
+		echo expect
+		echo ignored
+	) >.gitignore &&
+	>will-remove &&
+	git add --all &&
+	test_tick &&
+	git commit -m initial &&
+	git ls-files >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'git add --all' '
+	(
+		echo .gitignore
+		echo not-ignored
+		echo "M	.gitignore"
+		echo "A	not-ignored"
+		echo "D	will-remove"
+	) >expect &&
+	>ignored &&
+	>not-ignored &&
+	echo modification >>.gitignore &&
+	rm -f will-remove &&
+	git add --all &&
+	git update-index --refresh &&
+	git ls-files >actual &&
+	git diff-index --name-status --cached HEAD >>actual &&
+	test_cmp expect actual
+'
+
+test_done
-- 
1.5.6.4.570.g052e6
