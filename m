Received: from smtp89.iad3b.emailsrvr.com (smtp89.iad3b.emailsrvr.com [146.20.161.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1EA34EFFBD
	for <git@vger.kernel.org>; Fri,  9 Oct 2026 19:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=146.20.161.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791574635; cv=none; b=HE/CjuIUiXkNE/MZpBguJKZvFob1ro7gTuT2sXV9TlGUD/4S6wBkLemm2Va+bRvmo8DbvQaPlj10atIiDYZxCh0UGDa4vw6m+0/HrfHEFcdWkPZV+y/2743XAN2l5AMOkHRSl+Y1rg9isXBAt1g3J/SF2p/RhZf01rIHM5dL20o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791574635; c=relaxed/simple;
	bh=anPM7XW6e9BtAqeKvJqLBBgfSnjDT24XDk6TVJn/3yI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=na5PzLNO4o8xT3SsGo3poZVzbz0tq2KikvaMuiYMfya22uxbzVRjwSihOsj3/zhOAqW7SNI3SNBcEBDffY0IFNDbQwjwyPq33/TLSjH2FLDJIkZqGMjVkRz3/9cMtuENByaHIP8x20KIdIzZupgBq1WGF5oLeOAIWMwW8Ll36h0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jonsimons.org; spf=pass smtp.mailfrom=jonsimons.org; dkim=pass (1024-bit key) header.d=jonsimons.org header.i=@jonsimons.org header.b=RvMzDri4; arc=none smtp.client-ip=146.20.161.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jonsimons.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jonsimons.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=jonsimons.org header.i=@jonsimons.org header.b="RvMzDri4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=jonsimons.org;
	s=20200911-u7gnnm7o; t=1791574220;
	bh=anPM7XW6e9BtAqeKvJqLBBgfSnjDT24XDk6TVJn/3yI=;
	h=From:To:Subject:Date:From;
	b=RvMzDri4dMwfmKLhSaMjCfjo8B6+RMcjrenxiNflwLek1on9E4qbSJMW4STFZrMS1
	 tZLhV9NRkzZUyHKNCu9056NBcOl51LNVU8Ruyf8zIrAqN3M4Sq5xG3rihqIcA80NMA
	 K+eXcfbz/BrODUIG9XG+T6qlsnYWJPqelOI4q0Yk=
X-Auth-ID: jon@jonsimons.org
Received: by smtp4.relay.iad3b.emailsrvr.com (Authenticated sender: jon-AT-jonsimons.org) with ESMTPSA id D19702038A;
	Fri,  9 Oct 2026 15:30:19 -0400 (EDT)
From: Jon Simons <jon@jonsimons.org>
To: git@vger.kernel.org
Cc: Jon Simons <jon@jonsimons.org>
Subject: [PATCH 01/15] remote: validate --force-with-lease <refname> argument
Date: Fri,  9 Oct 2026 15:29:39 -0400
Message-ID: <20261009192953.81794-2-jon@jonsimons.org>
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
X-Classification-ID: 523ad08c-aaf2-41d9-9ffc-58ea03a01763-2-1

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

