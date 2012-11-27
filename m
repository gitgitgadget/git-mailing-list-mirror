From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/5] test: add failing tests for "diff --stat" to t4049
Date: Tue, 27 Nov 2012 13:21:46 -0800
Message-ID: <1354051310-29093-2-git-send-email-gitster@pobox.com>
References: <1354051310-29093-1-git-send-email-gitster@pobox.com>
Cc: Antoine Pelisse <apelisse@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 27 22:22:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TdSba-0001zD-E0
	for gcvg-git-2@plane.gmane.org; Tue, 27 Nov 2012 22:22:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756140Ab2K0VVz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Nov 2012 16:21:55 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41912 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755365Ab2K0VVy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Nov 2012 16:21:54 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 84E6F93CE;
	Tue, 27 Nov 2012 16:21:54 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=baTP
	nADiPZ5R3dZaxISLmFu2U+U=; b=unZT6GSuAJJg5RPfqSjdbJe0hHQonEasBkOu
	eCbwOXxy6+LtrME6t7QmZyYQiAutsn6suDOVQWz5i+dNVAltmwqL4PqjliPt6PnP
	i9aWrbiqM1e66nLMisCZeyEyo91C27dWkdWFUzqHso8n0LhptO2sk6wSt44/jAvx
	i5Gj/DA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	vAOXmqHPSKIXcwmQHCCBNkO5uDsqkSYGeS0zEHRfgVTHeSScSbPMSHA4MYIl633w
	7N4Oui3hircRI4WdtjjLc+iig+v848hhc4UrW8Y5LJ4EJ4upwZQEi5QfSM5693xM
	L5kCiLP7pQa/BLswYhB6srv96FqxnggD1L7uFwK/Bg0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 73F7D93CD;
	Tue, 27 Nov 2012 16:21:54 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CC81793CC; Tue, 27 Nov 2012
 16:21:53 -0500 (EST)
X-Mailer: git-send-email 1.8.0.1.331.g808d2af
In-Reply-To: <1354051310-29093-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 77332A9A-38D8-11E2-882A-C2612E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210600>

There are a few problems in diff.c around --stat area, partially
caused by the recent 74faaa1 (Fix "git diff --stat" for interesting
- but empty - file changes, 2012-10-17), and largely caused by the
earlier change that introduced when --stat-count was added.

Add a few test pieces to t4049 to expose the issues.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t4049-diff-stat-count.sh | 46 +++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 45 insertions(+), 1 deletion(-)

diff --git a/t/t4049-diff-stat-count.sh b/t/t4049-diff-stat-count.sh
index 7b3ef00..e212b11 100755
--- a/t/t4049-diff-stat-count.sh
+++ b/t/t4049-diff-stat-count.sh
@@ -4,12 +4,17 @@
 test_description='diff --stat-count'
 . ./test-lib.sh
 
-test_expect_success setup '
+test_expect_success 'setup' '
 	>a &&
 	>b &&
 	>c &&
 	>d &&
 	git add a b c d &&
+	git commit -m initial
+'
+
+test_expect_success 'limit output to 2 (simple)' '
+	git reset --hard &&
 	chmod +x c d &&
 	echo a >a &&
 	echo b >b &&
@@ -23,4 +28,43 @@ test_expect_success setup '
 	test_i18ncmp expect actual
 '
 
+test_expect_failure 'binary changes do not count in lines' '
+	git reset --hard &&
+	chmod +x c d &&
+	echo a >a &&
+	echo b >b &&
+	cat "$TEST_DIRECTORY"/test-binary-1.png >d &&
+	cat >expect <<-\EOF
+	 a | 1 +
+	 b | 1 +
+	 ...
+	 4 files changed, 2 insertions(+)
+	EOF
+	git diff --stat --stat-count=2 >actual &&
+	test_i18ncmp expect actual
+'
+
+test_expect_failure 'exclude unmerged entries from total file count' '
+	git reset --hard &&
+	echo a >a &&
+	echo b >b &&
+	git ls-files -s a >x &&
+	git rm -f d &&
+	for stage in 1 2 3
+	do
+		sed -e "s/ 0	a/ $stage	d/" x
+	done |
+	git update-index --index-info &&
+	echo d >d &&
+	chmod +x c d &&
+	cat >expect <<-\EOF
+	 a | 1 +
+	 b | 1 +
+	 ...
+	 4 files changed, 3 insertions(+)
+	EOF
+	git diff --stat --stat-count=2 >actual &&
+	test_i18ncmp expect actual
+'
+
 test_done
-- 
1.8.0.1.331.g808d2af
