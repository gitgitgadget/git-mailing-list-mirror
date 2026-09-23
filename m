Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90555560AB1
	for <git@vger.kernel.org>; Wed, 23 Sep 2026 16:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790182433; cv=none; b=J+2VnqmlBccRhNQlw/zd2mJqt0eDHj4wcBYje286BtVu6sz0dVsoSaVdPbCky6PVMvNmCocwCQ3AWZhJAY0UfzO4n2iN9qmWh3ZY0fQE44xxS1GKb6FWGBoLP9/5wClU826n40He9csb95AS+nXDBr0bSe1zvXGDe4A/LSIkR+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790182433; c=relaxed/simple;
	bh=x3gHxx0NS3FPjGl+54ganjlyJvEvcrTPErhEzbXnThU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JctXDjf9S2YTehA55V5UAlgJlvW/FsErZuSjjBRtpP34iqk5MvQIFlN1AZw5/YgPeLgdPVsLqxIxomEFqEAdxdDI5jYt/vbmCQmKv/T9qkt5ClIW0YYbD1xti+jaOXh6otLw1i+svcW/HEy0JwdhZB4IhfekZtTjjymqvTMKeZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=ZoiAAUyS; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="ZoiAAUyS"
Received: (qmail 35101 invoked by uid 106); 23 Sep 2026 16:53:49 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=x3gHxx0NS3FPjGl+54ganjlyJvEvcrTPErhEzbXnThU=; b=ZoiAAUyShz6E3xQY8l3Jnk3QqB9tEIs+1dCtVmZoQEIWyW6xTfxXQ492pMDEKAgMz9To+j188nYZxGVx8mn4Ixz7wzizXJwaou5x49xiEbFbv+IlGs+BXgk4wFZSKU1aqJtFP7ChinAt8w3ce4zsge4nKQnrTl2vJhdAYyExB9NdPkdMBwZ1VoGdso9h0Zafivyi+pW10yRTBJ/PV6n/k+UhQyQnMEzY9S+2Ub7J8RLI1T27CfyyBhAroNkN3JAOAr2CNGOs3FmLrVB4tzSY+BjRvZ3Y1ljwSero0nSGliReGNoMmylgr4+PdVPQ4xLLfFmPG6wpif6uZtp1De0wrQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 23 Sep 2026 16:53:49 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 181515 invoked by uid 111); 23 Sep 2026 16:53:48 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 23 Sep 2026 12:53:48 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 23 Sep 2026 12:53:48 -0400
From: Jeff King <peff@peff.net>
To: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] ci: work around Debian 12's HTTP/2 authentication
 failures
Message-ID: <20260923165348.GA29229@coredump.intra.peff.net>
References: <pull.2236.git.1790118373340.gitgitgadget@gmail.com>
 <20260923164700.GA28538@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260923164700.GA28538@coredump.intra.peff.net>

On Wed, Sep 23, 2026 at 12:47:01PM -0400, Jeff King wrote:

> So an ideal solution to me would be more like t5559 checking for the
> buggy version itself, setting a prereq, and then marking the tests with
> !HAVE_CURL_HTTP2_BUG.
> 
> That said, I'm not sure how tricky that would be to implement. We give
> the curl version with "git version --build-options", but we'd have to do
> some version number comparisons. It might not be worth spending a lot of
> time on this.

I guess our robot overlords^Whelpers could help with that. I passed your
patch and my email to Astra, which came up with this:

diff --git a/t/t5551-http-fetch-smart.sh b/t/t5551-http-fetch-smart.sh
index 805bec025c..8f620f0b44 100755
--- a/t/t5551-http-fetch-smart.sh
+++ b/t/t5551-http-fetch-smart.sh
@@ -17,6 +17,15 @@ fi
 test "$HTTP_PROTO" = "HTTP/2" && enable_http2
 start_httpd
 
+# Curl 7.88.1 can fail to retry authentication after an early HTTP/2
+# response. This was fixed in curl 8.3.0; see
+# https://github.com/curl/curl/pull/11756. Match the known-broken version,
+# since older versions (e.g., 7.74.0) work.
+test_lazy_prereq HAVE_CURL_HTTP2_BUG '
+	test_have_prereq HTTP2 &&
+	test "$(build_option libcurl)" = 7.88.1
+'
+
 test_expect_success HTTP2 'enable client-side http/2' '
 	git config --global http.version HTTP/2
 '
@@ -224,7 +233,7 @@ test_expect_success 'clone from auth-only-for-push repository' '
 	test_cmp expect actual
 '
 
-test_expect_success 'clone from auth-only-for-objects repository' '
+test_expect_success !HAVE_CURL_HTTP2_BUG 'clone from auth-only-for-objects repository' '
 	echo two >expect &&
 	set_askpass user@host pass@host &&
 	git clone --bare "$HTTPD_URL/auth-fetch/smart/repo.git" half-auth &&
@@ -233,7 +242,7 @@ test_expect_success 'clone from auth-only-for-objects repository' '
 	test_cmp expect actual
 '
 
-test_expect_success 'no-op half-auth fetch does not require a password' '
+test_expect_success !HAVE_CURL_HTTP2_BUG 'no-op half-auth fetch does not require a password' '
 	set_askpass wrong &&
 
 	# NEEDSWORK: When using HTTP(S), protocol v0 supports a "half-auth"


Not too bad. I had envisioned checking the range of versions, since you
found the fix (but we'd have to either use 7.88.1 as the start, or find
the actual bug introduction). But this covers at least as much as the
CI debian-12 specifier would.

-Peff
