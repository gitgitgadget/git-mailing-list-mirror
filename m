From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v4 5/5] test "commit -S" and "log --show-signature"
Date: Wed, 19 Oct 2011 17:37:03 -0700
Message-ID: <1319071023-31919-6-git-send-email-gitster@pobox.com>
References: <1318983645-18897-1-git-send-email-gitster@pobox.com>
 <1319071023-31919-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 20 02:37:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RGgdV-0007Z2-Fx
	for gcvg-git-2@lo.gmane.org; Thu, 20 Oct 2011 02:37:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755729Ab1JTAhU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Oct 2011 20:37:20 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33040 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755690Ab1JTAhQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Oct 2011 20:37:16 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8459069D7
	for <git@vger.kernel.org>; Wed, 19 Oct 2011 20:37:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=X8rJ
	J+B1IkI7YhxPkIOQyOgAL48=; b=bYvB3YlLk8SNr7nb5Dz44psp3aujBdYQn6RZ
	kOLOCzNZpJubfzf/jD7u8amGqfcWcyZKd9Zw4PvY0mITO62zwtePSjiBO8kkj4Vj
	v6B+XlCUoNL5UckP6ZswrxGHeW9sZcZHy9J4XaYG4cH+8DeE+U8dLW9qm9zEzK2Y
	YDR0Gdk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=DG5681
	gBPvHyAfa1Go+CBOODgsupNoa+3F83v48kJXQW9MLZxV4urh5EbF6K4hiwebbLCz
	hqXnUjSzz+7dtsSlFup31fVUC6MFcg41N9oA6qwTuxRo4rt8DhRL3rpt51BVCiVd
	U2nHsu4dQQztOrque5N3QYGds/wrY8htNw6dU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7BB9369D6
	for <git@vger.kernel.org>; Wed, 19 Oct 2011 20:37:15 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EAE6169D5 for
 <git@vger.kernel.org>; Wed, 19 Oct 2011 20:37:14 -0400 (EDT)
X-Mailer: git-send-email 1.7.7.498.g3f2e50
In-Reply-To: <1319071023-31919-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: A83C17FA-FAB3-11E0-BD78-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183992>

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t7510-signed-commit.sh |   60 ++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 60 insertions(+), 0 deletions(-)
 create mode 100755 t/t7510-signed-commit.sh

diff --git a/t/t7510-signed-commit.sh b/t/t7510-signed-commit.sh
new file mode 100755
index 0000000..5c7475d
--- /dev/null
+++ b/t/t7510-signed-commit.sh
@@ -0,0 +1,60 @@
+#!/bin/sh
+
+test_description='signed commit tests'
+. ./test-lib.sh
+. "$TEST_DIRECTORY/lib-gpg.sh"
+
+test_expect_success GPG 'create signed commits' '
+	echo 1 >file && git add file &&
+	test_tick && git commit -S -m initial &&
+	git tag initial &&
+	git branch side &&
+
+	echo 2 >file && test_tick && git commit -a -S -m second &&
+	git tag second &&
+
+	git checkout side &&
+	echo 3 >elif && git add elif &&
+	test_tick && git commit -m "third on side" &&
+
+	git checkout master &&
+	test_tick && git merge -S side &&
+	git tag merge &&
+
+	echo 4 >file && test_tick && git commit -a -m "fourth unsigned" &&
+	git tag fourth-unsigned &&
+
+	test_tick && git commit --amend -S -m "fourth signed"
+'
+
+test_expect_success GPG 'show signatures' '
+	(
+		for commit in initial second merge master
+		do
+			git show --pretty=short --show-signature $commit >actual &&
+			grep "Good signature from" actual || exit 1
+			! grep "BAD signature from" actual || exit 1
+			echo $commit OK
+		done
+	) &&
+	(
+		for commit in merge^2 fourth-unsigned
+		do
+			git show --pretty=short --show-signature $commit >actual &&
+			grep "Good signature from" actual && exit 1
+			! grep "BAD signature from" actual || exit 1
+			echo $commit OK
+		done
+	)
+'
+
+test_expect_success GPG 'detect fudged signature' '
+	git cat-file commit master >raw &&
+	sed -e "s/fourth signed/4th forged/" raw >forged &&
+	git hash-object -w -t commit forged >forged.commit &&
+	git show --pretty=short --show-signature $(cat forged.commit) >actual &&
+	grep "BAD signature from" actual &&
+	! grep "Good signature from" actual
+'
+
+test_done
-- 
1.7.7.498.g3f2e50
