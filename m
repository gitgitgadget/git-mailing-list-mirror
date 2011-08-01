From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 09/18] revert: Don't create invalid replay_opts in parse_args
Date: Mon,  1 Aug 2011 23:36:56 +0530
Message-ID: <1312222025-28453-10-git-send-email-artagnon@gmail.com>
References: <1312222025-28453-1-git-send-email-artagnon@gmail.com>
Cc: Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 01 20:12:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qnwy9-00046P-SF
	for gcvg-git-2@lo.gmane.org; Mon, 01 Aug 2011 20:12:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752082Ab1HASL5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Aug 2011 14:11:57 -0400
Received: from mail-pz0-f42.google.com ([209.85.210.42]:62360 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750699Ab1HASL4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Aug 2011 14:11:56 -0400
Received: by mail-pz0-f42.google.com with SMTP id 37so11912645pzk.1
        for <git@vger.kernel.org>; Mon, 01 Aug 2011 11:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=I66Dejk0Jk72dpHynsZyNAMUc3lgKEIkd9zaYELOCL0=;
        b=ZME7BoFBqpXFwzCzI3fAmQvvgLFJCIQFYGsGCUdbtrvcPMmPqXIZ8sNEgv01ARXfD2
         nAkg1sUl7+1+g7xIkLqmqKuklN7nHetSacxZq6LtW+KkRCa+0Jhwdn+oDRI4v/EscDy7
         AxY/Pd9/lFT3OYDoiY8ushuEk1IJHzgaWOAX0=
Received: by 10.68.26.6 with SMTP id h6mr7906160pbg.501.1312222316158;
        Mon, 01 Aug 2011 11:11:56 -0700 (PDT)
Received: from localhost.localdomain ([203.110.240.41])
        by mx.google.com with ESMTPS id d3sm5789958pbh.37.2011.08.01.11.11.47
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 01 Aug 2011 11:11:54 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.rc1.7.g2cf08.dirty
In-Reply-To: <1312222025-28453-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178381>

The "--ff" command-line option cannot be used with some other
command-line options.  However, parse_args still parses these
incompatible options into a replay_opts structure for use by the rest
of the program.  Although pick_commits, the current gatekeeper to the
cherry-pick machinery, checks the validity of the replay_opts
structure before before starting its operation, there will be multiple
entry points to the cherry-pick machinery in future.  To futureproof
the code and catch these errors in one place, make sure that an
invalid replay_opts structure is not created by parse_args in the
first place.  We still check the replay_opts structure for validity in
pick_commits, but this is an assert() now to emphasize that it's the
caller's responsibility to get it right.

Inspired-by: Christian Couder <chriscool@tuxfamily.org>
Mentored-by: Jonathan Nieder <jrnieder@gmail.com>
Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 builtin/revert.c |   40 +++++++++++++++++++++++++++++-----------
 1 files changed, 29 insertions(+), 11 deletions(-)

diff --git a/builtin/revert.c b/builtin/revert.c
index 90fe2ef..0196046 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -86,9 +86,28 @@ static int option_parse_x(const struct option *opt,
 	return 0;
 }
 
+static void verify_opt_compatible(const char *me, const char *base_opt, ...)
+{
+	const char *this_opt;
+	va_list ap;
+	int set;
+
+	va_start(ap, base_opt);
+	while ((this_opt = va_arg(ap, const char *))) {
+		set = va_arg(ap, int);
+		if (set) {
+			va_end(ap);
+			die(_("%s: %s cannot be used with %s"),
+				me, this_opt, base_opt);
+		}
+	}
+	va_end(ap);
+}
+
 static void parse_args(int argc, const char **argv, struct replay_opts *opts)
 {
 	const char * const * usage_str = revert_or_cherry_pick_usage(opts);
+	const char *me = action_name(opts);
 	int noop;
 	struct option options[] = {
 		OPT_BOOLEAN('n', "no-commit", &opts->no_commit, "don't automatically commit"),
@@ -122,6 +141,13 @@ static void parse_args(int argc, const char **argv, struct replay_opts *opts)
 	if (opts->commit_argc < 2)
 		usage_with_options(usage_str, options);
 
+	if (opts->allow_ff)
+		verify_opt_compatible(me, "--ff",
+				"--signoff", opts->signoff,
+				"--no-commit", opts->no_commit,
+				"-x", opts->record_origin,
+				"--edit", opts->edit,
+				NULL);
 	opts->commit_argv = argv;
 }
 
@@ -569,17 +595,9 @@ static int pick_commits(struct replay_opts *opts)
 	struct commit *commit;
 
 	setenv(GIT_REFLOG_ACTION, action_name(opts), 0);
-	if (opts->allow_ff) {
-		if (opts->signoff)
-			die(_("cherry-pick --ff cannot be used with --signoff"));
-		if (opts->no_commit)
-			die(_("cherry-pick --ff cannot be used with --no-commit"));
-		if (opts->record_origin)
-			die(_("cherry-pick --ff cannot be used with -x"));
-		if (opts->edit)
-			die(_("cherry-pick --ff cannot be used with --edit"));
-	}
-
+	if (opts->allow_ff)
+		assert(!(opts->signoff || opts->no_commit ||
+				opts->record_origin || opts->edit));
 	read_and_refresh_cache(opts);
 
 	prepare_revs(&revs, opts);
-- 
1.7.4.rc1.7.g2cf08.dirty
