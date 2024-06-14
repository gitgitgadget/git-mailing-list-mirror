Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F38213BAC8
	for <git@vger.kernel.org>; Fri, 14 Jun 2024 10:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718361297; cv=none; b=mGmc6EHV+dIFFr9BKgNVfkfw6G1IfNKVLeqbsOwxWQVzmT9SQ1Z8aPWYjjls6Rf1icj2UBhyyh0PnLeFSAujkS16fpOBzoOMR66BkGNktgqDzrz9KxI8YbTCje71DGxBCxNQI7OgaANvlqINVVavSOmSRcNJ/cZiA7GYlJYuyyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718361297; c=relaxed/simple;
	bh=HtGbiCKU5FTDxmClSGcnC5s821kXlBUU6/kECUQobTc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZbrlPb1GYp9E0LqyEd7mxraD+SaZJdBo4fld8+7CfpZiLBQHtArdkor2aW1conZTn336miRdv3T/gXNEQF9b9wMDMfRlhtdGmkIhXLagUdtIiolEJpPo6NDOIFgMfm/UGjn9WSxIDRw549YqYmjb7RE/3Uf41j760gsJex8UcuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 16616 invoked by uid 109); 14 Jun 2024 10:34:55 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 14 Jun 2024 10:34:55 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27343 invoked by uid 111); 14 Jun 2024 10:34:54 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 14 Jun 2024 06:34:54 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 14 Jun 2024 06:34:54 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Mathew George <mathewegeorge@gmail.com>, git@vger.kernel.org
Subject: [PATCH 09/11] t5801: test remote.*.vcs config
Message-ID: <20240614103454.GI222445@coredump.intra.peff.net>
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

The usual way to trigger a remote helper is to use the "::" syntax from:
87422439d1 (Allow specifying the remote helper in the url, 2009-11-18).
Doing:

  git config remote.origin.url hg::https://example.com/repo

will run "git-remote-hg origin https://example.com/repo". Or you can
use the fallback handling from 25d5cc488a (Pass unknown protocols to
external protocol handlers, 2009-12-09):

  git config remote.origin.url "foo://bar"

which will run "git-remote-foo origin foo://bar".

But there's a third way, from c578f51d52 (Add a config option for
remotes to specify a foreign vcs, 2009-11-18):

  git config remote.origin.vcs foo
  git config remote.origin.url bar

which will run "git-remote-foo origin bar". This is mostly redundant
with the other methods, except that it is supposed to allow you to run
without a URL at all. So:

  git config remote.origin.vcs foo

would run "git-remote-foo origin" with no extra URL parameter (under the
assumption that the helper somehow knows how to access the remote repo).
However, this mode has been broken since 25d5cc488a, shortly after it
was added! That commit taught the transport code to always look at the
URL string to parse off the "foo::" bits, meaning it would always
segfault in the no-url case. You can see that with:

  git -c remote.foo.vcs=bar fetch foo

Nobody seems to have noticed in the almost 15 years since, so presumably
it's not a well-used feature. And without that, arguably the whole
remote.*.vcs feature could be removed entirely, as it isn't offering
anything you couldn't do with the "helper::" syntax. But it _does_ work
if you have a URL, and it has been advertised in the documentation for
all that time. So we shouldn't just remove it without warning.

Likewise, even if we were going to deprecate it, we should avoid
breaking it in the meantime. Since there are no tests for it at all,
let's add a few basic ones:

  - this syntax doesn't work well with "git clone" (another point
    against it versus "helper::"). But we can use "clone -c" to set up
    the config manually, passing the URL as usual to clone. This does
    work, though note that I had to use --no-local in the test to avoid
    broken interactions between the local code and the helper. In the
    real world this would be a non-issue, since the remote URL would
    generally not also be a local Git repo!

  - likewise, we should be able to set up the config manually and fetch
    into a repository. This also works.

  - we can simulate a vcs that has no URL support by stuffing the remote
    path into another environment variable. This should work, but
    doesn't (it hits the segfault mentioned above).

In the first two cases, I took the extra step of checking GIT_TRACE
output to confirm that we actually ran the helper (since the URL is a
valid Git repo, the clone/fetch would appear to work even if we
didn't use the helper at all!).

Signed-off-by: Jeff King <peff@peff.net>
---
I have no real problem with deprecating this, and it might be a nice
thing to clean up in the long run. But it seemed like less work to just
fix it in the next patch, so I did that. ;)

 t/t5801-remote-helpers.sh | 23 +++++++++++++++++++++++
 t/t5801/git-remote-nourl  |  3 +++
 2 files changed, 26 insertions(+)
 create mode 100755 t/t5801/git-remote-nourl

diff --git a/t/t5801-remote-helpers.sh b/t/t5801-remote-helpers.sh
index 4e0a77f985..7c8c4359aa 100755
--- a/t/t5801-remote-helpers.sh
+++ b/t/t5801-remote-helpers.sh
@@ -38,6 +38,29 @@ test_expect_success 'cloning from local repo' '
 	test_cmp server/file local/file
 '
 
+test_expect_success 'clone with remote.*.vcs config' '
+	GIT_TRACE=$PWD/vcs-clone.trace \
+	git clone --no-local -c remote.origin.vcs=testgit "$PWD/server" vcs-clone &&
+	test_grep remote-testgit vcs-clone.trace
+'
+
+test_expect_success 'fetch with configured remote.*.vcs' '
+	git init vcs-fetch &&
+	git -C vcs-fetch config remote.origin.vcs testgit &&
+	git -C vcs-fetch config remote.origin.url "$PWD/server" &&
+	GIT_TRACE=$PWD/vcs-fetch.trace \
+	git -C vcs-fetch fetch origin &&
+	test_grep remote-testgit vcs-fetch.trace
+'
+
+test_expect_failure 'vcs remote with no url' '
+	NOURL_UPSTREAM=$PWD/server &&
+	export NOURL_UPSTREAM &&
+	git init vcs-nourl &&
+	git -C vcs-nourl config remote.origin.vcs nourl &&
+	git -C vcs-nourl fetch origin
+'
+
 test_expect_success 'create new commit on remote' '
 	(cd server &&
 	 echo content >>file &&
diff --git a/t/t5801/git-remote-nourl b/t/t5801/git-remote-nourl
new file mode 100755
index 0000000000..09be6013c5
--- /dev/null
+++ b/t/t5801/git-remote-nourl
@@ -0,0 +1,3 @@
+#!/bin/sh
+
+exec git-remote-testgit "$1" "$NOURL_UPSTREAM"
-- 
2.45.2.937.g0bcb3c087a

