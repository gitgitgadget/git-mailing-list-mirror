Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33959C61DA4
	for <git@archiver.kernel.org>; Thu, 23 Feb 2023 09:46:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234117AbjBWJqm (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Feb 2023 04:46:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234126AbjBWJqh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Feb 2023 04:46:37 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AE9A4DE1E
        for <git@vger.kernel.org>; Thu, 23 Feb 2023 01:46:34 -0800 (PST)
Received: (qmail 22849 invoked by uid 109); 23 Feb 2023 09:46:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 23 Feb 2023 09:46:33 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17694 invoked by uid 111); 23 Feb 2023 09:46:33 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 23 Feb 2023 04:46:33 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 23 Feb 2023 04:46:32 -0500
From:   Jeff King <peff@peff.net>
To:     Matthew John Cheetham via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
        Lessley Dennington <lessleydennington@gmail.com>,
        Matthew John Cheetham <mjcheetham@outlook.com>,
        M Hickford <mirth.hickford@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Glen Choo <chooglen@google.com>,
        Victoria Dye <vdye@github.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v10 2/3] http: read HTTP WWW-Authenticate response headers
Message-ID: <Y/c1+Llb/D27eWdg@coredump.intra.peff.net>
References: <pull.1352.v9.git.1676496846.gitgitgadget@gmail.com>
 <pull.1352.v10.git.1676586881.gitgitgadget@gmail.com>
 <703ac15222fdcfc98751b11af725cc1395134bd1.1676586881.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <703ac15222fdcfc98751b11af725cc1395134bd1.1676586881.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 16, 2023 at 10:34:40PM +0000, Matthew John Cheetham via GitGitGadget wrote:

> +/*
> + * Like skip_prefix_mem, but compare case-insensitively. Note that the
> + * comparison is done via tolower(), so it is strictly ASCII (no multi-byte
> + * characters or locale-specific conversions).
> + */
> +static inline int skip_iprefix_mem(const char *buf, size_t len,
> +				   const char *prefix,
> +				   const char **out, size_t *outlen)
> +{
> +	size_t prefix_len = strlen(prefix);
> +
> +	if (len < prefix_len)
> +		return 0;
> +
> +	if (!strncasecmp(buf, prefix, prefix_len)) {
> +		*out = buf + prefix_len;
> +		*outlen = len - prefix_len;
> +		return 1;
> +	}
> +
> +	return 0;
> +}

The comment at the top of the function seems out of date. It's using
strncasecmp(), so it probably would be locale-dependent. I think that's
probably OK, but we should probably fix the comment.

Alternatively, you could copy the tolower() loop from skip_iprefix().
Something like:
  
diff --git a/git-compat-util.h b/git-compat-util.h
index 28456241b6..f671a0ec3f 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -1296,17 +1296,13 @@ static inline int skip_iprefix_mem(const char *buf, size_t len,
 				   const char *prefix,
 				   const char **out, size_t *outlen)
 {
-	size_t prefix_len = strlen(prefix);
-
-	if (len < prefix_len)
-		return 0;
-
-	if (!strncasecmp(buf, prefix, prefix_len)) {
-		*out = buf + prefix_len;
-		*outlen = len - prefix_len;
-		return 1;
-	}
-
+	do {
+		if (!*prefix) {
+			*out = buf;
+			*outlen = len;
+			return 1;
+		}
+	} while (len-- > 0 && tolower(*buf++) == tolower(*prefix++));
 	return 0;
 }
 

looks right to me, though only lightly tested (via t5563). I'm happy
with either implementation.

> +static size_t fwrite_wwwauth(char *ptr, size_t eltsize, size_t nmemb, void *p)
> [...]
> +	/*
> +	 * If this is a HTTP status line and not a header field, this signals
> +	 * a different HTTP response. libcurl writes all the output of all
> +	 * response headers of all responses, including redirects.
> +	 * We only care about the last HTTP request response's headers so clear
> +	 * the existing array.
> +	 */
> +	if (!strncasecmp(ptr, "http/", 5))
> +		strvec_clear(values);

Since "ptr" isn't NUL terminated, using strncasecmp() may walk off the
end. I think you'd need to check that there are five bytes. You could
even use skip_iprefix_mem(), though of course we'd throw away the output
values. (For strings there is also istarts_with(), but I don't think we
have a "mem" equivalent).

The rest of the parsing looks good to me.

-Peff
