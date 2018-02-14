Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1C55E1F404
	for <e@80x24.org>; Wed, 14 Feb 2018 18:53:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1162401AbeBNSxi (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Feb 2018 13:53:38 -0500
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:37222 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1162387AbeBNSxY (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 14 Feb 2018 13:53:24 -0500
Received: from pps.filterd (m0096528.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w1EIm45o011919;
        Wed, 14 Feb 2018 10:52:08 -0800
Authentication-Results: palantir.com;
        spf=softfail smtp.mailfrom=newren@gmail.com
Received: from smtp-transport.yojoe.local (mxw3.palantir.com [66.70.54.23] (may be forged))
        by mx0a-00153501.pphosted.com with ESMTP id 2g1xgry8kg-1;
        Wed, 14 Feb 2018 10:52:08 -0800
Received: from mxw1.palantir.com (smtp.yojoe.local [172.19.0.45])
        by smtp-transport.yojoe.local (Postfix) with ESMTP id B2B7A225EC4F;
        Wed, 14 Feb 2018 10:52:07 -0800 (PST)
Received: from newren2-linux.yojoe.local (newren2-linux.dyn.yojoe.local [10.100.68.32])
        by smtp.yojoe.local (Postfix) with ESMTP id 9AC2B2CDE88;
        Wed, 14 Feb 2018 10:52:07 -0800 (PST)
From:   Elijah Newren <newren@gmail.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, sbeller@google.com,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH v8 22/29] merge-recursive: when comparing files, don't include trees
Date:   Wed, 14 Feb 2018 10:51:59 -0800
Message-Id: <20180214185206.15492-23-newren@gmail.com>
X-Mailer: git-send-email 2.16.1.232.g28d5be9217
In-Reply-To: <20180214185206.15492-1-newren@gmail.com>
References: <20180214185206.15492-1-newren@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-SPF-Result: softfail
X-Proofpoint-SPF-Record: v=spf1 redirect=_spf.google.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-14_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=4 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1711220000 definitions=main-1802140219
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

get_renames() would look up stage data that already existed (populated
in get_unmerged(), taken from whatever unpack_trees() created), and if
it didn't exist, would call insert_stage_data() to create the necessary
entry for the given file.  The insert_stage_data() fallback becomes
much more important for directory rename detection, because that creates
a mechanism to have a file in the resulting merge that didn't exist on
either side of history.  However, insert_stage_data(), due to calling
get_tree_entry() loaded up trees as readily as files.  We aren't
interested in comparing trees to files; the D/F conflict handling is
done elsewhere.  This code is just concerned with what entries existed
for a given path on the different sides of the merge, so create a
get_tree_entry_if_blob() helper function and use it.

Reviewed-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-recursive.c | 27 +++++++++++++++++++++------
 1 file changed, 21 insertions(+), 6 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index efe9c9a98e..18f92be608 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -421,6 +421,21 @@ static void get_files_dirs(struct merge_options *o, =
struct tree *tree)
 	read_tree_recursive(tree, "", 0, 0, &match_all, save_files_dirs, o);
 }
=20
+static int get_tree_entry_if_blob(const unsigned char *tree,
+				  const char *path,
+				  unsigned char *hashy,
+				  unsigned int *mode_o)
+{
+	int ret;
+
+	ret =3D get_tree_entry(tree, path, hashy, mode_o);
+	if (S_ISDIR(*mode_o)) {
+		hashcpy(hashy, null_sha1);
+		*mode_o =3D 0;
+	}
+	return ret;
+}
+
 /*
  * Returns an index_entry instance which doesn't have to correspond to
  * a real cache entry in Git's index.
@@ -431,12 +446,12 @@ static struct stage_data *insert_stage_data(const c=
har *path,
 {
 	struct string_list_item *item;
 	struct stage_data *e =3D xcalloc(1, sizeof(struct stage_data));
-	get_tree_entry(o->object.oid.hash, path,
-			e->stages[1].oid.hash, &e->stages[1].mode);
-	get_tree_entry(a->object.oid.hash, path,
-			e->stages[2].oid.hash, &e->stages[2].mode);
-	get_tree_entry(b->object.oid.hash, path,
-			e->stages[3].oid.hash, &e->stages[3].mode);
+	get_tree_entry_if_blob(o->object.oid.hash, path,
+			       e->stages[1].oid.hash, &e->stages[1].mode);
+	get_tree_entry_if_blob(a->object.oid.hash, path,
+			       e->stages[2].oid.hash, &e->stages[2].mode);
+	get_tree_entry_if_blob(b->object.oid.hash, path,
+			       e->stages[3].oid.hash, &e->stages[3].mode);
 	item =3D string_list_insert(entries, path);
 	item->util =3D e;
 	return e;
--=20
2.16.1.232.g28d5be9217

