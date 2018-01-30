Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 519D51F404
	for <e@80x24.org>; Tue, 30 Jan 2018 23:45:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752616AbeA3Xpk (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Jan 2018 18:45:40 -0500
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:36774 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932201AbeA3Xpb (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 30 Jan 2018 18:45:31 -0500
Received: from pps.filterd (m0131697.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w0UNOKDv009751;
        Tue, 30 Jan 2018 15:25:35 -0800
Authentication-Results: palantir.com;
        spf=softfail smtp.mailfrom=newren@gmail.com
Received: from smtp-transport.yojoe.local (mxw3.palantir.com [66.70.54.23] (may be forged))
        by mx0a-00153501.pphosted.com with ESMTP id 2frr5qd2d8-2;
        Tue, 30 Jan 2018 15:25:35 -0800
Received: from mxw1.palantir.com (smtp.yojoe.local [172.19.0.45])
        by smtp-transport.yojoe.local (Postfix) with ESMTP id EF588221A56A;
        Tue, 30 Jan 2018 15:25:34 -0800 (PST)
Received: from newren2-linux.yojoe.local (newren2-linux.dyn.yojoe.local [10.100.68.32])
        by smtp.yojoe.local (Postfix) with ESMTP id E3C222CDEB4;
        Tue, 30 Jan 2018 15:25:34 -0800 (PST)
From:   Elijah Newren <newren@gmail.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, sbeller@google.com, szeder.dev@gmail.com,
        jrnieder@gmail.com, peff@peff.net, Elijah Newren <newren@gmail.com>
Subject: [PATCH v7 17/31] merge-recursive: add a new hashmap for storing directory renames
Date:   Tue, 30 Jan 2018 15:25:19 -0800
Message-Id: <20180130232533.25846-18-newren@gmail.com>
X-Mailer: git-send-email 2.16.1.106.gf69932adfe
In-Reply-To: <20180130232533.25846-1-newren@gmail.com>
References: <20180130232533.25846-1-newren@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-SPF-Result: softfail
X-Proofpoint-SPF-Record: v=spf1 redirect=_spf.google.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-01-30_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=4 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1711220000 definitions=main-1801300286
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
index 8ac69e1cbb..3b6d0e3f70 100644
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
2.16.1.106.gf69932adfe

