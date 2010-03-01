From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/3] tests for "git add ignored-dir/file" without -f
Date: Mon, 01 Mar 2010 00:26:26 -0800
Message-ID: <7v7hpw5txp.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 01 09:26:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nm0xZ-0007nO-5R
	for gcvg-git-2@lo.gmane.org; Mon, 01 Mar 2010 09:26:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750807Ab0CAI0c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Mar 2010 03:26:32 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:36057 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750729Ab0CAI0a (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Mar 2010 03:26:30 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 3EEA59D301;
	Mon,  1 Mar 2010 03:26:30 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:subject
	:from:date:message-id:mime-version:content-type; s=sasl; bh=AhDh
	CTmIp2ZiOYkVgvZY7fQvS3s=; b=skWiLHkgr9LE1cj9Nl+6VFL7+Bn+uJ+S4W5N
	GkKsvDiuGys/w1R94AEeOMLWe9PXG2hR9uN0uQWRN8hzM/eKg+sgA+UPkshnFAah
	NAdOERHeTDfACSTumn5yVGpEC6fTJKDht2AUS0rjWxpz1UoUgqUufUG3fzEy3F9a
	RHxNsfs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:subject:from
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=FnJ
	dsN1URv44Au8mjjVfrthSQkqPTkZwn36vUQ2hyaNoUxuE3SwoPoJ/x2t9AYmrTIm
	2Mntl6fnFmNy/c0Y4OltemN43t5WIYR7SOYlw3LCdtOWVnUi0CcN1N1YHMyplPx1
	Lr6lWDSV8wPPf8khWc8q7hC72sCENsAalWHnF35Y=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 2A8FF9D2FF;
	Mon,  1 Mar 2010 03:26:29 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7130C9D2FB; Mon,  1 Mar
 2010 03:26:27 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 22679F9C-250C-11DF-867B-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141304>

Add tests for "attempt to add ignored paths" error condition.  The next
one should fix the breakage.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t2204-add-ignored.sh |   79 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 79 insertions(+), 0 deletions(-)
 create mode 100755 t/t2204-add-ignored.sh

diff --git a/t/t2204-add-ignored.sh b/t/t2204-add-ignored.sh
new file mode 100755
index 0000000..24afdab
--- /dev/null
+++ b/t/t2204-add-ignored.sh
@@ -0,0 +1,79 @@
+#!/bin/sh
+
+test_description='giving ignored paths to git add'
+
+. ./test-lib.sh
+
+test_expect_success setup '
+	mkdir sub dir dir/sub &&
+	echo sub >.gitignore &&
+	echo ign >>.gitignore &&
+	for p in . sub dir dir/sub
+	do
+		>"$p/ign" &&
+		>"$p/file" || exit 1
+	done
+'
+
+for i in file dir/file dir 'd*'
+do
+	test_expect_success "no complaints for unignored $i" '
+		rm -f .git/index &&
+		git add "$i" &&
+		git ls-files "$i" >out &&
+		test -s out
+	'
+done
+
+for i in ign dir/ign dir/sub dir/sub/*ign sub/file sub sub/*
+do
+	test_expect_success "complaints for ignored $i" '
+		rm -f .git/index &&
+		test_must_fail git add "$i" 2>err &&
+		git ls-files "$i" >out &&
+		! test -s out &&
+		grep -e "Use -f if" err &&
+		cat err
+	'
+
+	test_expect_success "complaints for ignored $i with unignored file" '
+		rm -f .git/index &&
+		test_must_fail git add "$i" file 2>err &&
+		git ls-files "$i" >out &&
+		! test -s out &&
+		grep -e "Use -f if" err &&
+		cat err
+	'
+done
+
+for i in sub sub/*
+do
+	test_expect_success "complaints for ignored $i in dir" '
+		rm -f .git/index &&
+		(
+			cd dir &&
+			test_must_fail git add "$i" 2>err &&
+			git ls-files "$i" >out &&
+			! test -s out &&
+			grep -e "Use -f if" err &&
+			cat err
+		)
+	'
+done
+
+for i in ign file
+do
+	test_expect_success "complaints for ignored $i in sub" '
+		rm -f .git/index &&
+		(
+			cd sub &&
+			test_must_fail git add "$i" 2>err &&
+			git ls-files "$i" >out &&
+			! test -s out &&
+			grep -e "Use -f if" err &&
+			cat err
+		)
+	'
+done
+
+test_done
-- 
1.7.0.1.241.g6604f
