Received: from smtp92.iad3b.emailsrvr.com (smtp92.iad3b.emailsrvr.com [146.20.161.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77C18391851
	for <git@vger.kernel.org>; Fri,  9 Oct 2026 19:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=146.20.161.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791574236; cv=none; b=TazZ81Z9TqoWoaJWAnwSPKH1qMe9mTkgTefTgGIpw1Yuetlzx5sBcU7VEX2cwotB0AGdF3UTRnXjOjq5gQAIkmb0Bjgq2EoDVN84dEZX3b5XjLqHomrC7g6QDzimiKmNxwJwWa/hvuC2aaWO1HlnkCtLgCmGqAuv5KPW0GcPRo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791574236; c=relaxed/simple;
	bh=RuAfoGBNGSJE5bu7G/4EDv3BCMl2GGDXwpoTXIAYIlw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M6rduS/TL4mrT5fuaL7m1tdJzTv4ICJRt5BNpyLI94/9uKRyEUw4TsPoIs19OsgtDzv3ob/G39xZ9hCDFmXDE9/XXD5NqfK9MpJefwHia6QpvtLMsOM/USSvvg2ghDhGFelfLtaJl4e/Zv2JvdJ9C6ovTsEkcUhcI0RIR0vmgYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jonsimons.org; spf=pass smtp.mailfrom=jonsimons.org; dkim=pass (1024-bit key) header.d=jonsimons.org header.i=@jonsimons.org header.b=DoM1ET/L; arc=none smtp.client-ip=146.20.161.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jonsimons.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jonsimons.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=jonsimons.org header.i=@jonsimons.org header.b="DoM1ET/L"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=jonsimons.org;
	s=20200911-u7gnnm7o; t=1791574220;
	bh=RuAfoGBNGSJE5bu7G/4EDv3BCMl2GGDXwpoTXIAYIlw=;
	h=From:To:Subject:Date:From;
	b=DoM1ET/LxFI6Z5OpeMu78oN0X0zS6DqlG0/9CyWfcZmH7VEVXq4SvsT4GcBHTBfYs
	 6Yr5k6pEwbo3eW5Tv6s2WPflDKok9FZz7W0sNcHpGnuzmCkIXJUZWhek3q3jazp22P
	 yCUKVieduS7rnmxvBiEVlw8J2qRS6cs74XEzeoiM=
X-Auth-ID: jon@jonsimons.org
Received: by smtp4.relay.iad3b.emailsrvr.com (Authenticated sender: jon-AT-jonsimons.org) with ESMTPSA id 7A0412038C;
	Fri,  9 Oct 2026 15:30:20 -0400 (EDT)
From: Jon Simons <jon@jonsimons.org>
To: git@vger.kernel.org
Cc: Jon Simons <jon@jonsimons.org>
Subject: [PATCH 03/15] t5510: document fetch with "./"-prefixed branch.<name>.merge
Date: Fri,  9 Oct 2026 15:29:41 -0400
Message-ID: <20261009192953.81794-4-jon@jonsimons.org>
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
X-Classification-ID: 523ad08c-aaf2-41d9-9ffc-58ea03a01763-4-1

refname_match() formats each candidate through mkpath(), which strips
a leading "./", so a branch.<name>.merge value of "./refs/heads/main"
matches "refs/heads/main" in both places that fetch compares them:

 - branch_merge_matches() when marking fetched refs for merge
   in FETCH_HEAD

 - find_ref_by_name_abbrev() when the merge source is not covered by the
   fetch refspec and is looked up amongst the remote advertised refs

Only a hand-edited config reaches these paths: clone, branch
--set-upstream-to, fetch --set-upstream, and push -u write only names
that have passed check_refname_format(), which rejects a leading "./".

Add two fetch tests asserting that such a "./"-prefixed value does not
match for these cases.  Both are test_expect_failure because the name
matches today:

 - The default fetch refspec should not match "./refs/heads/main"
   with fetched "refs/heads/main" and mark the ref for merge.

 - A protocol v0 fetch with refspec that omits "refs/heads/main"
   should not match "./refs/heads/main" against the remote
   advertised "refs/heads/main".

An upcoming commit stops using mkpath() in refname_match(), at which
point the tests are toggled to test_expect_success.

Signed-off-by: Jon Simons <jon@jonsimons.org>
---
 t/t5510-fetch.sh | 44 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index 300bd5396d..0303784b1f 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -1074,6 +1074,50 @@ test_expect_success 'LHS of refspec follows ref disambiguation rules' '
 	)
 '
 
+test_expect_failure 'fetch with "./"-prefixed branch.<name>.merge does not mark any ref for merge' '
+	mkdir dotslash-merge-default-refspec &&
+	(
+		cd dotslash-merge-default-refspec &&
+		git init -b main server &&
+		test_commit -C server one &&
+		git -C server branch other &&
+		test_commit -C server two &&
+
+		# The bogus ./refs/heads/main should not match the remote refs/heads/main.
+		git clone server client &&
+		git -C client config branch.main.merge ./refs/heads/main &&
+		git -C client fetch &&
+		{
+			echo "$(git -C server rev-parse main)	not-for-merge" &&
+			echo "$(git -C server rev-parse other)	not-for-merge"
+		} >expect &&
+		cut -f -2 client/.git/FETCH_HEAD >actual &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_failure 'fetch protocol v0 with "./"-prefixed branch.<name>.merge does not match any remote ref' '
+	mkdir dotslash-merge-fetch-protocol-v0 &&
+	(
+		cd dotslash-merge-fetch-protocol-v0 &&
+		git init -b main server &&
+		test_commit -C server one &&
+		git -C server branch other &&
+		test_commit -C server two &&
+
+		# Omit refs/heads/main from the fetch refspec so that the merge
+		# source is instead looked up among the refs the remote advertised.
+		git clone server client-v0 &&
+		git -C client-v0 config remote.origin.fetch \
+			+refs/heads/other:refs/remotes/origin/other &&
+		git -C client-v0 config branch.main.merge ./refs/heads/main &&
+		git -C client-v0 -c protocol.version=0 fetch &&
+		echo "$(git -C server rev-parse other)	not-for-merge" >expect &&
+		cut -f -2 client-v0/.git/FETCH_HEAD >actual &&
+		test_cmp expect actual
+	)
+'
+
 test_expect_success 'fetch.writeCommitGraph' '
 	git clone three write &&
 	(
-- 
2.55.0

