Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 787EE33D2
	for <git@vger.kernel.org>; Fri, 29 Mar 2024 00:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711673471; cv=none; b=A8PVuJF9Hj5FcrG79R64/UOpDNpHu7F6AOptYbkEPoPRA7oNesC0IyHZBpBAAnPHgxoOCVNgixw6SmKqDoQXNNXvipMwFILwFHf5awD9XpETDl62Q/RhhS5AlhThzhr5UQoTnEaLEnCAuvc5os6pSdA5miFkKJUvMu1ACJuGus4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711673471; c=relaxed/simple;
	bh=F6LR9gqKcHkVOugEf3Ro+ngvHEF6vjxVBpCOY/MMkeE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=okN1vc4t4ITfHw4DdF/VxJWOwiwCN1beyU8LJHs6T4zeoc7DHr05ZjIMHHVlseohjOVr7Y3u2+B6ELE79jzGv09m0ekoD4oysWqn2WZVjR4dPkfLgsebHsmu77SnvCztAswsQrMEdn2g+NTwad9ekwDI3HEqXEmIHKkC9cEXs80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=sopbXk+S; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="sopbXk+S"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 6579D1DFBF1;
	Thu, 28 Mar 2024 20:51:09 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=F
	6LR9gqKcHkVOugEf3Ro+ngvHEF6vjxVBpCOY/MMkeE=; b=sopbXk+S5pz0B0dOA
	tFUp72TdfKYfpsltpj9vSux6M8RkAU/d4132OYx8us++oWOOYuDsLrorKUnQjWrk
	4mdxSUspwOTNs20Fg5977SWiss6bEEtbgbNGKnX1YSscyaT6fqmh1rcAxdRphjG3
	Vj2kv0gRLk3prWOAh5ZeV+bOwo=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 5DCFD1DFBEF;
	Thu, 28 Mar 2024 20:51:09 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id ABEF41DFBEE;
	Thu, 28 Mar 2024 20:51:08 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Derrick Stolee <stolee@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH] do not set GIT_TEST_MAINT_SCHEDULER where it does not matter
Date: Thu, 28 Mar 2024 17:51:07 -0700
Message-ID: <xmqqmsqhsvwk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 6E405594-ED66-11EE-9FC6-25B3960A682E-77302942!pb-smtp2.pobox.com

31345d55 (maintenance: extract platform-specific scheduling,
2020-11-24) added code to t/test-lib.sh for everybody to set
GIT_TEST_MAINT_SCHEDULER to a "safe" value and instructed the test
writers to set the variable locally when their test wants to check
the scheduler integration.

But it did so without "export GIT_TEST_MAINT_SCHEDULER", so the
setting does not seem to have any effect anyway.  Instead of setting
it to a "safe" value, just unset it.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * t7900 (maintenance) uses many tests that does one-shot export of
   the variable, and one test that sets the value to its safe
   "failure" value and exports it at the end.

   t9210 (scaler) sets up a safe fake scheduler and exports it
   before doing any of its tests.

   Nobody else that includes t/test-lib.sh mentions this variable.

 t/test-lib.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git c/t/test-lib.sh w/t/test-lib.sh
index c8af8dab79..48345864f4 100644
--- c/t/test-lib.sh
+++ w/t/test-lib.sh
@@ -1959,9 +1959,9 @@ test_lazy_prereq DEFAULT_REPO_FORMAT '
 # Ensure that no test accidentally triggers a Git command
 # that runs the actual maintenance scheduler, affecting a user's
 # system permanently.
-# Tests that verify the scheduler integration must set this locally
-# to avoid errors.
-GIT_TEST_MAINT_SCHEDULER="none:exit 1"
+# Tests that verify the scheduler integration must set and
+# export this variable locally.
+sane_unset GIT_TEST_MAINT_SCHEDULER
 
 # Does this platform support `git fsmonitor--daemon`
 #
