From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] Add tests to catch problems with un-unlinkable symlinks
Date: Tue, 18 Mar 2008 21:59:39 -0700
Message-ID: <7v7ifz5mx0.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 19 20:45:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jc4C8-0002JK-Bl
	for gcvg-git-2@gmane.org; Wed, 19 Mar 2008 20:43:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756264AbYCSTkH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Mar 2008 15:40:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754878AbYCSTkG
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Mar 2008 15:40:06 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:49335 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757427AbYCSTkB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Mar 2008 15:40:01 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 848801A92;
	Wed, 19 Mar 2008 00:59:53 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id C045D1A91; Wed, 19 Mar 2008 00:59:50 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77524>

This currently fails not because we refuse to check out, but because we
detect error but incorrectly discard it in the callchain.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * The next one will fix it.

 t/t1004-read-tree-m-u-wf.sh |   35 +++++++++++++++++++++++++++++++++++
 1 files changed, 35 insertions(+), 0 deletions(-)

diff --git a/t/t1004-read-tree-m-u-wf.sh b/t/t1004-read-tree-m-u-wf.sh
index 283e77c..1356148 100755
--- a/t/t1004-read-tree-m-u-wf.sh
+++ b/t/t1004-read-tree-m-u-wf.sh
@@ -157,6 +157,41 @@ test_expect_success '3-way not overwriting local changes (their side)' '
 
 '
 
+test_expect_success 'funny symlink in work tree' '
+
+	git reset --hard &&
+	git checkout -b sym-b side-b &&
+	mkdir -p a &&
+	>a/b &&
+	git add a/b &&
+	git commit -m "side adds a/b" &&
+
+	rm -fr a &&
+	git checkout -b sym-a side-a &&
+	mkdir -p a &&
+	ln -s ../b a/b &&
+	git add a/b &&
+	git commit -m "we add a/b" &&
+
+	git read-tree -m -u sym-a sym-a sym-b
+
+'
+
+test_expect_failure 'funny symlink in work tree, un-unlink-able' '
+
+	rm -fr a b &&
+	git reset --hard &&
+
+	git checkout sym-a &&
+	chmod a-w a &&
+	test_must_fail git read-tree -m -u sym-a sym-a sym-b
+
+'
+
+# clean-up from the above test
+chmod a+w a
+rm -fr a b
+
 test_expect_success 'D/F setup' '
 
 	git reset --hard &&
-- 
1.5.5.rc0.122.g8e28f
