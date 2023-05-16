Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C245CC7EE22
	for <git@archiver.kernel.org>; Tue, 16 May 2023 02:28:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbjEPC2z (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 May 2023 22:28:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbjEPC2y (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 May 2023 22:28:54 -0400
X-Greylist: delayed 122 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 15 May 2023 19:28:53 PDT
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DA7C5B80
        for <git@vger.kernel.org>; Mon, 15 May 2023 19:28:52 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 9B04C1F95FF;
        Mon, 15 May 2023 22:26:52 -0400 (EDT)
        (envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; s=sasl; bh=mA7HqVqKGVvPcIJc1huVL6qOE
        stIQG8xAqOsNe6x1Ek=; b=Vmeb8c3n1BCKqA04Ve0Js0IkN9wy4iXRSg0zvj46v
        pmiUBZf1eGwM8yJPcgiPIpnEJAoQ1MRVUgB9zOQintYnS99BIdYIQkU0AuLo5g6X
        qAfOTNzVSARpNrj7C+eVja4ZRdKoHE5LHYYyVMWH5Ip0AzMxeeM34AOr9koSTAKY
        gs=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 93ABF1F95FD;
        Mon, 15 May 2023 22:26:52 -0400 (EDT)
        (envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [35.203.137.187])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id C446F1F95F8;
        Mon, 15 May 2023 22:26:49 -0400 (EDT)
        (envelope-from gitster@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [PATCH 1/3] tests: do not negate test_path_exists
Date:   Mon, 15 May 2023 19:26:44 -0700
Message-ID: <20230516022646.648123-2-gitster@pobox.com>
X-Mailer: git-send-email 2.41.0-rc0
In-Reply-To: <20230516022646.648123-1-gitster@pobox.com>
References: <20230516022646.648123-1-gitster@pobox.com>
MIME-Version: 1.0
X-Pobox-Relay-ID: 1CD92C32-F391-11ED-9B6C-C2DA088D43B2-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As a way to assert the path 'foo' is missing, "! test_path_exists foo" a
poor way to do so, as the helper is designed to complain when 'foo' is
missing, but the intention of the author who used negated form was to
make sure it does not exist.  This does not help debugging the tests.

Use test_path_is_missing instead, which is a more appropriate helper.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t4067-diff-partial-clone.sh | 4 ++--
 t/t4115-apply-symlink.sh      | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/t/t4067-diff-partial-clone.sh b/t/t4067-diff-partial-clone.s=
h
index f60f5cbd65..7af3a08862 100755
--- a/t/t4067-diff-partial-clone.sh
+++ b/t/t4067-diff-partial-clone.sh
@@ -151,7 +151,7 @@ test_expect_success 'diff does not fetch anything if =
inexact rename detection is
=20
 	# Ensure no fetches.
 	GIT_TRACE_PACKET=3D"$(pwd)/trace" git -C client diff --raw -M HEAD^ HEA=
D &&
-	! test_path_exists trace
+	test_path_is_missing trace
 '
=20
 test_expect_success 'diff --break-rewrites fetches only if necessary, an=
d batches blobs if it does' '
@@ -171,7 +171,7 @@ test_expect_success 'diff --break-rewrites fetches on=
ly if necessary, and batche
=20
 	# Ensure no fetches.
 	GIT_TRACE_PACKET=3D"$(pwd)/trace" git -C client diff --raw -M HEAD^ HEA=
D &&
-	! test_path_exists trace &&
+	test_path_is_missing trace &&
=20
 	# But with --break-rewrites, ensure that there is exactly 1 negotiation
 	# by checking that there is only 1 "done" line sent. ("done" marks the
diff --git a/t/t4115-apply-symlink.sh b/t/t4115-apply-symlink.sh
index e95e6d4e7d..a22a90d552 100755
--- a/t/t4115-apply-symlink.sh
+++ b/t/t4115-apply-symlink.sh
@@ -74,7 +74,7 @@ test_expect_success SYMLINKS 'symlink escape when creat=
ing new files' '
 	error: affected file ${SQ}renamed-symlink/create-me${SQ} is beyond a sy=
mbolic link
 	EOF
 	test_cmp expected_stderr stderr &&
-	! test_path_exists .git/create-me
+	test_path_is_missing .git/create-me
 '
=20
 test_expect_success SYMLINKS 'symlink escape when modifying file' '
--=20
2.41.0-rc0

