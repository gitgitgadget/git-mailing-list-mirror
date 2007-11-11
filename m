From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 5/6] builtin-commit: resurrect behavior for multiple -m
 options
Date: Sun, 11 Nov 2007 17:36:39 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711111736310.4362@racer.site>
References: <Pine.LNX.4.64.0711111730580.4362@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org, krh@redhat.com, gitster@pobox.com
X-From: git-owner@vger.kernel.org Sun Nov 11 18:37:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IrGk9-0006Dz-57
	for gcvg-git-2@gmane.org; Sun, 11 Nov 2007 18:37:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756142AbXKKRgv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Nov 2007 12:36:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756119AbXKKRgv
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Nov 2007 12:36:51 -0500
Received: from mail.gmx.net ([213.165.64.20]:54179 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756110AbXKKRgu (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Nov 2007 12:36:50 -0500
Received: (qmail invoked by alias); 11 Nov 2007 17:36:48 -0000
Received: from unknown (EHLO openvpn-client) [138.251.11.103]
  by mail.gmx.net (mp052) with SMTP; 11 Nov 2007 18:36:48 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19QARhXTwVQsWX+HKyLqKaHIUfyamRy7L1H0ALnJN
	tcnCSwf3eQhrTN
X-X-Sender: gene099@racer.site
In-Reply-To: <Pine.LNX.4.64.0711111730580.4362@racer.site>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64483>


When more than one -m option is given, the message does not replace
the previous, but is appended.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin-commit.c |   26 ++++++++++++++++++++------
 1 files changed, 20 insertions(+), 6 deletions(-)

diff --git a/builtin-commit.c b/builtin-commit.c
index 66d7e5e..069d180 100644
--- a/builtin-commit.c
+++ b/builtin-commit.c
@@ -30,13 +30,27 @@ static char *use_message_buffer;
 static const char commit_editmsg[] = "COMMIT_EDITMSG";
 static struct lock_file lock_file;
 
-static char *logfile, *force_author, *message, *template_file;
+static char *logfile, *force_author, *template_file;
 static char *edit_message, *use_message;
 static int all, edit_flag, also, interactive, only, amend, signoff;
 static int quiet, verbose, untracked_files, no_verify;
 
 static int no_edit, initial_commit, in_merge;
 const char *only_include_assumed;
+struct strbuf message;
+
+static int opt_parse_m(const struct option *opt, const char *arg, int unset)
+{
+	struct strbuf *buf = opt->value;
+	if (unset)
+		strbuf_setlen(buf, 0);
+	else {
+		strbuf_addstr(buf, arg);
+		strbuf_addch(buf, '\n');
+		strbuf_addch(buf, '\n');
+	}
+	return 0;
+}
 
 static struct option builtin_commit_options[] = {
 	OPT__QUIET(&quiet),
@@ -45,7 +59,7 @@ static struct option builtin_commit_options[] = {
 
 	OPT_STRING('F', "file", &logfile, "FILE", "read log from file"),
 	OPT_STRING(0, "author", &force_author, "AUTHOR", "override author for commit"),
-	OPT_STRING('m', "message", &message, "MESSAGE", "specify commit message"),
+	OPT_CALLBACK('m', "message", &message, "MESSAGE", "specify commit message", opt_parse_m),
 	OPT_STRING('c', "reedit-message", &edit_message, "COMMIT", "reuse and edit message from specified commit "),
 	OPT_STRING('C', "reuse-message", &use_message, "COMMIT", "reuse message from specified commit"),
 	OPT_BOOLEAN('s', "signoff", &signoff, "add Signed-off-by: header"),
@@ -150,8 +164,8 @@ static int prepare_log_message(const char *index_file, const char *prefix)
 	FILE *fp;
 
 	strbuf_init(&sb, 0);
-	if (message) {
-		strbuf_add(&sb, message, strlen(message));
+	if (message.len) {
+		strbuf_addbuf(&sb, &message);
 	} else if (logfile && !strcmp(logfile, "-")) {
 		if (isatty(0))
 			fprintf(stderr, "(reading log message from standard input)\n");
@@ -321,7 +335,7 @@ static int parse_and_validate_options(int argc, const char *argv[])
 	argc = parse_options(argc, argv, builtin_commit_options,
 			     builtin_commit_usage, 0);
 
-	if (logfile || message || use_message)
+	if (logfile || message.len || use_message)
 		no_edit = 1;
 	if (edit_flag)
 		no_edit = 0;
@@ -346,7 +360,7 @@ static int parse_and_validate_options(int argc, const char *argv[])
 		f++;
 	if (f > 1)
 		die("Only one of -c/-C/-F can be used.");
-	if (message && f > 0)
+	if (message.len && f > 0)
 		die("Option -m cannot be combined with -c/-C/-F.");
 	if (edit_message)
 		use_message = edit_message;
-- 
1.5.3.5.1693.g26ed
