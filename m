From: David Turner <dturner@twopensource.com>
Subject: [PATCH v7 01/33] setup: call setup_git_directory_gently before accessing refs
Date: Mon, 29 Feb 2016 19:52:34 -0500
Message-ID: <1456793586-22082-2-git-send-email-dturner@twopensource.com>
References: <1456793586-22082-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, peff@peff.net, mhagger@alum.mit.edu,
	pclouds@gmail.com
X-From: git-owner@vger.kernel.org Tue Mar 01 01:53:34 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aaYZA-0006sP-O2
	for gcvg-git-2@plane.gmane.org; Tue, 01 Mar 2016 01:53:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752499AbcCAAxa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Feb 2016 19:53:30 -0500
Received: from mail-qg0-f43.google.com ([209.85.192.43]:36011 "EHLO
	mail-qg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751350AbcCAAx1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Feb 2016 19:53:27 -0500
Received: by mail-qg0-f43.google.com with SMTP id u110so1408626qge.3
        for <git@vger.kernel.org>; Mon, 29 Feb 2016 16:53:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Xx/UPF+LoPlq0UWBJO7dGUlXMBe3orx+YMMGBRDmnNY=;
        b=AELm+B7ea4j5Wse9anfOiM5tG5P4QHQXjDro3ZRRqb/K0qCbAXcvomsZdT4CRYWOZy
         FABb2OMC/3cefBRmo6MPrLWePFBWwEgv/IOScU/zE9Mug6/URZBVHtRqpxaZtgkT39LF
         hCUV9dj4T1zR5Ab/VjPateoZRywUBa5FmStf4uFZ787hQbHM57Mtu8B4LQZ3wbYRhKiL
         qaLJHr4rsa0iEWe/cCRcqYqZpdYHgm7EOMoNXAz/dgfmX7KHAQ3z5Wxg/SJvF9SBwfrJ
         MV/dp4T9ib/BOc1dPejpJi8Z3/eRK1+UjOgP44AW8r0Lfa5CgGOA7PM8DPwoD6uMoauQ
         a/5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Xx/UPF+LoPlq0UWBJO7dGUlXMBe3orx+YMMGBRDmnNY=;
        b=LvhnkW3lYzWb+lNPz0LXPXTX1BRfhHk3TFSOfHJJWQTZE+KTLEfJE/ZwKmCnugpf1n
         IDlWOgA38r0bDHZLN1KKvfR1hqF83JocLP+Sztzp1+/p5RuwXfeHlRAHDmGzmNbFzu6E
         qSWUdtmnsqn8r8pE7M4RvASIHj10F22iJ6/C+5Gt/aX2W6ZYI90m48WEjqxMk8HxZ3b7
         Nj4jcm7n9xeyPFPq6IyvysXho1Ep33bdIKpUHm8nw2b4Q1h9kZsQ+itYFWFGcT1yw86m
         KnQH/RYAhKtw2tNu2qIa0LmhRc++fWliSNmxoNhCFszB7V6384vkeqU/zL57YEjEZ5yQ
         h0GQ==
X-Gm-Message-State: AD7BkJIc/aYP4HCAIHT6wKYTa1Cu8HZMUEPbPWakGYhGwm6PPRGWUJgx8e54PTnwhH6dfg==
X-Received: by 10.140.99.72 with SMTP id p66mr23070217qge.16.1456793605838;
        Mon, 29 Feb 2016 16:53:25 -0800 (PST)
Received: from ubuntu.twitter.biz ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id z62sm12094715qka.26.2016.02.29.16.53.24
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 29 Feb 2016 16:53:24 -0800 (PST)
X-Mailer: git-send-email 2.4.2.767.g62658d5-twtrsrc
In-Reply-To: <1456793586-22082-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287945>

Usually, git calls some form of setup_git_directory at startup.  But
sometimes, it doesn't.  Usually, that's OK because it's not really
using the repository.  But in some cases, it is using the repo.  In
those cases, either setup_git_directory_gently must be called, or the
repository (e.g. the refs) must not be accessed.

In every case except grep and shortlog, we fix this problem by making
the call.

In grep, in the --no-index mode, we don't want to access repository,
so we set a flag which prevents this.

In shortlog, we only want to skip accessing the repository when
running without a repo (in stdin mode), so we check that before
calling the only repo-dependent function that doesn't do its own
setup.

Suggested-by: Jeff King <peff@peff.net>
Signed-off-by: David Turner <dturner@twopensource.com>
---
 builtin/grep.c          | 1 +
 builtin/log.c           | 2 +-
 builtin/shortlog.c      | 7 ++++---
 git.c                   | 2 +-
 shortlog.h              | 2 +-
 test-match-trees.c      | 2 ++
 test-revision-walking.c | 2 ++
 7 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index 9e3f1cf..1e36b52 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -531,6 +531,7 @@ static int grep_directory(struct grep_opt *opt, const struct pathspec *pathspec,
 	if (exc_std)
 		setup_standard_excludes(&dir);
 
+	dir.flags |= DIR_NO_GITLINKS;
 	fill_directory(&dir, pathspec);
 	for (i = 0; i < dir.nr; i++) {
 		if (!dir_path_match(dir.entries[i], pathspec, 0, NULL))
diff --git a/builtin/log.c b/builtin/log.c
index 0d738d6..1d0e43e 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -975,7 +975,7 @@ static void make_cover_letter(struct rev_info *rev, int use_stdout,
 
 	strbuf_release(&sb);
 
-	shortlog_init(&log);
+	shortlog_init(&log, 0);
 	log.wrap_lines = 1;
 	log.wrap = 72;
 	log.in1 = 2;
diff --git a/builtin/shortlog.c b/builtin/shortlog.c
index bfc082e..ab4305b 100644
--- a/builtin/shortlog.c
+++ b/builtin/shortlog.c
@@ -219,11 +219,12 @@ static int parse_wrap_args(const struct option *opt, const char *arg, int unset)
 	return 0;
 }
 
-void shortlog_init(struct shortlog *log)
+void shortlog_init(struct shortlog *log, int nongit)
 {
 	memset(log, 0, sizeof(*log));
 
-	read_mailmap(&log->mailmap, &log->common_repo_prefix);
+	if (!nongit)
+		read_mailmap(&log->mailmap, &log->common_repo_prefix);
 
 	log->list.strdup_strings = 1;
 	log->wrap = DEFAULT_WRAPLEN;
@@ -252,7 +253,7 @@ int cmd_shortlog(int argc, const char **argv, const char *prefix)
 	struct parse_opt_ctx_t ctx;
 
 	git_config(git_default_config, NULL);
-	shortlog_init(&log);
+	shortlog_init(&log, nongit);
 	init_revisions(&rev, prefix);
 	parse_options_start(&ctx, argc, argv, prefix, options,
 			    PARSE_OPT_KEEP_DASHDASH | PARSE_OPT_KEEP_ARGV0);
diff --git a/git.c b/git.c
index 6cc0c07..51e0508 100644
--- a/git.c
+++ b/git.c
@@ -376,7 +376,7 @@ static struct cmd_struct commands[] = {
 	{ "am", cmd_am, RUN_SETUP | NEED_WORK_TREE },
 	{ "annotate", cmd_annotate, RUN_SETUP },
 	{ "apply", cmd_apply, RUN_SETUP_GENTLY },
-	{ "archive", cmd_archive },
+	{ "archive", cmd_archive, RUN_SETUP_GENTLY },
 	{ "bisect--helper", cmd_bisect__helper, RUN_SETUP },
 	{ "blame", cmd_blame, RUN_SETUP },
 	{ "branch", cmd_branch, RUN_SETUP },
diff --git a/shortlog.h b/shortlog.h
index de4f86f..ed1fbca 100644
--- a/shortlog.h
+++ b/shortlog.h
@@ -19,7 +19,7 @@ struct shortlog {
 	struct string_list mailmap;
 };
 
-void shortlog_init(struct shortlog *log);
+void shortlog_init(struct shortlog *log, int nongit);
 
 void shortlog_add_commit(struct shortlog *log, struct commit *commit);
 
diff --git a/test-match-trees.c b/test-match-trees.c
index 109f03e..4dad709 100644
--- a/test-match-trees.c
+++ b/test-match-trees.c
@@ -6,6 +6,8 @@ int main(int ac, char **av)
 	unsigned char hash1[20], hash2[20], shifted[20];
 	struct tree *one, *two;
 
+	setup_git_directory();
+
 	if (get_sha1(av[1], hash1))
 		die("cannot parse %s as an object name", av[1]);
 	if (get_sha1(av[2], hash2))
diff --git a/test-revision-walking.c b/test-revision-walking.c
index 285f06b..3d03133 100644
--- a/test-revision-walking.c
+++ b/test-revision-walking.c
@@ -50,6 +50,8 @@ int main(int argc, char **argv)
 	if (argc < 2)
 		return 1;
 
+	setup_git_directory();
+
 	if (!strcmp(argv[1], "run-twice")) {
 		printf("1st\n");
 		if (!run_revision_walk())
-- 
2.4.2.767.g62658d5-twtrsrc
