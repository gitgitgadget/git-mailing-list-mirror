Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C52942836E
	for <git@vger.kernel.org>; Mon, 19 Jan 2026 05:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768800131; cv=none; b=UnmJKReQ9d4HibEMRcQG2WDGn86guM5cOvZ+1iG1bQ0jE483oQDqhq3gOyjagWlq2s7707GK27H7dKyA10GvgucHLODVqsImwNrye9um+QenJPPP2lmBt23oSdT98qR6RpfHdTnKI66V7stD/69xoBdu5z0aY9EwHus6z4XipTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768800131; c=relaxed/simple;
	bh=RssCSBsI6HZZfvUM9EKrniW35Xe+C2RJOQfm26PbL5E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D+ZfXeB9swJPBPww/IVjKAogDHzpWVEhvHh0pirl3Y3QT5YtmJXtagzsBS2lBAIYljdlIXa+zbDSXWL/sDmH5w8WtV7u9UcCC1qCt3CD4xi/R+GUuwLaeLpxmZsNjnyaOLStkTMW1qu+29qVhcoxctUPoBprWtlg6IfDsFhneDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=MSpktCwF; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="MSpktCwF"
Received: (qmail 94432 invoked by uid 109); 19 Jan 2026 05:22:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=RssCSBsI6HZZfvUM9EKrniW35Xe+C2RJOQfm26PbL5E=; b=MSpktCwFFHZ52X35fDZOabNGN28rUHb4qhLXI8W7kgZPywLxhd3VjEaJRFSHRCdJYH91dFOOqmcxFkl/j0XDdNl625RSf3F1SJ7D1ukvv5G+T+X5rxeDqhg93Z+3P3z9U9J2w/jzmHcIHySIbi2IxaLAzkkC/CDN0BjsNCNx6VOBwGBQouTX2x4EA8r1uz+A185lrMMv0KDBOUr0h8iJBOoTOHpG6PTfWdVGUiVFQqYnzoq2lWolePAE0P6kbxtqAK2f1xrx92Ig3VRJu/FwNtzenJ00EYp7zV7cvr5XS2D4Jg37wOAtPVakg6mgnX+liD8f1Mx8qwv3p9WuSlZH5A==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 19 Jan 2026 05:22:09 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 153878 invoked by uid 111); 19 Jan 2026 05:22:12 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 19 Jan 2026 00:22:12 -0500
Authentication-Results: peff.net; auth=none
Date: Mon, 19 Jan 2026 00:22:08 -0500
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Harald Nordgren <haraldnordgren@gmail.com>
Subject: [PATCH 3/4] remote: fix leak in branch_get_push_1() with invalid
 "simple" config
Message-ID: <20260119052208.GC1991523@coredump.intra.peff.net>
References: <20260119051858.GA1991308@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260119051858.GA1991308@coredump.intra.peff.net>

Most of the code paths in branch_get_push_1() allocate a string for the
@{push} value. We then return the result, which is stored in a "struct
branch", so the value is not leaked.

But there's one path that does leak: when we are in the "simple" push
mode, we have to check that the @{push} value matches what we'd get for
@{upstream}. If it doesn't, we return an error, but forget to free the
@{push} value we computed.

Curiously, the existing tests don't trigger this with LSan, even though
they do exercise the code path. As far as I can tell, it should be
triggered via:

  git -c push.default=simple \
      -c branch.foo.remote=origin \
      -c branch.foo.merge=refs/heads/not-foo \
      rev-parse foo@{push}

which will complain that the upstream ("not-foo") does not match the
push destination ("foo"). We do die() shortly after this, but not until
after returning from branch_get_push_1(), which is where the leak
happens.

So it seems like a false negative in LSan. However, I can trigger it
reliably by printing the @{push} value using for-each-ref. This takes a
little more setup (because we need "foo" to actually exist to iterate
over it with for-each-ref), but we can piggy-back on the existing repo
config in t6300.

Signed-off-by: Jeff King <peff@peff.net>
---
 remote.c                | 4 +++-
 t/for-each-ref-tests.sh | 9 +++++++++
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/remote.c b/remote.c
index 5de9619bc7..e191b0ff6e 100644
--- a/remote.c
+++ b/remote.c
@@ -1938,9 +1938,11 @@ static const char *branch_get_push_1(struct repository *repo,
 			cur = tracking_for_push_dest(remote, branch->refname, err);
 			if (!cur)
 				return NULL;
-			if (strcmp(cur, up))
+			if (strcmp(cur, up)) {
+				free(cur);
 				return error_buf(err,
 						 _("cannot resolve 'simple' push to a single destination"));
+			}
 			return cur;
 		}
 	}
diff --git a/t/for-each-ref-tests.sh b/t/for-each-ref-tests.sh
index 4593be5fd5..bd2d45c971 100644
--- a/t/for-each-ref-tests.sh
+++ b/t/for-each-ref-tests.sh
@@ -1744,6 +1744,15 @@ test_expect_success ':remotename and :remoteref' '
 	)
 '
 
+test_expect_success '%(push) with an invalid push-simple config' '
+	echo "refs/heads/main " >expect &&
+	git -c push.default=simple \
+	    -c remote.pushdefault=myfork \
+	    for-each-ref \
+	    --format="%(refname) %(push)" refs/heads/main >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success "${git_for_each_ref} --ignore-case ignores case" '
 	${git_for_each_ref} --format="%(refname)" refs/heads/MAIN >actual &&
 	test_must_be_empty actual &&
-- 
2.53.0.rc0.338.g08aa8a9473

