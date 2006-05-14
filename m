From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH 5/5] diff: parse U/u/unified options with an optional integer arg
Date: Sun, 14 May 2006 08:19:22 -0700
Message-ID: <11476199631085-git-send-email-normalperson@yhbt.net>
References: <11476199622462-git-send-email-normalperson@yhbt.net>
Reply-To: Eric Wong <normalperson@yhbt.net>
Cc: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Sun May 14 17:19:53 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FfINk-0004pX-OV
	for gcvg-git@gmane.org; Sun, 14 May 2006 17:19:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751451AbWENPTc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 14 May 2006 11:19:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751454AbWENPTb
	(ORCPT <rfc822;git-outgoing>); Sun, 14 May 2006 11:19:31 -0400
Received: from hand.yhbt.net ([66.150.188.102]:413 "EHLO hand.yhbt.net")
	by vger.kernel.org with ESMTP id S1751451AbWENPTY (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 14 May 2006 11:19:24 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id DF07A7DC020;
	Sun, 14 May 2006 08:19:23 -0700 (PDT)
To: git@vger.kernel.org
X-Mailer: git-send-email 1.3.2.ge3d7
In-Reply-To: <11476199622462-git-send-email-normalperson@yhbt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19966>

Looks like Linus and I both think GIT_DIFF_OPTS="--unified=5" is
silly, but it still continues to work.

This was originally bundled into my first series gitopt patches,
and now Linus has a more correct/complete one that affects
combine-diff and works with uppercase -U  This patch
combines the Linus one with my gitopt version.

-u (lowercase) now accepts an optional arg, like -U (GNU diff
-u also has this behavior).

This uses the built-in gitopt parsers to do optional
integer argument handling.

Signed-off-by: Eric Wong <normalperson@yhbt.net>

---

 combine-diff.c |    1 +
 diff.c         |   11 ++++++++---
 diff.h         |    1 +
 3 files changed, 10 insertions(+), 3 deletions(-)

102e3227de7c7f08a69096d5094ee31128bf9819
diff --git a/combine-diff.c b/combine-diff.c
index 8a8fe38..64b20cc 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -608,6 +608,7 @@ static int show_patch_diff(struct combin
 	int abbrev = opt->full_index ? 40 : DEFAULT_ABBREV;
 	mmfile_t result_file;
 
+	context = opt->context;
 	/* Read the result of merge first */
 	if (!working_tree_file)
 		result = grab_blob(elem->sha1, &result_size);
diff --git a/diff.c b/diff.c
index 7d88dc5..6ee612f 100644
--- a/diff.c
+++ b/diff.c
@@ -15,7 +15,7 @@ #include "gitopt.h"
 static int diff_scoreopt_parse(const int id, const char *opt);
 
 enum diff_ost_ids {
-	opt_p = GITOPT_DIFF_BASE, opt_raw, opt_patch_with_raw,
+	opt_u = GITOPT_DIFF_BASE, opt_p, opt_raw, opt_patch_with_raw,
 	opt_stat, opt_patch_with_stat,
 	opt_z, opt_l, opt_full_index, opt_name_only, opt_name_status,
 	opt_R, opt_S, opt_s, opt_O, opt_diff_filter,
@@ -26,7 +26,8 @@ enum diff_ost_ids {
 
 const struct opt_spec diff_ost[] = {
 	{ 0,			'p',	0,	0,	opt_p },
-	{ "unified",		'u',	0,	0,	opt_p },
+	{ "unified",		'u',	0,	ARG_OPTINT,	opt_u },
+	{ 0,			'U',	0,	ARG_OPTINT,	opt_u },
 	{ "raw",		0,	0,	0,	opt_raw },
 	{ "patch-with-raw",	0,	0,	0,	opt_patch_with_raw },
 	{ "stat",		0,	0,	0,	opt_stat },
@@ -600,7 +601,7 @@ static void builtin_diff(const char *nam
 
 		ecbdata.label_path = lbl;
 		xpp.flags = XDF_NEED_MINIMAL;
-		xecfg.ctxlen = 3;
+		xecfg.ctxlen = o->context;
 		xecfg.flags = XDL_EMIT_FUNCNAMES;
 		if (!diffopts)
 			;
@@ -1224,6 +1225,7 @@ void diff_setup(struct diff_options *opt
 	options->line_termination = '\n';
 	options->break_opt = -1;
 	options->rename_limit = -1;
+	options->context = 3;
 
 	options->change = diff_change;
 	options->add_remove = diff_addremove;
@@ -1269,6 +1271,9 @@ int diff_opt_handler(struct gitopt_itera
 	struct diff_options *options = (struct diff_options *)args;
 
 	switch (id) {
+	case opt_u:
+		if (gi->ea->argc > 1)
+			options->context = strtol(gi->ea->argv[1], NULL, 10);
 	case opt_p:
 		options->output_format = DIFF_FORMAT_PATCH;
 		break;
diff --git a/diff.h b/diff.h
index fa44d1b..b9d7573 100644
--- a/diff.h
+++ b/diff.h
@@ -33,6 +33,7 @@ struct diff_options {
 		 full_index:1,
 		 silent_on_remove:1,
 		 find_copies_harder:1;
+	int context;
 	int break_opt;
 	int detect_rename;
 	int line_termination;
-- 
1.3.2.g102e322
