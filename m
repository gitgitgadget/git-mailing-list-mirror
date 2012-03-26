From: Jeff King <peff@peff.net>
Subject: [PATCH 1/2] checkout: suppress tracking message with "-q"
Date: Mon, 26 Mar 2012 19:51:01 -0400
Message-ID: <20120326235101.GA23290@sigill.intra.peff.net>
References: <20120326234944.GA1901@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: "Randal L. Schwartz" <merlyn@stonehenge.com>
X-From: git-owner@vger.kernel.org Tue Mar 27 01:51:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SCJgu-0001fp-S9
	for gcvg-git-2@plane.gmane.org; Tue, 27 Mar 2012 01:51:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932065Ab2CZXvH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Mar 2012 19:51:07 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:60282
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757802Ab2CZXvG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Mar 2012 19:51:06 -0400
Received: (qmail 20107 invoked by uid 107); 26 Mar 2012 23:51:24 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 26 Mar 2012 19:51:24 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 26 Mar 2012 19:51:01 -0400
Content-Disposition: inline
In-Reply-To: <20120326234944.GA1901@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193990>

Like the "switched to..." message (which is already
suppressed by "-q"), this message is purely informational.
Let's silence it if the user asked us to be quiet.

This patch is slightly more than a one-liner, because we
have to teach create_branch to propagate the flag all the
way down to install_branch_config.

Signed-off-by: Jeff King <peff@peff.net>
---
 branch.c           |    9 +++++----
 branch.h           |    2 +-
 builtin/branch.c   |    2 +-
 builtin/checkout.c |    1 +
 4 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/branch.c b/branch.c
index 9971820..eccdaf9 100644
--- a/branch.c
+++ b/branch.c
@@ -101,9 +101,10 @@ void install_branch_config(int flag, const char *local, const char *origin, cons
  * config.
  */
 static int setup_tracking(const char *new_ref, const char *orig_ref,
-                          enum branch_track track)
+			  enum branch_track track, int quiet)
 {
 	struct tracking tracking;
+	int config_flags = quiet ? 0 : BRANCH_CONFIG_VERBOSE;
 
 	if (strlen(new_ref) > 1024 - 7 - 7 - 1)
 		return error("Tracking not set up: name too long: %s",
@@ -128,7 +129,7 @@ static int setup_tracking(const char *new_ref, const char *orig_ref,
 		return error("Not tracking: ambiguous information for ref %s",
 				orig_ref);
 
-	install_branch_config(BRANCH_CONFIG_VERBOSE, new_ref, tracking.remote,
+	install_branch_config(config_flags, new_ref, tracking.remote,
 			      tracking.src ? tracking.src : orig_ref);
 
 	free(tracking.src);
@@ -191,7 +192,7 @@ int validate_new_branchname(const char *name, struct strbuf *ref,
 void create_branch(const char *head,
 		   const char *name, const char *start_name,
 		   int force, int reflog, int clobber_head,
-		   enum branch_track track)
+		   int quiet, enum branch_track track)
 {
 	struct ref_lock *lock = NULL;
 	struct commit *commit;
@@ -260,7 +261,7 @@ void create_branch(const char *head,
 			 start_name);
 
 	if (real_ref && track)
-		setup_tracking(ref.buf+11, real_ref, track);
+		setup_tracking(ref.buf+11, real_ref, track, quiet);
 
 	if (!dont_change_ref)
 		if (write_ref_sha1(lock, sha1, msg) < 0)
diff --git a/branch.h b/branch.h
index b99c5a3..64173ab 100644
--- a/branch.h
+++ b/branch.h
@@ -14,7 +14,7 @@
  */
 void create_branch(const char *head, const char *name, const char *start_name,
 		   int force, int reflog,
-		   int clobber_head, enum branch_track track);
+		   int clobber_head, int quiet, enum branch_track track);
 
 /*
  * Validates that the requested branch may be created, returning the
diff --git a/builtin/branch.c b/builtin/branch.c
index d8cccf7..f1eaf1e 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -808,7 +808,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 		if (kinds != REF_LOCAL_BRANCH)
 			die(_("-a and -r options to 'git branch' do not make sense with a branch name"));
 		create_branch(head, argv[0], (argc == 2) ? argv[1] : head,
-			      force_create, reflog, 0, track);
+			      force_create, reflog, 0, 0, track);
 	} else
 		usage_with_options(builtin_branch_usage, options);
 
diff --git a/builtin/checkout.c b/builtin/checkout.c
index 6b9061f..23fc56d 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -543,6 +543,7 @@ static void update_refs_for_switch(struct checkout_opts *opts,
 				      opts->new_branch_force ? 1 : 0,
 				      opts->new_branch_log,
 				      opts->new_branch_force ? 1 : 0,
+				      opts->quiet,
 				      opts->track);
 		new->name = opts->new_branch;
 		setup_branch_path(new);
-- 
1.7.10.rc2.3.g0850
