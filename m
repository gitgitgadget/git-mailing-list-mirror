From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH] update-ref: fail create operation over stdin if ref already exists
Date: Wed,  2 Apr 2014 10:09:54 +0200
Message-ID: <1396426194-3292-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Aman Gupta <aman@tmm1.net>,
	Brad King <brad.king@kitware.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 03 12:00:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WVeKA-0000xS-JG
	for gcvg-git-2@plane.gmane.org; Thu, 03 Apr 2014 11:52:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758083AbaDBIKS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Apr 2014 04:10:18 -0400
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:58317 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758005AbaDBIKN (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 2 Apr 2014 04:10:13 -0400
X-AuditID: 12074412-f79d46d000002e58-c9-533bc5e47f16
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id 6B.44.11864.4E5CB335; Wed,  2 Apr 2014 04:10:12 -0400 (EDT)
Received: from michael.fritz.box (p57A25BD8.dip0.t-ipconnect.de [87.162.91.216])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s328A9h6002248
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Wed, 2 Apr 2014 04:10:11 -0400
X-Mailer: git-send-email 1.9.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrCIsWRmVeSWpSXmKPExsUixO6iqPvkqHWwQe86XYtrby6yWexcJ2HR
	daWbyaKh9wqzxe0V85kdWD3+vv/A5PHx2XJ2j4uXlD365zUye3zeJBfAGsVtk5RYUhacmZ6n
	b5fAnbHg/V32gmaBionb3zA1MPbwdjFyckgImEjs+HiIHcIWk7hwbz1bFyMXh5DAZUaJs4ef
	sYEkhASOM0n8/mUJYrMJ6Eos6mlmArFFBNQkJrYdYgFpYBaYyChxddZURpCEsECwxNOORywg
	NouAqsTmK2vBGngFnCUOfZrCCLFNTmLK7wXsExi5FzAyrGKUS8wpzdXNTczMKU5N1i1OTszL
	Sy3SNdPLzSzRS00p3cQICRGhHYzrT8odYhTgYFTi4T1w3ipYiDWxrLgy9xCjJAeTkigvwzbr
	YCG+pPyUyozE4oz4otKc1OJDjBIczEoivFwHgXK8KYmVValF+TApaQ4WJXHen4vV/YQE0hNL
	UrNTUwtSi2CyMhwcShK8V48ANQoWpaanVqRl5pQgpJk4OEGGc0mJFKfmpaQWJZaWZMSDQj2+
	GBjsICkeoL1nQNp5iwsSc4GiEK2nGBWlxHllQRICIImM0jy4sbDIf8UoDvSlMO8KkCoeYNKA
	634FNJgJaDD3OiuQwSWJCCmpBkb7kJgaK0Ve8QnBLYzyyTYWJowHpzuK6uw//khJ6C+/z5VH
	lzeo+bTdWJlvOkfmkNBCJ8a8wH4Lxb+FmplP3iWsKOxt8w1ZLz47qzC88WWY15Jl+pJVTY6C
	10/tlDub2Jy8clLfE0ORza9Omf2cc930mudqziLdkrpl96YFObwyf9pQcymGV4ml 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245673>

From: Aman Gupta <aman@tmm1.net>

Signed-off-by: Aman Gupta <aman@tmm1.net>
Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
My colleague Aman ran across this bug and wrote the fix.  I didn't
notice this bug, but I just verified that it is also fixed by my
mh/ref-transaction patch series (albeit without a test case).

Because the bug could cause somebody to overwrite a reference
unintentionally, I propose that we apply this unintrusive fix to
maint.  When mh/ref-transaction makes it to a release, the bug will
continue to be fixed, but in a different way.

 builtin/update-ref.c  |  1 +
 t/t1400-update-ref.sh | 11 +++++++++++
 2 files changed, 12 insertions(+)

diff --git a/builtin/update-ref.c b/builtin/update-ref.c
index 1292cfe..5c208bb 100644
--- a/builtin/update-ref.c
+++ b/builtin/update-ref.c
@@ -147,6 +147,7 @@ static void parse_cmd_create(const char *next)
 	struct ref_update *update;
 
 	update = update_alloc();
+	update->have_old = 1;
 
 	if ((next = parse_first_arg(next, &ref)) != NULL && ref.buf[0])
 		update_store_ref_name(update, ref.buf);
diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
index 6ffd82f..e130c52 100755
--- a/t/t1400-update-ref.sh
+++ b/t/t1400-update-ref.sh
@@ -820,7 +820,18 @@ test_expect_success 'stdin -z update ref fails with bad old value' '
 	test_must_fail git rev-parse --verify -q $c
 '
 
+test_expect_success 'stdin -z create ref fails when ref exists' '
+	git update-ref $c $m &&
+	git rev-parse "$c" >expect &&
+	printf $F "create $c" "$m~1" >stdin &&
+	test_must_fail git update-ref -z --stdin <stdin 2>err &&
+	grep "fatal: Cannot lock the ref '"'"'$c'"'"'" err &&
+	git rev-parse "$c" >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'stdin -z create ref fails with bad new value' '
+	git update-ref -d "$c" &&
 	printf $F "create $c" "does-not-exist" >stdin &&
 	test_must_fail git update-ref -z --stdin <stdin 2>err &&
 	grep "fatal: invalid new value for ref $c: does-not-exist" err &&
-- 
1.9.0
