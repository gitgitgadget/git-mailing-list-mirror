Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 481B91F453
	for <e@80x24.org>; Thu, 27 Sep 2018 18:17:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728301AbeI1Agk (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Sep 2018 20:36:40 -0400
Received: from cloud.peff.net ([104.130.231.41]:33842 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727223AbeI1Agk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Sep 2018 20:36:40 -0400
Received: (qmail 6790 invoked by uid 109); 27 Sep 2018 18:17:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 27 Sep 2018 18:17:10 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3330 invoked by uid 111); 27 Sep 2018 18:16:46 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 27 Sep 2018 14:16:46 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 27 Sep 2018 14:17:08 -0400
Date:   Thu, 27 Sep 2018 14:17:08 -0400
From:   Jeff King <peff@peff.net>
To:     Nickolai Belakovski <nbelakovski@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] branch: colorize branches checked out in a linked
 working tree the same way as the current branch is colorized
Message-ID: <20180927181708.GA2468@sigill.intra.peff.net>
References: <CAC05386q2iGoiJ_fRgwoOTF23exEN2D1+oh4VjajEvYQ58O1TQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAC05386q2iGoiJ_fRgwoOTF23exEN2D1+oh4VjajEvYQ58O1TQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 27, 2018 at 08:13:13AM -0700, Nickolai Belakovski wrote:

> In order to more clearly display which branches are active, the output
> of git branch is modified to colorize branches checked out in any linked
> worktrees with the same color as the current branch.

I think the goal makes sense.

Do we want to limit this to git-branch, though? Ideally any output you
get from git-branch could be replicated with for-each-ref (or with
a custom "branch --format").

I.e., could we have a format in ref-filter that matches HEAD, but
returns a distinct symbol for a worktree HEAD? That would allow a few
things:

  - custom --formats for for-each-ref and branch could reuse the logic

  - we could show the symbol (in place of "*") even when color is not
    enabled

  - it should be much faster if there are a lot of worktrees; your patch
    does a linear if/else chain to look at each worktree, and it does it
    in the format-language, which is much slower than actual C. :)

Something like the patch below. I just picked "+" arbitrarily, but any
character would do (I avoided "*" just to make it visually distinct from
the current-worktree HEAD). I've left plugging this into git-branch's
default format as an exercise for the reader. ;)

---
diff --git a/ref-filter.c b/ref-filter.c
index e1bcb4ca8a..b17eefed0d 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -20,6 +20,7 @@
 #include "commit-slab.h"
 #include "commit-graph.h"
 #include "commit-reach.h"
+#include "worktree.h"
 
 static struct ref_msg {
 	const char *gone;
@@ -114,6 +115,7 @@ static struct used_atom {
 		} objectname;
 		struct refname_atom refname;
 		char *head;
+		struct string_list worktree_heads;
 	} u;
 } *used_atom;
 static int used_atom_cnt, need_tagged, need_symref;
@@ -420,6 +422,29 @@ static int head_atom_parser(const struct ref_format *format, struct used_atom *a
 	return 0;
 }
 
+static int worktree_head_atom_parser(const struct ref_format *format,
+				     struct used_atom *atom,
+				     const char *arg,
+				     struct strbuf *unused_err)
+{
+	struct worktree **worktrees = get_worktrees(0);
+	int i;
+
+	string_list_init(&atom->u.worktree_heads, 1);
+
+	for (i = 0; worktrees[i]; i++) {
+		if (worktrees[i]->head_ref)
+			string_list_append(&atom->u.worktree_heads,
+					   worktrees[i]->head_ref);
+	}
+
+	string_list_sort(&atom->u.worktree_heads);
+
+	free_worktrees(worktrees);
+	return 0;
+
+}
+
 static struct {
 	const char *name;
 	info_source source;
@@ -460,6 +485,7 @@ static struct {
 	{ "symref", SOURCE_NONE, FIELD_STR, refname_atom_parser },
 	{ "flag", SOURCE_NONE },
 	{ "HEAD", SOURCE_NONE, FIELD_STR, head_atom_parser },
+	{ "worktree", SOURCE_NONE, FIELD_STR, worktree_head_atom_parser },
 	{ "color", SOURCE_NONE, FIELD_STR, color_atom_parser },
 	{ "align", SOURCE_NONE, FIELD_STR, align_atom_parser },
 	{ "end", SOURCE_NONE },
@@ -1588,6 +1614,13 @@ static int populate_value(struct ref_array_item *ref, struct strbuf *err)
 			else
 				v->s = " ";
 			continue;
+		} else if (!strcmp(name, "worktree")) {
+			if (string_list_has_string(&atom->u.worktree_heads,
+						   ref->refname))
+				v->s = "+";
+			else
+				v->s = " ";
+			continue;
 		} else if (starts_with(name, "align")) {
 			v->handler = align_atom_handler;
 			v->s = "";
