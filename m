Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CD76D20195
	for <e@80x24.org>; Tue, 19 Jul 2016 22:13:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752538AbcGSWNa (ORCPT <rfc822;e@80x24.org>);
	Tue, 19 Jul 2016 18:13:30 -0400
Received: from siwi.pair.com ([209.68.5.199]:20791 "EHLO siwi.pair.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752529AbcGSWN3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jul 2016 18:13:29 -0400
Received: from jeffhost-linux1.corp.microsoft.com (unknown [167.220.148.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by siwi.pair.com (Postfix) with ESMTPSA id 5BC028463F;
	Tue, 19 Jul 2016 18:13:28 -0400 (EDT)
From:	Jeff Hostetler <jeffhost@microsoft.com>
To:	git@vger.kernel.org
Cc:	peff@peff.net, gitster@pobox.com, jeffhost@microsoft.com
Subject: [PATCH v1 1/6] Allow --porcelain[=<n>] in status and commit commands
Date:	Tue, 19 Jul 2016 18:10:53 -0400
Message-Id: <1468966258-11191-2-git-send-email-jeffhost@microsoft.com>
X-Mailer: git-send-email 2.8.0.rc4.17.gac42084.dirty
In-Reply-To: <1468966258-11191-1-git-send-email-jeffhost@microsoft.com>
References: <1468966258-11191-1-git-send-email-jeffhost@microsoft.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Update the --porcelain argument to take an optional
version number.  This will allow us to define new
porcelain formats in the future.

This default to 1 and represents the existing porcelain
format.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 Documentation/git-commit.txt |  2 +-
 Documentation/git-status.txt |  7 +++++--
 builtin/commit.c             | 40 +++++++++++++++++++++++++++-------------
 wt-status.h                  | 10 ++++++++++
 4 files changed, 43 insertions(+), 16 deletions(-)

diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
index b0a294d..0791573 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -104,7 +104,7 @@ OPTIONS
 --branch::
 	Show the branch and tracking info even in short-format.
 
---porcelain::
+--porcelain[=<version>]::
 	When doing a dry-run, give the output in a porcelain-ready
 	format. See linkgit:git-status[1] for details. Implies
 	`--dry-run`.
diff --git a/Documentation/git-status.txt b/Documentation/git-status.txt
index e1e8f57..de97729 100644
--- a/Documentation/git-status.txt
+++ b/Documentation/git-status.txt
@@ -32,11 +32,14 @@ OPTIONS
 --branch::
 	Show the branch and tracking info even in short-format.
 
---porcelain::
+--porcelain[=<version>]::
 	Give the output in an easy-to-parse format for scripts.
 	This is similar to the short output, but will remain stable
 	across Git versions and regardless of user configuration. See
 	below for details.
++
+The version parameter is used to specify the format version.
+This is optional and defaults to the original version '1' format.
 
 --long::
 	Give the output in the long-format. This is the default.
@@ -96,7 +99,7 @@ configuration variable documented in linkgit:git-config[1].
 
 -z::
 	Terminate entries with NUL, instead of LF.  This implies
-	the `--porcelain` output format if no other format is given.
+	the `--porcelain=1` output format if no other format is given.
 
 --column[=<options>]::
 --no-column::
diff --git a/builtin/commit.c b/builtin/commit.c
index 1f6dbcd..892d7f7 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -142,14 +142,24 @@ static int show_ignored_in_status, have_option_m;
 static const char *only_include_assumed;
 static struct strbuf message = STRBUF_INIT;
 
-static enum status_format {
-	STATUS_FORMAT_NONE = 0,
-	STATUS_FORMAT_LONG,
-	STATUS_FORMAT_SHORT,
-	STATUS_FORMAT_PORCELAIN,
+static enum wt_status_format status_format = STATUS_FORMAT_UNSPECIFIED;
 
-	STATUS_FORMAT_UNSPECIFIED
-} status_format = STATUS_FORMAT_UNSPECIFIED;
+static int opt_parse_porcelain(const struct option *opt, const char *arg, int unset)
+{
+	enum wt_status_format *value = (enum wt_status_format *)opt->value;
+	if (unset) {
+		*value = STATUS_FORMAT_UNSPECIFIED;
+	} else if (arg) {
+		int n = strtol(arg, NULL, 10);
+		if (n == 1)
+			*value = STATUS_FORMAT_PORCELAIN;
+		else
+			die("unsupported porcelain version");
+	} else {
+		*value = STATUS_FORMAT_PORCELAIN;
+	}
+	return 0;
+}
 
 static int opt_parse_m(const struct option *opt, const char *arg, int unset)
 {
@@ -500,6 +510,7 @@ static int run_status(FILE *fp, const char *index_file, const char *prefix, int
 	s->fp = fp;
 	s->nowarn = nowarn;
 	s->is_initial = get_sha1(s->reference, sha1) ? 1 : 0;
+	s->status_format = status_format;
 
 	wt_status_collect(s);
 
@@ -1099,7 +1110,7 @@ static const char *read_commit_message(const char *name)
  * is not in effect here.
  */
 static struct status_deferred_config {
-	enum status_format status_format;
+	enum wt_status_format status_format;
 	int show_branch;
 } status_deferred_config = {
 	STATUS_FORMAT_UNSPECIFIED,
@@ -1336,9 +1347,9 @@ int cmd_status(int argc, const char **argv, const char *prefix)
 			    N_("show status concisely"), STATUS_FORMAT_SHORT),
 		OPT_BOOL('b', "branch", &s.show_branch,
 			 N_("show branch information")),
-		OPT_SET_INT(0, "porcelain", &status_format,
-			    N_("machine-readable output"),
-			    STATUS_FORMAT_PORCELAIN),
+		{ OPTION_CALLBACK, 0, "porcelain", &status_format,
+		  N_("version"), N_("machine-readable output"),
+		  PARSE_OPT_OPTARG, opt_parse_porcelain },
 		OPT_SET_INT(0, "long", &status_format,
 			    N_("show status in long format (default)"),
 			    STATUS_FORMAT_LONG),
@@ -1381,6 +1392,8 @@ int cmd_status(int argc, const char **argv, const char *prefix)
 
 	s.is_initial = get_sha1(s.reference, sha1) ? 1 : 0;
 	s.ignore_submodule_arg = ignore_submodule_arg;
+	s.status_format = status_format;
+
 	wt_status_collect(&s);
 
 	if (0 <= fd)
@@ -1622,8 +1635,9 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 		OPT_SET_INT(0, "short", &status_format, N_("show status concisely"),
 			    STATUS_FORMAT_SHORT),
 		OPT_BOOL(0, "branch", &s.show_branch, N_("show branch information")),
-		OPT_SET_INT(0, "porcelain", &status_format,
-			    N_("machine-readable output"), STATUS_FORMAT_PORCELAIN),
+		{ OPTION_CALLBACK, 0, "porcelain", &status_format,
+		  N_("version"), N_("machine-readable output"),
+		  PARSE_OPT_OPTARG, opt_parse_porcelain },
 		OPT_SET_INT(0, "long", &status_format,
 			    N_("show status in long format (default)"),
 			    STATUS_FORMAT_LONG),
diff --git a/wt-status.h b/wt-status.h
index 2ca93f6..fc80341 100644
--- a/wt-status.h
+++ b/wt-status.h
@@ -43,6 +43,15 @@ struct wt_status_change_data {
 	unsigned new_submodule_commits : 1;
 };
 
+ enum wt_status_format {
+	STATUS_FORMAT_NONE = 0,
+	STATUS_FORMAT_LONG,
+	STATUS_FORMAT_SHORT,
+	STATUS_FORMAT_PORCELAIN,
+
+	STATUS_FORMAT_UNSPECIFIED
+ };
+
 struct wt_status {
 	int is_initial;
 	char *branch;
@@ -66,6 +75,7 @@ struct wt_status {
 	int show_branch;
 	int hints;
 
+	enum wt_status_format status_format;
 	/* These are computed during processing of the individual sections */
 	int commitable;
 	int workdir_dirty;
-- 
2.8.0.rc4.17.gac42084.dirty

