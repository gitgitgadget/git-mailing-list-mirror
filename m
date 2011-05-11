From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 5/8] revert: Catch incompatible command-line options early
Date: Wed, 11 May 2011 13:30:19 +0530
Message-ID: <1305100822-20470-6-git-send-email-artagnon@gmail.com>
References: <1305100822-20470-1-git-send-email-artagnon@gmail.com>
Cc: Christian Couder <chriscool@tuxfamily.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed May 11 18:26:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QKCFM-0007NR-B7
	for gcvg-git-2@lo.gmane.org; Wed, 11 May 2011 18:26:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757557Ab1EKQ0m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 May 2011 12:26:42 -0400
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:8448 "EHLO
	smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757378Ab1EKQ0l (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 May 2011 12:26:41 -0400
X-IronPort-AV: E=Sophos;i="4.64,351,1301875200"; 
   d="scan'208";a="697930919"
Received: from smtp-in-0191.sea3.amazon.com ([10.224.12.28])
  by smtp-border-fw-out-9101.sea19.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 11 May 2011 08:01:07 +0000
Received: from ramkum.desktop.amazon.com (ramkum.desktop.amazon.com [172.25.205.64])
	by smtp-in-0191.sea3.amazon.com (8.13.8/8.13.8) with ESMTP id p4B815hl012991;
	Wed, 11 May 2011 08:01:06 GMT
Received: by ramkum.desktop.amazon.com (Postfix, from userid 272482)
	id A1007754836; Wed, 11 May 2011 13:30:22 +0530 (IST)
X-Mailer: git-send-email 1.7.5.GIT
In-Reply-To: <1305100822-20470-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173404>

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
Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 I think we _should_ die when an error in command-line parsing occurs,
 since it should always be the toplevel caller.  Thanks to Junio for
 redesigning die_opt_incompatible in a sane manner.

 builtin/revert.c |   37 ++++++++++++++++++++++++++-----------
 1 files changed, 26 insertions(+), 11 deletions(-)

diff --git a/builtin/revert.c b/builtin/revert.c
index 288c898..0fe87e8 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -80,10 +80,29 @@ static int option_parse_x(const struct option *opt,
 	return 0;
 }
 
+static void die_opt_incompatible(const char *me, const char *base_opt, ...)
+{
+	const char *this_opt;
+	int this_opt_set;
+	va_list ap;
+
+	va_start(ap, base_opt);
+	while (1) {
+		if (!(this_opt = va_arg(ap, const char *)))
+			break;
+		if ((this_opt_set = va_arg(ap, int)))
+			die(_("%s: %s cannot be used with %s"),
+				me, this_opt, base_opt);
+	}
+	va_end(ap);
+}
+
 static void parse_args(int argc, const char **argv, struct replay_opts *opts)
 {
 	const char *const *usage_str = revert_or_cherry_pick_usage(opts);
+	const char *me = (opts->action == REVERT ? "revert" : "cherry-pick");
 	int noop;
+
 	struct option options[] = {
 		OPT_BOOLEAN('n', "no-commit", &(opts->no_commit), "don't automatically commit"),
 		OPT_BOOLEAN('e', "edit", &(opts->edit), "edit the commit message"),
@@ -121,6 +140,13 @@ static void parse_args(int argc, const char **argv, struct replay_opts *opts)
 	if (opts->commit_argc < 2)
 		usage_with_options(usage_str, options);
 
+	if (opts->allow_ff)
+		die_opt_incompatible(me, "--ff",
+				"--signoff", opts->signoff,
+				"--no-commit", opts->no_commit,
+				"-x", opts->no_replay,
+				"--edit", opts->edit,
+				NULL);
 	opts->commit_argv = argv;
 }
 
@@ -609,17 +635,6 @@ static int pick_commits(struct replay_opts *opts)
 	struct commit *commit;
 	int res;
 
-	if (opts->allow_ff) {
-		if (opts->signoff)
-			die(_("cherry-pick --ff cannot be used with --signoff"));
-		if (opts->no_commit)
-			die(_("cherry-pick --ff cannot be used with --no-commit"));
-		if (opts->no_replay)
-			die(_("cherry-pick --ff cannot be used with -x"));
-		if (opts->edit)
-			die(_("cherry-pick --ff cannot be used with --edit"));
-	}
-
 	if ((res = read_and_refresh_cache(opts)) ||
 		(res = prepare_revs(&revs, opts)))
 		return res;
-- 
1.7.5.GIT
