Received: from smtp90.iad3b.emailsrvr.com (smtp90.iad3b.emailsrvr.com [146.20.161.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86E184F4040
	for <git@vger.kernel.org>; Fri,  9 Oct 2026 19:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=146.20.161.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791574635; cv=none; b=SZTbzuGIgNMBAJQz4pLJMAnz6ZWFz2bVyNuq5kxqVgXwIdCHt7dzwE4PJhHJhBO6A0XkIm8n+3Zp/RgS4EpFxjNflpBbhp6qqr/jLCdQiiRuYab5uwRs3lRwAaXUqld1aHt+OXzz8R6qHeDLoojULBbNBNcQSTK3qMG0yjfnXwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791574635; c=relaxed/simple;
	bh=VFZNoU0rQ87m20xO70ZWg91lFWBGjiAImwXhk7ug880=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TQhabtBJPitO9Vps4zrkKqaS0J0+5opT84ao6YgU8s9uZ3BCwZzTMKowzVBXUXb3ZIUC+iHadob2LmXS2kZ7ZzM1D4eOzy1iVStnsdX8S1P1rW149JXEFpg6nSIBxyTbhQhGmkmEpZ14YtOspnR1wMa5OfhGKhE+ZMcmBWo0Q/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jonsimons.org; spf=pass smtp.mailfrom=jonsimons.org; dkim=pass (1024-bit key) header.d=jonsimons.org header.i=@jonsimons.org header.b=GXjdBAg9; arc=none smtp.client-ip=146.20.161.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jonsimons.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jonsimons.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=jonsimons.org header.i=@jonsimons.org header.b="GXjdBAg9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=jonsimons.org;
	s=20200911-u7gnnm7o; t=1791574223;
	bh=VFZNoU0rQ87m20xO70ZWg91lFWBGjiAImwXhk7ug880=;
	h=From:To:Subject:Date:From;
	b=GXjdBAg9CJcQKNIuSdxyZ/+sOJbA/b7qJByK53GPAGYAbcSi4j5Gpzc8j0NtAN/wj
	 OSJd7ys/g6yL+J3PCD8EapG+qW8PC2Afbp3mnflwVaEGNop+G/J1ymboVSrVgE2LwG
	 y5lgeIMiYYNwJ39Qapdvf6DYjbYwICnz+yEjqQXc=
X-Auth-ID: jon@jonsimons.org
Received: by smtp4.relay.iad3b.emailsrvr.com (Authenticated sender: jon-AT-jonsimons.org) with ESMTPSA id CDE1920393;
	Fri,  9 Oct 2026 15:30:22 -0400 (EDT)
From: Jon Simons <jon@jonsimons.org>
To: git@vger.kernel.org
Cc: Jon Simons <jon@jonsimons.org>
Subject: [PATCH 10/15] t5408: expect client-side error for duplicate destinations
Date: Fri,  9 Oct 2026 15:29:48 -0400
Message-ID: <20261009192953.81794-11-jon@jonsimons.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261009192953.81794-1-jon@jonsimons.org>
References: <20261009192953.81794-1-jon@jonsimons.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Classification-ID: 523ad08c-aaf2-41d9-9ffc-58ea03a01763-11-1

Update the error message expectation for the existing t5408 tests that
use send-pack to transmit duplicate updates to an empty remote, and
toggle them test_expect_failure.

The tests previously asserted the server-side rejection "multiple
updates for ref '<dst>' not allowed".

The next commit rejects these pushes on the client-side such that
send-pack fails earlier with "dst ref <dst> receives from more than
one src", and never reaches the server.  The tests are toggled to
test_expect_success then.

While here, change the test descriptions to note that they are no
longer asserting anything about the order of partial ref updates.

Also included is a fix for a missing "2>err" in the '--stdin refs
come after cmdline' test.

Signed-off-by: Jon Simons <jon@jonsimons.org>
---
 t/t5408-send-pack-stdin.sh | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/t/t5408-send-pack-stdin.sh b/t/t5408-send-pack-stdin.sh
index 7af350f01c..0321519f21 100755
--- a/t/t5408-send-pack-stdin.sh
+++ b/t/t5408-send-pack-stdin.sh
@@ -97,25 +97,25 @@ test_expect_success '--stdin refs are sent after cmdline refs' '
 	verify_push A bar
 '
 
-test_expect_success 'cmdline refs written in order' '
+test_expect_failure 'two cmdline refs for the same destination are rejected' '
 	clear_remote &&
 	test_must_fail git send-pack remote.git A:foo B:foo 2>err &&
-	test_grep "multiple updates for ref ${SQ}refs/heads/foo${SQ} not allowed" err &&
+	test_grep "dst ref refs/heads/foo receives from more than one src" err &&
 	test_must_fail git --git-dir=remote.git rev-parse foo
 '
 
-test_expect_success 'cmdline refs with multiple duplicates' '
+test_expect_failure 'three cmdline refs for the same destination are rejected' '
 	clear_remote &&
 	test_must_fail git send-pack remote.git A:foo B:foo C:foo 2>err &&
-	test_grep "multiple updates for ref ${SQ}refs/heads/foo${SQ} not allowed" err &&
+	test_grep "dst ref refs/heads/foo receives from more than one src" err &&
 	test_must_fail git --git-dir=remote.git rev-parse foo
 '
 
-test_expect_success '--stdin refs come after cmdline' '
+test_expect_failure 'cmdline and --stdin refs for the same destination are rejected' '
 	clear_remote &&
 	echo A:foo >input &&
-	test_must_fail git send-pack remote.git --stdin B:foo <input &&
-	test_grep "multiple updates for ref ${SQ}refs/heads/foo${SQ} not allowed" err &&
+	test_must_fail git send-pack remote.git --stdin B:foo <input 2>err &&
+	test_grep "dst ref refs/heads/foo receives from more than one src" err &&
 	test_must_fail git --git-dir=remote.git rev-parse foo
 '
 
-- 
2.55.0

