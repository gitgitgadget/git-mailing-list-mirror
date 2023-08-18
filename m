Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08A11EE499F
	for <git@archiver.kernel.org>; Sat, 19 Aug 2023 00:00:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243121AbjHSAAZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Aug 2023 20:00:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243015AbjHRX7w (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Aug 2023 19:59:52 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CE563AAE
        for <git@vger.kernel.org>; Fri, 18 Aug 2023 16:59:51 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E1CB729F25;
        Fri, 18 Aug 2023 19:59:50 -0400 (EDT)
        (envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; s=sasl; bh=d4jwQiqXt+v/Z0ZVaMZ5O8e73
        9TXiskvGpkRGFTZVjU=; b=gmlVPpKS3sVlaFkAQ3RJxj7U/CphutaoMwER2nWNP
        5AHPxE0VFEi0+PGPt2S9iaI6CjivmGrqNLjs5cvvnDbwWRPUoytS58PB5T8LEEbw
        pDlCp8lAp+fIt+wcMl7RRzylXeuGVGvAEU/q8SD1LDOflvsevli9v5gvAdkk7yg4
        Hk=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id DC1B629F24;
        Fri, 18 Aug 2023 19:59:50 -0400 (EDT)
        (envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.83.58.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id D712F29F23;
        Fri, 18 Aug 2023 19:59:45 -0400 (EDT)
        (envelope-from gitster@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [PATCH v3 5/5] diff: the -w option breaks --exit-code for --raw and other output modes
Date:   Fri, 18 Aug 2023 16:59:32 -0700
Message-ID: <20230818235932.3253552-6-gitster@pobox.com>
X-Mailer: git-send-email 2.42.0-rc2-7-gf9972720e9
In-Reply-To: <20230818235932.3253552-1-gitster@pobox.com>
References: <20230817222949.3835424-1-gitster@pobox.com>
 <20230818235932.3253552-1-gitster@pobox.com>
MIME-Version: 1.0
X-Pobox-Relay-ID: 4EA02C70-3E23-11EE-A8BB-F515D2CDFF5E-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The output from "--raw", "--name-status", and "--name-only" modes in
"git diff" does depend on and does not reflect how certain different
contents are considered equal, unlike "--patch" and "--stat" output
modes do, when used with options like "-w" (another way of thinking
about it is that it is not like we recompute the hash of the blob
after removing all whitespaces to show "git diff --raw -w" output).

But that is not an excuse for "git diff --exit-code --raw" to fail
to report differences with its exit status, when used with options
like "-w".  Make sure the command exits with 1 when these options
report paths that are different.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 diff.c                     | 6 ++++++
 t/t4015-diff-whitespace.sh | 8 ++++++--
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/diff.c b/diff.c
index da965ff688..78f4e7518f 100644
--- a/diff.c
+++ b/diff.c
@@ -4744,6 +4744,10 @@ void diff_setup_done(struct diff_options *options)
 	else
 		options->prefix_length =3D 0;
=20
+	/*
+	 * --name-only, --name-status, --checkdiff, and -s
+	 * turn other output format off.
+	 */
 	if (options->output_format & (DIFF_FORMAT_NAME |
 				      DIFF_FORMAT_NAME_STATUS |
 				      DIFF_FORMAT_CHECKDIFF |
@@ -6072,6 +6076,8 @@ static void flush_one_pair(struct diff_filepair *p,=
 struct diff_options *opt)
 		fprintf(opt->file, "%s", diff_line_prefix(opt));
 		write_name_quoted(name_a, opt->file, opt->line_termination);
 	}
+
+	opt->found_changes =3D 1;
 }
=20
 static void show_file_mode_name(struct diff_options *opt, const char *ne=
wdelete, struct diff_filespec *fs)
diff --git a/t/t4015-diff-whitespace.sh b/t/t4015-diff-whitespace.sh
index 230a89b951..7fcffa4b11 100755
--- a/t/t4015-diff-whitespace.sh
+++ b/t/t4015-diff-whitespace.sh
@@ -11,8 +11,12 @@ TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-diff.sh
=20
-for opts in --patch --quiet -s --stat --shortstat --dirstat=3Dlines
+for opt_res in --patch --quiet -s --stat --shortstat --dirstat=3Dlines \
+	       --raw! --name-only! --name-status!
 do
+	opts=3D${opt_res%!} expect_failure=3D
+	test "$opts" =3D "$opt_res" ||
+		expect_failure=3D"test_expect_code 1"
=20
 	test_expect_success "status with $opts (different)" '
 		echo foo >x &&
@@ -40,7 +44,7 @@ do
 		echo foo >x &&
 		git add x &&
 		echo " foo" >x &&
-		git diff -w $opts --exit-code x
+		$expect_failure git diff -w $opts --exit-code x
 	'
 done
=20
--=20
2.42.0-rc2-7-gf9972720e9

