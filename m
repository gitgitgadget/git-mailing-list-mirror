Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D15611F404
	for <e@80x24.org>; Fri,  9 Feb 2018 23:14:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753169AbeBIXOx (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Feb 2018 18:14:53 -0500
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:52364 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753073AbeBIXOw (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 9 Feb 2018 18:14:52 -0500
Received: from pps.filterd (m0096528.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w19ND8Ts005046;
        Fri, 9 Feb 2018 15:13:37 -0800
Authentication-Results: palantir.com;
        spf=softfail smtp.mailfrom=newren@gmail.com
Received: from smtp-transport.yojoe.local (mxw3.palantir.com [66.70.54.23] (may be forged))
        by mx0a-00153501.pphosted.com with ESMTP id 2fwaushktj-1;
        Fri, 09 Feb 2018 15:13:37 -0800
Received: from mxw1.palantir.com (new-smtp.yojoe.local [172.19.0.45])
        by smtp-transport.yojoe.local (Postfix) with ESMTP id BB7982244D03;
        Fri,  9 Feb 2018 15:13:30 -0800 (PST)
Received: from newren2-linux.yojoe.local (newren2-linux.dyn.yojoe.local [10.100.68.32])
        by smtp.yojoe.local (Postfix) with ESMTP id B02B52CDEEA;
        Fri,  9 Feb 2018 15:13:30 -0800 (PST)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     pclouds@gmail.com, peff@peff.net, Elijah Newren <newren@gmail.com>
Subject: [RFC PATCH 1/3] fsck: Move fsck_head_link() to get_default_heads() to avoid some globals
Date:   Fri,  9 Feb 2018 15:13:28 -0800
Message-Id: <20180209231330.4457-2-newren@gmail.com>
X-Mailer: git-send-email 2.16.1.75.gc01c8fdd7d
In-Reply-To: <20180209231330.4457-1-newren@gmail.com>
References: <20180209231330.4457-1-newren@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-SPF-Result: softfail
X-Proofpoint-SPF-Record: v=spf1 redirect=_spf.google.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-09_13:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=4 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=868 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1711220000 definitions=main-1802090293
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This will make it easier to check the HEAD of other worktrees from fsck.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/fsck.c | 27 ++++++++++++++++-----------
 1 file changed, 16 insertions(+), 11 deletions(-)

diff --git a/builtin/fsck.c b/builtin/fsck.c
index 04846d46f9..4132034170 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -33,8 +33,6 @@ static int check_strict;
 static int keep_cache_objects;
 static struct fsck_options fsck_walk_options =3D FSCK_OPTIONS_DEFAULT;
 static struct fsck_options fsck_obj_options =3D FSCK_OPTIONS_DEFAULT;
-static struct object_id head_oid;
-static const char *head_points_at;
 static int errors_found;
 static int write_lost_and_found;
 static int verbose;
@@ -453,8 +451,15 @@ static int fsck_handle_ref(const char *refname, cons=
t struct object_id *oid,
 	return 0;
 }
=20
+static int fsck_head_link(const char **head_points_at,
+			  struct object_id *head_oid);
+
 static void get_default_heads(void)
 {
+	const char *head_points_at;
+	struct object_id head_oid;
+
+	fsck_head_link(&head_points_at, &head_oid);
 	if (head_points_at && !is_null_oid(&head_oid))
 		fsck_handle_ref("HEAD", &head_oid, 0, NULL);
 	for_each_rawref(fsck_handle_ref, NULL);
@@ -548,33 +553,34 @@ static void fsck_object_dir(const char *path)
 	stop_progress(&progress);
 }
=20
-static int fsck_head_link(void)
+static int fsck_head_link(const char **head_points_at,
+			  struct object_id *head_oid)
 {
 	int null_is_error =3D 0;
=20
 	if (verbose)
 		fprintf(stderr, "Checking HEAD link\n");
=20
-	head_points_at =3D resolve_ref_unsafe("HEAD", 0, &head_oid, NULL);
-	if (!head_points_at) {
+	*head_points_at =3D resolve_ref_unsafe("HEAD", 0, head_oid, NULL);
+	if (!*head_points_at) {
 		errors_found |=3D ERROR_REFS;
 		return error("Invalid HEAD");
 	}
-	if (!strcmp(head_points_at, "HEAD"))
+	if (!strcmp(*head_points_at, "HEAD"))
 		/* detached HEAD */
 		null_is_error =3D 1;
-	else if (!starts_with(head_points_at, "refs/heads/")) {
+	else if (!starts_with(*head_points_at, "refs/heads/")) {
 		errors_found |=3D ERROR_REFS;
 		return error("HEAD points to something strange (%s)",
-			     head_points_at);
+			     *head_points_at);
 	}
-	if (is_null_oid(&head_oid)) {
+	if (is_null_oid(head_oid)) {
 		if (null_is_error) {
 			errors_found |=3D ERROR_REFS;
 			return error("HEAD: detached HEAD points at nothing");
 		}
 		fprintf(stderr, "notice: HEAD points to an unborn branch (%s)\n",
-			head_points_at + 11);
+			*head_points_at + 11);
 	}
 	return 0;
 }
@@ -686,7 +692,6 @@ int cmd_fsck(int argc, const char **argv, const char =
*prefix)
=20
 	git_config(fsck_config, NULL);
=20
-	fsck_head_link();
 	if (connectivity_only) {
 		for_each_loose_object(mark_loose_for_connectivity, NULL, 0);
 		for_each_packed_object(mark_packed_for_connectivity, NULL, 0);
--=20
2.16.1.75.gc01c8fdd7d

