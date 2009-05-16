From: Stephen Boyd <bebarino@gmail.com>
Subject: [PATCH 3/3] format-patch: migrate to parse-options API
Date: Sat, 16 May 2009 02:24:46 -0700
Message-ID: <1242465886-31769-3-git-send-email-bebarino@gmail.com>
References: <1242465886-31769-1-git-send-email-bebarino@gmail.com>
 <1242465886-31769-2-git-send-email-bebarino@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 16 11:25:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M5G8y-0006BM-5h
	for gcvg-git-2@gmane.org; Sat, 16 May 2009 11:25:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755024AbZEPJY6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 May 2009 05:24:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754915AbZEPJY6
	(ORCPT <rfc822;git-outgoing>); Sat, 16 May 2009 05:24:58 -0400
Received: from mail-pz0-f115.google.com ([209.85.222.115]:56546 "EHLO
	mail-pz0-f115.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754749AbZEPJY4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 May 2009 05:24:56 -0400
Received: by pzk13 with SMTP id 13so1406036pzk.33
        for <git@vger.kernel.org>; Sat, 16 May 2009 02:24:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references;
        bh=4Y6E/3rND9qhIGBGutUWCWMNa++aSTwk/88KyBUgEks=;
        b=Y3geJSliJnsmIugXQ8c2vuWxZpA4QX5KtG+vyYeSmySMNpgg/4kVryQPhXhd6cZRUq
         Dbem+cBhnkyKhEFjZQTBxJexioLuNEINcFaBcjg5GXr18MXtaVas3Qt0lc3TWG8JmPX2
         vo8Sc7YQY8oM1RawBkHsR90jYa4VHyebEI+q0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=xGD9qMXZ27aMy+xu02veoTAJB3Lzw+khOt2mSmAbANVt3SR+qMbMDGHdPzE/rAcRt/
         7kYVjzPvr7r5iXLlYbJ6AlD3HvZs8IRCMi46XGei/o22+z5naRHNh7UqfWGcLDp2pBIi
         xjvOui+pWj5ZfOTbRngOeuWdq3CZMHmKxLFvM=
Received: by 10.114.60.7 with SMTP id i7mr6502986waa.174.1242465897361;
        Sat, 16 May 2009 02:24:57 -0700 (PDT)
Received: from earth ([76.89.212.195])
        by mx.google.com with ESMTPS id n9sm2403073wag.34.2009.05.16.02.24.55
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 16 May 2009 02:24:56 -0700 (PDT)
Received: by earth (sSMTP sendmail emulation); Sat, 16 May 2009 02:24:53 -0700
X-Mailer: git-send-email 1.6.3.1.9.g95405b
In-Reply-To: <1242465886-31769-2-git-send-email-bebarino@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119347>


Signed-off-by: Stephen Boyd <bebarino@gmail.com>
---

I know that two patch series are coming which will conflict. One is already
in next, ca6b91d (format-patch let -k override format.numbered, 2009-05-09).
I will send a patch against next as a followup, just in case.

 builtin-log.c |  255 +++++++++++++++++++++++++++++++++++----------------------
 1 files changed, 158 insertions(+), 97 deletions(-)

diff --git a/builtin-log.c b/builtin-log.c
index 5eaec5d..2a35b6b 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -18,6 +18,7 @@
 #include "shortlog.h"
 #include "remote.h"
 #include "string-list.h"
+#include "parse-options.h"
 
 /* Set a default date-time format for git log ("log.date" config variable) */
 static const char *default_date_mode = NULL;
@@ -740,17 +741,117 @@ static const char *set_outdir(const char *prefix, const char *output_directory)
 				       output_directory));
 }
 
+static const char * const builtin_format_patch_usage[] = {
+	"git format-patch [options] [<since> | <revision range>]",
+	NULL
+};
+
+static int keep_subject = 0;
+
+static int keep_callback(const struct option *opt, const char *arg, int unset)
+{
+	((struct rev_info *)opt->value)->total = -1;
+	keep_subject = 1;
+	return 0;
+}
+
+static int subject_prefix = 0;
+
+static int subject_prefix_callback(const struct option *opt, const char *arg,
+			    int unset)
+{
+	subject_prefix = 1;
+	((struct rev_info *)opt->value)->subject_prefix = arg;
+	return 0;
+}
+
+static int numbered_callback(const struct option *opt, const char *arg,
+			     int unset)
+{
+	*(int *)opt->value = unset ? 0 : 1;
+	if (unset)
+		auto_number =  0;
+	return 0;
+}
+
+static int no_numbered_callback(const struct option *opt, const char *arg,
+				int unset)
+{
+	return numbered_callback(opt, arg, 1);
+}
+
+static int output_directory_callback(const struct option *opt, const char *arg,
+			      int unset)
+{
+	const char **dir = (const char **)opt->value;
+	if (*dir)
+		die("Two output directories?");
+	*dir = arg;
+	return 0;
+}
+
+static int thread_callback(const struct option *opt, const char *arg, int unset)
+{
+	int *thread = (int *)opt->value;
+	if (unset)
+		*thread = 0;
+	else if (!arg || !strcmp(arg, "shallow"))
+		*thread = THREAD_SHALLOW;
+	else if (!strcmp(arg, "deep"))
+		*thread = THREAD_DEEP;
+	else
+		return 1;
+	return 0;
+}
+
+static int attach_callback(const struct option *opt, const char *arg, int unset)
+{
+	struct rev_info *rev = (struct rev_info *)opt->value;
+	if (unset)
+		rev->mime_boundary = NULL;
+	else if (arg)
+		rev->mime_boundary = arg;
+	else
+		rev->mime_boundary = git_version_string;
+	rev->no_inline = unset ? 0 : 1;
+	return 0;
+}
+
+static int inline_callback(const struct option *opt, const char *arg, int unset)
+{
+	struct rev_info *rev = (struct rev_info *)opt->value;
+	if (unset)
+		rev->mime_boundary = NULL;
+	else if (arg)
+		rev->mime_boundary = arg;
+	else
+		rev->mime_boundary = git_version_string;
+	rev->no_inline = 0;
+	return 0;
+}
+
+static int header_callback(const struct option *opt, const char *arg, int unset)
+{
+	add_header(arg);
+	return 0;
+}
+
+static int cc_callback(const struct option *opt, const char *arg, int unset)
+{
+	ALLOC_GROW(extra_cc, extra_cc_nr + 1, extra_cc_alloc);
+	extra_cc[extra_cc_nr++] = xstrdup(arg);
+	return 0;
+}
+
 int cmd_format_patch(int argc, const char **argv, const char *prefix)
 {
 	struct commit *commit;
 	struct commit **list = NULL;
 	struct rev_info rev;
-	int nr = 0, total, i, j;
+	int nr = 0, total, i;
 	int use_stdout = 0;
 	int start_number = -1;
-	int keep_subject = 0;
 	int numbered_files = 0;		/* _just_ numbers */
-	int subject_prefix = 0;
 	int ignore_if_in_upstream = 0;
 	int cover_letter = 0;
 	int boundary_count = 0;
@@ -760,6 +861,57 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 	struct patch_ids ids;
 	char *add_signoff = NULL;
 	struct strbuf buf = STRBUF_INIT;
+	const struct option builtin_format_patch_options[] = {
+		{ OPTION_CALLBACK, 'n', "numbered", &numbered, NULL,
+			    "use [PATCH n/m] even with a single patch",
+			    PARSE_OPT_NOARG, numbered_callback },
+		{ OPTION_CALLBACK, 'N', "no-numbered", &numbered, NULL,
+			    "use [PATCH] even with a multiple patches",
+			    PARSE_OPT_NOARG, no_numbered_callback },
+		OPT_BOOLEAN('s', "signoff", &do_signoff, "add Signed-off-by:"),
+		OPT_BOOLEAN(0, "stdout", &use_stdout,
+			    "print patches to standard out"),
+		OPT_BOOLEAN(0, "cover-letter", &cover_letter,
+			    "generate a cover letter"),
+		OPT_BOOLEAN(0, "numbered-files", &numbered_files,
+			    "use simple number sequence for output file names"),
+		OPT_STRING(0, "suffix", &fmt_patch_suffix, "sfx",
+			    "use <sfx> instead of '.patch'"),
+		OPT_INTEGER(0, "start-number", &start_number,
+			    "start numbering patches at <n> instead of 1"),
+		{ OPTION_CALLBACK, 0, "subject-prefix", &rev, "prefix",
+			    "Use [<prefix>] instead of [PATCH]",
+			    PARSE_OPT_NONEG, subject_prefix_callback },
+		{ OPTION_CALLBACK, 'o', "output-directory", &output_directory,
+			    "dir", "store resulting files in <dir>",
+			    PARSE_OPT_NONEG, output_directory_callback },
+		{ OPTION_CALLBACK, 'k', "keep-subject", &rev, NULL,
+			    "don't strip/add [PATCH]",
+			    PARSE_OPT_NOARG | PARSE_OPT_NONEG, keep_callback },
+		OPT_BOOLEAN(0, "no-binary", &no_binary_diff,
+			    "don't output binary diffs"),
+		OPT_BOOLEAN(0, "ignore-if-in-upstream", &ignore_if_in_upstream,
+			    "don't include a patch matching a commit upstream"),
+		OPT_GROUP("Messaging"),
+		{ OPTION_CALLBACK, 0, "add-header", NULL, "header",
+			    "add email header", PARSE_OPT_NONEG,
+			    header_callback },
+		{ OPTION_CALLBACK, 0, "cc", NULL, "email", "add Cc: header",
+			    PARSE_OPT_NONEG, cc_callback },
+		OPT_STRING(0, "in-reply-to", &in_reply_to, "message-id",
+			    "make first mail a reply to <message-id>"),
+		{ OPTION_CALLBACK, 0, "attach", &rev, "boundary",
+			    "attach the patch", PARSE_OPT_OPTARG,
+			    attach_callback },
+		{ OPTION_CALLBACK, 0, "inline", &rev, "boundary",
+			    "inline the patch",
+			    PARSE_OPT_OPTARG | PARSE_OPT_NONEG,
+			    inline_callback },
+		{ OPTION_CALLBACK, 0, "thread", &thread, "style",
+			    "enable message threading, styles: shallow, deep",
+			    PARSE_OPT_OPTARG, thread_callback },
+		OPT_END()
+	};
 
 	git_config(git_format_config, NULL);
 	init_revisions(&rev, prefix);
@@ -782,100 +934,9 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 	 * like "git format-patch -o a123 HEAD^.." may fail; a123 is
 	 * possibly a valid SHA1.
 	 */
-	for (i = 1, j = 1; i < argc; i++) {
-		if (!strcmp(argv[i], "--stdout"))
-			use_stdout = 1;
-		else if (!strcmp(argv[i], "-n") ||
-				!strcmp(argv[i], "--numbered"))
-			numbered = 1;
-		else if (!strcmp(argv[i], "-N") ||
-				!strcmp(argv[i], "--no-numbered")) {
-			numbered = 0;
-			auto_number = 0;
-		}
-		else if (!prefixcmp(argv[i], "--start-number="))
-			start_number = strtol(argv[i] + 15, NULL, 10);
-		else if (!strcmp(argv[i], "--numbered-files"))
-			numbered_files = 1;
-		else if (!strcmp(argv[i], "--start-number")) {
-			i++;
-			if (i == argc)
-				die("Need a number for --start-number");
-			start_number = strtol(argv[i], NULL, 10);
-		}
-		else if (!prefixcmp(argv[i], "--cc=")) {
-			ALLOC_GROW(extra_cc, extra_cc_nr + 1, extra_cc_alloc);
-			extra_cc[extra_cc_nr++] = xstrdup(argv[i] + 5);
-		}
-		else if (!strcmp(argv[i], "-k") ||
-				!strcmp(argv[i], "--keep-subject")) {
-			keep_subject = 1;
-			rev.total = -1;
-		}
-		else if (!strcmp(argv[i], "--output-directory") ||
-			 !strcmp(argv[i], "-o")) {
-			i++;
-			if (argc <= i)
-				die("Which directory?");
-			if (output_directory)
-				die("Two output directories?");
-			output_directory = argv[i];
-		}
-		else if (!strcmp(argv[i], "--signoff") ||
-			 !strcmp(argv[i], "-s")) {
-			do_signoff = 1;
-		}
-		else if (!strcmp(argv[i], "--attach")) {
-			rev.mime_boundary = git_version_string;
-			rev.no_inline = 1;
-		}
-		else if (!prefixcmp(argv[i], "--attach=")) {
-			rev.mime_boundary = argv[i] + 9;
-			rev.no_inline = 1;
-		}
-		else if (!strcmp(argv[i], "--no-attach")) {
-			rev.mime_boundary = NULL;
-			rev.no_inline = 0;
-		}
-		else if (!strcmp(argv[i], "--inline")) {
-			rev.mime_boundary = git_version_string;
-			rev.no_inline = 0;
-		}
-		else if (!prefixcmp(argv[i], "--inline=")) {
-			rev.mime_boundary = argv[i] + 9;
-			rev.no_inline = 0;
-		}
-		else if (!strcmp(argv[i], "--ignore-if-in-upstream"))
-			ignore_if_in_upstream = 1;
-		else if (!strcmp(argv[i], "--thread")
-			|| !strcmp(argv[i], "--thread=shallow"))
-			thread = THREAD_SHALLOW;
-		else if (!strcmp(argv[i], "--thread=deep"))
-			thread = THREAD_DEEP;
-		else if (!strcmp(argv[i], "--no-thread"))
-			thread = 0;
-		else if (!prefixcmp(argv[i], "--in-reply-to="))
-			in_reply_to = argv[i] + 14;
-		else if (!strcmp(argv[i], "--in-reply-to")) {
-			i++;
-			if (i == argc)
-				die("Need a Message-Id for --in-reply-to");
-			in_reply_to = argv[i];
-		} else if (!prefixcmp(argv[i], "--subject-prefix=")) {
-			subject_prefix = 1;
-			rev.subject_prefix = argv[i] + 17;
-		} else if (!prefixcmp(argv[i], "--suffix="))
-			fmt_patch_suffix = argv[i] + 9;
-		else if (!strcmp(argv[i], "--cover-letter"))
-			cover_letter = 1;
-		else if (!strcmp(argv[i], "--no-binary"))
-			no_binary_diff = 1;
-		else if (!prefixcmp(argv[i], "--add-header="))
-			add_header(argv[i] + 13);
-		else
-			argv[j++] = argv[i];
-	}
-	argc = j;
+	argc = parse_options(argc, argv, builtin_format_patch_options,
+			     builtin_format_patch_usage,
+			     PARSE_OPT_KEEP_ARGV0 | PARSE_OPT_KEEP_UNKNOWN);
 
 	if (do_signoff) {
 		const char *committer;
-- 
1.6.3.1.9.g95405b
