Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1694C46467
	for <git@archiver.kernel.org>; Sat, 14 Jan 2023 14:49:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229875AbjANOrw (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 14 Jan 2023 09:47:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229955AbjANOrr (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 14 Jan 2023 09:47:47 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A94B983EA
        for <git@vger.kernel.org>; Sat, 14 Jan 2023 06:47:39 -0800 (PST)
Received: (qmail 29642 invoked by uid 109); 14 Jan 2023 14:47:39 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 14 Jan 2023 14:47:39 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10397 invoked by uid 111); 14 Jan 2023 14:47:39 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 14 Jan 2023 09:47:39 -0500
Authentication-Results: peff.net; auth=none
Date:   Sat, 14 Jan 2023 09:47:38 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Ramsay Jones <ramsay@ramsayjones.plus.com>, git@vger.kernel.org
Subject: Re: [PATCH] ci: do not die on deprecated-declarations warning
Message-ID: <Y8LAim4D3g6qnZdq@coredump.intra.peff.net>
References: <xmqqv8l9n5fj.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqv8l9n5fj.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 13, 2023 at 07:47:12PM -0800, Junio C Hamano wrote:

> Like a recent GitHub CI run on linux-musl [1] shows, we seem to be
> getting a bunch of errors of the form:
> 
>   Error: http.c:1002:9: 'CURLOPT_REDIR_PROTOCOLS' is deprecated:
>   since 7.85.0. Use CURLOPT_REDIR_PROTOCOLS_STR
>   [-Werror=deprecated-declarations]
> 
> For some of them, it may be reasonable to follow the deprecation
> notice and update the code, but some symbols like the above is not.

Heh, I was just poking at this myself.

> According to the release table [2], 7.85.0 that deprecates
> CURLOPT_REDIR_PROTOCOLS was released on 2022-08-31, less than a year
> ago, and according to the symbols-in-versions table [3],
> CURLOPT_REDIR_PROTOCOLS_STR was introduced in 7.85.0, so it will
> make us incompatible with anything older than a year if we rewrote
> the call as the message suggests.

Yeah, we'd definitely have to keep code covering both versions for a
while. Which is a good reason to punt until the deprecated option is
actually removed, since enough time may have passed by then that we can
avoid having to maintain both versions.

The other thing that makes me care less about this deprecation is that
the deprecation warning in the manpage says:

  We strongly recommend using CURLOPT_REDIR_PROTOCOLS_STR(3) instead
  because this option cannot control all available protocols!

But we don't care about that. We are setting a very small and vanilla
subset of the possible protocols, and the non-STR version is fine for
that.

> +# Libraries deprecate symbols while retaining them for a long time to
> +# keep software working with both older and newer versions of them.
> +# Getting warnings does help the developers' awareness, but we cannot
> +# afford to update too aggressively.  E.g. CURLOPT_REDIR_PROTOCOLS_STR
> +# is only available in 7.85.0 that deprecates CURLOPT_REDIR_PROTOCOLS
> +# but we cannot rewrite the uses of the latter with the former until
> +# 7.85.0, which was released in August 2022, becomes ubiquitous.
> +DEVELOPER_CFLAGS += -Wno-error=deprecated-declarations

That's a pretty broad hammer. And I think it may stomp on the hack to
rely on deprecated() in the UNUSED macro.

As Ramsay suggested, we could probably use CURL_DISABLE_DEPRECATION to
limit this just to the problematic case. An even more focused option is
to use curl's helper here:

diff --git a/http.c b/http.c
index 17d954dd95..21891493d9 100644
--- a/http.c
+++ b/http.c
@@ -1,3 +1,4 @@
+#define CURL_DISABLE_TYPECHECK 1
 #include "git-compat-util.h"
 #include "git-curl-compat.h"
 #include "http.h"
@@ -979,10 +980,12 @@ static CURL *get_curl_handle(void)
 
 	curl_easy_setopt(result, CURLOPT_MAXREDIRS, 20);
 	curl_easy_setopt(result, CURLOPT_POSTREDIR, CURL_REDIR_POST_ALL);
-	curl_easy_setopt(result, CURLOPT_REDIR_PROTOCOLS,
-			 get_curl_allowed_protocols(0));
-	curl_easy_setopt(result, CURLOPT_PROTOCOLS,
-			 get_curl_allowed_protocols(-1));
+	CURL_IGNORE_DEPRECATION(
+		curl_easy_setopt(result, CURLOPT_REDIR_PROTOCOLS,
+				 get_curl_allowed_protocols(0));
+		curl_easy_setopt(result, CURLOPT_PROTOCOLS,
+				 get_curl_allowed_protocols(-1));
+	)
 	if (getenv("GIT_CURL_VERBOSE"))
 		http_trace_curl_no_data();
 	setup_curl_trace(result);

though I think that was introduced only in 7.87.0 along with the
deprecation warnings themselves, so we'd need to have a fallback like:

  #ifndef CURL_IGNORE_DEPRECATION(x)
  #define CURL_IGNORE_DEPRECATION(x) x
  #endif

-Peff
