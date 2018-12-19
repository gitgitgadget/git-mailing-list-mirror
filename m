Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9B3B61F405
	for <e@80x24.org>; Wed, 19 Dec 2018 15:48:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730381AbeLSPs5 (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Dec 2018 10:48:57 -0500
Received: from cloud.peff.net ([104.130.231.41]:45812 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1730378AbeLSPsz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Dec 2018 10:48:55 -0500
Received: (qmail 24186 invoked by uid 109); 19 Dec 2018 15:48:55 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 19 Dec 2018 15:48:55 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22163 invoked by uid 111); 19 Dec 2018 15:48:28 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 19 Dec 2018 10:48:28 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 19 Dec 2018 10:48:53 -0500
Date:   Wed, 19 Dec 2018 10:48:53 -0500
From:   Jeff King <peff@peff.net>
To:     Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>
Cc:     git@vger.kernel.org,
        "brian m . carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH 3/3] setup: add `clear_repository_format()`
Message-ID: <20181219154853.GC14802@sigill.intra.peff.net>
References: <20181218072528.3870492-1-martin.agren@gmail.com>
 <20181218072528.3870492-4-martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181218072528.3870492-4-martin.agren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 18, 2018 at 08:25:28AM +0100, Martin Ågren wrote:

> After we set up a `struct repository_format`, it owns various pieces of
> allocated memory. We then either use those members, because we decide we
> want to use the "candidate" repository format, or we discard the
> candidate / scratch space. In the first case, we transfer ownership of
> the memory to a few global variables. In the latter case, we just
> silently drop the struct and end up leaking memory.
> 
> Introduce a function `clear_repository_format()` which frees the memory
> the struct holds on to. Call it in the code paths where we currently
> leak the memory. Also call it in the error path of
> `read_repository_format()` to clean up any partial result.
> 
> For hygiene, we need to at least set the pointers that we free to NULL.
> For future-proofing, let's zero the entire struct instead. It just means
> that in the error path of `read_...()` we need to restore the error
> sentinel in the `version` field.

This seems reasonable, and I very much agree on the zero-ing (even
though it _shouldn't_ matter due to the "undefined" rule). That also
makes it safe to clear() multiple times, which is a nice property.

> +void clear_repository_format(struct repository_format *format)
> +{
> +	string_list_clear(&format->unknown_extensions, 0);
> +	free(format->work_tree);
> +	free(format->partial_clone);
> +	memset(format, 0, sizeof(*format));
>  }

For the callers that actually pick the values out, I think it might be a
little less error-prone if they actually copied the strings and then
called clear_repository_format(). That avoids leaks of values that they
didn't know or care about (and the cost of an extra strdup for
repository setup is not a big deal).

Something like this on top of your patch, I guess (with the idea being
that functions which return an error would clear the format, but a
"successful" one would get returned back up the stack to
setup_git_directory_gently(), which then clears it before returning.

-- >8 --
diff --git a/setup.c b/setup.c
index babe5ea156..a5699f9ee6 100644
--- a/setup.c
+++ b/setup.c
@@ -470,6 +470,7 @@ static int check_repository_format_gently(const char *gitdir, struct repository_
 			warning("%s", err.buf);
 			strbuf_release(&err);
 			*nongit_ok = -1;
+			clear_repository_format(candidate);
 			return -1;
 		}
 		die("%s", err.buf);
@@ -499,7 +500,7 @@ static int check_repository_format_gently(const char *gitdir, struct repository_
 		}
 		if (candidate->work_tree) {
 			free(git_work_tree_cfg);
-			git_work_tree_cfg = candidate->work_tree;
+			git_work_tree_cfg = xstrdup(candidate->work_tree);
 			inside_work_tree = -1;
 		}
 	} else {
@@ -1158,6 +1159,7 @@ const char *setup_git_directory_gently(int *nongit_ok)
 
 	strbuf_release(&dir);
 	strbuf_release(&gitdir);
+	clear_repository_format(&repo_fmt);
 
 	return prefix;
 }

-Peff
