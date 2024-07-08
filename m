Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 590B18C06
	for <git@vger.kernel.org>; Mon,  8 Jul 2024 23:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720481545; cv=none; b=MHZSgvWNvqZEV00jtxBYx3zeUD1dr3dLS4dNpAnb2OtsAybY0Rox4hZ8WIrbcsFFyL/5lLUGUO8ILkSnXw7O1dC6jVQVIp/9zZxoaBv4svZ3YkWHLUtSRMFYHddkKWsQpbHVj2Uo8VHBC9TJUeRPezQk/ghthz2C7jzB4PnC8pA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720481545; c=relaxed/simple;
	bh=pQXm11Dp51dQKMGe+S8B3tHOOcEkOnu0oMD/CQtIblI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W3cg3P8cynYN9/JRbuXH4wyNz4TBHKddY/bG0fulcv983DMKayUknq+7v5uetSHifVsDmm6t7hRJKaJ2bJo/Y86kiSDDNUKat9L0sIIeuV379snMOSdpPUtSi7Cj08ySjJ1DLXjyu23R6Lw5dhOxBsrHYpW4KW+TIuoEiGvaTwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 19947 invoked by uid 109); 8 Jul 2024 23:32:22 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 08 Jul 2024 23:32:22 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28060 invoked by uid 111); 8 Jul 2024 23:32:19 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 08 Jul 2024 19:32:19 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 8 Jul 2024 19:32:20 -0400
From: Jeff King <peff@peff.net>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] builtin/push: call set_refspecs after validating remote
Message-ID: <20240708233220.GA934035@coredump.intra.peff.net>
References: <20240708140350.622986-1-karthik.188@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240708140350.622986-1-karthik.188@gmail.com>

On Mon, Jul 08, 2024 at 04:03:50PM +0200, Karthik Nayak wrote:

> Since 9badf97c4 (remote: allow resetting url list), we reset the remote
> URL if the provided URL is empty. This means any caller of
> `remotes_remote_get()` would now get a NULL remote.
> 
> The 'builtin/push.c' code, calls 'set_refspecs' before validating the
> remote. This worked earlier since we would get a remote, albeit with an
> empty URL. With the new changes, we get a NULL remote and this crashes.

Interesting. I think this was always a bit buggy, in the sense that the
some of the code was prepared for pushremote_get() to return NULL, but
the set_refspecs() call was not. So in theory _any_ problem with the
remote that caused pushremote_get() to bail out would be a problem. But
in practice, I'm not sure there was a way to do so, since the remote.c
code usually falls back on the given name as the url if needed, rather
than returning NULL.

And 9badf97c4 does something a bit unexpected here, since the fallback
calls the same add_url() function that we feed the config values to, and
so it respects the same "empty means reset" logic. Which means that an
empty-string remote name will no longer fall back in that way.

It's a little surprising that we hit the "empty means reset" logic here.
I wonder if that fallback path should be avoiding it. OTOH, an empty
string URL is nonsense, and it's not going to work, so maybe returning a
NULL remote is a good thing. The issue here is mostly just calling BUG()
for something that is bogus input.

> Do a simple fix by doing remote validation first and also add a test to
> validate the bug fix.

OK, so we push it further down, past the "if (!remote)" check in the
caller. I think that's a good fix. It does make me wonder why
set_refspecs() does not simply take the remote struct in the first
place? I.e.:

diff --git a/builtin/push.c b/builtin/push.c
index 992f603de7..ae787f1f63 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -96,9 +96,8 @@ static void refspec_append_mapped(struct refspec *refspec, const char *ref,
 	refspec_append(refspec, ref);
 }
 
-static void set_refspecs(const char **refs, int nr, const char *repo)
+static void set_refspecs(const char **refs, int nr, struct remote *remote)
 {
-	struct remote *remote = NULL;
 	struct ref *local_refs = NULL;
 	int i;
 
@@ -127,12 +126,6 @@ static void set_refspecs(const char **refs, int nr, const char *repo)
 			if (count_refspec_match(ref, local_refs, &matched) != 1) {
 				refspec_append(&rs, ref);
 			} else {
-				/* lazily grab remote */
-				if (!remote)
-					remote = remote_get(repo);
-				if (!remote)
-					BUG("must get a remote for repo '%s'", repo);
-
 				refspec_append_mapped(&rs, ref, remote, matched);
 			}
 		} else
@@ -648,7 +641,7 @@ int cmd_push(int argc, const char **argv, const char *prefix)
 	}
 
 	if (argc > 0)
-		set_refspecs(argv + 1, argc - 1, repo);
+		set_refspecs(argv + 1, argc - 1, remote);
 
 	if (remote->mirror)
 		flags |= (TRANSPORT_PUSH_MIRROR|TRANSPORT_PUSH_FORCE);

which is now possible after your patch. Note that set_refspecs()
currently calls remote_get(), but the caller will use pushremote_get()
to get the remote. I think that set_refspecs() is actually wrong here,
but it doesn't matter in practice because "repo" is always non-NULL at
this point.

But with the patch above, this kind of error would be impossible to
trigger (but again, your patch is still necessary to get the ordering
right in the first place).

> I noticed that this was breaking on master. We run tests on Git master
> for Gitaly at GitLab and I noticed a SEFAULT. I could also reproduce the
> bug by simply doing 'git push "" refs/heads/master' on master, next and
> seen. 

I don't see a segfault, but rather a BUG() that triggers SIGABRT. Does
that match what you see?

> +GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
> +export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
> +
>  TEST_PASSES_SANITIZE_LEAK=true
>  . ./test-lib.sh
>  
> @@ -38,6 +41,11 @@ test_expect_success 'detect missing sha1 expressions early' '
>  	test_cmp expect rp-ran
>  '
>  
> +test_expect_success 'detect empty remote' '
> +	test_must_fail git push "" main 2> stderr &&
> +	grep "fatal: bad repository ''" stderr
> +'

The test makes sense. Your single-quotes are not doing what you expect,
though (they are closing and re-opening the outer test body, so end up
as the empty string). You can use $SQ$SQ instead (I'm also working on
patches to allow you to specify the body as a here-doc to avoid exactly
this kind of situation, but I don't think we should depend on that yet).

I was a little surprised you needed to use the name "main" and not just
"HEAD" or something neutral (avoiding the INITIAL_BRANCH_NAME stuff).
But we only hit the problematic code path when we match a local name.

Also, minor style nit: use "2>stderr" with no space.


Anyway, thanks for catching my bug! I think your fix is the right
approach, and we just need to adjust the test. I do think we should do
the patch I suggested above on top. I'd be happy if you want to add it
in to your series, but let me know if you want me to write a commit
message or just send it separately afterwards.

-Peff
