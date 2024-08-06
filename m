Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90CC674E26
	for <git@vger.kernel.org>; Tue,  6 Aug 2024 17:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722963859; cv=none; b=fRmElY/mrYKsG6YWBXckxuTJU31DqwY/eeflYU7GuoW+fM6sLsrVcRk8j+SPBrF8jmcKCPygqrobS2mQF9ujWbgBnjI1a89eQpXpYT+eDvJ5itELWdl+e4TxnBGstOLlMMTF1aP28o4j9jBizi5pmGl69yHcUZSbaDtu+nSg6hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722963859; c=relaxed/simple;
	bh=TS7k5YGER+pdduQxlq1kEKJf0VQY/vYN6q48HEePEWs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PpFfB44RICCgKxwLI0CwBRRAa8iizIrTBkHbn+D+Df09K8OVvPv0ti0RnSStmxH37YTYiRLyCuauG/417NcDkFOKsIkZqn0rtqOcuAnsgyPFUWAXDG0IrGQm/dUTG6b+9PZre9Gy15Czxke034gd0HYZ/QcRy9zmvx7TvyswYa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=mBFYJJ73; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="mBFYJJ73"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 663362F1AF;
	Tue,  6 Aug 2024 13:04:16 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=TS7k5YGER+pdduQxlq1kEKJf0VQY/vYN6q48HE
	ePEWs=; b=mBFYJJ73KlT9HuKaOpG4qtVLHN8iKfoaaYGCuHn+MapNt49f7n9AWb
	GtOqxGAAiQDbrQVsp1EaB6R8us0U8Y3JR0if7ekCgb26B9z2utWfSdF1rw90To0X
	jGzk28VLLEDryRAIPrSMT1giYELnDPbGW587+aFTScsZIqB3Z5k+A=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 5EC3C2F1AE;
	Tue,  6 Aug 2024 13:04:16 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A8C4C2F1AD;
	Tue,  6 Aug 2024 13:04:15 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2] t3206: test_when_finished before dirtying operations,
 not after
In-Reply-To: <xmqqttfyzd01.fsf@gitster.g> (Junio C. Hamano's message of "Mon,
	05 Aug 2024 17:55:10 -0700")
References: <xmqqttfyzd01.fsf@gitster.g>
Date: Tue, 06 Aug 2024 10:04:13 -0700
Message-ID: <xmqqwmkttwfm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 E94F9CA2-5415-11EF-95EE-9B0F950A682E-77302942!pb-smtp2.pobox.com

Many existing tests in this script perform operation(s) and then use
test_when_finished to define how to undo the effect of the
operation(s).

This is backwards.  When your operation(s) fail before you manage to
successfully call test_when_finished (remember, that these commands
must be all &&-chained, so a failure of an earlier operation mean
your test_when_finished may not be executed at all).  You must
establish how to clean up your mess with test_when_finished before
you create the mess to be cleaned up.

Also make sure that the body of test_when_finished deals with case
where the cruft it wants to remove failed to be created, by using
"rm -f" (instead of "rm") to remove potential cruft files, and
having "|| :" after "git notes remove" to remove potential cruft
notes---both of these by default fail when asked to remove something
that does not exist, instead of being silently idempotent no-ops.

Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 * a range-diff appears at the end.  The last paragraph of the
   proposed log message is new, and the differences in patch text
   are about making sure test_when_finished commands are prepared
   for their body failing.

 t/t3206-range-diff.sh | 52 +++++++++++++++++++++----------------------
 1 file changed, 26 insertions(+), 26 deletions(-)

diff --git a/t/t3206-range-diff.sh b/t/t3206-range-diff.sh
index a767c3520e..d2ca43d6aa 100755
--- a/t/t3206-range-diff.sh
+++ b/t/t3206-range-diff.sh
@@ -533,9 +533,9 @@ test_expect_success 'dual-coloring' '
 for prev in topic main..topic
 do
 	test_expect_success "format-patch --range-diff=$prev" '
+		test_when_finished "rm -f 000?-*" &&
 		git format-patch --cover-letter --range-diff=$prev \
 			main..unmodified >actual &&
-		test_when_finished "rm 000?-*" &&
 		test_line_count = 5 actual &&
 		test_grep "^Range-diff:$" 0000-* &&
 		grep "= 1: .* s/5/A" 0000-* &&
@@ -560,32 +560,32 @@ test_expect_success "explicit --no-cover-letter defeats implied --cover-letter"
 '
 
 test_expect_success 'format-patch --range-diff as commentary' '
+	test_when_finished "rm -f 0001-*" &&
 	git format-patch --range-diff=HEAD~1 HEAD~1 >actual &&
-	test_when_finished "rm 0001-*" &&
 	test_line_count = 1 actual &&
 	test_grep "^Range-diff:$" 0001-* &&
 	grep "> 1: .* new message" 0001-*
 '
 
 test_expect_success 'format-patch --range-diff reroll-count with a non-integer' '
+	test_when_finished "rm -f v2.9-0001-*" &&
 	git format-patch --range-diff=HEAD~1 -v2.9 HEAD~1 >actual &&
-	test_when_finished "rm v2.9-0001-*" &&
 	test_line_count = 1 actual &&
 	test_grep "^Range-diff:$" v2.9-0001-* &&
 	grep "> 1: .* new message" v2.9-0001-*
 '
 
 test_expect_success 'format-patch --range-diff reroll-count with a integer' '
+	test_when_finished "rm -f v2-0001-*" &&
 	git format-patch --range-diff=HEAD~1 -v2 HEAD~1 >actual &&
-	test_when_finished "rm v2-0001-*" &&
 	test_line_count = 1 actual &&
 	test_grep "^Range-diff ..* v1:$" v2-0001-* &&
 	grep "> 1: .* new message" v2-0001-*
 '
 
 test_expect_success 'format-patch --range-diff with v0' '
+	test_when_finished "rm -f v0-0001-*" &&
 	git format-patch --range-diff=HEAD~1 -v0 HEAD~1 >actual &&
-	test_when_finished "rm v0-0001-*" &&
 	test_line_count = 1 actual &&
 	test_grep "^Range-diff:$" v0-0001-* &&
 	grep "> 1: .* new message" v0-0001-*
@@ -606,9 +606,9 @@ test_expect_success 'basic with modified format.pretty without "commit "' '
 '
 
 test_expect_success 'range-diff compares notes by default' '
+	test_when_finished "git notes remove topic unmodified || :" &&
 	git notes add -m "topic note" topic &&
 	git notes add -m "unmodified note" unmodified &&
-	test_when_finished git notes remove topic unmodified &&
 	git range-diff --no-color main..topic main..unmodified \
 		>actual &&
 	sed s/Z/\ /g >expect <<-EOF &&
@@ -630,9 +630,9 @@ test_expect_success 'range-diff compares notes by default' '
 '
 
 test_expect_success 'range-diff with --no-notes' '
+	test_when_finished "git notes remove topic unmodified || :" &&
 	git notes add -m "topic note" topic &&
 	git notes add -m "unmodified note" unmodified &&
-	test_when_finished git notes remove topic unmodified &&
 	git range-diff --no-color --no-notes main..topic main..unmodified \
 		>actual &&
 	cat >expect <<-EOF &&
@@ -645,12 +645,12 @@ test_expect_success 'range-diff with --no-notes' '
 '
 
 test_expect_success 'range-diff with multiple --notes' '
+	test_when_finished "git notes --ref=note1 remove topic unmodified || :" &&
 	git notes --ref=note1 add -m "topic note1" topic &&
 	git notes --ref=note1 add -m "unmodified note1" unmodified &&
-	test_when_finished git notes --ref=note1 remove topic unmodified &&
+	test_when_finished "git notes --ref=note2 remove topic unmodified || :" &&
 	git notes --ref=note2 add -m "topic note2" topic &&
 	git notes --ref=note2 add -m "unmodified note2" unmodified &&
-	test_when_finished git notes --ref=note2 remove topic unmodified &&
 	git range-diff --no-color --notes=note1 --notes=note2 main..topic main..unmodified \
 		>actual &&
 	sed s/Z/\ /g >expect <<-EOF &&
@@ -678,12 +678,12 @@ test_expect_success 'range-diff with multiple --notes' '
 
 # `range-diff` should act like `log` with regards to notes
 test_expect_success 'range-diff with --notes=custom does not show default notes' '
+	test_when_finished "git notes remove topic unmodified || :" &&
 	git notes add -m "topic note" topic &&
 	git notes add -m "unmodified note" unmodified &&
+	test_when_finished "git notes --ref=custom remove topic unmodified || :" &&
 	git notes --ref=custom add -m "topic note" topic &&
 	git notes --ref=custom add -m "unmodified note" unmodified &&
-	test_when_finished git notes remove topic unmodified &&
-	test_when_finished git notes --ref=custom remove topic unmodified &&
 	git range-diff --notes=custom main..topic main..unmodified \
 		>actual &&
 	! grep "## Notes ##" actual &&
@@ -691,12 +691,12 @@ test_expect_success 'range-diff with --notes=custom does not show default notes'
 '
 
 test_expect_success 'format-patch --range-diff does not compare notes by default' '
+	test_when_finished "git notes remove topic unmodified || :" &&
 	git notes add -m "topic note" topic &&
 	git notes add -m "unmodified note" unmodified &&
-	test_when_finished git notes remove topic unmodified &&
+	test_when_finished "rm -f 000?-*" &&
 	git format-patch --cover-letter --range-diff=$prev \
 		main..unmodified >actual &&
-	test_when_finished "rm 000?-*" &&
 	test_line_count = 5 actual &&
 	test_grep "^Range-diff:$" 0000-* &&
 	grep "= 1: .* s/5/A" 0000-* &&
@@ -708,26 +708,26 @@ test_expect_success 'format-patch --range-diff does not compare notes by default
 '
 
 test_expect_success 'format-patch --notes=custom --range-diff only compares custom notes' '
+	test_when_finished "git notes remove topic unmodified || :" &&
 	git notes add -m "topic note" topic &&
-	git notes --ref=custom add -m "topic note (custom)" topic &&
 	git notes add -m "unmodified note" unmodified &&
+	test_when_finished "git notes --ref=custom remove topic unmodified || :" &&
+	git notes --ref=custom add -m "topic note (custom)" topic &&
 	git notes --ref=custom add -m "unmodified note (custom)" unmodified &&
-	test_when_finished git notes remove topic unmodified &&
-	test_when_finished git notes --ref=custom remove topic unmodified &&
+	test_when_finished "rm -f 000?-*" &&
 	git format-patch --notes=custom --cover-letter --range-diff=$prev \
 		main..unmodified >actual &&
-	test_when_finished "rm 000?-*" &&
 	grep "## Notes (custom) ##" 0000-* &&
 	! grep "## Notes ##" 0000-*
 '
 
 test_expect_success 'format-patch --range-diff with --no-notes' '
+	test_when_finished "git notes remove topic unmodified || :" &&
 	git notes add -m "topic note" topic &&
 	git notes add -m "unmodified note" unmodified &&
-	test_when_finished git notes remove topic unmodified &&
+	test_when_finished "rm -f 000?-*" &&
 	git format-patch --no-notes --cover-letter --range-diff=$prev \
 		main..unmodified >actual &&
-	test_when_finished "rm 000?-*" &&
 	test_line_count = 5 actual &&
 	test_grep "^Range-diff:$" 0000-* &&
 	grep "= 1: .* s/5/A" 0000-* &&
@@ -739,12 +739,12 @@ test_expect_success 'format-patch --range-diff with --no-notes' '
 '
 
 test_expect_success 'format-patch --range-diff with --notes' '
+	test_when_finished "git notes remove topic unmodified || :" &&
 	git notes add -m "topic note" topic &&
 	git notes add -m "unmodified note" unmodified &&
-	test_when_finished git notes remove topic unmodified &&
+	test_when_finished "rm -f 000?-*" &&
 	git format-patch --notes --cover-letter --range-diff=$prev \
 		main..unmodified >actual &&
-	test_when_finished "rm 000?-*" &&
 	test_line_count = 5 actual &&
 	test_grep "^Range-diff:$" 0000-* &&
 	grep "= 1: .* s/5/A" 0000-* &&
@@ -767,13 +767,13 @@ test_expect_success 'format-patch --range-diff with --notes' '
 '
 
 test_expect_success 'format-patch --range-diff with format.notes config' '
+	test_when_finished "git notes remove topic unmodified || :" &&
 	git notes add -m "topic note" topic &&
 	git notes add -m "unmodified note" unmodified &&
-	test_when_finished git notes remove topic unmodified &&
 	test_config format.notes true &&
+	test_when_finished "rm -f 000?-*" &&
 	git format-patch --cover-letter --range-diff=$prev \
 		main..unmodified >actual &&
-	test_when_finished "rm 000?-*" &&
 	test_line_count = 5 actual &&
 	test_grep "^Range-diff:$" 0000-* &&
 	grep "= 1: .* s/5/A" 0000-* &&
@@ -796,15 +796,15 @@ test_expect_success 'format-patch --range-diff with format.notes config' '
 '
 
 test_expect_success 'format-patch --range-diff with multiple notes' '
+	test_when_finished "git notes --ref=note1 remove topic unmodified || :" &&
 	git notes --ref=note1 add -m "topic note1" topic &&
 	git notes --ref=note1 add -m "unmodified note1" unmodified &&
-	test_when_finished git notes --ref=note1 remove topic unmodified &&
+	test_when_finished "git notes --ref=note2 remove topic unmodified || :" &&
 	git notes --ref=note2 add -m "topic note2" topic &&
 	git notes --ref=note2 add -m "unmodified note2" unmodified &&
-	test_when_finished git notes --ref=note2 remove topic unmodified &&
+	test_when_finished "rm -f 000?-*" &&
 	git format-patch --notes=note1 --notes=note2 --cover-letter --range-diff=$prev \
 		main..unmodified >actual &&
-	test_when_finished "rm 000?-*" &&
 	test_line_count = 5 actual &&
 	test_grep "^Range-diff:$" 0000-* &&
 	grep "= 1: .* s/5/A" 0000-* &&

Range-diff:
1:  591c4d512f ! 1:  3a3c1a1a44 t3206: test_when_finished before dirtying operations, not after
    @@ Commit message
         establish how to clean up your mess with test_when_finished before
         you create the mess to be cleaned up.
     
    +    Also make sure that the body of test_when_finished deals with case
    +    where the cruft it wants to remove failed to be created, by using
    +    "rm -f" (instead of "rm") to remove potential cruft files, and
    +    having "|| :" after "git notes remove" to remove potential cruft
    +    notes---both of these by default fail when asked to remove something
    +    that does not exist, instead of being silently idempotent no-ops.
    +
    +    Helped-by: Eric Sunshine <sunshine@sunshineco.com>
         Signed-off-by: Junio C Hamano <gitster@pobox.com>
     
      ## t/t3206-range-diff.sh ##
    @@ t/t3206-range-diff.sh: test_expect_success 'dual-coloring' '
      for prev in topic main..topic
      do
      	test_expect_success "format-patch --range-diff=$prev" '
    -+		test_when_finished "rm 000?-*" &&
    ++		test_when_finished "rm -f 000?-*" &&
      		git format-patch --cover-letter --range-diff=$prev \
      			main..unmodified >actual &&
     -		test_when_finished "rm 000?-*" &&
    @@ t/t3206-range-diff.sh: test_expect_success "explicit --no-cover-letter defeats i
      '
      
      test_expect_success 'format-patch --range-diff as commentary' '
    --	git format-patch --range-diff=HEAD~1 HEAD~1 >actual &&
    - 	test_when_finished "rm 0001-*" &&
    -+	git format-patch --range-diff=HEAD~1 HEAD~1 >actual &&
    ++	test_when_finished "rm -f 0001-*" &&
    + 	git format-patch --range-diff=HEAD~1 HEAD~1 >actual &&
    +-	test_when_finished "rm 0001-*" &&
      	test_line_count = 1 actual &&
      	test_grep "^Range-diff:$" 0001-* &&
      	grep "> 1: .* new message" 0001-*
      '
      
      test_expect_success 'format-patch --range-diff reroll-count with a non-integer' '
    --	git format-patch --range-diff=HEAD~1 -v2.9 HEAD~1 >actual &&
    - 	test_when_finished "rm v2.9-0001-*" &&
    -+	git format-patch --range-diff=HEAD~1 -v2.9 HEAD~1 >actual &&
    ++	test_when_finished "rm -f v2.9-0001-*" &&
    + 	git format-patch --range-diff=HEAD~1 -v2.9 HEAD~1 >actual &&
    +-	test_when_finished "rm v2.9-0001-*" &&
      	test_line_count = 1 actual &&
      	test_grep "^Range-diff:$" v2.9-0001-* &&
      	grep "> 1: .* new message" v2.9-0001-*
      '
      
      test_expect_success 'format-patch --range-diff reroll-count with a integer' '
    --	git format-patch --range-diff=HEAD~1 -v2 HEAD~1 >actual &&
    - 	test_when_finished "rm v2-0001-*" &&
    -+	git format-patch --range-diff=HEAD~1 -v2 HEAD~1 >actual &&
    ++	test_when_finished "rm -f v2-0001-*" &&
    + 	git format-patch --range-diff=HEAD~1 -v2 HEAD~1 >actual &&
    +-	test_when_finished "rm v2-0001-*" &&
      	test_line_count = 1 actual &&
      	test_grep "^Range-diff ..* v1:$" v2-0001-* &&
      	grep "> 1: .* new message" v2-0001-*
      '
      
      test_expect_success 'format-patch --range-diff with v0' '
    --	git format-patch --range-diff=HEAD~1 -v0 HEAD~1 >actual &&
    - 	test_when_finished "rm v0-0001-*" &&
    -+	git format-patch --range-diff=HEAD~1 -v0 HEAD~1 >actual &&
    ++	test_when_finished "rm -f v0-0001-*" &&
    + 	git format-patch --range-diff=HEAD~1 -v0 HEAD~1 >actual &&
    +-	test_when_finished "rm v0-0001-*" &&
      	test_line_count = 1 actual &&
      	test_grep "^Range-diff:$" v0-0001-* &&
      	grep "> 1: .* new message" v0-0001-*
    @@ t/t3206-range-diff.sh: test_expect_success 'basic with modified format.pretty wi
      '
      
      test_expect_success 'range-diff compares notes by default' '
    -+	test_when_finished git notes remove topic unmodified &&
    ++	test_when_finished "git notes remove topic unmodified || :" &&
      	git notes add -m "topic note" topic &&
      	git notes add -m "unmodified note" unmodified &&
     -	test_when_finished git notes remove topic unmodified &&
    @@ t/t3206-range-diff.sh: test_expect_success 'range-diff compares notes by default
      '
      
      test_expect_success 'range-diff with --no-notes' '
    -+	test_when_finished git notes remove topic unmodified &&
    ++	test_when_finished "git notes remove topic unmodified || :" &&
      	git notes add -m "topic note" topic &&
      	git notes add -m "unmodified note" unmodified &&
     -	test_when_finished git notes remove topic unmodified &&
    @@ t/t3206-range-diff.sh: test_expect_success 'range-diff with --no-notes' '
      '
      
      test_expect_success 'range-diff with multiple --notes' '
    -+	test_when_finished git notes --ref=note1 remove topic unmodified &&
    ++	test_when_finished "git notes --ref=note1 remove topic unmodified || :" &&
      	git notes --ref=note1 add -m "topic note1" topic &&
      	git notes --ref=note1 add -m "unmodified note1" unmodified &&
     -	test_when_finished git notes --ref=note1 remove topic unmodified &&
    -+	test_when_finished git notes --ref=note2 remove topic unmodified &&
    ++	test_when_finished "git notes --ref=note2 remove topic unmodified || :" &&
      	git notes --ref=note2 add -m "topic note2" topic &&
      	git notes --ref=note2 add -m "unmodified note2" unmodified &&
     -	test_when_finished git notes --ref=note2 remove topic unmodified &&
    @@ t/t3206-range-diff.sh: test_expect_success 'range-diff with multiple --notes' '
      
      # `range-diff` should act like `log` with regards to notes
      test_expect_success 'range-diff with --notes=custom does not show default notes' '
    -+	test_when_finished git notes remove topic unmodified &&
    ++	test_when_finished "git notes remove topic unmodified || :" &&
      	git notes add -m "topic note" topic &&
      	git notes add -m "unmodified note" unmodified &&
    -+	test_when_finished git notes --ref=custom remove topic unmodified &&
    ++	test_when_finished "git notes --ref=custom remove topic unmodified || :" &&
      	git notes --ref=custom add -m "topic note" topic &&
      	git notes --ref=custom add -m "unmodified note" unmodified &&
     -	test_when_finished git notes remove topic unmodified &&
    @@ t/t3206-range-diff.sh: test_expect_success 'range-diff with --notes=custom does
      '
      
      test_expect_success 'format-patch --range-diff does not compare notes by default' '
    -+	test_when_finished git notes remove topic unmodified &&
    ++	test_when_finished "git notes remove topic unmodified || :" &&
      	git notes add -m "topic note" topic &&
      	git notes add -m "unmodified note" unmodified &&
     -	test_when_finished git notes remove topic unmodified &&
    -+	test_when_finished "rm 000?-*" &&
    ++	test_when_finished "rm -f 000?-*" &&
      	git format-patch --cover-letter --range-diff=$prev \
      		main..unmodified >actual &&
     -	test_when_finished "rm 000?-*" &&
    @@ t/t3206-range-diff.sh: test_expect_success 'format-patch --range-diff does not c
      '
      
      test_expect_success 'format-patch --notes=custom --range-diff only compares custom notes' '
    -+	test_when_finished git notes remove topic unmodified &&
    ++	test_when_finished "git notes remove topic unmodified || :" &&
      	git notes add -m "topic note" topic &&
     -	git notes --ref=custom add -m "topic note (custom)" topic &&
      	git notes add -m "unmodified note" unmodified &&
    --	git notes --ref=custom add -m "unmodified note (custom)" unmodified &&
    --	test_when_finished git notes remove topic unmodified &&
    - 	test_when_finished git notes --ref=custom remove topic unmodified &&
    ++	test_when_finished "git notes --ref=custom remove topic unmodified || :" &&
     +	git notes --ref=custom add -m "topic note (custom)" topic &&
    -+	git notes --ref=custom add -m "unmodified note (custom)" unmodified &&
    -+	test_when_finished "rm 000?-*" &&
    + 	git notes --ref=custom add -m "unmodified note (custom)" unmodified &&
    +-	test_when_finished git notes remove topic unmodified &&
    +-	test_when_finished git notes --ref=custom remove topic unmodified &&
    ++	test_when_finished "rm -f 000?-*" &&
      	git format-patch --notes=custom --cover-letter --range-diff=$prev \
      		main..unmodified >actual &&
     -	test_when_finished "rm 000?-*" &&
    @@ t/t3206-range-diff.sh: test_expect_success 'format-patch --range-diff does not c
      '
      
      test_expect_success 'format-patch --range-diff with --no-notes' '
    -+	test_when_finished git notes remove topic unmodified &&
    ++	test_when_finished "git notes remove topic unmodified || :" &&
      	git notes add -m "topic note" topic &&
      	git notes add -m "unmodified note" unmodified &&
     -	test_when_finished git notes remove topic unmodified &&
    -+	test_when_finished "rm 000?-*" &&
    ++	test_when_finished "rm -f 000?-*" &&
      	git format-patch --no-notes --cover-letter --range-diff=$prev \
      		main..unmodified >actual &&
     -	test_when_finished "rm 000?-*" &&
    @@ t/t3206-range-diff.sh: test_expect_success 'format-patch --range-diff with --no-
      '
      
      test_expect_success 'format-patch --range-diff with --notes' '
    -+	test_when_finished git notes remove topic unmodified &&
    ++	test_when_finished "git notes remove topic unmodified || :" &&
      	git notes add -m "topic note" topic &&
      	git notes add -m "unmodified note" unmodified &&
     -	test_when_finished git notes remove topic unmodified &&
    -+	test_when_finished "rm 000?-*" &&
    ++	test_when_finished "rm -f 000?-*" &&
      	git format-patch --notes --cover-letter --range-diff=$prev \
      		main..unmodified >actual &&
     -	test_when_finished "rm 000?-*" &&
    @@ t/t3206-range-diff.sh: test_expect_success 'format-patch --range-diff with --not
      '
      
      test_expect_success 'format-patch --range-diff with format.notes config' '
    -+	test_when_finished git notes remove topic unmodified &&
    ++	test_when_finished "git notes remove topic unmodified || :" &&
      	git notes add -m "topic note" topic &&
      	git notes add -m "unmodified note" unmodified &&
     -	test_when_finished git notes remove topic unmodified &&
      	test_config format.notes true &&
    -+	test_when_finished "rm 000?-*" &&
    ++	test_when_finished "rm -f 000?-*" &&
      	git format-patch --cover-letter --range-diff=$prev \
      		main..unmodified >actual &&
     -	test_when_finished "rm 000?-*" &&
    @@ t/t3206-range-diff.sh: test_expect_success 'format-patch --range-diff with forma
      '
      
      test_expect_success 'format-patch --range-diff with multiple notes' '
    -+	test_when_finished git notes --ref=note1 remove topic unmodified &&
    ++	test_when_finished "git notes --ref=note1 remove topic unmodified || :" &&
      	git notes --ref=note1 add -m "topic note1" topic &&
      	git notes --ref=note1 add -m "unmodified note1" unmodified &&
     -	test_when_finished git notes --ref=note1 remove topic unmodified &&
    -+	test_when_finished git notes --ref=note2 remove topic unmodified &&
    ++	test_when_finished "git notes --ref=note2 remove topic unmodified || :" &&
      	git notes --ref=note2 add -m "topic note2" topic &&
      	git notes --ref=note2 add -m "unmodified note2" unmodified &&
     -	test_when_finished git notes --ref=note2 remove topic unmodified &&
    -+	test_when_finished "rm 000?-*" &&
    ++	test_when_finished "rm -f 000?-*" &&
      	git format-patch --notes=note1 --notes=note2 --cover-letter --range-diff=$prev \
      		main..unmodified >actual &&
     -	test_when_finished "rm 000?-*" &&
-- 
2.46.0-235-g968ce1ce0e

