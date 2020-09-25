Return-Path: <SRS0=RFRG=DC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1CE4C4363D
	for <git@archiver.kernel.org>; Fri, 25 Sep 2020 06:09:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 629A822211
	for <git@archiver.kernel.org>; Fri, 25 Sep 2020 06:09:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="RT13rY92"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727241AbgIYGJJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Sep 2020 02:09:09 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:56271 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727110AbgIYGJJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Sep 2020 02:09:09 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B5CB7EE035;
        Fri, 25 Sep 2020 02:00:03 -0400 (EDT)
        (envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; s=sasl; bh=7eYxThBb0UYhR8hj4xoFEsWA1
        oc=; b=RT13rY92wkImOEVRuqoaxXEj4cBme08rVZf+jHPEdXHhJXOTJzLkHYNMW
        NV6vwxyBHc9cE+O7mogdxv4V+UmT7aL+d4t9OqEGhfeZzNhF+7x3pp37lqGhIERX
        Nfk0sWriR7XqdOBtDTBHdGRsNCllJVIPZAg1EPKY+oh0gFWT60=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
        :date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; q=dns; s=sasl; b=QBN0aL7R236Vtnbr3yM
        rdjlnEPQEl77dimfiLfkQ5l/gzyaJVwmXi/t2b05mNHBNW1Us8JlZWeyzyEgwNsN
        WfP7O70Fd6lY/oSGWCcwS+VIJDbUcBoTD2jmWIZWmAbUy/ailLe9nOza7qitSyaM
        BfK41hn4BVYet/A0GVX8lbl4=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id AECF1EE031;
        Fri, 25 Sep 2020 02:00:03 -0400 (EDT)
        (envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id C203DEE020;
        Fri, 25 Sep 2020 02:00:00 -0400 (EDT)
        (envelope-from gitster@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [PATCH 2/4] blame: validate and peel the object names on the ignore list
Date:   Thu, 24 Sep 2020 22:59:52 -0700
Message-Id: <20200925055954.1111389-3-gitster@pobox.com>
X-Mailer: git-send-email 2.28.0-718-gd8d5e3da39
In-Reply-To: <20200925055954.1111389-1-gitster@pobox.com>
References: <20200925055954.1111389-1-gitster@pobox.com>
MIME-Version: 1.0
X-Pobox-Relay-ID: 591270F8-FEF4-11EA-BB79-843F439F7C89-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The command reads list of object names to place on the ignore list
either from the command line or from a file, but they are not
checked with their object type (those read from the file are not
even checked for object existence).

Extend the oidset_parse_file() API and allow it to take a callback
that can be used to die (e.g. when an inappropriate input is read)
or modify the object name read (e.g. when a tag pointing at a commit
is read, and the caller wants a commit object name), and use it in
the code that handles ignore list.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/blame.c              | 27 ++++++++++++++++++++++++--
 oidset.c                     |  9 ++++++++-
 oidset.h                     |  9 +++++++++
 t/t8013-blame-ignore-revs.sh | 37 ++++++++++++++++++++++++++----------
 4 files changed, 69 insertions(+), 13 deletions(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index 94ef57c1cc..baa5d979cc 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -27,6 +27,7 @@
 #include "object-store.h"
 #include "blame.h"
 #include "refs.h"
+#include "tag.h"
=20
 static char blame_usage[] =3D N_("git blame [<options>] [<rev-opts>] [<r=
ev>] [--] <file>");
=20
@@ -803,6 +804,26 @@ static int is_a_rev(const char *name)
 	return OBJ_NONE < oid_object_info(the_repository, &oid, NULL);
 }
=20
+static int peel_to_commit_oid(struct object_id *oid_ret, void *cbdata)
+{
+	struct repository *r =3D ((struct blame_scoreboard *)cbdata)->repo;
+	struct object_id oid;
+
+	oidcpy(&oid, oid_ret);
+	while (1) {
+		struct object *obj;
+		int kind =3D oid_object_info(r, &oid, NULL);
+		if (kind =3D=3D OBJ_COMMIT) {
+			oidcpy(oid_ret, &oid);
+			return 0;
+		}
+		if (kind !=3D OBJ_TAG)
+			return -1;
+		obj =3D deref_tag(r, parse_object(r, &oid), NULL, 0);
+		oidcpy(&oid, &obj->oid);
+	}
+}
+
 static void build_ignorelist(struct blame_scoreboard *sb,
 			     struct string_list *ignore_revs_file_list,
 			     struct string_list *ignore_rev_list)
@@ -815,10 +836,12 @@ static void build_ignorelist(struct blame_scoreboar=
d *sb,
 		if (!strcmp(i->string, ""))
 			oidset_clear(&sb->ignore_list);
 		else
-			oidset_parse_file(&sb->ignore_list, i->string);
+			oidset_parse_file_carefully(&sb->ignore_list, i->string,
+						    peel_to_commit_oid, sb);
 	}
 	for_each_string_list_item(i, ignore_rev_list) {
-		if (get_oid_committish(i->string, &oid))
+		if (get_oid_committish(i->string, &oid) ||
+		    peel_to_commit_oid(&oid, sb))
 			die(_("cannot find revision %s to ignore"), i->string);
 		oidset_insert(&sb->ignore_list, &oid);
 	}
diff --git a/oidset.c b/oidset.c
index 15d4e18c37..2d0ab76fb5 100644
--- a/oidset.c
+++ b/oidset.c
@@ -42,6 +42,12 @@ int oidset_size(struct oidset *set)
 }
=20
 void oidset_parse_file(struct oidset *set, const char *path)
+{
+	oidset_parse_file_carefully(set, path, NULL, NULL);
+}
+
+void oidset_parse_file_carefully(struct oidset *set, const char *path,
+				 oidset_parse_tweak_fn fn, void *cbdata)
 {
 	FILE *fp;
 	struct strbuf sb =3D STRBUF_INIT;
@@ -66,7 +72,8 @@ void oidset_parse_file(struct oidset *set, const char *=
path)
 		if (!sb.len)
 			continue;
=20
-		if (parse_oid_hex(sb.buf, &oid, &p) || *p !=3D '\0')
+		if (parse_oid_hex(sb.buf, &oid, &p) || *p !=3D '\0' ||
+		    (fn && fn(&oid, cbdata)))
 			die("invalid object name: %s", sb.buf);
 		oidset_insert(set, &oid);
 	}
diff --git a/oidset.h b/oidset.h
index 209ae7a173..01f6560283 100644
--- a/oidset.h
+++ b/oidset.h
@@ -73,6 +73,15 @@ void oidset_clear(struct oidset *set);
  */
 void oidset_parse_file(struct oidset *set, const char *path);
=20
+/*
+ * Similar to the above, but with a callback which can (1) return non-ze=
ro to
+ * signal displeasure with the object and (2) replace object ID with som=
ething
+ * else (meant to be used to "peel").
+ */
+typedef int (*oidset_parse_tweak_fn)(struct object_id *, void *);
+void oidset_parse_file_carefully(struct oidset *set, const char *path,
+				 oidset_parse_tweak_fn fn, void *cbdata);
+
 struct oidset_iter {
 	kh_oid_set_t *set;
 	khiter_t iter;
diff --git a/t/t8013-blame-ignore-revs.sh b/t/t8013-blame-ignore-revs.sh
index 67de83ae2b..24ae5018e8 100755
--- a/t/t8013-blame-ignore-revs.sh
+++ b/t/t8013-blame-ignore-revs.sh
@@ -21,6 +21,7 @@ test_expect_success setup '
 	test_tick &&
 	git commit -m X &&
 	git tag X &&
+	git tag -a -m "X (annotated)" XT &&
=20
 	git blame --line-porcelain file >blame_raw &&
=20
@@ -33,19 +34,35 @@ test_expect_success setup '
 	test_cmp expect actual
 '
=20
-# Ignore X, make sure A is blamed for line 1 and B for line 2.
-test_expect_success ignore_rev_changing_lines '
-	git blame --line-porcelain --ignore-rev X file >blame_raw &&
-
-	grep -E "^[0-9a-f]+ [0-9]+ 1" blame_raw | sed -e "s/ .*//" >actual &&
-	git rev-parse A >expect &&
-	test_cmp expect actual &&
+# Ensure bogus --ignore-rev requests are caught
+test_expect_success 'validate --ignore-rev' '
+	test_must_fail git blame --ignore-rev X^{tree} file
+'
=20
-	grep -E "^[0-9a-f]+ [0-9]+ 2" blame_raw | sed -e "s/ .*//" >actual &&
-	git rev-parse B >expect &&
-	test_cmp expect actual
+# Ensure bogus --ignore-revs-file requests are caught
+test_expect_success 'validate --ignore-revs-file' '
+	git rev-parse X^{tree} >ignore_x &&
+	test_must_fail git blame --ignore-revs-file ignore_x file
 '
=20
+for I in X XT
+do
+	# Ignore X (or XT), make sure A is blamed for line 1 and B for line 2.
+	# Giving X (i.e. commit) and XT (i.e. annotated tag to commit) should
+	# produce the same result.
+	test_expect_success "ignore_rev_changing_lines ($I)" '
+		git blame --line-porcelain --ignore-rev $I file >blame_raw &&
+
+		grep -E "^[0-9a-f]+ [0-9]+ 1" blame_raw | sed -e "s/ .*//" >actual &&
+		git rev-parse A >expect &&
+		test_cmp expect actual &&
+
+		grep -E "^[0-9a-f]+ [0-9]+ 2" blame_raw | sed -e "s/ .*//" >actual &&
+		git rev-parse B >expect &&
+		test_cmp expect actual
+	'
+done
+
 # For ignored revs that have added 'unblamable' lines, attribute those t=
o the
 # ignored commit.
 # 	A--B--X--Y
--=20
2.28.0-718-gd8d5e3da39

