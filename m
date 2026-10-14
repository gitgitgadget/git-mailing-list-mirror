Received: from smtp119.iad3a.emailsrvr.com (smtp119.iad3a.emailsrvr.com [173.203.187.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDDDF28BAB9
	for <git@vger.kernel.org>; Wed, 14 Oct 2026 03:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.203.187.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791948104; cv=none; b=PASkFFzR2fbdCWgqlxU4mHvm0wyPI8HrJyAMTIRPPiJ5iIk/UI5ep+mXqg/HZCdb847jRh0+E3nIa1RkLX77z5zZF86EIP+n/a75okMOgxNF8elZH4tvWCuSHlYyQrahcAmCzxKiTF4oO95/zDWiAjUqJnUDbdjnAQK/19Jcd78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791948104; c=relaxed/simple;
	bh=tg/AveneqVDPjsaNt4/N7kt00MUXzg0pn5eSO4TMTt8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FC9yoExX6V+rOVOnCKd8pt0RP2QZP9rL0Xm786ufOxVkZ+1IRyxOKjJNFcLDD56BhC2fNKfFameD7u0/MAZj3A2IJqzdLe5QmLADavhFJZuRUlXLLFwP77xRwUST/8wYB2SIwzGB7VFqX03VZBAzWDd8Eg36NRZBG3gaz6SPLrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jonsimons.org; spf=pass smtp.mailfrom=jonsimons.org; dkim=pass (1024-bit key) header.d=jonsimons.org header.i=@jonsimons.org header.b=VaOolYO8; arc=none smtp.client-ip=173.203.187.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jonsimons.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jonsimons.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=jonsimons.org header.i=@jonsimons.org header.b="VaOolYO8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=jonsimons.org;
	s=20200911-u7gnnm7o; t=1791947645;
	bh=tg/AveneqVDPjsaNt4/N7kt00MUXzg0pn5eSO4TMTt8=;
	h=From:To:Subject:Date:From;
	b=VaOolYO83UAnGa4ijha8e5iFZrQbU8Zf1BXTkcs0eB+RmnUeRJvX0ySPKZ7wwTBRk
	 Ar9UQQKRa08MgiMqTobbcpHxy32nEbghlsZ585t2QT7GXEHovZ404TzVwhQv6e1+I6
	 5b5D7k2qp7WB4+Pf781DbYdXWYONQMJINLQyENe4=
X-Auth-ID: jon@jonsimons.org
Received: by smtp23.relay.iad3a.emailsrvr.com (Authenticated sender: jon-AT-jonsimons.org) with ESMTPSA id 54021252C7;
	Tue, 13 Oct 2026 23:14:05 -0400 (EDT)
From: Jon Simons <jon@jonsimons.org>
To: git@vger.kernel.org
Cc: Jon Simons <jon@jonsimons.org>
Subject: [PATCH v2 02/12] t/perf: add explicit delete refspec matching test
Date: Tue, 13 Oct 2026 23:13:37 -0400
Message-ID: <20261014031347.50433-3-jon@jonsimons.org>
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
X-Classification-ID: 20ae8d58-78b7-4215-81c6-d8119c94fa7d-3-1

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

