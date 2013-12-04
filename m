From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: [RFC/WIP PATCH 3/4] teach add -f option for ignored submodules
Date: Wed, 4 Dec 2013 23:21:56 +0100
Message-ID: <20131204222156.GD7326@sandbox-ub>
References: <528FC638.5060403@web.de>
 <20131122215454.GA4952@sandbox-ub>
 <20131122220953.GI4212@google.com>
 <52910BC4.1030800@web.de>
 <20131124005256.GA3500@sandbox-ub>
 <52922962.3090407@web.de>
 <CAErtv2729o-xf=49xY06aVL1ZJzJpeH+cc_Pd1cAP52r32Ss_g@mail.gmail.com>
 <20131125174945.GA3847@sandbox-ub>
 <CAErtv259jxCtvbJYZHgQZv-VJ9U+JwNzWo0tn007SDTCCBScrA@mail.gmail.com>
 <20131204221659.GA7326@sandbox-ub>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Sergey Sharybin <sergey.vfx@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 04 23:22:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VoKpZ-0000dz-MA
	for gcvg-git-2@plane.gmane.org; Wed, 04 Dec 2013 23:22:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756101Ab3LDWWA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Dec 2013 17:22:00 -0500
Received: from smtprelay03.ispgateway.de ([80.67.31.30]:53662 "EHLO
	smtprelay03.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754748Ab3LDWV7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Dec 2013 17:21:59 -0500
Received: from [77.21.76.49] (helo=sandbox-ub)
	by smtprelay03.ispgateway.de with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.68)
	(envelope-from <hvoigt@hvoigt.net>)
	id 1VoKpS-0007eM-7O; Wed, 04 Dec 2013 23:21:58 +0100
Content-Disposition: inline
In-Reply-To: <20131204221659.GA7326@sandbox-ub>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238819>

When the user wants to bypass the ignored status configured by
submodule.<name>.ignore=all it is now allowed by using the -f option.

Signed-off-by: Heiko Voigt <hvoigt@hvoigt.net>
---
 builtin/add.c | 49 +++++++++++++++++++++++++++++++++++++------------
 submodule.c   | 10 ++++++++++
 submodule.h   |  1 +
 3 files changed, 48 insertions(+), 12 deletions(-)

diff --git a/builtin/add.c b/builtin/add.c
index 2d0d2ef..d6cab7f 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -16,6 +16,7 @@
 #include "revision.h"
 #include "bulk-checkin.h"
 #include "submodule.h"
+#include "string-list.h"
 
 static const char * const builtin_add_usage[] = {
 	N_("git add [options] [--] <pathspec>..."),
@@ -37,6 +38,20 @@ struct update_callback_data {
 static const char *option_with_implicit_dot;
 static const char *short_option_with_implicit_dot;
 
+static struct lock_file lock_file;
+
+static const char ignore_error[] =
+N_("The following paths are ignored by one of your .gitignore files:\n");
+static const char submodule_ignore_error[] =
+N_("The following paths are ignored submodules:\n");
+
+static int verbose, show_only, ignored_too, refresh_only;
+static int ignore_add_errors, intent_to_add, ignore_missing;
+
+#define ADDREMOVE_DEFAULT 0 /* Change to 1 in Git 2.0 */
+static int addremove = ADDREMOVE_DEFAULT;
+static int addremove_explicit = -1; /* unspecified */
+
 static void warn_pathless_add(void)
 {
 	static int shown;
@@ -140,6 +155,9 @@ static void update_callback(struct diff_queue_struct *q,
 			warn_pathless_add();
 			continue;
 		}
+		if (is_ignored_submodule(path) && !ignored_too)
+			continue;
+
 		switch (fix_unmerged_status(p, data)) {
 		default:
 			die(_("unexpected diff status %c"), p->status);
@@ -174,6 +192,7 @@ static void update_files_in_cache(const char *prefix,
 	struct rev_info rev;
 
 	init_revisions(&rev, prefix);
+	enforce_no_complete_ignore_submodule(&rev.diffopt);
 	setup_revisions(0, NULL, &rev, NULL);
 	if (pathspec)
 		copy_pathspec(&rev.prune_data, pathspec);
@@ -332,18 +351,6 @@ static int edit_patch(int argc, const char **argv, const char *prefix)
 	return 0;
 }
 
-static struct lock_file lock_file;
-
-static const char ignore_error[] =
-N_("The following paths are ignored by one of your .gitignore files:\n");
-
-static int verbose, show_only, ignored_too, refresh_only;
-static int ignore_add_errors, intent_to_add, ignore_missing;
-
-#define ADDREMOVE_DEFAULT 0 /* Change to 1 in Git 2.0 */
-static int addremove = ADDREMOVE_DEFAULT;
-static int addremove_explicit = -1; /* unspecified */
-
 static int ignore_removal_cb(const struct option *opt, const char *arg, int unset)
 {
 	/* if we are told to ignore, we are not adding removals */
@@ -407,6 +414,17 @@ static int add_files(struct dir_struct *dir, int flags)
 	return exit_status;
 }
 
+static void die_ignored_submodules(struct string_list *ignored_submodules)
+{
+	struct string_list_item *path;
+
+	fprintf(stderr, _(submodule_ignore_error));
+	for_each_string_list_item(path, ignored_submodules)
+		fprintf(stderr, "%s\n", path->string);
+	fprintf(stderr, _("Use -f if you really want to add them.\n"));
+	die(_("no files added"));
+}
+
 int cmd_add(int argc, const char **argv, const char *prefix)
 {
 	int exit_status = 0;
@@ -419,6 +437,7 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 	char *seen = NULL;
 	int implicit_dot = 0;
 	struct update_callback_data update_data;
+	struct string_list ignored_submodules = STRING_LIST_INIT_NODUP;
 
 	gitmodules_config();
 	git_config(add_config, NULL);
@@ -550,6 +569,7 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 
 		for (i = 0; i < pathspec.nr; i++) {
 			const char *path = pathspec.items[i].match;
+			char path_copy[PATH_MAX];
 			if (!seen[i] &&
 			    ((pathspec.items[i].magic &
 			      (PATHSPEC_GLOB | PATHSPEC_ICASE)) ||
@@ -562,6 +582,9 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 					die(_("pathspec '%s' did not match any files"),
 					    pathspec.items[i].original);
 			}
+			normalize_path_copy(path_copy, path);
+			if (is_ignored_submodule(path_copy))
+				string_list_insert(&ignored_submodules, path);
 		}
 		free(seen);
 	}
@@ -583,6 +606,8 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 	update_files_in_cache(prefix, &pathspec, &update_data);
 
 	exit_status |= !!update_data.add_errors;
+	if (!ignored_too && ignored_submodules.nr)
+		die_ignored_submodules(&ignored_submodules);
 	if (add_new_files)
 		exit_status |= add_files(&dir, flags);
 
diff --git a/submodule.c b/submodule.c
index e0719b6..c28a926 100644
--- a/submodule.c
+++ b/submodule.c
@@ -199,6 +199,16 @@ void set_diffopt_flags_from_submodule_config(struct diff_options *diffopt,
 	}
 }
 
+int is_ignored_submodule(const char *path)
+{
+	struct diff_options diffopt;
+	memset(&diffopt, 0, sizeof(diffopt));
+	set_diffopt_flags_from_submodule_config(&diffopt, path);
+	if (DIFF_OPT_TST(&diffopt, IGNORE_SUBMODULES))
+		return 1;
+	return 0;
+}
+
 int submodule_config(const char *var, const char *value, void *cb)
 {
 	if (!prefixcmp(var, "submodule."))
diff --git a/submodule.h b/submodule.h
index 2c8087e..e067580 100644
--- a/submodule.h
+++ b/submodule.h
@@ -17,6 +17,7 @@ int remove_path_from_gitmodules(const char *path);
 void stage_updated_gitmodules(void);
 void set_diffopt_flags_from_submodule_config(struct diff_options *diffopt,
 		const char *path);
+int is_ignored_submodule(const char *path);
 int submodule_config(const char *var, const char *value, void *cb);
 void gitmodules_config(void);
 int parse_submodule_config_option(const char *var, const char *value);
-- 
1.8.5.1.43.gf00fb86
