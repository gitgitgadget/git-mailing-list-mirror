From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v4 08/24] grep.c: use index api
Date: Wed, 27 Nov 2013 13:00:43 +0100
Message-ID: <1385553659-9928-9-git-send-email-t.gummerer@gmail.com>
References: <1385553659-9928-1-git-send-email-t.gummerer@gmail.com>
Cc: t.gummerer@gmail.com, gitster@pobox.com, tr@thomasrast.ch,
	mhagger@alum.mit.edu, pclouds@gmail.com,
	robin.rosenberg@dewire.com, sunshine@sunshineco.com,
	ramsay@ramsay1.demon.co.uk
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 27 13:02:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vldof-0001tV-IB
	for gcvg-git-2@plane.gmane.org; Wed, 27 Nov 2013 13:02:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754780Ab3K0MBx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Nov 2013 07:01:53 -0500
Received: from mail-la0-f45.google.com ([209.85.215.45]:56628 "EHLO
	mail-la0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754322Ab3K0MBw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Nov 2013 07:01:52 -0500
Received: by mail-la0-f45.google.com with SMTP id eh20so5163826lab.18
        for <git@vger.kernel.org>; Wed, 27 Nov 2013 04:01:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xYHHH9DaWmVFxEzJRT91pHoG76uue1+eqZpWoEzqzYc=;
        b=bIDIMMARCb5+6RpndhOw0+vEbowjmzPdPlT5Ok/cUdZztMLtLsBGKUxHEJHqsRf+RM
         xIpO90ATz8x4IFUB0IqXBeBtO/zXuTJAoeSH20kvGHaSbGvMKOgaLS4r09ta5wOzE4XC
         txPYXxvXiRg3glxNwmNN7QjU2ZDrpS5ACKimdL145yqtXAKjNH+50A7JbmYWdN1EmMg7
         8yutqILzfBDbHaTTEICvDX/KOT28WMSr39dyh7FdAsIGAqk4hzCYpOpuJhttHvcI/3Zh
         T1qUPij85Ht0KtM+udnD1R63XvYvdzuHqliuGAl9DhtVqAQ+pBjUt9yPySMtLVGsg8rh
         oCWw==
X-Received: by 10.112.219.99 with SMTP id pn3mr11919010lbc.24.1385553709879;
        Wed, 27 Nov 2013 04:01:49 -0800 (PST)
Received: from localhost (213-66-41-37-no99.tbcn.telia.com. [213.66.41.37])
        by mx.google.com with ESMTPSA id sd11sm53245297lab.2.2013.11.27.04.01.47
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Nov 2013 04:01:48 -0800 (PST)
X-Mailer: git-send-email 1.8.4.2
In-Reply-To: <1385553659-9928-1-git-send-email-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238422>

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 builtin/grep.c | 69 +++++++++++++++++++++++++++++-----------------------------
 1 file changed, 35 insertions(+), 34 deletions(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index 63f8603..36c2bf0 100644
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
@@ -900,10 +890,21 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
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
1.8.4.2
