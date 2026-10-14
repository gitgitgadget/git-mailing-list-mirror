Received: from smtp116.iad3a.emailsrvr.com (smtp116.iad3a.emailsrvr.com [173.203.187.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0372238D3EB
	for <git@vger.kernel.org>; Wed, 14 Oct 2026 03:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.203.187.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791947658; cv=none; b=qo+TjS1RAYDDG/KpeJFNegSiozjXHHT0Qfpov4Kc2okpWUjuSlqK/ZHAyZFLHHYE4UTVLZnkbSWHSJ5ylctCACiqSkptjJ4duGZLL19Ip+/RaPsuZUte0lfmSmdTCBRRRrVrQFKunNuKEcXBcxZrAwuCtMlQvS4eUjwMGJO9rEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791947658; c=relaxed/simple;
	bh=HCR+uyaLeG5ZGMwMPkwtKzpoMZLt/2K/6Ew13JPoFMU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YP+Dchp6tB2pQSCqKf6RdBmZqGoqSCRoPOjR6TaA0aG313+3OTsqdgcSzfI2W/x4GHqT2DFcbLFTWZDbzBlPE9VLKZhfsqs/15Bmx+HKaRDCJ+1Mp74oWOyDoV0NDm2JkCACJOXqSOKpfzg1qLE3p4zok6CcYCCUYsTVhjvsGYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jonsimons.org; spf=pass smtp.mailfrom=jonsimons.org; dkim=pass (1024-bit key) header.d=jonsimons.org header.i=@jonsimons.org header.b=DhNOGmyY; arc=none smtp.client-ip=173.203.187.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jonsimons.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jonsimons.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=jonsimons.org header.i=@jonsimons.org header.b="DhNOGmyY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=jonsimons.org;
	s=20200911-u7gnnm7o; t=1791947653;
	bh=HCR+uyaLeG5ZGMwMPkwtKzpoMZLt/2K/6Ew13JPoFMU=;
	h=From:To:Subject:Date:From;
	b=DhNOGmyY0tj3zDwUexlCkfPfsu9cYfO0cajm/lo+cCzgjFZ+T9LUcDko0n0+GOojf
	 NxjIJQgsdTjwEPKnPnM2ULdbv5lAM4wZs/Ba3Y6THUAOxIzGNCWrs2H7f9YDo6jqg/
	 kWwUAyaqkyg5/4cTERGG4+Da02KX0XzmzSLuE3oo=
X-Auth-ID: jon@jonsimons.org
Received: by smtp23.relay.iad3a.emailsrvr.com (Authenticated sender: jon-AT-jonsimons.org) with ESMTPSA id 6A7B22530F;
	Tue, 13 Oct 2026 23:14:13 -0400 (EDT)
From: Jon Simons <jon@jonsimons.org>
To: git@vger.kernel.org
Cc: Jon Simons <jon@jonsimons.org>
Subject: [PATCH v2 07/12] t5408: check refspec order with distinct destinations
Date: Tue, 13 Oct 2026 23:13:42 -0400
Message-ID: <20261014031347.50433-8-jon@jonsimons.org>
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
X-Classification-ID: 20ae8d58-78b7-4215-81c6-d8119c94fa7d-8-1

26be19ba8d (send-pack: take refspecs over stdin, 2014-08-21) added tests
to assert that send-pack sends command-line refspecs in the order given,
and those read with --stdin after them, by pushing to the same
destination twice, and seeing which update succeeded.

But since 9d2962a7c4 (receive-pack: use batched reference updates,
2025-05-19) such pushes to the same destination now fail completely on
the server-side with "multiple updates for ref '<dst>' not allowed",
and so the ordering is no longer being asserted.

Add two explicit tests to reinstate the ordering assertions.

Signed-off-by: Jon Simons <jon@jonsimons.org>
---
 t/t5408-send-pack-stdin.sh | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/t/t5408-send-pack-stdin.sh b/t/t5408-send-pack-stdin.sh
index 3c47be1af8..7af350f01c 100755
--- a/t/t5408-send-pack-stdin.sh
+++ b/t/t5408-send-pack-stdin.sh
@@ -67,6 +67,36 @@ test_expect_success 'stdin mixed with cmdline' '
 	verify_push B
 '
 
+test_expect_success 'cmdline refs are sent in order' '
+	clear_remote &&
+	test_hook -C remote.git pre-receive <<-\EOF &&
+	cut -d" " -f3 >pushed-refs
+	EOF
+	git send-pack remote.git A:foo B:bar C:baz &&
+	cat >expect <<-\EOF &&
+	refs/heads/foo
+	refs/heads/bar
+	refs/heads/baz
+	EOF
+	test_cmp expect remote.git/pushed-refs
+'
+
+test_expect_success '--stdin refs are sent after cmdline refs' '
+	clear_remote &&
+	test_hook -C remote.git pre-receive <<-\EOF &&
+	cut -d" " -f3 >pushed-refs
+	EOF
+	echo A:bar >input &&
+	git send-pack remote.git --stdin B:foo <input &&
+	cat >expect <<-\EOF &&
+	refs/heads/foo
+	refs/heads/bar
+	EOF
+	test_cmp expect remote.git/pushed-refs &&
+	verify_push B foo &&
+	verify_push A bar
+'
+
 test_expect_success 'cmdline refs written in order' '
 	clear_remote &&
 	test_must_fail git send-pack remote.git A:foo B:foo 2>err &&
-- 
2.55.0

