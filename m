Received: from smtp96.iad3b.emailsrvr.com (smtp96.iad3b.emailsrvr.com [146.20.161.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59B2333B6F8
	for <git@vger.kernel.org>; Sun, 11 Oct 2026 16:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=146.20.161.96
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791737482; cv=none; b=fURYSaQ8HBiYOSndEq88aZO/HMqHuEwbbI7vfPKuG0QolgrS7mKlCcNrKOhTW1VSRpSolO88LO6lm0I6PbU3jCNnQbQGKRfdSYvQtPKF4kPoLtS4orIyT26lhrl5Nmnwms9Mm3AwV8BHji13ddj5nhU1A2Wl+WihLt+oWJlcmEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791737482; c=relaxed/simple;
	bh=e+/S6NQWKbcwXPeSgQ/mIBsKfrT8hI39I1yjUT/yPoo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CnBgSXBQzOs+hoCw7ab1nytEli+BqM8Pjm2Nq9TlSWopWeQ4eKhGbWIwZMpsMPsnY1ZwBB+o9qMVONi5RuABoBJQuUORahcr+ojCgXbW+P1p37wo9Xu0p8dSdvL2L7EldIeSTHJo28XtAc7Oe/EIKQNe0ZHf+yCKaSVAKsy6Dv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jonsimons.org; spf=pass smtp.mailfrom=jonsimons.org; dkim=pass (1024-bit key) header.d=jonsimons.org header.i=@jonsimons.org header.b=H/zvZ0pa; arc=none smtp.client-ip=146.20.161.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jonsimons.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jonsimons.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=jonsimons.org header.i=@jonsimons.org header.b="H/zvZ0pa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=jonsimons.org;
	s=20200911-u7gnnm7o; t=1791732738;
	bh=e+/S6NQWKbcwXPeSgQ/mIBsKfrT8hI39I1yjUT/yPoo=;
	h=From:To:Subject:Date:From;
	b=H/zvZ0paEDi6s9/DQA/VVEliqhQmOJ+4J6O+4L1U+d9F0+xaKbRzi2Tk+fDogP0DN
	 XOFsEDKc1z8I5IneLWLJG4ilkjmbxfY2AT95UYpKlVYF7bPBFYyO7bZ5RDc2l6SG53
	 UawrLcmgghnM6khzKSAMj8ELjziq7xqbmcD1g0yg=
X-Auth-ID: jon@jonsimons.org
Received: by smtp13.relay.iad3b.emailsrvr.com (Authenticated sender: jon-AT-jonsimons.org) with ESMTPSA id C1180600A6;
	Sun, 11 Oct 2026 11:32:17 -0400 (EDT)
From: Jon Simons <jon@jonsimons.org>
To: git@vger.kernel.org,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>
Cc: Jon Simons <jon@jonsimons.org>
Subject: [PATCH] SubmittingPatches: avoid add-failing-test-then-fix anti-pattern
Date: Sun, 11 Oct 2026 11:32:06 -0400
Message-ID: <20261011153206.72386-1-jon@jonsimons.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Classification-ID: 8e89247c-9650-4d29-98e0-0f2811157383-1-1

Document the preference to avoid the 'add a failing test and fix it in a
subsequent commit' anti-pattern.  Although such a sequence is fine for
local development, reviewers instead prefer a single commit that
introduces the test together with its code change.

The goal of this addition is to capture the preference in writing, with
hopes of optimizing future review flows by reducing back-and-forths to
the list.

Signed-off-by: Jon Simons <jon@jonsimons.org>
---
 Documentation/SubmittingPatches | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
index c60855f706..27b53d2b31 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -271,6 +271,16 @@ fixed by accident to avoid regression.  Also, try merging your work to
 that are still in flight may have unexpected interactions with what
 you are trying to do in your topic.
 
+When fixing a bug, you may find it useful to first write a test using
+`test_expect_failure` to confirm that the test exposes the bug.
+However, unless there is a strong reason not to, submit the test as
+`test_expect_success` in the same commit as your code change that
+fixes the bug.  A separate commit that only changes `test_expect_failure`
+to `test_expect_success` can leave the behavior being tested out of the
+diff context, making the fix harder to review.  Reviewers who want to
+verify that your test reproduces the bug can temporarily undo the code
+changes while keeping the test.
+
 Pushing to a fork of https://github.com/git/git will use their CI
 integration to test your changes on Linux, Mac and Windows. See the
 <<GHCI,GitHub CI>> section for details.
-- 
2.55.0

