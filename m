From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 4/6] add -u: only show pathless 'add -u' warning when changes
 exist outside cwd
Date: Tue, 19 Mar 2013 15:50:50 -0700
Message-ID: <20130319225050.GE19014@google.com>
References: <1362786889-28688-1-git-send-email-gitster@pobox.com>
 <20130319224400.GA19014@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Jeff King <peff@peff.net>, git@vger.kernel.org,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 19 23:51:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UI5NM-0003bh-4n
	for gcvg-git-2@plane.gmane.org; Tue, 19 Mar 2013 23:51:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934376Ab3CSWu4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Mar 2013 18:50:56 -0400
Received: from mail-pb0-f51.google.com ([209.85.160.51]:62431 "EHLO
	mail-pb0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934117Ab3CSWuz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Mar 2013 18:50:55 -0400
Received: by mail-pb0-f51.google.com with SMTP id un15so812363pbc.10
        for <git@vger.kernel.org>; Tue, 19 Mar 2013 15:50:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=Bb4dPAsNJW79hzlCVSOnQJljfeODUsUIeP1Id7NVnro=;
        b=GTR7IJYooZivckk1ZY27N6cgjEhhVS0EXDvgV9MU21Ds4vP0w+eb6LxExJJIk+HSiK
         flDjkrWrvvCI+dyjcQ3nT96N9QMeDQhCHzZ49iFzkKTrRBWM2RCDv3LeXPZj/CEt4VNn
         BxKqwDgLiwWj08Airn9UhdPR+fAwm1fszorUSX1E+koWHRhaRxpUlZEKI9v0LuUXkgMl
         e9gmp1Y9ijyas65bYM3vQnaWnnkNca9HPYAaw+J/MCyk+0EH09ORGdhfPRWAqdvjzfml
         Q3WNycsSzI+wW1H5I9NqmYYdFdqUp1cAIgPh2OkEhXKoukLZ89w8t65UEQDlrfh3tvg9
         PdoQ==
X-Received: by 10.68.231.70 with SMTP id te6mr5633635pbc.159.1363733455103;
        Tue, 19 Mar 2013 15:50:55 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPS id zv3sm14251700pab.0.2013.03.19.15.50.52
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 19 Mar 2013 15:50:53 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20130319224400.GA19014@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218564>

A common workflow in large projects is to chdir into a subdirectory of
interest and only do work there:

	cd src
	vi foo.c
	make test
	git add -u
	git commit

The upcoming change to 'git add -u' behavior would not affect such a
workflow: when the only changes present are in the current directory,
'git add -u' will add all changes, and whether that happens via an
implicit "." or implicit ":/" parameter is an unimportant
implementation detail.

The warning about use of 'git add -u' with no pathspec is annoying
because it seemingly serves no purpose in this case.  So suppress the
warning unless there are changes outside the cwd that are not being
added.

A previous version of this patch ran two I/O-intensive diff-files
passes: one to find changes outside the cwd, and another to find
changes to add to the index within the cwd.  This version runs one
full-tree diff and decides for each change whether to add it or warn
and suppress it in update_callback.  As a result, even on very large
repositories "git add -u" will not be significantly slower than the
future default behavior ("git add -u :/"), and the slowdown relative
to "git add -u ." should be a useful clue to users of such
repositories to get into the habit of explicitly passing '.'.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Acked-by: Jeff King <peff@peff.net>
Improved-by: Junio C Hamano <gitster@pobox.com>
---
This is the interesting one.

Changes since v1:
 * run only one diff-files pass, as explained in the log message
 * use strncmp_icase, not match_pathspec, to check if paths are
   under cwd
 * expand log message with performance implications
 * summarized Peff's review with an Ack.  I hope that's ok.

Thanks for your help getting this into good shape.

 builtin/add.c | 43 +++++++++++++++++++++++++++++++++++++++----
 1 file changed, 39 insertions(+), 4 deletions(-)

diff --git a/builtin/add.c b/builtin/add.c
index a424e69..4d8d441 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -26,6 +26,8 @@ static int take_worktree_changes;
 struct update_callback_data {
 	int flags;
 	int add_errors;
+	const char *implicit_dot;
+	size_t implicit_dot_len;
 };
 
 static const char *option_with_implicit_dot;
@@ -94,10 +96,27 @@ static void update_callback(struct diff_queue_struct *q,
 {
 	int i;
 	struct update_callback_data *data = cbdata;
+	const char *implicit_dot = data->implicit_dot;
+	size_t implicit_dot_len = data->implicit_dot_len;
 
 	for (i = 0; i < q->nr; i++) {
 		struct diff_filepair *p = q->queue[i];
 		const char *path = p->one->path;
+
+		/*
+		 * Check if "git add -A" or "git add -u" was run from a
+		 * subdirectory with a modified file outside that directory,
+		 * and warn if so.
+		 *
+		 * "git add -u" will behave like "git add -u :/" instead of
+		 * "git add -u ." in the future.  This warning prepares for
+		 * that change.
+		 */
+		if (implicit_dot &&
+		    strncmp_icase(path, implicit_dot, implicit_dot_len)) {
+			warn_pathless_add();
+			continue;
+		}
 		switch (fix_unmerged_status(p, data)) {
 		default:
 			die(_("unexpected diff status %c"), p->status);
@@ -121,17 +140,30 @@ static void update_callback(struct diff_queue_struct *q,
 	}
 }
 
+#define ADD_CACHE_IMPLICIT_DOT 32
 int add_files_to_cache(const char *prefix, const char **pathspec, int flags)
 {
 	struct update_callback_data data;
 	struct rev_info rev;
+
+	memset(&data, 0, sizeof(data));
+	data.flags = flags & ~ADD_CACHE_IMPLICIT_DOT;
+	if ((flags & ADD_CACHE_IMPLICIT_DOT) && prefix) {
+		/*
+		 * Check for modified files throughout the worktree so
+		 * update_callback has a chance to warn about changes
+		 * outside the cwd.
+		 */
+		data.implicit_dot = prefix;
+		data.implicit_dot_len = strlen(prefix);
+		pathspec = NULL;
+	}
+
 	init_revisions(&rev, prefix);
 	setup_revisions(0, NULL, &rev, NULL);
 	init_pathspec(&rev.prune_data, pathspec);
 	rev.diffopt.output_format = DIFF_FORMAT_CALLBACK;
 	rev.diffopt.format_callback = update_callback;
-	data.flags = flags;
-	data.add_errors = 0;
 	rev.diffopt.format_callback_data = &data;
 	rev.max_count = 0; /* do not compare unmerged paths with stage #2 */
 	run_diff_files(&rev, DIFF_RACY_IS_MODIFIED);
@@ -371,6 +403,7 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 	int add_new_files;
 	int require_pathspec;
 	char *seen = NULL;
+	int implicit_dot = 0;
 
 	git_config(add_config, NULL);
 
@@ -400,10 +433,11 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 	}
 	if (option_with_implicit_dot && !argc) {
 		static const char *here[2] = { ".", NULL };
-		if (prefix)
+		if (prefix && addremove)
 			warn_pathless_add();
 		argc = 1;
 		argv = here;
+		implicit_dot = 1;
 	}
 
 	add_new_files = !take_worktree_changes && !refresh_only;
@@ -416,7 +450,8 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 		 (intent_to_add ? ADD_CACHE_INTENT : 0) |
 		 (ignore_add_errors ? ADD_CACHE_IGNORE_ERRORS : 0) |
 		 (!(addremove || take_worktree_changes)
-		  ? ADD_CACHE_IGNORE_REMOVAL : 0));
+		  ? ADD_CACHE_IGNORE_REMOVAL : 0)) |
+		 (implicit_dot ? ADD_CACHE_IMPLICIT_DOT : 0);
 
 	if (require_pathspec && argc == 0) {
 		fprintf(stderr, _("Nothing specified, nothing added.\n"));
-- 
1.8.2.rc3
