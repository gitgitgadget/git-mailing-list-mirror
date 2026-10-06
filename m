Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E50222AE76
	for <git@vger.kernel.org>; Tue,  6 Oct 2026 03:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791258762; cv=none; b=iAv2jEmOhZNkCV9Gtf1xa+ebG1ffa/7M2Uk6Q+TAWFayJEBYJR27Xp/78OBG3nGMbn73YFhFd15LGI1FPoye5tVwxURDSbmc+BwwkfHXRED/Rix+HPLRmVxtZDOq9MAgUuWTMtdiafEV0j5O1CRkCtJatKinVpA/IiGyiH0l5bU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791258762; c=relaxed/simple;
	bh=eIV359VEDIeyhdDu0m/mqg83tHxO8N787ZGByzeB7ow=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IXTxXYOfjx/C6pat9i1vUe12bheDHdLPsItCh69ZAWlJ4IjzJKgQMQw66bIvuJg9Fkue83kVnSi/cYHTDFyb8zxEA6rSj5EBbyCZm/pwSGz+iItys3YS4CmP2ZP/+1nm6lyFy+X986gFx8Z5k4AQ3hb9N8OCoAN/nan3GGZ0PbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=HRIcZ8ix; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="HRIcZ8ix"
Received: (qmail 29669 invoked by uid 106); 6 Oct 2026 03:52:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=eIV359VEDIeyhdDu0m/mqg83tHxO8N787ZGByzeB7ow=; b=HRIcZ8ixD/rTlZpaVBAlQ8R2l/td6EvDK5sD7q3oM4vRrKEXYl5Yeac7jW18anYomq4OGf5XCWQkeooaPStzo3N4JqHAo2ALhlCuzWCc8+mLN/Us/bnSJys6IVVZrL12gjcez2bV/6svoDy6gmdq9h1W3rCnCf/H7Tfu75SHEsDt/AADhtKYK2WMy1hJauGRNEXVLkErTnsGriJ4UXu0fIzRX1fVoUtdeRAYy6HRMURAfszhPBVrXm386Ves3oNOoxSFxLP4Gs7LWjpIdkAJO7RU8u2EPMJOrHm+JdCnZOA+2lu+2stFmMKv4X0X51Str+iZ3dpuW75Q/ZKO975Rtw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 06 Oct 2026 03:52:39 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 114941 invoked by uid 111); 6 Oct 2026 03:52:43 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 05 Oct 2026 23:52:43 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 5 Oct 2026 23:52:39 -0400
From: Jeff King <peff@peff.net>
To: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH 2/1] test-lib: allow lazy prerequisite snippets as here-docs
Message-ID: <20261006035239.GA1335881@coredump.intra.peff.net>
References: <pull.2236.git.1790118373340.gitgitgadget@gmail.com>
 <pull.2236.v2.git.1790283229626.gitgitgadget@gmail.com>
 <20261006034331.GA1325722@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261006034331.GA1325722@coredump.intra.peff.net>

On Mon, Oct 05, 2026 at 11:43:32PM -0400, Jeff King wrote:

>   2. Single-quote the snippet, then quote interior single-quotes as
>      '\''. Reasonably obvious, but ugly.
> 
>   3. Use the '<<\EOT' here-doc trick to specify the snippet. This would
>      look nice, but we don't yet support it for prereqs. ;)
> 
> This patch uses (2), and we can circle back to (3) to make it look nicer
> later.

Doing (3) turned out easier than I thought it would. Patch is below. I
think it still makes sense to do the immediate fix with (2), and then
this on top as cleanup (or as a separate topic, though obviously there
is a textual dependency).

-- >8 --
Subject: test-lib: allow lazy prerequisite snippets as here-docs

Commit 1d133ae91f (test-lib: allow test snippets as here-docs, 2024-07-10)
let test_expect_success and test_expect_failure read their snippets from
stdin, making it easier to use single quotes within them. I mentioned
there that we could extend this to lazy prerequisites, but left it for
later.

Let's finish that off now. Since test_body_or_stdin() takes the name of
the variable to fill, we can use it directly to populate the saved prereq
snippet. We read the body when the prereq is declared, but still evaluate
it only when the prereq is used.

Converting the curl version check in t5551 shows how this can reduce
awkward quoting.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t5551-http-fetch-smart.sh | 8 ++++----
 t/test-lib-functions.sh     | 2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/t/t5551-http-fetch-smart.sh b/t/t5551-http-fetch-smart.sh
index cb681e644f..9dd20d1c65 100755
--- a/t/t5551-http-fetch-smart.sh
+++ b/t/t5551-http-fetch-smart.sh
@@ -21,14 +21,14 @@ start_httpd
 # authentication after an early HTTP/2 response. This bug was introduced
 # in cURL v7.88.0 (8c762f5998 (http2: minor buffer and error path fixes,
 # 2023-02-08)) and fixed in v8.3.0 (https://github.com/curl/curl/pull/11756).
-test_lazy_prereq HAVE_CURL_HTTP2_BUG '
+test_lazy_prereq HAVE_CURL_HTTP2_BUG - <<\EOT
 	test_have_prereq HTTP2 &&
 	build_option libcurl |
-	awk -F. '\''
+	awk -F. '
 		($1 == 7 && $2 >= 88) || ($1 == 8 && $2 < 3) { broken = 1 }
 		END { exit !broken }
-	'\''
-'
+	'
+EOT
 
 test_expect_success HTTP2 'enable client-side http/2' '
 	git config --global http.version HTTP/2
diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 809c662124..de75ae842c 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -760,7 +760,7 @@ lazily_testable_prereq= lazily_tested_prereq=
 # Usage: test_lazy_prereq PREREQ 'script'
 test_lazy_prereq () {
 	lazily_testable_prereq="$lazily_testable_prereq$1 "
-	eval test_prereq_lazily_$1=\$2
+	test_body_or_stdin "test_prereq_lazily_$1" "$2"
 }
 
 test_run_lazy_prereq_ () {
-- 
2.56.0.399.g9e0ddc9b37

