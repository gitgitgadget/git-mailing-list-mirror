From: David Turner <dturner@twopensource.com>
Subject: [PATCH v3] log: add log.follow config option
Date: Tue,  7 Jul 2015 21:29:34 -0400
Message-ID: <1436318974-16250-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 08 03:30:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZCeBV-00073i-0C
	for gcvg-git-2@plane.gmane.org; Wed, 08 Jul 2015 03:30:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757708AbbGHB35 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jul 2015 21:29:57 -0400
Received: from mail-qk0-f177.google.com ([209.85.220.177]:36459 "EHLO
	mail-qk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757074AbbGHB34 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jul 2015 21:29:56 -0400
Received: by qkei195 with SMTP id i195so153340303qke.3
        for <git@vger.kernel.org>; Tue, 07 Jul 2015 18:29:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Ud+/yZ9KWAotvkqK6tUoKN2CGQDPmUAyoymiTRJZu8E=;
        b=hsdACp02INytSg69junp6uuUx+ZfvTPilcJoJAHNuq2nL6o74ws1oFWAonXtAzc71a
         Vi6l3d3uC0r4yPJxL6exvvBZMuY0XC7k9y2hAV4h+lOhFVVHkLjYm4zm4TQ/HIpe+cOL
         7txe2ghSYCO3ayqPqRSx7qFKbR31mT6WBPpL6Q5nHX83lhI2D4K9jQFpBdofcTZtXlMI
         gFhnrbdOL+bGY9aM/0Pd8M40nI3RVgXy4rs099EnGO3gXBQvx0RxaLhypqajfdRmAYpd
         qXbds+RqiZfi+0zbDfYP/bw++8IemgkF736Xza90lN6XEFK8oECPWQbSzc5t4A6njytr
         Q6JA==
X-Gm-Message-State: ALoCoQnjyoOijWIiNJ02jQKpkHrrmSVNu7xbeblu9illsZDVYqXztfxojn3WRQ0z+AbsNC69WvWM
X-Received: by 10.55.18.82 with SMTP id c79mr12037035qkh.18.1436318995216;
        Tue, 07 Jul 2015 18:29:55 -0700 (PDT)
Received: from ubuntu.jfk4.office.twttr.net ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id g81sm338608qhc.8.2015.07.07.18.29.53
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 07 Jul 2015 18:29:54 -0700 (PDT)
X-Mailer: git-send-email 2.0.5.499.g01f6352.dirty-twtrsrc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273631>

Many users prefer to always use --follow with logs.  Rather than
aliasing the command, an option might be more convenient for some.

Signed-off-by: David Turner <dturner@twopensource.com>
---
 Documentation/git-log.txt |  6 ++++++
 builtin/log.c             |  7 +++++++
 diff.c                    |  5 +++--
 diff.h                    |  1 +
 revision.c                | 17 +++++++++++------
 t/t4202-log.sh            | 23 +++++++++++++++++++++++
 6 files changed, 51 insertions(+), 8 deletions(-)

diff --git a/Documentation/git-log.txt b/Documentation/git-log.txt
index 5692945..79bf4d4 100644
--- a/Documentation/git-log.txt
+++ b/Documentation/git-log.txt
@@ -184,6 +184,12 @@ log.date::
 	`--date` option.)  Defaults to "default", which means to write
 	dates like `Sat May 8 19:35:34 2010 -0500`.
 
+log.follow::
+	If a single file argument is given to git log, it will act as
+	if the `--follow` option was also used.  This has the same
+	limitations as `--follow`, i.e. it cannot be used to follow
+	multiple files and does not work well on non-linear history.
+
 log.showRoot::
 	If `false`, `git log` and related commands will not treat the
 	initial commit as a big creation event.  Any root commits in
diff --git a/builtin/log.c b/builtin/log.c
index 8781049..6a068f7 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -31,6 +31,7 @@ static const char *default_date_mode = NULL;
 
 static int default_abbrev_commit;
 static int default_show_root = 1;
+static int default_follow;
 static int decoration_style;
 static int decoration_given;
 static int use_mailmap_config;
@@ -102,6 +103,8 @@ static void cmd_log_init_defaults(struct rev_info *rev)
 {
 	if (fmt_pretty)
 		get_commit_format(fmt_pretty, rev);
+	if (default_follow)
+		DIFF_OPT_SET(&rev->diffopt, DEFAULT_FOLLOW_RENAMES);
 	rev->verbose_header = 1;
 	DIFF_OPT_SET(&rev->diffopt, RECURSIVE);
 	rev->diffopt.stat_width = -1; /* use full terminal width */
@@ -390,6 +393,10 @@ static int git_log_config(const char *var, const char *value, void *cb)
 		default_show_root = git_config_bool(var, value);
 		return 0;
 	}
+	if (!strcmp(var, "log.follow")) {
+		default_follow = git_config_bool(var, value);
+		return 0;
+	}
 	if (skip_prefix(var, "color.decorate.", &slot_name))
 		return parse_decorate_color_config(var, slot_name, value);
 	if (!strcmp(var, "log.mailmap")) {
diff --git a/diff.c b/diff.c
index 87b16d5..135b222 100644
--- a/diff.c
+++ b/diff.c
@@ -3815,9 +3815,10 @@ int diff_opt_parse(struct diff_options *options, const char **av, int ac)
 		DIFF_OPT_SET(options, FIND_COPIES_HARDER);
 	else if (!strcmp(arg, "--follow"))
 		DIFF_OPT_SET(options, FOLLOW_RENAMES);
-	else if (!strcmp(arg, "--no-follow"))
+	else if (!strcmp(arg, "--no-follow")) {
 		DIFF_OPT_CLR(options, FOLLOW_RENAMES);
-	else if (!strcmp(arg, "--color"))
+		DIFF_OPT_CLR(options, DEFAULT_FOLLOW_RENAMES);
+	} else if (!strcmp(arg, "--color"))
 		options->use_color = 1;
 	else if (skip_prefix(arg, "--color=", &arg)) {
 		int value = git_config_colorbool(NULL, arg);
diff --git a/diff.h b/diff.h
index c7ad42a..f7208ad 100644
--- a/diff.h
+++ b/diff.h
@@ -91,6 +91,7 @@ typedef struct strbuf *(*diff_prefix_fn_t)(struct diff_options *opt, void *data)
 #define DIFF_OPT_DIRSTAT_BY_LINE     (1 << 28)
 #define DIFF_OPT_FUNCCONTEXT         (1 << 29)
 #define DIFF_OPT_PICKAXE_IGNORE_CASE (1 << 30)
+#define DIFF_OPT_DEFAULT_FOLLOW_RENAMES (1 << 31)
 
 #define DIFF_OPT_TST(opts, flag)    ((opts)->flags & DIFF_OPT_##flag)
 #define DIFF_OPT_TOUCHED(opts, flag)    ((opts)->touched_flags & DIFF_OPT_##flag)
diff --git a/revision.c b/revision.c
index 3ff8723..7c1931b 100644
--- a/revision.c
+++ b/revision.c
@@ -2311,15 +2311,13 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
 	if (revs->diffopt.output_format & ~DIFF_FORMAT_NO_OUTPUT)
 		revs->diff = 1;
 
-	/* Pickaxe, diff-filter and rename following need diffs */
-	if (revs->diffopt.pickaxe ||
-	    revs->diffopt.filter ||
-	    DIFF_OPT_TST(&revs->diffopt, FOLLOW_RENAMES))
-		revs->diff = 1;
-
 	if (revs->topo_order)
 		revs->limited = 1;
 
+	if (DIFF_OPT_TST(&revs->diffopt, DEFAULT_FOLLOW_RENAMES) &&
+	    revs->prune_data.nr == 1)
+		DIFF_OPT_SET(&revs->diffopt, FOLLOW_RENAMES);
+
 	if (revs->prune_data.nr) {
 		copy_pathspec(&revs->pruning.pathspec, &revs->prune_data);
 		/* Can't prune commits with rename following: the paths change.. */
@@ -2329,6 +2327,13 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
 			copy_pathspec(&revs->diffopt.pathspec,
 				      &revs->prune_data);
 	}
+
+	/* Pickaxe, diff-filter and rename following need diffs */
+	if (revs->diffopt.pickaxe ||
+	    revs->diffopt.filter ||
+	    DIFF_OPT_TST(&revs->diffopt, FOLLOW_RENAMES))
+		revs->diff = 1;
+
 	if (revs->combine_merges)
 		revs->ignore_merges = 0;
 	revs->diffopt.abbrev = revs->abbrev;
diff --git a/t/t4202-log.sh b/t/t4202-log.sh
index 1b2e981..dbabbc3 100755
--- a/t/t4202-log.sh
+++ b/t/t4202-log.sh
@@ -146,7 +146,30 @@ test_expect_success 'git log --follow' '
 	actual=$(git log --follow --pretty="format:%s" ichi) &&
 	expect=$(echo third ; echo second ; echo initial) &&
 	verbose test "$actual" = "$expect"
+'
+
+test_expect_success 'git config log.follow works like --follow' '
+	test_config log.follow true &&
+	actual=$(git log --pretty="format:%s" ichi) &&
+	expect=$(echo third ; echo second ; echo initial) &&
+	verbose test "$actual" = "$expect"
+'
 
+test_expect_success 'git config log.follow does not die with multiple paths' '
+	test_config log.follow true &&
+	git log --pretty="format:%s" ichi ein
+'
+
+test_expect_success 'git config log.follow does not die with no paths' '
+	test_config log.follow true &&
+	git log --
+'
+
+test_expect_success  'git config log.follow is overridden by --no-follow' '
+	test_config log.follow true &&
+	actual=$(git log --no-follow --pretty="format:%s" ichi) &&
+	expect="third" &&
+	verbose test "$actual" = "$expect"
 '
 
 cat > expect << EOF
-- 
2.0.5.499.g01f6352.dirty-twtrsrc
