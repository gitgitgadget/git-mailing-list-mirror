Received: from smtp118.iad3a.emailsrvr.com (smtp118.iad3a.emailsrvr.com [173.203.187.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEB623AA1BA
	for <git@vger.kernel.org>; Wed, 14 Oct 2026 03:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.203.187.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791948705; cv=none; b=MHSsjQu9ZS2IFBVaTBPpBGjBI2ryjIkK73Lq8qhofMFkpvV9W0z1XF2vqRKIt6I3Kqiz6rbMO6ot4l9b8ccpzr8+ql/6+fqSRZoUkPIP6hCbkgiF2qYUxdgUAUTTbWd9K4beYo5m0Q3HxGBvGM7Yez5okhdjECpJxXJk5FCAsOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791948705; c=relaxed/simple;
	bh=AOni52puZc9fZ+yFX2ZrEkRvI2ifRX8kqH77gs9BpNk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cp9xaJZfvPZIra95+bEFZUzkFses8SRgJHPJDOyQi3xBhsV1ue7lerfu21r0zdtVVSC1H9YRHJknnSYNrDgtuxN4qSb6fYFaOzBcx9No/c0PK/6nbvfEjVWmbmoCKPIiRQKcqMRs+6M/pcO+hV62wATQmZIndpxTsnkV3ftQnkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jonsimons.org; spf=pass smtp.mailfrom=jonsimons.org; dkim=pass (1024-bit key) header.d=jonsimons.org header.i=@jonsimons.org header.b=S4M4mHDC; arc=none smtp.client-ip=173.203.187.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jonsimons.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jonsimons.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=jonsimons.org header.i=@jonsimons.org header.b="S4M4mHDC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=jonsimons.org;
	s=20200911-u7gnnm7o; t=1791947651;
	bh=AOni52puZc9fZ+yFX2ZrEkRvI2ifRX8kqH77gs9BpNk=;
	h=From:To:Subject:Date:From;
	b=S4M4mHDC45QiQaeO8/wtnagcLl80RwUM0OmFZgPzmXbT60LCL/ARfwK+iaXxToRgP
	 JRArzRo+3pTGseayqlk8veKnfi1R7V5S8QBOnw6zh0O5bQBFyGugWovs82SaP1T/V5
	 4FMFBVJjWFTLWEUrSq6L9F0PwKv5K8Blm+Ol4zt4=
X-Auth-ID: jon@jonsimons.org
Received: by smtp23.relay.iad3a.emailsrvr.com (Authenticated sender: jon-AT-jonsimons.org) with ESMTPSA id 92E0D25309;
	Tue, 13 Oct 2026 23:14:11 -0400 (EDT)
From: Jon Simons <jon@jonsimons.org>
To: git@vger.kernel.org
Cc: Jon Simons <jon@jonsimons.org>
Subject: [PATCH v2 06/12] t5408, t5410: test duplicate updates without relying on the client
Date: Tue, 13 Oct 2026 23:13:41 -0400
Message-ID: <20261014031347.50433-7-jon@jonsimons.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261014031347.50433-1-jon@jonsimons.org>
References: <20261009192953.81794-1-jon@jonsimons.org>
 <20261014031347.50433-1-jon@jonsimons.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Classification-ID: 20ae8d58-78b7-4215-81c6-d8119c94fa7d-7-1

The existing t5408 tests that use send-pack to transmit duplicate
updates for the same destination happen to rely on the client not
recognizing the duplicates when the remote is empty.

As a result, they are the only push tests that exercise each of:

 - receive-pack rejection of multiple updates for the same ref, from
   9d2962a7c4 (receive-pack: use batched reference updates, 2025-05-19)

 - send-pack's receive_status() handling of a ref reported twice by the
   remote, from 77188b5bba (send-pack: fix memory leak around duplicate
   refs, 2025-05-19)

Add explicit tests for each of those paths, in preparation of an
upcoming commit that fixes the client to reject such pushes before
sending any update.

Signed-off-by: Jon Simons <jon@jonsimons.org>
---
 t/t5408-send-pack-stdin.sh | 12 ++++++++++++
 t/t5410-receive-pack.sh    | 35 +++++++++++++++++++++++++++++++++++
 2 files changed, 47 insertions(+)

diff --git a/t/t5408-send-pack-stdin.sh b/t/t5408-send-pack-stdin.sh
index ec339761c2..3c47be1af8 100755
--- a/t/t5408-send-pack-stdin.sh
+++ b/t/t5408-send-pack-stdin.sh
@@ -89,6 +89,18 @@ test_expect_success '--stdin refs come after cmdline' '
 	test_must_fail git --git-dir=remote.git rev-parse foo
 '
 
+test_expect_success 'send-pack handles repeated status for the same ref' '
+	clear_remote &&
+	test_hook -C remote.git receive-report <<-\EOF &&
+	cat >/dev/null &&
+	printf "%s\n" "unpack ok" "ng refs/heads/foo first" \
+		"ng refs/heads/foo second" 0000 |
+	test-tool pkt-line pack
+	EOF
+	test_must_fail git send-pack remote.git A:foo 2>err &&
+	test_grep "remote rejected.*A -> foo (second)" err
+'
+
 test_expect_success 'refspecs and --mirror do not mix (cmdline)' '
 	clear_remote &&
 	test_must_fail git send-pack remote.git --mirror $(cat refs)
diff --git a/t/t5410-receive-pack.sh b/t/t5410-receive-pack.sh
index 09d6bfd2a1..8fbc0c6bc9 100755
--- a/t/t5410-receive-pack.sh
+++ b/t/t5410-receive-pack.sh
@@ -97,4 +97,39 @@ test_expect_success TEE_DOES_NOT_HANG \
 	test_must_fail git -C remote.git rev-list $(git -C repo rev-parse HEAD)
 '
 
+test_expect_success 'receive-pack rejects multiple updates for the same ref' '
+	test_when_finished "rm -rf repo remote.git" &&
+
+	git init repo &&
+	git -C repo commit --allow-empty -m A &&
+	git -C repo branch A &&
+	git -C repo commit --allow-empty -m B &&
+	git -C repo branch B &&
+	git init --bare remote.git &&
+	git -C repo send-pack ../remote.git A B &&
+	A=$(git -C repo rev-parse A) &&
+	B=$(git -C repo rev-parse B) &&
+	{
+		printf "%s %s refs/heads/foo\0report-status object-format=%s" \
+			$ZERO_OID $A "$(test_oid algo)" |
+		test-tool pkt-line pack-raw-stdin &&
+		printf "%s %s refs/heads/foo" $ZERO_OID $B |
+		test-tool pkt-line pack-raw-stdin &&
+		printf 0000 &&
+		git pack-objects --stdout </dev/null
+	} >request &&
+	git receive-pack remote.git <request >response 2>err &&
+	test_grep "multiple updates for ref ${SQ}refs/heads/foo${SQ} not allowed" err &&
+	test-tool pkt-line unpack <response >report &&
+	sed -n "/^unpack /,\$p" report >actual &&
+	cat >expect <<-\EOF &&
+	unpack ok
+	ng refs/heads/foo failed to update refs
+	ng refs/heads/foo failed to update refs
+	0000
+	EOF
+	test_cmp expect actual &&
+	test_must_fail git --git-dir=remote.git rev-parse --verify refs/heads/foo
+'
+
 test_done
-- 
2.55.0

