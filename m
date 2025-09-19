Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC72A2AD24
	for <git@vger.kernel.org>; Fri, 19 Sep 2025 23:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758323245; cv=none; b=qLKa1qZnihZ5fEQhu7v+/fOSqEkvQieKxDRXtNCNOKFqVMAaSsrk0h8gmS5S1ujik1sZeOycSgsvkAk9bUmqUr/YoaoDPPfOsILbdVg64VPjlda4V0gN3B+mEadzZXkboNDVj2PnX/6t0OsRLvBpGv2AI7qT/1RSBSXIp+txuh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758323245; c=relaxed/simple;
	bh=Yp6Y1bEwkeAToEzbamdfLOeENLZYCwxSL5NyM24oS+A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hw9tOwGXcYZ2Xd1n53d2Jkt6P6lWk7S9ceFzARLZscAFMCsk5QXEsHWN0g9qumElL3UtDssdLnoZEHWqDShEVGmY8G+3MpVLkMRW+uglfwLIPJ52LhgydU4SFR3GUVWpDT7WIqJVE09Q9tQE71SNtJ3V1DkhMf+7fbtm/Ieneuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=cPTvZ+4f; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="cPTvZ+4f"
Received: (qmail 134870 invoked by uid 109); 19 Sep 2025 23:07:22 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=Yp6Y1bEwkeAToEzbamdfLOeENLZYCwxSL5NyM24oS+A=; b=cPTvZ+4fI6NQW57sI5THzfojX2wmxZYxTrzMr26LbaIiZWGD3wUltzOi6X8eiwbjOD+Rl3JBbfd1kW423DcKIo0PLQj5n3IRxomVq2RTrJiWJbTSXkDjCj9MfglzR9hKak3mnJ6J8eMQxxX+BI9eXjWYk0mtQ8q3s4K/dRPvXwC82YlUoFY+Onk5bF+PY2VhVDkDQS8PMPjUkc5Hsjv7/hlGkvJLccWmtAvVZm6gVWORpnEYuYyjp7cnZuhpEqxAVYK854VMO+WE8tKPboOD4MH4M7twRKzld8aF5xK4CeztGIJsxUMu7PTuBTtBEoelAw8xnuWFmIuVQ+Fv8xfMwQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 19 Sep 2025 23:07:22 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 211688 invoked by uid 111); 19 Sep 2025 23:07:21 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 19 Sep 2025 19:07:21 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 19 Sep 2025 19:07:21 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Lauri Niskanen <ape@ape3000.com>, git@vger.kernel.org,
	Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH 6/6] revision: retain argv NULL invariant in
 setup_revisions()
Message-ID: <20250919230721.GA936044@coredump.intra.peff.net>
References: <20250919223351.GA3906184@coredump.intra.peff.net>
 <20250919225146.GF594545@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250919225146.GF594545@coredump.intra.peff.net>

On Fri, Sep 19, 2025 at 06:51:46PM -0400, Jeff King wrote:

> It is tempting to do likewise for all of the entries afterwards, too, as
> some of them may also need to be freed (e.g., if coming from a strvec).
> But doing so isn't entirely trivial, as we munge argc in the function
> (e.g., when we find "--" and move all of the entries after it into the
> prune_data list). It would be possible with some light refactoring, but
> it's probably not worth it. Nobody should ever look at them (they are
> beyond the revised argc and past the NULL argv entry) outside of strvec
> cleanup, and setup_revisions_from_strvec() already handles this case.

I _think_ that would probably look like this on top (with obvious
inspiration from your earlier patch), but I don't know if it is
worthwhile or not:

diff --git a/revision.c b/revision.c
index 806a1c4c24..96188ab4ad 100644
--- a/revision.c
+++ b/revision.c
@@ -3003,14 +3003,17 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
 		seen_dashdash = 0;
 		for (i = 1; i < argc; i++) {
 			const char *arg = argv[i];
+			int j;
 			if (strcmp(arg, "--"))
 				continue;
-			if (opt && opt->free_removed_argv_elements)
-				free((char *)argv[i]);
-			argv[i] = NULL;
+			for (j = i; j < argc; j++) {
+				if (i != j)
+					strvec_push(&prune_data, argv[j]);
+				if (opt && opt->free_removed_argv_elements)
+					free((char *)argv[j]);
+				argv[j] = NULL;
+			}
 			argc = i;
-			if (argv[i + 1])
-				strvec_pushv(&prune_data, argv + i + 1);
 			seen_dashdash = 1;
 			break;
 		}
@@ -3192,10 +3195,10 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
 		revs->show_notes_given = 1;
 	}
 
-	if (argv) {
+	while (left < argc--) {
 		if (opt && opt->free_removed_argv_elements)
-			free((char *)argv[left]);
-		argv[left] = NULL;
+			free((char *)argv[argc]);
+		argv[argc] = NULL;
 	}
 
 	return left;
@@ -3205,19 +3208,14 @@ void setup_revisions_from_strvec(struct strvec *argv, struct rev_info *revs,
 				 struct setup_revision_opt *opt)
 {
 	struct setup_revision_opt fallback_opt;
-	int ret;
 
 	if (!opt) {
 		memset(&fallback_opt, 0, sizeof(fallback_opt));
 		opt = &fallback_opt;
 	}
 	opt->free_removed_argv_elements = 1;
 
-	ret = setup_revisions(argv->nr, argv->v, revs, opt);
-
-	for (size_t i = ret; i < argv->nr; i++)
-		free((char *)argv->v[i]);
-	argv->nr = ret;
+	argv->nr = setup_revisions(argv->nr, argv->v, revs, opt);
 }
 
 static void release_revisions_cmdline(struct rev_cmdline_info *cmdline)
