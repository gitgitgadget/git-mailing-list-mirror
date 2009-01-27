From: Junio C Hamano <gitster@pobox.com>
Subject: [Bug] rebase -i squashes submodule changes into unrelated commit
Date: Tue, 27 Jan 2009 01:07:31 -0800
Message-ID: <7vljsxyv58.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 27 10:09:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRjwM-0004tv-Ky
	for gcvg-git-2@gmane.org; Tue, 27 Jan 2009 10:09:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751703AbZA0JHj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Jan 2009 04:07:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751443AbZA0JHi
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Jan 2009 04:07:38 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:38325 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751423AbZA0JHh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Jan 2009 04:07:37 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 809211D622;
	Tue, 27 Jan 2009 04:07:36 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 9B6741D591; Tue,
 27 Jan 2009 04:07:33 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: F0A9562E-EC51-11DD-B200-0372113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107322>

Attempting to rebase three-commit series (two regular changes, followed by
one commit that changes what commit is bound for a submodule path) to
squash the first two results in a failure; not just the first two commits
squashed, but the change to the submodule is also included in the result.

This failure causes the subsequent step to "pick" the change that actually
changes the submodule to be applied, because there is no change left to be
applied.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t3404-rebase-interactive.sh |   26 ++++++++++++++++++++++++++
 1 files changed, 26 insertions(+), 0 deletions(-)

diff --git c/t/t3404-rebase-interactive.sh w/t/t3404-rebase-interactive.sh
index 2cc8e7a..6ffb9ad 100755
--- c/t/t3404-rebase-interactive.sh
+++ w/t/t3404-rebase-interactive.sh
@@ -462,4 +462,30 @@ test_expect_success 'do "noop" when there is nothing to cherry-pick' '
 
 '
 
+test_expect_success 'submodule rebase setup' '
+	git checkout A &&
+	mkdir sub &&
+	(
+		cd sub && git init && >elif &&
+		git add elif && git commit -m "submodule initial"
+	) &&
+	echo 1 >file1 &&
+	git add file1 sub
+	test_tick &&
+	git commit -m "One" &&
+	echo 2 >file1 &&
+	test_tick &&
+	git commit -a -m "Two" &&
+	(
+		cd sub && echo 3 >elif &&
+		git commit -a -m "submodule second"
+	) &&
+	test_tick &&
+	git commit -a -m "Three changes submodule"
+'
+
+test_expect_failure 'submodule rebase -i' '
+	FAKE_LINES="1 squash 2 3" git rebase -i A
+'
+
 test_done
