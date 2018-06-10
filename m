Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 34D991F403
	for <e@80x24.org>; Sun, 10 Jun 2018 20:44:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932153AbeFJUoW (ORCPT <rfc822;e@80x24.org>);
        Sun, 10 Jun 2018 16:44:22 -0400
Received: from cloud.peff.net ([104.130.231.41]:40850 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1753736AbeFJUoV (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Jun 2018 16:44:21 -0400
Received: (qmail 17000 invoked by uid 109); 10 Jun 2018 20:44:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sun, 10 Jun 2018 20:44:21 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11806 invoked by uid 111); 10 Jun 2018 20:44:35 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Sun, 10 Jun 2018 16:44:35 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 10 Jun 2018 16:44:19 -0400
Date:   Sun, 10 Jun 2018 16:44:19 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Elijah Newren <newren@gmail.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 24/30] merge-recursive: Add computation of collisions due
 to dir rename & merging
Message-ID: <20180610204419.GA11273@sigill.intra.peff.net>
References: <20171110190550.27059-1-newren@gmail.com>
 <20171110190550.27059-25-newren@gmail.com>
 <7d1237c7-5a83-d766-7d93-5f0d59166067@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7d1237c7-5a83-d766-7d93-5f0d59166067@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jun 10, 2018 at 12:56:31PM +0200, René Scharfe wrote:

> The value of PATH_MAX is platform-dependent, so it's easy to exceed when
> doing cross-platform development.  It's also not a hard limit on most
> operating systems, not even on Windows.  Further reading:
> 
>    https://insanecoding.blogspot.com/2007/11/pathmax-simply-isnt.html
> 
> So using a fixed buffer is not a good idea, and writing to it without
> checking is dangerous.  Here's a fix:

Even on platforms where it _is_ a hard-limit, we are quite often dealing
with paths that come from tree objects (so even if the OS would
eventually complain about our path, it is small consolation when we
smash the stack before we get there).

Your patch looks good to me, and we definitely should address this
before v2.18-final.

> -	char temp[PATH_MAX];
> +	char *temp = xstrdup(path);
>  	char *end;
> -	struct dir_rename_entry *entry;
> +	struct dir_rename_entry *entry = NULL;;
>  
> -	strcpy(temp, path);

I'm sad that this strcpy() wasn't caught in review. IMHO we should avoid
that function altogether, even when we _think_ it can't trigger an
overflow. That's easier to reason about (and makes auditing easier).

It looks like another one has crept in recently, too.

-- >8 --
Subject: [PATCH] blame: prefer xsnprintf to strcpy for colors

Our color buffers are all COLOR_MAXLEN, which fits the
largest possible color. So we can never overflow the buffer
by copying an existing color. However, using strcpy() makes
it harder to audit the code-base for calls that _are_
problems. We should use something like xsnprintf(), which
shows the reader that we expect this never to fail (and
provides a run-time assertion if it does, just in case).

Signed-off-by: Jeff King <peff@peff.net>
---
Another option would just be color_parse(repeated_meta_color, "cyan").
The run-time cost is slightly higher, but it probably doesn't matter
here, and perhaps it's more readable.

This one is less critical for v2.18.

 builtin/blame.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index 4202584f97..45770c5a8c 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -1068,7 +1068,9 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 		find_alignment(&sb, &output_option);
 		if (!*repeated_meta_color &&
 		    (output_option & OUTPUT_COLOR_LINE))
-			strcpy(repeated_meta_color, GIT_COLOR_CYAN);
+			xsnprintf(repeated_meta_color,
+				  sizeof(repeated_meta_color),
+				  "%s", GIT_COLOR_CYAN);
 	}
 	if (output_option & OUTPUT_ANNOTATE_COMPAT)
 		output_option &= ~(OUTPUT_COLOR_LINE | OUTPUT_SHOW_AGE_WITH_COLOR);
-- 
2.18.0.rc1.446.g4486251e51

