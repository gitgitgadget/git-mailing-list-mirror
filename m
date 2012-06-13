From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 17/19] apply: allow rerere() upon --3way results
Date: Wed, 13 Jun 2012 12:32:58 -0700
Message-ID: <1339615980-19727-18-git-send-email-gitster@pobox.com>
References: <1339615980-19727-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 13 21:33:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SetK6-0000ae-1o
	for gcvg-git-2@plane.gmane.org; Wed, 13 Jun 2012 21:33:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754807Ab2FMTdh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jun 2012 15:33:37 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:32942 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754800Ab2FMTdf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jun 2012 15:33:35 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4C187875C
	for <git@vger.kernel.org>; Wed, 13 Jun 2012 15:33:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=v4wO
	pfIWXlh9DXhqDubGmr2MZ1U=; b=o+FvcanMb6UM/pmq7/4CxHNtuQD3sq7vKyMV
	XZE7Nlzkb9J8RC2MhA0RhfKH/FXL/OlfC1SfbYibK1I0OX7CG5j99foT8JpKtHiQ
	Cnu1sdJ66+dQgFbTwU21r8nqhhZ388GWdkPwy993UV9vQBNNbDxdrFX3nJME81CW
	fndayF4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=MWle7X
	h3+wTq5uJgLWFsZr8eN+yvFmKQ6h4zCW2zbNivseXR2nromim9oIzQvVlda4rx9u
	tsB/W67GVocOaEIQ2c5YaBmlH7zgmuz/KTHhsd7LGoL7dgRButgKg6k1lC3lxNzj
	CI8fStJ4g1WuxrKW8pOZUaNPWgc5iG+k0j4Pg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3A58D875B
	for <git@vger.kernel.org>; Wed, 13 Jun 2012 15:33:35 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BA0108749 for
 <git@vger.kernel.org>; Wed, 13 Jun 2012 15:33:34 -0400 (EDT)
X-Mailer: git-send-email 1.7.11.rc3.30.g3bdace2
In-Reply-To: <1339615980-19727-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: AA76934C-B58E-11E1-843D-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199927>

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/apply.c           |  3 +++
 t/t4108-apply-threeway.sh | 25 +++++++++++++++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/builtin/apply.c b/builtin/apply.c
index 8afba92..d12f4f2 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -18,6 +18,7 @@
 #include "parse-options.h"
 #include "xdiff-interface.h"
 #include "ll-merge.h"
+#include "rerere.h"
 
 /*
  *  --check turns on checking that the working tree matches the
@@ -4020,6 +4021,8 @@ static int write_out_results(struct patch *list)
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
1.7.11.rc3.30.g3bdace2
