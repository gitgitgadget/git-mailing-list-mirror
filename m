Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA7D4C7112B
	for <git@archiver.kernel.org>; Thu, 17 Aug 2023 22:30:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355751AbjHQWaW (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Aug 2023 18:30:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355739AbjHQWaH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Aug 2023 18:30:07 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A2523590
        for <git@vger.kernel.org>; Thu, 17 Aug 2023 15:30:06 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6BC611A8254;
        Thu, 17 Aug 2023 18:30:05 -0400 (EDT)
        (envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; s=sasl; bh=KZ9bVplMqjBwPPZwqZPiKerMb
        gbCvdYG3lvFDXPxXVg=; b=tRR2nmfWvxQEE1x4ToAqbNiClDvsGdAM9JlyVkqjW
        jXiFszBVt3fBmBLMDLBsnnjkfHDQrZ52Pbgzfpd5SY9Lhp0+JO7w0PLc6IoOPggn
        kEyOWUFeTVjyFnOCiTTzMgo0oW6j72ux7EEl3VTQkZchjG7nzLdE+wA1OEg6lqT4
        p4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1B0E11A8251;
        Thu, 17 Aug 2023 18:30:05 -0400 (EDT)
        (envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.83.58.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 5C4FE1A824E;
        Thu, 17 Aug 2023 18:30:03 -0400 (EDT)
        (envelope-from gitster@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [PATCH v2 5/5] diff: teach "--name-status" and friends to honor "--exit-code -w"
Date:   Thu, 17 Aug 2023 15:29:49 -0700
Message-ID: <20230817222949.3835424-6-gitster@pobox.com>
X-Mailer: git-send-email 2.42.0-rc2
In-Reply-To: <20230817222949.3835424-1-gitster@pobox.com>
References: <xmqqttsxbfyw.fsf@gitster.g>
 <20230817222949.3835424-1-gitster@pobox.com>
MIME-Version: 1.0
X-Pobox-Relay-ID: 9C042DEE-3D4D-11EE-907B-25B3960A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We have fallback code that is used when "-s -w --exit-code" options
are used together to compute the exit code, because the exit code
must take the whitespace-ignoring comparison into account over the
contents, but with "-s", the normal codepath does not even have to
look at the contents at all.  The fallback code simply runs a "git
diff --patch" while sending the output to "/dev/null".

The codepaths for some other output modes, like "--name-status" and
"--raw", share the same trait as "-s" in that they do not look at
the contents for their output generation.  Extend the fallback code
to cover these output modes as well.

Note that they may still not be correct in that a path whose
contents have no differences other than whitespace changes would
still show up in the "diff -w --name-only --exit-code" output, even
though the exit status may say there is no differences.  Arguably
this is better than status quo, even though it still may be wrong.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 diff.c                     | 23 +++++++++++++++++++----
 t/t4015-diff-whitespace.sh |  3 ++-
 2 files changed, 21 insertions(+), 5 deletions(-)

diff --git a/diff.c b/diff.c
index 7213237675..3bb9d11bfe 100644
--- a/diff.c
+++ b/diff.c
@@ -6573,13 +6573,28 @@ void diff_flush(struct diff_options *options)
 	if (output_format & DIFF_FORMAT_CALLBACK)
 		options->format_callback(q, options, options->format_callback_data);
=20
-	if (output_format & DIFF_FORMAT_NO_OUTPUT &&
+	if (((output_format & DIFF_FORMAT_NO_OUTPUT) ||
+	     /* these compute .found_changes properly */
+	     !(output_format & (DIFF_FORMAT_DIFFSTAT|
+				DIFF_FORMAT_SHORTSTAT|
+				DIFF_FORMAT_NUMSTAT|
+				DIFF_FORMAT_DIRSTAT|
+				DIFF_FORMAT_PATCH))) &&
 	    options->flags.exit_with_status &&
 	    options->flags.diff_from_contents) {
 		/*
-		 * run diff_flush_patch for the exit status. setting
-		 * options->file to /dev/null should be safe, because we
-		 * aren't supposed to produce any output anyway.
+		 * We need to inspect the contents, not just object
+		 * names, to determine the exit status, but the usual
+		 * processing for the output format specified does not
+		 * have to work with and does not look at the
+		 * contents.  Run an extra and silent "diff --patch"
+		 * but discard the output to /dev/null, so that we
+		 * would set the .found_changes bit correctly.
+		 *
+		 * We can safely close and discard the original output
+		 * file here, since all that is left to do from this
+		 * point is to return (we don't do the FORMAT_PATCH
+		 * thing below).
 		 */
 		diff_free_file(options);
 		options->file =3D xfopen("/dev/null", "w");
diff --git a/t/t4015-diff-whitespace.sh b/t/t4015-diff-whitespace.sh
index 355d96aa14..412d20181c 100755
--- a/t/t4015-diff-whitespace.sh
+++ b/t/t4015-diff-whitespace.sh
@@ -11,7 +11,8 @@ TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-diff.sh
=20
-for opts in --patch --quiet -s --stat --shortstat --dirstat=3Dlines
+for opts in --patch --quiet -s --stat --shortstat --dirstat=3Dlines \
+	    --name-only --raw --name-status --summary
 do
=20
 	test_expect_success "status with $opts (different)" '
--=20
2.42.0-rc2

