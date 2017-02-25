Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AD50D2022D
	for <e@80x24.org>; Sat, 25 Feb 2017 10:13:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751824AbdBYKNU (ORCPT <rfc822;e@80x24.org>);
        Sat, 25 Feb 2017 05:13:20 -0500
Received: from aserp1040.oracle.com ([141.146.126.69]:39982 "EHLO
        aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751810AbdBYKNU (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Feb 2017 05:13:20 -0500
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by aserp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with ESMTP id v1PADEYi010464
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
        Sat, 25 Feb 2017 10:13:15 GMT
Received: from t460.home (dhcp-ukc1-twvpn-2-vpnpool-10-175-206-239.vpn.oracle.com [10.175.206.239])
        by aserv0021.oracle.com (8.13.8/8.14.4) with ESMTP id v1PADC6D005857;
        Sat, 25 Feb 2017 10:13:13 GMT
From:   Vegard Nossum <vegard.nossum@oracle.com>
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Cc:     Christian Couder <christian.couder@gmail.com>,
        Michal Zalewski <lcamtuf@google.com>,
        Vegard Nossum <vegard.nossum@oracle.com>
Subject: [PATCH 1/2] apply: guard against renames of non-existant empty files
Date:   Sat, 25 Feb 2017 11:13:06 +0100
Message-Id: <20170225101307.24067-1-vegard.nossum@oracle.com>
X-Mailer: git-send-email 2.12.0.rc0
X-Source-IP: aserv0021.oracle.com [141.146.126.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If we have a patch like the one in the new test-case, then we will
try to rename a non-existant empty file, i.e. patch->old_name will
be NULL. In this case, a NULL entry will be added to fn_table, which
is not allowed (a subsequent binary search will die with a NULL
pointer dereference).

The patch file is completely bogus as it tries to rename something
that is known not to exist, so we can throw an error for this.

Found using AFL.

Signed-off-by: Vegard Nossum <vegard.nossum@oracle.com>
---
 apply.c                     |  3 ++-
 t/t4154-apply-git-header.sh | 15 +++++++++++++++
 2 files changed, 17 insertions(+), 1 deletion(-)
 create mode 100755 t/t4154-apply-git-header.sh

diff --git a/apply.c b/apply.c
index 0e2caeab9..cbf7cc7f2 100644
--- a/apply.c
+++ b/apply.c
@@ -1585,7 +1585,8 @@ static int find_header(struct apply_state *state,
 				patch->old_name = xstrdup(patch->def_name);
 				patch->new_name = xstrdup(patch->def_name);
 			}
-			if (!patch->is_delete && !patch->new_name) {
+			if ((!patch->is_delete && !patch->new_name) ||
+			    (patch->is_rename && !patch->old_name)) {
 				error(_("git diff header lacks filename information "
 					     "(line %d)"), state->linenr);
 				return -128;
diff --git a/t/t4154-apply-git-header.sh b/t/t4154-apply-git-header.sh
new file mode 100755
index 000000000..d651af4a2
--- /dev/null
+++ b/t/t4154-apply-git-header.sh
@@ -0,0 +1,15 @@
+#!/bin/sh
+
+test_description='apply with git/--git headers'
+
+. ./test-lib.sh
+
+test_expect_success 'apply old mode / rename new' '
+	test_must_fail git apply << EOF
+diff --git a/1 b/1
+old mode 0
+rename new 0
+EOF
+'
+
+test_done
-- 
2.12.0.rc0

