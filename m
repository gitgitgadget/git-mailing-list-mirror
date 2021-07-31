Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 431B8C4338F
	for <git@archiver.kernel.org>; Sat, 31 Jul 2021 20:37:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C7C160725
	for <git@archiver.kernel.org>; Sat, 31 Jul 2021 20:37:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231739AbhGaUhQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 31 Jul 2021 16:37:16 -0400
Received: from mail-40136.protonmail.ch ([185.70.40.136]:56306 "EHLO
        mail-40136.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231462AbhGaUhP (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 31 Jul 2021 16:37:15 -0400
Date:   Sat, 31 Jul 2021 20:36:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=eagain.st;
        s=protonmail; t=1627763826;
        bh=AsUKO9tmNoY30Bt9xizBWwCSN5mBGQZT5vZO9alNM+4=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=iwlb+mNiFOtK+xI5RLJYQ0+ZNpxwlLPZsZk9Z6Xh7N5H9V0GctOZZwVesuM2WjyXU
         nmuapQU5UAcDAeq6wVEX5uqu1gBDpOUoekG/GOW/DgjJmh1M5zq5RZbeJ7wKgKl3wS
         UYSPDJedfXuNATUeoXQymwialsnxptMJa/TunIN+MmdJjVJ8yilPy+6vphWVJmXwP2
         WTg0KdGmAWkx2v1UJ65Fn6crJZYb/BQoRUK5fShpQeyo8b04x+ixLGCH4Qy564XlFY
         d25FwQpIE2kimGTCaC3XBct0GePn8G8Y2ZO1RBmO3k80uClS8PVfUQeicdUw53IsS3
         rQxLb1VKcAbew==
To:     git@vger.kernel.org
From:   Kim Altintop <kim@eagain.st>
Cc:     Kim Altintop <kim@eagain.st>,
        Brandon Williams <bwilliams.eng@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>
Reply-To: Kim Altintop <kim@eagain.st>
Subject: [PATCH v2] upload-pack.c: treat want-ref relative to namespace
Message-ID: <20210731203415.618641-1-kim@eagain.st>
In-Reply-To: <20210730135845.633234-1-kim@eagain.st>
References: <20210730135845.633234-1-kim@eagain.st>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When 'upload-pack' runs within the context of a git namespace, treat any
'want-ref' lines the client sends as relative to that namespace.

Also check if the wanted ref is hidden via 'hideRefs'. If it is hidden,
respond with an error as if the ref didn't exist.

Signed-off-by: Kim Altintop <kim@eagain.st>
---

Changes from v1:

  * Amend commit message
  * upload-pack.c: fix variable renaming (how could this even work?)
  * upload-pack.c: hide namespace in all output, including die()
  * t5703: don't use subshell in repo setup
  * t5703: use "env" keyword to correctly scope GIT_NAMESPACE


 t/t5703-upload-pack-ref-in-want.sh | 72 ++++++++++++++++++++++++++++++
 upload-pack.c                      | 17 ++++---
 2 files changed, 82 insertions(+), 7 deletions(-)

diff --git a/t/t5703-upload-pack-ref-in-want.sh b/t/t5703-upload-pack-ref-i=
n-want.sh
index e9e471621d..96df3073d1 100755
--- a/t/t5703-upload-pack-ref-in-want.sh
+++ b/t/t5703-upload-pack-ref-in-want.sh
@@ -298,6 +298,78 @@ test_expect_success 'fetching with wildcard that match=
es multiple refs' '
 =09grep "want-ref refs/heads/o/bar" log
 '

+REPO=3D"$(pwd)/repo-ns"
+
+test_expect_success 'setup namespaced repo' '
+=09git init -b main "$REPO" &&
+=09cd "$REPO" &&
+=09test_commit a &&
+=09test_commit b &&
+=09git checkout a &&
+=09test_commit c &&
+=09git checkout a &&
+=09test_commit d &&
+=09git update-ref refs/heads/ns-no b &&
+=09git update-ref refs/namespaces/ns/refs/heads/ns-yes c &&
+=09git update-ref refs/namespaces/ns/refs/heads/hidden d &&
+=09git -C "$REPO" config uploadpack.allowRefInWant true &&
+=09git -C "$REPO" config transfer.hideRefs refs/heads/hidden
+'
+
+test_expect_success 'want-ref with namespaces' '
+=09oid=3D$(git -C "$REPO" rev-parse c) &&
+=09cat >expected_refs <<-EOF &&
+=09$oid refs/heads/ns-yes
+=09EOF
+=09>expected_commits &&
+
+=09oid=3D$(git -C "$REPO" rev-parse c) &&
+=09test-tool pkt-line pack >in <<-EOF &&
+=09$(write_command fetch)
+=090001
+=09no-progress
+=09want-ref refs/heads/ns-yes
+=09have $oid
+=09done
+=090000
+=09EOF
+
+=09env GIT_NAMESPACE=3Dns test-tool -C "$REPO" serve-v2 --stateless-rpc >o=
ut <in &&
+=09check_output
+'
+
+test_expect_success 'want-ref outside namespace' '
+=09oid=3D$(git -C "$REPO" rev-parse c) &&
+=09test-tool pkt-line pack >in <<-EOF &&
+=09$(write_command fetch)
+=090001
+=09no-progress
+=09want-ref refs/heads/ns-no
+=09have $oid
+=09done
+=090000
+=09EOF
+
+=09test_must_fail env GIT_NAMESPACE=3Dns test-tool -C "$REPO" serve-v2 --s=
tateless-rpc >out <in &&
+=09grep "unknown ref" out
+'
+
+test_expect_success 'hideRefs with namespaces' '
+=09oid=3D$(git -C "$REPO" rev-parse c) &&
+=09test-tool pkt-line pack >in <<-EOF &&
+=09$(write_command fetch)
+=090001
+=09no-progress
+=09want-ref refs/heads/hidden
+=09have $oid
+=09done
+=090000
+=09EOF
+
+=09test_must_fail env GIT_NAMESPACE=3Dns test-tool -C "$REPO" serve-v2 --s=
tateless-rpc >out <in &&
+=09grep "unknown ref" out
+'
+
 . "$TEST_DIRECTORY"/lib-httpd.sh
 start_httpd

diff --git a/upload-pack.c b/upload-pack.c
index 297b76fcb4..c897802f1c 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -1417,21 +1417,24 @@ static int parse_want_ref(struct packet_writer *wri=
ter, const char *line,
 =09=09=09  struct string_list *wanted_refs,
 =09=09=09  struct object_array *want_obj)
 {
-=09const char *arg;
-=09if (skip_prefix(line, "want-ref ", &arg)) {
+=09const char *refname_nons;
+=09if (skip_prefix(line, "want-ref ", &refname_nons)) {
 =09=09struct object_id oid;
 =09=09struct string_list_item *item;
 =09=09struct object *o;
+=09=09struct strbuf refname =3D STRBUF_INIT;

-=09=09if (read_ref(arg, &oid)) {
-=09=09=09packet_writer_error(writer, "unknown ref %s", arg);
-=09=09=09die("unknown ref %s", arg);
+=09=09strbuf_addf(&refname, "%s%s", get_git_namespace(), refname_nons);
+=09=09if (ref_is_hidden(refname_nons, refname.buf) ||
+=09=09    read_ref(refname.buf, &oid)) {
+=09=09=09packet_writer_error(writer, "unknown ref %s", refname_nons);
+=09=09=09die("unknown ref %s", refname_nons);
 =09=09}

-=09=09item =3D string_list_append(wanted_refs, arg);
+=09=09item =3D string_list_append(wanted_refs, refname_nons);
 =09=09item->util =3D oiddup(&oid);

-=09=09o =3D parse_object_or_die(&oid, arg);
+=09=09o =3D parse_object_or_die(&oid, refname_nons);
 =09=09if (!(o->flags & WANTED)) {
 =09=09=09o->flags |=3D WANTED;
 =09=09=09add_object_array(o, NULL, want_obj);
--
2.32.0


