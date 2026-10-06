Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2816733ADAF
	for <git@vger.kernel.org>; Tue,  6 Oct 2026 03:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791258617; cv=none; b=BGsCDQCG8/GlAP5NGzfRvrnzzTSzWvvCycDh1h5jzx5TMY/Rnt1n5UsvvlF2XEk2tTjs8o1bGC7LBryF0EETg4D6KRGhz3+wf8fKZsqgLZf5iAUUoQ7tE/jCzUYG+P6XcksdG6+S1zsvaIJ9DXqo3AvN+ubwO/IjY+VsWNqtUlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791258617; c=relaxed/simple;
	bh=dzn+e/vhuHZXLJz3dX3MPj7CS0qc74PmTz8cgWuN814=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OV7lU2NU59PJ8tLCUfueYA5Fk8SVPny64l3wiPxAx1JQpQiqnqirXUPebinAeZT6qzD54VNAbzfgVpyBA5flDt7NzQ82eGEMAd/ZYdMLtHNWkIdqJ04xbkhu4EQJWWrKzp7gjKpmr1TtFSjxQXy5MGhRGwDTSB6859QKc47ZHBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=LEUNIjBj; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="LEUNIjBj"
Received: (qmail 29644 invoked by uid 106); 6 Oct 2026 03:43:32 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=dzn+e/vhuHZXLJz3dX3MPj7CS0qc74PmTz8cgWuN814=; b=LEUNIjBjlOFtwJEiwXe+OcYftqw6ZqvJdisjYeoCym4Sv7KhVWwc0lUW0xevM9vSJ3QQ/yAS1kDgHfFuLkiKF+cxkNqQ7pFsF8HOYHf4B+orH+qqEEHfc8xgf8a8GmbJDtNxmwoqza9QU6aKIYwRqhKu4N5VsIwZ6J9XyYOd3tmkrI0UyHFXwD7HBczpLr9SSdPp+LFWjxiMAnVB7p8Z2n9PYekm7pmEWUI5uGsG5ThTtNf9M1I7phN+mC5RWOj1CIN5jTZv4Ng0UrxIdEt0W34VoX3K2QIKRWIILje3pgr0fP9wC/wjLJaA2k76AF3yGIp972+CXSJcZGcAahXMCw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 06 Oct 2026 03:43:32 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 114402 invoked by uid 111); 6 Oct 2026 03:43:35 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 05 Oct 2026 23:43:35 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 5 Oct 2026 23:43:31 -0400
From: Jeff King <peff@peff.net>
To: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH] t5551: fix quoting in curl version bug prereq
Message-ID: <20261006034331.GA1325722@coredump.intra.peff.net>
References: <pull.2236.git.1790118373340.gitgitgadget@gmail.com>
 <pull.2236.v2.git.1790283229626.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.2236.v2.git.1790283229626.gitgitgadget@gmail.com>

On Thu, Sep 24, 2026 at 08:53:49PM +0000, Johannes Schindelin via GitGitGadget wrote:

> +# The cURL version which Debian 12 ships (v7.88.1) can fail to retry
> +# authentication after an early HTTP/2 response. This bug was introduced
> +# in cURL v7.88.0 (8c762f5998 (http2: minor buffer and error path fixes,
> +# 2023-02-08)) and fixed in v8.3.0 (https://github.com/curl/curl/pull/11756).
> +test_lazy_prereq HAVE_CURL_HTTP2_BUG "
> +	test_have_prereq HTTP2 &&
> +	build_option libcurl |
> +	awk -F. '
> +		($1 == 7 && $2 >= 88) || ($1 == 8 && $2 < 3) { broken = 1 }
> +		END { exit !broken }
> +	'
> +"

Doh, this is totally broken. The prereq snippet is in double-quotes, so
the $1, etc in the awk invocation are interpolated before we even eval
it. Fix is below.

-- >8 --
Subject: [PATCH] t5551: fix quoting in curl version bug prereq

We have a prereq snippet that invokes awk. The awk script's $1, etc,
variables need to be quoted to avoid shell interpolation. We correctly
use a single-quote inside the prereq snippet, but the snippet itself is
contained in double-quotes. So we interpolate "$1" into whatever value
that happens to have in the outer shell, and eval nonsense like:

  awk '(--some-garbage == 7 && --other-garbage >= 88) ...'

As a result, we don't think we have a buggy curl version even when we
do, and run the test anyway. But of course it's easy not to notice,
since this prereq was protecting us from a racy bug. It only breaks
sometimes.

There are a few options for fixing the quoting:

  1. Backslash-escaping the dollar signs. This is perhaps the least-ugly
     version, but it's a minor hassle to remember if somebody touches
     the code later.

  2. Single-quote the snippet, then quote interior single-quotes as
     '\''. Reasonably obvious, but ugly.

  3. Use the '<<\EOT' here-doc trick to specify the snippet. This would
     look nice, but we don't yet support it for prereqs. ;)

This patch uses (2), and we can circle back to (3) to make it look nicer
later.

Signed-off-by: Jeff King <peff@peff.net>
---
This should go on top of js/ci-debian-12-http2-workaround.

Since I know we both used GPT to work on this, I was curious if this
slipped past it. Doesn't look like it from what I sent (which used
option 2 above). I wonder if your agent flipped it, or if you saw how
ugly it was and flipped it yourself. Not blaming, but it's just a funny
and interesting data point if a human second-guessing the AI output
introduced a bug.

 t/t5551-http-fetch-smart.sh | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/t/t5551-http-fetch-smart.sh b/t/t5551-http-fetch-smart.sh
index f66d7ce7ac..cb681e644f 100755
--- a/t/t5551-http-fetch-smart.sh
+++ b/t/t5551-http-fetch-smart.sh
@@ -21,14 +21,14 @@ start_httpd
 # authentication after an early HTTP/2 response. This bug was introduced
 # in cURL v7.88.0 (8c762f5998 (http2: minor buffer and error path fixes,
 # 2023-02-08)) and fixed in v8.3.0 (https://github.com/curl/curl/pull/11756).
-test_lazy_prereq HAVE_CURL_HTTP2_BUG "
+test_lazy_prereq HAVE_CURL_HTTP2_BUG '
 	test_have_prereq HTTP2 &&
 	build_option libcurl |
-	awk -F. '
+	awk -F. '\''
 		($1 == 7 && $2 >= 88) || ($1 == 8 && $2 < 3) { broken = 1 }
 		END { exit !broken }
-	'
-"
+	'\''
+'
 
 test_expect_success HTTP2 'enable client-side http/2' '
 	git config --global http.version HTTP/2
-- 
2.56.0.399.g9e0ddc9b37

