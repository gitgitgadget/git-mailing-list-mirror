From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v3 11/24] grep.c: use index api
Date: Sun, 18 Aug 2013 21:42:00 +0200
Message-ID: <1376854933-31241-12-git-send-email-t.gummerer@gmail.com>
References: <1376854933-31241-1-git-send-email-t.gummerer@gmail.com>
Cc: trast@inf.ethz.ch, mhagger@alum.mit.edu, gitster@pobox.com,
	pclouds@gmail.com, robin.rosenberg@dewire.com,
	sunshine@sunshineco.com, ramsay@ramsay1.demon.co.uk,
	t.gummerer@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 18 21:48:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VB8xz-0003xJ-R7
	for gcvg-git-2@plane.gmane.org; Sun, 18 Aug 2013 21:48:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754863Ab3HRTsl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Aug 2013 15:48:41 -0400
Received: from mail-wg0-f53.google.com ([74.125.82.53]:35925 "EHLO
	mail-wg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754647Ab3HRTsk (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Aug 2013 15:48:40 -0400
Received: by mail-wg0-f53.google.com with SMTP id c11so2968953wgh.32
        for <git@vger.kernel.org>; Sun, 18 Aug 2013 12:48:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=v2et2lfoNuR4nrbl9XHgpyRZ9siQP7hVxqv6DtWWGYM=;
        b=VOnrCWBvWbS9cs1kP3Qlag8xZDUf9oUEYqmKqrBGJKAIMet8Ofz+jOwaPTdieahZIQ
         6jixGQCoFeDAtN7v4lPMOWLlV0wU2/C8JT1PEKMhzwjGPhPr5kHQkl+tbJ3iBrJ7QtLq
         yH6aBsiMLOHesrqnY3IztBAVyQmgkctyj89Y+1eYlBDXHztoHEVU9yqdNornUcR8NBEB
         XUCRiD3vFi+xkPEH0F1Kl5dtuUBIWFK3m/ThO6OBVR0u7N9zPpyFYmST9ESrJx713+lE
         Tc53AJR7JXaD/VjLvzbQaXJwroTTcpZwykjOTK9Fe+5FWHFzoLklNDBAJ+U0+P/rYsb/
         yClg==
X-Received: by 10.194.240.197 with SMTP id wc5mr5996108wjc.23.1376855319926;
        Sun, 18 Aug 2013 12:48:39 -0700 (PDT)
Received: from localhost (host105-104-dynamic.0-79-r.retail.telecomitalia.it. [79.0.104.105])
        by mx.google.com with ESMTPSA id bt8sm11764247wib.8.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 18 Aug 2013 12:48:39 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.4.1231.g9fbf354.dirty
In-Reply-To: <1376854933-31241-1-git-send-email-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232499>

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 builtin/grep.c | 69 +++++++++++++++++++++++++++++-----------------------------
 1 file changed, 35 insertions(+), 34 deletions(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index 7dc0389..1114fe8 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -369,41 +369,31 @@ static void run_pager(struct grep_opt *opt, const char *prefix)
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
-		const struct cache_entry *ce = active_cache[nr];
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
@@ -897,10 +887,21 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
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
1.8.3.4.1231.g9fbf354.dirty
