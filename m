Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EED781F42B
	for <e@80x24.org>; Fri, 10 Nov 2017 19:06:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753945AbdKJTG0 (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Nov 2017 14:06:26 -0500
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:48764 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753796AbdKJTGD (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 10 Nov 2017 14:06:03 -0500
Received: from pps.filterd (m0131697.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id vAAJ4Gr9002777;
        Fri, 10 Nov 2017 11:06:02 -0800
Authentication-Results: palantir.com;
        spf=softfail smtp.mailfrom=newren@gmail.com
Received: from smtp-transport.yojoe.local (mxw3.palantir.com [66.70.54.23] (may be forged))
        by mx0a-00153501.pphosted.com with ESMTP id 2e53631bgs-3;
        Fri, 10 Nov 2017 11:06:01 -0800
Received: from mxw1.palantir.com (new-smtp.yojoe.local [172.19.0.45])
        by smtp-transport.yojoe.local (Postfix) with ESMTP id 5672122F6288;
        Fri, 10 Nov 2017 11:06:01 -0800 (PST)
Received: from newren2-linux.yojoe.local (newren2-linux.dyn.yojoe.local [10.100.68.32])
        by smtp.yojoe.local (Postfix) with ESMTP id 4D0082CDE6A;
        Fri, 10 Nov 2017 11:06:01 -0800 (PST)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>
Subject: [PATCH 26/30] merge-recursive: When comparing files, don't include trees
Date:   Fri, 10 Nov 2017 11:05:46 -0800
Message-Id: <20171110190550.27059-27-newren@gmail.com>
X-Mailer: git-send-email 2.15.0.5.g9567be9905
In-Reply-To: <20171110190550.27059-1-newren@gmail.com>
References: <20171110190550.27059-1-newren@gmail.com>
X-Proofpoint-SPF-Result: softfail
X-Proofpoint-SPF-Record: v=spf1 redirect=_spf.google.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2017-11-10_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=4 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1707230000
 definitions=main-1711100261
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

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-recursive.c | 27 +++++++++++++++++++++------
 1 file changed, 21 insertions(+), 6 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 7c2c29bb51..2a7258f6bb 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -407,6 +407,21 @@ static void get_files_dirs(struct merge_options *o, struct tree *tree)
 	read_tree_recursive(tree, "", 0, 0, &match_all, save_files_dirs, o);
 }
 
+static int get_tree_entry_if_blob(const unsigned char *tree,
+				  const char *path,
+				  unsigned char *hashy,
+				  unsigned *mode_o)
+{
+	int ret;
+
+	ret = get_tree_entry(tree, path, hashy, mode_o);
+	if (S_ISDIR(*mode_o)) {
+		hashcpy(hashy, null_sha1);
+		*mode_o = 0;
+	}
+	return ret;
+}
+
 /*
  * Returns an index_entry instance which doesn't have to correspond to
  * a real cache entry in Git's index.
@@ -417,12 +432,12 @@ static struct stage_data *insert_stage_data(const char *path,
 {
 	struct string_list_item *item;
 	struct stage_data *e = xcalloc(1, sizeof(struct stage_data));
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
 	item = string_list_insert(entries, path);
 	item->util = e;
 	return e;
-- 
2.15.0.5.g9567be9905

