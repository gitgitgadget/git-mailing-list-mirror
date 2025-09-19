Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94B652D8381
	for <git@vger.kernel.org>; Fri, 19 Sep 2025 22:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758321631; cv=none; b=QimSwPRw/2YQtilwN+O0+BniNSzcolhPzpNQFPmp2XLMDkSh4ut+5lECYbgWutoITQ9M6cIZGBPTuSdoT+ONwb1evxPElO96eALCgJ0FdJ4E1tHX+3BbcjEQBw/iTkP5CYO8mSNMVaWCW+sE0cLIv+kZrdAOVuqqauA0rlbDcow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758321631; c=relaxed/simple;
	bh=ZteoDuLj+/h0htv15mDvAUyDIsYKpVaufsNFKz54uq8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WrJcAqiVSENujDuv/6nD/EmBd2Ix7xJWPRD4IhhNYEGdKIKHtI1IcGBbLTeQHonkzjaM8n3tQiUk/d5EdIOgSmxFs3NCzD7d5cTfWkSHvLt9YAHtZNjl62C03LCqbaUmG+jDXjNt3prhE20ltL4MdIMZKGHjyEGCHlaD2omdeo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=fpV0Ei8p; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="fpV0Ei8p"
Received: (qmail 134733 invoked by uid 109); 19 Sep 2025 22:40:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=ZteoDuLj+/h0htv15mDvAUyDIsYKpVaufsNFKz54uq8=; b=fpV0Ei8pT3q0FNNgvPpyuHzrjnehK24Wovyo/ShD8cRHuTrzqP1tklb9aTQ6v4dwOBeAKZTpPJeXnWL1f3kJEMAzucIIV9rdN+TDAr5HocPZWcv/GQvt5rcoIKASb6eYYgBhvBer0BzR3jAVYR0T+2WxM/EO9Gf14kLVQQ5K1CLk9ZxaRHe14/RA7p1IjOeWCIgyT3ZQpDpTVuLb7Y8njw+FdKHuf03u/nuotfzJoVg+GnlyACjDo/RGBzs3ScAlQTmUfUt6CFbsHliS2LvzI2+fJ1Wuu1Ijb/kv8vtscGoAlNhpBRc9kIluoeBDpFhNLFeRk67rVlDG4/NMCPcoaQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 19 Sep 2025 22:40:28 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 211342 invoked by uid 111); 19 Sep 2025 22:40:28 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 19 Sep 2025 18:40:28 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 19 Sep 2025 18:40:27 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Lauri Niskanen <ape@ape3000.com>, git@vger.kernel.org,
	Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 1/6] stash: tell setup_revisions() to free our allocated
 strings
Message-ID: <20250919224027.GA594545@coredump.intra.peff.net>
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

In "git stash show", we do a first pass of parsing our command line
options by splitting them into revision args and stash args. These are
stored in strvecs, and we pass the revision args to setup_revisions().

But setup_revisions() may modify the argv we pass it, causing us to leak
some of the entries. In particular, if it sees a "--" string, that will
be dropped from argv. This is the same as other cases addressed by
f92dbdbc6a (revisions API: don't leak memory on argv elements that need
free()-ing, 2022-08-02), and we should fix it the same way: by passing
the free_removed_argv_elements option to setup_revisions().

I've added a test here which fails when built with SANITIZE=leak because
it calls "git stash show --". This by itself is not a very
interesting invocation, because there is nothing after the "--", and
thus the "--" is not really doing anything.

But I think the current parsing in show_stash() is a little
questionable. It splits the arguments into revision options and stash
options solely based on the presence of a leading dash, with no regard
to "--" at all. So:

  git stash show -- foo

will take "foo" as a stash option before we even pass anything to
setup_revisions(). And something like:

  git stash show -- 1

will show stash@{1}. But I would expect anything after the "--" to be a
pathspec. So in this example it would show only the part of the diff
that touched "foo". And something like:

  git stash show -p 1 -- foo

would treat "1" as a stash and "foo" as a pathspec.

That may be something we want to fix, but I want to focus here on the
leak-fixing without changing behavior. So this test is a little odd, but
does what we want without locking us in to any particular behavior (we
only care that "--" by itself does not change the output nor leak).

Signed-off-by: Jeff King <peff@peff.net>
---
I wonder if anybody actually cares that "git stash show -- foo" will
treat "foo" as a stash. If not, then it would probably be a fairly easy
#leftoverbits project to teach it to stop there and retain everything
after as a rev argument (which would then treat it like a pathspec).

 builtin/stash.c  | 3 ++-
 t/t3903-stash.sh | 6 ++++++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/builtin/stash.c b/builtin/stash.c
index f5ddee5c7f..e5ab3c4cf5 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -957,6 +957,7 @@ static void diff_include_untracked(const struct stash_info *info, struct diff_op
 static int show_stash(int argc, const char **argv, const char *prefix,
 		      struct repository *repo UNUSED)
 {
+	struct setup_revision_opt opt = { .free_removed_argv_elements = 1 };
 	int i;
 	int ret = -1;
 	struct stash_info info = STASH_INFO_INIT;
@@ -1015,7 +1016,7 @@ static int show_stash(int argc, const char **argv, const char *prefix,
 		}
 	}
 
-	argc = setup_revisions(revision_args.nr, revision_args.v, &rev, NULL);
+	argc = setup_revisions(revision_args.nr, revision_args.v, &rev, &opt);
 	if (argc > 1)
 		goto usage;
 	if (!rev.diffopt.output_format) {
diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index 0bb4648e36..1c9e589bbe 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -1741,4 +1741,10 @@ test_expect_success 'submodules does not affect the branch recorded in stash mes
 	)
 '
 
+test_expect_success 'stash show handles --' '
+	git stash show >expect &&
+	git stash show -- >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
2.51.0.568.g6b54b97edf

