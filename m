From: Nicolas Vigier <boklm@mars-attacks.org>
Subject: [PATCH] Add the commit.gpgsign option to sign all commits
Date: Tue,  5 Nov 2013 00:14:41 +0100
Message-ID: <1383606881-2979-1-git-send-email-boklm@mars-attacks.org>
Cc: Nicolas Vigier <boklm@mars-attacks.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 05 00:15:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VdTML-0004rd-SP
	for gcvg-git-2@plane.gmane.org; Tue, 05 Nov 2013 00:15:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753359Ab3KDXO6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Nov 2013 18:14:58 -0500
Received: from mx0.mars-attacks.org ([92.243.25.60]:43613 "EHLO
	mx0.mars-attacks.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753286Ab3KDXO5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Nov 2013 18:14:57 -0500
Received: from localhost (localhost [127.0.0.1])
	by mx0.mars-attacks.org (Postfix) with ESMTP id 10DDD4E5A
	for <git@vger.kernel.org>; Tue,  5 Nov 2013 00:15:12 +0100 (CET)
X-Virus-Scanned: amavisd-new at mars-attacks.org
Received: from mx0.mars-attacks.org ([127.0.0.1])
	by localhost (mx0.mars-attacks.org [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id rAB0DQ9PAKsm; Tue,  5 Nov 2013 00:15:11 +0100 (CET)
Received: from wxy.mars-attacks.org (moow.mars-attacks.org [82.242.116.57])
	by mx0.mars-attacks.org (Postfix) with ESMTPS id 556923ECC;
	Tue,  5 Nov 2013 00:15:11 +0100 (CET)
Received: by wxy.mars-attacks.org (Postfix, from userid 500)
	id B28B343934; Tue,  5 Nov 2013 00:14:54 +0100 (CET)
X-Mailer: git-send-email 1.8.4.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237312>

If you want to GPG sign all your commits, you have to add the -S option
all the time. The commit.gpgsign config option allows to sign all
commits automatically.

Signed-off-by: Nicolas Vigier <boklm@mars-attacks.org>
---
 Documentation/config.txt | 3 +++
 builtin/commit-tree.c    | 7 ++++++-
 builtin/commit.c         | 4 ++++
 builtin/merge.c          | 3 +++
 4 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index ab26963d6187..4cfa557375a2 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -988,6 +988,9 @@ commit.cleanup::
 	have to remove the help lines that begin with `#` in the commit log
 	template yourself, if you do this).
 
+commit.gpgsign::
+	A boolean to specify whether all commits should be GPG signed.
+
 commit.status::
 	A boolean to enable/disable inclusion of status information in the
 	commit message template when using an editor to prepare the commit
diff --git a/builtin/commit-tree.c b/builtin/commit-tree.c
index f641ff2a898c..1646d5b25e4f 100644
--- a/builtin/commit-tree.c
+++ b/builtin/commit-tree.c
@@ -12,6 +12,8 @@
 
 static const char commit_tree_usage[] = "git commit-tree [(-p <sha1>)...] [-S[<keyid>]] [-m <message>] [-F <file>] <sha1> <changelog";
 
+static const char *sign_commit;
+
 static void new_parent(struct commit *parent, struct commit_list **parents_p)
 {
 	unsigned char *sha1 = parent->object.sha1;
@@ -31,6 +33,10 @@ static int commit_tree_config(const char *var, const char *value, void *cb)
 	int status = git_gpg_config(var, value, NULL);
 	if (status)
 		return status;
+	if (!strcmp(var, "commit.gpgsign")) {
+		sign_commit = git_config_bool(var, value) ? "" : NULL;
+		return 0;
+	}
 	return git_default_config(var, value, cb);
 }
 
@@ -41,7 +47,6 @@ int cmd_commit_tree(int argc, const char **argv, const char *prefix)
 	unsigned char tree_sha1[20];
 	unsigned char commit_sha1[20];
 	struct strbuf buffer = STRBUF_INIT;
-	const char *sign_commit = NULL;
 
 	git_config(commit_tree_config, NULL);
 
diff --git a/builtin/commit.c b/builtin/commit.c
index 6ab4605cf5c2..cffddf210807 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1406,6 +1406,10 @@ static int git_commit_config(const char *k, const char *v, void *cb)
 	}
 	if (!strcmp(k, "commit.cleanup"))
 		return git_config_string(&cleanup_arg, k, v);
+	if (!strcmp(k, "commit.gpgsign")) {
+		sign_commit = git_config_bool(k, v) ? "" : NULL;
+		return 0;
+	}
 
 	status = git_gpg_config(k, v, NULL);
 	if (status)
diff --git a/builtin/merge.c b/builtin/merge.c
index 02a69c14e6ab..fea27244557d 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -604,6 +604,9 @@ static int git_merge_config(const char *k, const char *v, void *cb)
 	} else if (!strcmp(k, "merge.defaulttoupstream")) {
 		default_to_upstream = git_config_bool(k, v);
 		return 0;
+	} else if (!strcmp(k, "commit.gpgsign")) {
+		sign_commit = git_config_bool(k, v) ? "" : NULL;
+		return 0;
 	}
 
 	status = fmt_merge_msg_config(k, v, cb);
-- 
1.8.4.2
