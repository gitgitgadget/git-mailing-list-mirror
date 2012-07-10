From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v4 17/19] apply: allow rerere() to work on --3way results
Date: Tue, 10 Jul 2012 00:04:10 -0700
Message-ID: <1341903852-4815-18-git-send-email-gitster@pobox.com>
References: <1341903852-4815-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 10 09:05:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SoUVd-0000bE-3j
	for gcvg-git-2@plane.gmane.org; Tue, 10 Jul 2012 09:05:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754192Ab2GJHFL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jul 2012 03:05:11 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53363 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754152Ab2GJHFA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jul 2012 03:05:00 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6C9257E02
	for <git@vger.kernel.org>; Tue, 10 Jul 2012 03:05:00 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=EUnE
	MxWE97rIDi67dSGwUlN0lxw=; b=UTf9cVf74VRauyIhcnon248JyBSD2b1wIwIV
	Y4RO1+rNb0PsMFmkPH49OSXcmLHCjvB/XTFGQ/rKK8izoy3ZCrou7wPdJeqB2cK5
	/oNNLgxehdl6Z4fXUS1Iyk7by82xRGXs29z+Gy/KBi86BQIy4STqXgbQQ9U+gvZf
	qMDqHQU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=A8pteA
	KfaqfMy++cGLU935inpmzbC8jiDPmVGmgsog/eOcMn4B1znRcDJqP6mwZ9nFFQ9I
	X/6Kw6bPgasigunlsWm7vy1C1gvbh/xwDWG3D3cixw8GcVGKUEVvB6GS4QQHLSTl
	EOcsA3g0KinEuRIG/M2GRjm8S2LEOWyDCMf/w=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 640077E01
	for <git@vger.kernel.org>; Tue, 10 Jul 2012 03:05:00 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E1DDB7E00 for
 <git@vger.kernel.org>; Tue, 10 Jul 2012 03:04:59 -0400 (EDT)
X-Mailer: git-send-email 1.7.11.1.294.g68a9409
In-Reply-To: <1341903852-4815-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 9049B9F2-CA5D-11E1-BBBD-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201255>

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/apply.c           |  3 +++
 t/t4108-apply-threeway.sh | 25 +++++++++++++++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/builtin/apply.c b/builtin/apply.c
index dc52c94..cd68862 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -18,6 +18,7 @@
 #include "parse-options.h"
 #include "xdiff-interface.h"
 #include "ll-merge.h"
+#include "rerere.h"
 
 /*
  *  --check turns on checking that the working tree matches the
@@ -4026,6 +4027,8 @@ static int write_out_results(struct patch *list)
 		for_each_string_list_item(item, &cpath)
 			fprintf(stderr, "U %s\n", item->string);
 		string_list_clear(&cpath, 0);
+
+		rerere(0);
 	}
 
 	return errs;
diff --git a/t/t4108-apply-threeway.sh b/t/t4108-apply-threeway.sh
index 475dfb5..e6d4da6 100755
--- a/t/t4108-apply-threeway.sh
+++ b/t/t4108-apply-threeway.sh
@@ -75,4 +75,29 @@ test_expect_success 'apply with --3way' '
 	test_cmp expect.diff actual.diff
 '
 
+test_expect_success 'apply with --3way with rerere enabled' '
+	git config rerere.enabled true &&
+
+	# Merging side should be similar to applying this patch
+	git diff ...side >P.diff &&
+
+	# The corresponding conflicted merge
+	git reset --hard &&
+	git checkout master^0 &&
+	test_must_fail git merge --no-commit side &&
+
+	# Manually resolve and record the resolution
+	create_file 1 two 3 4 five six 7 >one &&
+	git rerere &&
+	cat one >expect &&
+
+	# should fail to apply
+	git reset --hard &&
+	git checkout master^0 &&
+	test_must_fail git apply --index --3way P.diff &&
+
+	# but rerere should have replayed the recorded resolution
+	test_cmp expect one
+'
+
 test_done
-- 
1.7.11.1.294.g68a9409
