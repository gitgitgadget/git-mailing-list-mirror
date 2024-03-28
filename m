Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A77D286AF
	for <git@vger.kernel.org>; Thu, 28 Mar 2024 11:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711626042; cv=none; b=IGllRduobSAC9ks5v2MbfYcGjNDcV2IDMxqPbExMPM/m0OW6tcb7NQB8TYo8bTv157EdIYZONjms3IWhVftrzQl/F6GlHTHKfjc4id7l5WytZPHv7rvTgSqZNjDGdy/ENNNXiiVwrxUjwq/eaXB1a/RU5zZ9saxiyD9/Ckg64o8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711626042; c=relaxed/simple;
	bh=xeHefqLhn4GU9Ow95Zy5LkSi4FEmag9mWkYajUQ+lXM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DSScUg+Pc120sccM6mf2JQQtRp0GA9zdzBUvey6OR3mnA5ZmJHpMM9mj2DP8NxRbAk+LrEsmnB3VSwuStf6INEupaOZL+CUXv4HwfliKeGI2kizntlObpWL+Cxsm6wqtX3GfExVqzquT8x4IazXTpscBZ4YmSMCHDmsUTFoF8nA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 4194 invoked by uid 109); 28 Mar 2024 11:40:39 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 28 Mar 2024 11:40:39 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5550 invoked by uid 111); 28 Mar 2024 11:40:39 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 28 Mar 2024 07:40:39 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 28 Mar 2024 07:40:38 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Han Young <hanyang.tony@bytedance.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 0/1] quote: quote space
Message-ID: <20240328114038.GA1394725@coredump.intra.peff.net>
References: <20240319095212.42332-1-hanyang.tony@bytedance.com>
 <xmqqttl2qml9.fsf@gitster.g>
 <xmqqfrwlltjn.fsf@gitster.g>
 <xmqqsf0bz5oj.fsf@gitster.g>
 <20240328103254.GA898963@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240328103254.GA898963@coredump.intra.peff.net>

On Thu, Mar 28, 2024 at 06:32:54AM -0400, Jeff King wrote:

> We package up the failed test output and trash directories for each run.
> You can find the one for this case here:
> 
>   https://github.com/git/git/actions/runs/8458842054/artifacts/1364695605
> 
> It is sometimes misleading because we don't run with "-i", so subsequent
> tests may stomp on things. But in this case the failing test is the last
> one. Unfortunately, I don't think it shows us much, because the state we
> tried to diff is removed by the test itself (both the funny dir and the
> index after we tried to add it).
> 
> So I don't know if we failed to even create "funny /" in the first
> place, if adding it to the index failed, or if the diff somehow failed.

I ran it again using https://github.com/mxschmitt/action-tmate to get an
interactive shell.

It looks like making the directory works fine:

  # mkdir "funny "
  # ls -ld f*
  drwxr-xr-x 1 runneradmin None 0 Mar 28 11:01 'funny '

Likewise making the file:

  # >"funny /empty"
  # ls -l f*/*
  -rw-r--r-- 1 runneradmin None 0 Mar 28 11:02 'funny /empty'

Adding it _seems_ to work, but nothing is put into the index:

  # git add funny\ /empty
  # git ls-files -s
  100644 e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 0       empty

At first I thought we had somehow created an entry with the wrong
filename, but that is just the existing "empty" entry from the earlier
tests. If you "rm .git/index" and try again, you get an empty index.

Running it under a debugger, it looks like treat_leading_path() realizes
it needs to look at "funny /", which it then feeds to is_directory().
That calls stat(), which returns -1. Digging there it looks like we feed
the expected name to GetFileAttributesExW(), but it returns an error
(123?) which we don't match in the switch statement, and we declare it
ENOENT.

So I suspect this isn't a bug in Git so much as we are running afoul of
OS limitations. And that is corroborated by these:

  https://superuser.com/questions/1733673/how-to-determine-if-a-file-with-a-trailing-space-exists

  https://stackoverflow.com/questions/48439697/trailing-whitespace-in-filename

There's some Win32 API magic you can do by prepending "\\?\", but I
couldn't get it to do anything useful.  Curiously, asking Git to
traverse itself yields another failure mode:

  # git add "funny "
  error: open("funny /empty"): No such file or directory
  error: unable to index file 'funny /empty'
  fatal: adding files failed

I'm way over my head here in terms of Windows quirks, so I'll stop
digging and assume it's not worth trying to make this work.

The patch you showed earlier functions as a workaround. But I think we
could also skip the filesystem entirely, since what we care about is
parsing the patch itself. Something like this:

diff --git a/t/t4126-apply-empty.sh b/t/t4126-apply-empty.sh
index eaf0c5304a..003b117362 100755
--- a/t/t4126-apply-empty.sh
+++ b/t/t4126-apply-empty.sh
@@ -67,25 +67,23 @@ test_expect_success 'apply --index create' '
 '
 
 test_expect_success 'apply with no-contents and a funny pathname' '
-	mkdir "funny " &&
-	>"funny /empty" &&
-	git add "funny /empty" &&
-	git diff HEAD "funny /" >sample.patch &&
-	git diff -R HEAD "funny /" >elpmas.patch &&
-	git reset --hard &&
-	rm -fr "funny " &&
+	blob=$(git rev-parse HEAD:empty) &&
+	git update-index --add --cacheinfo 100644,$blob,"funny /empty" &&
+	git diff --cached HEAD -- "funny /" >sample.patch &&
+	git diff --cached -R HEAD -- "funny /" >elpmas.patch &&
+	git reset &&
 
-	git apply --stat --check --apply sample.patch &&
-	test_must_be_empty "funny /empty" &&
+	git apply --cached --stat --check --apply sample.patch &&
+	git rev-parse --verify ":funny /empty" &&
 
-	git apply --stat --check --apply elpmas.patch &&
-	test_path_is_missing "funny /empty" &&
+	git apply --cached --stat --check --apply elpmas.patch &&
+	test_must_fail git rev-parse --verify ":funny /empty" &&
 
-	git apply -R --stat --check --apply elpmas.patch &&
-	test_must_be_empty "funny /empty" &&
+	git apply --cached -R --stat --check --apply elpmas.patch &&
+	git rev-parse --verify ":funny /empty" &&
 
-	git apply -R --stat --check --apply sample.patch &&
-	test_path_is_missing "funny /empty"
+	git apply --cached -R --stat --check --apply sample.patch &&
+	test_must_fail git rev-parse --verify ":funny /empty"
 '
 
 test_done

-Peff
