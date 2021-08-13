Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B680C4338F
	for <git@archiver.kernel.org>; Fri, 13 Aug 2021 06:23:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 47637610A5
	for <git@archiver.kernel.org>; Fri, 13 Aug 2021 06:23:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238829AbhHMGYS (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Aug 2021 02:24:18 -0400
Received: from mail-0201.mail-europe.com ([51.77.79.158]:52997 "EHLO
        mail-0201.mail-europe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234011AbhHMGYS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Aug 2021 02:24:18 -0400
Date:   Fri, 13 Aug 2021 06:23:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=eagain.st;
        s=protonmail; t=1628835827;
        bh=SGLVxudw4mIZR1ySD9LgTq0McxoQoT7NPg4vzvDQqTI=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=mnkNnqkmiIzGVgSeg2357VwjQM5w1eZ32jbF2NctgZVWhrEOFJTmQolLVRcnhC5dQ
         2PdqxEHVTEUnM2gi02lU9eM5I90w5yN8OHG6AyBaiGrz+tEejlJ66C+fvzL+ycQuzC
         5zKCTrag4D02N3Y7i9Zphbo38YFA2I1SQTPSTUMomDcY3PlXPQg7bLwXIeIUDMlk3f
         5I3XYnFbvPgtDi/FXHyx0JWw/ZTInRAYMfwngALnisIu922Ym+93QnsZKSEZfC6OA+
         MZrv8n8SYLKyILpoawVv8+mOHj5L7X8QrWeu3NFanRjV7Uz6oJJJSPTI+D4ZJWecJF
         HOYzguBi1RBqQ==
To:     git@vger.kernel.org
From:   Kim Altintop <kim@eagain.st>
Cc:     kim@eagain.st, gitster@pobox.com, jonathantanmy@google.com,
        bwilliams.eng@gmail.com, johannes.schindelin@gmx.de,
        jrnieder@gmail.com, sunshine@sunshineco.com
Reply-To: Kim Altintop <kim@eagain.st>
Subject: [PATCH v6 1/3] t5730: introduce fetch command helper
Message-ID: <20210813062237.10403-2-kim@eagain.st>
In-Reply-To: <20210809175530.75326-1-kim@eagain.st>
References: <20210730135845.633234-1-kim@eagain.st> <20210731203415.618641-1-kim@eagain.st> <20210804203829.661565-1-kim@eagain.st> <20210804205951.668140-1-kim@eagain.st> <20210809175530.75326-1-kim@eagain.st>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Assembling a "raw" fetch command to be fed directly to "test-tool serve-v2"
is extracted into a test helper.

Suggested-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Kim Altintop <kim@eagain.st>
---
 t/t5703-upload-pack-ref-in-want.sh | 73 +++++++++++++++---------------
 1 file changed, 37 insertions(+), 36 deletions(-)

diff --git a/t/t5703-upload-pack-ref-in-want.sh b/t/t5703-upload-pack-ref-i=
n-want.sh
index e9e471621d..3dad21ff45 100755
--- a/t/t5703-upload-pack-ref-in-want.sh
+++ b/t/t5703-upload-pack-ref-in-want.sh
@@ -40,6 +40,30 @@ write_command () {
 =09fi
 }

+# Write a complete fetch command to stdout, suitable for use with `test-to=
ol
+# pkt-line`. "want-ref", "want", and "have" lines are read from stdin.
+#
+# Examples:
+#
+# write_fetch_command <<-EOF
+# want-ref refs/heads/main
+# have $(git rev-parse a)
+# EOF
+#
+# write_fetch_command <<-EOF
+# want $(git rev-parse b)
+# have $(git rev-parse a)
+# EOF
+#
+write_fetch_command () {
+=09write_command fetch &&
+=09echo "0001" &&
+=09echo "no-progress" &&
+=09cat &&
+=09echo "done" &&
+=09echo "0000"
+}
+
 # c(o/foo) d(o/bar)
 #        \ /
 #         b   e(baz)  f(main)
@@ -77,15 +101,11 @@ test_expect_success 'config controls ref-in-want adver=
tisement' '
 '

 test_expect_success 'invalid want-ref line' '
-=09test-tool pkt-line pack >in <<-EOF &&
-=09$(write_command fetch)
-=090001
-=09no-progress
+=09write_fetch_command >pkt <<-EOF &&
 =09want-ref refs/heads/non-existent
-=09done
-=090000
 =09EOF

+=09test-tool pkt-line pack <pkt >in &&
 =09test_must_fail test-tool serve-v2 --stateless-rpc 2>out <in &&
 =09grep "unknown ref" out
 '
@@ -97,16 +117,11 @@ test_expect_success 'basic want-ref' '
 =09EOF
 =09git rev-parse f >expected_commits &&

-=09oid=3D$(git rev-parse a) &&
-=09test-tool pkt-line pack >in <<-EOF &&
-=09$(write_command fetch)
-=090001
-=09no-progress
+=09write_fetch_command >pkt <<-EOF &&
 =09want-ref refs/heads/main
-=09have $oid
-=09done
-=090000
+=09have $(git rev-parse a)
 =09EOF
+=09test-tool pkt-line pack <pkt >in &&

 =09test-tool serve-v2 --stateless-rpc >out <in &&
 =09check_output
@@ -121,17 +136,12 @@ test_expect_success 'multiple want-ref lines' '
 =09EOF
 =09git rev-parse c d >expected_commits &&

-=09oid=3D$(git rev-parse b) &&
-=09test-tool pkt-line pack >in <<-EOF &&
-=09$(write_command fetch)
-=090001
-=09no-progress
+=09write_fetch_command >pkt <<-EOF &&
 =09want-ref refs/heads/o/foo
 =09want-ref refs/heads/o/bar
-=09have $oid
-=09done
-=090000
+=09have $(git rev-parse b)
 =09EOF
+=09test-tool pkt-line pack <pkt >in &&

 =09test-tool serve-v2 --stateless-rpc >out <in &&
 =09check_output
@@ -144,16 +154,12 @@ test_expect_success 'mix want and want-ref' '
 =09EOF
 =09git rev-parse e f >expected_commits &&

-=09test-tool pkt-line pack >in <<-EOF &&
-=09$(write_command fetch)
-=090001
-=09no-progress
+=09write_fetch_command >pkt <<-EOF &&
 =09want-ref refs/heads/main
 =09want $(git rev-parse e)
 =09have $(git rev-parse a)
-=09done
-=090000
 =09EOF
+=09test-tool pkt-line pack <pkt >in &&

 =09test-tool serve-v2 --stateless-rpc >out <in &&
 =09check_output
@@ -166,16 +172,11 @@ test_expect_success 'want-ref with ref we already hav=
e commit for' '
 =09EOF
 =09>expected_commits &&

-=09oid=3D$(git rev-parse c) &&
-=09test-tool pkt-line pack >in <<-EOF &&
-=09$(write_command fetch)
-=090001
-=09no-progress
+=09write_fetch_command >pkt <<-EOF &&
 =09want-ref refs/heads/o/foo
-=09have $oid
-=09done
-=090000
+=09have $(git rev-parse c)
 =09EOF
+=09test-tool pkt-line pack <pkt >in &&

 =09test-tool serve-v2 --stateless-rpc >out <in &&
 =09check_output
--
2.32.0


