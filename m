Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71F2B63C
	for <git@vger.kernel.org>; Tue,  6 Aug 2024 00:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722905718; cv=none; b=sEeCJiaITTvRlN+RQC/KWRfZX3vTIJ/s6GWJ+UfXsNCwx8bjYXGJTz66Vyxci8+WFyg2tCPUZSkjkQuUuWRxsafNKty/u9Q/+UyhawS3JZCEmEAJ5mQQF7+WyjRy+m2l4TQfjGobgc+dfU9aTu0LYau8P+i/8IJADEpYNd/RgaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722905718; c=relaxed/simple;
	bh=cpb+gMHwiG8C5bZUjkwnsDW96yuZtA9sMkDObBXcgQ0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=oxgyNmTCH4YEQf3493tNlLo70hJm8mPFjLgJ1U6yI21h/ucUe9VGkh4o+LGZ8u11oqJoJWxoW67hbYuSnziSMY73r6r9HMftlID5Po4oVSAuRVbukfsF5GypmTt9AKLTOCMSxKpT2SPAVv7U1poHmShkiAgJVcufqg0Jv7c8z8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=BmaTNA9q; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="BmaTNA9q"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id EB09D1C12E;
	Mon,  5 Aug 2024 20:55:15 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=c
	pb+gMHwiG8C5bZUjkwnsDW96yuZtA9sMkDObBXcgQ0=; b=BmaTNA9qFjVqzVJJv
	prmAQ1rx1Yrsj07GL6c6ciqCs5jMP2KbQlsBXap6exBbg1BO8N7/9IfJW1fZguiN
	KHCRqaahYRnC7dXuGDgCFw8w9mDDDFmLqfVIRjPeKzYq159Lb5Xch91aXdmykIxd
	xkOlwa50NQUFGb2wlcEniBogsk=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id E40B61C12D;
	Mon,  5 Aug 2024 20:55:15 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id EECCF1C12A;
	Mon,  5 Aug 2024 20:55:11 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH] t3206: test_when_finished before dirtying operations, not
 after
Date: Mon, 05 Aug 2024 17:55:10 -0700
Message-ID: <xmqqttfyzd01.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 88F3A47A-538E-11EF-B3FB-E92ED1CD468F-77302942!pb-smtp21.pobox.com

Many existing tests in this script perform operation(s) and then use
test_when_finished to define how to undo the effect of the
operation(s).

This is backwards.  When your operation(s) fail before you manage to
successfully call test_when_finished (remember, that these commands
must be all &&-chained, so a failure of an earlier operation mean
your test_when_finished may not be executed at all).  You must
establish how to clean up your mess with test_when_finished before
you create the mess to be cleaned up.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * During a recent review of a topic, I noticed this file was
   littered with issues, and marked it as leftoverbits to clean it
   up after the dust settled.  The dust had settled, so it is a good
   time to clean up.

 t/t3206-range-diff.sh | 52 +++++++++++++++++++++----------------------
 1 file changed, 26 insertions(+), 26 deletions(-)

diff --git a/t/t3206-range-diff.sh b/t/t3206-range-diff.sh
index a767c3520e..d3bcd74236 100755
--- a/t/t3206-range-diff.sh
+++ b/t/t3206-range-diff.sh
@@ -533,9 +533,9 @@ test_expect_success 'dual-coloring' '
 for prev in topic main..topic
 do
 	test_expect_success "format-patch --range-diff=$prev" '
+		test_when_finished "rm 000?-*" &&
 		git format-patch --cover-letter --range-diff=$prev \
 			main..unmodified >actual &&
-		test_when_finished "rm 000?-*" &&
 		test_line_count = 5 actual &&
 		test_grep "^Range-diff:$" 0000-* &&
 		grep "= 1: .* s/5/A" 0000-* &&
@@ -560,32 +560,32 @@ test_expect_success "explicit --no-cover-letter defeats implied --cover-letter"
 '
 
 test_expect_success 'format-patch --range-diff as commentary' '
-	git format-patch --range-diff=HEAD~1 HEAD~1 >actual &&
 	test_when_finished "rm 0001-*" &&
+	git format-patch --range-diff=HEAD~1 HEAD~1 >actual &&
 	test_line_count = 1 actual &&
 	test_grep "^Range-diff:$" 0001-* &&
 	grep "> 1: .* new message" 0001-*
 '
 
 test_expect_success 'format-patch --range-diff reroll-count with a non-integer' '
-	git format-patch --range-diff=HEAD~1 -v2.9 HEAD~1 >actual &&
 	test_when_finished "rm v2.9-0001-*" &&
+	git format-patch --range-diff=HEAD~1 -v2.9 HEAD~1 >actual &&
 	test_line_count = 1 actual &&
 	test_grep "^Range-diff:$" v2.9-0001-* &&
 	grep "> 1: .* new message" v2.9-0001-*
 '
 
 test_expect_success 'format-patch --range-diff reroll-count with a integer' '
-	git format-patch --range-diff=HEAD~1 -v2 HEAD~1 >actual &&
 	test_when_finished "rm v2-0001-*" &&
+	git format-patch --range-diff=HEAD~1 -v2 HEAD~1 >actual &&
 	test_line_count = 1 actual &&
 	test_grep "^Range-diff ..* v1:$" v2-0001-* &&
 	grep "> 1: .* new message" v2-0001-*
 '
 
 test_expect_success 'format-patch --range-diff with v0' '
-	git format-patch --range-diff=HEAD~1 -v0 HEAD~1 >actual &&
 	test_when_finished "rm v0-0001-*" &&
+	git format-patch --range-diff=HEAD~1 -v0 HEAD~1 >actual &&
 	test_line_count = 1 actual &&
 	test_grep "^Range-diff:$" v0-0001-* &&
 	grep "> 1: .* new message" v0-0001-*
@@ -606,9 +606,9 @@ test_expect_success 'basic with modified format.pretty without "commit "' '
 '
 
 test_expect_success 'range-diff compares notes by default' '
+	test_when_finished git notes remove topic unmodified &&
 	git notes add -m "topic note" topic &&
 	git notes add -m "unmodified note" unmodified &&
-	test_when_finished git notes remove topic unmodified &&
 	git range-diff --no-color main..topic main..unmodified \
 		>actual &&
 	sed s/Z/\ /g >expect <<-EOF &&
@@ -630,9 +630,9 @@ test_expect_success 'range-diff compares notes by default' '
 '
 
 test_expect_success 'range-diff with --no-notes' '
+	test_when_finished git notes remove topic unmodified &&
 	git notes add -m "topic note" topic &&
 	git notes add -m "unmodified note" unmodified &&
-	test_when_finished git notes remove topic unmodified &&
 	git range-diff --no-color --no-notes main..topic main..unmodified \
 		>actual &&
 	cat >expect <<-EOF &&
@@ -645,12 +645,12 @@ test_expect_success 'range-diff with --no-notes' '
 '
 
 test_expect_success 'range-diff with multiple --notes' '
+	test_when_finished git notes --ref=note1 remove topic unmodified &&
 	git notes --ref=note1 add -m "topic note1" topic &&
 	git notes --ref=note1 add -m "unmodified note1" unmodified &&
-	test_when_finished git notes --ref=note1 remove topic unmodified &&
+	test_when_finished git notes --ref=note2 remove topic unmodified &&
 	git notes --ref=note2 add -m "topic note2" topic &&
 	git notes --ref=note2 add -m "unmodified note2" unmodified &&
-	test_when_finished git notes --ref=note2 remove topic unmodified &&
 	git range-diff --no-color --notes=note1 --notes=note2 main..topic main..unmodified \
 		>actual &&
 	sed s/Z/\ /g >expect <<-EOF &&
@@ -678,12 +678,12 @@ test_expect_success 'range-diff with multiple --notes' '
 
 # `range-diff` should act like `log` with regards to notes
 test_expect_success 'range-diff with --notes=custom does not show default notes' '
+	test_when_finished git notes remove topic unmodified &&
 	git notes add -m "topic note" topic &&
 	git notes add -m "unmodified note" unmodified &&
+	test_when_finished git notes --ref=custom remove topic unmodified &&
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
+	test_when_finished git notes remove topic unmodified &&
 	git notes add -m "topic note" topic &&
 	git notes add -m "unmodified note" unmodified &&
-	test_when_finished git notes remove topic unmodified &&
+	test_when_finished "rm 000?-*" &&
 	git format-patch --cover-letter --range-diff=$prev \
 		main..unmodified >actual &&
-	test_when_finished "rm 000?-*" &&
 	test_line_count = 5 actual &&
 	test_grep "^Range-diff:$" 0000-* &&
 	grep "= 1: .* s/5/A" 0000-* &&
@@ -708,26 +708,26 @@ test_expect_success 'format-patch --range-diff does not compare notes by default
 '
 
 test_expect_success 'format-patch --notes=custom --range-diff only compares custom notes' '
+	test_when_finished git notes remove topic unmodified &&
 	git notes add -m "topic note" topic &&
-	git notes --ref=custom add -m "topic note (custom)" topic &&
 	git notes add -m "unmodified note" unmodified &&
-	git notes --ref=custom add -m "unmodified note (custom)" unmodified &&
-	test_when_finished git notes remove topic unmodified &&
 	test_when_finished git notes --ref=custom remove topic unmodified &&
+	git notes --ref=custom add -m "topic note (custom)" topic &&
+	git notes --ref=custom add -m "unmodified note (custom)" unmodified &&
+	test_when_finished "rm 000?-*" &&
 	git format-patch --notes=custom --cover-letter --range-diff=$prev \
 		main..unmodified >actual &&
-	test_when_finished "rm 000?-*" &&
 	grep "## Notes (custom) ##" 0000-* &&
 	! grep "## Notes ##" 0000-*
 '
 
 test_expect_success 'format-patch --range-diff with --no-notes' '
+	test_when_finished git notes remove topic unmodified &&
 	git notes add -m "topic note" topic &&
 	git notes add -m "unmodified note" unmodified &&
-	test_when_finished git notes remove topic unmodified &&
+	test_when_finished "rm 000?-*" &&
 	git format-patch --no-notes --cover-letter --range-diff=$prev \
 		main..unmodified >actual &&
-	test_when_finished "rm 000?-*" &&
 	test_line_count = 5 actual &&
 	test_grep "^Range-diff:$" 0000-* &&
 	grep "= 1: .* s/5/A" 0000-* &&
@@ -739,12 +739,12 @@ test_expect_success 'format-patch --range-diff with --no-notes' '
 '
 
 test_expect_success 'format-patch --range-diff with --notes' '
+	test_when_finished git notes remove topic unmodified &&
 	git notes add -m "topic note" topic &&
 	git notes add -m "unmodified note" unmodified &&
-	test_when_finished git notes remove topic unmodified &&
+	test_when_finished "rm 000?-*" &&
 	git format-patch --notes --cover-letter --range-diff=$prev \
 		main..unmodified >actual &&
-	test_when_finished "rm 000?-*" &&
 	test_line_count = 5 actual &&
 	test_grep "^Range-diff:$" 0000-* &&
 	grep "= 1: .* s/5/A" 0000-* &&
@@ -767,13 +767,13 @@ test_expect_success 'format-patch --range-diff with --notes' '
 '
 
 test_expect_success 'format-patch --range-diff with format.notes config' '
+	test_when_finished git notes remove topic unmodified &&
 	git notes add -m "topic note" topic &&
 	git notes add -m "unmodified note" unmodified &&
-	test_when_finished git notes remove topic unmodified &&
 	test_config format.notes true &&
+	test_when_finished "rm 000?-*" &&
 	git format-patch --cover-letter --range-diff=$prev \
 		main..unmodified >actual &&
-	test_when_finished "rm 000?-*" &&
 	test_line_count = 5 actual &&
 	test_grep "^Range-diff:$" 0000-* &&
 	grep "= 1: .* s/5/A" 0000-* &&
@@ -796,15 +796,15 @@ test_expect_success 'format-patch --range-diff with format.notes config' '
 '
 
 test_expect_success 'format-patch --range-diff with multiple notes' '
+	test_when_finished git notes --ref=note1 remove topic unmodified &&
 	git notes --ref=note1 add -m "topic note1" topic &&
 	git notes --ref=note1 add -m "unmodified note1" unmodified &&
-	test_when_finished git notes --ref=note1 remove topic unmodified &&
+	test_when_finished git notes --ref=note2 remove topic unmodified &&
 	git notes --ref=note2 add -m "topic note2" topic &&
 	git notes --ref=note2 add -m "unmodified note2" unmodified &&
-	test_when_finished git notes --ref=note2 remove topic unmodified &&
+	test_when_finished "rm 000?-*" &&
 	git format-patch --notes=note1 --notes=note2 --cover-letter --range-diff=$prev \
 		main..unmodified >actual &&
-	test_when_finished "rm 000?-*" &&
 	test_line_count = 5 actual &&
 	test_grep "^Range-diff:$" 0000-* &&
 	grep "= 1: .* s/5/A" 0000-* &&
-- 
2.46.0-235-g968ce1ce0e

