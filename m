Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0D2E8202F2
	for <e@80x24.org>; Mon, 20 Nov 2017 22:03:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751767AbdKTWDP (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Nov 2017 17:03:15 -0500
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:38052 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751427AbdKTWCO (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 20 Nov 2017 17:02:14 -0500
Received: from pps.filterd (m0131697.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id vAKLxARs020073;
        Mon, 20 Nov 2017 14:02:10 -0800
Authentication-Results: ppops.net;
        spf=softfail smtp.mailfrom=newren@gmail.com
Received: from smtp-transport.yojoe.local (mxw3.palantir.com [66.70.54.23] (may be forged))
        by mx0a-00153501.pphosted.com with ESMTP id 2eakkpb8qm-2;
        Mon, 20 Nov 2017 14:02:10 -0800
Received: from mxw1.palantir.com (smtp.yojoe.local [172.19.0.45])
        by smtp-transport.yojoe.local (Postfix) with ESMTP id 1952822F41B1;
        Mon, 20 Nov 2017 14:02:10 -0800 (PST)
Received: from newren2-linux.yojoe.local (newren2-linux.dyn.yojoe.local [10.100.68.32])
        by smtp.yojoe.local (Postfix) with ESMTP id 15B6A2CDE75;
        Mon, 20 Nov 2017 14:02:10 -0800 (PST)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, gitster@pobox.com,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH v2 23/33] merge-recursive: add a new hashmap for storing file collisions
Date:   Mon, 20 Nov 2017 14:01:59 -0800
Message-Id: <20171120220209.15111-24-newren@gmail.com>
X-Mailer: git-send-email 2.15.0.323.g31fe956618
In-Reply-To: <20171120220209.15111-1-newren@gmail.com>
References: <20171120220209.15111-1-newren@gmail.com>
X-Proofpoint-SPF-Result: softfail
X-Proofpoint-SPF-Record: v=spf1 redirect=_spf.google.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2017-11-20_12:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=4 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1711200295
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Directory renames with the ability to merge directories opens up the
possibility of add/add/add/.../add conflicts, if each of the N
directories being merged into one target directory all had a file with
the same name.  We need a way to check for and report on such
collisions; this hashmap will be used for this purpose.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-recursive.c | 23 +++++++++++++++++++++++
 merge-recursive.h |  7 +++++++
 2 files changed, 30 insertions(+)

diff --git a/merge-recursive.c b/merge-recursive.c
index 03897af883..472754c493 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -84,6 +84,29 @@ static void dir_rename_entry_init(struct dir_rename_entry *entry,
 	string_list_init(&entry->possible_new_dirs, 0);
 }
 
+static struct collision_entry *collision_find_entry(struct hashmap *hashmap,
+						    char *target_file)
+{
+	struct collision_entry key;
+
+	hashmap_entry_init(&key, strhash(target_file));
+	key.target_file = target_file;
+	return hashmap_get(hashmap, &key, NULL);
+}
+
+static int collision_cmp(void *unused_cmp_data,
+			 const struct collision_entry *e1,
+			 const struct collision_entry *e2,
+			 const void *unused_keydata)
+{
+	return strcmp(e1->target_file, e2->target_file);
+}
+
+static void collision_init(struct hashmap *map)
+{
+	hashmap_init(map, (hashmap_cmp_fn) collision_cmp, NULL, 0);
+}
+
 static void flush_output(struct merge_options *o)
 {
 	if (o->buffer_output < 2 && o->obuf.len) {
diff --git a/merge-recursive.h b/merge-recursive.h
index a024949739..e02c1e1243 100644
--- a/merge-recursive.h
+++ b/merge-recursive.h
@@ -37,6 +37,13 @@ struct dir_rename_entry {
 	struct string_list possible_new_dirs;
 };
 
+struct collision_entry {
+	struct hashmap_entry ent; /* must be the first member! */
+	char *target_file;
+	struct string_list source_files;
+	unsigned reported_already:1;
+};
+
 /* merge_trees() but with recursive ancestor consolidation */
 int merge_recursive(struct merge_options *o,
 		    struct commit *h1,
-- 
2.15.0.309.g00c152f825

