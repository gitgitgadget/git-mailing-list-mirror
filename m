From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 07/10] revert: Catch incompatible command-line options early
Date: Wed, 25 May 2011 14:17:02 +0000
Message-ID: <1306333025-29893-8-git-send-email-artagnon@gmail.com>
References: <1306333025-29893-1-git-send-email-artagnon@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Christian Couder <christian.couder@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed May 25 16:17:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QPEuF-0003uG-M9
	for gcvg-git-2@lo.gmane.org; Wed, 25 May 2011 16:17:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932722Ab1EYORa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 May 2011 10:17:30 -0400
Received: from mail-qy0-f174.google.com ([209.85.216.174]:36798 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932423Ab1EYORT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 May 2011 10:17:19 -0400
Received: by mail-qy0-f174.google.com with SMTP id 7so2121342qyk.19
        for <git@vger.kernel.org>; Wed, 25 May 2011 07:17:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=8w7xipZCLp+HPJG3rtWIssB0xVGZjnXPPqGm8/VBq/M=;
        b=c0VfAxcrduqqA19WDORZq3uaEJgI6hJVgtDeS+N1q9H1hlMIgAFMhggPU54ocKX9XF
         UyrxWzxccmOHNC+KFi+DvIMLGUTCjU2Q4fip9F8lP5+BY7hfdLZIJ/VJBR1bx3eYc1uD
         Gpihngpsc00dQhjSKMNrdBUXwj3xPxAGWgOoI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=NerIaZ6dVZ71B4zB8Jwdl6uEKKvKccs9476+L8ItDeZAXsQDks4hTk+T9UYzvWXveG
         yHrGfq2nHzim2ocPJtmevlyjhkOC9rWjP5NtJq7vU2yY7iYQdi3EDUZKf0OV7ZtBgb/J
         UNxRwRR2zFl5YKfOc0oA2LoqphZx6FFuhhs44=
Received: by 10.229.9.195 with SMTP id m3mr3820153qcm.137.1306333039601;
        Wed, 25 May 2011 07:17:19 -0700 (PDT)
Received: from localhost.localdomain (ec2-184-72-137-52.compute-1.amazonaws.com [184.72.137.52])
        by mx.google.com with ESMTPS id t17sm5285636qcs.35.2011.05.25.07.17.18
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 25 May 2011 07:17:18 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.1
In-Reply-To: <1306333025-29893-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174402>

Earlier, incompatible command-line options used to be caught in
pick_commits after parse_args has parsed the options and populated the
options structure; a lot of unncessary work has already been done, and
significant amount of cleanup is required to die at this stage.
Instead, hand over this responsibility to parse_args so that the
program can die early.  Also write a die_opt_incompabile function to
handle incompatible options in a general manner; it will be used more
extensively as more command-line options are introduced later in the
series.

Helped-by: Junio C Hamano <gitster@pobox.com>
Helped-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 builtin/revert.c |   34 +++++++++++++++++++++++-----------
 1 files changed, 23 insertions(+), 11 deletions(-)

diff --git a/builtin/revert.c b/builtin/revert.c
index 9a612c6..d21af96 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -80,6 +80,22 @@ static int option_parse_x(const struct option *opt,
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
@@ -116,6 +132,13 @@ static void parse_args(int argc, const char **argv, struct replay_opts *opts)
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
 
@@ -567,17 +590,6 @@ static int pick_commits(struct replay_opts *opts)
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
 	read_and_refresh_cache(me, opts);
 
 	prepare_revs(&revs, opts);
-- 
1.7.5.GIT
