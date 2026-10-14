Received: from smtp116.iad3a.emailsrvr.com (smtp116.iad3a.emailsrvr.com [173.203.187.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97C713C76BE
	for <git@vger.kernel.org>; Wed, 14 Oct 2026 03:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.203.187.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791947662; cv=none; b=JUaXKgMl3kFO9cLwaD0RJkh9zxQE56RB2fmJXoFpyOmc+AxTOmKayYkkTUtZI7pHgcjuouQ6X85d9WSoTIdWI1rgQFcFqlJWd5sRUqFJDjGx7xMCeObvlyam1bjyDE9fkDoh6QJVLCEGWQXCCkVVlULsY7zXGw5rlBUU3u0CztU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791947662; c=relaxed/simple;
	bh=ORAwWrf52xXXQLFpfSKEmFWHeS4OCDV76yH9I46XlOc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BHCoUD4qjobsk9a4lrjvnBEkxJR7A9+4u/uDcx0u9Ur7UiexEl397oAwn9nu8VQXNXCx92ZsvT6aboM/IdPe6dikK2h1fV0rHVsyIDZANSIG8yMsFd4WiZrJTfyRQPAGindYnSjYv+S7T5jR5c89qkrEq745VvZBDWfYTBMAWZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jonsimons.org; spf=pass smtp.mailfrom=jonsimons.org; dkim=pass (1024-bit key) header.d=jonsimons.org header.i=@jonsimons.org header.b=D9x/AUXg; arc=none smtp.client-ip=173.203.187.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jonsimons.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jonsimons.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=jonsimons.org header.i=@jonsimons.org header.b="D9x/AUXg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=jonsimons.org;
	s=20200911-u7gnnm7o; t=1791947659;
	bh=ORAwWrf52xXXQLFpfSKEmFWHeS4OCDV76yH9I46XlOc=;
	h=From:To:Subject:Date:From;
	b=D9x/AUXgposP3W7oEhyFqclMEAniN58UDUiXm+f3bW0mS2EUnNhR1ss/BjeUH0PrQ
	 oUJEXA1Fn45Bz1QJAfKll0CALv5eCyO6q3cOUVHrieaW7Zbg1cmBWXRRdymet+idkG
	 yluFGllaUuwuDwH4euk5d3u+JvbrSN9r8EVsuKJ0=
X-Auth-ID: jon@jonsimons.org
Received: by smtp23.relay.iad3a.emailsrvr.com (Authenticated sender: jon-AT-jonsimons.org) with ESMTPSA id 7F71B2530F;
	Tue, 13 Oct 2026 23:14:19 -0400 (EDT)
From: Jon Simons <jon@jonsimons.org>
To: git@vger.kernel.org
Cc: Jon Simons <jon@jonsimons.org>
Subject: [PATCH v2 10/12] t/perf: measure --force-with-lease in p5516
Date: Tue, 13 Oct 2026 23:13:45 -0400
Message-ID: <20261014031347.50433-11-jon@jonsimons.org>
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
X-Classification-ID: 20ae8d58-78b7-4215-81c6-d8119c94fa7d-11-1

Extend p5516 with rows that push the same delete refspecs plus one
explicit --force-with-lease=<refname>:<expect> per refspec.

The new rows are used to demonstrate a speedup in a subsequent commit.

Numbers as of this commit
(`./p5516-push-delete-refspec.sh -r create,lease`):

  Test                        this tree
  -------------------------------------------
  5516.16: empty:lease:1      0.12(0.06+0.10)
  5516.19: empty:lease:10     0.17(0.10+0.10)
  5516.22: empty:lease:100    0.45(0.38+0.10)
  5516.25: mirror:lease:1     0.15(0.09+0.10)
  5516.28: mirror:lease:10    0.18(0.12+0.10)
  5516.31: mirror:lease:100   0.52(0.42+0.10)

Signed-off-by: Jon Simons <jon@jonsimons.org>
---
 t/perf/p5516-push-delete-refspec.sh | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/t/perf/p5516-push-delete-refspec.sh b/t/perf/p5516-push-delete-refspec.sh
index 0e425193e5..a1e3f74bf7 100755
--- a/t/perf/p5516-push-delete-refspec.sh
+++ b/t/perf/p5516-push-delete-refspec.sh
@@ -6,6 +6,9 @@ Measure client-side matching of explicit delete refspecs with "git push
 --dry-run" against a server that advertises lots of refs.  An empty client
 (no local refs) and a mirror client (full local copy of the server refs)
 are tested pushing 1, 10, and 100 refspecs each.
+
+A second set of rows measures one --force-with-lease per refspec for
+timing those paths.
 '
 . ./perf-lib.sh
 
@@ -24,6 +27,8 @@ test_expect_success 'create server with many refs and two clients' '
 	git -C client_mirror config --unset remote.origin.mirror
 '
 
+oid=$(git -C server rev-parse HEAD)
+
 for mode in empty mirror
 do
 	client=client_$mode
@@ -39,4 +44,24 @@ do
 	done
 done
 
+for mode in empty mirror
+do
+	client=client_$mode
+	for nr_refspecs in 1 10 100
+	do
+		test_expect_success "create $mode lease refspecs: $nr_refspecs" '
+			test_seq -f ":refs/heads/b%d" $nr_refspecs >refspecs
+		'
+
+		test_expect_success "create $mode leases: $nr_refspecs" '
+			test_seq -f "refs/heads/b%d:'"$oid"'" $nr_refspecs |
+			sed "s/^/--force-with-lease=/" >leases
+		'
+
+		test_perf "$mode:lease:$nr_refspecs" '
+			git -C '"$client"' push --dry-run origin $(cat refspecs) $(cat leases)
+		'
+	done
+done
+
 test_done
-- 
2.55.0

