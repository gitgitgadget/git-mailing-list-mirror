Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9E952CA5
	for <git@vger.kernel.org>; Fri, 24 May 2024 23:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716591787; cv=none; b=KUpmlCw7aq23L3zA5i+lFkidnOTxN/zF9SphEXg7QKZKLbXFjVoIXyx3hIr9/lJA8Q3n12U3QsoS84yPozTXq2N0VmUAIRCWT05q4/4vOTiFAhXxADTKmu3VqcPTzhwrq37nb2RsjzbBL8R6x9bGl2sqwYNxCxz0ZUW5TwhYn0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716591787; c=relaxed/simple;
	bh=1zfgl1fdPnNvd9ss3ti4F29RiveYvYA8L/2QU8yHHFg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PIu0z48yViNFzYvcOhJc8xr6rixxvACEG2DSOvmCmo1d/KdSZHMDAOTLnUoVUlsmwA9s4YFMSZMx/+5Mbx/hWgcF7wl1I+wegEShOTKThBBWlGTbKF/7rXZDzgqRxBMoDHVqNEQWD8JXitP23a11cgyZLialYTiHaoy0nmmb2uA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=esMaVq8h; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="esMaVq8h"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id D44DE289D4;
	Fri, 24 May 2024 19:02:59 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=1zfgl1fdPnNvd9ss3ti4F29RiveYvYA8L/2QU8
	yHHFg=; b=esMaVq8hVQn2xpdHveUGhCXCNMUDEyx9VijOYBFkVlH3io039Nzvom
	BoF72h9HCdZwcPjN/8w24zFPvBfkTGlvjsgj61uSJANWxcR5HOYOAeKgKmol+7Ga
	vK2i0hqoPMI5NB99HUhx1w7E/TXUGZplJDWtG94WtxRn8g9yfdFc4=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id CD052289D3;
	Fri, 24 May 2024 19:02:59 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.173.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id E8EF2289D2;
	Fri, 24 May 2024 19:02:56 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 2/2] format-patch: move range/inter diff at the end of a
 single patch output
In-Reply-To: <20240523225007.2871766-3-gitster@pobox.com> (Junio C. Hamano's
	message of "Thu, 23 May 2024 15:50:07 -0700")
References: <20240523225007.2871766-1-gitster@pobox.com>
	<20240523225007.2871766-3-gitster@pobox.com>
Date: Fri, 24 May 2024 16:02:55 -0700
Message-ID: <xmqqed9qke3k.fsf_-_@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 C26933BA-1A21-11EF-B94A-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

When running "format-patch" on a multiple patch series, the output
coming from "--interdiff" and "--range-diff" options is inserted
after the "shortlog" list of commits and the overall diffstat.

The idea is that shortlog/diffstat are shorter and with denser
information content, which gives a better overview before the
readers dive into more details of range/inter diff.

When working on a single patch, however, we stuff the inter/range
diff output before the actual patch, next to the diffstat.  This
pushes down the patch text way down with inter/range diff output,
distracting readers.

Move the inter/range diff output to the very end of the output,
after all the patch text is shown.

As the inter/range diff is no longer part of the commentary block
(i.e., what comes after the log message and "---", but before the
patch text), stop producing "---" in the function that generates
them.  But to separate it out visually (note: this is not needed
to help tools like "git apply" that pay attention to the hunk
headers to figure out the length of the hunks), add an extra blank
line between the end of the patch text and the inter/range diff.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * The [1/2] patch is not shown as it is unchanged, to pretend that
   this [2/2] is a "single patch series".  This output (except for
   this commentary) was created with

   $ git format-patch --interdiff=@{24.hours} -1

 log-tree.c              | 11 +++++------
 t/t4014-format-patch.sh | 36 ++++++++++++++++++++++++++++++------
 2 files changed, 35 insertions(+), 12 deletions(-)

diff --git a/log-tree.c b/log-tree.c
index e7cd2c491f..7de744911e 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -684,8 +684,7 @@ static void show_diff_of_diff(struct rev_info *opt)
 		memcpy(&dq, &diff_queued_diff, sizeof(diff_queued_diff));
 		DIFF_QUEUE_CLEAR(&diff_queued_diff);
 
-		next_commentary_block(opt, NULL);
-		fprintf_ln(opt->diffopt.file, "%s", opt->idiff_title);
+		fprintf_ln(opt->diffopt.file, "\n%s", opt->idiff_title);
 		show_interdiff(opt->idiff_oid1, opt->idiff_oid2, 2,
 			       &opt->diffopt);
 
@@ -704,8 +703,7 @@ static void show_diff_of_diff(struct rev_info *opt)
 		memcpy(&dq, &diff_queued_diff, sizeof(diff_queued_diff));
 		DIFF_QUEUE_CLEAR(&diff_queued_diff);
 
-		next_commentary_block(opt, NULL);
-		fprintf_ln(opt->diffopt.file, "%s", opt->rdiff_title);
+		fprintf_ln(opt->diffopt.file, "\n%s", opt->rdiff_title);
 		/*
 		 * Pass minimum required diff-options to range-diff; others
 		 * can be added later if deemed desirable.
@@ -903,8 +901,6 @@ void show_log(struct rev_info *opt)
 	strbuf_release(&msgbuf);
 	free(ctx.notes_message);
 	free(ctx.after_subject);
-
-	show_diff_of_diff(opt);
 }
 
 int log_tree_diff_flush(struct rev_info *opt)
@@ -1173,9 +1169,12 @@ int log_tree_commit(struct rev_info *opt, struct commit *commit)
 	}
 	if (opt->track_linear && !opt->linear && opt->reverse_output_stage)
 		fprintf(opt->diffopt.file, "\n%s\n", opt->break_bar);
+	if (shown)
+		show_diff_of_diff(opt);
 	opt->loginfo = NULL;
 	maybe_flush_or_die(opt->diffopt.file, "stdout");
 	opt->diffopt.no_free = no_free;
+
 	diff_free(&opt->diffopt);
 	return shown;
 }
diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index ba85b582c5..de039825a9 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -2482,13 +2482,37 @@ test_expect_success 'interdiff: reroll-count with a integer' '
 '
 
 test_expect_success 'interdiff: solo-patch' '
-	cat >expect <<-\EOF &&
-	  +fleep
-
-	EOF
 	git format-patch --interdiff=boop~2 -1 boop &&
-	test_grep "^Interdiff:$" 0001-fleep.patch &&
-	sed "1,/^  @@ /d; /^$/q" 0001-fleep.patch >actual &&
+
+	# remove up to the last "patch" output line,
+	# and remove everything below the signature mark.
+	sed -e "1,/^+fleep\$/d" -e "/^-- /,\$d" 0001-fleep.patch >actual &&
+
+	# fabricate Interdiff output.
+	git diff boop~2 boop >inter &&
+	{
+		echo &&
+		echo "Interdiff:" &&
+		sed -e "s/^/  /" inter
+	} >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success 'range-diff: solo-patch' '
+	git format-patch --creation-factor=999 \
+		--range-diff=boop~2..boop~1 -1 boop &&
+
+	# remove up to the last "patch" output line,
+	# and remove everything below the signature mark.
+	sed -e "1,/^+fleep\$/d" -e "/^-- /,\$d" 0001-fleep.patch >actual &&
+
+	# fabricate range-diff output.
+	{
+		echo &&
+		echo "Range-diff:" &&
+		git range-diff --creation-factor=999 \
+			boop~2..boop~1 boop~1..boop
+	} >expect &&
 	test_cmp expect actual
 '
 

Interdiff:
  diff --git a/log-tree.c b/log-tree.c
  index f28c4d0bb0..7de744911e 100644
  --- a/log-tree.c
  +++ b/log-tree.c
  @@ -684,7 +684,7 @@ static void show_diff_of_diff(struct rev_info *opt)
   		memcpy(&dq, &diff_queued_diff, sizeof(diff_queued_diff));
   		DIFF_QUEUE_CLEAR(&diff_queued_diff);
   
  -		fprintf_ln(opt->diffopt.file, "%s", opt->idiff_title);
  +		fprintf_ln(opt->diffopt.file, "\n%s", opt->idiff_title);
   		show_interdiff(opt->idiff_oid1, opt->idiff_oid2, 2,
   			       &opt->diffopt);
   
  @@ -703,7 +703,7 @@ static void show_diff_of_diff(struct rev_info *opt)
   		memcpy(&dq, &diff_queued_diff, sizeof(diff_queued_diff));
   		DIFF_QUEUE_CLEAR(&diff_queued_diff);
   
  -		fprintf_ln(opt->diffopt.file, "%s", opt->rdiff_title);
  +		fprintf_ln(opt->diffopt.file, "\n%s", opt->rdiff_title);
   		/*
   		 * Pass minimum required diff-options to range-diff; others
   		 * can be added later if deemed desirable.
  @@ -1169,11 +1169,11 @@ int log_tree_commit(struct rev_info *opt, struct commit *commit)
   	}
   	if (opt->track_linear && !opt->linear && opt->reverse_output_stage)
   		fprintf(opt->diffopt.file, "\n%s\n", opt->break_bar);
  +	if (shown)
  +		show_diff_of_diff(opt);
   	opt->loginfo = NULL;
   	maybe_flush_or_die(opt->diffopt.file, "stdout");
   	opt->diffopt.no_free = no_free;
  -	if (shown)
  -		show_diff_of_diff(opt);
   
   	diff_free(&opt->diffopt);
   	return shown;
  diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
  index c0c5eccb7c..de039825a9 100755
  --- a/t/t4014-format-patch.sh
  +++ b/t/t4014-format-patch.sh
  @@ -2491,12 +2491,31 @@ test_expect_success 'interdiff: solo-patch' '
   	# fabricate Interdiff output.
   	git diff boop~2 boop >inter &&
   	{
  +		echo &&
   		echo "Interdiff:" &&
   		sed -e "s/^/  /" inter
   	} >expect &&
   	test_cmp expect actual
   '
   
  +test_expect_success 'range-diff: solo-patch' '
  +	git format-patch --creation-factor=999 \
  +		--range-diff=boop~2..boop~1 -1 boop &&
  +
  +	# remove up to the last "patch" output line,
  +	# and remove everything below the signature mark.
  +	sed -e "1,/^+fleep\$/d" -e "/^-- /,\$d" 0001-fleep.patch >actual &&
  +
  +	# fabricate range-diff output.
  +	{
  +		echo &&
  +		echo "Range-diff:" &&
  +		git range-diff --creation-factor=999 \
  +			boop~2..boop~1 boop~1..boop
  +	} >expect &&
  +	test_cmp expect actual
  +'
  +
   test_expect_success 'format-patch does not respect diff.noprefix' '
   	git -c diff.noprefix format-patch -1 --stdout >actual &&
   	grep "^--- a/blorp" actual
-- 
2.45.1-248-g15a88ae3cc

