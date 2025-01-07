Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B616E4879B
	for <git@vger.kernel.org>; Tue,  7 Jan 2025 07:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736233677; cv=none; b=DpsEPjKApM89PeJUDUT1OafQ/q6G6ZVQh+ZzzAjvbCRrs1jiGHKhGIsGW7SRgLE7zEwiQM9g72E1lsx5359tN1IyJS/WVPMT6YaekzaQbZ4MbMZqWeBcneKr+PohYF5RvYpiLCNzI3yA/3o3OtSDmbbKbLOIZhQkLx1cnTMxDi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736233677; c=relaxed/simple;
	bh=GeseXBZPH5YTc0YcW5rn3dCN7Ys+1zwNCuLg9h6fsKs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=exVpg+KfL9C1z0x/U4h1PJEuvvqCU7y7IscyMDcabpLkfi+IkmXOX34KvqtBbCYbYa1fGwKBCB1BZmpOY7n0VIIPYiVF/fOkFe2hZn+6t48mPCcJR7EdDIxWf3Dpeii1PS3ApFe0S3sB1LSnacnT1MvpJNUvjOiqUk1CBA6j1K0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=CkxMVGAv; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="CkxMVGAv"
Received: (qmail 29030 invoked by uid 109); 7 Jan 2025 07:07:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=GeseXBZPH5YTc0YcW5rn3dCN7Ys+1zwNCuLg9h6fsKs=; b=CkxMVGAv+f+y96Ctcm/y/iJubbfIfOA3EKOPBqhTvoXy37BIryyHjygFu5rV9bu6EZzY0LnqczHy7jQIuGAOeTfr+xvH6PtlPzxQtzJ1xJvgS29ppqwJn6BqEkiql+6KjiDLbKoH72bnd0NtSJAeubOWS+c9zODVpF7dB2XH1f2Y+R/mUMCFuDzxDjzGEU52PkV9Vhvz+pEj9ftcLmm/LVBCFY/InXKPZwa2VCg6azvndyjyXGJpufcnaLAdV7ylc0oXzrBGjmzO7YuOB85hlbA34zKbk4x6e1YhwH2qD7Y1WnJif6zeQgwniYl/Z9EEybA6N6jeRXVJNzkqmJ4xjA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 07 Jan 2025 07:07:53 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21874 invoked by uid 111); 7 Jan 2025 07:07:53 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 07 Jan 2025 02:07:53 -0500
Authentication-Results: peff.net; auth=none
Date: Tue, 7 Jan 2025 02:07:52 -0500
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: [PATCH 2/3] test-lib: simplify lsan results check
Message-ID: <20250107070752.GB584668@coredump.intra.peff.net>
References: <20250107070409.GA584456@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250107070409.GA584456@coredump.intra.peff.net>

We want to know if there are any leaks logged by LSan in the results
directory, so we run "find" on the containing directory and pipe it to
xargs. We can accomplish the same thing by just globbing in the shell
and passing the result to grep, which has a few advantages:

  - it's one fewer process to run

  - we can glob on the TEST_RESULTS_SAN_FILE pattern, which is what we
    checked at the beginning of the function, and is the same glob use
    to show the logs in check_test_results_san_file_

  - this correctly handles the case where TEST_OUTPUT_DIRECTORY has a
    space in it. For example doing:

       mkdir "/tmp/foo bar"
       TEST_OUTPUT_DIRECTORY="/tmp/foo bar" make SANITIZE=leak test

    would yield a lot of:

      grep: /tmp/foo: No such file or directory
      grep: bar/test-results/t0006-date.leak/trace.test-tool.582311: No such file or directory

    when there are leaks. We could do the same thing with "xargs
    --null", but that isn't portable.

We are now subject to command-line length limits, but that is also true
of the globbing cat used to show the logs themselves. This hasn't been a
problem in practice.

We do need to use "grep -s" for the case that the glob does not expand
(i.e., there are not any log files at all). This option is in POSIX, and
has been used in t7407 for several years without anybody complaining.
This also also naturally handles the case where the surrounding
directory has already been removed (in which case there are likewise no
files!), dropping the need to comment about it.

Signed-off-by: Jeff King <peff@peff.net>
---
I was surprised by the use of "grep -s" in t7407, since it is totally
pointless there. But I think we can take its presence as a positive sign
for portability.

 t/test-lib.sh | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index be3553e40e..898c2267b8 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -1172,12 +1172,7 @@ test_atexit_handler () {
 check_test_results_san_file_has_entries_ () {
 	test -z "$TEST_RESULTS_SAN_FILE" && return 1
 
-	# stderr piped to /dev/null because the directory may have
-	# been "rmdir"'d already.
-	find "$TEST_RESULTS_SAN_DIR" \
-		-type f \
-		-name "$TEST_RESULTS_SAN_FILE_PFX.*" 2>/dev/null |
-	xargs grep ^DEDUP_TOKEN |
+	grep -s ^DEDUP_TOKEN "$TEST_RESULTS_SAN_FILE".* |
 	grep -qv sanitizer::GetThreadStackTopAndBottom
 }
 
-- 
2.48.0.rc2.377.g0507c08f68

