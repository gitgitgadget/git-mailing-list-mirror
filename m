Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD448148319
	for <git@vger.kernel.org>; Fri, 14 Jun 2024 10:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718361434; cv=none; b=PDTcGIVl9vr3UWTBYFMTJM8pME4N8ZkuoOryuBYwyWV0GLu4wGN+LRG64S+DPeyt6dnlmLw9O/XN/mdQttAUYP0wmCcKjYfih4oHJ6iMc7mgbEhXcXdX1BuI/D5knqKgHEqLSseS5b+0xDWfX6SJKVio42nooABoZ4Z1vfSSE1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718361434; c=relaxed/simple;
	bh=oX5bdMPhS1HR3SjNhmUlUjfJMe6ykBhyDE0KbmNJ53E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HK6sCk3JjU0ltJSZM9iiobAnLl5PpDcA9GNP9VDqm3oCQAc52K+q5WnqWxTBIcyA95Nb2OeamNDqhNvDtmWNpZ6YX8eDn60jVXo7GAtcKZfAWWKlU/6Gg5MmZFs13LdZajubMVYDYtYrUKbACxB1V0f9d02QiA8pvHpYwuPxqaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 16632 invoked by uid 109); 14 Jun 2024 10:37:12 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 14 Jun 2024 10:37:12 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27384 invoked by uid 111); 14 Jun 2024 10:37:11 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 14 Jun 2024 06:37:11 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 14 Jun 2024 06:37:11 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Mathew George <mathewegeorge@gmail.com>, git@vger.kernel.org
Subject: [PATCH 10/11] remote: always require at least one url in a remote
Message-ID: <20240614103711.GJ222445@coredump.intra.peff.net>
References: <20240614102439.GA222287@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240614102439.GA222287@coredump.intra.peff.net>

When we return a struct from remote_get(), the result _almost_ always
has at least one url. In remotes_remote_get_1(), we do this:

        if (name_given && !valid_remote(ret))
                add_url_alias(remote_state, ret, name);
        if (!valid_remote(ret))
                return NULL;

So if the remote doesn't have a url, we give it one based on the name
(this is how unconfigured urls are used as remotes). And if that doesn't
work, we return NULL.

But there's a catch: valid_remote() checks that we have at least one url
_unless_ the remote.*.vcs field is set. This comes from c578f51d52 (Add
a config option for remotes to specify a foreign vcs, 2009-11-18), and
the whole idea was to support remote helpers that don't have their own
url.

However, that mode has been broken since 25d5cc488a (Pass unknown
protocols to external protocol handlers, 2009-12-09)! That commit
unconditionally looks at the url in get_helper(), causing a segfault
with something like:

  git -c remote.foo.vcs=bar fetch foo

We could fix that now, of course. But given that it has been broken for
almost 15 years and nobody noticed, there's a better option. This weird
"there might not be a url" special case requires checks all over the
code base, and it's not clear if there are other similar segfaults
lurking. It would be nice if we could drop that special case.

So instead, let's let the "the remote name is the url" code kick in. If
you have "remote.foo.vcs", then your url (unless otherwise configured)
is "foo". This does have a visible effect compared to what 25d5cc488a
was trying to do. The idea back then is that for a remote without a url,
we'd run:

   # only one command-line option!
   git-remote-bar foo

whereas with our default url, now we'll run:

  git-remote-bar foo foo

Again, in practice nobody can be relying on this because it has been
segfaulting for 15 years. We should consider just removing this "vcs"
config option entirely, but that would be a user-visible breakage. So by
fixing it this way, we can keep things working that have been working,
and simplify away one special case inside our code.

This fixes the segfault from 25d5cc488a (demonstrated by the test), and
we can build further cleanups on top.

Signed-off-by: Jeff King <peff@peff.net>
---
 remote.c                  | 2 +-
 t/t5801-remote-helpers.sh | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/remote.c b/remote.c
index b7262964fb..5fa046c8f8 100644
--- a/remote.c
+++ b/remote.c
@@ -32,7 +32,7 @@ struct counted_string {
 
 static int valid_remote(const struct remote *remote)
 {
-	return (!!remote->url.nr) || (!!remote->foreign_vcs);
+	return !!remote->url.nr;
 }
 
 static char *alias_url(const char *url, struct rewrites *r)
diff --git a/t/t5801-remote-helpers.sh b/t/t5801-remote-helpers.sh
index 7c8c4359aa..20f43f7b7d 100755
--- a/t/t5801-remote-helpers.sh
+++ b/t/t5801-remote-helpers.sh
@@ -53,7 +53,7 @@ test_expect_success 'fetch with configured remote.*.vcs' '
 	test_grep remote-testgit vcs-fetch.trace
 '
 
-test_expect_failure 'vcs remote with no url' '
+test_expect_success 'vcs remote with no url' '
 	NOURL_UPSTREAM=$PWD/server &&
 	export NOURL_UPSTREAM &&
 	git init vcs-nourl &&
-- 
2.45.2.937.g0bcb3c087a

