From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 09/18] revert: Don't create invalid replay_opts in parse_args
Date: Thu, 28 Jul 2011 22:22:22 +0530
Message-ID: <1311871951-3497-10-git-send-email-artagnon@gmail.com>
References: <1311871951-3497-1-git-send-email-artagnon@gmail.com>
Cc: Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 28 19:03:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QmTzU-0008EC-Tg
	for gcvg-git-2@lo.gmane.org; Thu, 28 Jul 2011 19:03:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755685Ab1G1RDQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Jul 2011 13:03:16 -0400
Received: from mail-gw0-f43.google.com ([74.125.83.43]:52272 "EHLO
	mail-gw0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754841Ab1G1RDP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jul 2011 13:03:15 -0400
X-Greylist: delayed 419 seconds by postgrey-1.27 at vger.kernel.org; Thu, 28 Jul 2011 13:03:15 EDT
Received: by gwm11 with SMTP id 11so2724915gwm.2
        for <git@vger.kernel.org>; Thu, 28 Jul 2011 10:03:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=OBzRLp8iw4l66Z/jZqxSFr5sPVMBmAwgQFB3ylv04Uk=;
        b=UDU580FzcP9VEiGGiv2VMLe3kXkG/4XH7OQk0AX3pQJXCx/eo8Gy7+BJ8URG2fpYO2
         FON7bS8HHeP/yEmbuTf+iju9pQC7TsTHrVgriAbASs23eo2jcdMDzDPR6GQtZccDbrOi
         PBv0meHbitjwc+oxFCj5cIPiIQojFE1qq77Gk=
Received: by 10.42.146.136 with SMTP id j8mr154677icv.369.1311872175908;
        Thu, 28 Jul 2011 09:56:15 -0700 (PDT)
Received: from localhost.localdomain ([203.110.240.41])
        by mx.google.com with ESMTPS id ue1sm1497759icb.8.2011.07.28.09.56.11
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 28 Jul 2011 09:56:14 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.rc1.7.g2cf08.dirty
In-Reply-To: <1311871951-3497-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178100>

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
 builtin/revert.c |   38 +++++++++++++++++++++++++++-----------
 1 files changed, 27 insertions(+), 11 deletions(-)

diff --git a/builtin/revert.c b/builtin/revert.c
index 90fe2ef..9c29852 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -86,9 +86,26 @@ static int option_parse_x(const struct option *opt,
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
+		if (set)
+			die(_("%s: %s cannot be used with %s"),
+				me, this_opt, base_opt);
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
@@ -122,6 +139,13 @@ static void parse_args(int argc, const char **argv, struct replay_opts *opts)
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
 
@@ -569,17 +593,9 @@ static int pick_commits(struct replay_opts *opts)
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
