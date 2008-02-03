From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFH] revision limiting sometimes ignored
Date: Sat, 02 Feb 2008 23:47:22 -0800
Message-ID: <7v4pcqzdkl.fsf@gitster.siamese.dyndns.org>
References: <20080202122135.GA5783@code-monkey.de>
	<20080203030054.GA18654@coredump.intra.peff.net>
	<20080203043310.GA5984@coredump.intra.peff.net>
	<7vr6fuzgq1.fsf@gitster.siamese.dyndns.org>
	<20080203071318.GA13849@coredump.intra.peff.net>
	<20080203071833.GA16273@coredump.intra.peff.net>
	<7vbq6yzdvr.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Feb 03 08:48:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JLZaA-0002ZQ-6a
	for gcvg-git-2@gmane.org; Sun, 03 Feb 2008 08:48:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759292AbYBCHrf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Feb 2008 02:47:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759283AbYBCHrf
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Feb 2008 02:47:35 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:64957 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758880AbYBCHre (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Feb 2008 02:47:34 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id F0A9A4DD2;
	Sun,  3 Feb 2008 02:47:32 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 510F84DD0;
	Sun,  3 Feb 2008 02:47:29 -0500 (EST)
In-Reply-To: <7vbq6yzdvr.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
	message of "Sat, 02 Feb 2008 23:40:40 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72336>

By the way, the issue does not have anything to do with merges.

This is the absolute minimum (and reliable) reproduction recipe.
You need four commits.  If you remove "commit three &&", the
traversal will contaminate "one".

---

 t/t6009-rev-list-parent.sh |   38 ++++++++++++++++++++++++++++++++++++++
 1 files changed, 38 insertions(+), 0 deletions(-)

diff --git a/t/t6009-rev-list-parent.sh b/t/t6009-rev-list-parent.sh
new file mode 100755
index 0000000..1da5dbb
--- /dev/null
+++ b/t/t6009-rev-list-parent.sh
@@ -0,0 +1,38 @@
+#!/bin/sh
+
+test_description='properly cull all ancestors'
+
+. ./test-lib.sh
+
+commit () {
+	test_tick &&
+	echo $1 >file &&
+	git commit -a -m $1 &&
+	git tag $1
+}
+
+test_expect_success setup '
+
+	touch file &&
+	git add file &&
+
+	commit one &&
+
+	test_tick=$(($test_tick - 2400))
+
+	commit two &&
+	commit three &&
+	commit four &&
+
+	git log --pretty=oneline --abbrev-commit
+'
+
+test_expect_failure 'one is ancestor of others and should not be shown' '
+
+	git rev-list one --not four >result &&
+	>expect &&
+	diff -u expect result 
+
+'
+
+test_done
