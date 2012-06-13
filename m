From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 19/19] apply --3way: tests
Date: Wed, 13 Jun 2012 12:33:00 -0700
Message-ID: <1339615980-19727-20-git-send-email-gitster@pobox.com>
References: <1339615980-19727-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 13 21:33:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SetK6-0000ae-IJ
	for gcvg-git-2@plane.gmane.org; Wed, 13 Jun 2012 21:33:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754817Ab2FMTdn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jun 2012 15:33:43 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33005 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754810Ab2FMTdj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jun 2012 15:33:39 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D42BC8766
	for <git@vger.kernel.org>; Wed, 13 Jun 2012 15:33:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=0bio
	g19D3EKoBmYh5gXt9cVLr8U=; b=eyN+V73TW2MQ5aj8MWuPVRSYcVE5EvfGO1/F
	/u5sirNspuFfdLuESVbepDBqV9KcFQW5nQJLU/Agz8mX652Z9W4kA0kjidpVEWCW
	McCcAv2O+iS73nDDaHhOXDVFrUXShnZYBMQ7t4XDSCtwUqxL+Fv9YX/jVE4P4OOK
	JicdQUo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=ybNkUx
	335yDE8jzwhzQZZsiahI/HCIwBKUxf3co4zuM2PnQqjKNeV8ZkeqSOquqvvAJZc8
	qTRNj1cgdhwdisYAzL4aKADehwfK/wyK5FVRjAUiv9xMwUXr3QpgfC9QRKdpOk/c
	8PIH8vVYEy8bAGCRV3IubnxyCIIYkdrMFfPmA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CC6858765
	for <git@vger.kernel.org>; Wed, 13 Jun 2012 15:33:38 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5C69D8764 for
 <git@vger.kernel.org>; Wed, 13 Jun 2012 15:33:38 -0400 (EDT)
X-Mailer: git-send-email 1.7.11.rc3.30.g3bdace2
In-Reply-To: <1339615980-19727-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: AC9E78CE-B58E-11E1-9026-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199928>

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
1.7.11.rc3.30.g3bdace2
