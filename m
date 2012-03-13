From: Jeff King <peff@peff.net>
Subject: Re: checkout -q not quiet enough
Date: Tue, 13 Mar 2012 16:08:43 -0400
Message-ID: <20120313200842.GA23664@sigill.intra.peff.net>
References: <86aa3k5ppk.fsf@red.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: "Randal L. Schwartz" <merlyn@stonehenge.com>
X-From: git-owner@vger.kernel.org Tue Mar 13 21:08:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S7Y1b-0001fh-0x
	for gcvg-git-2@plane.gmane.org; Tue, 13 Mar 2012 21:08:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752585Ab2CMUIq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Mar 2012 16:08:46 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:48650
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752370Ab2CMUIq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Mar 2012 16:08:46 -0400
Received: (qmail 1584 invoked by uid 107); 13 Mar 2012 20:08:56 -0000
Received: from c-71-206-173-132.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.206.173.132)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 13 Mar 2012 16:08:56 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 13 Mar 2012 16:08:43 -0400
Content-Disposition: inline
In-Reply-To: <86aa3k5ppk.fsf@red.stonehenge.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193064>

On Tue, Mar 13, 2012 at 11:19:03AM -0700, Randal L. Schwartz wrote:

> checkout without -q:
> 
>   Switched to a new branch 'projects/DUH-11'
>   Branch projects/DUH-11 set up to track remote branch projects/DUH-11 from origin.
> 
> checkout with -q:
> 
>   Branch projects/DUH-11 set up to track remote branch projects/DUH-11 from origin.
> 
> Bug or feature?  If feature, how do I get it "more q'ey"?

Bug, I think. You'd need something like the patch below, except that:

  1. It should probably collapse the many options to create_branch into
     a "flags" field.

  2. git-branch should probably learn "-q", as well, to suppress the
     same message.

---
diff --git a/branch.c b/branch.c
index 9971820..796da08 100644
--- a/branch.c
+++ b/branch.c
@@ -101,7 +101,7 @@ void install_branch_config(int flag, const char *local, const char *origin, cons
  * config.
  */
 static int setup_tracking(const char *new_ref, const char *orig_ref,
-                          enum branch_track track)
+			  enum branch_track track, int flags)
 {
 	struct tracking tracking;
 
@@ -128,7 +128,7 @@ static int setup_tracking(const char *new_ref, const char *orig_ref,
 		return error("Not tracking: ambiguous information for ref %s",
 				orig_ref);
 
-	install_branch_config(BRANCH_CONFIG_VERBOSE, new_ref, tracking.remote,
+	install_branch_config(flags, new_ref, tracking.remote,
 			      tracking.src ? tracking.src : orig_ref);
 
 	free(tracking.src);
@@ -191,7 +191,7 @@ int validate_new_branchname(const char *name, struct strbuf *ref,
 void create_branch(const char *head,
 		   const char *name, const char *start_name,
 		   int force, int reflog, int clobber_head,
-		   enum branch_track track)
+		   int quiet, enum branch_track track)
 {
 	struct ref_lock *lock = NULL;
 	struct commit *commit;
@@ -201,6 +201,7 @@ void create_branch(const char *head,
 	int forcing = 0;
 	int dont_change_ref = 0;
 	int explicit_tracking = 0;
+	int tracking_flags = quiet ? 0 : BRANCH_CONFIG_VERBOSE;
 
 	if (track == BRANCH_TRACK_EXPLICIT || track == BRANCH_TRACK_OVERRIDE)
 		explicit_tracking = 1;
@@ -260,7 +261,7 @@ void create_branch(const char *head,
 			 start_name);
 
 	if (real_ref && track)
-		setup_tracking(ref.buf+11, real_ref, track);
+		setup_tracking(ref.buf+11, real_ref, track, tracking_flags);
 
 	if (!dont_change_ref)
 		if (write_ref_sha1(lock, sha1, msg) < 0)
diff --git a/branch.h b/branch.h
index b99c5a3..923fc34 100644
--- a/branch.h
+++ b/branch.h
@@ -13,8 +13,8 @@
  * branch for (if any).
  */
 void create_branch(const char *head, const char *name, const char *start_name,
-		   int force, int reflog,
-		   int clobber_head, enum branch_track track);
+		   int force, int reflog, int clobber_head, int quiet,
+		   enum branch_track track);
 
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
