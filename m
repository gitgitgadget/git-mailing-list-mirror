From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] refresh-index: fix bitmask assignment
Date: Sun, 20 Jul 2008 00:03:30 -0700
Message-ID: <7vk5fhf35p.fsf@gitster.siamese.dyndns.org>
References: <7vtzelf4mf.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 20 09:06:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KKSzk-0006KX-Iy
	for gcvg-git-2@gmane.org; Sun, 20 Jul 2008 09:06:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752084AbYGTHDh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Jul 2008 03:03:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752079AbYGTHDh
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Jul 2008 03:03:37 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:41760 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751767AbYGTHDh (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Jul 2008 03:03:37 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id B13C13CF17;
	Sun, 20 Jul 2008 03:03:34 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id E365D3CF16; Sun, 20 Jul 2008 03:03:32 -0400 (EDT)
In-Reply-To: <7vtzelf4mf.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Sat, 19 Jul 2008 23:31:52 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: F81AC5FA-5629-11DD-A869-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89166>

This hopefully protects the previous fix (and other --refresh related
options) from future  breakages.

I'll squash it in to the previous one.
---
 t/t2103-update-index-ignore-missing.sh |   89 ++++++++++++++++++++++++++++++++
 1 files changed, 89 insertions(+), 0 deletions(-)
 create mode 100755 t/t2103-update-index-ignore-missing.sh

diff --git a/t/t2103-update-index-ignore-missing.sh b/t/t2103-update-index-ignore-missing.sh
new file mode 100755
index 0000000..332694e
--- /dev/null
+++ b/t/t2103-update-index-ignore-missing.sh
@@ -0,0 +1,89 @@
+#!/bin/sh
+
+test_description='update-index with options'
+
+. ./test-lib.sh
+
+test_expect_success basics '
+	>one &&
+	>two &&
+	>three &&
+
+	# need --add when adding
+	test_must_fail git update-index one &&
+	test -z "$(git ls-files)" &&
+	git update-index --add one &&
+	test zone = "z$(git ls-files)" &&
+
+	# update-index is atomic
+	echo 1 >one &&
+	test_must_fail git update-index one two &&
+	echo "M	one" >expect &&
+	git diff-files --name-status >actual &&
+	test_cmp expect actual &&
+
+	git update-index --add one two three &&
+	for i in one three two; do echo $i; done >expect &&
+	git ls-files >actual &&
+	test_cmp expect actual &&
+
+	test_tick &&
+	(
+		test_create_repo xyzzy &&
+		cd xyzzy &&
+		>file &&
+		git add file
+		git commit -m "sub initial"
+	) &&
+	git add xyzzy &&
+
+	test_tick &&
+	git commit -m initial &&
+	git tag initial
+'
+
+test_expect_success '--ignore-missing --refresh' '
+	git reset --hard initial &&
+	echo 2 >one &&
+	test_must_fail git update-index --refresh &&
+	echo 1 >one &&
+	git update-index --refresh &&
+	rm -f two &&
+	test_must_fail git update-index --refresh &&
+	git update-index --ignore-missing --refresh
+
+'
+
+test_expect_success '--unmerged --refresh' '
+	git reset --hard initial &&
+	info=$(git ls-files -s one | sed -e "s/ 0	/ 1	/") &&
+	git rm --cached one &&
+	echo "$info" | git update-index --index-info &&
+	test_must_fail git update-index --refresh &&
+	git update-index --unmerged --refresh &&
+	echo 2 >two &&
+	test_must_fail git update-index --unmerged --refresh >actual &&
+	grep two actual &&
+	! grep one actual &&
+	! grep three actual
+'
+
+test_expect_success '--ignore-submodules --refresh (1)' '
+	git reset --hard initial &&
+	rm -f two &&
+	test_must_fail git update-index --ignore-submodules --refresh
+'
+
+test_expect_success '--ignore-submodules --refresh (2)' '
+	git reset --hard initial &&
+	test_tick &&
+	(
+		cd xyzzy &&
+		git commit -m "sub second" --allow-empty
+	) &&
+	test_must_fail git update-index --refresh &&
+	test_must_fail git update-index --ignore-missing --refresh &&
+	git update-index --ignore-submodules --refresh
+'
+
+test_done
