Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1DA9C4338F
	for <git@archiver.kernel.org>; Fri, 13 Aug 2021 06:24:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7BF68610A5
	for <git@archiver.kernel.org>; Fri, 13 Aug 2021 06:24:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238831AbhHMGY0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Aug 2021 02:24:26 -0400
Received: from mail-40134.protonmail.ch ([185.70.40.134]:56750 "EHLO
        mail-40134.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234011AbhHMGYZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Aug 2021 02:24:25 -0400
Date:   Fri, 13 Aug 2021 06:23:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=eagain.st;
        s=protonmail; t=1628835837;
        bh=2i8rnjkud9KRTipT2pvgN5lT8p91Gw75pk2ulRDLpUg=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=g7LYCH6Q84gAgr6D/bFue2OLEV6UM2TNDQX4+WYEifx6JDWVqiIG3/wgSTXhagqU9
         +fsRA2DudT4WXBWx/Yg2ZQB6T9zI1LowS1DMkz9wPKv8Ed+yn1burKLX7KjPUkObR9
         /bK/UlTaPepBFdwYq8WQ43ZL5SGcVuyC6BfAtr2GTtvW6mwKi0YaErT84X47TDoOqN
         zk8IHbGpYwvAEwUBNEsLFDcuC06yRAz1QYUwTHbRZttFcwF/qyjtjcYz9ALF9Vlybx
         n6foOxFwq3Hka3GCfUS2DZbt2DM8ZDAgzvNNttlPCmtLM2Qg+LrMnQuWKG7alvCYWp
         WJ/S37g97Y20A==
To:     git@vger.kernel.org
From:   Kim Altintop <kim@eagain.st>
Cc:     kim@eagain.st, gitster@pobox.com, jonathantanmy@google.com,
        bwilliams.eng@gmail.com, johannes.schindelin@gmx.de,
        jrnieder@gmail.com, sunshine@sunshineco.com
Reply-To: Kim Altintop <kim@eagain.st>
Subject: [PATCH v6 2/3] upload-pack.c: treat want-ref relative to namespace
Message-ID: <20210813062237.10403-3-kim@eagain.st>
In-Reply-To: <20210809175530.75326-1-kim@eagain.st>
References: <20210730135845.633234-1-kim@eagain.st> <20210731203415.618641-1-kim@eagain.st> <20210804203829.661565-1-kim@eagain.st> <20210804205951.668140-1-kim@eagain.st> <20210809175530.75326-1-kim@eagain.st>
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

Helped-by: Jonathan Tan <jonathantanmy@google.com>
Signed-off-by: Kim Altintop <kim@eagain.st>
---
 t/t5703-upload-pack-ref-in-want.sh | 135 +++++++++++++++++++++++++++++
 upload-pack.c                      |  18 ++--
 2 files changed, 146 insertions(+), 7 deletions(-)

diff --git a/t/t5703-upload-pack-ref-in-want.sh b/t/t5703-upload-pack-ref-i=
n-want.sh
index 3dad21ff45..220098523a 100755
--- a/t/t5703-upload-pack-ref-in-want.sh
+++ b/t/t5703-upload-pack-ref-in-want.sh
@@ -299,6 +299,141 @@ test_expect_success 'fetching with wildcard that matc=
hes multiple refs' '
 =09grep "want-ref refs/heads/o/bar" log
 '

+REPO=3D"$(pwd)/repo-ns"
+
+test_expect_success 'setup namespaced repo' '
+=09(
+=09=09git init -b main "$REPO" &&
+=09=09cd "$REPO" &&
+=09=09test_commit a &&
+=09=09test_commit b &&
+=09=09git checkout a &&
+=09=09test_commit c &&
+=09=09git checkout a &&
+=09=09test_commit d &&
+=09=09git update-ref refs/heads/ns-no b &&
+=09=09git update-ref refs/namespaces/ns/refs/heads/ns-yes c &&
+=09=09git update-ref refs/namespaces/ns/refs/heads/hidden d
+=09) &&
+=09git -C "$REPO" config uploadpack.allowRefInWant true
+'
+
+test_expect_success 'with namespace: want-ref is considered relative to na=
mespace' '
+=09wanted_ref=3Drefs/heads/ns-yes &&
+
+=09oid=3D$(git -C "$REPO" rev-parse "refs/namespaces/ns/$wanted_ref") &&
+=09cat >expected_refs <<-EOF &&
+=09$oid $wanted_ref
+=09EOF
+=09cat >expected_commits <<-EOF &&
+=09$oid
+=09$(git -C "$REPO" rev-parse a)
+=09EOF
+
+=09write_fetch_command >pkt <<-EOF &&
+=09want-ref $wanted_ref
+=09EOF
+=09test-tool pkt-line pack <pkt >in &&
+
+=09GIT_NAMESPACE=3Dns test-tool -C "$REPO" serve-v2 --stateless-rpc >out <=
in &&
+=09check_output
+'
+
+test_expect_success 'with namespace: want-ref outside namespace is unknown=
' '
+=09wanted_ref=3Drefs/heads/ns-no &&
+
+=09write_fetch_command >pkt <<-EOF &&
+=09want-ref $wanted_ref
+=09EOF
+=09test-tool pkt-line pack <pkt >in &&
+
+=09test_must_fail env GIT_NAMESPACE=3Dns \
+=09=09test-tool -C "$REPO" serve-v2 --stateless-rpc >out <in &&
+=09grep "unknown ref" out
+'
+
+# Cross-check refs/heads/ns-no indeed exists
+test_expect_success 'without namespace: want-ref outside namespace succeed=
s' '
+=09wanted_ref=3Drefs/heads/ns-no &&
+
+=09oid=3D$(git -C "$REPO" rev-parse $wanted_ref) &&
+=09cat >expected_refs <<-EOF &&
+=09$oid $wanted_ref
+=09EOF
+=09cat >expected_commits <<-EOF &&
+=09$oid
+=09$(git -C "$REPO" rev-parse a)
+=09EOF
+
+=09write_fetch_command >pkt <<-EOF &&
+=09want-ref $wanted_ref
+=09EOF
+=09test-tool pkt-line pack <pkt >in &&
+
+=09test-tool -C "$REPO" serve-v2 --stateless-rpc >out <in &&
+=09check_output
+'
+
+test_expect_success 'with namespace: hideRefs is matched, relative to name=
space' '
+=09wanted_ref=3Drefs/heads/hidden &&
+=09git -C "$REPO" config transfer.hideRefs $wanted_ref &&
+
+=09write_fetch_command >pkt <<-EOF &&
+=09want-ref $wanted_ref
+=09EOF
+=09test-tool pkt-line pack <pkt >in &&
+
+=09test_must_fail env GIT_NAMESPACE=3Dns \
+=09=09test-tool -C "$REPO" serve-v2 --stateless-rpc >out <in &&
+=09grep "unknown ref" out
+'
+
+# Cross-check refs/heads/hidden indeed exists
+test_expect_success 'with namespace: want-ref succeeds if hideRefs is remo=
ved' '
+=09wanted_ref=3Drefs/heads/hidden &&
+=09git -C "$REPO" config --unset transfer.hideRefs $wanted_ref &&
+
+=09oid=3D$(git -C "$REPO" rev-parse "refs/namespaces/ns/$wanted_ref") &&
+=09cat >expected_refs <<-EOF &&
+=09$oid $wanted_ref
+=09EOF
+=09cat >expected_commits <<-EOF &&
+=09$oid
+=09$(git -C "$REPO" rev-parse a)
+=09EOF
+
+=09write_fetch_command >pkt <<-EOF &&
+=09want-ref $wanted_ref
+=09EOF
+=09test-tool pkt-line pack <pkt >in &&
+
+=09GIT_NAMESPACE=3Dns test-tool -C "$REPO" serve-v2 --stateless-rpc >out <=
in &&
+=09check_output
+'
+
+test_expect_success 'without namespace: relative hideRefs does not match' =
'
+=09wanted_ref=3Drefs/namespaces/ns/refs/heads/hidden &&
+=09git -C "$REPO" config transfer.hideRefs refs/heads/hidden &&
+
+=09oid=3D$(git -C "$REPO" rev-parse $wanted_ref) &&
+=09cat >expected_refs <<-EOF &&
+=09$oid $wanted_ref
+=09EOF
+=09cat >expected_commits <<-EOF &&
+=09$oid
+=09$(git -C "$REPO" rev-parse a)
+=09EOF
+
+=09write_fetch_command >pkt <<-EOF &&
+=09want-ref $wanted_ref
+=09EOF
+=09test-tool pkt-line pack <pkt >in &&
+
+=09test-tool -C "$REPO" serve-v2 --stateless-rpc >out <in &&
+=09check_output
+'
+
+
 . "$TEST_DIRECTORY"/lib-httpd.sh
 start_httpd

diff --git a/upload-pack.c b/upload-pack.c
index 297b76fcb4..6ce07231d3 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -1417,21 +1417,25 @@ static int parse_want_ref(struct packet_writer *wri=
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
+=09=09strbuf_release(&refname);

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


