From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 18/20] update-index: manually enable or disable untracked cache
Date: Wed,  7 May 2014 21:51:58 +0700
Message-ID: <1399474320-6840-19-git-send-email-pclouds@gmail.com>
References: <1399474320-6840-1-git-send-email-pclouds@gmail.com>
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 07 16:53:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wi3EA-0006QZ-M2
	for gcvg-git-2@plane.gmane.org; Wed, 07 May 2014 16:53:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932879AbaEGOxl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 May 2014 10:53:41 -0400
Received: from mail-pa0-f52.google.com ([209.85.220.52]:51594 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751942AbaEGOxk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 May 2014 10:53:40 -0400
Received: by mail-pa0-f52.google.com with SMTP id kx10so1292491pab.39
        for <git@vger.kernel.org>; Wed, 07 May 2014 07:53:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mJn37ZDzlhA5gKzFKaEC219PAcVdtxcjCHqXFhTRhpU=;
        b=n4vWP2XDSULglrUDS+uJjSHGx4c2Y/DSU522uu8a7Dq1fjTHsV55eFC8HYQsMDLJBP
         0UoBqZ0eTsw1nrJUlY54OSUJ2jhfAs2zgvS7gfCY4gg8t8ui+XCIzCy0ug7umpu4xvI+
         8hOj7Sc2oxnt3bGPy0haZlwQizFBElNj+qivD2ENvorkDRuiVe/1lhrUUC9qLUsWg2T/
         42sowicty+NEWqmrrW7BvXw12M3WDfILmaiFXnVpsS8LQAs+DcGpavk2WOQdRMpR1B5m
         b2gJrlLWtaCE9gwCiiONwL61m2NJcXzTTv76uvpgueOzuCzseMcMjsf5dcZlWhwqqp8y
         oYMw==
X-Received: by 10.66.249.233 with SMTP id yx9mr19933619pac.3.1399474419959;
        Wed, 07 May 2014 07:53:39 -0700 (PDT)
Received: from lanh ([115.73.204.3])
        by mx.google.com with ESMTPSA id tu3sm113512170pab.1.2014.05.07.07.53.37
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 07 May 2014 07:53:39 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Wed, 07 May 2014 21:53:40 +0700
X-Mailer: git-send-email 1.9.1.346.ga2b5940
In-Reply-To: <1399474320-6840-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248323>

Some numbers below. In short, the saving on wt_status_collect_untracked()
is about 80%. There are some overhead on read/write_cache, but it seems
lower than 50ms, while the .._untracked() saving is in the 500ms range
(except linux-2.6, about 150ms). "git status" time saving ranges from
33% to 42%.

On gentoo-x86.git (100k files, 23k dirs, quite balance
tree, 8.5MB index v4, cache-tree fully populated), before turning
untracked cache on (the most important line is wt_status_collect:625)

   184.650 gitmodules_config:201 if (read_cache() < 0) die("index
     0.004 cmd_status:1299 read_cache_preload(&s.pathspec)
   226.231 cmd_status:1300 refresh_index(&the_index, REFRESH_QUIET
     3.096 cmd_status:1304 update_index_if_able(&the_index, &index_lock)
     6.788  wt_status_collect:619 wt_status_collect_changes_worktree(s)
     6.780  wt_status_collect:624 wt_status_collect_changes_index(s)
   772.866  wt_status_collect:625 wt_status_collect_untracked(s)
   786.686 cmd_status:1308 wt_status_collect(&s)

real    0m1.211s
user    0m0.566s
sys     0m0.638s

and after (saving 42% total time):

   220.888 gitmodules_config:201 if (read_cache() < 0) die("index
    36.368 cmd_status:1299 read_cache_preload(&s.pathspec)
   223.936 cmd_status:1300 refresh_index(&the_index, REFRESH_QUIET
     2.935 cmd_status:1304 update_index_if_able(&the_index, &index_lock)
     7.031  wt_status_collect:619 wt_status_collect_changes_worktree(s)
     7.156  wt_status_collect:624 wt_status_collect_changes_index(s)
   148.022  wt_status_collect:625 wt_status_collect_untracked(s)
   162.443 cmd_status:1308 wt_status_collect(&s)
    36.943 cmd_status:1348 if (the_index.untracked) { struct

real    0m0.696s
user    0m0.406s
sys     0m0.288s

On webkit.git (182k files, 6k dirs, 14M index v4), before:

   283.182 gitmodules_config:201 if (read_cache() < 0) die("index
     0.004 cmd_status:1299 read_cache_preload(&s.pathspec)
   515.836 cmd_status:1300 refresh_index(&the_index, REFRESH_QUIET
     5.428 cmd_status:1304 update_index_if_able(&the_index, &index_lock)
    11.162  wt_status_collect:619 wt_status_collect_changes_worktree(s)
    11.068  wt_status_collect:624 wt_status_collect_changes_index(s)
   887.247  wt_status_collect:625 wt_status_collect_untracked(s)
   909.722 cmd_status:1308 wt_status_collect(&s)

real    0m1.729s
user    0m0.785s
sys     0m0.941s

and after (saving 38% total time):

   290.994 gitmodules_config:201 if (read_cache() < 0) die("index
    10.132 cmd_status:1299 read_cache_preload(&s.pathspec)
   516.656 cmd_status:1300 refresh_index(&the_index, REFRESH_QUIET
     5.159 cmd_status:1304 update_index_if_able(&the_index, &index_lock)
    12.605  wt_status_collect:619 wt_status_collect_changes_worktree(s)
    11.262  wt_status_collect:624 wt_status_collect_changes_index(s)
   186.032  wt_status_collect:625 wt_status_collect_untracked(s)
   210.134 cmd_status:1308 wt_status_collect(&s)
    12.332 cmd_status:1348 if (the_index.untracked) { struct index_state

real    0m1.058s
user    0m0.525s
sys     0m0.532s

And linux-2.6 (45k files, 3k dirs, 3.2MB index v4), before:

    68.668 gitmodules_config:201 if (read_cache() < 0) die("index
     0.004 cmd_status:1299 read_cache_preload(&s.pathspec)
   114.270 cmd_status:1300 refresh_index(&the_index, REFRESH_QUIET
     1.180 cmd_status:1304 update_index_if_able(&the_index, &index_lock)
     4.027  wt_status_collect:619 wt_status_collect_changes_worktree(s)
     4.265  wt_status_collect:624 wt_status_collect_changes_index(s)
   191.285  wt_status_collect:625 wt_status_collect_untracked(s)
   199.825 cmd_status:1308 wt_status_collect(&s)

real    0m0.392s
user    0m0.177s
sys     0m0.215s

and after (saving 33%):

    71.756 gitmodules_config:201 if (read_cache() < 0) die("index
     5.201 cmd_status:1299 read_cache_preload(&s.pathspec)
   111.064 cmd_status:1300 refresh_index(&the_index, REFRESH_QUIET
     1.171 cmd_status:1304 update_index_if_able(&the_index, &index_lock)
     3.054  wt_status_collect:619 wt_status_collect_changes_worktree(s)
     4.945  wt_status_collect:624 wt_status_collect_changes_index(s)
    27.203  wt_status_collect:625 wt_status_collect_untracked(s)
    35.475 cmd_status:1308 wt_status_collect(&s)
    25.759 cmd_status:1348 if (the_index.untracked) { struct index_state

real    0m0.259s
user    0m0.106s
sys     0m0.132s
---
 builtin/update-index.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/builtin/update-index.c b/builtin/update-index.c
index ba54e19..003e28e 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -734,6 +734,7 @@ static int reupdate_callback(struct parse_opt_ctx_t *ctx,
 int cmd_update_index(int argc, const char **argv, const char *prefix)
 {
 	int newfd, entries, has_errors = 0, line_termination = '\n';
+	int untracked_cache = -1;
 	int read_from_stdin = 0;
 	int prefix_length = prefix ? strlen(prefix) : 0;
 	int preferred_index_format = 0;
@@ -822,6 +823,8 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 			resolve_undo_clear_callback},
 		OPT_INTEGER(0, "index-version", &preferred_index_format,
 			N_("write index in this format")),
+		OPT_BOOL(0, "untracked-cache", &untracked_cache,
+			N_("enable/disable untracked cache")),
 		OPT_END()
 	};
 
@@ -915,6 +918,20 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 		strbuf_release(&buf);
 	}
 
+	if (untracked_cache > 0) {
+		struct untracked_cache *uc;
+
+		uc = xcalloc(1, sizeof(*uc));
+		uc->exclude_per_dir = ".gitignore";
+		/* should be the same flags used by git-status */
+		uc->dir_flags = DIR_SHOW_OTHER_DIRECTORIES | DIR_HIDE_EMPTY_DIRECTORIES;
+		the_index.untracked = uc;
+		active_cache_changed = 1;
+	} else if (!untracked_cache) {
+		the_index.untracked = NULL;
+		active_cache_changed = 1;
+	}
+
 	if (active_cache_changed) {
 		if (newfd < 0) {
 			if (refresh_args.flags & REFRESH_QUIET)
-- 
1.9.1.346.ga2b5940
