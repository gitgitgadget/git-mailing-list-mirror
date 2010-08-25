From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] checkout: respect diff.ignoreSubmodules setting
Date: Wed, 25 Aug 2010 12:34:57 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.1008251225200.4020@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, gitster@pobox.com
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Wed Aug 25 12:35:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OoDK1-0002Ec-Kc
	for gcvg-git-2@lo.gmane.org; Wed, 25 Aug 2010 12:35:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753358Ab0HYKfD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Aug 2010 06:35:03 -0400
Received: from mailout-de.gmx.net ([213.165.64.22]:59254 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S1753110Ab0HYKfB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Aug 2010 06:35:01 -0400
Received: (qmail invoked by alias); 25 Aug 2010 10:34:58 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp002) with SMTP; 25 Aug 2010 12:34:58 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/TvlAeWVnTql5hR7fd+R1fdkAMf+rvHlxBMMPS7h
	7bGSpQCVeIummR
X-X-Sender: schindel@intel-tinevez-2-302
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154438>


When 'git checkout' reports uncommitted changes, it also does so for
submodules.

The default mode is now to look really hard into submodules, not only
for different commits, but also for modified files. Since this can be
pretty expensive when there are a lot (and large) submodules, there is
the diff.ignoreSubmodules option.

Let's respect that setting when 'git checkout' reports the uncommitted
changes, since it does nothing else than a 'git diff --name-status'.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/checkout.c |   16 ++++++++++++----
 1 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index ff5ac1e..19c23b2 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -18,6 +18,7 @@
 #include "xdiff-interface.h"
 #include "ll-merge.h"
 #include "resolve-undo.h"
+#include "submodule.h"
 
 static const char * const checkout_usage[] = {
 	"git checkout [options] <branch>",
@@ -40,6 +41,7 @@ struct checkout_opts {
 	const char *new_orphan_branch;
 	int new_branch_log;
 	enum branch_track track;
+	struct diff_options diff_options;
 };
 
 static int post_checkout_hook(struct commit *old, struct commit *new,
@@ -282,11 +284,12 @@ static int checkout_paths(struct tree *source_tree, const char **pathspec,
 	return errs;
 }
 
-static void show_local_changes(struct object *head)
+static void show_local_changes(struct object *head, struct diff_options *opts)
 {
 	struct rev_info rev;
 	/* I think we want full paths, even if we're in a subdirectory. */
 	init_revisions(&rev, NULL);
+	rev.diffopt.flags = opts->flags;
 	rev.diffopt.output_format |= DIFF_FORMAT_NAME_STATUS;
 	if (diff_setup_done(&rev.diffopt) < 0)
 		die("diff_setup_done failed");
@@ -471,7 +474,7 @@ static int merge_working_tree(struct checkout_opts *opts,
 		die("unable to write new index file");
 
 	if (!opts->force && !opts->quiet)
-		show_local_changes(&new->commit->object);
+		show_local_changes(&new->commit->object, &opts->diff_options);
 
 	return 0;
 }
@@ -619,7 +622,12 @@ static int switch_branches(struct checkout_opts *opts, struct branch_info *new)
 
 static int git_checkout_config(const char *var, const char *value, void *cb)
 {
-	return git_xmerge_config(var, value, cb);
+	if (!strcmp(var, "diff.ignoresubmodules")) {
+		struct checkout_opts *opts = cb;
+		handle_ignore_submodules_arg(&opts->diff_options, value);
+		return 0;
+	}
+	return git_xmerge_config(var, value, NULL);
 }
 
 static int interactive_checkout(const char *revision, const char **pathspec,
@@ -703,7 +711,7 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 	memset(&opts, 0, sizeof(opts));
 	memset(&new, 0, sizeof(new));
 
-	git_config(git_checkout_config, NULL);
+	git_config(git_checkout_config, &opts);
 
 	opts.track = BRANCH_TRACK_UNSPECIFIED;
 
-- 
1.7.2.2.485.gf3638.dirty
