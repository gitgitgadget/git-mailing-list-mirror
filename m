Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 690E4C433FE
	for <git@archiver.kernel.org>; Thu, 12 May 2022 22:36:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359222AbiELWgS (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 May 2022 18:36:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359225AbiELWgH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 May 2022 18:36:07 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FBB02555BF
        for <git@vger.kernel.org>; Thu, 12 May 2022 15:36:03 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 51EF519C31C;
        Thu, 12 May 2022 18:32:39 -0400 (EDT)
        (envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=TClJvfYAhlBf
        8svihCBH4b3snl7mXhrykCElEy4+fYY=; b=PSJobzzbZ79A1BB2fB0F57fulE+i
        HttyCZdKOjHs8mOVXDR8AvfcRdaDjbR3puWxbaXwN+jMkJrDD5+xWKIvJpxFgDm1
        5H4sxR2d6tk/gkRlBUeiKryIAk8tOufVbHRpW8RLfnG6YUVZGGWr/Az2znH+p84q
        H1HTjc+Ph+xlN5M=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 4AC0E19C31B;
        Thu, 12 May 2022 18:32:39 -0400 (EDT)
        (envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.83.65.128])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 362A819C31A;
        Thu, 12 May 2022 18:32:34 -0400 (EDT)
        (envelope-from gitster@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 4/4] object-file: fix a unpack_loose_header() regression in 3b6a8db3b03
Date:   Thu, 12 May 2022 15:32:18 -0700
Message-Id: <20220512223218.237544-5-gitster@pobox.com>
X-Mailer: git-send-email 2.36.1-338-g1c7f76a54c
In-Reply-To: <20220512223218.237544-1-gitster@pobox.com>
References: <cover-0.4-00000000000-20220421T200733Z-avarab@gmail.com>
 <20220512223218.237544-1-gitster@pobox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Pobox-Relay-ID: 6B0DEC46-D243-11EC-AD62-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>

Fix a regression in my 3b6a8db3b03 (object-file.c: use "enum" return
type for unpack_loose_header(), 2021-10-01) revealed both by running
the test suite with --valgrind, and with the amended "git fsck" test.

In practice this regression in v2.34.0 caused us to claim that we
couldn't parse the header, as opposed to not being able to unpack
it. Before the change in the C code the test_cmp added here would emit:

	-error: unable to unpack header of ./objects/e6/9de29bb2d1d6434b8b29ae77=
5ad8c2e48c5391
	+error: unable to parse header of ./objects/e6/9de29bb2d1d6434b8b29ae775=
ad8c2e48c5391

I.e. we'd proceed to call parse_loose_header() on the uninitialized
"hdr" value, and it would have been very unlikely for that
uninitialized memory to be a valid git object.

The other callers of unpack_loose_header() were already checking the
enum values exhaustively. See 3b6a8db3b03 and
5848fb11acd (object-file.c: return ULHR_TOO_LONG on "header too long",
2021-10-01).

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 object-file.c       |  8 ++++++--
 t/t1006-cat-file.sh | 10 ++++++++--
 t/t1450-fsck.sh     | 13 +++++++++++--
 3 files changed, 25 insertions(+), 6 deletions(-)

diff --git a/object-file.c b/object-file.c
index 5ffbf3d4fd..b5d1d12b68 100644
--- a/object-file.c
+++ b/object-file.c
@@ -2623,8 +2623,12 @@ int read_loose_object(const char *path,
 		goto out;
 	}
=20
-	if (unpack_loose_header(&stream, map, mapsize, hdr, sizeof(hdr),
-				NULL) < 0) {
+	switch (unpack_loose_header(&stream, map, mapsize, hdr, sizeof(hdr),
+				    NULL)) {
+	case ULHR_OK:
+		break;
+	case ULHR_BAD:
+	case ULHR_TOO_LONG:
 		error(_("unable to unpack header of %s"), path);
 		goto out;
 	}
diff --git a/t/t1006-cat-file.sh b/t/t1006-cat-file.sh
index 1b85207694..dadf3b1458 100755
--- a/t/t1006-cat-file.sh
+++ b/t/t1006-cat-file.sh
@@ -681,7 +681,7 @@ test_expect_success 'cat-file -t and -s on corrupt lo=
ose object' '
=20
 		# Setup and create the empty blob and its path
 		empty_path=3D$(git rev-parse --git-path objects/$(test_oid_to_path "$E=
MPTY_BLOB")) &&
-		git hash-object -w --stdin </dev/null &&
+		empty_blob=3D$(git hash-object -w --stdin </dev/null) &&
=20
 		# Create another blob and its path
 		echo other >other.blob &&
@@ -722,7 +722,13 @@ test_expect_success 'cat-file -t and -s on corrupt l=
oose object' '
 		# content out as-is. Try to make it zlib-invalid.
 		mv -f other.blob "$empty_path" &&
 		test_must_fail git fsck 2>err.fsck &&
-		grep "^error: inflate: data stream error (" err.fsck
+		cat >expect <<-EOF &&
+		error: inflate: data stream error (incorrect header check)
+		error: unable to unpack header of ./$empty_path
+		error: $empty_blob: object corrupt or missing: ./$empty_path
+		EOF
+		grep "^error: " err.fsck >actual &&
+		test_cmp expect actual
 	)
 '
=20
diff --git a/t/t1450-fsck.sh b/t/t1450-fsck.sh
index de50c0ea01..ab7f31f1dc 100755
--- a/t/t1450-fsck.sh
+++ b/t/t1450-fsck.sh
@@ -774,10 +774,19 @@ test_expect_success 'fsck finds problems in duplica=
te loose objects' '
 		# no "-d" here, so we end up with duplicates
 		git repack &&
 		# now corrupt the loose copy
-		file=3D$(sha1_file "$(git rev-parse HEAD)") &&
+		oid=3D"$(git rev-parse HEAD)" &&
+		file=3D$(sha1_file "$oid") &&
 		rm "$file" &&
 		echo broken >"$file" &&
-		test_must_fail git fsck
+		test_must_fail git fsck 2>err &&
+
+		cat >expect <<-EOF &&
+		error: inflate: data stream error (incorrect header check)
+		error: unable to unpack header of $file
+		error: $oid: object corrupt or missing: $file
+		EOF
+		grep "^error: " err >actual &&
+		test_cmp expect actual
 	)
 '
=20
--=20
2.36.1-338-g1c7f76a54c

