Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CC11020954
	for <e@80x24.org>; Wed, 29 Nov 2017 01:44:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753312AbdK2Bn7 (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Nov 2017 20:43:59 -0500
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:55472 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753238AbdK2Bnz (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 28 Nov 2017 20:43:55 -0500
Received: from pps.filterd (m0131697.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id vAT1d790004735;
        Tue, 28 Nov 2017 17:42:39 -0800
Authentication-Results: ppops.net;
        spf=softfail smtp.mailfrom=newren@gmail.com
Received: from smtp-transport.yojoe.local (mxw3.palantir.com [66.70.54.23] (may be forged))
        by mx0a-00153501.pphosted.com with ESMTP id 2ef78pmm13-2;
        Tue, 28 Nov 2017 17:42:38 -0800
Received: from mxw1.palantir.com (new-smtp.yojoe.local [172.19.0.45])
        by smtp-transport.yojoe.local (Postfix) with ESMTP id CEFCB22157C9;
        Tue, 28 Nov 2017 17:42:38 -0800 (PST)
Received: from newren2-linux.yojoe.local (newren2-linux.dyn.yojoe.local [10.100.68.32])
        by smtp.yojoe.local (Postfix) with ESMTP id C5C562CDE74;
        Tue, 28 Nov 2017 17:42:38 -0800 (PST)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, gitster@pobox.com,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH v4 20/34] merge-recursive: add a new hashmap for storing directory renames
Date:   Tue, 28 Nov 2017 17:42:23 -0800
Message-Id: <20171129014237.32570-21-newren@gmail.com>
X-Mailer: git-send-email 2.15.0.408.g850bc54b15
In-Reply-To: <20171129014237.32570-1-newren@gmail.com>
References: <20171129014237.32570-1-newren@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-SPF-Result: softfail
X-Proofpoint-SPF-Record: v=spf1 redirect=_spf.google.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2017-11-28_13:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=4 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1711290020
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This just adds dir_rename_entry and the associated functions; code using
these will be added in subsequent commits.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-recursive.c | 35 +++++++++++++++++++++++++++++++++++
 merge-recursive.h |  8 ++++++++
 2 files changed, 43 insertions(+)

diff --git a/merge-recursive.c b/merge-recursive.c
index 4adff2d538..0cb27c66e2 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -49,6 +49,41 @@ static unsigned int path_hash(const char *path)
 	return ignore_case ? strihash(path) : strhash(path);
 }
=20
+static struct dir_rename_entry *dir_rename_find_entry(struct hashmap *ha=
shmap,
+						      char *dir)
+{
+	struct dir_rename_entry key;
+
+	if (dir =3D=3D NULL)
+		return NULL;
+	hashmap_entry_init(&key, strhash(dir));
+	key.dir =3D dir;
+	return hashmap_get(hashmap, &key, NULL);
+}
+
+static int dir_rename_cmp(void *unused_cmp_data,
+			  const struct dir_rename_entry *e1,
+			  const struct dir_rename_entry *e2,
+			  const void *unused_keydata)
+{
+	return strcmp(e1->dir, e2->dir);
+}
+
+static void dir_rename_init(struct hashmap *map)
+{
+	hashmap_init(map, (hashmap_cmp_fn) dir_rename_cmp, NULL, 0);
+}
+
+static void dir_rename_entry_init(struct dir_rename_entry *entry,
+				  char *directory)
+{
+	hashmap_entry_init(entry, strhash(directory));
+	entry->dir =3D directory;
+	entry->non_unique_new_dir =3D 0;
+	strbuf_init(&entry->new_dir, 0);
+	string_list_init(&entry->possible_new_dirs, 0);
+}
+
 static void flush_output(struct merge_options *o)
 {
 	if (o->buffer_output < 2 && o->obuf.len) {
diff --git a/merge-recursive.h b/merge-recursive.h
index 80d69d1401..d7f4cc80c1 100644
--- a/merge-recursive.h
+++ b/merge-recursive.h
@@ -29,6 +29,14 @@ struct merge_options {
 	struct string_list df_conflict_file_set;
 };
=20
+struct dir_rename_entry {
+	struct hashmap_entry ent; /* must be the first member! */
+	char *dir;
+	unsigned non_unique_new_dir:1;
+	struct strbuf new_dir;
+	struct string_list possible_new_dirs;
+};
+
 /* merge_trees() but with recursive ancestor consolidation */
 int merge_recursive(struct merge_options *o,
 		    struct commit *h1,
--=20
2.15.0.408.g850bc54b15

