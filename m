Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 970423219F
	for <git@vger.kernel.org>; Wed, 15 May 2024 19:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715801633; cv=none; b=Prfm2PbLr2eW3K8K6MuFn8WEft0DjAOQoHzZmMXBciuKD3+6xMNLsw55QZkiBgqw6khpF72eGHSYM8wGqOAi4ukXsaNXea7MSYL4cL5r5bdmq7jlLMT0FGHnYNXGF9KRMPhCeVgPI2m7b/adgmzrwJRvhU6rzfiTB/TnTAfZlso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715801633; c=relaxed/simple;
	bh=n1thKaLiQ6qaMzV54y4dADsSp0Jo9XQueIL7JN08HTM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nLG+XL91mXjaznHUlWcNtnEdcJWd+kwZ/k4QgCEvHdIeKb4sXNJ/xaeNFawyDU++p8BQD2HtbXrY0MVL3OGkLcmFoqnwmkvXx7wdBGab+lqE+lBmw88pBf7eZy6TH032x7chXalJJE3ljeObo35/wWcOsHsAr8mS8RUPXKJ7+4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=EC1z4ATS; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="EC1z4ATS"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 218FD1F974;
	Wed, 15 May 2024 15:32:47 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=n
	1thKaLiQ6qaMzV54y4dADsSp0Jo9XQueIL7JN08HTM=; b=EC1z4ATS/3Auxt7U3
	xy1K8PFF6J9/R7Rc5+VCBxu7nsE3ZkMXT3XzFLo67zrbhqiA5Ej5TX0yaFvd+ysA
	Es8UiN+v7xXCX4bKDhMh46mC5Kkr2zdvtPiF8inB6cLr+rbgOFXfK1uWefYpe/gH
	TvyswTpXs1PV1Xi+xfrpU9962M=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 1A2421F973;
	Wed, 15 May 2024 15:32:47 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 9C6F01F972;
	Wed, 15 May 2024 15:32:43 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: [PATCH] t0017: clarify dubious test set-up
Date: Wed, 15 May 2024 12:32:42 -0700
Message-ID: <xmqqcypmx44l.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 E692A3D4-12F1-11EF-9D45-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

1ff750b1 (tests: make GIT_TEST_GETTEXT_POISON a boolean, 2019-06-21)
added this test, in which "test-tool -C" is fed a name of a
directory that does not exist, and expects that it dies because of a
failure to read the configuration file(s), because the configuration
setting is screwed up to contain mutual inclusion loop, before it
notices that the directory to chdir into does not exist and dies.

It is of dubious value to etch the current order of events, i.e.,
the configuration needs to be read that early (for initializing
trace2 subsystem) before we even notice the lack of the directory
and have a chance to fail, into stone.  Indeed, if you completely
compile out trace2 subsystem so that it does not even attempt to
read the configuration that early, we would die with a different
error message (i.e. "unable to chdir to 'cycle'") and this test will
fail.

At least give a bogus argument to "test-tool -C" a name that is
clearly bogus to make sure we can more easily see what is going on
with plenty of comments.  

We may want to remove this test altogether, instead, though.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t0017-env-helper.sh | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/t/t0017-env-helper.sh b/t/t0017-env-helper.sh
index fc14ba091c..f3a16859cc 100755
--- a/t/t0017-env-helper.sh
+++ b/t/t0017-env-helper.sh
@@ -91,9 +91,16 @@ test_expect_success 'test-tool env-helper reads config thanks to trace2' '
 		git config -l 2>err &&
 	grep "exceeded maximum include depth" err &&
 
+	# This validates that the assumption that we attempt to
+	# read the configuration and fail very early in the start-up
+	# sequence (due to trace2 subsystem), even before we notice
+	# that the directory named with "test-tool -C" does not exist
+	# and die.  It is a dubious thing to test, though.
 	test_must_fail \
 		env HOME="$(pwd)/home" GIT_TEST_ENV_HELPER=true \
-		test-tool -C cycle env-helper --type=bool --default=0 --exit-code GIT_TEST_ENV_HELPER 2>err &&
+		test-tool -C no-such-directory \
+		env-helper --type=bool --default=0 \
+		--exit-code GIT_TEST_ENV_HELPER 2>err &&
 	grep "exceeded maximum include depth" err
 '
 
-- 
2.45.1-190-g19fe900cfc

