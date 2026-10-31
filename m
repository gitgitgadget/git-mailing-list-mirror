Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793429824;
	b=JLDbu6KWG+ptN24UYYMPtcBpU+tpFZjeKIqYFxtV4SDDlIHCrx81v+MpzZ93nhfB0kRJ
	 sod4njMaAxvaZgNl4inXAUqHolkUomDZgJE8IB6r9SXkiRdPf31yFUCK6mFg3P2GrprZW
	 wvFBN0phJTNr/QzAd481UOlRkSCfcQ35WsPUsoBiYrO6lx3MncSOL3v2npnJ8iLFJPJcD
	 gGpBqpYMltSQCQ2gPSJ4VVuM0XWXUFZI1Z2gR0sw9aGIEau5SpFvoDTT3QIsW6uXjQF+g
	 iK5yDcJ4m+Sd3K3Rch343NpJOHZW9jz7Er8L7a6q/ADZAXjXVdVANWkT2XxaNhWxDlg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793429824;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=WOmdSGQlVzcpAg9XWaMrUxNh0CSQMWI3I7nSccq+NYo=;
	b=TKIjftANanUNwZ4RZF1PzhibDdnK7wvBO06pzre0C+fGDU6EqiS6E9mQMm8LP1Ny27x1
	 6oc/2Vf+IqvBlzjYMYsMOQeP8Wj/e6F7ZDq46+3Yi8VPgmZH0HFJdxdhy1NhAcIKNEV+b
	 E9E5WjKvleRvCJW2p3+sUw1624y0tOrZbCdTPYcLR/61HRX1rl4J3RUBE30cZiafV4d3g
	 UolaEBmVxYEKzn1a8CfCWX3xpdS/S5RxNlxddBI863sqBfpR44xb9pLO6YMZivxcIJk80
	 6YdzqA6LBUFZIcoMdHTdYK2tBB9l5TSo9vyMw7JPndIxQXrv3fY0LF6+rhkkD/ytVcg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=l9dEYa8X;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B649E606A31A
	for <git@vger.kernel.org>; Sat, 31 Oct 2026 06:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=l9dEYa8X
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD1A21F000C1;
	Sat, 31 Oct 2026 06:56:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793429823;
	bh=WOmdSGQlVzcpAg9XWaMrUxNh0CSQMWI3I7nSccq+NYo=;
	h=From:To:Cc:Subject:Date;
	b=l9dEYa8XuApX3YTXNEP090fTC/bVc2Hd1u6ZuUo9cLph3GVK7nrlpLBVEHLRFgE4g
	 SjmG4uUrvqdWrUA10CHaeVj+PPs+/0xZe1HMvXkn3ui0iH/jz5r3RwApfJwWtRCGpi
	 W1hD6444GQjJ4X+yFuIdCP383Kka9AeycXXCKSwd9ODjSGyfEMgGt+7nlSFsPpedxs
	 gO4rk9nrVn41MHADEfB94IJXFg07XMyrQ2ISuUwtzReWJ7A/aQV7xdRfODJCsKsFeY
	 F1VstWIV2vpZfhu3s3+5fIgcUDAC4F+HVZKsXQ/dm6UXm4+ylU7Dwh4xX5Ri0H/Hfd
	 eP+bLIiYCYSnQ==
From: Linus Torvalds <torvalds@kernel.org>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH] describe: count the distance correctly when commit dates are skewed
Date: Fri, 30 Oct 2026 23:55:03 -0700
Message-ID: <20261031065525.19883-2-torvalds@kernel.org>
X-Mailer: git-send-email 2.56.0.237.g993442f913
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Linus Torvalds <torvalds@linux-foundation.org>

The current merge window for Linux v7.4 showed annoying behavior with
'git describe', where it doesn't actually follow the documented intent
of the result: the commit distance is miscomputed when the commit dates
aren't entirely reliable.

This makes the 'git describe' output not match what the kernel
calculates in its localversion:

	linux$ git describe && uname -r
	v7.3-19342-g2a500a04d6f9
	7.3.0-19059-g2a500a04d6f9

and the kernel calculation is correct, and 'git describe' is wrong. The
number that 'git describe' gives (19342) is nonsense.

The reason is that 'git describe' has walked the commit list past the
actual tagged release due to walking the commits purely in date order,
and is thus counting a few hundred commits that were already included in
Linux 7.3.

The fix is to take the commit generation number into account when
ordering the commits. That will still fail if the repository has no
commit graph, but it at least improves on the situation in the common
case. With that one-liner fix, 'git describe' gets the correct commit
distance on my kernel tree:

	linux$ git describe && uname -r
	v7.3-19059-g2a500a04d6f9
	7.3.0-19059-g2a500a04d6f9

See also commit 1b600e659a ("Compute accurate distances in git-describe
before output.", 2007-01-27) which fixed a different issue in this same
area. Clearly the *intent* is that the distance number is actually the
real distance.

Also add a test-case for this. Thanks to Claude.

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---

[ Using my kernel.org email to send this, because setting that up is
  easier than fighting gmail ..   - Linus ]

 builtin/describe.c  |  2 +-
 t/t6120-describe.sh | 27 +++++++++++++++++++++++++++
 2 files changed, 28 insertions(+), 1 deletion(-)

diff --git a/builtin/describe.c b/builtin/describe.c
index c0abc931a5..2cd597d919 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -328,7 +328,7 @@ static void append_suffix(int depth, const struct object_id *oid, struct strbuf
 static void describe_commit(struct commit *cmit, struct strbuf *dst)
 {
 	struct commit *c, *gave_up_on = NULL;
-	struct prio_queue queue = { compare_commits_by_commit_date };
+	struct prio_queue queue = { compare_commits_by_gen_then_commit_date };
 	struct commit_name *n;
 	struct possible_tag all_matches[MAX_TAGS];
 	unsigned int match_cnt = 0, annotated_cnt = 0, cur_match;
diff --git a/t/t6120-describe.sh b/t/t6120-describe.sh
index 7a7c46658a..a75f9227d9 100755
--- a/t/t6120-describe.sh
+++ b/t/t6120-describe.sh
@@ -749,6 +749,33 @@ test_expect_success 'setup: describe commits with disjoint bases 2' '
 check_describe -C disjoint2 "B-3-gHASH" HEAD
 check_describe -C disjoint2 --expect-failure "B-3-gHASH" --candidates=2 HEAD
 
+#            T
+#  o----o----o----x
+#        \       /
+#         `--o--'
+#            B
+#
+# T is dated an hour before its parent, so a walk by commit date
+# reaches T's parent through B before it reaches T.
+#
+test_expect_success 'setup: describe a tag dated before its parent' '
+	git init skew &&
+	(
+		cd skew &&
+		git config core.commitGraph true &&
+		test_commit --date "2020-01-01 18:00" base &&
+		test_commit --date "2020-01-01 18:01" o &&
+		test_commit --annotate --date "2020-01-01 17:01" T &&
+		git checkout -b side o &&
+		test_commit --date "2020-01-01 18:02" B &&
+		git checkout main &&
+		GIT_COMMITTER_DATE="2020-01-01 18:03" git merge --no-ff -m x side &&
+		git commit-graph write --reachable
+	)
+'
+
+check_describe -C skew "T-2-gHASH" HEAD
+
 test_expect_success 'setup misleading taggerdates' '
 	GIT_COMMITTER_DATE="2006-12-12 12:31" git tag -a -m "another tag" newer-tag-older-commit unique-file~1
 '
-- 
2.56.0.237.g993442f913

