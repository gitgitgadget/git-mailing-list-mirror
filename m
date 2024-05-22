Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB9D51422A5
	for <git@vger.kernel.org>; Wed, 22 May 2024 17:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716398068; cv=none; b=qTcKjo6drrGAQtIk+0iCKuEgL+K+syx3gNbLiIt+mrQRCg1BN7+7oYx1S7SLShQ0AfJbOw6p8UgnQnt2o9iZG3A6HfjwP01/erpRES7cS+u+8K1zJGkOXEsJa+XdeLLLlrISEPajLX9kTNJPYhA+CGNnFeFPsVLkladjVMxHkq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716398068; c=relaxed/simple;
	bh=+EWLTHc6lH405CmTRoKS8g6Awt4MlnBWSBz/sM23Ex0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=iIoQmZd54XEKIpbDiGwWc0lEHnY19JHCA4jL1l4sY9a4HfAxHnY7NkqwB1C2OA6+mwW3F6OY75KKwviiZj8T+PPFt9wajgn65M/PNEI7j/S2Jhhja5KknrqEFN23hlartCjh3AdCiUoxVNBQxw/cCl9AGIxg0CgGsKt6o3cBkXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=bX647HZt; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="bX647HZt"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A5531187A6;
	Wed, 22 May 2024 13:14:25 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=+EWLTHc6lH405CmTRoKS8g6Awt4MlnBWSBz/sM
	23Ex0=; b=bX647HZtwtUtLzP/DIZnr8C5meB3S3vGPZfuoOhpbZ5NKNrGaAT+l/
	ThnMbH3YX8AE7Pkei+ymC+YQNNQIjDH0Yjke5HMJj/nM5afKC0pbHhFvmgpn95Un
	mAe4KnuDnzw+EV1Q5UpQ/9Zl3yaE2ZtC4YiMRhce7hxU1jVcgERcM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 9E0FA187A5;
	Wed, 22 May 2024 13:14:25 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.173.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0A5F8187A4;
	Wed, 22 May 2024 13:14:24 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>,  Patrick Steinhardt <ps@pks.im>,
    Eric Sunshine <sunshine@sunshineco.com>, Dragan Simic <dsimic@manjaro.org>
Subject: [PATCH v3] add-patch: enforce only one-letter response to prompts
In-Reply-To: <xmqqh6eqiwgf.fsf@gitster.g> (Junio C. Hamano's message of "Tue,
	21 May 2024 16:20:16 -0700")
References: <xmqqr0dvb1sh.fsf_-_@gitster.g> <xmqqh6eqiwgf.fsf@gitster.g>
Date: Wed, 22 May 2024 10:14:23 -0700
Message-ID: <xmqqikz56a6o.fsf_-_@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 BD1DC52A-185E-11EF-A6A6-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

In a "git add -p" session, especially when we are not using the
single-key mode, we may see 'qa' as a response to a prompt

  (1/2) Stage this hunk [y,n,q,a,d,j,J,g,/,e,p,?]?

and then just do the 'q' thing (i.e. quit the session), ignoring
everything other than the first byte.

If 'q' and 'a' are next to each other on the user's keyboard, there
is a plausible chance that we see 'qa' when the user who wanted to
say 'a' fat-fingered and we ended up doing the 'q' thing instead.

As we didn't think of a good reason during the review discussion why
we want to accept excess letters only to ignore them, it appears to
be a safe change to simply reject input that is longer than just one
byte.

The two exceptions are the 'g' command that takes a hunk number, and
the '/' command that takes a regular expression.  They have to be
accompanied by their operands (this makes me wonder how users who
set the interactive.singlekey configuration feed these operands---it
turns out that we notice there is no operand and give them another
chance to type the operand separately, without using single key
input this time), so we accept a string that is more than one byte
long.

Keep the "use only the first byte, downcased" behaviour when we ask
yes/no question, though.  Neither on Qwerty or on Dvorak, 'y' and
'n' are not close to each other.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 The whole range-diff is not worth sharing as the bulk of it show
 the new tests.  The part that shows the changes to the proposed log
 message and the code looks like this:

    @@ Metadata
      ## Commit message ##
         add-patch: enforce only one-letter response to prompts
     
    -    In an "git add -p" session, especially when we are not using the
    -    single-char mode, we may see 'qa' as a response to a prompt
    +    In a "git add -p" session, especially when we are not using the
    +    single-key mode, we may see 'qa' as a response to a prompt
     
           (1/2) Stage this hunk [y,n,q,a,d,j,J,g,/,e,p,?]?
     
    @@ add-patch.c: static int patch_update_file(struct add_p_state *s,
      			continue;
      		ch = tolower(s->answer.buf[0]);
     +
    -+		/* 'g' takes a hunk number, '/' takes a regexp */
    -+		if (1 < s->answer.len && (ch != 'g' && ch != '/')) {
    ++		/* 'g' takes a hunk number and '/' takes a regexp */
    ++		if (s->answer.len != 1 && (ch != 'g' && ch != '/')) {
     +			error(_("only one letter is expected, got '%s'"), s->answer.buf);
     +			continue;
     +		}
      		if (ch == 'y') {
      			hunk->use = USE_HUNK;
      soft_increment:
     
 add-patch.c                |  7 +++++++
 t/t3701-add-interactive.sh | 38 ++++++++++++++++++++++++++++++++++++--
 2 files changed, 43 insertions(+), 2 deletions(-)

diff --git a/add-patch.c b/add-patch.c
index 79eda168eb..7242da2c03 100644
--- a/add-patch.c
+++ b/add-patch.c
@@ -1228,6 +1228,7 @@ static int prompt_yesno(struct add_p_state *s, const char *prompt)
 		fflush(stdout);
 		if (read_single_character(s) == EOF)
 			return -1;
+		/* do not limit to 1-byte input to allow 'no' etc. */
 		switch (tolower(s->answer.buf[0])) {
 		case 'n': return 0;
 		case 'y': return 1;
@@ -1506,6 +1507,12 @@ static int patch_update_file(struct add_p_state *s,
 		if (!s->answer.len)
 			continue;
 		ch = tolower(s->answer.buf[0]);
+
+		/* 'g' takes a hunk number and '/' takes a regexp */
+		if (s->answer.len != 1 && (ch != 'g' && ch != '/')) {
+			error(_("only one letter is expected, got '%s'"), s->answer.buf);
+			continue;
+		}
 		if (ch == 'y') {
 			hunk->use = USE_HUNK;
 soft_increment:
diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
index 0b5339ac6c..61f5e9eec0 100755
--- a/t/t3701-add-interactive.sh
+++ b/t/t3701-add-interactive.sh
@@ -144,6 +144,14 @@ test_expect_success 'revert works (commit)' '
 	grep "unchanged *+3/-0 file" output
 '
 
+test_expect_success 'reject multi-key input' '
+	saved=$(git hash-object -w file) &&
+	test_when_finished "git cat-file blob $saved >file" &&
+	echo an extra line >>file &&
+	test_write_lines aa | git add -p >actual 2>error &&
+	test_grep "error: .* got ${SQ}aa${SQ}" error
+'
+
 test_expect_success 'setup expected' '
 	cat >expected <<-\EOF
 	EOF
@@ -511,7 +519,7 @@ test_expect_success 'split hunk setup' '
 	test_write_lines 10 15 20 21 22 23 24 30 40 50 60 >test
 '
 
-test_expect_success 'goto hunk' '
+test_expect_success 'goto hunk 1 with "g 1"' '
 	test_when_finished "git reset" &&
 	tr _ " " >expect <<-EOF &&
 	(2/2) Stage this hunk [y,n,q,a,d,K,g,/,e,?]? + 1:  -1,2 +1,3          +15
@@ -527,7 +535,20 @@ test_expect_success 'goto hunk' '
 	test_cmp expect actual.trimmed
 '
 
-test_expect_success 'navigate to hunk via regex' '
+test_expect_success 'goto hunk 1 with "g1"' '
+	test_when_finished "git reset" &&
+	tr _ " " >expect <<-EOF &&
+	_10
+	+15
+	_20
+	(1/2) Stage this hunk [y,n,q,a,d,j,J,g,/,e,?]?_
+	EOF
+	test_write_lines s y g1 | git add -p >actual &&
+	tail -n 4 <actual >actual.trimmed &&
+	test_cmp expect actual.trimmed
+'
+
+test_expect_success 'navigate to hunk via regex /pattern' '
 	test_when_finished "git reset" &&
 	tr _ " " >expect <<-EOF &&
 	(2/2) Stage this hunk [y,n,q,a,d,K,g,/,e,?]? @@ -1,2 +1,3 @@
@@ -541,6 +562,19 @@ test_expect_success 'navigate to hunk via regex' '
 	test_cmp expect actual.trimmed
 '
 
+test_expect_success 'navigate to hunk via regex / pattern' '
+	test_when_finished "git reset" &&
+	tr _ " " >expect <<-EOF &&
+	_10
+	+15
+	_20
+	(1/2) Stage this hunk [y,n,q,a,d,j,J,g,/,e,?]?_
+	EOF
+	test_write_lines s y / 1,2 | git add -p >actual &&
+	tail -n 4 <actual >actual.trimmed &&
+	test_cmp expect actual.trimmed
+'
+
 test_expect_success 'split hunk "add -p (edit)"' '
 	# Split, say Edit and do nothing.  Then:
 	#
-- 
2.45.1-216-g4365c6fcf9
