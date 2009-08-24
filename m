From: "Kirill A. Korinskiy" <catap@catap.ru>
Subject: [PATCH] Add option -b/--branch to clone for select a new HEAD
Date: Tue, 25 Aug 2009 00:42:48 +0400
Message-ID: <1251146568-25248-1-git-send-email-catap@catap.ru>
Cc: git@vger.kernel.org, "Kirill A. Korinskiy" <catap@catap.ru>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Aug 24 23:25:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mfh2h-0006Wx-0E
	for gcvg-git-2@lo.gmane.org; Mon, 24 Aug 2009 23:25:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753400AbZHXVZW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Aug 2009 17:25:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752360AbZHXVZV
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Aug 2009 17:25:21 -0400
Received: from mx.catap.ru ([85.25.165.176]:42065 "EHLO mx.catap.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751080AbZHXVZV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Aug 2009 17:25:21 -0400
X-Greylist: delayed 2462 seconds by postgrey-1.27 at vger.kernel.org; Mon, 24 Aug 2009 17:25:21 EDT
Received: from catap.static.corbina.ru ([85.21.143.245] helo=satellite.home.catap.ru)
	by mx.catap.ru with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <catap@satellite.home.catap.ru>)
	id 1MfgNs-0006gT-6C; Tue, 25 Aug 2009 00:43:20 +0400
Received: from catap by satellite.home.catap.ru with local (Exim 4.69)
	(envelope-from <catap@satellite.home.catap.ru>)
	id 1MfgNM-0006Zn-MI; Tue, 25 Aug 2009 00:42:48 +0400
X-Mailer: git-send-email 1.6.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126969>

Sometimes (especially on production systems) we need to use only one
remote branch for building software. It really annoying to clone
origin and then swith branch by hand everytime. So this patch provide
functionality to clone remote branch with one command without using
checkout after clone.
---
 Documentation/git-clone.txt |    4 ++++
 builtin-clone.c             |   26 +++++++++++++++++++++++---
 2 files changed, 27 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
index 2c63a0f..50446d2 100644
--- a/Documentation/git-clone.txt
+++ b/Documentation/git-clone.txt
@@ -127,6 +127,10 @@ objects from the source repository into a pack in the cloned repository.
 	Instead of using the remote name 'origin' to keep track
 	of the upstream repository, use <name>.
 
+--branch <name>::
+-b <name>::
+	Instead of using the remote HEAD as master, use <name> branch.
+
 --upload-pack <upload-pack>::
 -u <upload-pack>::
 	When given, and the repository to clone from is accessed
diff --git a/builtin-clone.c b/builtin-clone.c
index 32dea74..4420c68 100644
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
+		   "use <branch> from 'origin' as HEAD"),
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
@@ -372,6 +375,9 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 		if (option_origin)
 			die("--bare and --origin %s options are incompatible.",
 			    option_origin);
+		if (option_branch)
+			die("--bare and --branch %s options are incompatible.",
+			    option_branch);
 		option_no_checkout = 1;
 	}
 
@@ -518,7 +524,21 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 
 		mapped_refs = write_remote_refs(refs, refspec, reflog_msg.buf);
 
-		remote_head = find_ref_by_name(refs, "HEAD");
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
 		head_points_at = guess_remote_head(remote_head, mapped_refs, 0);
 	}
 	else {
-- 
1.6.2
