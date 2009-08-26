From: "Kirill A. Korinskiy" <catap@catap.ru>
Subject: [PATCH] Add option -b/--branch to clone for select a new HEAD
Date: Wed, 26 Aug 2009 18:46:47 +0400
Message-ID: <1251298007-18693-1-git-send-email-catap@catap.ru>
References: <20090826121600.GA29098@atjola.homenet>
Cc: git@vger.kernel.org, "Kirill A. Korinskiy" <catap@catap.ru>
To: B.Steinbrink@gmx.de
X-From: git-owner@vger.kernel.org Wed Aug 26 16:48:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MgJnm-0007Qq-4A
	for gcvg-git-2@lo.gmane.org; Wed, 26 Aug 2009 16:48:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751123AbZHZOr6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Aug 2009 10:47:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750980AbZHZOr6
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Aug 2009 10:47:58 -0400
Received: from mx.catap.ru ([85.25.165.176]:34182 "EHLO mx.catap.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750895AbZHZOr5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Aug 2009 10:47:57 -0400
Received: from [195.218.191.52] (helo=satellite.home.catap.ru)
	by mx.catap.ru with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <catap@satellite.home.catap.ru>)
	id 1MgJmz-0003DI-Ka; Wed, 26 Aug 2009 18:47:53 +0400
Received: from catap by satellite.home.catap.ru with local (Exim 4.69)
	(envelope-from <catap@satellite.home.catap.ru>)
	id 1MgJlv-0004sE-Cs; Wed, 26 Aug 2009 18:46:47 +0400
X-Mailer: git-send-email 1.6.2
In-Reply-To: <20090826121600.GA29098@atjola.homenet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127101>

Sometimes (especially on production systems) we need to use only one
remote branch for building software. It's really annoying to clone
origin and then switch branch by hand everytime. So this patch
provides functionality to clone a remote branch with one command
without using checkout after clone.

Signed-off-by: Kirill A. Korinskiy <catap@catap.ru>
---
 Documentation/git-clone.txt |    5 ++++
 builtin-clone.c             |   25 ++++++++++++++++++---
 t/t5706-clone-branch.sh     |   49 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 75 insertions(+), 4 deletions(-)
 create mode 100755 t/t5706-clone-branch.sh

diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
index 2c63a0f..5cd106c 100644
--- a/Documentation/git-clone.txt
+++ b/Documentation/git-clone.txt
@@ -127,6 +127,11 @@ objects from the source repository into a pack in the cloned repository.
 	Instead of using the remote name 'origin' to keep track
 	of the upstream repository, use <name>.
 
+--branch <name>::
+-b <name>::
+	Create a local branch head for <name> instead of the branch
+	referenced by the remote repos HEAD.
+
 --upload-pack <upload-pack>::
 -u <upload-pack>::
 	When given, and the repository to clone from is accessed
diff --git a/builtin-clone.c b/builtin-clone.c
index 32dea74..91392a3 100644
--- a/builtin-clone.c
+++ b/builtin-clone.c
@@ -41,6 +41,7 @@ static int option_quiet, option_no_checkout, option_bare, option_mirror;
 static int option_local, option_no_hardlinks, option_shared;
 static char *option_template, *option_reference, *option_depth;
 static char *option_origin = NULL;
+static char *option_branch = NULL;
 static char *option_upload_pack = "git-upload-pack";
 static int option_verbose;
 
@@ -65,6 +66,8 @@ static struct option builtin_clone_options[] = {
 		   "reference repository"),
 	OPT_STRING('o', "origin", &option_origin, "branch",
 		   "use <branch> instead of 'origin' to track upstream"),
+	OPT_STRING('b', "branch", &option_branch, "branch",
+		   "use <branch> from upstream as HEAD"),
 	OPT_STRING('u', "upload-pack", &option_upload_pack, "path",
 		   "path to git-upload-pack on the remote"),
 	OPT_STRING(0, "depth", &option_depth, "depth",
@@ -347,8 +350,8 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	const char *repo_name, *repo, *work_tree, *git_dir;
 	char *path, *dir;
 	int dest_exists;
-	const struct ref *refs, *head_points_at, *remote_head, *mapped_refs;
-	struct strbuf key = STRBUF_INIT, value = STRBUF_INIT;
+	const struct ref *refs, *head_points_at, *remote_head = NULL, *mapped_refs;
+	struct strbuf key = STRBUF_INIT, value = STRBUF_INIT, branch_head = STRBUF_INIT;
 	struct strbuf branch_top = STRBUF_INIT, reflog_msg = STRBUF_INIT;
 	struct transport *transport = NULL;
 	char *src_ref_prefix = "refs/heads/";
@@ -518,8 +521,22 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 
 		mapped_refs = write_remote_refs(refs, refspec, reflog_msg.buf);
 
-		remote_head = find_ref_by_name(refs, "HEAD");
-		head_points_at = guess_remote_head(remote_head, mapped_refs, 0);
+		if (option_branch) {
+			strbuf_addf(&branch_head, "%s%s", src_ref_prefix, option_branch);
+
+			remote_head = find_ref_by_name(refs, branch_head.buf);
+		}
+
+		if (!remote_head) {
+			if (option_branch)
+				warning("Remote branch %s not found in upstream %s"
+					", using HEAD instead",
+					option_branch, option_origin);
+
+			remote_head = find_ref_by_name(refs, "HEAD");
+		}
+
+		head_points_at = guess_remote_head(remote_head, mapped_refs, 1);
 	}
 	else {
 		warning("You appear to have cloned an empty repository.");
diff --git a/t/t5706-clone-branch.sh b/t/t5706-clone-branch.sh
new file mode 100755
index 0000000..b5fec50
--- /dev/null
+++ b/t/t5706-clone-branch.sh
@@ -0,0 +1,49 @@
+#!/bin/sh
+
+test_description='branch clone options'
+. ./test-lib.sh
+
+test_expect_success 'setup' '
+
+	mkdir parent &&
+	(cd parent && git init &&
+	 echo one >file && git add file &&
+	 git commit -m one && git branch foo &&
+	 git checkout -b two &&
+	 echo two >f && git add f && git commit -m two &&
+	 git checkout master)
+
+'
+
+test_expect_success 'clone' '
+
+	git clone parent clone &&
+	(cd clone &&
+	test $(git rev-parse --verify HEAD) = \
+	     $(git rev-parse --verify refs/remotes/origin/master) &&
+	test $(git rev-parse --verify HEAD) != \
+	     $(git rev-parse --verify refs/remotes/origin/two))
+
+
+'
+
+test_expect_success 'clone -b two' '
+
+	git clone -b two parent clone-b &&
+	(cd clone-b &&
+	test $(git rev-parse --verify HEAD) = \
+	     $(git rev-parse --verify refs/remotes/origin/two) &&
+	test $(git rev-parse --verify HEAD) != \
+	     $(git rev-parse --verify refs/remotes/origin/master))
+
+'
+
+test_expect_success 'clone -b foo' '
+
+	git clone -b foo parent clone-b-foo &&
+	(cd clone-b-foo &&
+	test $(git branch | grep \* | sed -e s:\*\ ::) = foo)
+
+'
+
+test_done
-- 
1.6.2
