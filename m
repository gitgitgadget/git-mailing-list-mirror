Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9A0FF20A2A
	for <e@80x24.org>; Wed, 20 Sep 2017 20:25:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751799AbdITUZz (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Sep 2017 16:25:55 -0400
Received: from cloud.peff.net ([104.130.231.41]:45134 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751687AbdITUZz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Sep 2017 16:25:55 -0400
Received: (qmail 12105 invoked by uid 109); 20 Sep 2017 20:25:55 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 20 Sep 2017 20:25:55 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16025 invoked by uid 111); 20 Sep 2017 20:26:32 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Wed, 20 Sep 2017 16:26:32 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 20 Sep 2017 16:25:52 -0400
Date:   Wed, 20 Sep 2017 16:25:52 -0400
From:   Jeff King <peff@peff.net>
To:     Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] revision: fix memory leaks with `struct cmdline_pathspec`
Message-ID: <20170920202552.kkwhigmv7lq6cj3y@sigill.intra.peff.net>
References: <1505936846-2195-4-git-send-email-martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1505936846-2195-4-git-send-email-martin.agren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 20, 2017 at 09:47:26PM +0200, Martin Ågren wrote:

> We don't free the array `prune_data.path` or the individual strings it
> points to. Do so by introducing and using `free_cmdline_pathspec()`. To
> be able to safely free the strings, always use `xstrdup()` when
> assigning them. That does mean we allocate more memory than we used to,
> but it also means it is clear who owns the strings and that we can stop
> leaking those that we do allocate.

Hmm. From this description (and from looking at the patch), it seems
like we could just skip the allocation.

The missing piece of the puzzle is that sometimes we call
append_prune_data() to append from argv, and sometimes we use
read_pathspec_from_stdin().

So we may literally have a mix-and-match of allocated and unallocated
entries, and the only sane way to resolve that is by making them all
allocated.

So I think this solves the problem, but I couldn't help notice...

> @@ -1682,7 +1682,7 @@ static void append_prune_data(struct cmdline_pathspec *prune, const char **av)
>  {
>  	while (*av) {
>  		ALLOC_GROW(prune->path, prune->nr + 1, prune->alloc);
> -		prune->path[prune->nr++] = *(av++);
> +		prune->path[prune->nr++] = xstrdup(*(av++));
>  	}

Isn't this whole thing just an argv_array, and this is argv_array_pushv?
We even NULL-terminate it manually later on!

So rather than increasing the line count by adding
free_cmdline_pathspec, I think we could actually _reduce_ it by
converting to an argv array, as below. And then adding in your free
would be one extra line.

diff --git a/revision.c b/revision.c
index 94a5e98525..5c58b3fb2b 100644
--- a/revision.c
+++ b/revision.c
@@ -20,6 +20,7 @@
 #include "cache-tree.h"
 #include "bisect.h"
 #include "packfile.h"
+#include "argv-array.h"
 
 volatile show_early_output_fn_t show_early_output;
 
@@ -1612,31 +1613,15 @@ int handle_revision_arg(const char *arg_, struct rev_info *revs, int flags, unsi
 	return 0;
 }
 
-struct cmdline_pathspec {
-	int alloc;
-	int nr;
-	const char **path;
-};
-
-static void append_prune_data(struct cmdline_pathspec *prune, const char **av)
-{
-	while (*av) {
-		ALLOC_GROW(prune->path, prune->nr + 1, prune->alloc);
-		prune->path[prune->nr++] = *(av++);
-	}
-}
-
 static void read_pathspec_from_stdin(struct rev_info *revs, struct strbuf *sb,
-				     struct cmdline_pathspec *prune)
+				     struct argv_array *prune)
 {
-	while (strbuf_getline(sb, stdin) != EOF) {
-		ALLOC_GROW(prune->path, prune->nr + 1, prune->alloc);
-		prune->path[prune->nr++] = xstrdup(sb->buf);
-	}
+	while (strbuf_getline(sb, stdin) != EOF)
+		argv_array_push(prune, sb->buf);
 }
 
 static void read_revisions_from_stdin(struct rev_info *revs,
-				      struct cmdline_pathspec *prune)
+				      struct argv_array *prune)
 {
 	struct strbuf sb;
 	int seen_dashdash = 0;
@@ -2201,10 +2186,9 @@ static void NORETURN diagnose_missing_default(const char *def)
 int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct setup_revision_opt *opt)
 {
 	int i, flags, left, seen_dashdash, read_from_stdin, got_rev_arg = 0, revarg_opt;
-	struct cmdline_pathspec prune_data;
+	struct argv_array prune_data = ARGV_ARRAY_INIT;
 	const char *submodule = NULL;
 
-	memset(&prune_data, 0, sizeof(prune_data));
 	if (opt)
 		submodule = opt->submodule;
 
@@ -2220,7 +2204,7 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
 			argv[i] = NULL;
 			argc = i;
 			if (argv[i + 1])
-				append_prune_data(&prune_data, argv + i + 1);
+				argv_array_pushv(&prune_data, argv + i + 1);
 			seen_dashdash = 1;
 			break;
 		}
@@ -2281,14 +2265,14 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
 			for (j = i; j < argc; j++)
 				verify_filename(revs->prefix, argv[j], j == i);
 
-			append_prune_data(&prune_data, argv + i);
+			argv_array_pushv(&prune_data, argv + i);
 			break;
 		}
 		else
 			got_rev_arg = 1;
 	}
 
-	if (prune_data.nr) {
+	if (prune_data.argc) {
 		/*
 		 * If we need to introduce the magic "a lone ':' means no
 		 * pathspec whatsoever", here is the place to do so.
@@ -2303,10 +2287,8 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
 		 *	call init_pathspec() to set revs->prune_data here.
 		 * }
 		 */
-		ALLOC_GROW(prune_data.path, prune_data.nr + 1, prune_data.alloc);
-		prune_data.path[prune_data.nr++] = NULL;
 		parse_pathspec(&revs->prune_data, 0, 0,
-			       revs->prefix, prune_data.path);
+			       revs->prefix, prune_data.argv);
 	}
 
 	if (revs->def == NULL)
