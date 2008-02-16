From: Jay Soffian <jaysoffian@gmail.com>
Subject: [RFC PATCH 2/2] new --rebase option to set branch.*.rebase for new branches
Date: Fri, 15 Feb 2008 22:45:57 -0500
Message-ID: <1203133557-50013-2-git-send-email-jaysoffian@gmail.com>
References: <1203133557-50013-1-git-send-email-jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Jay Soffian <jaysoffian@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 16 04:46:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JQE0i-00008B-KD
	for gcvg-git-2@gmane.org; Sat, 16 Feb 2008 04:46:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758450AbYBPDqK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Feb 2008 22:46:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759321AbYBPDqI
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Feb 2008 22:46:08 -0500
Received: from an-out-0708.google.com ([209.85.132.247]:24634 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758377AbYBPDqE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Feb 2008 22:46:04 -0500
Received: by an-out-0708.google.com with SMTP id d31so204331and.103
        for <git@vger.kernel.org>; Fri, 15 Feb 2008 19:46:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references:mime-version:content-type:content-transfer-encoding;
        bh=3cNASki0fG9kcDT5uLpBTodxxLxnfGs4Zryft58DWBw=;
        b=w9RYS1mTH0muj8zl+wTpQXWTGUDigVoBUqOFUikgYWIg7z5K3fldw/f+VDEkk9wtmONc0KtfiLSPhbNNZnzffpFVjkwwPjr873fdRdI0Szhm+p8V1T1vVTN8f3ZcRgQDAETZVyrzvK7w3YQD8WkPZiirdtW5cE9c1ldoypYZcWU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references:mime-version:content-type:content-transfer-encoding;
        b=UJ3XN6NTS2BjpJVzO/yCX6NwNaKTXzQ696SYJOp65qYkQpZueuwUc23yV2cEUmW+oHS+8j80V4npBSTv3i/eUkAXOeMUUcVj/aSWFZOLvExeP+Cx3Mtq2koQqTcF4+SUdDSIldodilVl0rW19uybj5P9nDacNf+NlHtdbG9+M6Y=
Received: by 10.100.13.2 with SMTP id 2mr5417217anm.2.1203133562717;
        Fri, 15 Feb 2008 19:46:02 -0800 (PST)
Received: from localhost ( [75.189.159.45])
        by mx.google.com with ESMTPS id d25sm9476751and.2.2008.02.15.19.46.00
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 15 Feb 2008 19:46:01 -0800 (PST)
X-Mailer: git-send-email 1.5.4.1.1281.g75df
In-Reply-To: <1203133557-50013-1-git-send-email-jaysoffian@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74004>

Add a --rebase option to git-branch and git-checkout. If given, it
implies --track but additionally sets branch.<newbranch>.rebase to true.

Signed-off-by: Jay Soffian <jaysoffian@gmail.com>
---
 builtin-branch.c |   18 ++++++++++++++----
 git-checkout.sh  |   11 ++++++++---
 2 files changed, 22 insertions(+), 7 deletions(-)

diff --git a/builtin-branch.c b/builtin-branch.c
index 94ab195..1404d8b 100644
--- a/builtin-branch.c
+++ b/builtin-branch.c
@@ -393,7 +393,7 @@ static int find_tracked_branch(struct remote *remote, void *priv)
  * to infer the settings for branch.<new_ref>.{remote,merge} from the
  * config.
  */
-static int setup_tracking(const char *new_ref, const char *orig_ref)
+static int setup_tracking(const char *new_ref, const char *orig_ref, int rebase)
 {
 	char key[1024];
 	struct tracking tracking;
@@ -407,6 +407,10 @@ static int setup_tracking(const char *new_ref, const char *orig_ref)
 		git_config_set(key, ".");
 		sprintf(key, "branch.%s.merge", new_ref);
 		git_config_set(key, orig_ref);
+		if (rebase) {
+			sprintf(key, "branch.%s.rebase", new_ref);
+			git_config_set(key, "true");
+		}
 		printf("Branch %s set up to track local branch %s.\n",
 			       new_ref, orig_ref);
 		return 0;
@@ -428,6 +432,10 @@ static int setup_tracking(const char *new_ref, const char *orig_ref)
 		sprintf(key, "branch.%s.merge", new_ref);
 		git_config_set(key, tracking.src);
 		free(tracking.src);
+		if (rebase) {
+			sprintf(key, "branch.%s.rebase", new_ref);
+			git_config_set(key, "true");
+		}
 		printf("Branch %s set up to track remote branch %s.\n",
 			       new_ref, orig_ref);
 	}
@@ -436,7 +444,7 @@ static int setup_tracking(const char *new_ref, const char *orig_ref)
 }
 
 static void create_branch(const char *name, const char *start_name,
-			  int force, int reflog, int track)
+			  int force, int reflog, int track, int rebase)
 {
 	struct ref_lock *lock;
 	struct commit *commit;
@@ -495,7 +503,7 @@ static void create_branch(const char *name, const char *start_name,
 	   automatically merges from there.  So far, this is only done for
 	   remotes registered via .git/config.  */
 	if (real_ref && track)
-		setup_tracking(name, real_ref);
+		setup_tracking(name, real_ref, rebase);
 
 	if (write_ref_sha1(lock, sha1, msg) < 0)
 		die("Failed to write ref: %s.", strerror(errno));
@@ -566,12 +574,14 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 	int verbose = 0, abbrev = DEFAULT_ABBREV, detached = 0;
 	int reflog = 0, track;
 	int kinds = REF_LOCAL_BRANCH;
+	int rebase = 0;
 	struct commit_list *with_commit = NULL;
 
 	struct option options[] = {
 		OPT_GROUP("Generic options"),
 		OPT__VERBOSE(&verbose),
 		OPT_BOOLEAN( 0 , "track",  &track, "set up tracking mode (see git-pull(1))"),
+		OPT_BOOLEAN( 0 , "rebase",  &rebase, "set up branch to rebase (see git-pull(1))"),
 		OPT_BOOLEAN( 0 , "color",  &branch_use_color, "use colored output"),
 		OPT_SET_INT('r', NULL,     &kinds, "act on remote-tracking branches",
 			REF_REMOTE_BRANCH),
@@ -625,7 +635,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 		rename_branch(argv[0], argv[1], rename > 1);
 	else if (argc <= 2)
 		create_branch(argv[0], (argc == 2) ? argv[1] : head,
-			      force_create, reflog, track);
+			      force_create, reflog, track, rebase);
 	else
 		usage_with_options(builtin_branch_usage, options);
 
diff --git a/git-checkout.sh b/git-checkout.sh
index bd74d70..569e29c 100755
--- a/git-checkout.sh
+++ b/git-checkout.sh
@@ -7,6 +7,7 @@ git-checkout [options] [<branch>] [<paths>...]
 b=          create a new branch started at <branch>
 l           create the new branch's reflog
 track       arrange that the new branch tracks the remote branch
+rebase      arrange that the new branch rebases
 f           proceed even if the index or working tree is not HEAD
 m           merge local modifications into the new branch
 q,quiet     be quiet
@@ -23,6 +24,7 @@ new_name=
 force=
 branch=
 track=
+rebase=
 newbranch=
 newbranch_log=
 merge=
@@ -49,6 +51,9 @@ while test $# != 0; do
 	--track|--no-track)
 		track="$1"
 		;;
+	--rebase)
+		rebase="$1"
+		;;
 	-f)
 		force=1
 		;;
@@ -92,9 +97,9 @@ then
 fi
 [ "$1" = "--" ] && shift
 
-case "$newbranch,$track" in
+case "$newbranch,$track,$rebase" in
 ,--*)
-	die "git checkout: --track and --no-track require -b"
+	die "git checkout: --track, --no-track and --rebase require -b"
 esac
 
 case "$force$merge" in
@@ -261,7 +266,7 @@ fi
 #
 if [ "$?" -eq 0 ]; then
 	if [ "$newbranch" ]; then
-		git branch $track $newbranch_log "$newbranch" "$new_name" || exit
+		git branch $track $rebase $newbranch_log "$newbranch" "$new_name" || exit
 		branch="$newbranch"
 	fi
 	if test -n "$branch"
-- 
1.5.4.1.1281.g75df
