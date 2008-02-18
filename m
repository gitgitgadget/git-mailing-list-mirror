From: Jay Soffian <jaysoffian@gmail.com>
Subject: [PATCH] branch: optionally setup branch.*.merge from upstream local branches
Date: Mon, 18 Feb 2008 07:04:08 -0500
Message-ID: <1203336248-9308-1-git-send-email-jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Jay Soffian <jaysoffian@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 18 13:05:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JR4jr-0002Tg-I0
	for gcvg-git-2@gmane.org; Mon, 18 Feb 2008 13:04:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757686AbYBRMEP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Feb 2008 07:04:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756601AbYBRMEP
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Feb 2008 07:04:15 -0500
Received: from an-out-0708.google.com ([209.85.132.243]:9104 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755355AbYBRMEO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Feb 2008 07:04:14 -0500
Received: by an-out-0708.google.com with SMTP id d31so380537and.103
        for <git@vger.kernel.org>; Mon, 18 Feb 2008 04:04:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references:mime-version:content-type:content-transfer-encoding;
        bh=s0+XHSsoUTtqmfhnoSDYccCYmDHdTB4u/nIpD+mVvvY=;
        b=BKCr4kBnUU4dgSywti4uZbLKqfoBqdflfZbZsanymGJnlLO2SgmkgBVzyYobvK9FM8OT3oPI0r5gDihFNQ4ClzYFUAXHBmdRh9KcblM5cGsbDMaKVq2fbJ8S3L/gJt/ElYzDJnvC7DFDchXIytofKVA/IkSu1558901ULa4Wfjk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references:mime-version:content-type:content-transfer-encoding;
        b=XMQU49WFPWjNd1MNBi86/xPbFi1gakxlaBRBToOVfVXDVGvbNqHB/gQGQhq/WwCKewdyuCL/RJKo5nnJW8B3MnpJFzSwh27oQPw+AB3sOTGI/1XUqYlCQOPeCyaxYk8YnVZ7e2wT14sEp7O1GKZgOyO8zHsJevs8efmfTlzjyU8=
Received: by 10.100.31.3 with SMTP id e3mr11262330ane.1.1203336251506;
        Mon, 18 Feb 2008 04:04:11 -0800 (PST)
Received: from localhost ( [75.189.159.45])
        by mx.google.com with ESMTPS id b18sm13395492ana.14.2008.02.18.04.04.09
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 18 Feb 2008 04:04:10 -0800 (PST)
X-Mailer: git-send-email 1.5.4.2.183.g9fe5b
In-Reply-To: 1203133557-50013-1-git-send-email-jaysoffian@gmail.com
References: 1203133557-50013-1-git-send-email-jaysoffian@gmail.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74271>

git branch / git checkout -b now honor --track when the upstream branch
is local. Previously --track was silently ignored for local upstream
branches.

The configuration setting branch.autosetupmerge can now be set to
"always" which is equivalent to using --track. Setting
branch.autosetupmerge to boolean true will retains the former behavior
of only setting up branch.*.merge for remote upstream branches.

Signed-off-by: Jay Soffian <jaysoffian@gmail.com>
---
On Feb 16, 2008 6:45 AM, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> Hi,
> 
> On Fri, 15 Feb 2008, Junio C Hamano wrote:
> 
> > This area was last cleaned up in 6f084a5 (branch --track: code cleanup
> > and saner handling of local branches).  I do not know if the original
> > intention of the code was to allow a hack like this to work, or it is
> > just an unintended accident that it happens to work.  Dscho, any ideas?
> 
> AFAIR the problem was that you were (rightfully) annoyed when you were
> setting up your local branches, and all of a sudden, they were set up with
> loads of tracking information, cluttering your config.
> 
> Basically, that is the reason why we disallowed tracking information to be
> set up for local branching.

Hopefully this is an acceptable compromise? Junio suggested making this 
implicit:

   [remote "."]
      fetch = refs/*:refs/*

But I thought that might affect other areas, and I don't think this is too bad.

 branch.c           |   12 ++++++++++--
 branch.h           |    8 +++++++-
 builtin-branch.c   |   11 ++++++++---
 builtin-checkout.c |   15 ++++++++++-----
 4 files changed, 35 insertions(+), 11 deletions(-)

diff --git a/branch.c b/branch.c
index 1fc8788..24e98dd 100644
--- a/branch.c
+++ b/branch.c
@@ -71,7 +71,7 @@ static int setup_tracking(const char *new_ref, const char *orig_ref)
 
 void create_branch(const char *head,
 		   const char *name, const char *start_name,
-		   int force, int reflog, int track)
+		   int force, int reflog, enum branch_track track)
 {
 	struct ref_lock *lock;
 	struct commit *commit;
@@ -130,7 +130,15 @@ void create_branch(const char *head,
 	   automatically merges from there.  So far, this is only done for
 	   remotes registered via .git/config.  */
 	if (real_ref && track)
-		setup_tracking(name, real_ref);
+		if (setup_tracking(name, real_ref) == 1 && track == BRANCH_TRACK_ALWAYS) {
+			char key[1024];
+			sprintf(key, "branch.%s.remote", name);
+			git_config_set(key, ".");
+			sprintf(key, "branch.%s.merge", name);
+			git_config_set(key, real_ref);
+			printf("Branch %s set up with upstream branch %s.\n",
+			       name, real_ref);
+		}
 
 	if (write_ref_sha1(lock, sha1, msg) < 0)
 		die("Failed to write ref: %s.", strerror(errno));
diff --git a/branch.h b/branch.h
index d30abe0..771d6ce 100644
--- a/branch.h
+++ b/branch.h
@@ -1,6 +1,12 @@
 #ifndef BRANCH_H
 #define BRANCH_H
 
+enum branch_track {
+	BRANCH_TRACK_FALSE = 0,
+	BRANCH_TRACK_TRUE = 1,
+	BRANCH_TRACK_ALWAYS = 2,
+};
+
 /* Functions for acting on the information about branches. */
 
 /*
@@ -13,7 +19,7 @@
  * branch for (if any).
  */
 void create_branch(const char *head, const char *name, const char *start_name,
-		   int force, int reflog, int track);
+		   int force, int reflog, enum branch_track track);
 
 /*
  * Remove information about the state of working on the current
diff --git a/builtin-branch.c b/builtin-branch.c
index 5094e0d..231bff4 100644
--- a/builtin-branch.c
+++ b/builtin-branch.c
@@ -30,7 +30,7 @@ static const char * const builtin_branch_usage[] = {
 static const char *head;
 static unsigned char head_sha1[20];
 
-static int branch_track = 1;
+static enum branch_track branch_track = BRANCH_TRACK_FALSE;
 
 static int branch_use_color;
 static char branch_colors[][COLOR_MAXLEN] = {
@@ -77,6 +77,10 @@ static int git_branch_config(const char *var, const char *value)
 		return 0;
 	}
 	if (!strcmp(var, "branch.autosetupmerge")) {
+		if (value && !strcasecmp(value, "always")) {
+			branch_track = BRANCH_TRACK_ALWAYS;
+			return 0;
+		}
 		branch_track = git_config_bool(var, value);
 		return 0;
 	}
@@ -420,14 +424,15 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 {
 	int delete = 0, rename = 0, force_create = 0;
 	int verbose = 0, abbrev = DEFAULT_ABBREV, detached = 0;
-	int reflog = 0, track;
+	int reflog = 0;
+	enum branch_track track;
 	int kinds = REF_LOCAL_BRANCH;
 	struct commit_list *with_commit = NULL;
 
 	struct option options[] = {
 		OPT_GROUP("Generic options"),
 		OPT__VERBOSE(&verbose),
-		OPT_BOOLEAN( 0 , "track",  &track, "set up tracking mode (see git-pull(1))"),
+		OPT_SET_INT( 0 , "track",  &track, "set up tracking mode (see git-pull(1))", BRANCH_TRACK_ALWAYS),
 		OPT_BOOLEAN( 0 , "color",  &branch_use_color, "use colored output"),
 		OPT_SET_INT('r', NULL,     &kinds, "act on remote-tracking branches",
 			REF_REMOTE_BRANCH),
diff --git a/builtin-checkout.c b/builtin-checkout.c
index 0d19835..d77ee9c 100644
--- a/builtin-checkout.c
+++ b/builtin-checkout.c
@@ -186,7 +186,7 @@ struct checkout_opts {
 
 	char *new_branch;
 	int new_branch_log;
-	int track;
+	enum branch_track track;
 };
 
 struct branch_info {
@@ -521,13 +521,18 @@ static int switch_branches(struct checkout_opts *opts,
 	return post_checkout_hook(old.commit, new->commit, 1);
 }
 
-static int branch_track = 0;
+static enum branch_track branch_track = BRANCH_TRACK_FALSE;
 
 static int git_checkout_config(const char *var, const char *value)
 {
-	if (!strcmp(var, "branch.autosetupmerge"))
+	if (!strcmp(var, "branch.autosetupmerge")) {
+		if (value && !strcasecmp(value, "always")) {
+			branch_track = BRANCH_TRACK_ALWAYS;
+			return 0;
+		}
 		branch_track = git_config_bool(var, value);
-
+		return 0;
+	}
 	return git_default_config(var, value);
 }
 
@@ -542,7 +547,7 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 		OPT__QUIET(&opts.quiet),
 		OPT_STRING('b', NULL, &opts.new_branch, "new branch", "branch"),
 		OPT_BOOLEAN('l', NULL, &opts.new_branch_log, "log for new branch"),
-		OPT_BOOLEAN( 0 , "track", &opts.track, "track"),
+		OPT_SET_INT( 0 , "track",  &opts.track, "track", BRANCH_TRACK_ALWAYS),
 		OPT_BOOLEAN('f', NULL, &opts.force, "force"),
 		OPT_BOOLEAN('m', NULL, &opts.merge, "merge"),
 		OPT_END(),
-- 
1.5.4.2.183.g9fe5b
