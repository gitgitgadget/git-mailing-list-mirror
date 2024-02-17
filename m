Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6C73DDA9
	for <git@vger.kernel.org>; Sat, 17 Feb 2024 04:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708145905; cv=none; b=KHotYJj+vNsr1hVdphulhuJgLz3mN0t0iiwPSELXkkzPfYn8aGu0B55YYyFMpvVG7Rc6dNGWiAhfFW7wNvQZj5pgJdVe3IgPc1TDb0L4mvwRRLJKUCrGBSTNOxH65oopIT4FkL1skxI5xTWvQWho711Uh4rPlev3Mdl41LviYvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708145905; c=relaxed/simple;
	bh=vrSWnEYMUm7giGDxh1Ekx5nW/vbZ+oSthrfdemczc7c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e3HlFfFUE53yn93K82IkRdwYSDyKvSZHzAzngMta5Dxd6UQiCi5HT7HVxYDv3p0y/SBYzEkRFi4nNa+5UyuPUU6W/WJpciwoSaZr0kKy0ffmKcF61CO8kWPhXQ5lpkiWp7oKQ+gi5o6F9gM/rNw5UVrYFbaap8g1j3Dle1Bm2CY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 2168 invoked by uid 109); 17 Feb 2024 04:58:16 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 17 Feb 2024 04:58:16 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20578 invoked by uid 111); 17 Feb 2024 04:58:19 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 16 Feb 2024 23:58:19 -0500
Authentication-Results: peff.net; auth=none
Date: Fri, 16 Feb 2024 23:58:14 -0500
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Bo Anderson via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, Bo Anderson <mail@boanderson.me>
Subject: [PATCH] t0303: check that helper_test_clean removes all credentials
Message-ID: <20240217045814.GA539459@coredump.intra.peff.net>
References: <pull.1664.git.1707959036807.gitgitgadget@gmail.com>
 <20240215043900.GA2821179@coredump.intra.peff.net>
 <xmqqle7lskvg.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqle7lskvg.fsf@gitster.g>

On Thu, Feb 15, 2024 at 09:22:27AM -0800, Junio C Hamano wrote:

> > I wonder if we might want something like this, as well, which can catch
> > leftovers:
> 
> Sounds like a good hygiene ;-).

Unfortunately, it is not quite so simple. There are a bunch of other
tests run by t0303 that are not in t0302, because credential-store does
not support caching, expiration, etc.

Putting it in t0301 would be better, but we don't have a way to inspect
the internal state of the cache daemon. We could perhaps add one, but
here's an even hackier solution. ;)

-- >8 --
Subject: [PATCH] t0303: check that helper_test_clean removes all credentials

Our lib-credential.sh library comes with a "clean" function that removes
all of the credentials used in its tests (to avoid leaving cruft in
system credential storage). But it's easy to add a test that uses a new
credential but forget to add it to the clean function.  E.g., the case
fixed by 83e6eb7d7a (t/lib-credential: clean additional credential,
2024-02-15).

We should be able to catch this automatically, but it's a little tricky.

We can't just compare the contents of the helper's storage before and
after the test run, because there isn't a way to ask a helper to dump
all of its storage. And in most cases we don't have direct access to the
underlying storage (since the whole point of the helper is to abstract
that away). We can work around that by using our own "store" helper,
since we can directly inspect its state by looking at its on-disk file.

But there's a catch: the "store" helper doesn't support features like
caching or expiration, so using it naively fails tests (and skipping
those tests would give us incomplete coverage). Implementing all of
those features would be non-trivial. But we can hack around that by
overriding the "check" function used by the tests to turn most requests
into noop success (except for "approve" requests, which actually store
things).

And then at the end we can check that running the "clean" function takes
us back to an empty state.

Note that because we've skipped any tests that erase credentials
(because of our noop check function), the state we see at cleanup time
may be larger than it would be normally. That's OK. The point of the
clean function is to clean up any cruft we _might_ have left in place,
so we're just being doubly thorough.

The way this is bolted onto t0303 feels a little messy. But it's really
the best place to do it, because then we know that it is running the
exact sequence of tests that we'd use for testing a real external
helper. In a normal run of "make test" it currently does nothing (the
idea is that you run it manually after pointing it at some helper
program). But now with this patch, "make test" will sanity-check the
script itself.

Signed-off-by: Jeff King <peff@peff.net>
---
This should be applied on top of ba/credential-test-clean-fix,
naturally, or it will fail. :)

 t/t0303-credential-external.sh | 26 ++++++++++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/t/t0303-credential-external.sh b/t/t0303-credential-external.sh
index 095574bfc6..72ae405c3e 100755
--- a/t/t0303-credential-external.sh
+++ b/t/t0303-credential-external.sh
@@ -32,9 +32,24 @@ commands.
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-credential.sh
 
+# If we're not given a specific external helper to run against,
+# there isn't much to test. But we can still run through our
+# battery of tests with a fake helper and check that the
+# test themselves are self-consistent and clean up after
+# themselves.
+#
+# We'll use the "store" helper, since we can easily inspect
+# its state by looking at the on-disk file. But since it doesn't
+# implement any caching or expiry logic, we'll cheat and override
+# the "check" function to just report all results as OK.
 if test -z "$GIT_TEST_CREDENTIAL_HELPER"; then
-	skip_all="used to test external credential helpers"
-	test_done
+	GIT_TEST_CREDENTIAL_HELPER=store
+	GIT_TEST_CREDENTIAL_HELPER_TIMEOUT=store
+	check () {
+		test "$1" = "approve" || return 0
+		git -c credential.helper=store credential approve
+	}
+	check_cleanup=t
 fi
 
 test -z "$GIT_TEST_CREDENTIAL_HELPER_SETUP" ||
@@ -59,4 +74,11 @@ fi
 # might be long-term system storage
 helper_test_clean "$GIT_TEST_CREDENTIAL_HELPER"
 
+if test "$check_cleanup" = "t"
+then
+	test_expect_success 'test cleanup removes everything' '
+		test_must_be_empty "$HOME/.git-credentials"
+	'
+fi
+
 test_done
-- 
2.44.0.rc1.410.g8325d5f159

