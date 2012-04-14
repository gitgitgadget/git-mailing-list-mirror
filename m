From: Clemens Buchacher <drizzd@aon.at>
Subject: [PATCH] cherry-pick: do not expect file arguments
Date: Sat, 14 Apr 2012 21:04:48 +0200
Message-ID: <20120414190448.GA26209@ecki>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 14 21:06:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SJ8IT-0002Uy-QA
	for gcvg-git-2@plane.gmane.org; Sat, 14 Apr 2012 21:06:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753761Ab2DNTGE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Apr 2012 15:06:04 -0400
Received: from smtpout15.highway.telekom.at ([195.3.96.90]:42956 "EHLO
	email.aon.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752253Ab2DNTGD (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Apr 2012 15:06:03 -0400
Received: (qmail 15093 invoked from network); 14 Apr 2012 19:06:01 -0000
X-Spam-Checker-Version: SpamAssassin 3.2.0 (2007-05-01) on
	WARSBL606.highway.telekom.at
X-Spam-Level: ****
Received: from p5b22d2b0.dip.t-dialin.net (HELO [127.0.0.1]) (aon.912301525.1@aon.at@[91.34.210.176])
          (envelope-sender <drizzd@aon.at>)
          by smarthub81.res.a1.net (qmail-ldap-1.03) with AES128-SHA encrypted SMTP
          for <git@vger.kernel.org>; 14 Apr 2012 19:06:00 -0000
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195505>

If a commit-ish passed to cherry-pick or revert happens to have a file
of the same name, git complains that the argument is ambiguous and
advises to use '--'. To make things worse, the '--' argument is removed
by parse_options, und so passing '--' has no effect.

Instead, always interpret cherry-pick/revert arguments as revisions.

Signed-off-by: Clemens Buchacher <drizzd@aon.at>
---
 builtin/revert.c |    5 ++++-
 revision.c       |   24 ++++++++++++++----------
 revision.h       |    1 +
 3 files changed, 19 insertions(+), 11 deletions(-)

diff --git a/builtin/revert.c b/builtin/revert.c
index e6840f2..92f3fa5 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -181,12 +181,15 @@ static void parse_args(int argc, const char **argv, struct replay_opts *opts)
 	if (opts->subcommand != REPLAY_NONE) {
 		opts->revs = NULL;
 	} else {
+		struct setup_revision_opt s_r_opt;
 		opts->revs = xmalloc(sizeof(*opts->revs));
 		init_revisions(opts->revs, NULL);
 		opts->revs->no_walk = 1;
 		if (argc < 2)
 			usage_with_options(usage_str, options);
-		argc = setup_revisions(argc, argv, opts->revs, NULL);
+		memset(&s_r_opt, 0, sizeof(s_r_opt));
+		s_r_opt.assume_dashdash = 1;
+		argc = setup_revisions(argc, argv, opts->revs, &s_r_opt);
 	}
 
 	if (argc > 1)
diff --git a/revision.c b/revision.c
index b3554ed..9a0d9c7 100644
--- a/revision.c
+++ b/revision.c
@@ -1715,17 +1715,21 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
 		submodule = opt->submodule;
 
 	/* First, search for "--" */
-	seen_dashdash = 0;
-	for (i = 1; i < argc; i++) {
-		const char *arg = argv[i];
-		if (strcmp(arg, "--"))
-			continue;
-		argv[i] = NULL;
-		argc = i;
-		if (argv[i + 1])
-			append_prune_data(&prune_data, argv + i + 1);
+	if (opt && opt->assume_dashdash) {
 		seen_dashdash = 1;
-		break;
+	} else {
+		seen_dashdash = 0;
+		for (i = 1; i < argc; i++) {
+			const char *arg = argv[i];
+			if (strcmp(arg, "--"))
+				continue;
+			argv[i] = NULL;
+			argc = i;
+			if (argv[i + 1])
+				append_prune_data(&prune_data, argv + i + 1);
+			seen_dashdash = 1;
+			break;
+		}
 	}
 
 	/* Second, deal with arguments and options */
diff --git a/revision.h b/revision.h
index b8e9223..1a08384 100644
--- a/revision.h
+++ b/revision.h
@@ -183,6 +183,7 @@ struct setup_revision_opt {
 	const char *def;
 	void (*tweak)(struct rev_info *, struct setup_revision_opt *);
 	const char *submodule;
+	int assume_dashdash;
 };
 
 extern void init_revisions(struct rev_info *revs, const char *prefix);
-- 
1.7.9.6
