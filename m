Received: from smtp90.iad3b.emailsrvr.com (smtp90.iad3b.emailsrvr.com [146.20.161.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E44A04F4CF5
	for <git@vger.kernel.org>; Fri,  9 Oct 2026 19:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=146.20.161.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791574648; cv=none; b=YDIZbwwzSiwoGy71gkW4zOMrG7Sp2OazCXzk74fZzcwthWwsLfTls9WmLf8rK94NFp0LtDMnhgoWIXDh64ijHmcT+I8uBya25ZaTkxCQEyx+aXt1Ws+bUWRp4XHOwTuvDoUDGwXPgPBCKW2fqoDgrNCDGpFZE0a2K775es6cgpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791574648; c=relaxed/simple;
	bh=AOni52puZc9fZ+yFX2ZrEkRvI2ifRX8kqH77gs9BpNk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D+o2TiDGOq2aNHRcOuHb11EBKOcBXXkDy8kJH6Jxg8YwYxZQ13FUyiSEFtik96CRWm2WHaeDTc3TNueQH7ODX80tQa45XwZA38qRsF021Nj8DtBeb1ToXZZV6DtiT3+XVwBHdjSH2Hqo78kLfdR3c6HfhUjEdRMcodjlnZbbyCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jonsimons.org; spf=pass smtp.mailfrom=jonsimons.org; dkim=pass (1024-bit key) header.d=jonsimons.org header.i=@jonsimons.org header.b=ArkkuXR8; arc=none smtp.client-ip=146.20.161.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jonsimons.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jonsimons.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=jonsimons.org header.i=@jonsimons.org header.b="ArkkuXR8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=jonsimons.org;
	s=20200911-u7gnnm7o; t=1791574222;
	bh=AOni52puZc9fZ+yFX2ZrEkRvI2ifRX8kqH77gs9BpNk=;
	h=From:To:Subject:Date:From;
	b=ArkkuXR8O1WFqmxgDvQxmH9Zl1liVICQyaQNST8MLRYKrtePzT7C8pgzYU0veZlpn
	 V7q4FXU/8lkk/HFxDeBbycRTlI8kDf96dawMvLqaih2Tsl/EzwvdGAcWSVmnkZn30O
	 EuQjm+gpked1F0m6/OlEVdbnbNkeqS9mtXgfACnQ=
X-Auth-ID: jon@jonsimons.org
Received: by smtp4.relay.iad3b.emailsrvr.com (Authenticated sender: jon-AT-jonsimons.org) with ESMTPSA id 2C96420391;
	Fri,  9 Oct 2026 15:30:22 -0400 (EDT)
From: Jon Simons <jon@jonsimons.org>
To: git@vger.kernel.org
Cc: Jon Simons <jon@jonsimons.org>
Subject: [PATCH 08/15] t5408, t5410: test duplicate updates without relying on the client
Date: Fri,  9 Oct 2026 15:29:46 -0400
Message-ID: <20261009192953.81794-9-jon@jonsimons.org>
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
X-Classification-ID: 523ad08c-aaf2-41d9-9ffc-58ea03a01763-9-1

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

