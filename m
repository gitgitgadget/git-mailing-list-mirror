From: Koosha Khajehmoogahi <koosha@posteo.de>
Subject: [PATCH] [RFC] Add a new config. option for skipping merges in git-log
Date: Mon, 16 Mar 2015 16:27:14 +0100
Message-ID: <5506F652.7050700@posteo.de>
References: <5506E751.8010506@posteo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Mar 16 16:28:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YXWw8-0003VC-SG
	for gcvg-git-2@plane.gmane.org; Mon, 16 Mar 2015 16:28:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965795AbbCPP2I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Mar 2015 11:28:08 -0400
Received: from mx02.posteo.de ([89.146.194.165]:59300 "EHLO mx02.posteo.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934320AbbCPP2F (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Mar 2015 11:28:05 -0400
Received: from dovecot03.posteo.de (unknown [185.67.36.28])
	by mx02.posteo.de (Postfix) with ESMTPS id 87D879D8EE0
	for <git@vger.kernel.org>; Mon, 16 Mar 2015 16:28:04 +0100 (CET)
Received: from mail.posteo.de (localhost [127.0.0.1])
	by dovecot03.posteo.de (Postfix) with ESMTPSA id 3l5M2r2wt3z5vNS
	for <git@vger.kernel.org>; Mon, 16 Mar 2015 16:28:04 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.5.0
In-Reply-To: <5506E751.8010506@posteo.de>
X-Forwarded-Message-Id: <5506E751.8010506@posteo.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265566>


This patch adds a 'showmerges' config. option for git-log.
This option determines whether the log should contain merge
commits or not. In essence, if this option is set to false,
git-log will be run as 'git-log --no-merges'.

To force git-log to show merges even if 'log.showmerges' is
set, we use --include-merges command line option.

Signed-off-by: Koosha Khajehmoogahi <koosha@posteo.de>
---
 Documentation/config.txt | 3 +++
 builtin/log.c            | 9 +++++++++
 revision.c               | 2 ++
 revision.h               | 1 +
 4 files changed, 15 insertions(+)

This is the second time I send this patch as it seems it didn't
get delivered even after one hour!

Please help me with this patch. It seems that my --include-merges
command-line option does not have have any effect on the behavior
of git-log. I don't know why the value of force_show_merges is
always 0!

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 1530255..7775b8c 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1735,6 +1735,9 @@ log.showroot::
 	Tools like linkgit:git-log[1] or linkgit:git-whatchanged[1], which
 	normally hide the root commit will now show it. True by default.
 
+log.showmerges::
+	If true, merges will be shown in the log list. True by default.
+
 log.mailmap::
 	If true, makes linkgit:git-log[1], linkgit:git-show[1], and
 	linkgit:git-whatchanged[1] assume `--use-mailmap`.
diff --git a/builtin/log.c b/builtin/log.c
index dd8f3fc..867bcf2 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -31,6 +31,7 @@ static const char *default_date_mode = NULL;
 
 static int default_abbrev_commit;
 static int default_show_root = 1;
+static int default_max_parents = -1;
 static int decoration_style;
 static int decoration_given;
 static int use_mailmap_config;
@@ -108,6 +109,8 @@ static void cmd_log_init_defaults(struct rev_info *rev)
 	rev->diffopt.stat_graph_width = -1; /* respect statGraphWidth config */
 	rev->abbrev_commit = default_abbrev_commit;
 	rev->show_root_diff = default_show_root;
+	if (rev->force_show_merges == 0)
+		rev->max_parents = default_max_parents;
 	rev->subject_prefix = fmt_patch_subject_prefix;
 	DIFF_OPT_SET(&rev->diffopt, ALLOW_TEXTCONV);
 
@@ -390,6 +393,12 @@ static int git_log_config(const char *var, const char *value, void *cb)
 		default_show_root = git_config_bool(var, value);
 		return 0;
 	}
+
+	if (!strcmp(var, "log.showmerges")) {
+		default_max_parents = git_config_bool(var, value) ? -1 : 1;
+		return 0;
+	}
+
 	if (skip_prefix(var, "color.decorate.", &slot_name))
 		return parse_decorate_color_config(var, slot_name, value);
 	if (!strcmp(var, "log.mailmap")) {
diff --git a/revision.c b/revision.c
index 66520c6..e7073b8 100644
--- a/revision.c
+++ b/revision.c
@@ -1804,6 +1804,8 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 		revs->min_parents = 2;
 	} else if (!strcmp(arg, "--no-merges")) {
 		revs->max_parents = 1;
+	} else if (!strcmp(arg, "--include-merges")) {
+		revs->force_show_merges = 1;
 	} else if (starts_with(arg, "--min-parents=")) {
 		revs->min_parents = atoi(arg+14);
 	} else if (starts_with(arg, "--no-min-parents")) {
diff --git a/revision.h b/revision.h
index 0ea8b4e..f496472 100644
--- a/revision.h
+++ b/revision.h
@@ -145,6 +145,7 @@ struct rev_info {
 	unsigned int	track_linear:1,
 			track_first_time:1,
 			linear:1;
+	unsigned int force_show_merges:1;
 
 	enum date_mode date_mode;
 
-- 
1.9.1
