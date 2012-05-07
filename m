From: Jeff King <peff@peff.net>
Subject: [PATCH 2/5] status: refactor colopts handling
Date: Mon, 7 May 2012 17:23:33 -0400
Message-ID: <20120507212333.GB19567@sigill.intra.peff.net>
References: <20120507212125.GA19532@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	git@vger.kernel.org, Zak Johnson <zakj@nox.cx>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 07 23:23:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SRVPA-00078T-8p
	for gcvg-git-2@plane.gmane.org; Mon, 07 May 2012 23:23:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932243Ab2EGVXg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 May 2012 17:23:36 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:33246
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757696Ab2EGVXf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 May 2012 17:23:35 -0400
Received: (qmail 27428 invoked by uid 107); 7 May 2012 21:23:53 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 07 May 2012 17:23:53 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 07 May 2012 17:23:33 -0400
Content-Disposition: inline
In-Reply-To: <20120507212125.GA19532@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197310>

The current code reads the config and command-line options
into a separate "colopts" variable, and then copies the
contents of that variable into the "struct wt_status". We
can eliminate the extra variable and copy just write
straight into the wt_status struct.

This simplifies the "status" code a little bit.
Unfortunately, it makes the "commit" code one line more
complex; a side effect of the separate variable was that
"commit" did not copy the colopts variable, so any
column.status configuration had no effect.

The result still ends up cleaner, though. In the previous
version, it was unclear whether commit simply forgot to copy
the colopt variable, or whether it was intentional. Now it
explicitly turns off column options. Furthermore, if commit
later learns to respect column.status, this will make the
end result simpler. I punted on just adding that feature
now, because it was sufficiently non-obvious that it should
not go into a refactoring patch.

Signed-off-by: Jeff King <peff@peff.net>
---
For the reasons mentioned above, this ended up as a less impressive
cleanup than I had hoped. I think it's still worth doing, but I won't be
too sad if it gets dropped.

 builtin/commit.c | 13 ++++++-------
 wt-status.h      |  2 +-
 2 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 5f48e8a..1a69cb0 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -89,7 +89,6 @@ static int quiet, verbose, no_verify, allow_empty, dry_run, renew_authorship;
 static int no_post_rewrite, allow_empty_message;
 static char *untracked_files_arg, *force_date, *ignore_submodule_arg;
 static char *sign_commit;
-static unsigned int colopts;
 
 /*
  * The default commit message cleanup mode will remove the lines
@@ -1123,7 +1122,7 @@ static int git_status_config(const char *k, const char *v, void *cb)
 	struct wt_status *s = cb;
 
 	if (!prefixcmp(k, "column."))
-		return git_column_config(k, v, "status", &colopts);
+		return git_column_config(k, v, "status", &s->colopts);
 	if (!strcmp(k, "status.submodulesummary")) {
 		int is_bool;
 		s->submodule_summary = git_config_bool_or_int(k, v, &is_bool);
@@ -1166,7 +1165,7 @@ static int git_status_config(const char *k, const char *v, void *cb)
 
 int cmd_status(int argc, const char **argv, const char *prefix)
 {
-	struct wt_status s;
+	static struct wt_status s;
 	int fd;
 	unsigned char sha1[20];
 	static struct option builtin_status_options[] = {
@@ -1189,7 +1188,7 @@ int cmd_status(int argc, const char **argv, const char *prefix)
 		{ OPTION_STRING, 0, "ignore-submodules", &ignore_submodule_arg, "when",
 		  "ignore changes to submodules, optional when: all, dirty, untracked. (Default: all)",
 		  PARSE_OPT_OPTARG, NULL, (intptr_t)"all" },
-		OPT_COLUMN(0, "column", &colopts, "list untracked files in columns"),
+		OPT_COLUMN(0, "column", &s.colopts, "list untracked files in columns"),
 		OPT_END(),
 	};
 
@@ -1203,8 +1202,7 @@ int cmd_status(int argc, const char **argv, const char *prefix)
 	argc = parse_options(argc, argv, prefix,
 			     builtin_status_options,
 			     builtin_status_usage, 0);
-	finalize_colopts(&colopts, -1);
-	s.colopts = colopts;
+	finalize_colopts(&s.colopts, -1);
 
 	if (null_termination && status_format == STATUS_FORMAT_LONG)
 		status_format = STATUS_FORMAT_PORCELAIN;
@@ -1369,6 +1367,7 @@ static int run_rewrite_hook(const unsigned char *oldsha1,
 
 int cmd_commit(int argc, const char **argv, const char *prefix)
 {
+	static struct wt_status s;
 	static struct option builtin_commit_options[] = {
 		OPT__QUIET(&quiet, "suppress summary after successful commit"),
 		OPT__VERBOSE(&verbose, "show diff in commit message template"),
@@ -1431,7 +1430,6 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 	struct commit_list *parents = NULL, **pptr = &parents;
 	struct stat statbuf;
 	int allow_fast_forward = 1;
-	struct wt_status s;
 	struct commit *current_head = NULL;
 	struct commit_extra_header *extra = NULL;
 
@@ -1441,6 +1439,7 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 	wt_status_prepare(&s);
 	git_config(git_commit_config, &s);
 	determine_whence(&s);
+	s.colopts = 0;
 
 	if (get_sha1("HEAD", sha1))
 		current_head = NULL;
diff --git a/wt-status.h b/wt-status.h
index 6dd7207..5386077 100644
--- a/wt-status.h
+++ b/wt-status.h
@@ -56,7 +56,7 @@ struct wt_status {
 	enum untracked_status_type show_untracked_files;
 	const char *ignore_submodule_arg;
 	char color_palette[WT_STATUS_MAXSLOT][COLOR_MAXLEN];
-	int colopts;
+	unsigned colopts;
 
 	/* These are computed during processing of the individual sections */
 	int commitable;
-- 
1.7.10.1.12.gd79f7ab
