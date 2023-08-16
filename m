Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64301C2FC05
	for <git@archiver.kernel.org>; Wed, 16 Aug 2023 23:46:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347207AbjHPXpy (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Aug 2023 19:45:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347228AbjHPXpb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Aug 2023 19:45:31 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70891272C
        for <git@vger.kernel.org>; Wed, 16 Aug 2023 16:45:29 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 1712719266;
        Wed, 16 Aug 2023 19:45:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=vrPtgFAvTflxmuFoyEdWDkVsyy6Uwjt/K2W92ShLx+k=; b=oiZO
        GRPv77IKrOJ8NmoWLRubmHKzd5Hd8pVlAphtLuC/JaJxrVEnDM2qtR8nMYCPjTce
        d06juNQlHL2sQCuoSh4WA7fFRtpchF6wRD0CNyx2fGNDn91lq5mYmKT33eEafRWP
        O0ulCMVXePtql2ELZhwIXyq+VlG2QWqwvN01iU0=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 0E61619265;
        Wed, 16 Aug 2023 19:45:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.58.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 13FEC19264;
        Wed, 16 Aug 2023 19:45:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     Paul Watson <pwatson2@wellmed.net>
Subject: [PATCH] diff: tighten interaction between -w and --exit-code
References: <MW2PR12MB25558D1886C4AA2A95A5FC618709A@MW2PR12MB2555.namprd12.prod.outlook.com>
        <xmqqbkfh8nu3.fsf@gitster.g>
X-Gnus-Delayed: Wed, 16 Aug 2023 19:21:29 -0700
Date:   Wed, 16 Aug 2023 16:45:23 -0700
Message-ID: <xmqqv8ded018.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F8B9114A-3C8E-11EE-9C30-C2DA088D43B2-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The "diff" family of commands have "--exit-code" option to make them
report if they "saw" changes with their exit code, but it did not work
when options in the "ignore space" family is used *and* the output mode
did not involve the "--patch" format output, unless the output is
totally suppressed with "-s".

Internally, the diff machinery grabs sets of paths from the two
sides being compared that record different blob objects, optionally
matches these paths up for rename processing, and compares the blob
objects pair-wise.  When options like "-w" are *not* involved, the
machinery can say that it see a difference immediately after
noticing that the object names of the blobs at paths being compared
are different.  In essence, this means that a non-empty diff_queue[]
means the command should exit with 1 under "--exit-code" mode.

But when options that may make two different blobs compare as
equivalents, like "-w" that ignores whitespace differences, are in
effect, the blobs need to be compared for their contents, as if we
were generating a patch, even when the user is only interested in
"--exit-code" and not an actual differences.

There are two special case tweaks in the existing code.  One is that
the codepath to compute "--patch" output sets .found_changes bit
only when it sees a "real" change (whose definition is loosened when
"-w" is in effect to ignore whitespace-only changes), and uses that
bit, instead of whether diff_queue[] has any paths, to decide the
exit status.  The other is that when "-s" (no output) is combined
with "-w", the machinery calls the same "--patch" codepath but
redirecting the output to void, only for the .found_changes bit.

That is fine, until somebody comes and tries to combine options like
"--stat", "--name-only", "--name-status", etc. with "-w".  Because
the second special case above to run a fallback "--patch" computation
does not kick in for these other output modes, .found_changes bit is
not updated correctly.

To fix this, do two things:

 * The codepath to generate "--stat" output already calls the
   underlying xdiff machinery with appropriate options like "-w",
   but it did not update .found_changes bit.  Fixing "--stat -w"
   combined with "--exit-code" thus becomes just the matter of
   adding these missing .found_changes assignment.

 * For generating "--name-only", "--name-status", etc., the code
   does not look into the contents of the blob objects at all.  For
   now, extend the special case used for "-s -w --exit-code" to run
   a silent "--patch" computation to set the .found_changes bit
   correctly.

Not that the latter may still not be correct in that a path whose
contents have no differences other than whitespace changes would
still show up in the "diff -w --name-only --exit-code" output, even
though the exit status may say there is no differences.  Arguably
this is better than status quo, even though it still is wrong.

Reported-by: Paul Watson <pwatson2@wellmed.net>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
Junio C Hamano <gitster@pobox.com> writes:

> Also, this is not limited to the no-index mode.
>
>     $ echo one >1
>     $ git add 1
>     $ echo two >1
>     $ git diff --exit-code --numstat 1; echo "<<$?>>"
>     1	1	1
>     <<1>>
>     $ git diff --exit-code --numstat -w 1; echo "<<$?>>"
>     1	1	1
>     <<0>>
>
> So the minimum reproduction seems to be
>
>   * the diff machinery is asked to do --exit-code (no-index
>     implicitly does it)
>   * -w is used
>   * -p is *not* used
>   * to compare two different files.
>
> Thanks for a bug report.
>
> Patches welcome ;-)

So I ended up looking into this myself X-<.

 diff.c                     |  22 +++++++++-
 t/t4015-diff-whitespace.sh | 100 ++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 119 insertions(+), 3 deletions(-)

diff --git c/diff.c w/diff.c
index ee3eb629e3..38b57b589f 100644
--- c/diff.c
+++ w/diff.c
@@ -3795,6 +3795,7 @@ static void builtin_diffstat(const char *name_a, const char *name_b,
 		} else {
 			data->added = diff_filespec_size(o->repo, two);
 			data->deleted = diff_filespec_size(o->repo, one);
+			o->found_changes = 1;
 		}
 	}
 
@@ -3803,6 +3804,7 @@ static void builtin_diffstat(const char *name_a, const char *name_b,
 		diff_populate_filespec(o->repo, two, NULL);
 		data->deleted = count_lines(one->data, one->size);
 		data->added = count_lines(two->data, two->size);
+		o->found_changes = 1;
 	}
 
 	else if (may_differ) {
@@ -3828,6 +3830,11 @@ static void builtin_diffstat(const char *name_a, const char *name_b,
 				  diffstat_consume, diffstat, &xpp, &xecfg))
 			die("unable to generate diffstat for %s", one->path);
 
+		/* Do this before cancelling the no-op diffstat below */
+		if (diffstat->files[diffstat->nr - 1]->added ||
+		    diffstat->files[diffstat->nr - 1]->deleted)
+			o->found_changes = 1;
+
 		if (DIFF_FILE_VALID(one) && DIFF_FILE_VALID(two)) {
 			struct diffstat_file *file =
 				diffstat->files[diffstat->nr - 1];
@@ -4832,6 +4839,11 @@ void diff_setup_done(struct diff_options *options)
 	else
 		options->prefix_length = 0;
 
+	/*
+	 * This is how "diff --name-status -p --stat --raw" becomes
+	 * equivalent to "diff --name-status", which may be
+	 * unintuitive.
+	 */
 	if (options->output_format & (DIFF_FORMAT_NAME |
 				      DIFF_FORMAT_NAME_STATUS |
 				      DIFF_FORMAT_CHECKDIFF |
@@ -6684,13 +6696,19 @@ void diff_flush(struct diff_options *options)
 		separator++;
 	}
 
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
 		 * run diff_flush_patch for the exit status. setting
 		 * options->file to /dev/null should be safe, because we
-		 * aren't supposed to produce any output anyway.
+		 * aren't supposed to produce any output from here.
 		 */
 		diff_free_file(options);
 		options->file = xfopen("/dev/null", "w");
diff --git c/t/t4015-diff-whitespace.sh w/t/t4015-diff-whitespace.sh
index b298f220e0..1b944d77e4 100755
--- c/t/t4015-diff-whitespace.sh
+++ w/t/t4015-diff-whitespace.sh
@@ -1,7 +1,7 @@
 #!/bin/sh
 #
 # Copyright (c) 2006 Johannes E. Schindelin
-#
+# Copyright (c) 2023 Google LLC
 
 test_description='Test special whitespace in diff engine.
 
@@ -11,6 +11,104 @@ TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-diff.sh
 
+test_expect_success 'exit status with -w --name-only (different)' '
+	echo foo >x &&
+	git add x &&
+	echo bar >x &&
+	test_expect_code 1 git diff -w --name-only --exit-code x
+'
+
+test_expect_success 'exit status with -w --name-only (different but equivalent)' '
+	echo foo >x &&
+	git add x &&
+	echo " foo" >x &&
+	git diff -w --name-only --exit-code x
+'
+
+test_expect_success 'exit status with -w --raw (different)' '
+	echo foo >x &&
+	git add x &&
+	echo bar >x &&
+	test_expect_code 1 git diff -w --raw --exit-code x
+'
+
+test_expect_success 'exit status with -w --raw (different but equivalent)' '
+	echo foo >x &&
+	git add x &&
+	echo " foo" >x &&
+	git diff -w --raw --exit-code x
+'
+
+test_expect_success 'exit status with -w --stat (different)' '
+	echo foo >x &&
+	git add x &&
+	echo bar >x &&
+	test_expect_code 1 git diff -w --stat --exit-code x
+'
+
+test_expect_success 'exit status with -w --stat (different but equivalent)' '
+	echo foo >x &&
+	git add x &&
+	echo " foo" >x &&
+	git diff -w --stat --exit-code x
+'
+
+test_expect_success 'exit status with -w --shortstat (different)' '
+	echo foo >x &&
+	git add x &&
+	echo bar >x &&
+	test_expect_code 1 git diff -w --shortstat --exit-code x
+'
+
+test_expect_success 'exit status with -w --shortstat (different but equivalent)' '
+	echo foo >x &&
+	git add x &&
+	echo " foo" >x &&
+	git diff -w --shortstat --exit-code x
+'
+
+test_expect_success 'exit status with -w --quiet (different)' '
+	echo foo >x &&
+	git add x &&
+	echo bar >x &&
+	test_expect_code 1 git diff -w --quiet --exit-code x
+'
+
+test_expect_success 'exit status with -w --quiet (different but equivalent)' '
+	echo foo >x &&
+	git add x &&
+	echo " foo" >x &&
+	git diff -w --quiet --exit-code x
+'
+
+test_expect_success 'exit status with -w --summary (different)' '
+	echo foo >x &&
+	git add x &&
+	echo bar >x &&
+	test_expect_code 1 git diff -w --summary --exit-code x
+'
+
+test_expect_success 'exit status with -w --summary (different but equivalent)' '
+	echo foo >x &&
+	git add x &&
+	echo " foo" >x &&
+	git diff -w --summary --exit-code x
+'
+
+test_expect_success 'exit status with -w -s (different)' '
+	echo foo >x &&
+	git add x &&
+	echo bar >x &&
+	test_expect_code 1 git diff -w -s --exit-code x
+'
+
+test_expect_success 'exit status with -w -s (different but equivalent)' '
+	echo foo >x &&
+	git add x &&
+	echo " foo" >x &&
+	git diff -w -s --exit-code x
+'
+
 test_expect_success "Ray Lehtiniemi's example" '
 	cat <<-\EOF >x &&
 	do {

