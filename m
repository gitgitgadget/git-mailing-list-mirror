From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v2 08/19] grep.c: Use index api
Date: Fri, 12 Jul 2013 19:26:53 +0200
Message-ID: <1373650024-3001-9-git-send-email-t.gummerer@gmail.com>
References: <1373650024-3001-1-git-send-email-t.gummerer@gmail.com>
Cc: t.gummerer@gmail.com, trast@inf.ethz.ch, mhagger@alum.mit.edu,
	gitster@pobox.com, pclouds@gmail.com, robin.rosenberg@dewire.com,
	sunshine@sunshineco.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 12 19:29:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uxh9W-0003nF-Jo
	for gcvg-git-2@plane.gmane.org; Fri, 12 Jul 2013 19:29:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933305Ab3GLR3B (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Jul 2013 13:29:01 -0400
Received: from mail-pa0-f41.google.com ([209.85.220.41]:57881 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932650Ab3GLR3A (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jul 2013 13:29:00 -0400
Received: by mail-pa0-f41.google.com with SMTP id bj3so9283048pad.28
        for <git@vger.kernel.org>; Fri, 12 Jul 2013 10:28:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=BaPMGbssOguxqMu0ObLx3HN4aLSyq6l2MxS/9rRp6aQ=;
        b=iiIpR0xq/d6jtw/U/hxrKc/QVeoe5qwQh/9HuNTdTMhAo33EEvgeLmaOavz3C3g1ut
         WR2QCpEJ/mqK4/hRefEKma60O4on97QpxNi8MOkDD90VuFkeEBDdtLoT5rTjWohq9/im
         HvzYBVqwowIjGmEzoOQtnqPjQ05RSRnNyJPH3E39YzhRK9PIyumcgYJ9ewYGIKB34dFq
         JuuYJAnowiB6vqSyxi3/9FnbTBzjq2T1I6ym3wbr8UYXrCqjRVnCaGCkZGix08KUX0Bx
         QHnWIi1HnbHaHYEPw2vD8Rg4cVJqFl0I3A3ayB/bXOUqg2D3FKFgppnPnyXcy4vKu6AL
         bm7w==
X-Received: by 10.66.2.130 with SMTP id 2mr44441893pau.13.1373650139689;
        Fri, 12 Jul 2013 10:28:59 -0700 (PDT)
Received: from localhost ([2001:470:6d:596:9227:e4ff:feea:9196])
        by mx.google.com with ESMTPSA id jf4sm46413605pbb.19.2013.07.12.10.28.55
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 12 Jul 2013 10:28:59 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.453.g1dfc63d
In-Reply-To: <1373650024-3001-1-git-send-email-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230218>

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 builtin/grep.c | 71 ++++++++++++++++++++++++++++++----------------------------
 1 file changed, 37 insertions(+), 34 deletions(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index a419cda..8b02644 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -368,41 +368,33 @@ static void run_pager(struct grep_opt *opt, const char *prefix)
 	free(argv);
 }
 
-static int grep_cache(struct grep_opt *opt, const struct pathspec *pathspec, int cached)
+struct grep_opts {
+	struct grep_opt *opt;
+	const struct pathspec *pathspec;
+	int cached;
+	int hit;
+};
+
+static int grep_cache(struct cache_entry *ce, void *cb_data)
 {
-	int hit = 0;
-	int nr;
-	read_cache();
+	struct grep_opts *opts = cb_data;
 
-	for (nr = 0; nr < active_nr; nr++) {
-		struct cache_entry *ce = active_cache[nr];
-		if (!S_ISREG(ce->ce_mode))
-			continue;
-		if (!match_pathspec_depth(pathspec, ce->name, ce_namelen(ce), 0, NULL))
-			continue;
-		/*
-		 * If CE_VALID is on, we assume worktree file and its cache entry
-		 * are identical, even if worktree file has been modified, so use
-		 * cache version instead
-		 */
-		if (cached || (ce->ce_flags & CE_VALID) || ce_skip_worktree(ce)) {
-			if (ce_stage(ce))
-				continue;
-			hit |= grep_sha1(opt, ce->sha1, ce->name, 0, ce->name);
-		}
-		else
-			hit |= grep_file(opt, ce->name);
-		if (ce_stage(ce)) {
-			do {
-				nr++;
-			} while (nr < active_nr &&
-				 !strcmp(ce->name, active_cache[nr]->name));
-			nr--; /* compensate for loop control */
-		}
-		if (hit && opt->status_only)
-			break;
-	}
-	return hit;
+	if (!S_ISREG(ce->ce_mode))
+		return 0;
+	if (!match_pathspec_depth(opts->pathspec, ce->name, ce_namelen(ce), 0, NULL))
+		return 0;
+	/*
+	 * If CE_VALID is on, we assume worktree file and its cache entry
+	 * are identical, even if worktree file has been modified, so use
+	 * cache version instead
+	 */
+	if (opts->cached || (ce->ce_flags & CE_VALID) || ce_skip_worktree(ce))
+		opts->hit |= grep_sha1(opts->opt, ce->sha1, ce->name, 0, ce->name);
+	else
+		opts->hit |= grep_file(opts->opt, ce->name);
+	if (opts->hit && opts->opt->status_only)
+		return 1;
+	return 0;
 }
 
 static int grep_tree(struct grep_opt *opt, const struct pathspec *pathspec,
@@ -895,10 +887,21 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 	} else if (0 <= opt_exclude) {
 		die(_("--[no-]exclude-standard cannot be used for tracked contents."));
 	} else if (!list.nr) {
+		struct grep_opts opts;
+		struct filter_opts *filter_opts = xmalloc(sizeof(*filter_opts));
+
 		if (!cached)
 			setup_work_tree();
 
-		hit = grep_cache(&opt, &pathspec, cached);
+		memset(filter_opts, 0, sizeof(*filter_opts));
+		filter_opts->pathspec = &pathspec;
+		opts.opt = &opt;
+		opts.pathspec = &pathspec;
+		opts.cached = cached;
+		opts.hit = 0;
+		read_cache_filtered(filter_opts);
+		for_each_cache_entry(grep_cache, &opts);
+		hit = opts.hit;
 	} else {
 		if (cached)
 			die(_("both --cached and trees are given."));
-- 
1.8.3.453.g1dfc63d
