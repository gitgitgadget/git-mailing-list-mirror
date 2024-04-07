Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 886B610A0A
	for <git@vger.kernel.org>; Sun,  7 Apr 2024 01:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712451873; cv=none; b=Ec/YrF1/XlvEwpXrZI3hoTIdsOO7InDLnXWAqyqa7XuZonBdxFc8y910ZMbP6mCdt7b50lKdv+bIViuSMf6CgxxmVWYCQ2tCChzfNJvHjSARiXQR9GaAT55rV8itrD6LTOO7Vm+m3IRYcpiue7O92qd6oFm7LgVHWJ1dfC8DgRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712451873; c=relaxed/simple;
	bh=aOK5oyMRCpazZ630LJsRrdQ/ErzdHFBSOSpkp8vb+NE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sCNfE8W+1/BO8pXDu2+eAha8Jx+NMbw7N44H4bddTYmrzW6bf8A1sHuq9kLgAdmwukvYgXgwtRxK44HUcAb81jIvFWCpCfCxk2LxAXVWRe1Lh4C/238m6nEl8hwm/0rcJ1cJ/OgUVqCmFnl2nsdDLkoPV5dGlw6Tt6PVwcHpNUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 7381 invoked by uid 109); 7 Apr 2024 01:04:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 07 Apr 2024 01:04:30 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11266 invoked by uid 111); 7 Apr 2024 01:04:32 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 06 Apr 2024 21:04:32 -0400
Authentication-Results: peff.net; auth=none
Date: Sat, 6 Apr 2024 21:04:29 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, =?utf-8?B?UnViw6lu?= Justo <rjusto@gmail.com>
Subject: [PATCH 09/11] merge: use git_config_string_dup() for pull strategies
Message-ID: <20240407010429.GI868358@coredump.intra.peff.net>
References: <20240407005656.GA436890@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240407005656.GA436890@coredump.intra.peff.net>

Converting pull.twohead and pull.octopus to use git_config_string_dup()
fixes possible leaks if we see those config variables defined multiple
times. Doing so is mostly an "easy" case, except that we later may
assign a string literal to pull_twohead (which is now a non-const
pointer).

That's actually not _too_ bad in practice, as it happens after we've
done all of our config parsing (so nobody would try to free it). And the
compiler won't complain unless -Wwrite-strings is used (and turning that
on creates a host of other warnings, some useful and some not). But
while we're here let's future proof it as best we can.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/merge.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index c2be29ed2f..a9e5100e70 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -101,7 +101,7 @@ static struct strategy all_strategy[] = {
 	{ "subtree",    NO_FAST_FORWARD | NO_TRIVIAL },
 };
 
-static const char *pull_twohead, *pull_octopus;
+static char *pull_twohead, *pull_octopus;
 
 enum ff_type {
 	FF_NO,
@@ -615,9 +615,9 @@ static int git_merge_config(const char *k, const char *v,
 	else if (!strcmp(k, "merge.verifysignatures"))
 		verify_signatures = git_config_bool(k, v);
 	else if (!strcmp(k, "pull.twohead"))
-		return git_config_string(&pull_twohead, k, v);
+		return git_config_string_dup(&pull_twohead, k, v);
 	else if (!strcmp(k, "pull.octopus"))
-		return git_config_string(&pull_octopus, k, v);
+		return git_config_string_dup(&pull_octopus, k, v);
 	else if (!strcmp(k, "commit.cleanup"))
 		return git_config_string_dup(&cleanup_arg, k, v);
 	else if (!strcmp(k, "merge.ff")) {
@@ -1291,7 +1291,7 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 	if (!pull_twohead) {
 		char *default_strategy = getenv("GIT_TEST_MERGE_ALGORITHM");
 		if (default_strategy && !strcmp(default_strategy, "ort"))
-			pull_twohead = "ort";
+			pull_twohead = xstrdup("ort");
 	}
 
 	init_diff_ui_defaults();
-- 
2.44.0.872.g288abe5b5b

