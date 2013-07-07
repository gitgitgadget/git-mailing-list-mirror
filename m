From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH 10/22] grep.c: Use index api
Date: Sun,  7 Jul 2013 10:11:48 +0200
Message-ID: <1373184720-29767-11-git-send-email-t.gummerer@gmail.com>
References: <1373184720-29767-1-git-send-email-t.gummerer@gmail.com>
Cc: trast@inf.ethz.ch, mhagger@alum.mit.edu, gitster@pobox.com,
	pclouds@gmail.com, robin.rosenberg@dewire.com, t.gummerer@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 07 10:13:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uvk63-0006J6-5p
	for gcvg-git-2@plane.gmane.org; Sun, 07 Jul 2013 10:13:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752066Ab3GGINU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Jul 2013 04:13:20 -0400
Received: from mail-ee0-f47.google.com ([74.125.83.47]:48291 "EHLO
	mail-ee0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751983Ab3GGIM6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Jul 2013 04:12:58 -0400
Received: by mail-ee0-f47.google.com with SMTP id e49so2140355eek.20
        for <git@vger.kernel.org>; Sun, 07 Jul 2013 01:12:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=pqtn1YQ1uLVLXgj9IaqRcsiteq28874h/33u8UTU0+8=;
        b=cvzLVz671w3RlE/L/fmIVrzmNS1D/YCFJ4gxpDc/d1JIYgootQfzpogAl6tzkImBhy
         /mKZzc2i+kMllfKiaoKJMcXYrNpklVxTXApvVtL3zRiXuXjGtJuTS7/LRtXq+exgBxKg
         VAksyvbsef/Pa01UzefoHmCRDhxkuVju11QyKnian875wEjOj/4qxJWOTYIMSnliNw6M
         StXodJav+C/xNwHGZR5AZT3NHmIlrQXZbVM5J/6L/z5Gry1kDP1xVDHPhLuSpNkTCHAu
         zi/IeUZP/RK/nY/tbaeyQhifQ/A9gYjKL2ogNLEZzEEmplkZWZNKI/LzJF/ylOB262wR
         DbeA==
X-Received: by 10.15.110.10 with SMTP id cg10mr19794863eeb.57.1373184777595;
        Sun, 07 Jul 2013 01:12:57 -0700 (PDT)
Received: from localhost (host252-23-dynamic.0-87-r.retail.telecomitalia.it. [87.0.23.252])
        by mx.google.com with ESMTPSA id ci50sm30682236eeb.12.2013.07.07.01.12.55
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 07 Jul 2013 01:12:56 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.453.g1dfc63d
In-Reply-To: <1373184720-29767-1-git-send-email-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229743>

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 builtin/grep.c | 71 ++++++++++++++++++++++++++++++----------------------------
 1 file changed, 37 insertions(+), 34 deletions(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index a419cda..2a1c8f4 100644
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
+		filter_opts->pathspec = pathspec.raw;
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
