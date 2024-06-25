Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0495317F4F4
	for <git@vger.kernel.org>; Tue, 25 Jun 2024 23:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719357174; cv=none; b=VJYr2Kd7DA5U2amTz9jaV9JajecSWIKmuVrnt+tXPZ/nZxSsLdkHEM2AEkv7z2oOVZ5U6MgpxfvTOy1CMMB7k9hJHP+TZ9MSUYaViGaj8BYtYu3/j2I6kKlEL2EKWGACnKzRHHehPK0j4veIUkKKlyQqgyxiAczdt7mRVMNNGHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719357174; c=relaxed/simple;
	bh=Q+16RkIoOujgq+OqnWQkyTInqwtaIQAFUwxcU8J+iu8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BuCjoQgJOmOtqj67see+dY5QoO7aOmtoUcfGKX1YGVli4+Z1tXtk4odkylvLZCaPbHA72h+J7A15dXuVvSamrII9t3vFWfbs7cXHTpBo23FFwaeKeaAqRU216Jfo5ooWZbwaD93xMYcoTdmMp2e7p16vn/fcvfcKwt46123i8Po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=wNa5HcHq; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="wNa5HcHq"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id EB93929579;
	Tue, 25 Jun 2024 19:12:51 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding; s=sasl; bh=Q+16RkIoOujgq+OqnWQkyTInq
	wtaIQAFUwxcU8J+iu8=; b=wNa5HcHqN6pXRosPaXfflpVWhC1Ct7Hbh3cpX+F+4
	MhSOn5/vXem/DzijFbUUTG1lGoWTzjZCErxqtU6aCtTZUmX2kOyCnuJIAZFU/8Qh
	4NpHfhq+jZS4IBIsm8BCp9LXxwngwo1j0c3GRGc0bo8JOcPT18eWxZxb1Vc6Z6+c
	S0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E453529578;
	Tue, 25 Jun 2024 19:12:51 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.204.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 521FB29575;
	Tue, 25 Jun 2024 19:12:51 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH v4 1/2] t0006: simplify prerequisites
Date: Tue, 25 Jun 2024 16:12:47 -0700
Message-ID: <20240625231248.4070257-2-gitster@pobox.com>
X-Mailer: git-send-email 2.45.2-796-g2ef7a3d713
In-Reply-To: <20240625231248.4070257-1-gitster@pobox.com>
References: <pull.1726.v3.git.git.1717719428510.gitgitgadget@gmail.com> <xmqq1q58ejnw.fsf@gitster.g> <xmqqtthzrraw.fsf@gitster.g>
 <20240625231248.4070257-1-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Pobox-Relay-ID:
 71E89F80-3348-11EF-98D8-5B6DE52EC81B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable

The system must support 64-bit time and its time_t must be 64-bit
wide to pass these tests.  Combine these two prerequisites together
to simplify the tests.  In theory, they could be fulfilled
independently and tests could require only one without the other,
but in practice, but in practice these must come hand-in-hand.

Update the "check_parse" test helper to pay attention to the
REQUIRE_64BIT_TIME variable, which can be set to the HAVE_64BIT_TIME
prerequisite so that a parse test can be skipped on 32-bit systems.
This will be used in the next step to skip tests for timestamps near
the end of year 2099, as 32-bit systems will not be able to express
a timestamp beyond 2038 anyway.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t0006-date.sh | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/t/t0006-date.sh b/t/t0006-date.sh
index 3031256d14..24e8647f26 100755
--- a/t/t0006-date.sh
+++ b/t/t0006-date.sh
@@ -8,6 +8,11 @@ TEST_PASSES_SANITIZE_LEAK=3Dtrue
 # arbitrary reference time: 2009-08-30 19:20:00
 GIT_TEST_DATE_NOW=3D1251660000; export GIT_TEST_DATE_NOW
=20
+if test_have_prereq TIME_IS_64BIT,TIME_T_IS_64BIT
+then
+	test_set_prereq HAVE_64BIT_TIME
+fi
+
 check_relative() {
 	t=3D$(($GIT_TEST_DATE_NOW - $1))
 	echo "$t -> $2" >expect
@@ -80,14 +85,15 @@ check_show raw "$TIME" '1466000000 -0200'
=20
 # arbitrary time absurdly far in the future
 FUTURE=3D"5758122296 -0400"
-check_show iso       "$FUTURE" "2152-06-19 18:24:56 -0400" TIME_IS_64BIT=
,TIME_T_IS_64BIT
-check_show iso-local "$FUTURE" "2152-06-19 22:24:56 +0000" TIME_IS_64BIT=
,TIME_T_IS_64BIT
+check_show iso       "$FUTURE" "2152-06-19 18:24:56 -0400" HAVE_64BIT_TI=
ME
+check_show iso-local "$FUTURE" "2152-06-19 22:24:56 +0000" HAVE_64BIT_TI=
ME
=20
-check_parse() {
+REQUIRE_64BIT_TIME=3D
+check_parse () {
 	echo "$1 -> $2" >expect
-	test_expect_${4:-success} "parse date ($1${3:+ TZ=3D$3})" "
-	TZ=3D${3:-$TZ} test-tool date parse '$1' >actual &&
-	test_cmp expect actual
+	test_expect_success $REQUIRE_64BIT_TIME "parse date ($1${3:+ TZ=3D$3}) =
-> $2" "
+		TZ=3D${3:-$TZ} test-tool date parse '$1' >actual &&
+		test_cmp expect actual
 	"
 }
=20
--=20
2.45.2-796-g2ef7a3d713

