Received: from smtp94.iad3b.emailsrvr.com (smtp94.iad3b.emailsrvr.com [146.20.161.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 949634F4728
	for <git@vger.kernel.org>; Fri,  9 Oct 2026 19:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=146.20.161.94
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791574630; cv=none; b=AFDMzXzsWFpTRPJsyQ/oa9FUnakgdpk8+TTEuynrWOzt7gUOwS95lJPEBzNZGukYqkAAtvhaRw90Za8JF7RzcooiPKNnbnn09uqQBHmkajmXS4YP4fIONgDUxymRGKeckh1FeBs9kMUBJC+mvZ9SFm+wTZtJa9yeQLXtEhX2l8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791574630; c=relaxed/simple;
	bh=HCR+uyaLeG5ZGMwMPkwtKzpoMZLt/2K/6Ew13JPoFMU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l9prMjFraLRzaST9qbF/llVYKi8DEE3wm3zZsl+QBLCaM6ySyTN3hUcf/1HgxjYUwc0rKTNxvKIuZyOrtBBdWHcK9+oc2834lTTBSLX2DPqQyxpU5QD/l+knr5KKctRSuZ/rMqEBqiwrVGl2G9StkJtnmD39oIfjUPyR+2sCIEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jonsimons.org; spf=pass smtp.mailfrom=jonsimons.org; dkim=pass (1024-bit key) header.d=jonsimons.org header.i=@jonsimons.org header.b=I5hZbuT2; arc=none smtp.client-ip=146.20.161.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jonsimons.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jonsimons.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=jonsimons.org header.i=@jonsimons.org header.b="I5hZbuT2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=jonsimons.org;
	s=20200911-u7gnnm7o; t=1791574222;
	bh=HCR+uyaLeG5ZGMwMPkwtKzpoMZLt/2K/6Ew13JPoFMU=;
	h=From:To:Subject:Date:From;
	b=I5hZbuT2fbXAA2+IqgwmC+0DJG4elXBKoZ/4doAOFmB5+OOOv8rQPIqqnGY9ZA0hH
	 sidIHqgWqCG0Er6DSyy5sXRgfNw2h5mGQM0tQ0Kunr5HQD/RpPZJvNOZ7s7tqDuEuj
	 buWLLGqG4jqT4QJfgZquyFylcfBNHvbVEHfl7mdI=
X-Auth-ID: jon@jonsimons.org
Received: by smtp4.relay.iad3b.emailsrvr.com (Authenticated sender: jon-AT-jonsimons.org) with ESMTPSA id 7E9F120392;
	Fri,  9 Oct 2026 15:30:22 -0400 (EDT)
From: Jon Simons <jon@jonsimons.org>
To: git@vger.kernel.org
Cc: Jon Simons <jon@jonsimons.org>
Subject: [PATCH 09/15] t5408: check refspec order with distinct destinations
Date: Fri,  9 Oct 2026 15:29:47 -0400
Message-ID: <20261009192953.81794-10-jon@jonsimons.org>
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
X-Classification-ID: 523ad08c-aaf2-41d9-9ffc-58ea03a01763-10-1

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

