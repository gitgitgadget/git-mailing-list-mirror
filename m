From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH 4/4] builtin_clone: use strbuf in cmd_clone()
Date: Fri, 21 Nov 2008 01:45:01 +0100
Message-ID: <f38db18d6741dfd116752ff4797479833fd00bc3.1227227976.git.vmiklos@frugalware.org>
References: <cover.1227227976.git.vmiklos@frugalware.org>
 <6bd31bceb3840f14d747972b4858e1c5b215744d.1227227976.git.vmiklos@frugalware.org>
 <33c4500c44cb27b1bfb3ec5584c0665b0dbd7c73.1227227976.git.vmiklos@frugalware.org>
 <59af178ebb4da602253e95f46f54473f42177e09.1227227976.git.vmiklos@frugalware.org>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 21 01:45:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L3K9I-0007O6-Qr
	for gcvg-git-2@gmane.org; Fri, 21 Nov 2008 01:45:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755381AbYKUAn6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Nov 2008 19:43:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755349AbYKUAn5
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Nov 2008 19:43:57 -0500
Received: from yugo.dsd.sztaki.hu ([195.111.2.114]:47488 "EHLO
	yugo.frugalware.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755272AbYKUAnv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Nov 2008 19:43:51 -0500
Received: from vmobile.example.net (catv-80-98-230-81.catv.broadband.hu [80.98.230.81])
	by yugo.frugalware.org (Postfix) with ESMTPA id CEC87446CD2;
	Fri, 21 Nov 2008 01:43:48 +0100 (CET)
Received: by vmobile.example.net (Postfix, from userid 1003)
	id 13C7F148F7; Fri, 21 Nov 2008 01:45:01 +0100 (CET)
X-Mailer: git-send-email 1.6.0.4
In-Reply-To: <59af178ebb4da602253e95f46f54473f42177e09.1227227976.git.vmiklos@frugalware.org>
In-Reply-To: <cover.1227227976.git.vmiklos@frugalware.org>
References: <cover.1227227976.git.vmiklos@frugalware.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101489>

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---
 builtin-clone.c |   45 +++++++++++++++++++++++++--------------------
 1 files changed, 25 insertions(+), 20 deletions(-)

diff --git a/builtin-clone.c b/builtin-clone.c
index 8182ebd..a6ea3d6 100644
--- a/builtin-clone.c
+++ b/builtin-clone.c
@@ -358,8 +358,8 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	const char *repo_name, *repo, *work_tree, *git_dir;
 	char *path, *dir;
 	const struct ref *refs, *head_points_at, *remote_head, *mapped_refs;
-	char branch_top[256], key[256], value[256];
-	struct strbuf reflog_msg = STRBUF_INIT;
+	struct strbuf key = STRBUF_INIT, value = STRBUF_INIT;
+	struct strbuf branch_top = STRBUF_INIT, reflog_msg = STRBUF_INIT;
 	struct transport *transport = NULL;
 	char *src_ref_prefix = "refs/heads/";
 
@@ -463,35 +463,36 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	if (option_bare) {
 		if (option_mirror)
 			src_ref_prefix = "refs/";
-		strcpy(branch_top, src_ref_prefix);
+		strbuf_addstr(&branch_top, src_ref_prefix);
 
 		git_config_set("core.bare", "true");
 	} else {
-		snprintf(branch_top, sizeof(branch_top),
-			 "refs/remotes/%s/", option_origin);
+		strbuf_addf(&branch_top, "refs/remotes/%s/", option_origin);
 	}
 
 	if (option_mirror || !option_bare) {
 		/* Configure the remote */
 		if (option_mirror) {
-			snprintf(key, sizeof(key),
-					"remote.%s.mirror", option_origin);
-			git_config_set(key, "true");
+			strbuf_addf(&key, "remote.%s.mirror", option_origin);
+			git_config_set(key.buf, "true");
+			strbuf_reset(&key);
 		}
 
-		snprintf(key, sizeof(key), "remote.%s.url", option_origin);
-		git_config_set(key, repo);
+		strbuf_addf(&key, "remote.%s.url", option_origin);
+		git_config_set(key.buf, repo);
+			strbuf_reset(&key);
 
-		snprintf(key, sizeof(key), "remote.%s.fetch", option_origin);
-		snprintf(value, sizeof(value),
-				"+%s*:%s*", src_ref_prefix, branch_top);
-		git_config_set_multivar(key, value, "^$", 0);
+		strbuf_addf(&key, "remote.%s.fetch", option_origin);
+		strbuf_addf(&value, "+%s*:%s*", src_ref_prefix, branch_top.buf);
+		git_config_set_multivar(key.buf, value.buf, "^$", 0);
+		strbuf_reset(&key);
+		strbuf_reset(&value);
 	}
 
 	refspec.force = 0;
 	refspec.pattern = 1;
 	refspec.src = src_ref_prefix;
-	refspec.dst = branch_top;
+	refspec.dst = branch_top.buf;
 
 	if (path && !is_bundle)
 		refs = clone_local(path, git_dir);
@@ -546,7 +547,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 				   head_points_at->old_sha1,
 				   NULL, 0, DIE_ON_ERR);
 
-			strbuf_addstr(&head_ref, branch_top);
+			strbuf_addstr(&head_ref, branch_top.buf);
 			strbuf_addstr(&head_ref, "HEAD");
 
 			/* Remote branch link */
@@ -554,10 +555,11 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 				      head_points_at->peer_ref->name,
 				      reflog_msg.buf);
 
-			snprintf(key, sizeof(key), "branch.%s.remote", head);
-			git_config_set(key, option_origin);
-			snprintf(key, sizeof(key), "branch.%s.merge", head);
-			git_config_set(key, head_points_at->name);
+			strbuf_addf(&key, "branch.%s.remote", head);
+			git_config_set(key.buf, option_origin);
+			strbuf_reset(&key);
+			strbuf_addf(&key, "branch.%s.merge", head);
+			git_config_set(key.buf, head_points_at->name);
 		}
 	} else if (remote_head) {
 		/* Source had detached HEAD pointing somewhere. */
@@ -607,6 +609,9 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	}
 
 	strbuf_release(&reflog_msg);
+	strbuf_release(&branch_top);
+	strbuf_release(&key);
+	strbuf_release(&value);
 	junk_pid = 0;
 	return 0;
 }
-- 
1.6.0.4
