From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 8/9] apply: allow rerere() upon --3way results
Date: Thu, 10 May 2012 15:32:52 -0700
Message-ID: <1336689173-15822-9-git-send-email-gitster@pobox.com>
References: <1336689173-15822-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 11 00:33:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SSbvO-0006Jv-3s
	for gcvg-git-2@plane.gmane.org; Fri, 11 May 2012 00:33:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932611Ab2EJWdX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 May 2012 18:33:23 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36745 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932577Ab2EJWdL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 May 2012 18:33:11 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6E934843C
	for <git@vger.kernel.org>; Thu, 10 May 2012 18:33:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=yX2s
	GEjdyZtKj9xiD1OGqQdYLwQ=; b=USv0z5fa6BwaCg+/rJIXy08FxtQPMyuLgRb+
	NXzLzDEqPY0SH9Cts3wv/gesR32PGQDdsdaPKysInSBuFsF/qMcNXz/j0IDijdKF
	wtzs6tw/NChargkh0CsORDUvPLHrdi21JLjQ/M9sBq8v99Qg1pJh50AZ+SdXSoz7
	bGEuhyo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=ykya2r
	Dun8/m+ZvgMwg74Rp8GGywNwAgx3VAvsUxZcsvBXIq8mSWGQ62oq7k+KCw1gs91P
	/OEF8JckUyhwYVazATgMjkMupOQj2bc3+iyXXEwSkqyx2eJHaKoBWHQf34L34aWg
	LsgR0210Oj7DvxwILHMr8w4rHsDM5vxw+h03o=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 665CA843B
	for <git@vger.kernel.org>; Thu, 10 May 2012 18:33:11 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EA767843A for
 <git@vger.kernel.org>; Thu, 10 May 2012 18:33:10 -0400 (EDT)
X-Mailer: git-send-email 1.7.10.1.574.g840b38f
In-Reply-To: <1336689173-15822-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 1F887D08-9AF0-11E1-92E3-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197643>

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/apply.c           |  3 +++
 t/t4108-apply-threeway.sh | 25 +++++++++++++++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/builtin/apply.c b/builtin/apply.c
index 9f376b5..502c1bf1 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -18,6 +18,7 @@
 #include "parse-options.h"
 #include "xdiff-interface.h"
 #include "ll-merge.h"
+#include "rerere.h"
 
 /*
  *  --check turns on checking that the working tree matches the
@@ -3874,6 +3875,8 @@ static int write_out_results(struct patch *list)
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
1.7.10.1.574.g840b38f
