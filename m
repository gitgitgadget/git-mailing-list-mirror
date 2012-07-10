From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v4 19/19] apply: tests for the --3way option
Date: Tue, 10 Jul 2012 00:04:12 -0700
Message-ID: <1341903852-4815-20-git-send-email-gitster@pobox.com>
References: <1341903852-4815-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 10 09:05:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SoUVc-0000bE-Ii
	for gcvg-git-2@plane.gmane.org; Tue, 10 Jul 2012 09:05:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754193Ab2GJHFM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jul 2012 03:05:12 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53430 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754177Ab2GJHFG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jul 2012 03:05:06 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 90EA87E0B
	for <git@vger.kernel.org>; Tue, 10 Jul 2012 03:05:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=xkOW
	5WTwTZS9V2EQ2jxb4S9h08U=; b=SXge7iszLoT2GLlRT9gQGK91a3ZAfgos8j0X
	al7CqZBBZy2PG0KULyE+8mjwe7pzlKSaSYWetYfOqTMKUCY5CZG35WQo3ApZOiXk
	PAMAJjp9hqkDkqhKKMXX6Dw5DTL48Uqy9J+NYWnUyq9lcLcnpG9CQNwzcGGqTZFb
	ExW3Mc0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=ehAlYl
	8fP3BRr24/fkHCtT5zC8RUT9MjZ+BQC1ZtJJO2YugnsBs5xIyRdmetUN3Me5NvcP
	SglCiptPLB10jN05JWlVbdLd/ktCEIB+gEbbfYNIhGzSUmEOUcb3w3hYxDEiT+ad
	RRYxBAUgvHbmXprCVteyB9LXTTNI+G52nWUoY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 885737E0A
	for <git@vger.kernel.org>; Tue, 10 Jul 2012 03:05:06 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E5CA17E09 for
 <git@vger.kernel.org>; Tue, 10 Jul 2012 03:05:04 -0400 (EDT)
X-Mailer: git-send-email 1.7.11.1.294.g68a9409
In-Reply-To: <1341903852-4815-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 93472C2A-CA5D-11E1-9FA8-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201254>

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t4108-apply-threeway.sh | 54 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/t/t4108-apply-threeway.sh b/t/t4108-apply-threeway.sh
index e6d4da6..fa5d4ef 100755
--- a/t/t4108-apply-threeway.sh
+++ b/t/t4108-apply-threeway.sh
@@ -100,4 +100,58 @@ test_expect_success 'apply with --3way with rerere enabled' '
 	test_cmp expect one
 '
 
+test_expect_success 'apply -3 with add/add conflict setup' '
+	git reset --hard &&
+
+	git checkout -b adder &&
+	create_file 1 2 3 4 5 6 7 >three &&
+	create_file 1 2 3 4 5 6 7 >four &&
+	git add three four &&
+	git commit -m "add three and four" &&
+
+	git checkout -b another adder^ &&
+	create_file 1 2 3 4 5 6 7 >three &&
+	create_file 1 2 3 four 5 6 7 >four &&
+	git add three four &&
+	git commit -m "add three and four" &&
+
+	# Merging another should be similar to applying this patch
+	git diff adder...another >P.diff &&
+
+	git checkout adder^0 &&
+	test_must_fail git merge --no-commit another &&
+	git ls-files -s >expect.ls &&
+	git diff HEAD | sanitize_conflicted_diff >expect.diff
+'
+
+test_expect_success 'apply -3 with add/add conflict' '
+	# should fail to apply ...
+	git reset --hard &&
+	git checkout adder^0 &&
+	test_must_fail git apply --index --3way P.diff &&
+	# ... and leave conflicts in the index and in the working tree
+	git ls-files -s >actual.ls &&
+	git diff HEAD | sanitize_conflicted_diff >actual.diff &&
+
+	# The result should resemble the corresponding merge
+	test_cmp expect.ls actual.ls &&
+	test_cmp expect.diff actual.diff
+'
+
+test_expect_success 'apply -3 with add/add conflict (dirty working tree)' '
+	# should fail to apply ...
+	git reset --hard &&
+	git checkout adder^0 &&
+	echo >>four &&
+	cat four >four.save &&
+	cat three >three.save &&
+	git ls-files -s >expect.ls &&
+	test_must_fail git apply --index --3way P.diff &&
+	# ... and should not touch anything
+	git ls-files -s >actual.ls &&
+	test_cmp expect.ls actual.ls &&
+	test_cmp four.save four &&
+	test_cmp three.save three
+'
+
 test_done
-- 
1.7.11.1.294.g68a9409
