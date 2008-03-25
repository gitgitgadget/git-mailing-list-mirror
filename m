From: Junio C Hamano <junio@pobox.com>
Subject: [PATCH 3/5] Add tests for git-prune
Date: Mon, 24 Mar 2008 23:59:31 -0700
Message-ID: <7v63vbnvak.fsf@gitster.siamese.dyndns.org>
References: <200803232150.29971.barra_cuda@katamail.com>
 <200803241502.21465.barra_cuda@katamail.com>
 <7vwsnrubmd.fsf@gitster.siamese.dyndns.org>
 <200803242218.44026.barra_cuda@katamail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Michele Ballabio <barra_cuda@katamail.com>
X-From: git-owner@vger.kernel.org Tue Mar 25 08:00:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Je393-0002vo-Pq
	for gcvg-git-2@gmane.org; Tue, 25 Mar 2008 08:00:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752764AbYCYG7p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Mar 2008 02:59:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752717AbYCYG7p
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Mar 2008 02:59:45 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:57900 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751224AbYCYG7o (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Mar 2008 02:59:44 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id E71A92F88;
	Tue, 25 Mar 2008 02:59:42 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 0E6F22F86; Tue, 25 Mar 2008 02:59:38 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78156>

From: Michele Ballabio <barra_cuda@katamail.com>
Date: Sun, 23 Mar 2008 22:34:34 +0100

It seems that git prune changed behaviour with respect to revisions added
from command line, probably when it became a builtin. Currently, it prints
a short usage and exits: instead, it should take those revisions into
account and not prune them. So add a couple of test to point this out.

We'll be fixing this by switching to parse_options(), so add tests to
detect bogus command line parameters as well, to keep ourselves from
introducing regressions.

Signed-off-by: Michele Ballabio <barra_cuda@katamail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t5304-prune.sh |   34 ++++++++++++++++++++++++++++++++++
 1 files changed, 34 insertions(+), 0 deletions(-)

diff --git a/t/t5304-prune.sh b/t/t5304-prune.sh
index 47090c4..3d81e1f 100644
--- a/t/t5304-prune.sh
+++ b/t/t5304-prune.sh
@@ -78,4 +78,38 @@ test_expect_success 'gc: start with ok gc.pruneExpire' '
 
 '
 
+test_expect_success 'prune: prune nonsense parameters' '
+
+	test_must_fail git prune garbage &&
+	test_must_fail git prune --- &&
+	test_must_fail git prune --no-such-option
+
+'
+
+test_expect_success 'prune: prune unreachable heads' '
+
+	git config core.logAllRefUpdates false &&
+	mv .git/logs .git/logs.old &&
+	: > file2 &&
+	git add file2 &&
+	git commit -m temporary &&
+	tmp_head=$(git rev-list -1 HEAD) &&
+	git reset HEAD^ &&
+	git prune &&
+	test_must_fail git reset $tmp_head --
+
+'
+
+test_expect_failure 'prune: do not prune heads listed as an argument' '
+
+	: > file2 &&
+	git add file2 &&
+	git commit -m temporary &&
+	tmp_head=$(git rev-list -1 HEAD) &&
+	git reset HEAD^ &&
+	git prune -- $tmp_head &&
+	git reset $tmp_head --
+
+'
+
 test_done
-- 
1.5.5.rc1.121.g1594
