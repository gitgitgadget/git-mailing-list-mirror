From: David Turner <dturner@twopensource.com>
Subject: [PATCH v4] log: add log.follow config option
Date: Wed,  8 Jul 2015 13:42:01 -0400
Message-ID: <1436377321-8495-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Jul 08 19:47:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZCtMb-0008Nn-4r
	for gcvg-git-2@plane.gmane.org; Wed, 08 Jul 2015 19:42:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759319AbbGHRmZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jul 2015 13:42:25 -0400
Received: from mail-qk0-f172.google.com ([209.85.220.172]:35931 "EHLO
	mail-qk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758378AbbGHRmX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jul 2015 13:42:23 -0400
Received: by qkei195 with SMTP id i195so168405245qke.3
        for <git@vger.kernel.org>; Wed, 08 Jul 2015 10:42:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=AmbXp355KxSedogrj3wApmWR6jB+8ZOhP/BMiXLm+VI=;
        b=QRFgP6t1MwQQeUaWsadaMpOV1obGgvkfvaYAlK7Lvt0dvhfF0izoH6eB+Rzse0HWHg
         2Ydqzf8+S4wuBbW7AeuzYyPWpi8jkpoqF0t2nYjuc1+83RQzb122/pYCtGYl51HADU2K
         mo0cle7mXBZwwOw7aEtZwAPDk1hVKUmRO7+jOdgcvzeV9LajhoWUhkBvNJ7n7l6EDvRL
         JkXkscS2eQ99wQapF8ptGl5qQ8YKfCf0VU/tfOxm3kW5K8Jyl/Jkg/YRMw/u2aUpR6uu
         HiT+c+hazJ46qHf7OFHxyby3rwehdHTGJki0+LP3to4F1NduwwylPmu/5g3RmGS+ZTSV
         GfsA==
X-Gm-Message-State: ALoCoQlO2/O2SFR5h6YXRftJldMyGYk3JcrR7ibVUx+4xzYTKIOVok30m6CyDHF67UUcFL+C/b7c
X-Received: by 10.140.233.22 with SMTP id e22mr18042455qhc.67.1436377342816;
        Wed, 08 Jul 2015 10:42:22 -0700 (PDT)
Received: from ubuntu.jfk4.office.twttr.net ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id 66sm1488447qkr.47.2015.07.08.10.42.21
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 08 Jul 2015 10:42:21 -0700 (PDT)
X-Mailer: git-send-email 2.0.5.499.g01f6352.dirty-twtrsrc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273696>

This version uses tweak, and also includes Matthieu Moy's suggested
whitespace fix.

---
Many users prefer to always use --follow with logs.  Rather than
aliasing the command, an option might be more convenient for some.

Junio C Hamano <gitster@pobox.com> suggested using the tweak
functionality for this, which is much nicer than what I had before.

Signed-off-by: David Turner <dturner@twopensource.com>
---
 Documentation/git-log.txt |  6 ++++++
 builtin/log.c             | 16 ++++++++++++++++
 diff.c                    |  5 +++--
 diff.h                    |  1 +
 t/t4202-log.sh            | 23 +++++++++++++++++++++++
 5 files changed, 49 insertions(+), 2 deletions(-)

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
index 8781049..d06248a 100644
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
@@ -618,6 +625,14 @@ int cmd_log_reflog(int argc, const char **argv, const char *prefix)
 	return cmd_log_walk(&rev);
 }
 
+static void default_follow_tweak(struct rev_info *rev,
+				 struct setup_revision_opt *opt)
+{
+	if (DIFF_OPT_TST(&rev->diffopt, DEFAULT_FOLLOW_RENAMES) &&
+	    rev->prune_data.nr == 1)
+		DIFF_OPT_SET(&rev->diffopt, FOLLOW_RENAMES);
+}
+
 int cmd_log(int argc, const char **argv, const char *prefix)
 {
 	struct rev_info rev;
@@ -631,6 +646,7 @@ int cmd_log(int argc, const char **argv, const char *prefix)
 	memset(&opt, 0, sizeof(opt));
 	opt.def = "HEAD";
 	opt.revarg_opt = REVARG_COMMITTISH;
+	opt.tweak = default_follow_tweak;
 	cmd_log_init(argc, argv, prefix, &rev, &opt);
 	return cmd_log_walk(&rev);
 }
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
diff --git a/t/t4202-log.sh b/t/t4202-log.sh
index 1b2e981..35d2d7c 100755
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
+test_expect_success 'git config log.follow is overridden by --no-follow' '
+	test_config log.follow true &&
+	actual=$(git log --no-follow --pretty="format:%s" ichi) &&
+	expect="third" &&
+	verbose test "$actual" = "$expect"
 '
 
 cat > expect << EOF
-- 
2.0.5.499.g01f6352.dirty-twtrsrc
