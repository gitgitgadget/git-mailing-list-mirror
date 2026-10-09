Received: from smtp95.iad3b.emailsrvr.com (smtp95.iad3b.emailsrvr.com [146.20.161.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60AC545D93E
	for <git@vger.kernel.org>; Fri,  9 Oct 2026 19:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=146.20.161.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791574233; cv=none; b=tIU3WvZ/Z+Gz9V0kYzaGVwUNiIARsYuRqAxHFZIwBfMmlIPIgdILilCYGfLw/rxFL1DjFX2BdMalgjmzIie0DjymbnR7xWDJEnbmj6KtU50YWkKPnuA7av1ELgviTLiNhD0skayFGcpU745kLGZ6WmyyB4RPboDuAh8Uah4wlcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791574233; c=relaxed/simple;
	bh=+ddQe5/WX5JzPvhgzRKCumCm7TlAHWgCOouXJuPW5rs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GBS/nYRS382brnwT9bX3tJd60n9r+8dujdXh/DHg6VeNpoeLcVn0KvUI4mVz8PXTUNy5DAhFbDxUJHtS93AejkMTKLwV2NhDQb+4Ut/LO9zKK2SBtdGD+vjPXaB8ddo8hwn5tcRo3KmOgN7rpoFyBOUpFtSH6afcVzE37H98I4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jonsimons.org; spf=pass smtp.mailfrom=jonsimons.org; dkim=pass (1024-bit key) header.d=jonsimons.org header.i=@jonsimons.org header.b=V2QTzUHI; arc=none smtp.client-ip=146.20.161.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jonsimons.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jonsimons.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=jonsimons.org header.i=@jonsimons.org header.b="V2QTzUHI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=jonsimons.org;
	s=20200911-u7gnnm7o; t=1791574222;
	bh=+ddQe5/WX5JzPvhgzRKCumCm7TlAHWgCOouXJuPW5rs=;
	h=From:To:Subject:Date:From;
	b=V2QTzUHIc/1Z69TTySt9VkjXobprMs3vLNY6uGQh3Zte0EiSO1LFXAm4AC3iQUIQ1
	 UhiF3g5xE1BC7WJrBCrS7yV5/N/t6g5EXmLlEffHOvP3PArzMozr/3nrYe429RfUxw
	 8NJb4qyXYPcKZKulorgPspemFmgBbpaMBXCssSXE=
X-Auth-ID: jon@jonsimons.org
Received: by smtp4.relay.iad3b.emailsrvr.com (Authenticated sender: jon-AT-jonsimons.org) with ESMTPSA id D02E820385;
	Fri,  9 Oct 2026 15:30:21 -0400 (EDT)
From: Jon Simons <jon@jonsimons.org>
To: git@vger.kernel.org
Cc: Jon Simons <jon@jonsimons.org>
Subject: [PATCH 07/15] t5516: test pushing two refspecs creating the same new branch
Date: Fri,  9 Oct 2026 15:29:45 -0400
Message-ID: <20261009192953.81794-8-jon@jonsimons.org>
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
X-Classification-ID: 523ad08c-aaf2-41d9-9ffc-58ea03a01763-8-1

Pushing two refspecs that create the same new branch fails client-side
as desired with "dst ref <dst> receives from more than one src", as long
as the remote advertises at least one ref.

But pushing the same to an empty remote does not fail client-side as
expected: a --dry-run push prints "[new branch]" twice, and an actual
push fails on the server side with "multiple updates for ref '<dst>'
not allowed".

Add tests for both remotes, with and without --dry-run.  The empty repo
passes are marked as test_expect_failure, in preparation for a commit
that includes a fix and toggles them to test_expect_success.

Signed-off-by: Jon Simons <jon@jonsimons.org>
---
 t/t5516-fetch-push.sh | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index 81ad6cd52f..e150246577 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -400,6 +400,42 @@ test_expect_success 'push with no ambiguity (2)' '
 	check_push_result testrepo $the_commit remotes/origin/main
 '
 
+test_expect_success 'push --dry-run two refspecs targeting the same ref fails' '
+	mk_test testrepo heads/main &&
+	test_must_fail git push --dry-run testrepo main:frotz main:frotz 2>err &&
+	test_grep "dst ref refs/heads/frotz receives from more than one src" err
+'
+
+test_expect_success 'push two refspecs targeting the same ref fails' '
+	mk_test testrepo heads/main &&
+	test_must_fail git push testrepo main:frotz main:frotz 2>err &&
+	test_grep "dst ref refs/heads/frotz receives from more than one src" err
+'
+
+test_expect_failure 'push --dry-run two refspecs creating the same ref fails on empty repo' '
+	mk_empty testrepo &&
+	test_must_fail git push --dry-run testrepo main:frotz main:frotz 2>err &&
+	test_grep "dst ref refs/heads/frotz receives from more than one src" err
+'
+
+test_expect_failure 'push two refspecs creating the same ref fails on empty repo' '
+	mk_empty testrepo &&
+	test_must_fail git push testrepo main:frotz main:frotz 2>err &&
+	test_grep "dst ref refs/heads/frotz receives from more than one src" err
+'
+
+test_expect_failure 'push --dry-run abbreviated then full refspec creating the same ref fails on empty repo' '
+	mk_empty testrepo &&
+	test_must_fail git push --dry-run testrepo main:frotz main:refs/heads/frotz 2>err &&
+	test_grep "dst ref refs/heads/frotz receives from more than one src" err
+'
+
+test_expect_failure 'push abbreviated then full refspec creating the same ref fails on empty repo' '
+	mk_empty testrepo &&
+	test_must_fail git push testrepo main:frotz main:refs/heads/frotz 2>err &&
+	test_grep "dst ref refs/heads/frotz receives from more than one src" err
+'
+
 test_expect_success 'push with colon-less refspec, no ambiguity' '
 	mk_test testrepo heads/main heads/t/main &&
 	git branch -f t/main main &&
-- 
2.55.0

