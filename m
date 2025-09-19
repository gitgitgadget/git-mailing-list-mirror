Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F3E42D5426
	for <git@vger.kernel.org>; Fri, 19 Sep 2025 22:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758322151; cv=none; b=EEWOE/DHY6pym8O1RRFt0/ak+LEoOpyiov37h0eK3PI76I6iRidgIXbfxDl2i1Zdp/ZBwPcqr3sn+zGMIHQHWjRjALMqsbolGlah2hv9xMBu7DBKAhPMrOrp2Qg6JcYkm2WMtJT6255WUl38xzwNDJIB9jnMkADrt22Xc1UMr2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758322151; c=relaxed/simple;
	bh=IEQEIzEV5xLLEaxAnCELnvCIx5YZ3QU7uAmle+QuwlU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FuyaiV04Il+7lcLDl2tchGAbk5jO/z/Lu3jatvB4toWfNu3hsvzBe/wagPp29Q+Wo+niZy2BBS7Frn3Wuduvgdyia14aV4NXHlDYmBSvfXzwkoYADiyyuIP7JATc07+4I9KYU/1KW9AbN5a+lJc7trjDzekeIeCydTnpDaBJz1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=BuT9b/Nf; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="BuT9b/Nf"
Received: (qmail 134796 invoked by uid 109); 19 Sep 2025 22:49:08 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=IEQEIzEV5xLLEaxAnCELnvCIx5YZ3QU7uAmle+QuwlU=; b=BuT9b/NfQ91wbtj4L+/tCmr78x6f25c1BHC/fzzsrrXXOUceo3GhAn/spYS4+rJmHMr8S9CcVqgUOcvrAuvr5N8VBFT46iodihm1OvHCGQMcM4BRI5kWcl0Ic0BP5RLyCYdZGXViV6Qc2POKFDCeDinGAflEvlWtMaH9/h4uHub8c4E3dsIM5Gels5BekshhJ4ATFtn401oDl9DJxXic09IrtiaVavS9iOvpAgT3LfQZ57ifTzyVzgUVNs+uCzYLjMfrWcysZ8Zar8lXrCsoySThHkdnpPmYda7dujzGBBSwsqYXbqEzJUt3iW7f7kNyQ+0tYnVI8JnxyuptsUkg1Q==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 19 Sep 2025 22:49:08 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 211418 invoked by uid 111); 19 Sep 2025 22:49:07 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 19 Sep 2025 18:49:07 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 19 Sep 2025 18:49:07 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Lauri Niskanen <ape@ape3000.com>, git@vger.kernel.org,
	Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 4/6] treewide: use setup_revisions_from_strvec() when we have
 a strvec
Message-ID: <20250919224907.GD594545@coredump.intra.peff.net>
References: <20250919223351.GA3906184@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250919223351.GA3906184@coredump.intra.peff.net>

The previous commit introduced a wrapper to make using setup_revisions()
with a strvec easier and safer. It converted spots that were already
doing most of what the wrapper did.

Let's now convert spots where we were not setting up the
free_removed_argv_elements flag. As discussed in the previous commit,
this probably isn't fixing any bugs or leaks (since these sites wouldn't
trigger the re-shuffling of argv that causes them). This is mostly
future-proofing us against setup_revisions() becoming more aggressive
about its re-shuffling.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/describe.c | 3 ++-
 http-push.c        | 2 +-
 submodule.c        | 2 +-
 3 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/builtin/describe.c b/builtin/describe.c
index 9f4e26d7ff..ffaf8d9f0a 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -580,7 +580,8 @@ static void describe_blob(const struct object_id *oid, struct strbuf *dst)
 		     NULL);
 
 	repo_init_revisions(the_repository, &revs, NULL);
-	if (setup_revisions(args.nr, args.v, &revs, NULL) > 1)
+	setup_revisions_from_strvec(&args, &revs, NULL);
+	if (args.nr > 1)
 		BUG("setup_revisions could not handle all args?");
 
 	if (prepare_revision_walk(&revs))
diff --git a/http-push.c b/http-push.c
index 91a5465afb..4c43ba3bc7 100644
--- a/http-push.c
+++ b/http-push.c
@@ -1941,7 +1941,7 @@ int cmd_main(int argc, const char **argv)
 			strvec_pushf(&commit_argv, "^%s",
 				     oid_to_hex(&ref->old_oid));
 		repo_init_revisions(the_repository, &revs, setup_git_directory());
-		setup_revisions(commit_argv.nr, commit_argv.v, &revs, NULL);
+		setup_revisions_from_strvec(&commit_argv, &revs, NULL);
 		revs.edge_hint = 0; /* just in case */
 
 		/* Generate a list of objects that need to be pushed */
diff --git a/submodule.c b/submodule.c
index fff3c75570..35c55155f7 100644
--- a/submodule.c
+++ b/submodule.c
@@ -900,7 +900,7 @@ static void collect_changed_submodules(struct repository *r,
 	save_warning = warn_on_object_refname_ambiguity;
 	warn_on_object_refname_ambiguity = 0;
 	repo_init_revisions(r, &rev, NULL);
-	setup_revisions(argv->nr, argv->v, &rev, &s_r_opt);
+	setup_revisions_from_strvec(argv, &rev, &s_r_opt);
 	warn_on_object_refname_ambiguity = save_warning;
 	if (prepare_revision_walk(&rev))
 		die(_("revision walk setup failed"));
-- 
2.51.0.568.g6b54b97edf

