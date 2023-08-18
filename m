Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 339C5EE49A1
	for <git@archiver.kernel.org>; Sat, 19 Aug 2023 00:00:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243034AbjHRX7w (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Aug 2023 19:59:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243122AbjHRX7m (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Aug 2023 19:59:42 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5AC93AAE
        for <git@vger.kernel.org>; Fri, 18 Aug 2023 16:59:40 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 377231A1FD4;
        Fri, 18 Aug 2023 19:59:40 -0400 (EDT)
        (envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; s=sasl; bh=MxFpL1pjw/VCL4g9Ye6NbJxWB
        N6a4PLAhjQjeCDHlI4=; b=JowfaZmcGDV4vx7Heu1PlfdR4Rz/Uh19a5ott3sML
        zTrWAKZsTCiXOEZcjYXcCiZvu9hqIHgWVzZ9c5vBcbSB9xLO7aIBKBQE8tHsnzTf
        gRgZFYPF97jQJj4b+2LwGHl2wMIl9bywZ20wOfrs/GS/no+wYchE1YzbfwGeszRb
        lM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2DEE01A1FD3;
        Fri, 18 Aug 2023 19:59:40 -0400 (EDT)
        (envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.83.58.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 8DF401A1FD2;
        Fri, 18 Aug 2023 19:59:39 -0400 (EDT)
        (envelope-from gitster@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [PATCH v3 2/5] diff: mode-only change should be noticed by "--patch -w --exit-code"
Date:   Fri, 18 Aug 2023 16:59:29 -0700
Message-ID: <20230818235932.3253552-3-gitster@pobox.com>
X-Mailer: git-send-email 2.42.0-rc2-7-gf9972720e9
In-Reply-To: <20230818235932.3253552-1-gitster@pobox.com>
References: <20230817222949.3835424-1-gitster@pobox.com>
 <20230818235932.3253552-1-gitster@pobox.com>
MIME-Version: 1.0
X-Pobox-Relay-ID: 4ADF1D1C-3E23-11EE-83AF-25B3960A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The codepath to notice the content-level changes, taking certain
no-op changes like "ignore whitespace" into account, forgot that
a mode-only change is still a change.  This resulted in

    $ git diff --patch --exit-code -w

to exit with status 0 even when there is such a mode-only change,
breaking both "--patch" and "--quiet" output formats.

Teach the builtin_diff() codepath that creation and deletion as well
as mode changes are all interesting changes.

Note that the test specifically checks removal of an empty file,
because if there is anything in the preimage (i.e. the removed file
is not empty), the removal would still trigger textual patch output
and the codepath for that does update .found_changes bit to report
that it found an interesting change.  We need to make sure that the
.found_changes bit is set even without triggering textual patch
output.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 diff.c                     |  3 +++
 t/t4015-diff-whitespace.sh | 35 ++++++++++++++++++++++++++++++++++-
 2 files changed, 37 insertions(+), 1 deletion(-)

diff --git a/diff.c b/diff.c
index 0ce678fc06..998d7ae20c 100644
--- a/diff.c
+++ b/diff.c
@@ -3497,18 +3497,21 @@ static void builtin_diff(const char *name_a,
 		strbuf_addf(&header, "%s%snew file mode %06o%s\n", line_prefix, meta, =
two->mode, reset);
 		if (xfrm_msg)
 			strbuf_addstr(&header, xfrm_msg);
+		o->found_changes =3D 1;
 		must_show_header =3D 1;
 	}
 	else if (lbl[1][0] =3D=3D '/') {
 		strbuf_addf(&header, "%s%sdeleted file mode %06o%s\n", line_prefix, me=
ta, one->mode, reset);
 		if (xfrm_msg)
 			strbuf_addstr(&header, xfrm_msg);
+		o->found_changes =3D 1;
 		must_show_header =3D 1;
 	}
 	else {
 		if (one->mode !=3D two->mode) {
 			strbuf_addf(&header, "%s%sold mode %06o%s\n", line_prefix, meta, one-=
>mode, reset);
 			strbuf_addf(&header, "%s%snew mode %06o%s\n", line_prefix, meta, two-=
>mode, reset);
+			o->found_changes =3D 1;
 			must_show_header =3D 1;
 		}
 		if (xfrm_msg)
diff --git a/t/t4015-diff-whitespace.sh b/t/t4015-diff-whitespace.sh
index f3e20dd5bb..02731dccb9 100755
--- a/t/t4015-diff-whitespace.sh
+++ b/t/t4015-diff-whitespace.sh
@@ -1,7 +1,7 @@
 #!/bin/sh
 #
 # Copyright (c) 2006 Johannes E. Schindelin
-#
+# Copyright (c) 2023 Google LLC
=20
 test_description=3D'Test special whitespace in diff engine.
=20
@@ -11,6 +11,39 @@ TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-diff.sh
=20
+for opts in --patch --quiet -s
+do
+
+	test_expect_success "status with $opts (different)" '
+		echo foo >x &&
+		git add x &&
+		echo bar >x &&
+		test_expect_code 1 git diff -w $opts --exit-code x
+	'
+
+	test_expect_success POSIXPERM "status with $opts (mode differs)" '
+		test_when_finished "git update-index --chmod=3D-x x" &&
+		echo foo >x &&
+		git add x &&
+		git update-index --chmod=3D+x x &&
+		test_expect_code 1 git diff -w $opts --exit-code x
+	'
+
+	test_expect_success "status with $opts (removing an empty file)" '
+		: >x &&
+		git add x &&
+		rm x &&
+		test_expect_code 1 git diff -w $opts --exit-code -- x
+	'
+
+	test_expect_success "status with $opts (different but equivalent)" '
+		echo foo >x &&
+		git add x &&
+		echo " foo" >x &&
+		git diff -w $opts --exit-code x
+	'
+done
+
 test_expect_success "Ray Lehtiniemi's example" '
 	cat <<-\EOF >x &&
 	do {
--=20
2.42.0-rc2-7-gf9972720e9

