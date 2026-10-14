Received: from smtp113.iad3a.emailsrvr.com (smtp113.iad3a.emailsrvr.com [173.203.187.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 873D53C0601
	for <git@vger.kernel.org>; Wed, 14 Oct 2026 03:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.203.187.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791948106; cv=none; b=pg8C9zERk1c6kCudUn0KvC1STDGHsOFa+zmhd4d8Z3fF75IrAYLOcGaqrTgIyMs+kw7v0ysJfoqy+ny3WXWwTgRKfYbsljd0oYxROZEjdGN2AG0V1/KE8wUqkREMm6rOTrKLSsA6mhe9IW/+SNTFIKnoW4r+CfUOIro5CXqGwyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791948106; c=relaxed/simple;
	bh=anPM7XW6e9BtAqeKvJqLBBgfSnjDT24XDk6TVJn/3yI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i/wiZZOnK2M9gFkDcMWFcmj1LcY1uDQkuRcsbVnwbJ1y2NCyG+5VUtThi82ldXc1Crzyp0sh/u+NJixT1tHsvchpb7oCqkD39ksjKvID20VAphcJij25/2bvYOxB59//wjvdCPoRvMP4DvZa1Ohqe2j7FHzMRlAaYLiHMCvvrGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jonsimons.org; spf=pass smtp.mailfrom=jonsimons.org; dkim=pass (1024-bit key) header.d=jonsimons.org header.i=@jonsimons.org header.b=YlsbqV2i; arc=none smtp.client-ip=173.203.187.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jonsimons.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jonsimons.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=jonsimons.org header.i=@jonsimons.org header.b="YlsbqV2i"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=jonsimons.org;
	s=20200911-u7gnnm7o; t=1791947643;
	bh=anPM7XW6e9BtAqeKvJqLBBgfSnjDT24XDk6TVJn/3yI=;
	h=From:To:Subject:Date:From;
	b=YlsbqV2ieslIA0xX3NOuqfom5WTi1e22GocqEbFhCFN8ihXVewW10CFopL1exL0rT
	 ptXG+/HR4NGzGDn2s8NVvuv1DFHSGjhMzp0EWxLwO5PH10gzm6qjLbC7J1rZ16AE0d
	 7pTb+13NDOR4pPLMYQdZfIUF92bZ9gOKyt7jJRRI=
X-Auth-ID: jon@jonsimons.org
Received: by smtp23.relay.iad3a.emailsrvr.com (Authenticated sender: jon-AT-jonsimons.org) with ESMTPSA id 4170C252A9;
	Tue, 13 Oct 2026 23:14:03 -0400 (EDT)
From: Jon Simons <jon@jonsimons.org>
To: git@vger.kernel.org
Cc: Jon Simons <jon@jonsimons.org>
Subject: [PATCH v2 01/12] remote: validate --force-with-lease <refname> argument
Date: Tue, 13 Oct 2026 23:13:36 -0400
Message-ID: <20261014031347.50433-2-jon@jonsimons.org>
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
X-Classification-ID: 20ae8d58-78b7-4215-81c6-d8119c94fa7d-2-1

Use check_refname_format() to validate the <refname> component of
'git push --force-with-lease=<refname>[:<expect>]'.

apply_push_cas() will silently ignore a lease entry that does not match
any remote ref.  And today "./refs/heads/main" will happen to be matched
with "refs/heads/main" due to refname_match() usage of mkpath(), whose
cleanup_path() strips leading "./".

An upcoming commit removes mkpath() from refname_match(), after which
there is no unintentional match in this situation, so that the lease
is ignored instead of applied.  Reject an invalid refname now to make
this situation fail fast both before and after that change.

Signed-off-by: Jon Simons <jon@jonsimons.org>
---
 remote.c            | 2 ++
 t/t5533-push-cas.sh | 9 +++++++++
 2 files changed, 11 insertions(+)

diff --git a/remote.c b/remote.c
index 71170f36a9..114d4d983c 100644
--- a/remote.c
+++ b/remote.c
@@ -2740,6 +2740,8 @@ static int parse_push_cas_option(struct push_cas_option *cas, const char *arg, i
 	/* "--<option>=refname" or "--<option>=refname:value" */
 	colon = strchrnul(arg, ':');
 	entry = add_cas_entry(cas, arg, colon - arg);
+	if (check_refname_format(entry->refname, REFNAME_ALLOW_ONELEVEL))
+		return error(_("'%s' is not a valid refname"), entry->refname);
 	if (!*colon)
 		entry->use_tracking = 1;
 	else if (!colon[1])
diff --git a/t/t5533-push-cas.sh b/t/t5533-push-cas.sh
index e6e1360a42..f6eafee7ad 100755
--- a/t/t5533-push-cas.sh
+++ b/t/t5533-push-cas.sh
@@ -63,6 +63,15 @@ test_expect_success setup '
 	test_commit C
 '
 
+test_expect_success 'push --force-with-lease rejects invalid refname' '
+	setup_srcdst_basic &&
+	(
+		cd dst &&
+		test_must_fail git push --force-with-lease=./refs/heads/main origin main 2>err &&
+		test_grep "is not a valid refname" err
+	)
+'
+
 test_expect_success 'push to update (protected)' '
 	setup_srcdst_basic &&
 	(
-- 
2.55.0

