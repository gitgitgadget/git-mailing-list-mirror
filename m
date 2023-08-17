Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C1DDC2FC04
	for <git@archiver.kernel.org>; Thu, 17 Aug 2023 05:12:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347855AbjHQFLg (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Aug 2023 01:11:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347795AbjHQFLD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Aug 2023 01:11:03 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 362012698
        for <git@vger.kernel.org>; Wed, 16 Aug 2023 22:11:01 -0700 (PDT)
Received: (qmail 18709 invoked by uid 109); 17 Aug 2023 05:11:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 17 Aug 2023 05:11:00 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25855 invoked by uid 111); 17 Aug 2023 05:11:01 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 17 Aug 2023 01:11:01 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 17 Aug 2023 01:10:59 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Paul Watson <pwatson2@wellmed.net>
Subject: Re: [PATCH] diff: tighten interaction between -w and --exit-code
Message-ID: <20230817051059.GA3006160@coredump.intra.peff.net>
References: <MW2PR12MB25558D1886C4AA2A95A5FC618709A@MW2PR12MB2555.namprd12.prod.outlook.com>
 <xmqqbkfh8nu3.fsf@gitster.g>
 <xmqqv8ded018.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqv8ded018.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 16, 2023 at 04:45:23PM -0700, Junio C Hamano wrote:

> To fix this, do two things:
> 
>  * The codepath to generate "--stat" output already calls the
>    underlying xdiff machinery with appropriate options like "-w",
>    but it did not update .found_changes bit.  Fixing "--stat -w"
>    combined with "--exit-code" thus becomes just the matter of
>    adding these missing .found_changes assignment.
> 
>  * For generating "--name-only", "--name-status", etc., the code
>    does not look into the contents of the blob objects at all.  For
>    now, extend the special case used for "-s -w --exit-code" to run
>    a silent "--patch" computation to set the .found_changes bit
>    correctly.

Nicely explained overall, but one hunk of the patch left me wondering...

> @@ -3828,6 +3830,11 @@ static void builtin_diffstat(const char *name_a, const char *name_b,
>  				  diffstat_consume, diffstat, &xpp, &xecfg))
>  			die("unable to generate diffstat for %s", one->path);
>  
> +		/* Do this before cancelling the no-op diffstat below */
> +		if (diffstat->files[diffstat->nr - 1]->added ||
> +		    diffstat->files[diffstat->nr - 1]->deleted)
> +			o->found_changes = 1;
> +

So this is checking whether any lines were added/deleted to see if the
stat was a noop. But what about non-content bits, like mode changes?
E.g., the tests below all fail (but would pass without "-w"):

diff --git a/t/t4015-diff-whitespace.sh b/t/t4015-diff-whitespace.sh
index 1b944d77e4..54e56ad911 100755
--- a/t/t4015-diff-whitespace.sh
+++ b/t/t4015-diff-whitespace.sh
@@ -25,6 +25,14 @@ test_expect_success 'exit status with -w --name-only (different but equivalent)'
 	git diff -w --name-only --exit-code x
 '
 
+test_expect_success 'exit status with -w --name-only (mode change)' '
+	test_when_finished "git reset" &&
+	echo foo >x &&
+	git add x &&
+	git update-index --chmod=+x x &&
+	test_expect_code 1 git diff -w --name-only --exit-code
+'
+
 test_expect_success 'exit status with -w --raw (different)' '
 	echo foo >x &&
 	git add x &&
@@ -39,6 +47,14 @@ test_expect_success 'exit status with -w --raw (different but equivalent)' '
 	git diff -w --raw --exit-code x
 '
 
+test_expect_success 'exit status with -w --raw (mode change)' '
+	test_when_finished "git reset" &&
+	echo foo >x &&
+	git add x &&
+	git update-index --chmod=+x x &&
+	test_expect_code 1 git diff -w --raw --exit-code
+'
+
 test_expect_success 'exit status with -w --stat (different)' '
 	echo foo >x &&
 	git add x &&
@@ -53,6 +69,14 @@ test_expect_success 'exit status with -w --stat (different but equivalent)' '
 	git diff -w --stat --exit-code x
 '
 
+test_expect_success 'exit status with -w --stat (mode change)' '
+	test_when_finished "git reset" &&
+	echo foo >x &&
+	git add x &&
+	git update-index --chmod=+x x &&
+	test_expect_code 1 git diff -w --stat --exit-code
+'
+
 test_expect_success 'exit status with -w --shortstat (different)' '
 	echo foo >x &&
 	git add x &&
@@ -67,6 +91,14 @@ test_expect_success 'exit status with -w --shortstat (different but equivalent)'
 	git diff -w --shortstat --exit-code x
 '
 
+test_expect_success 'exit status with -w --shortstat (mode change)' '
+	test_when_finished "git reset" &&
+	echo foo >x &&
+	git add x &&
+	git update-index --chmod=+x x &&
+	test_expect_code 1 git diff -w --shortstat --exit-code
+'
+
 test_expect_success 'exit status with -w --quiet (different)' '
 	echo foo >x &&
 	git add x &&
@@ -81,6 +113,14 @@ test_expect_success 'exit status with -w --quiet (different but equivalent)' '
 	git diff -w --quiet --exit-code x
 '
 
+test_expect_success 'exit status with -w --quiet (mode change)' '
+	test_when_finished "git reset" &&
+	echo foo >x &&
+	git add x &&
+	git update-index --chmod=+x x &&
+	test_expect_code 1 git diff -w --quiet --exit-code
+'
+
 test_expect_success 'exit status with -w --summary (different)' '
 	echo foo >x &&
 	git add x &&
@@ -95,6 +135,14 @@ test_expect_success 'exit status with -w --summary (different but equivalent)' '
 	git diff -w --summary --exit-code x
 '
 
+test_expect_success 'exit status with -w --summary (mode change)' '
+	test_when_finished "git reset" &&
+	echo foo >x &&
+	git add x &&
+	git update-index --chmod=+x x &&
+	test_expect_code 1 git diff -w --summary --exit-code
+'
+
 test_expect_success 'exit status with -w -s (different)' '
 	echo foo >x &&
 	git add x &&
@@ -109,6 +157,14 @@ test_expect_success 'exit status with -w -s (different but equivalent)' '
 	git diff -w -s --exit-code x
 '
 
+test_expect_success 'exit status with -w -s (mode change)' '
+	test_when_finished "git reset" &&
+	echo foo >x &&
+	git add x &&
+	git update-index --chmod=+x x &&
+	test_expect_code 1 git diff -w -s --exit-code x
+'
+
 test_expect_success "Ray Lehtiniemi's example" '
 	cat <<-\EOF >x &&
 	do {

For the diffstat case, I think we could check the mode here, but there
are other cases (e.g., adding or deleting an empty file). The code right
below the hunk I quoted seems to try to deal with that (the "cancelling
the no-op" your comment mentions). I'm not sure if we want something
like this:

diff --git a/diff.c b/diff.c
index 38b57b589f..1dbfdaeff0 100644
--- a/diff.c
+++ b/diff.c
@@ -3853,6 +3853,8 @@ static void builtin_diffstat(const char *name_a, const char *name_b,
 				&& one->mode == two->mode) {
 				free_diffstat_file(file);
 				diffstat->nr--;
+			} else {
+				o->found_changes = 1;
 			}
 		}
 	}

but I haven't dug too far (and of course all of the other options also
need something similar to catch this case).

-Peff
