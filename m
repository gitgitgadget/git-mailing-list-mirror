From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 09/10] revert: Implement parsing --continue, --abort and --skip
Date: Thu, 26 May 2011 15:53:52 +0000
Message-ID: <1306425233-504-10-git-send-email-artagnon@gmail.com>
References: <1306333025-29893-1-git-send-email-artagnon@gmail.com>
 <1306425233-504-1-git-send-email-artagnon@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Christian Couder <christian.couder@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu May 26 17:54:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QPctA-0001N6-F7
	for gcvg-git-2@lo.gmane.org; Thu, 26 May 2011 17:54:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757992Ab1EZPyN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 May 2011 11:54:13 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:62865 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754017Ab1EZPyM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 May 2011 11:54:12 -0400
Received: by mail-qw0-f46.google.com with SMTP id 3so441172qwk.19
        for <git@vger.kernel.org>; Thu, 26 May 2011 08:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=xq2cvdAaDfKmhwU9Vbu78f4pBDMN4GE2+Q/wVWd53y0=;
        b=un0iBuAjzNZw8MWFu8NGCRDychHdCqhNZN4IKbmzfirsv2/JuborOrc7e7XCrfeBGN
         TuLi4WlDrxTjca3rcnW6fIibdsWA+qkFJjKMxlfKVdFKeC56ImWsAByGy7MPWg8c2BDR
         luH7aoFMZU4eBPVb2Stg0tnJce91E0YsUvBS8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=ngAe1DAbEu1qbAhmM9D6Kj4ub65NBle6YuMC2hERvMh1fXjwAfUBzi1Ta6UowtnTwS
         06ta80UCQNmZRf+AXJo79gQ4rIXs0Voci1qH4b4BALO/0yNLhhmWGTHZ3eZh4yUyY71J
         5HaC/eUC146eKtDzSr10NN5jYuP4UKZGpSvis=
Received: by 10.229.18.81 with SMTP id v17mr752641qca.7.1306425251728;
        Thu, 26 May 2011 08:54:11 -0700 (PDT)
Received: from localhost.localdomain (ec2-184-72-137-52.compute-1.amazonaws.com [184.72.137.52])
        by mx.google.com with ESMTPS id j18sm513435qck.27.2011.05.26.08.54.10
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 26 May 2011 08:54:10 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.1
In-Reply-To: <1306425233-504-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174530>

Introduce three new command-line options: --continue, --abort, and
--skip resembling the correspoding options in "rebase -i".  For now,
just parse the options into the replay_opts structure, making sure
that two of them are not specified together.  They will actually be
implemented later in the series.

Mentored-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 builtin/revert.c |   71 +++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 70 insertions(+), 1 deletions(-)

diff --git a/builtin/revert.c b/builtin/revert.c
index 306f5b0..f33d40a 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -47,6 +47,11 @@ static const char *me;
 struct replay_opts {
 	enum { REVERT, CHERRY_PICK } action;
 
+	/* --abort, --skip, and --continue */
+	int abort_oper;
+	int skip_oper;
+	int continue_oper;
+
 	/* Boolean options */
 	int edit;
 	int record_origin;
@@ -103,11 +108,36 @@ static void verify_opt_compatible(const char *me, const char *base_opt, ...)
 	va_end(ap);
 }
 
+static void verify_opt_mutually_compatible(const char *me, ...)
+{
+	const char *opt1, *opt2;
+	va_list ap;
+	int set;
+
+	va_start(ap, me);
+	while ((opt1 = va_arg(ap, const char *))) {
+		set = va_arg(ap, int);
+		if (set)
+			break;
+	}
+	if (!opt1) return;
+	while ((opt2 = va_arg(ap, const char *))) {
+		set = va_arg(ap, int);
+		if (set)
+			die(_("%s: %s cannot be used with %s"),
+				me, opt1, opt2);
+	}
+	va_end(ap);
+}
+
 static void parse_args(int argc, const char **argv, struct replay_opts *opts)
 {
 	const char * const * usage_str = revert_or_cherry_pick_usage(opts);
 	int noop;
 	struct option options[] = {
+		OPT_BOOLEAN(0, "abort", &opts->abort_oper, "abort the current operation"),
+		OPT_BOOLEAN(0, "skip", &opts->skip_oper, "skip the current commit"),
+		OPT_BOOLEAN(0, "continue", &opts->continue_oper, "continue the current operation"),
 		OPT_BOOLEAN('n', "no-commit", &opts->no_commit, "don't automatically commit"),
 		OPT_BOOLEAN('e', "edit", &opts->edit, "edit the commit message"),
 		{ OPTION_BOOLEAN, 'r', NULL, &noop, NULL, "no-op (backward compatibility)",
@@ -136,7 +166,37 @@ static void parse_args(int argc, const char **argv, struct replay_opts *opts)
 	opts->commit_argc = parse_options(argc, argv, NULL, options, usage_str,
 					PARSE_OPT_KEEP_ARGV0 |
 					PARSE_OPT_KEEP_UNKNOWN);
-	if (opts->commit_argc < 2)
+
+	/* Check for mutually incompatible command line arguments */
+	verify_opt_mutually_compatible(me,
+				"--abort", opts->abort_oper,
+				"--skip", opts->skip_oper,
+				"--continue", opts->continue_oper,
+				NULL);
+
+	/* Check for incompatible command line arguments */
+	if (opts->abort_oper || opts->skip_oper || opts->continue_oper) {
+		char *this_oper;
+		if (opts->abort_oper)
+			this_oper = "--abort";
+		else if (opts->skip_oper)
+			this_oper = "--skip";
+		else
+			this_oper = "--continue";
+
+		verify_opt_compatible(me, this_oper,
+				"--no-commit", opts->no_commit,
+				"--edit", opts->edit,
+				"--signoff", opts->signoff,
+				"--mainline", opts->mainline,
+				"--strategy", opts->strategy ? 1 : 0,
+				"--strategy-option", opts->xopts ? 1 : 0,
+				"-x", opts->record_origin,
+				"--ff", opts->allow_ff,
+				NULL);
+	}
+
+	else if (opts->commit_argc < 2)
 		usage_with_options(usage_str, options);
 
 	if (opts->allow_ff)
@@ -146,6 +206,15 @@ static void parse_args(int argc, const char **argv, struct replay_opts *opts)
 				"-x", opts->record_origin,
 				"--edit", opts->edit,
 				NULL);
+
+	/* Remove these when the options are actually implemented */
+	if (opts->abort_oper)
+		die("--abort is not implemented yet");
+	if (opts->skip_oper)
+		die("--skip is not implemented yet");
+	if (opts->continue_oper)
+		die("--continue is not implemented yet");
+
 	opts->commit_argv = argv;
 }
 
-- 
1.7.5.GIT
