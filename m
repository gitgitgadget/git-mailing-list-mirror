From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 5/6] t1010: add mktree test
Date: Sun, 10 May 2009 11:49:50 -0700
Message-ID: <1241981391-19639-6-git-send-email-gitster@pobox.com>
References: <1241981391-19639-1-git-send-email-gitster@pobox.com>
 <1241981391-19639-2-git-send-email-gitster@pobox.com>
 <1241981391-19639-3-git-send-email-gitster@pobox.com>
 <1241981391-19639-4-git-send-email-gitster@pobox.com>
 <1241981391-19639-5-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 10 20:50:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M3E6R-0004rg-Bv
	for gcvg-git-2@gmane.org; Sun, 10 May 2009 20:50:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756239AbZEJSuM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 May 2009 14:50:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756175AbZEJSuK
	(ORCPT <rfc822;git-outgoing>); Sun, 10 May 2009 14:50:10 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:53288 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754978AbZEJSuD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 May 2009 14:50:03 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id D9A3216173
	for <git@vger.kernel.org>; Sun, 10 May 2009 14:50:03 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 5DFC016172 for
 <git@vger.kernel.org>; Sun, 10 May 2009 14:50:03 -0400 (EDT)
X-Mailer: git-send-email 1.6.3.9.g6345d
In-Reply-To: <1241981391-19639-5-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 5F7711F8-3D93-11DE-97C7-D766E3C8547C-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

So far mktree (which has always been a quick hack) had no test.
At least give it a bit of test coverage.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t1010-mktree.sh |   61 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 61 insertions(+), 0 deletions(-)
 create mode 100755 t/t1010-mktree.sh

diff --git a/t/t1010-mktree.sh b/t/t1010-mktree.sh
new file mode 100755
index 0000000..4d9b138
--- /dev/null
+++ b/t/t1010-mktree.sh
@@ -0,0 +1,61 @@
+#!/bin/sh
+
+test_description='git mktree'
+
+. ./test-lib.sh
+
+test_expect_success setup '
+	for d in a a. a0
+	do
+		mkdir "$d" && echo "$d/one" >"$d/one" &&
+		git add "$d"
+	done &&
+	echo one >one &&
+	git add one &&
+	git write-tree >tree &&
+	git ls-tree $(cat tree) >top &&
+	git ls-tree -r $(cat tree) >all &&
+	test_tick &&
+	git commit -q -m one &&
+	H=$(git rev-parse HEAD) &&
+	git update-index --add --cacheinfo 160000 $H sub &&
+	test_tick &&
+	git commit -q -m two &&
+	git rev-parse HEAD^{tree} >tree.withsub &&
+	git ls-tree HEAD >top.withsub &&
+	git ls-tree -r HEAD >all.withsub
+'
+
+test_expect_success 'ls-tree piped to mktree (1)' '
+	git mktree <top >actual &&
+	test_cmp tree actual
+'
+
+test_expect_success 'ls-tree piped to mktree (2)' '
+	git mktree <top.withsub >actual &&
+	test_cmp tree.withsub actual
+'
+
+test_expect_success 'ls-tree output in wrong order given to mktree (1)' '
+	perl -e "print reverse <>" <top |
+	git mktree >actual &&
+	test_cmp tree actual
+'
+
+test_expect_success 'ls-tree output in wrong order given to mktree (2)' '
+	perl -e "print reverse <>" <top.withsub |
+	git mktree >actual &&
+	test_cmp tree.withsub actual
+'
+
+test_expect_failure 'mktree reads ls-tree -r output (1)' '
+	git mktree <all >actual &&
+	test_cmp tree actual
+'
+
+test_expect_failure 'mktree reads ls-tree -r output (2)' '
+	git mktree <all.withsub >actual &&
+	test_cmp tree.withsub actual
+'
+
+test_done
-- 
1.6.3.9.g6345d
