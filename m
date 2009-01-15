From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH v2] checkout: implement "-" shortcut name for last branch
Date: Thu, 15 Jan 2009 01:12:02 +0100
Message-ID: <1231978322-21228-1-git-send-email-trast@student.ethz.ch>
References: <1231977976-8739-1-git-send-email-trast@student.ethz.ch>
Cc: Junio C Hamano <junio@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 15 01:13:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LNFrJ-0004z5-7E
	for gcvg-git-2@gmane.org; Thu, 15 Jan 2009 01:13:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758018AbZAOALx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Jan 2009 19:11:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757604AbZAOALx
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Jan 2009 19:11:53 -0500
Received: from xsmtp0.ethz.ch ([82.130.70.14]:27268 "EHLO XSMTP0.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755474AbZAOALw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jan 2009 19:11:52 -0500
Received: from xfe0.d.ethz.ch ([82.130.124.40]) by XSMTP0.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 15 Jan 2009 01:11:50 +0100
Received: from localhost.localdomain ([84.75.148.62]) by xfe0.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 15 Jan 2009 01:11:50 +0100
X-Mailer: git-send-email 1.6.1.282.gae4091.dirty
In-Reply-To: <1231977976-8739-1-git-send-email-trast@student.ethz.ch>
X-OriginalArrivalTime: 15 Jan 2009 00:11:50.0632 (UTC) FILETIME=[DD019680:01C976A5]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105735>

Let git-checkout save the old branch as a symref in LAST_HEAD, and
make 'git checkout -' switch back to LAST_HEAD, like 'cd -' does in
the shell.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---

Bah, sorry.  I managed to keep it uncommitted AGAIN.

But this fixed version passes tests.  All of them.  Really!  ;-)


 Documentation/git-checkout.txt         |    3 ++
 Documentation/gitrepository-layout.txt |    4 ++
 builtin-checkout.c                     |   27 ++++++++++++++++-
 t/t2012-checkout-last.sh               |   50 ++++++++++++++++++++++++++++++++
 4 files changed, 83 insertions(+), 1 deletions(-)
 create mode 100755 t/t2012-checkout-last.sh

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
index b5dd9c0..da74831 100644
--- a/builtin-checkout.c
+++ b/builtin-checkout.c
@@ -480,6 +480,16 @@ static void report_tracking(struct branch_info *new)
 	strbuf_release(&sb);
 }
 
+static void save_old_branch(struct branch_info *old, char *msg)
+{
+	if (old->path) {
+		create_symref("LAST_HEAD", old->path, msg);
+	} else if (old->commit) {
+		update_ref(msg, "LAST_HEAD", old->commit->object.sha1, NULL,
+			   REF_NODEREF, DIE_ON_ERR);
+	}
+}
+
 static void update_refs_for_switch(struct checkout_opts *opts,
 				   struct branch_info *old,
 				   struct branch_info *new)
@@ -505,12 +515,15 @@ static void update_refs_for_switch(struct checkout_opts *opts,
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
@@ -533,6 +546,8 @@ static int switch_branches(struct checkout_opts *opts, struct branch_info *new)
 	int flag;
 	memset(&old, 0, sizeof(old));
 	old.path = resolve_ref("HEAD", rev, 0, &flag);
+	if (old.path)
+		old.path = strdup(old.path);
 	old.commit = lookup_commit_reference_gently(rev, 1);
 	if (!(flag & REF_ISSYMREF))
 		old.path = NULL;
@@ -604,6 +619,7 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 		OPT_END(),
 	};
 	int has_dash_dash;
+	int flag;
 
 	memset(&opts, 0, sizeof(opts));
 	memset(&new, 0, sizeof(new));
@@ -671,6 +687,15 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
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
diff --git a/t/t2012-checkout-last.sh b/t/t2012-checkout-last.sh
new file mode 100755
index 0000000..320f6eb
--- /dev/null
+++ b/t/t2012-checkout-last.sh
@@ -0,0 +1,50 @@
+#!/bin/sh
+
+test_description='checkout can switch to last branch'
+
+. ./test-lib.sh
+
+test_expect_success 'setup' '
+	echo hello >world &&
+	git add world &&
+	git commit -m initial &&
+	git branch other &&
+	echo "hello again" >>world &&
+	git add world &&
+	git commit -m second
+'
+
+test_expect_success '"checkout -" does not work initially' '
+	test_must_fail git checkout -
+'
+
+test_expect_success 'first branch switch' '
+	git checkout other
+'
+
+test_expect_success '"checkout -" switches back' '
+	git checkout - &&
+	test "z$(git symbolic-ref HEAD)" = "zrefs/heads/master"
+'
+
+test_expect_success '"checkout -" switches forth' '
+	git checkout - &&
+	test "z$(git symbolic-ref HEAD)" = "zrefs/heads/other"
+'
+
+test_expect_success 'detach HEAD' '
+	git checkout $(git rev-parse HEAD)
+'
+
+test_expect_success '"checkout -" attaches again' '
+	git checkout - &&
+	test "z$(git symbolic-ref HEAD)" = "zrefs/heads/other"
+'
+
+test_expect_success '"checkout -" detaches again' '
+	git checkout - &&
+	test "z$(git rev-parse HEAD)" = "z$(git rev-parse other)" &&
+	test_must_fail git symbolic-ref HEAD
+'
+
+test_done
-- 
1.6.1.282.gae4091.dirty
