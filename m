Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8051E366057
	for <git@vger.kernel.org>; Wed,  2 Sep 2026 05:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788328654; cv=none; b=TTkfek3oItEvWmgsjQ1Fyj93Ny9h5WhG81oosEoGA/T+gOcjkOrul9V40FK3Zn0BTbuKMCmE4+7NP9fqFPwammYHRcRPrRYjph0rs2+YtByfP6juUs7blc8Dn+Bq8XFKi7fTOTU22jBDW+tOf4a9K0JN4t2IJYwwxwaDj/zF4Z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788328654; c=relaxed/simple;
	bh=pLjGhXndnQDBtSMM6UAlLZZK92c1ZRepOEV9BLeTWaA=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MD9fkva2QNrGwl95C+ekxvgYRnaatePihKCw1hYs5aQLGZ6HFs/KIey1mskQBcueYGk8Qgu26s2Hno522BGS9Ui4t6Qul4RenlrenIDoQ8+dr0AJcc6PZKkv7BvMoUFkxv8ByB9w8NwGqfrekLR9w0nkHHlRWvvr/p6NHY9olXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=UP9glvnC; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="UP9glvnC"
Received: (qmail 9968 invoked by uid 106); 2 Sep 2026 05:57:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=pLjGhXndnQDBtSMM6UAlLZZK92c1ZRepOEV9BLeTWaA=; b=UP9glvnCtmpk+my0E6zk9IAsdktXsRlz9Ow0NsLVAWT56Fi0mx7WjgcFhdtt/d2wtz18xtqfgqRqwTBACPHT94DuCvyPMv8cKTgVlLjzpHlxeYjT54JY78qub2gOW8GFLQ9FAO/SxMpj0/IOUHUolJP02MWhDWxuaIGapQhQfbd9y9P+JfaWIQbpFQJOW3a8gbYO6U9OBjkKUzqFXJpaV6DR2sfq000kVbVkkbtcSdu/C+M7nvxmCi173lsHJySfW3Y2HDxQaTUk9jR/ASGaVyfZuI1+4F2gRtJjXERm4fRlKUh9iFSoUCEouwNpocg/+ufj2x1RtmqsUfesRGK/lA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 02 Sep 2026 05:57:31 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 46859 invoked by uid 111); 2 Sep 2026 05:57:31 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 02 Sep 2026 01:57:31 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 2 Sep 2026 01:57:30 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Subject: [PATCH 2/2] submodule--helper: free URL when repository setup fails
Message-ID: <20260902055730.GB41747@coredump.intra.peff.net>
References: <20260902055117.GA41587@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260902055117.GA41587@coredump.intra.peff.net>

If repo setup fails, we'll return an error without freeing the allocated
url string, leaking the memory. The test suite does trigger this error,
but never with the leak. We only allocate a url if submodule_from_path()
returned something, but our tests use other situations, like totally
nonexistent submodules.

We can cover this case by asking about a submodule that exists but which
has not been initialized. The new test fails with SANITIZE=leak.

The smallest fix would just be a call to free(url), but I think it's a
little nicer to set up a dedicated out-path for cleanup here. The
previous commit made it safe to call repo_clear() even if
repo_submodule_init() fails.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/submodule--helper.c             | 10 +++++++---
 t/t7426-submodule-get-default-remote.sh | 17 +++++++++++++++++
 2 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index e7cd3225fa..469e3dbcc9 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -80,6 +80,7 @@ static int get_default_remote_submodule(const char *module_path, char **default_
 	struct repository subrepo;
 	const char *remote_name = NULL;
 	char *url = NULL;
+	int ret = 0;
 
 	sub = submodule_from_path(the_repository, null_oid(the_hash_algo), module_path);
 	if (sub && sub->url) {
@@ -96,9 +97,11 @@ static int get_default_remote_submodule(const char *module_path, char **default_
 	}
 
 	if (repo_submodule_init(&subrepo, the_repository, module_path,
-				null_oid(the_hash_algo)) < 0)
-		return die_message(_("could not get a repository handle for submodule '%s'"),
+				null_oid(the_hash_algo)) < 0) {
+		ret = die_message(_("could not get a repository handle for submodule '%s'"),
 				   module_path);
+		goto out;
+	}
 
 	/* Look up by URL first */
 	if (url)
@@ -108,10 +111,11 @@ static int get_default_remote_submodule(const char *module_path, char **default_
 
 	*default_remote = xstrdup(remote_name);
 
+out:
 	repo_clear(&subrepo);
 	free(url);
 
-	return 0;
+	return ret;
 }
 
 static int module_get_default_remote(int argc, const char **argv, const char *prefix,
diff --git a/t/t7426-submodule-get-default-remote.sh b/t/t7426-submodule-get-default-remote.sh
index b842af9a2d..0379c9f044 100755
--- a/t/t7426-submodule-get-default-remote.sh
+++ b/t/t7426-submodule-get-default-remote.sh
@@ -60,6 +60,23 @@ test_expect_success 'get-default-remote fails with non-submodule path' '
 	)
 '
 
+test_expect_success 'get-default-remote fails with uninitialized submodule' '
+	test_when_finished "
+		git -C super config -f .gitmodules --remove-section submodule.uninitialized &&
+		git -C super update-index --force-remove uninitialized
+	" &&
+	(
+		cd super &&
+		git config -f .gitmodules submodule.uninitialized.path uninitialized &&
+		git config -f .gitmodules submodule.uninitialized.url ../sub &&
+		head=$(git -C ../sub rev-parse HEAD) &&
+		git update-index --add --cacheinfo 160000,$head,uninitialized &&
+		test_must_fail git submodule--helper get-default-remote \
+			uninitialized 2>err &&
+		test_grep "could not get a repository handle" err
+	)
+'
+
 test_expect_success 'get-default-remote fails without path argument' '
 	(
 		cd super &&
-- 
2.55.0.1067.gf7fc94a55c
