Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAFA5156E4
	for <git@vger.kernel.org>; Wed, 17 Jul 2024 07:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721199653; cv=none; b=Xx4UPa9p3Uev6tjh+BzF65sgy+AoAyyzm1K+We6rTbn4zh4XJYSVm6/LbXR5L61d4LOrMxgDLgUV78+erJ3018Dt5MuUYHbNzStcSIa9uXrxwIhieo8PJpXXWa78RQ3qXmvI26/FlZb9BZYXVBRBSQL4cgNv2qqRnGtfvP9+BdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721199653; c=relaxed/simple;
	bh=hViVi7a3caZ+SaKIushiK2QT2fFpGmOkkwoNLF/CYZs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cxly5bl80W8s+3bQHcDYPVVmD5xsVyirDdBHD/Oa9i4gJPZlfcinjDvWspNQmLN4b9bId7xHz1wZyG6RyhfCRE+ojpxWz7Q77yRxyaxflipYkoWRuh0cuYaFl3ijR+y2kWwUIM1EyVR4HQ2zdiPAx4D472NTO0PkwnKAEtwygAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 24402 invoked by uid 109); 17 Jul 2024 07:00:50 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 17 Jul 2024 07:00:50 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19164 invoked by uid 111); 17 Jul 2024 07:00:48 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 17 Jul 2024 03:00:48 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 17 Jul 2024 03:00:50 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: rsbecker@nexbridge.com, git@vger.kernel.org
Subject: [PATCH] t4153: stop redirecting input from /dev/zero
Message-ID: <20240717070050.GG547635@coredump.intra.peff.net>
References: <024201dad543$877221e0$965665a0$@nexbridge.com>
 <xmqqv818aezm.fsf@gitster.g>
 <20240714070558.GA575927@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240714070558.GA575927@coredump.intra.peff.net>

On Sun, Jul 14, 2024 at 03:05:58AM -0400, Jeff King wrote:

> With --retry I think we would not actually read stdin at all, so we
> could just remove the mention of /dev/zero entirely. But if we wanted to
> be sure it did not read and choke on any input provided, I think just:
> 
> diff --git a/t/t4153-am-resume-override-opts.sh b/t/t4153-am-resume-override-opts.sh
> index a4d0c03ca6..76783bdd67 100755
> --- a/t/t4153-am-resume-override-opts.sh
> +++ b/t/t4153-am-resume-override-opts.sh
> @@ -45,6 +45,7 @@ test_expect_success '--3way overrides --no-3way' '
>  
>  	# Applying side1 with am --3way will succeed due to the threeway-merge.
>  	# Applying side2 will fail as --3way does not apply to it.
> +	echo garbage |
>  	test_must_fail git am --retry --3way &&
>  	test_path_is_dir .git/rebase-apply &&
>  	test side1 = "$(cat file2)"
> @@ -99,7 +100,8 @@ test_expect_success '--reject overrides --no-reject' '
>  	test_path_is_dir .git/rebase-apply &&
>  	test_path_is_missing file.rej &&
>  
> -	test_must_fail git am --retry --reject </dev/zero &&
> +	echo garbage |
> +	test_must_fail git am --retry --reject &&
>  	test_path_is_dir .git/rebase-apply &&
>  	test_path_is_file file.rej
>  '

Looking at the history, the use of /dev/zero was not here to simulate
garbage on stdin. It really was just meant to be a descriptor which
never ran out of input, as a workaround for test_terminal. This is
described in the commit mentioned below.

So I think we should just do this, which can go on top of jk/am-retry. I
still do not think it is super-urgent, but given the simplicity of the
fix is probably worth doing for the upcoming v2.46, which exposes these
tests to more platforms.

-- >8 --
Subject: [PATCH] t4153: stop redirecting input from /dev/zero

Commit 852a171018 (am: let command-line options override saved options,
2015-08-04) redirected a few "git am" invocations from /dev/zero, even
though it did not expect "am" to read the input. This was necessary at
the time because those tests used test_terminal, and as described in
18d8c26930 (test_terminal: redirect child process' stdin to a pty,
2015-08-04):

  Note that due to the way the code is structured, the child's stdin
  pseudo-tty will be closed when we finish reading from our stdin. This
  means that in the common case, where our stdin is attached to /dev/null,
  the child's stdin pseudo-tty will be closed immediately. Some operations
  like isatty(), which git-am uses, require the file descriptor to be
  open, and hence if the success of the command depends on such functions,
  test_terminal's stdin should be redirected to a source with large amount
  of data to ensure that the child's stdin is not closed, e.g.

              test_terminal git am --3way </dev/zero

But we later dropped the use of test_terminal in 53ce2e3f0a (am: add
explicit "--retry" option, 2024-06-06). That commit dropped one of the
redirections from /dev/zero but not the other.

In theory the remaining one should not cause any problems, but it turns
out that at least one platform (NonStop) does not have /dev/zero at all.
We never noticed before because it also did not pass the TTY prereq,
meaning these tests were not run at all there until 53ce2e3f0a.

So let's drop the useless /dev/zero mention. There are others in the
test suite, but they are run only for tests marked with EXPENSIVE (so
not typically by default).

Reported-by: Randall S. Becker <rsbecker@nexbridge.com>
Signed-off-by: Jeff King <peff@peff.net>
---
 t/t4153-am-resume-override-opts.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t4153-am-resume-override-opts.sh b/t/t4153-am-resume-override-opts.sh
index a4d0c03ca6..dd6ad8f7a8 100755
--- a/t/t4153-am-resume-override-opts.sh
+++ b/t/t4153-am-resume-override-opts.sh
@@ -99,7 +99,7 @@ test_expect_success '--reject overrides --no-reject' '
 	test_path_is_dir .git/rebase-apply &&
 	test_path_is_missing file.rej &&
 
-	test_must_fail git am --retry --reject </dev/zero &&
+	test_must_fail git am --retry --reject &&
 	test_path_is_dir .git/rebase-apply &&
 	test_path_is_file file.rej
 '
-- 
2.46.0.rc0.511.gabae7d6275

