Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41D7EC4338F
	for <git@archiver.kernel.org>; Mon,  9 Aug 2021 17:57:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1AB8861159
	for <git@archiver.kernel.org>; Mon,  9 Aug 2021 17:57:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235739AbhHIR5v (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Aug 2021 13:57:51 -0400
Received: from mail1.protonmail.ch ([185.70.40.18]:17121 "EHLO
        mail1.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235715AbhHIR5O (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Aug 2021 13:57:14 -0400
Date:   Mon, 09 Aug 2021 17:56:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=eagain.st;
        s=protonmail; t=1628531811;
        bh=rWb19kpNbJ6bceLXacmyKg333Ak1I2jLiQ9teztIrUQ=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=ed1dkB2ZSI935It/a1OauOXirVPZpgx5NpuUfOG8ZnAH/JumjQGt4vwpkqkEMeKE9
         W4uHUoLY58drF/856F0OepLk8CQ6OgIsxqecP0BLL4VGj8crO7w7NQKFBwc640aH5E
         vfaAlxUuyCu2FfUsAbTzoVy5NbYYhtV9Gzlks3QQcq+Wl3GeQWKJc5lfSIfP7mL/U/
         rn4wJo6nydrQKSvXG7Flbd/uzyxl/9ONxloK0Ool55l+O1dg1sRNa3VXSSR/DNAs/x
         Lx989raHXwAqFLqOmwgcIzNe15kppPsjebJv8zZRLmQePJ1TaOZx2lMRhuIbr8X2fx
         WFjXs6IH6Gz6w==
To:     git@vger.kernel.org
From:   Kim Altintop <kim@eagain.st>
Cc:     kim@eagain.st, gitster@pobox.com, jonathantanmy@google.com,
        bwilliams.eng@gmail.com
Reply-To: Kim Altintop <kim@eagain.st>
Subject: [PATCH 1/3] t5730: introduce fetch command helper
Message-ID: <20210809175530.75326-2-kim@eagain.st>
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
 t/t5703-upload-pack-ref-in-want.sh | 107 ++++++++++++++++++++---------
 1 file changed, 74 insertions(+), 33 deletions(-)

diff --git a/t/t5703-upload-pack-ref-in-want.sh b/t/t5703-upload-pack-ref-i=
n-want.sh
index e9e471621d..cd4744b016 100755
--- a/t/t5703-upload-pack-ref-in-want.sh
+++ b/t/t5703-upload-pack-ref-in-want.sh
@@ -40,6 +40,54 @@ write_command () {
 =09fi
 }

+# Write a complete fetch command to stdout, suitable for use with `test-to=
ol
+# pkt-line`. "want-ref", "want", and "have" values can be given in this or=
der,
+# with sections separated by "--".
+#
+# Examples:
+#
+# write_fetch_command refs/heads/main
+#
+# write_fetch_command \
+#=09refs/heads/main \
+#=09-- \
+#=09-- \
+#=09$(git rev-parse x)
+#
+# write_fetch_command \
+#=09--
+#=09$(git rev-parse a) \
+#=09--
+#=09$(git rev-parse b)
+write_fetch_command () {
+=09write_command fetch &&
+=09echo "0001" &&
+=09echo "no-progress" || return
+    while :
+=09do
+=09=09case $# in 0) break ;; esac &&
+=09=09case "$1" in --) shift; break ;; esac &&
+=09=09echo "want-ref $1" &&
+=09=09shift || return
+=09done &&
+    while :
+=09do
+=09=09case $# in 0) break ;; esac &&
+=09=09case "$1" in --) shift; break ;; esac &&
+=09=09echo "want $1" &&
+=09=09shift || return
+=09done &&
+    while :
+=09do
+=09=09case $# in 0) break ;; esac &&
+=09=09case "$1" in --) shift; break ;; esac &&
+=09=09echo "have $1" &&
+=09=09shift || return
+=09done &&
+=09echo "done" &&
+=09echo "0000"
+}
+
 # c(o/foo) d(o/bar)
 #        \ /
 #         b   e(baz)  f(main)
@@ -97,15 +145,13 @@ test_expect_success 'basic want-ref' '
 =09EOF
 =09git rev-parse f >expected_commits &&

-=09oid=3D$(git rev-parse a) &&
 =09test-tool pkt-line pack >in <<-EOF &&
-=09$(write_command fetch)
-=090001
-=09no-progress
-=09want-ref refs/heads/main
-=09have $oid
-=09done
-=090000
+=09$(write_fetch_command \
+=09=09refs/heads/main \
+=09=09-- \
+=09=09-- \
+=09=09$(git rev-parse a) \
+=09)
 =09EOF

 =09test-tool serve-v2 --stateless-rpc >out <in &&
@@ -121,16 +167,14 @@ test_expect_success 'multiple want-ref lines' '
 =09EOF
 =09git rev-parse c d >expected_commits &&

-=09oid=3D$(git rev-parse b) &&
 =09test-tool pkt-line pack >in <<-EOF &&
-=09$(write_command fetch)
-=090001
-=09no-progress
-=09want-ref refs/heads/o/foo
-=09want-ref refs/heads/o/bar
-=09have $oid
-=09done
-=090000
+=09$(write_fetch_command \
+=09=09refs/heads/o/foo \
+=09=09refs/heads/o/bar \
+=09=09-- \
+=09=09-- \
+=09=09$(git rev-parse b) \
+=09)
 =09EOF

 =09test-tool serve-v2 --stateless-rpc >out <in &&
@@ -145,14 +189,13 @@ test_expect_success 'mix want and want-ref' '
 =09git rev-parse e f >expected_commits &&

 =09test-tool pkt-line pack >in <<-EOF &&
-=09$(write_command fetch)
-=090001
-=09no-progress
-=09want-ref refs/heads/main
-=09want $(git rev-parse e)
-=09have $(git rev-parse a)
-=09done
-=090000
+=09$(write_fetch_command \
+=09=09refs/heads/main \
+=09=09-- \
+=09=09$(git rev-parse e) \
+=09=09-- \
+=09=09$(git rev-parse a) \
+=09)
 =09EOF

 =09test-tool serve-v2 --stateless-rpc >out <in &&
@@ -166,15 +209,13 @@ test_expect_success 'want-ref with ref we already hav=
e commit for' '
 =09EOF
 =09>expected_commits &&

-=09oid=3D$(git rev-parse c) &&
 =09test-tool pkt-line pack >in <<-EOF &&
-=09$(write_command fetch)
-=090001
-=09no-progress
-=09want-ref refs/heads/o/foo
-=09have $oid
-=09done
-=090000
+=09$(write_fetch_command \
+=09=09refs/heads/o/foo \
+=09=09-- \
+=09=09-- \
+=09=09$(git rev-parse c) \
+=09)
 =09EOF

 =09test-tool serve-v2 --stateless-rpc >out <in &&
--
2.32.0


