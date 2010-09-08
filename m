From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 2/5] merge: Make '--log' an integer option for number of shortlog entries
Date: Wed,  8 Sep 2010 23:29:54 +0530
Message-ID: <1283968797-31793-3-git-send-email-artagnon@gmail.com>
References: <1283968797-31793-1-git-send-email-artagnon@gmail.com>
Cc: Git Mailing List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 08 20:03:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OtOz3-0001BB-Gl
	for gcvg-git-2@lo.gmane.org; Wed, 08 Sep 2010 20:02:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752194Ab0IHSCR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Sep 2010 14:02:17 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:50851 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752076Ab0IHSCN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Sep 2010 14:02:13 -0400
Received: by mail-iw0-f174.google.com with SMTP id 5so195346iwn.19
        for <git@vger.kernel.org>; Wed, 08 Sep 2010 11:02:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=NXtroJT6Y++WERAwZJOY1PEs/LZyqt/9uYMpng3+rf8=;
        b=DcCTNxL1KxZD1RpMpzmz0ha19YgEKCpXatqKXrEpHSXkmQFb2cUQt2eVDkQYkpQJQ0
         FSes10Kqh8yl6152hH4WtsbdvnkKp+8/2fi2lbMnye47iOkw+hjSk8D5Hqmy5q3kiHm3
         GSLGPGnd9s/EjllfKf5JM6/EyR1THJTrdhjag=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=BQ3jnSs9ORa32ZPUzwfF+sZkDAUsHOJwJ9wfojywzAEdx+JnpmKaqmJcyV77M7jb2H
         zcd2suANRyez74CRCU6ckmEWyWQXbhLwxsaTN7dGo0EXsT92rq+a9cCWN1vbgLQKRDQz
         x3dDFMZcWM+LbvXNv9q2u/FUn9SUE+AT1+nTA=
Received: by 10.231.15.9 with SMTP id i9mr71797iba.58.1283968932852;
        Wed, 08 Sep 2010 11:02:12 -0700 (PDT)
Received: from localhost.localdomain ([203.110.240.41])
        by mx.google.com with ESMTPS id z6sm199616ibc.12.2010.09.08.11.02.08
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 08 Sep 2010 11:02:11 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.2.409.gdbb11.dirty
In-Reply-To: <1283968797-31793-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155804>

Change the command-line '--log' option from a boolean option to an
integer option, and parse the optional integer provided on the
command-line into the 'shortlog_len' variable. Also update the
documentation accordingly.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
Reported-by: Yaroslav Halchenko <debian@onerussian.com>
Thanks-to: Jonathan Nieder <jrnieder@gmail.com>
Thanks-to: Johannes Sixt <j.sixt@viscovery.net>
---
 Documentation/git-fmt-merge-msg.txt |   10 ++++++----
 Documentation/merge-options.txt     |    6 +++---
 builtin/fmt-merge-msg.c             |   28 ++++++++++++++++++----------
 builtin/merge.c                     |   17 ++++++++++-------
 4 files changed, 37 insertions(+), 24 deletions(-)

diff --git a/Documentation/git-fmt-merge-msg.txt b/Documentation/git-fmt-merge-msg.txt
index 302f56b..f04a9ff 100644
--- a/Documentation/git-fmt-merge-msg.txt
+++ b/Documentation/git-fmt-merge-msg.txt
@@ -9,8 +9,8 @@ git-fmt-merge-msg - Produce a merge commit message
 SYNOPSIS
 --------
 [verse]
-'git fmt-merge-msg' [-m <message>] [--log | --no-log] <$GIT_DIR/FETCH_HEAD
-'git fmt-merge-msg' [-m <message>] [--log | --no-log] -F <file>
+'git fmt-merge-msg' [-m <message>] [--log[=<n>] | --no-log] <$GIT_DIR/FETCH_HEAD
+'git fmt-merge-msg' [-m <message>] [--log[=<n>] | --no-log] -F <file>
 
 DESCRIPTION
 -----------
@@ -24,10 +24,12 @@ automatically invoking 'git merge'.
 OPTIONS
 -------
 
---log::
+--log[=<n>]::
 	In addition to branch names, populate the log message with
 	one-line descriptions from the actual commits that are being
-	merged.
+	merged.  At most <n> commits from each merge parent will be
+	used (20 if <n> is omitted).  This overrides the `merge.log`
+	configuration variable.
 
 --no-log::
 	Do not list one-line descriptions from the actual commits being
diff --git a/Documentation/merge-options.txt b/Documentation/merge-options.txt
index 722d704..e33e0f8 100644
--- a/Documentation/merge-options.txt
+++ b/Documentation/merge-options.txt
@@ -16,11 +16,11 @@ inspect and further tweak the merge result before committing.
 With --no-ff Generate a merge commit even if the merge
 resolved as a fast-forward.
 
---log::
+--log[=<n>]::
 --no-log::
 	In addition to branch names, populate the log message with
-	one-line descriptions from the actual commits that are being
-	merged.
+	one-line descriptions from at most <n> actual commits that are being
+	merged. See also linkgit:git-fmt-merge-msg[1].
 +
 With --no-log do not list one-line descriptions from the
 actual commits being merged.
diff --git a/builtin/fmt-merge-msg.c b/builtin/fmt-merge-msg.c
index 42021d3..455e7c6 100644
--- a/builtin/fmt-merge-msg.c
+++ b/builtin/fmt-merge-msg.c
@@ -7,21 +7,24 @@
 #include "string-list.h"
 
 static const char * const fmt_merge_msg_usage[] = {
-	"git fmt-merge-msg [-m <message>] [--log|--no-log] [--file <file>]",
+	"git fmt-merge-msg [-m <message>] [--log[=<n>]|--no-log] [--file <file>]",
 	NULL
 };
 
-static int merge_summary;
+static int shortlog_len;
 
 static int fmt_merge_msg_config(const char *key, const char *value, void *cb)
 {
 	static int found_merge_log = 0;
 	if (!strcmp("merge.log", key)) {
 		found_merge_log = 1;
-		merge_summary = git_config_bool(key, value);
+		shortlog_len = git_config_bool(key, value) ? DEFAULT_MERGE_LOG_LEN : 0;
+		return 0;
+	}
+	if (!found_merge_log && !strcmp("merge.summary", key)) {
+		shortlog_len = git_config_bool(key, value) ? DEFAULT_MERGE_LOG_LEN : 0;
+		return 0;
 	}
-	if (!found_merge_log && !strcmp("merge.summary", key))
-		merge_summary = git_config_bool(key, value);
 	return 0;
 }
 
@@ -318,10 +321,13 @@ int cmd_fmt_merge_msg(int argc, const char **argv, const char *prefix)
 	const char *inpath = NULL;
 	const char *message = NULL;
 	struct option options[] = {
-		OPT_BOOLEAN(0, "log",     &merge_summary, "populate log with the shortlog"),
-		{ OPTION_BOOLEAN, 0, "summary", &merge_summary, NULL,
+		{ OPTION_INTEGER, 0, "log", &shortlog_len, "n",
+		  "populate log with at most <n> entries from shortlog",
+		  PARSE_OPT_OPTARG, NULL, DEFAULT_MERGE_LOG_LEN },
+		{ OPTION_INTEGER, 0, "summary", &shortlog_len, "n",
 		  "alias for --log (deprecated)",
-		  PARSE_OPT_NOARG | PARSE_OPT_HIDDEN },
+		  PARSE_OPT_OPTARG | PARSE_OPT_HIDDEN, NULL,
+		  DEFAULT_MERGE_LOG_LEN },
 		OPT_STRING('m', "message", &message, "text",
 			"use <text> as start of message"),
 		OPT_FILENAME('F', "file", &inpath, "file to read from"),
@@ -337,12 +343,14 @@ int cmd_fmt_merge_msg(int argc, const char **argv, const char *prefix)
 			     0);
 	if (argc > 0)
 		usage_with_options(fmt_merge_msg_usage, options);
-	if (message && !merge_summary) {
+	if (message && !shortlog_len) {
 		char nl = '\n';
 		write_in_full(STDOUT_FILENO, message, strlen(message));
 		write_in_full(STDOUT_FILENO, &nl, 1);
 		return 0;
 	}
+	if (shortlog_len < 0)
+		die("Negative --log=%d", shortlog_len);
 
 	if (inpath && strcmp(inpath, "-")) {
 		in = fopen(inpath, "r");
@@ -357,7 +365,7 @@ int cmd_fmt_merge_msg(int argc, const char **argv, const char *prefix)
 		strbuf_addstr(&output, message);
 	ret = fmt_merge_msg(&input, &output,
 			    message ? 0 : 1,
-			    merge_summary ? DEFAULT_MERGE_LOG_LEN : 0);
+			    shortlog_len);
 
 	if (ret)
 		return ret;
diff --git a/builtin/merge.c b/builtin/merge.c
index b2c0984..9e4733d 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -42,7 +42,7 @@ static const char * const builtin_merge_usage[] = {
 	NULL
 };
 
-static int show_diffstat = 1, option_log, squash;
+static int show_diffstat = 1, shortlog_len, squash;
 static int option_commit = 1, allow_fast_forward = 1;
 static int fast_forward_only;
 static int allow_trivial = 1, have_message;
@@ -175,8 +175,9 @@ static struct option builtin_merge_options[] = {
 	OPT_BOOLEAN(0, "stat", &show_diffstat,
 		"show a diffstat at the end of the merge"),
 	OPT_BOOLEAN(0, "summary", &show_diffstat, "(synonym to --stat)"),
-	OPT_BOOLEAN(0, "log", &option_log,
-		"add list of one-line log to merge commit message"),
+	{ OPTION_INTEGER, 0, "log", &shortlog_len, "n",
+	  "add (at most <n>) entries from shortlog to merge commit message",
+	  PARSE_OPT_OPTARG, NULL, DEFAULT_MERGE_LOG_LEN },
 	OPT_BOOLEAN(0, "squash", &squash,
 		"create a single commit instead of doing a merge"),
 	OPT_BOOLEAN(0, "commit", &option_commit,
@@ -501,8 +502,10 @@ static int git_merge_config(const char *k, const char *v, void *cb)
 		return git_config_string(&pull_twohead, k, v);
 	else if (!strcmp(k, "pull.octopus"))
 		return git_config_string(&pull_octopus, k, v);
-	else if (!strcmp(k, "merge.log") || !strcmp(k, "merge.summary"))
-		option_log = git_config_bool(k, v);
+	else if (!strcmp(k, "merge.log") || !strcmp(k, "merge.summary")) {
+		shortlog_len = git_config_bool(k, v) ? DEFAULT_MERGE_LOG_LEN : 0;
+		return 0;
+	}
 	return git_diff_ui_config(k, v, cb);
 }
 
@@ -998,9 +1001,9 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 		for (i = 0; i < argc; i++)
 			merge_name(argv[i], &merge_names);
 
-		if (!have_message || option_log) {
+		if (!have_message || shortlog_len) {
 			fmt_merge_msg(&merge_names, &merge_msg, !have_message,
-				      option_log ? DEFAULT_MERGE_LOG_LEN : 0);
+				      shortlog_len);
 			if (merge_msg.len)
 				strbuf_setlen(&merge_msg, merge_msg.len - 1);
 		}
-- 
1.7.2.2.409.gdbb11.dirty
