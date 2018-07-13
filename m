Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D82581F85E
	for <e@80x24.org>; Fri, 13 Jul 2018 16:33:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731935AbeGMQtC (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Jul 2018 12:49:02 -0400
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:41036 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729762AbeGMQtB (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 13 Jul 2018 12:49:01 -0400
Received: from pps.filterd (m0131697.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6DGTGVp027159;
        Fri, 13 Jul 2018 09:33:34 -0700
Authentication-Results: palantir.com;
        spf=softfail smtp.mailfrom=newren@gmail.com
Received: from smtp-transport.yojoe.local (mxw3.palantir.com [66.70.54.23] (may be forged))
        by mx0a-00153501.pphosted.com with ESMTP id 2k2uchk0sg-1;
        Fri, 13 Jul 2018 09:33:34 -0700
Received: from mxw1.palantir.com (smtp.yojoe.local [172.19.0.45])
        by smtp-transport.yojoe.local (Postfix) with ESMTP id 49884225F290;
        Fri, 13 Jul 2018 09:33:34 -0700 (PDT)
Received: from newren2-linux.yojoe.local (newren2-linux.pa.palantir.tech [10.100.71.66])
        by smtp.yojoe.local (Postfix) with ESMTP id 33AC32CDE6A;
        Fri, 13 Jul 2018 09:33:34 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, sunshine@sunshineco.com,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH v2 1/2] t1015: demonstrate directory/file conflict recovery failures
Date:   Fri, 13 Jul 2018 09:33:30 -0700
Message-Id: <20180713163331.22446-2-newren@gmail.com>
X-Mailer: git-send-email 2.18.0.645.g72fe132ec2
In-Reply-To: <20180713163331.22446-1-newren@gmail.com>
References: <20180711051834.28181-1-newren@gmail.com>
 <20180713163331.22446-1-newren@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-SPF-Result: softfail
X-Proofpoint-SPF-Record: v=spf1 redirect=_spf.google.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-13_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=4 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807130143
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Several "recovery" commands outright fail or do not fully recover
when directory-file conflicts are present.  This includes:
  * git read-tree --reset HEAD
  * git am --skip
  * git am --abort
  * git merge --abort
  * git reset --hard

Add testcases documenting these shortcomings.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t1015-read-index-unmerged.sh | 123 +++++++++++++++++++++++++++++++++
 1 file changed, 123 insertions(+)
 create mode 100755 t/t1015-read-index-unmerged.sh

diff --git a/t/t1015-read-index-unmerged.sh b/t/t1015-read-index-unmerged=
.sh
new file mode 100755
index 0000000000..32ef6bdcfa
--- /dev/null
+++ b/t/t1015-read-index-unmerged.sh
@@ -0,0 +1,123 @@
+#!/bin/sh
+
+test_description=3D'Test various callers of read_index_unmerged'
+. ./test-lib.sh
+
+test_expect_success 'setup modify/delete + directory/file conflict' '
+	test_create_repo df_plus_modify_delete &&
+	(
+		cd df_plus_modify_delete &&
+
+		test_write_lines a b c d e f g h >letters &&
+		git add letters &&
+		git commit -m initial &&
+
+		git checkout -b modify &&
+		# Throw in letters.txt for sorting order fun
+		# ("letters.txt" sorts between "letters" and "letters/file")
+		echo i >>letters &&
+		echo "version 2" >letters.txt &&
+		git add letters letters.txt &&
+		git commit -m modified &&
+
+		git checkout -b delete HEAD^ &&
+		git rm letters &&
+		mkdir letters &&
+		>letters/file &&
+		echo "version 1" >letters.txt &&
+		git add letters letters.txt &&
+		git commit -m deleted
+	)
+'
+
+test_expect_failure 'read-tree --reset cleans unmerged entries' '
+	test_when_finished "git -C df_plus_modify_delete clean -f" &&
+	test_when_finished "git -C df_plus_modify_delete reset --hard" &&
+	(
+		cd df_plus_modify_delete &&
+
+		git checkout delete^0 &&
+		test_must_fail git merge modify &&
+
+		git read-tree --reset HEAD &&
+		git ls-files -u >conflicts &&
+		test_must_be_empty conflicts
+	)
+'
+
+test_expect_failure 'One reset --hard cleans unmerged entries' '
+	test_when_finished "git -C df_plus_modify_delete clean -f" &&
+	test_when_finished "git -C df_plus_modify_delete reset --hard" &&
+	(
+		cd df_plus_modify_delete &&
+
+		git checkout delete^0 &&
+		test_must_fail git merge modify &&
+
+		git reset --hard &&
+		test_path_is_missing .git/MERGE_HEAD &&
+		git ls-files -u >conflicts &&
+		test_must_be_empty conflicts
+	)
+'
+
+test_expect_success 'setup directory/file conflict + simple edit/edit' '
+	test_create_repo df_plus_edit_edit &&
+	(
+		cd df_plus_edit_edit &&
+
+		test_seq 1 10 >numbers &&
+		git add numbers &&
+		git commit -m initial &&
+
+		git checkout -b d-edit &&
+		mkdir foo &&
+		echo content >foo/bar &&
+		git add foo &&
+		echo 11 >>numbers &&
+		git add numbers &&
+		git commit -m "directory and edit" &&
+
+		git checkout -b f-edit d-edit^1 &&
+		echo content >foo &&
+		git add foo &&
+		echo eleven >>numbers &&
+		git add numbers &&
+		git commit -m "file and edit"
+	)
+'
+
+test_expect_failure 'git merge --abort succeeds despite D/F conflict' '
+	test_when_finished "git -C df_plus_edit_edit clean -f" &&
+	test_when_finished "git -C df_plus_edit_edit reset --hard" &&
+	(
+		cd df_plus_edit_edit &&
+
+		git checkout f-edit^0 &&
+		test_must_fail git merge d-edit^0 &&
+
+		git merge --abort &&
+		test_path_is_missing .git/MERGE_HEAD &&
+		git ls-files -u >conflicts &&
+		test_must_be_empty conflicts
+	)
+'
+
+test_expect_failure 'git am --skip succeeds despite D/F conflict' '
+	test_when_finished "git -C df_plus_edit_edit clean -f" &&
+	test_when_finished "git -C df_plus_edit_edit reset --hard" &&
+	(
+		cd df_plus_edit_edit &&
+
+		git checkout f-edit^0 &&
+		git format-patch -1 d-edit &&
+		test_must_fail git am -3 0001*.patch &&
+
+		git am --skip &&
+		test_path_is_missing .git/rebase-apply &&
+		git ls-files -u >conflicts &&
+		test_must_be_empty conflicts
+	)
+'
+
+test_done
--=20
2.18.0.645.g72fe132ec2

