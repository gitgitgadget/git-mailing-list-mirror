Received: from smtp90.iad3b.emailsrvr.com (smtp90.iad3b.emailsrvr.com [146.20.161.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ED0646C845
	for <git@vger.kernel.org>; Fri,  9 Oct 2026 19:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=146.20.161.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791574635; cv=none; b=HMC4Z4DwG8eULasTkpjhZkLU/dml6lFgLBuUZ4dUbrUZH4s0FqCOaKEu5GUV8U9fdIEWtJ51vkpXjSJQkRd2BpBd1MMRd5kZqs93leYpJh/5psOzEyKE4eg0/jowvZOTmcFk8ILi8MQL3GDowqN3cbMbGWGxV41c/Abe1NcjYXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791574635; c=relaxed/simple;
	bh=tg/AveneqVDPjsaNt4/N7kt00MUXzg0pn5eSO4TMTt8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MIlsjc8qGUhNZ5CheTaVhyUzxDB4villRD6pcfeaL2aU4W+V3nZAxfn+GDXHNCg1rcJIDNRQNgpCaBw2R10OWqUUTHFLR4vPFi4K7LMC9TDhH5Ss+uxlEzUSa5pdq8H7c44Uvcq+Krumg45dOB3S/qWOweDuWHpxHf1XF0Ng9eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jonsimons.org; spf=pass smtp.mailfrom=jonsimons.org; dkim=pass (1024-bit key) header.d=jonsimons.org header.i=@jonsimons.org header.b=GQra4pEd; arc=none smtp.client-ip=146.20.161.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jonsimons.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jonsimons.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=jonsimons.org header.i=@jonsimons.org header.b="GQra4pEd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=jonsimons.org;
	s=20200911-u7gnnm7o; t=1791574221;
	bh=tg/AveneqVDPjsaNt4/N7kt00MUXzg0pn5eSO4TMTt8=;
	h=From:To:Subject:Date:From;
	b=GQra4pEdtwi6MOTcLC7uVh2iJ9iN0Zvni3SqtsfjLUwrN0KB7CMTt05mHSPNlfyez
	 FVkBvrWmG4vWXMVe8OXO0W3zt74UQgKjwinT9HysJZtG3c5B5TM48vF/UM8fvwtkmp
	 1gQPF8aW01A/jTpwjiFHFnnCkQ/7nmTWRz1mO7uU=
X-Auth-ID: jon@jonsimons.org
Received: by smtp4.relay.iad3b.emailsrvr.com (Authenticated sender: jon-AT-jonsimons.org) with ESMTPSA id CA3842038D;
	Fri,  9 Oct 2026 15:30:20 -0400 (EDT)
From: Jon Simons <jon@jonsimons.org>
To: git@vger.kernel.org
Cc: Jon Simons <jon@jonsimons.org>
Subject: [PATCH 04/15] t/perf: add explicit delete refspec matching test
Date: Fri,  9 Oct 2026 15:29:42 -0400
Message-ID: <20261009192953.81794-5-jon@jonsimons.org>
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
X-Classification-ID: 523ad08c-aaf2-41d9-9ffc-58ea03a01763-5-1

Add p5516 to measure the client-side cost of matching explicit
refspecs on 'git push' against a server that advertises many refs.

The server gets 100k branches, and two clients push 1, 10, 100 delete
refspecs each with --dry-run: an empty client (no local refs), which
isolates matching against the advertised refs, and a mirror client
(full local copy of server refs), to exercise matching against the
same number of local refs.  Delete refspecs and --dry-run are used
to avoid any object transfer or ref update activity in the measurement
and leave the scratch repos unmodified, such that each repetition does
the same amount of matching work.

The test is used to demonstrate speedups in subsequent commits.
Baseline numbers on my machine:

  Test                           this tree
  ----------------------------------------------
  5516.3: empty:refspecs:1       0.14(0.08+0.10)
  5516.5: empty:refspecs:10      0.38(0.32+0.10)
  5516.7: empty:refspecs:100     2.50(2.44+0.10)
  5516.9: mirror:refspecs:1      0.21(0.14+0.11)
  5516.11: mirror:refspecs:10    0.80(0.73+0.11)
  5516.13: mirror:refspecs:100   6.85(6.78+0.12)

Signed-off-by: Jon Simons <jon@jonsimons.org>
---
 t/perf/p5516-push-delete-refspec.sh | 42 +++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)
 create mode 100755 t/perf/p5516-push-delete-refspec.sh

diff --git a/t/perf/p5516-push-delete-refspec.sh b/t/perf/p5516-push-delete-refspec.sh
new file mode 100755
index 0000000000..0e425193e5
--- /dev/null
+++ b/t/perf/p5516-push-delete-refspec.sh
@@ -0,0 +1,42 @@
+#!/bin/sh
+
+test_description='explicit delete refspec matching on push
+
+Measure client-side matching of explicit delete refspecs with "git push
+--dry-run" against a server that advertises lots of refs.  An empty client
+(no local refs) and a mirror client (full local copy of the server refs)
+are tested pushing 1, 10, and 100 refspecs each.
+'
+. ./perf-lib.sh
+
+test_perf_fresh_repo
+
+ref_count=100000
+
+test_expect_success 'create server with many refs and two clients' '
+	test_commit base &&
+	git clone --bare --ref-format=reftable . server &&
+	test_seq -f "create refs/heads/b%d HEAD" $ref_count |
+	git -C server update-ref --stdin &&
+	git init --bare client_empty &&
+	git -C client_empty remote add origin "$PWD/server" &&
+	git clone --mirror --ref-format=reftable "$PWD/server" client_mirror &&
+	git -C client_mirror config --unset remote.origin.mirror
+'
+
+for mode in empty mirror
+do
+	client=client_$mode
+	for nr_refspecs in 1 10 100
+	do
+		test_expect_success "create $mode refspecs: $nr_refspecs" '
+			test_seq -f ":refs/heads/b%d" $nr_refspecs >refspecs
+		'
+
+		test_perf "$mode:refspecs:$nr_refspecs" '
+			git -C '"$client"' push --dry-run origin $(cat refspecs)
+		'
+	done
+done
+
+test_done
-- 
2.55.0

