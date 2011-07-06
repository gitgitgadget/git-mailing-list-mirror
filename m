From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 09/14] revert: Don't create invalid replay_opts in parse_args
Date: Wed,  6 Jul 2011 07:54:23 +0000
Message-ID: <1309938868-2028-10-git-send-email-artagnon@gmail.com>
References: <1309938868-2028-1-git-send-email-artagnon@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jul 06 09:55:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QeMwg-0005vT-Ns
	for gcvg-git-2@lo.gmane.org; Wed, 06 Jul 2011 09:54:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752514Ab1GFHyr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Jul 2011 03:54:47 -0400
Received: from mail-qy0-f181.google.com ([209.85.216.181]:50598 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752197Ab1GFHyp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jul 2011 03:54:45 -0400
Received: by qyk9 with SMTP id 9so3905037qyk.19
        for <git@vger.kernel.org>; Wed, 06 Jul 2011 00:54:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=PFb4zOgLN+pc5tfMCSYqocVL3yB7NI5LmhJVHMEPN14=;
        b=OFUcNdjS5/VaPPGoILGEYWzivQDXkCr0z+CS6P/crf9sgSxcFP351Ok048nyAOdC13
         u8zFDeTjZyWVToGH5VsGyG5MI00ZALA4+VaRICgr1Arjqjs2b4c+oKEyo5aGFXPiql7h
         BWyyfvlqe9AkCu268D2TmwLgmHl7TgcbQOQ64=
Received: by 10.229.39.3 with SMTP id d3mr6059924qce.271.1309938885112;
        Wed, 06 Jul 2011 00:54:45 -0700 (PDT)
Received: from localhost.localdomain (ec2-184-72-137-52.compute-1.amazonaws.com [184.72.137.52])
        by mx.google.com with ESMTPS id e18sm6212790qcs.5.2011.07.06.00.54.43
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 06 Jul 2011 00:54:43 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.1
In-Reply-To: <1309938868-2028-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176656>

The "--ff" command-line option cannot be used with four other
command-line options.  However, when these options are specified with
"--ff" on the command-line, parse_args will still parse these
incompatible options into a replay_opts structure for use by the rest
of the program.  Although pick_commits checks the validity of the
replay_opts strucutre before before starting its operation, this is
inelegant design; pick_commits is currently the gatekeeper to the
cherry-pick machinery, but this will change in future.  To futureproof
the code and catch these errors in one place, make sure that an
invalid replay_opts structure is not created by parse_args in the
first place.  Also ensure that regressions in maintaining this
invariant are caught in the future by adding an assertion in
pick_commits.

Inspired-by: Christian Couder <chriscool@tuxfamily.org>
Mentored-by: Jonathan Nieder <jrnieder@gmail.com>
Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 builtin/revert.c |   37 ++++++++++++++++++++++++++-----------
 1 files changed, 26 insertions(+), 11 deletions(-)

diff --git a/builtin/revert.c b/builtin/revert.c
index e3a7c9e..27dc538 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -82,6 +82,22 @@ static int option_parse_x(const struct option *opt,
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
@@ -118,6 +134,13 @@ static void parse_args(int argc, const char **argv, struct replay_opts *opts)
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
 
@@ -561,17 +584,9 @@ static int pick_commits(struct replay_opts *opts)
 	struct commit *commit;
 
 	setenv(GIT_REFLOG_ACTION, me, 0);
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
 	read_and_refresh_cache(me, opts);
 
 	prepare_revs(&revs, opts);
-- 
1.7.5.GIT
