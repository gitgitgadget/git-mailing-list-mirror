From: Edmundo Carmona Antoranz <eantoranz@gmail.com>
Subject: [PATCH v6] checkout: add --progress option
Date: Sun,  1 Nov 2015 14:27:54 -0600
Message-ID: <1446409674-17951-1-git-send-email-eantoranz@gmail.com>
Cc: peff@peff.net, sunshine@sunshineco.com,
	Edmundo Carmona Antoranz <eantoranz@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 01 21:28:10 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZszEX-00026F-OD
	for gcvg-git-2@plane.gmane.org; Sun, 01 Nov 2015 21:28:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753030AbbKAU2G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Nov 2015 15:28:06 -0500
Received: from mail-yk0-f180.google.com ([209.85.160.180]:35407 "EHLO
	mail-yk0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752880AbbKAU2E (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Nov 2015 15:28:04 -0500
Received: by ykek133 with SMTP id k133so122499150yke.2
        for <git@vger.kernel.org>; Sun, 01 Nov 2015 12:28:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=cLvuuLUr5IhaI4uTgXe62WD5Ng5yX2oGt+uMX2O/n/c=;
        b=SsYzhdh5pKYqa1lVsNZ6GZlQvlvBYKmYDgjyDOP9mGMTTrYxpWMZjqnhKbJVKl3CG5
         MRtaUgtpPN7AVXvaT6Os/or5u1x62CUW1XmYk3cCyVnp6kyCvik6fXvOnY7fj70z0wU/
         diNMOOhFBC3ogtPK3kvtrlzDVr5xRt8r+YMBQk/i1yQvrNZ/nrcnZ3/UkVDfHZbr6dJq
         Sw1zyfuIENFTNyjxHRf/gkHnUjNfBxTRCtAfM1vAVWw6CYYJlXWwAoF6+POj5ovV5bN5
         pf1FoKHnrvfymxFmrGAnwcb0vT8mbcZpRXB/EGnOhx59H10hosB/riyqBZOEa3wWK5Ux
         vLDg==
X-Received: by 10.13.244.1 with SMTP id d1mr9751004ywf.84.1446409683055;
        Sun, 01 Nov 2015 12:28:03 -0800 (PST)
Received: from linuxerio.cabletica.com (ip157-11-15-186.ct.co.cr. [186.15.11.157])
        by smtp.gmail.com with ESMTPSA id z14sm11400135ywz.18.2015.11.01.12.28.01
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 01 Nov 2015 12:28:02 -0800 (PST)
X-Mailer: git-send-email 2.6.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280666>

Under normal circumstances, and like other git commands,
git checkout will write progress info to stderr if
attached to a terminal. This option allows progress
to be forced even if not using a terminal. Also,
progress can be skipped if using option --no-progress.

Signed-off-by: Edmundo Carmona Antoranz <eantoranz@gmail.com>
---
 Documentation/git-checkout.txt |  6 ++++++
 builtin/checkout.c             | 14 ++++++++++++--
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkout.txt
index e269fb1..c24c8ee 100644
--- a/Documentation/git-checkout.txt
+++ b/Documentation/git-checkout.txt
@@ -107,6 +107,12 @@ OPTIONS
 --quiet::
 	Quiet, suppress feedback messages.
 
+--[no-]progress::
+	Progress status is reported on the standard error stream
+	by default when it is attached to a terminal, unless --quiet
+	is specified. This flag enables progress reporting even if not
+	attached to a terminal, regardless of -q.
+
 -f::
 --force::
 	When switching branches, proceed even if the index or the
diff --git a/builtin/checkout.c b/builtin/checkout.c
index bc703c0..e346f52 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -37,6 +37,7 @@ struct checkout_opts {
 	int overwrite_ignore;
 	int ignore_skipworktree;
 	int ignore_other_worktrees;
+	int show_progress;
 
 	const char *new_branch;
 	const char *new_branch_force;
@@ -417,7 +418,7 @@ static int reset_tree(struct tree *tree, const struct checkout_opts *o,
 	opts.reset = 1;
 	opts.merge = 1;
 	opts.fn = oneway_merge;
-	opts.verbose_update = !o->quiet && isatty(2);
+	opts.verbose_update = o->show_progress;
 	opts.src_index = &the_index;
 	opts.dst_index = &the_index;
 	parse_tree(tree);
@@ -501,7 +502,7 @@ static int merge_working_tree(const struct checkout_opts *opts,
 		topts.update = 1;
 		topts.merge = 1;
 		topts.gently = opts->merge && old->commit;
-		topts.verbose_update = !opts->quiet && isatty(2);
+		topts.verbose_update = opts->show_progress;
 		topts.fn = twoway_merge;
 		if (opts->overwrite_ignore) {
 			topts.dir = xcalloc(1, sizeof(*topts.dir));
@@ -1156,6 +1157,7 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 				N_("second guess 'git checkout <no-such-branch>'")),
 		OPT_BOOL(0, "ignore-other-worktrees", &opts.ignore_other_worktrees,
 			 N_("do not check if another worktree is holding the given ref")),
+		OPT_BOOL(0, "progress", &opts.show_progress, N_("force progress reporting")),
 		OPT_END(),
 	};
 
@@ -1163,6 +1165,7 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 	memset(&new, 0, sizeof(new));
 	opts.overwrite_ignore = 1;
 	opts.prefix = prefix;
+	opts.show_progress = -1;
 
 	gitmodules_config();
 	git_config(git_checkout_config, &opts);
@@ -1172,6 +1175,13 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 	argc = parse_options(argc, argv, prefix, options, checkout_usage,
 			     PARSE_OPT_KEEP_DASHDASH);
 
+	if (opts.show_progress < 0) {
+		if (opts.quiet)
+			opts.show_progress = 0;
+		else
+			opts.show_progress = isatty(2);
+	}
+
 	if (conflict_style) {
 		opts.merge = 1; /* implied */
 		git_xmerge_config("merge.conflictstyle", conflict_style, NULL);
-- 
2.6.1
