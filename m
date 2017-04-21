Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D1F95207BC
	for <e@80x24.org>; Fri, 21 Apr 2017 15:56:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1037185AbdDUO74 (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Apr 2017 10:59:56 -0400
Received: from cloud.peff.net ([104.130.231.41]:37745 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1041242AbdDUO7y (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Apr 2017 10:59:54 -0400
Received: (qmail 32741 invoked by uid 109); 21 Apr 2017 14:59:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 21 Apr 2017 14:59:18 +0000
Received: (qmail 16928 invoked by uid 111); 21 Apr 2017 14:59:42 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 21 Apr 2017 10:59:42 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 21 Apr 2017 10:59:16 -0400
Date:   Fri, 21 Apr 2017 10:59:16 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/6] nd/worktree-move update
Message-ID: <20170421145916.mknekgqzhxffu7di@sigill.intra.peff.net>
References: <20170420101024.7593-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20170420101024.7593-1-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 20, 2017 at 05:10:18PM +0700, Nguyễn Thái Ngọc Duy wrote:

>  - fixes the compile problem on latest master (because prefix_filename
>    takes one argument less)

It also now returns an allocated buffer.

So:

> --- a/builtin/worktree.c
> +++ b/builtin/worktree.c
> @@ -561,9 +561,7 @@ static int move_worktree(int ac, const char **av, const char *prefix)
>  	if (ac != 2)
>  		usage_with_options(worktree_usage, options);
>  
> -	strbuf_addstr(&dst, prefix_filename(prefix,
> -					    strlen(prefix),
> -					    av[1]));
> +	strbuf_addstr(&dst, prefix_filename(prefix, av[1]));

...this is now a leak. Probably:

  const char *filename = prefix_filename(prefix, av[1]);
  strbuf_attach(&dst, filename, strlen(filename), strlen(filename));

is what you want. That would be less awkward if we had a
strbuf_attach_str().

Or if we had a strbuf variant of prefix_filename(), you could do:

  prefix_filename_buf(&dst, prefix, av[1]);

I almost added that when I did the prefix_filename() work, since it uses
a strbuf internally. But there were no callers that would have used it.
Maybe it's worth doing now.

-- >8 --
From d0b933fc023023a017df9268360aa327c28b90f0 Mon Sep 17 00:00:00 2001
From: Jeff King <peff@peff.net>
Date: Fri, 21 Apr 2017 10:53:07 -0400
Subject: [PATCH] prefix_filename: add strbuf variant

Now that prefix_filename() always allocates, it's awkward to
put its value directly into a strbuf. You have to either
free:

  const char *filename = prefix_filename(prefix, arg);
  strbuf_addstr(&buf, filename);
  free(filename);

or you have to attach:

  const char *filename = prefix_filename(prefix, arg);
  strbuf_attach(&buf, filename, strlen(filename), strlen(filename));

Since we're already using a strbuf internally, it's easy to
provide a variant that lets you write directly into one:

  prefix_filename_buf(&buf, prefix, arg);

For consistency with git_path_buf(), the function overwrites
the strbuf rather than appending.

Signed-off-by: Jeff King <peff@peff.net>
---
 abspath.c | 17 ++++++++++++-----
 cache.h   |  6 ++++++
 2 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/abspath.c b/abspath.c
index 7f1cfe979..7594f62a5 100644
--- a/abspath.c
+++ b/abspath.c
@@ -246,21 +246,28 @@ char *absolute_pathdup(const char *path)
 	return strbuf_detach(&sb, NULL);
 }
 
-char *prefix_filename(const char *pfx, const char *arg)
+void prefix_filename_buf(struct strbuf *path, const char *pfx, const char *arg)
 {
-	struct strbuf path = STRBUF_INIT;
 	size_t pfx_len = pfx ? strlen(pfx) : 0;
 
+	strbuf_reset(path);
+
 	if (!pfx_len)
 		; /* nothing to prefix */
 	else if (is_absolute_path(arg))
 		pfx_len = 0;
 	else
-		strbuf_add(&path, pfx, pfx_len);
+		strbuf_add(path, pfx, pfx_len);
 
-	strbuf_addstr(&path, arg);
+	strbuf_addstr(path, arg);
 #ifdef GIT_WINDOWS_NATIVE
-	convert_slashes(path.buf + pfx_len);
+	convert_slashes(path->buf + pfx_len);
 #endif
+}
+
+char *prefix_filename(const char *pfx, const char *arg)
+{
+	struct strbuf path = STRBUF_INIT;
+	prefix_filename_buf(&path, pfx, arg);
 	return strbuf_detach(&path, NULL);
 }
diff --git a/cache.h b/cache.h
index ba27595d5..209039a98 100644
--- a/cache.h
+++ b/cache.h
@@ -548,6 +548,12 @@ extern char *prefix_path_gently(const char *prefix, int len, int *remaining, con
  */
 extern char *prefix_filename(const char *prefix, const char *path);
 
+/*
+ * Like prefix_filename, but write into "buf", overwriting any
+ * previous contents of the strbuf.
+ */
+extern void prefix_filename_buf(struct strbuf *out, const char *prefix, const char *path);
+
 extern int check_filename(const char *prefix, const char *name);
 extern void verify_filename(const char *prefix,
 			    const char *name,
-- 
2.13.0.rc0.364.g36b4d8031

