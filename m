From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 09/18] revert: Don't create invalid replay_opts in parse_args
Date: Thu,  4 Aug 2011 16:09:07 +0530
Message-ID: <1312454356-3070-10-git-send-email-artagnon@gmail.com>
References: <1312454356-3070-1-git-send-email-artagnon@gmail.com>
Cc: Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 04 12:43:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QovOU-0007A1-8F
	for gcvg-git-2@lo.gmane.org; Thu, 04 Aug 2011 12:43:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754094Ab1HDKnH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Aug 2011 06:43:07 -0400
Received: from mail-pz0-f42.google.com ([209.85.210.42]:63604 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754086Ab1HDKnF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Aug 2011 06:43:05 -0400
Received: by mail-pz0-f42.google.com with SMTP id 37so1836868pzk.1
        for <git@vger.kernel.org>; Thu, 04 Aug 2011 03:43:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=rvO9GVB4P2X0nivJkdFU15qLXqRQvduRQIk+KMwNuDw=;
        b=jIlpYHYej2kbUhil2/wk/Qbe/OJl+LOvaxDFZo5srYw/4d1fNBNw2LvcXGoqs+CQ+0
         CeVbmVMW/w+13KFVubRvEkOG0HXjlxJOjk4c9UUTBaM8zwK/fZBGqXWd28wmEyP2iVNT
         Ky/pDXQ+7xsqXYDSBGUlEf72ExGshB6jTRKh8=
Received: by 10.142.172.1 with SMTP id u1mr707433wfe.73.1312454585129;
        Thu, 04 Aug 2011 03:43:05 -0700 (PDT)
Received: from localhost.localdomain ([203.110.240.41])
        by mx.google.com with ESMTPS id m7sm2090440pbk.6.2011.08.04.03.43.00
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 04 Aug 2011 03:43:04 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.351.gb35ac.dirty
In-Reply-To: <1312454356-3070-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178725>

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
index 90fe2ef..f75c9cb 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -86,9 +86,26 @@ static int option_parse_x(const struct option *opt,
 	return 0;
 }
 
+static void verify_opt_compatible(const char *me, const char *base_opt, ...)
+{
+	const char *this_opt;
+	va_list ap;
+
+	va_start(ap, base_opt);
+	while ((this_opt = va_arg(ap, const char *))) {
+		if (va_arg(ap, int))
+			break;
+	}
+	va_end(ap);
+
+	if (this_opt)
+		die(_("%s: %s cannot be used with %s"), me, this_opt, base_opt);
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
1.7.6.351.gb35ac.dirty
