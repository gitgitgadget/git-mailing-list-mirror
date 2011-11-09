From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 16/17] test "commit -S" and "log --show-signature"
Date: Tue,  8 Nov 2011 17:02:02 -0800
Message-ID: <1320800523-5407-17-git-send-email-gitster@pobox.com>
References: <1320800523-5407-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 09 02:03:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RNwZ4-0003z8-5z
	for gcvg-git-2@lo.gmane.org; Wed, 09 Nov 2011 02:02:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755069Ab1KIBCo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Nov 2011 20:02:44 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36693 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752828Ab1KIBCl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Nov 2011 20:02:41 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 15C295BAD
	for <git@vger.kernel.org>; Tue,  8 Nov 2011 20:02:41 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=T6ac
	cylDfKQbErOl77QeKIEutJg=; b=tVimXkH2yRKRykMhr9UIXiw+pqFzOqKiTc4T
	BqMdmB3FLY1hVlhvElm6dJOy8yXJaqD1ldVzwHiYh7CMk6DOqOw7HFMFkhVmPQVV
	LHPj4UFjxQNie+mXcBirXZ3SzSVY3rfA2968CZEZQBIW40ES4QuJy19/IL42dXzK
	160MS6o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=qCq5+U
	CWaFWMzXMc8srNIi+gnR2oFAX7EIuo8e0oJq/EADQsKqD8DgEiGNDR37yUx/fn2y
	HQfMErqpd4BcHnaoLE+HsSOy40RkNnSmCBAgC6qWcBWF0MRKn0q3Mug1lEtQR2gl
	CoP75wdjEAkZhtsP/9r4po63PhEcip1lMiVYQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0E1AC5BAC
	for <git@vger.kernel.org>; Tue,  8 Nov 2011 20:02:41 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7862D5BAB for
 <git@vger.kernel.org>; Tue,  8 Nov 2011 20:02:40 -0500 (EST)
X-Mailer: git-send-email 1.7.8.rc1.82.gde0f9
In-Reply-To: <1320800523-5407-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 85C8B744-0A6E-11E1-9599-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185138>

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t7510-signed-commit.sh |   71 ++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 71 insertions(+), 0 deletions(-)
 create mode 100755 t/t7510-signed-commit.sh

diff --git a/t/t7510-signed-commit.sh b/t/t7510-signed-commit.sh
new file mode 100755
index 0000000..30401ce
--- /dev/null
+++ b/t/t7510-signed-commit.sh
@@ -0,0 +1,71 @@
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
+
+	sed -e "s/fourth signed/4th forged/" raw >forged1 &&
+	git hash-object -w -t commit forged1 >forged1.commit &&
+	git show --pretty=short --show-signature $(cat forged1.commit) >actual1 &&
+	grep "BAD signature from" actual1 &&
+	! grep "Good signature from" actual1
+'
+
+test_expect_success GPG 'detect fudged signature with NUL' '
+	git cat-file commit master >raw &&
+	cat raw >forged2 &&
+	echo Qwik | tr "Q" "\000" >>forged2 &&
+	git hash-object -w -t commit forged2 >forged2.commit &&
+	git show --pretty=short --show-signature $(cat forged2.commit) >actual2 &&
+	grep "BAD signature from" actual2 &&
+	! grep "Good signature from" actual2
+'
+
+test_done
-- 
1.7.8.rc1.82.g90e080
