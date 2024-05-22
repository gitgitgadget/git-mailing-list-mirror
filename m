Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F8D17AE5D
	for <git@vger.kernel.org>; Wed, 22 May 2024 21:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716414353; cv=none; b=rQNcaTkYHodGOHEHhJGcLitU2ikfOpThUw4/lADZbhI6vRoAjb19kQGSxAMcyGLWUBI6ti4A2TQiZNpeqZcleUvrC94APUrk5ThTP0E8KVYCEFYRy925etuDd11FlLxsLPu2Ai7FcjaNuS2DGeOSBiu/1Jr4L8cHxRApgJCP8H8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716414353; c=relaxed/simple;
	bh=o5829vIwHayl7va+0wn2DDut88ImaIKehHyPIxp4eZc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cVwKpzfgCQsVghWRmwTotbLCgMAj4iNqSmDI3vkpOKDNBpnzxeRBSu+phphzxv0EJbT7L+O/aawiJDG1vOo6ywEEYMO6kzavj6ZwBi23MKNIfZ14Pd4nB79PSfSpxpslyIyz6rFcDr63voMX3SXnA8Hr/WlRmJy+5xQnKhL5tCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=nS/1P2ho; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="nS/1P2ho"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id EA19C2B586;
	Wed, 22 May 2024 17:45:49 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=o5829vIwHayl7va+0wn2DDut88ImaIKehHyPIx
	p4eZc=; b=nS/1P2hoi3q8rl+cvmt4quG8U+ATUXzX0Lr37Jmnec/3lmYLJe9jxi
	hYDKwcBIok7sbJGqj3LKtMTcHg4q0UQBgg4AWQLl5ymnhycczEpGrKY+ujNdTlgV
	J07gFId/+B1LYwLqgZQ4rz/+4Ry+I/amjkFDVgFRNbgttlMPIXeEk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id E15882B585;
	Wed, 22 May 2024 17:45:49 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.173.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 3F2572B584;
	Wed, 22 May 2024 17:45:49 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>,  Patrick Steinhardt <ps@pks.im>,  Eric
 Sunshine <sunshine@sunshineco.com>,  Dragan Simic <dsimic@manjaro.org>
Subject: [PATCH v4] add-patch: enforce only one-letter response to prompts
In-Reply-To: <xmqqikz56a6o.fsf_-_@gitster.g> (Junio C. Hamano's message of
	"Wed, 22 May 2024 10:14:23 -0700")
References: <xmqqr0dvb1sh.fsf_-_@gitster.g> <xmqqh6eqiwgf.fsf@gitster.g>
	<xmqqikz56a6o.fsf_-_@gitster.g>
Date: Wed, 22 May 2024 14:45:48 -0700
Message-ID: <xmqqh6ep1pwz.fsf_-_@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 A7444780-1884-11EF-8A15-25B3960A682E-77302942!pb-smtp2.pobox.com

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
 * Hopefully the final iteration.  The differences are:

   - The end-user facing "here is what is wrong with your input"
     message is given with err() to be consistent with other such
     messages.

   - I gave up basing this on v2.44.0, as it is a new feature that
     does not have to be merged down to older maintenance tracks.
     This is now based on 80dbfac2 (Merge branch
     'rj/add-p-typo-reaction', 2024-05-08), which is before v2.45.1
     but has modern enough t3701 and add-patch.c:err() sends its
     output to the standard output stream.

   - The tests for 'g' and '/' to check both the stuck and the split
     forms have been updated for the more recent prompt that
     includes 'p'.

   - The test for multi-key sequence expects the err() output on the
     standard output stream.

   As an experiment, this message has the range-diff at the end, not
   before the primary part of the patch text.  I think this format
   should be easier to read for reviewers.

 add-patch.c                |  7 +++++++
 t/t3701-add-interactive.sh | 38 ++++++++++++++++++++++++++++++++++++--
 2 files changed, 43 insertions(+), 2 deletions(-)

diff --git a/add-patch.c b/add-patch.c
index 2252895c28..814de57c4a 100644
--- a/add-patch.c
+++ b/add-patch.c
@@ -1227,6 +1227,7 @@ static int prompt_yesno(struct add_p_state *s, const char *prompt)
 		fflush(stdout);
 		if (read_single_character(s) == EOF)
 			return -1;
+		/* do not limit to 1-byte input to allow 'no' etc. */
 		switch (tolower(s->answer.buf[0])) {
 		case 'n': return 0;
 		case 'y': return 1;
@@ -1510,6 +1511,12 @@ static int patch_update_file(struct add_p_state *s,
 		if (!s->answer.len)
 			continue;
 		ch = tolower(s->answer.buf[0]);
+
+		/* 'g' takes a hunk number and '/' takes a regexp */
+		if (s->answer.len != 1 && (ch != 'g' && ch != '/')) {
+			err(s, _("Only one letter is expected, got '%s'"), s->answer.buf);
+			continue;
+		}
 		if (ch == 'y') {
 			hunk->use = USE_HUNK;
 soft_increment:
diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
index 28a95a775d..6624a4f7c0 100755
--- a/t/t3701-add-interactive.sh
+++ b/t/t3701-add-interactive.sh
@@ -160,6 +160,14 @@ test_expect_success 'revert works (commit)' '
 	grep "unchanged *+3/-0 file" output
 '
 
+test_expect_success 'reject multi-key input' '
+	saved=$(git hash-object -w file) &&
+	test_when_finished "git cat-file blob $saved >file" &&
+	echo an extra line >>file &&
+	test_write_lines aa | git add -p >actual &&
+	test_grep "is expected, got ${SQ}aa${SQ}" actual
+'
+
 test_expect_success 'setup expected' '
 	cat >expected <<-\EOF
 	EOF
@@ -526,7 +534,7 @@ test_expect_success 'split hunk setup' '
 	test_write_lines 10 15 20 21 22 23 24 30 40 50 60 >test
 '
 
-test_expect_success 'goto hunk' '
+test_expect_success 'goto hunk 1 with "g 1"' '
 	test_when_finished "git reset" &&
 	tr _ " " >expect <<-EOF &&
 	(2/2) Stage this hunk [y,n,q,a,d,K,g,/,e,p,?]? + 1:  -1,2 +1,3          +15
@@ -542,7 +550,20 @@ test_expect_success 'goto hunk' '
 	test_cmp expect actual.trimmed
 '
 
-test_expect_success 'navigate to hunk via regex' '
+test_expect_success 'goto hunk 1 with "g1"' '
+	test_when_finished "git reset" &&
+	tr _ " " >expect <<-EOF &&
+	_10
+	+15
+	_20
+	(1/2) Stage this hunk [y,n,q,a,d,j,J,g,/,e,p,?]?_
+	EOF
+	test_write_lines s y g1 | git add -p >actual &&
+	tail -n 4 <actual >actual.trimmed &&
+	test_cmp expect actual.trimmed
+'
+
+test_expect_success 'navigate to hunk via regex /pattern' '
 	test_when_finished "git reset" &&
 	tr _ " " >expect <<-EOF &&
 	(2/2) Stage this hunk [y,n,q,a,d,K,g,/,e,p,?]? @@ -1,2 +1,3 @@
@@ -556,6 +577,19 @@ test_expect_success 'navigate to hunk via regex' '
 	test_cmp expect actual.trimmed
 '
 
+test_expect_success 'navigate to hunk via regex / pattern' '
+	test_when_finished "git reset" &&
+	tr _ " " >expect <<-EOF &&
+	_10
+	+15
+	_20
+	(1/2) Stage this hunk [y,n,q,a,d,j,J,g,/,e,p,?]?_
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

(Range diff relative to v3)

1:  13d42e5db6 ! 1:  de62120664 add-patch: enforce only one-letter response to prompts
    @@ add-patch.c: static int patch_update_file(struct add_p_state *s,
     +
     +		/* 'g' takes a hunk number and '/' takes a regexp */
     +		if (s->answer.len != 1 && (ch != 'g' && ch != '/')) {
    -+			error(_("only one letter is expected, got '%s'"), s->answer.buf);
    ++			err(s, _("Only one letter is expected, got '%s'"), s->answer.buf);
     +			continue;
     +		}
      		if (ch == 'y') {
    @@ t/t3701-add-interactive.sh: test_expect_success 'revert works (commit)' '
     +	saved=$(git hash-object -w file) &&
     +	test_when_finished "git cat-file blob $saved >file" &&
     +	echo an extra line >>file &&
    -+	test_write_lines aa | git add -p >actual 2>error &&
    -+	test_grep "error: .* got ${SQ}aa${SQ}" error
    ++	test_write_lines aa | git add -p >actual &&
    ++	test_grep "is expected, got ${SQ}aa${SQ}" actual
     +'
     +
      test_expect_success 'setup expected' '
    @@ t/t3701-add-interactive.sh: test_expect_success 'split hunk setup' '
     +test_expect_success 'goto hunk 1 with "g 1"' '
      	test_when_finished "git reset" &&
      	tr _ " " >expect <<-EOF &&
    - 	(2/2) Stage this hunk [y,n,q,a,d,K,g,/,e,?]? + 1:  -1,2 +1,3          +15
    + 	(2/2) Stage this hunk [y,n,q,a,d,K,g,/,e,p,?]? + 1:  -1,2 +1,3          +15
     @@ t/t3701-add-interactive.sh: test_expect_success 'goto hunk' '
      	test_cmp expect actual.trimmed
      '
    @@ t/t3701-add-interactive.sh: test_expect_success 'goto hunk' '
     +	_10
     +	+15
     +	_20
    -+	(1/2) Stage this hunk [y,n,q,a,d,j,J,g,/,e,?]?_
    ++	(1/2) Stage this hunk [y,n,q,a,d,j,J,g,/,e,p,?]?_
     +	EOF
     +	test_write_lines s y g1 | git add -p >actual &&
     +	tail -n 4 <actual >actual.trimmed &&
    @@ t/t3701-add-interactive.sh: test_expect_success 'goto hunk' '
     +test_expect_success 'navigate to hunk via regex /pattern' '
      	test_when_finished "git reset" &&
      	tr _ " " >expect <<-EOF &&
    - 	(2/2) Stage this hunk [y,n,q,a,d,K,g,/,e,?]? @@ -1,2 +1,3 @@
    + 	(2/2) Stage this hunk [y,n,q,a,d,K,g,/,e,p,?]? @@ -1,2 +1,3 @@
     @@ t/t3701-add-interactive.sh: test_expect_success 'navigate to hunk via regex' '
      	test_cmp expect actual.trimmed
      '
    @@ t/t3701-add-interactive.sh: test_expect_success 'navigate to hunk via regex' '
     +	_10
     +	+15
     +	_20
    -+	(1/2) Stage this hunk [y,n,q,a,d,j,J,g,/,e,?]?_
    ++	(1/2) Stage this hunk [y,n,q,a,d,j,J,g,/,e,p,?]?_
     +	EOF
     +	test_write_lines s y / 1,2 | git add -p >actual &&
     +	tail -n 4 <actual >actual.trimmed &&
