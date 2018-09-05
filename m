Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 185D71F404
	for <e@80x24.org>; Wed,  5 Sep 2018 17:25:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727738AbeIEV5E (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Sep 2018 17:57:04 -0400
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:50172 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727267AbeIEV5D (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 5 Sep 2018 17:57:03 -0400
Received: from pps.filterd (m0096528.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w85HMp7f029154;
        Wed, 5 Sep 2018 10:25:52 -0700
Authentication-Results: palantir.com;
        spf=softfail smtp.mailfrom=newren@gmail.com
Received: from smtp-transport.yojoe.local (mxw3.palantir.com [66.70.54.23] (may be forged))
        by mx0a-00153501.pphosted.com with ESMTP id 2m7qnmqebj-1;
        Wed, 05 Sep 2018 10:25:52 -0700
Received: from mxw1.palantir.com (new-smtp.yojoe.local [172.19.0.45])
        by smtp-transport.yojoe.local (Postfix) with ESMTP id 4152422E02A2;
        Wed,  5 Sep 2018 10:25:52 -0700 (PDT)
Received: from newren2-linux.yojoe.local (newren2-linux.pa.palantir.tech [10.100.71.66])
        by smtp.yojoe.local (Postfix) with ESMTP id 39C8F2CDEA7;
        Wed,  5 Sep 2018 10:25:52 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     brad.king@kitware.com, Elijah Newren <newren@gmail.com>
Subject: [PATCH 2/2] update-ref: allow --no-deref with --stdin
Date:   Wed,  5 Sep 2018 10:25:50 -0700
Message-Id: <20180905172550.11621-3-newren@gmail.com>
X-Mailer: git-send-email 2.19.0.rc2
In-Reply-To: <20180905172550.11621-1-newren@gmail.com>
References: <20180905172550.11621-1-newren@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-SPF-Result: softfail
X-Proofpoint-SPF-Record: v=spf1 redirect=_spf.google.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-05_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=13 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1809050174
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If passed both --no-deref and --stdin, update-ref would error out with a
general usage message that did not at all suggest these options were
incompatible.  The manpage for update-ref did suggest through its
synopsis line that --no-deref and --stdin were incompatible, but it sadly
also incorrectly suggested that -d and --no-deref were incompatible.  So
the help around the --no-deref option is buggy in a few ways.

The --stdin option did provide a different mechanism for avoiding
dereferencing symbolic-refs: adding a line reading
  option no-deref
before every other directive in the input.  (Technically, if the user
wants to do the extra work of first determining which refs they want to
update or delete are symbolic, then they only need to put the extra
"option no-deref" lines before the updates of those refs.  But in some
cases, that's more work than just adding the "option no-deref" before
every other directive.)

It's easier to allow the user to just pass --no-deref along with --stdin
in order to tell update-ref that the user doesn't want any symbolic ref
to be dereferenced.  It also makes the update-ref documentation simpler.
Implement that, and update the documentation to match.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 Documentation/git-update-ref.txt |  2 +-
 builtin/update-ref.c             | 23 +++++++++++++----------
 t/t1400-update-ref.sh            | 31 +++++++++++++++++++++++++++++++
 3 files changed, 45 insertions(+), 11 deletions(-)

diff --git a/Documentation/git-update-ref.txt b/Documentation/git-update-=
ref.txt
index bc8fdfd469..fda8516677 100644
--- a/Documentation/git-update-ref.txt
+++ b/Documentation/git-update-ref.txt
@@ -8,7 +8,7 @@ git-update-ref - Update the object name stored in a ref s=
afely
 SYNOPSIS
 --------
 [verse]
-'git update-ref' [-m <reason>] (-d <ref> [<oldvalue>] | [--no-deref] [--=
create-reflog] <ref> <newvalue> [<oldvalue>] | --stdin [-z])
+'git update-ref' [-m <reason>] [--no-deref] (-d <ref> [<oldvalue>] | [--=
create-reflog] <ref> <newvalue> [<oldvalue>] | --stdin [-z])
=20
 DESCRIPTION
 -----------
diff --git a/builtin/update-ref.c b/builtin/update-ref.c
index 54fac01f21..2d8f7f0578 100644
--- a/builtin/update-ref.c
+++ b/builtin/update-ref.c
@@ -15,6 +15,7 @@ static const char * const git_update_ref_usage[] =3D {
=20
 static char line_termination =3D '\n';
 static unsigned int update_flags;
+static unsigned int default_flags;
 static unsigned create_reflog_flag;
 static const char *msg;
=20
@@ -205,7 +206,7 @@ static const char *parse_cmd_update(struct ref_transa=
ction *transaction,
 				   msg, &err))
 		die("%s", err.buf);
=20
-	update_flags =3D 0;
+	update_flags =3D default_flags;
 	free(refname);
 	strbuf_release(&err);
=20
@@ -237,7 +238,7 @@ static const char *parse_cmd_create(struct ref_transa=
ction *transaction,
 				   msg, &err))
 		die("%s", err.buf);
=20
-	update_flags =3D 0;
+	update_flags =3D default_flags;
 	free(refname);
 	strbuf_release(&err);
=20
@@ -273,7 +274,7 @@ static const char *parse_cmd_delete(struct ref_transa=
ction *transaction,
 				   update_flags, msg, &err))
 		die("%s", err.buf);
=20
-	update_flags =3D 0;
+	update_flags =3D default_flags;
 	free(refname);
 	strbuf_release(&err);
=20
@@ -302,7 +303,7 @@ static const char *parse_cmd_verify(struct ref_transa=
ction *transaction,
 				   update_flags, &err))
 		die("%s", err.buf);
=20
-	update_flags =3D 0;
+	update_flags =3D default_flags;
 	free(refname);
 	strbuf_release(&err);
=20
@@ -357,7 +358,6 @@ int cmd_update_ref(int argc, const char **argv, const=
 char *prefix)
 	const char *refname, *oldval;
 	struct object_id oid, oldoid;
 	int delete =3D 0, no_deref =3D 0, read_stdin =3D 0, end_null =3D 0;
-	unsigned int flags =3D 0;
 	int create_reflog =3D 0;
 	struct option options[] =3D {
 		OPT_STRING( 'm', NULL, &msg, N_("reason"), N_("reason of the update"))=
,
@@ -378,6 +378,11 @@ int cmd_update_ref(int argc, const char **argv, cons=
t char *prefix)
=20
 	create_reflog_flag =3D create_reflog ? REF_FORCE_CREATE_REFLOG : 0;
=20
+	if (no_deref) {
+		default_flags =3D REF_NO_DEREF;
+		update_flags =3D default_flags;
+	}
+
 	if (read_stdin) {
 		struct strbuf err =3D STRBUF_INIT;
 		struct ref_transaction *transaction;
@@ -385,7 +390,7 @@ int cmd_update_ref(int argc, const char **argv, const=
 char *prefix)
 		transaction =3D ref_transaction_begin(&err);
 		if (!transaction)
 			die("%s", err.buf);
-		if (delete || no_deref || argc > 0)
+		if (delete || argc > 0)
 			usage_with_options(git_update_ref_usage, options);
 		if (end_null)
 			line_termination =3D '\0';
@@ -427,8 +432,6 @@ int cmd_update_ref(int argc, const char **argv, const=
 char *prefix)
 			die("%s: not a valid old SHA1", oldval);
 	}
=20
-	if (no_deref)
-		flags =3D REF_NO_DEREF;
 	if (delete)
 		/*
 		 * For purposes of backwards compatibility, we treat
@@ -436,9 +439,9 @@ int cmd_update_ref(int argc, const char **argv, const=
 char *prefix)
 		 */
 		return delete_ref(msg, refname,
 				  (oldval && !is_null_oid(&oldoid)) ? &oldoid : NULL,
-				  flags);
+				  default_flags);
 	else
 		return update_ref(msg, refname, &oid, oldval ? &oldoid : NULL,
-				  flags | create_reflog_flag,
+				  default_flags | create_reflog_flag,
 				  UPDATE_REFS_DIE_ON_ERR);
 }
diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
index 7c8df20955..02493f14ba 100755
--- a/t/t1400-update-ref.sh
+++ b/t/t1400-update-ref.sh
@@ -807,6 +807,37 @@ test_expect_success 'stdin delete symref works optio=
n no-deref' '
 	test_cmp expect actual
 '
=20
+test_expect_success 'stdin update symref works flag --no-deref' '
+	git symbolic-ref TESTSYMREFONE $b &&
+	git symbolic-ref TESTSYMREFTWO $b &&
+	cat >stdin <<-EOF &&
+	update TESTSYMREFONE $a $b
+	update TESTSYMREFTWO $a $b
+	EOF
+	git update-ref --no-deref --stdin <stdin &&
+	git rev-parse TESTSYMREFONE TESTSYMREFTWO >expect &&
+	git rev-parse $a $a >actual &&
+	test_cmp expect actual &&
+	git rev-parse $m~1 >expect &&
+	git rev-parse $b >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'stdin delete symref works flag --no-deref' '
+	git symbolic-ref TESTSYMREFONE $b &&
+	git symbolic-ref TESTSYMREFTWO $b &&
+	cat >stdin <<-EOF &&
+	delete TESTSYMREFONE $b
+	delete TESTSYMREFTWO $b
+	EOF
+	git update-ref --no-deref --stdin <stdin &&
+	test_must_fail git rev-parse --verify -q TESTSYMREFONE &&
+	test_must_fail git rev-parse --verify -q TESTSYMREFTWO &&
+	git rev-parse $m~1 >expect &&
+	git rev-parse $b >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'stdin delete ref works with right old value' '
 	echo "delete $b $m~1" >stdin &&
 	git update-ref --stdin <stdin &&
--=20
2.19.0.rc2.2.g1aedc61e22

