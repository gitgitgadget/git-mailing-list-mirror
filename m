From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] Fix "quote" misconversion for rewrite diff output.
Date: Thu, 22 Nov 2007 00:36:38 -0800
Message-ID: <7v4pfe8ynd.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 22 09:37:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iv7YW-0008Vt-5H
	for gcvg-git-2@gmane.org; Thu, 22 Nov 2007 09:37:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751244AbXKVIgq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Nov 2007 03:36:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751214AbXKVIgq
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Nov 2007 03:36:46 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:45707 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750696AbXKVIgp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Nov 2007 03:36:45 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 1310E2EF;
	Thu, 22 Nov 2007 03:37:04 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 5E485976A4;
	Thu, 22 Nov 2007 03:37:02 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65755>

663af3422a648e87945e4d8c0cc3e13671f2bbde (Full rework of
quote_c_style and write_name_quoted.) mistakenly used puts()
when writing out a fixed string when it did not want to add a
terminating LF.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 diff.c                  |    2 +-
 t/t4022-diff-rewrite.sh |   26 ++++++++++++++++++++++++++
 2 files changed, 27 insertions(+), 1 deletions(-)
 create mode 100755 t/t4022-diff-rewrite.sh

diff --git a/diff.c b/diff.c
index b08d28a..6b54959 100644
--- a/diff.c
+++ b/diff.c
@@ -2716,7 +2716,7 @@ static void diff_summary(struct diff_filepair *p)
 		break;
 	default:
 		if (p->score) {
-			puts(" rewrite ");
+			fputs(" rewrite ", stdout);
 			write_name_quoted(p->two->path, stdout, ' ');
 			printf("(%d%%)\n", similarity_index(p));
 		}
diff --git a/t/t4022-diff-rewrite.sh b/t/t4022-diff-rewrite.sh
new file mode 100755
index 0000000..6de4acb
--- /dev/null
+++ b/t/t4022-diff-rewrite.sh
@@ -0,0 +1,26 @@
+#!/bin/sh
+
+test_description='rewrite diff'
+
+. ./test-lib.sh
+
+test_expect_success setup '
+
+	cat ../../COPYING >test &&
+	git add test &&
+	tr 'a-zA-Z' 'n-za-mN-ZA-M' <../../COPYING >test
+
+'
+
+test_expect_success 'detect rewrite' '
+
+	actual=$(git diff-files -B --summary test) &&
+	expr "$actual" : " rewrite test ([0-9]*%)$" || {
+		echo "Eh? <<$actual>>"
+		false
+	}
+
+'
+
+test_done
+
-- 
1.5.3.6.1929.g388a
