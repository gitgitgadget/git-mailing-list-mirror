Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F6D816EBFD
	for <git@vger.kernel.org>; Fri,  5 Apr 2024 20:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712347495; cv=none; b=q7NhwJOyVWRxR2yAfoX9JI1ao5JTvEP/PiWsQVD28xgYPk9sx/mogAldKufSparmeWP1Lge8lLgDwpu9Kzq1NWAD/6KalLHqvhvqhso/5uXiPNrHp0tCOtyKFL1164frlKaEBQAl8fKPsmQHqI+yk+KFWk8s+y5s0fL/4ag5YW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712347495; c=relaxed/simple;
	bh=JLCLOfhtrGQU+J/EkcE77BasHE6lvjNDZCNjMhSmLwA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l1D+NK8Q5uVufZS+4/DRuCdOZ3Xdx28A0qIa+QX3jDu9an8D56q44JvvEkHReDp5SFGBPmyucgqpjYcHsS2aCuErrXPZtGp/W02rvBvtfUUfD354r8dTM2U9H4tbwbkyQulck0vFa7Y9EV1Pnnn88+mM6Nzlvh6dnwVgzIjwGiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 20164 invoked by uid 109); 5 Apr 2024 20:04:52 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 05 Apr 2024 20:04:52 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 32191 invoked by uid 111); 5 Apr 2024 20:04:54 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 05 Apr 2024 16:04:54 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 5 Apr 2024 16:04:51 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Daniel Stenberg <daniel@haxx.se>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 3/2] remote-curl: add Transfer-Encoding header only for older
 curl
Message-ID: <20240405200451.GA3700566@coredump.intra.peff.net>
References: <20240330000212.GA1261238@coredump.intra.peff.net>
 <2n7sn76-p413-5632-4o2s-o5n2p1rqnr5@unkk.fr>
 <20240402200254.GA874754@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240402200254.GA874754@coredump.intra.peff.net>

On Tue, Apr 02, 2024 at 04:02:54PM -0400, Jeff King wrote:

> Ultimately the issue will be fixed by moving to a different version of
> libcurl, but here's an easy workaround in the meantime, with a small doc
> cleanup I found along the way.
> 
>   [1/2]: http: reset POSTFIELDSIZE when clearing curl handle
>   [2/2]: INSTALL: bump libcurl version to 7.21.3

Here's a final patch on top that gives us a workaround for the HTTP/2
half of this. It's a cleaned-up version of what I showed earlier.

-- >8 --
Subject: remote-curl: add Transfer-Encoding header only for older curl

As of curl 7.66.0, we don't need to manually specify a "chunked"
Transfer-Encoding header. Instead, modern curl deduces the need for it
in a POST that has a POSTFIELDSIZE of -1 and uses READFUNCTION rather
than POSTFIELDS.

That version is recent enough that we can't just drop the header; we
need to do so conditionally. Since it's only a single line, it seems
like the simplest thing would just be to keep setting it unconditionally
(after all, the #ifdefs are much longer than the actual code). But
there's another wrinkle: HTTP/2.

Curl may choose to use HTTP/2 under the hood if the server supports it.
And in that protocol, we do not use the chunked encoding for streaming
at all. Most versions of curl handle this just fine by recognizing and
removing the header. But there's a regression in curl 8.7.0 and 8.7.1
where it doesn't, and large requests over HTTP/2 are broken (which t5559
notices). That regression has since been fixed upstream, but not yet
released.

Make the setting of this header conditional, which will let Git work
even with those buggy curl versions. And as a bonus, it serves as a
reminder that we can eventually clean up the code as we bump the
supported curl versions.

Signed-off-by: Jeff King <peff@peff.net>
---
Manually tested against curl 8.7.0 (where skipping the header fixes
t5559), as well as 7.65.0 (which continues to pass t5551, but would fail
if we didn't set the header).

 git-curl-compat.h | 9 +++++++++
 remote-curl.c     | 3 +++
 2 files changed, 12 insertions(+)

diff --git a/git-curl-compat.h b/git-curl-compat.h
index fd96b3cdff..e1d0bdd273 100644
--- a/git-curl-compat.h
+++ b/git-curl-compat.h
@@ -126,6 +126,15 @@
 #define GIT_CURL_HAVE_CURLSSLSET_NO_BACKENDS
 #endif
 
+/**
+ * Versions before curl 7.66.0 (September 2019) required manually setting the
+ * transfer-encoding for a streaming POST; after that this is handled
+ * automatically.
+ */
+#if LIBCURL_VERSION_NUM < 0x074200
+#define GIT_CURL_NEED_TRANSFER_ENCODING_HEADER
+#endif
+
 /**
  * CURLOPT_PROTOCOLS_STR and CURLOPT_REDIR_PROTOCOLS_STR were added in 7.85.0,
  * released in August 2022.
diff --git a/remote-curl.c b/remote-curl.c
index 31b02b8840..0b6d7815fd 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -1,4 +1,5 @@
 #include "git-compat-util.h"
+#include "git-curl-compat.h"
 #include "config.h"
 #include "environment.h"
 #include "gettext.h"
@@ -955,7 +956,9 @@ static int post_rpc(struct rpc_state *rpc, int stateless_connect, int flush_rece
 		/* The request body is large and the size cannot be predicted.
 		 * We must use chunked encoding to send it.
 		 */
+#ifdef GIT_CURL_NEED_TRANSFER_ENCODING_HEADER
 		headers = curl_slist_append(headers, "Transfer-Encoding: chunked");
+#endif
 		rpc->initial_buffer = 1;
 		curl_easy_setopt(slot->curl, CURLOPT_READFUNCTION, rpc_out);
 		curl_easy_setopt(slot->curl, CURLOPT_INFILE, rpc);
-- 
2.44.0.872.gbe303efee2

