Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0B5171F424
	for <e@80x24.org>; Thu, 21 Dec 2017 19:19:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755076AbdLUTTu (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Dec 2017 14:19:50 -0500
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:56348 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754544AbdLUTTt (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 21 Dec 2017 14:19:49 -0500
Received: from pps.filterd (m0131697.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id vBLJJ7Tt012166;
        Thu, 21 Dec 2017 11:19:07 -0800
Authentication-Results: palantir.com;
        spf=softfail smtp.mailfrom=newren@gmail.com
Received: from smtp-transport.yojoe.local (mxw3.palantir.com [66.70.54.23] (may be forged))
        by mx0a-00153501.pphosted.com with ESMTP id 2ew27n83x1-1;
        Thu, 21 Dec 2017 11:19:07 -0800
Received: from mxw1.palantir.com (smtp.yojoe.local [172.19.0.45])
        by smtp-transport.yojoe.local (Postfix) with ESMTP id A0672220F5EE;
        Thu, 21 Dec 2017 11:19:07 -0800 (PST)
Received: from newren2-linux.yojoe.local (newren2-linux.dyn.yojoe.local [10.100.68.32])
        by smtp.yojoe.local (Postfix) with ESMTP id 97BF32CDE6C;
        Thu, 21 Dec 2017 11:19:07 -0800 (PST)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     a.krey@gmx.de, Elijah Newren <newren@gmail.com>
Subject: [PATCH 3/3] merge-recursive: Avoid incorporating uncommitted changes in a merge
Date:   Thu, 21 Dec 2017 11:19:07 -0800
Message-Id: <20171221191907.4251-3-newren@gmail.com>
X-Mailer: git-send-email 2.15.1.436.g63a861020b
In-Reply-To: <20171221191907.4251-1-newren@gmail.com>
References: <CABPp-BGy3_RyVQfCm+9O_AAfKA0_CZ5ajJE7NuLbToERWyWmqQ@mail.gmail.com>
 <20171221191907.4251-1-newren@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-SPF-Result: softfail
X-Proofpoint-SPF-Record: v=spf1 redirect=_spf.google.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2017-12-21_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=4 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1711220000 definitions=main-1712210263
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

builtin/merge.c contains this important requirement for merge strategies:
	/*
	 * At this point, we need a real merge.  No matter what strategy
	 * we use, it would operate on the index, possibly affecting the
	 * working tree, and when resolved cleanly, have the desired
	 * tree in the index -- this means that the index must be in
	 * sync with the head commit.  The strategies are responsible
	 * to ensure this.
	 */

merge-recursive does not do this check directly, instead it relies on
unpack_trees() to do it.  However, merge_trees() has a special check for
the merge branch exactly matching the merge base; when it detects that
situation, it returns early without calling unpack_trees(), because it
knows that the HEAD commit already has the correct result.  Unfortunately=
,
it didn't check that the index matched HEAD, so after it returned, the
outer logic ended up creating a merge commit that included something
other than HEAD.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-recursive.c                        | 7 +++++++
 t/t6044-merge-unrelated-index-changes.sh | 2 +-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 2ecf495cc2..780f81a8bd 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1952,6 +1952,13 @@ int merge_trees(struct merge_options *o,
 	}
=20
 	if (oid_eq(&common->object.oid, &merge->object.oid)) {
+		struct strbuf sb =3D STRBUF_INIT;
+
+		if (index_has_changes(&sb)) {
+			err(o, _("Dirty index: cannot merge (dirty: %s)"),
+			    sb.buf);
+			return 0;
+		}
 		output(o, 0, _("Already up to date!"));
 		*result =3D head;
 		return 1;
diff --git a/t/t6044-merge-unrelated-index-changes.sh b/t/t6044-merge-unr=
elated-index-changes.sh
index 5e472be92b..23b86fb977 100755
--- a/t/t6044-merge-unrelated-index-changes.sh
+++ b/t/t6044-merge-unrelated-index-changes.sh
@@ -112,7 +112,7 @@ test_expect_success 'recursive' '
 	test_must_fail git merge -s recursive C^0
 '
=20
-test_expect_failure 'recursive, when merge branch matches merge base' '
+test_expect_success 'recursive, when merge branch matches merge base' '
 	git reset --hard &&
 	git checkout B^0 &&
=20
--=20
2.15.1.436.g63a861020b

