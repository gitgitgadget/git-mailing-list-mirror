Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42CB72737F8
	for <git@vger.kernel.org>; Thu, 18 Dec 2025 12:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766060528; cv=none; b=lx7bSowbP67/DQhpQ/Az/v5F1oZKgQezPTzd2FhIcBo/oxKJ5JvGWuy6rD3X+Llmh7r5rSu15u8sSCwNOe6RC2NJ+/B6isWl3OXzs94WBroL8OrGn6M3RiH9A10J4iA6iMSBprjTnIzz9eKoCzpcnVI5OtOPi/2z8qzLVPAQNdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766060528; c=relaxed/simple;
	bh=tseBKl2qCSEZaSRT3aIBiuO8W/5MB2Hi5TfZypNW9cY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c5W6V/O9q0BNn05ZfhUbr4uheVsue+bI2mTq8CjAaQj+aYi6nVHQkWglJ4p/BhIpj0i2Mjjmu8l0K1W851Jwo8N0AW4AYShMGmOsFMSaQtKgv+LumuOQAUAF27P8zDxyfgp3xHA7DsaWsVN1n8SUApax+wpkKni2wmIYXF1EpF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=fXo92COI; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="fXo92COI"
Received: (qmail 390856 invoked by uid 109); 18 Dec 2025 12:22:05 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=tseBKl2qCSEZaSRT3aIBiuO8W/5MB2Hi5TfZypNW9cY=; b=fXo92COIL5Esk/xuoD/8SwPk82EylakcbClFPNjFJrxpTK/mpk0BUtXs8+ti934GZqoGKtWbiju3p7ODjGE37EQUzzikInMcZ2tZeOzD1Y9vMbdTh/wx9O+FbeBUzEaiQtLT1Z1d3JryYk0hJ5svj/FuNWpTVUeLzXZuw7ZC/kEE7EsTSu3790AIRcl7VMSb07pgMWO5N0FqbO1zs6zOG0ddMEsFHmrVqkU0dJC1+vh2b4x2qEyuR+tfsUm038GhV56h5utMTFlD87JIBGlFWkPUndr35Mx3c7gDq0oYbWrSsf/6A23bfgugmu9eh/JflsiorwOXU7nxuNCA521vvg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 18 Dec 2025 12:22:05 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 520715 invoked by uid 111); 18 Dec 2025 12:22:04 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 18 Dec 2025 07:22:04 -0500
Authentication-Results: peff.net; auth=none
Date: Thu, 18 Dec 2025 07:22:04 -0500
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Matthew John Cheetham <mjcheetham@outlook.com>,
	Daniel Stenberg <daniel@haxx.se>
Subject: [PATCH 3/3] t5563: relax whitespace assumptions for unfolded headers
Message-ID: <20251218122204.GC3758205@coredump.intra.peff.net>
References: <20251218121120.GA3252258@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251218121120.GA3252258@coredump.intra.peff.net>

In t5563 we check the handling of WWW-Authenticate headers that have
been folded (i.e., where a continuation line starts with extra
whitespace). Traditionally curl handed each line to us individually, but
in the upcoming v8.18.0, it hands us full lines that have been unfolded.
But it doesn't produce exactly the same unfolding that we did!

In particular, two of the tests send an extra blank continuation line.
Something like this:

  printf 'WWW-Authenticate: foo param1="value1"\r\n'
  printf ' \r\n'
  printf ' param2="value2"\r\n"

We unfold that into:

  WWW-Authenticate: foo param1="value1" param2="value2"

But curl will give us a string with an extra space:

  WWW-Authenticate: foo param1="value1"  param2="value2"

I think curl is actually correct here. RFC 7230 says:

   A user agent that receives an obs-fold in a response message that is
   not within a message/http container MUST replace each received
   obs-fold with one or more SP octets prior to interpreting the field
   value.

So each folded instance turns the initial whitespace into "one or more"
spaces, and the "blank" line becomes a single space. Whereas Git's
unfolding code explicitly avoids this, with the comment "Do not bother
appending the new value if this continuation header is itself empty." in
fwrite_wwwauth().

I think it's mostly academic at this point. These folded continuations
have been deprecated entirely since RFC 7230 came out in 2014, and
there's very little reason for a server to add a blank continuation line
at all. And anybody parsing the unfolded header contents should skip
past the extra whitespace (which is allowed to be present according to
the RFC).

But our tests do a byte-wise comparison, so they care about the
difference between the two outputs. We have two options here:

  1. We can modify Git's unfolding code to behave like modern curl.

  2. We can relax the tests to be happy with either output.

I picked (2) here, just because it seemed less risky to touch only the
tests and not the code (though if any real-world systems _do_ care about
the distinction, they will eventually run into problems when libcurl is
upgraded).

There is one further curiosity here. There's a second test which mixes
tabs and spaces for continuation, like this:

  printf 'WWW-Authenticate: foo param1="value1"\r\n'
  printf '\t\r\n'
  printf ' param2="value2"\r\n"

From the snippet of RFC quoted above, I believe this should produce the
exact same output (the continuation whitespace is replaced with one or
more spaces, even though it is a tab here). But curl retains the tab
instead!

So to implement the "relaxed whitespace" mode in the test, we just
convert any run of multiple whitespace characters to a single space.
This is a bit hacky and over-zealous, but it's easy to do and good
enough for our purposes here. We only enable the relaxed mode for the
two tests which trigger this issue.

Signed-off-by: Jeff King <peff@peff.net>
---
Note that when built against this new version of curl, Git's unfolding
code should never trigger at all. In the long run we should be able to
rip it out, but we probably need to wait a decade or so before we can
bump the minimum libcurl version to 8.18.0.

I guess we could make it a conditional in the code (which would help us
remember to eventually rip it out), but it felt weird to start adding
version conditionals for a version that isn't even released yet. ;)

 t/t5563-simple-http-auth.sh | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/t/t5563-simple-http-auth.sh b/t/t5563-simple-http-auth.sh
index c1febbae9d..0967cd501c 100755
--- a/t/t5563-simple-http-auth.sh
+++ b/t/t5563-simple-http-auth.sh
@@ -47,6 +47,13 @@ set_credential_reply () {
 expect_credential_query () {
 	local suffix="$(test -n "$2" && echo "-$2")"
 	cat >"$TRASH_DIRECTORY/$1-expect$suffix.cred" &&
+	if $(test "$3" = "--relax-whitespace")
+	then
+		HT='	' &&
+		sed "s/[ $HT][ $HT]*/ /g" \
+			<"$TRASH_DIRECTORY/$1-query$suffix.cred" >tmp &&
+		mv tmp "$TRASH_DIRECTORY/$1-query$suffix.cred"
+	fi &&
 	test_cmp "$TRASH_DIRECTORY/$1-expect$suffix.cred" \
 		 "$TRASH_DIRECTORY/$1-query$suffix.cred"
 }
@@ -451,7 +458,7 @@ test_expect_success 'access using basic auth with wwwauth header empty continuat
 	test_config_global credential.helper test-helper &&
 	git ls-remote "$HTTPD_URL/custom_auth/repo.git" &&
 
-	expect_credential_query get <<-EOF &&
+	expect_credential_query get "" --relax-whitespace <<-EOF &&
 	capability[]=authtype
 	capability[]=state
 	protocol=http
@@ -495,7 +502,7 @@ test_expect_success 'access using basic auth with wwwauth header mixed continuat
 	test_config_global credential.helper test-helper &&
 	git ls-remote "$HTTPD_URL/custom_auth/repo.git" &&
 
-	expect_credential_query get <<-EOF &&
+	expect_credential_query get "" --relax-whitespace <<-EOF &&
 	capability[]=authtype
 	capability[]=state
 	protocol=http
-- 
2.52.0.595.gac9d83db54
