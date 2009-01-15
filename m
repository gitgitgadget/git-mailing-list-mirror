From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH] checkout: implement "-" shortcut name for last branch
Date: Thu, 15 Jan 2009 01:06:16 +0100
Message-ID: <1231977976-8739-1-git-send-email-trast@student.ethz.ch>
Cc: Junio C Hamano <junio@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 15 01:07:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LNFlk-00039y-AI
	for gcvg-git-2@gmane.org; Thu, 15 Jan 2009 01:07:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757013AbZAOAGM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Jan 2009 19:06:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755175AbZAOAGK
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Jan 2009 19:06:10 -0500
Received: from xsmtp0.ethz.ch ([82.130.70.14]:26620 "EHLO XSMTP0.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754135AbZAOAGJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jan 2009 19:06:09 -0500
Received: from xfe0.d.ethz.ch ([82.130.124.40]) by XSMTP0.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 15 Jan 2009 01:06:07 +0100
Received: from localhost.localdomain ([84.75.148.62]) by xfe0.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 15 Jan 2009 01:06:07 +0100
X-Mailer: git-send-email 1.6.1.282.gae4091.dirty
X-OriginalArrivalTime: 15 Jan 2009 00:06:07.0190 (UTC) FILETIME=[104C7F60:01C976A5]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105734>

Let git-checkout save the old branch as a symref in LAST_HEAD, and
make 'git checkout -' switch back to LAST_HEAD, like 'cd -' does in
the shell.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---

I really wished I had this earlier today.  I'm just not sure if it's a
good idea, or even possible, to reserve the '-'.  I can't seem to
check out a branch '-foo' with git-checkout, but it's easy to create
one with 'git branch -- -foo'.  git-check-ref-format(1) doesn't forbid
it either, although the actual 'git check-ref-format -foo' exits with
status 1.

 Documentation/git-checkout.txt         |    3 +++
 Documentation/gitrepository-layout.txt |    4 ++++
 builtin-checkout.c                     |   26 +++++++++++++++++++++++++-
 3 files changed, 32 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkout.txt
index 9cd5151..1397745 100644
--- a/Documentation/git-checkout.txt
+++ b/Documentation/git-checkout.txt
@@ -133,6 +133,9 @@ the conflicted merge in the specified paths.
 +
 When this parameter names a non-branch (but still a valid commit object),
 your HEAD becomes 'detached'.
++
+You may also specify "`-`", which denotes the last branch you were on
+before the current HEAD.
 
 
 Detached HEAD
diff --git a/Documentation/gitrepository-layout.txt b/Documentation/gitrepository-layout.txt
index 1befca9..f506c98 100644
--- a/Documentation/gitrepository-layout.txt
+++ b/Documentation/gitrepository-layout.txt
@@ -123,6 +123,10 @@ is often called 'detached HEAD', and almost all commands work
 identically as normal.  See linkgit:git-checkout[1] for
 details.
 
+LAST_HEAD::
+	A symref that holds the value of HEAD before the last
+	branch switch.
+
 branches::
 	A slightly deprecated way to store shorthands to be used
 	to specify URL to 'git-fetch', 'git-pull' and 'git-push'
diff --git a/builtin-checkout.c b/builtin-checkout.c
index b5dd9c0..356ad6c 100644
--- a/builtin-checkout.c
+++ b/builtin-checkout.c
@@ -480,6 +480,15 @@ static void report_tracking(struct branch_info *new)
 	strbuf_release(&sb);
 }
 
+static void save_old_branch(struct branch_info *old, char *msg)
+{
+	if (old->path) {
+		create_symref("LAST_HEAD", old->path, msg);
+	} else
+		update_ref(msg, "LAST_HEAD", old->commit->object.sha1, NULL,
+			   REF_NODEREF, DIE_ON_ERR);
+}
+
 static void update_refs_for_switch(struct checkout_opts *opts,
 				   struct branch_info *old,
 				   struct branch_info *new)
@@ -505,12 +514,15 @@ static void update_refs_for_switch(struct checkout_opts *opts,
 			if (old->path && !strcmp(new->path, old->path))
 				fprintf(stderr, "Already on \"%s\"\n",
 					new->name);
-			else
+			else {
 				fprintf(stderr, "Switched to%s branch \"%s\"\n",
 					opts->new_branch ? " a new" : "",
 					new->name);
+				save_old_branch(old, msg.buf);
+			}
 		}
 	} else if (strcmp(new->name, "HEAD")) {
+		save_old_branch(old, msg.buf);
 		update_ref(msg.buf, "HEAD", new->commit->object.sha1, NULL,
 			   REF_NODEREF, DIE_ON_ERR);
 		if (!opts->quiet) {
@@ -533,6 +545,8 @@ static int switch_branches(struct checkout_opts *opts, struct branch_info *new)
 	int flag;
 	memset(&old, 0, sizeof(old));
 	old.path = resolve_ref("HEAD", rev, 0, &flag);
+	if (old.path)
+		old.path = strdup(old.path);
 	old.commit = lookup_commit_reference_gently(rev, 1);
 	if (!(flag & REF_ISSYMREF))
 		old.path = NULL;
@@ -604,6 +618,7 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 		OPT_END(),
 	};
 	int has_dash_dash;
+	int flag;
 
 	memset(&opts, 0, sizeof(opts));
 	memset(&new, 0, sizeof(new));
@@ -671,6 +686,15 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 		arg = argv[0];
 		has_dash_dash = (argc > 1) && !strcmp(argv[1], "--");
 
+		if (!strcmp(arg, "-")) {
+			arg = resolve_ref("LAST_HEAD", rev, 0, &flag);
+			if (!arg)
+				die("No last branch saved.");
+			if(!prefixcmp(arg, "refs/heads/"))
+				arg += 11;
+			arg = strdup(arg);
+		}
+
 		if (get_sha1(arg, rev)) {
 			if (has_dash_dash)          /* case (1) */
 				die("invalid reference: %s", arg);
-- 
1.6.1.282.gae4091.dirty
