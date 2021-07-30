Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86DC8C4338F
	for <git@archiver.kernel.org>; Fri, 30 Jul 2021 13:59:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6FDC660F5E
	for <git@archiver.kernel.org>; Fri, 30 Jul 2021 13:59:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239030AbhG3N7a (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Jul 2021 09:59:30 -0400
Received: from mail-0201.mail-europe.com ([51.77.79.158]:42804 "EHLO
        mail-0201.mail-europe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238961AbhG3N73 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Jul 2021 09:59:29 -0400
Date:   Fri, 30 Jul 2021 13:59:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=eagain.st;
        s=protonmail; t=1627653561;
        bh=KntvmRWqcuiIMQJAf6E9/WbsS21yswxheAIDfSSDq3U=;
        h=Date:To:From:Cc:Reply-To:Subject:From;
        b=wJ/RKH24we+jw2V2NjjVKSLzH9/TnyC3L9k6ZZpzTPHuVsLiVWVo0Il1KEK+SvGdc
         D37Xd14Rk7KxZUsoKW8qWQlSMBmNZze63qZXtc03jXW2q6xYKYsN0X61tsGtd9ShLQ
         NWOxOqXLzrADpK3v+DwXsjof2S9WtoJP3N5obH37iOPH2pQeH9g/fYIukIEXz35nKy
         Bn4h+avqnBsbq7JLA9tere5YXnquz6jW22dB1BF/xZl/hm9p38Kt81TjI/yoF1w/za
         OSef3SixiFJ7mv8jmFVwuD0pRup/tW747jS3wqb51hopEgCDtul7E18K7rueqC7wtG
         3A2vZA7EbWzjg==
To:     git@vger.kernel.org
From:   Kim Altintop <kim@eagain.st>
Cc:     Kim Altintop <kim@eagain.st>,
        Brandon Williams <bwilliams.eng@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>
Reply-To: Kim Altintop <kim@eagain.st>
Subject: [PATCH] upload-pack.c: treat want-ref relative to namespace
Message-ID: <20210730135845.633234-1-kim@eagain.st>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When 'upload-pack' runs within the context of a git namespace, treat any
'want-ref' lines the client sends as relative to that namespace.

Also check if the wanted ref is hidden via 'hideRefs', and respond with
an error otherwise. It was previously possible to request any ref, but
note that this is still the case unless 'hideRefs' is in effect.

Signed-off-by: Kim Altintop <kim@eagain.st>
---

Please excuse my newbie ness.

 t/t5703-upload-pack-ref-in-want.sh | 77 ++++++++++++++++++++++++++++++
 upload-pack.c                      | 15 +++---
 2 files changed, 86 insertions(+), 6 deletions(-)

diff --git a/t/t5703-upload-pack-ref-in-want.sh b/t/t5703-upload-pack-ref-i=
n-want.sh
index e9e471621d..9fb16848bc 100755
--- a/t/t5703-upload-pack-ref-in-want.sh
+++ b/t/t5703-upload-pack-ref-in-want.sh
@@ -298,6 +298,83 @@ test_expect_success 'fetching with wildcard that match=
es multiple refs' '
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
+    git -C "$REPO" config uploadpack.allowRefInWant true &&
+    git -C "$REPO" config transfer.hideRefs refs/heads/hidden
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
+=09GIT_NAMESPACE=3Dns && export GIT_NAMESPACE &&
+=09test-tool -C "$REPO" serve-v2 --stateless-rpc >out <in &&
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
+=09GIT_NAMESPACE=3Dns && export GIT_NAMESPACE &&
+=09test_must_fail test-tool -C "$REPO" serve-v2 --stateless-rpc >out <in &=
&
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
+=09GIT_NAMESPACE=3Dns && export GIT_NAMESPACE &&
+=09test_must_fail test-tool -C "$REPO" serve-v2 --stateless-rpc >out <in &=
&
+=09grep "unknown ref" out
+'
+
 . "$TEST_DIRECTORY"/lib-httpd.sh
 start_httpd

diff --git a/upload-pack.c b/upload-pack.c
index 297b76fcb4..008ac75125 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -1417,21 +1417,24 @@ static int parse_want_ref(struct packet_writer *wri=
ter, const char *line,
 =09=09=09  struct string_list *wanted_refs,
 =09=09=09  struct object_array *want_obj)
 {
-=09const char *arg;
+=09const char *refname_nons;
 =09if (skip_prefix(line, "want-ref ", &arg)) {
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
+=09=09=09die("unknown ref %s", refname.buf);
 =09=09}

-=09=09item =3D string_list_append(wanted_refs, arg);
+=09=09item =3D string_list_append(wanted_refs, refname_nons);
 =09=09item->util =3D oiddup(&oid);

-=09=09o =3D parse_object_or_die(&oid, arg);
+=09=09o =3D parse_object_or_die(&oid, refname);
 =09=09if (!(o->flags & WANTED)) {
 =09=09=09o->flags |=3D WANTED;
 =09=09=09add_object_array(o, NULL, want_obj);
--
2.32.0


