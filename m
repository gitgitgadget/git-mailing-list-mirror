Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B3E461F424
	for <e@80x24.org>; Thu, 21 Dec 2017 19:20:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755153AbdLUTUX (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Dec 2017 14:20:23 -0500
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:53680 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1755114AbdLUTUX (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 21 Dec 2017 14:20:23 -0500
Received: from pps.filterd (m0096528.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id vBLJIK7I001381;
        Thu, 21 Dec 2017 11:19:08 -0800
Authentication-Results: palantir.com;
        spf=softfail smtp.mailfrom=newren@gmail.com
Received: from smtp-transport.yojoe.local (mxw3.palantir.com [66.70.54.23] (may be forged))
        by mx0a-00153501.pphosted.com with ESMTP id 2ew18q872k-1;
        Thu, 21 Dec 2017 11:19:07 -0800
Received: from mxw1.palantir.com (smtp.yojoe.local [172.19.0.45])
        by smtp-transport.yojoe.local (Postfix) with ESMTP id 97229220F5EB;
        Thu, 21 Dec 2017 11:19:07 -0800 (PST)
Received: from newren2-linux.yojoe.local (newren2-linux.dyn.yojoe.local [10.100.68.32])
        by smtp.yojoe.local (Postfix) with ESMTP id 904DA2CDE83;
        Thu, 21 Dec 2017 11:19:07 -0800 (PST)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     a.krey@gmx.de, Elijah Newren <newren@gmail.com>
Subject: [PATCH 2/3] move index_has_changes() from builtin/am.c to merge.c for reuse
Date:   Thu, 21 Dec 2017 11:19:06 -0800
Message-Id: <20171221191907.4251-2-newren@gmail.com>
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

index_has_changes() is a function we want to reuse outside of just am,
making it also available for merge-recursive and merge-ort.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/am.c | 37 -------------------------------------
 cache.h      |  9 +++++++++
 merge.c      | 33 +++++++++++++++++++++++++++++++++
 3 files changed, 42 insertions(+), 37 deletions(-)

diff --git a/builtin/am.c b/builtin/am.c
index 3d98e52085..a02d5186cb 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -1142,43 +1142,6 @@ static void refresh_and_write_cache(void)
 		die(_("unable to write index file"));
 }
=20
-/**
- * Returns 1 if the index differs from HEAD, 0 otherwise. When on an unb=
orn
- * branch, returns 1 if there are entries in the index, 0 otherwise. If =
an
- * strbuf is provided, the space-separated list of files that differ wil=
l be
- * appended to it.
- */
-static int index_has_changes(struct strbuf *sb)
-{
-	struct object_id head;
-	int i;
-
-	if (!get_oid_tree("HEAD", &head)) {
-		struct diff_options opt;
-
-		diff_setup(&opt);
-		opt.flags.exit_with_status =3D 1;
-		if (!sb)
-			opt.flags.quick =3D 1;
-		do_diff_cache(&head, &opt);
-		diffcore_std(&opt);
-		for (i =3D 0; sb && i < diff_queued_diff.nr; i++) {
-			if (i)
-				strbuf_addch(sb, ' ');
-			strbuf_addstr(sb, diff_queued_diff.queue[i]->two->path);
-		}
-		diff_flush(&opt);
-		return opt.flags.has_changes !=3D 0;
-	} else {
-		for (i =3D 0; sb && i < active_nr; i++) {
-			if (i)
-				strbuf_addch(sb, ' ');
-			strbuf_addstr(sb, active_cache[i]->name);
-		}
-		return !!active_nr;
-	}
-}
-
 /**
  * Dies with a user-friendly message on how to proceed after resolving t=
he
  * problem. This message can be overridden with state->resolvemsg.
diff --git a/cache.h b/cache.h
index a2ec8c0b55..d8b975a571 100644
--- a/cache.h
+++ b/cache.h
@@ -644,6 +644,15 @@ extern int write_locked_index(struct index_state *, =
struct lock_file *lock, unsi
 extern int discard_index(struct index_state *);
 extern void move_index_extensions(struct index_state *dst, struct index_=
state *src);
 extern int unmerged_index(const struct index_state *);
+
+/**
+ * Returns 1 if the index differs from HEAD, 0 otherwise. When on an unb=
orn
+ * branch, returns 1 if there are entries in the index, 0 otherwise. If =
an
+ * strbuf is provided, the space-separated list of files that differ wil=
l be
+ * appended to it.
+ */
+extern int index_has_changes(struct strbuf *sb);
+
 extern int verify_path(const char *path);
 extern int strcmp_offset(const char *s1, const char *s2, size_t *first_c=
hange);
 extern int index_dir_exists(struct index_state *istate, const char *name=
, int namelen);
diff --git a/merge.c b/merge.c
index e5d796c9f2..195b578700 100644
--- a/merge.c
+++ b/merge.c
@@ -1,4 +1,6 @@
 #include "cache.h"
+#include "diff.h"
+#include "diffcore.h"
 #include "lockfile.h"
 #include "commit.h"
 #include "run-command.h"
@@ -15,6 +17,37 @@ static const char *merge_argument(struct commit *commi=
t)
 		return EMPTY_TREE_SHA1_HEX;
 }
=20
+int index_has_changes(struct strbuf *sb)
+{
+	struct object_id head;
+	int i;
+
+	if (!get_oid_tree("HEAD", &head)) {
+		struct diff_options opt;
+
+		diff_setup(&opt);
+		opt.flags.exit_with_status =3D 1;
+		if (!sb)
+			opt.flags.quick =3D 1;
+		do_diff_cache(&head, &opt);
+		diffcore_std(&opt);
+		for (i =3D 0; sb && i < diff_queued_diff.nr; i++) {
+			if (i)
+				strbuf_addch(sb, ' ');
+			strbuf_addstr(sb, diff_queued_diff.queue[i]->two->path);
+		}
+		diff_flush(&opt);
+		return opt.flags.has_changes !=3D 0;
+	} else {
+		for (i =3D 0; sb && i < active_nr; i++) {
+			if (i)
+				strbuf_addch(sb, ' ');
+			strbuf_addstr(sb, active_cache[i]->name);
+		}
+		return !!active_nr;
+	}
+}
+
 int try_merge_command(const char *strategy, size_t xopts_nr,
 		      const char **xopts, struct commit_list *common,
 		      const char *head_arg, struct commit_list *remotes)
--=20
2.15.1.436.g63a861020b

