From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [PATCH 1/5] Make clone parse the default refspec with the normal
 code
Date: Thu, 5 Mar 2009 23:56:16 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0903052353210.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 06 05:57:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LfS82-0008Rl-3n
	for gcvg-git-2@gmane.org; Fri, 06 Mar 2009 05:57:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752827AbZCFE4T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Mar 2009 23:56:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752650AbZCFE4T
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Mar 2009 23:56:19 -0500
Received: from iabervon.org ([66.92.72.58]:51776 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752066AbZCFE4S (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Mar 2009 23:56:18 -0500
Received: (qmail 6360 invoked by uid 1000); 6 Mar 2009 04:56:16 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 6 Mar 2009 04:56:16 -0000
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112380>

Instead of creating a refspec by hand, go through the refspec parsing
code, so that changes in the refspec storage will be accounted for.

Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
---
 builtin-clone.c |   25 +++++++++++++------------
 1 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/builtin-clone.c b/builtin-clone.c
index c338910..06b5a7f 100644
--- a/builtin-clone.c
+++ b/builtin-clone.c
@@ -378,7 +378,8 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	struct transport *transport = NULL;
 	char *src_ref_prefix = "refs/heads/";
 
-	struct refspec refspec;
+	struct refspec *refspec;
+	const char *fetch_pattern;
 
 	junk_pid = getpid();
 
@@ -487,8 +488,14 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 		strbuf_addf(&branch_top, "refs/remotes/%s/", option_origin);
 	}
 
+	strbuf_addf(&value, "+%s*:%s*", src_ref_prefix, branch_top.buf);
+
 	if (option_mirror || !option_bare) {
 		/* Configure the remote */
+		strbuf_addf(&key, "remote.%s.fetch", option_origin);
+		git_config_set_multivar(key.buf, value.buf, "^$", 0);
+		strbuf_reset(&key);
+
 		if (option_mirror) {
 			strbuf_addf(&key, "remote.%s.mirror", option_origin);
 			git_config_set(key.buf, "true");
@@ -497,19 +504,13 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 
 		strbuf_addf(&key, "remote.%s.url", option_origin);
 		git_config_set(key.buf, repo);
-			strbuf_reset(&key);
-
-		strbuf_addf(&key, "remote.%s.fetch", option_origin);
-		strbuf_addf(&value, "+%s*:%s*", src_ref_prefix, branch_top.buf);
-		git_config_set_multivar(key.buf, value.buf, "^$", 0);
 		strbuf_reset(&key);
-		strbuf_reset(&value);
 	}
 
-	refspec.force = 0;
-	refspec.pattern = 1;
-	refspec.src = src_ref_prefix;
-	refspec.dst = branch_top.buf;
+	fetch_pattern = value.buf;
+	refspec = parse_fetch_refspec(1, &fetch_pattern);
+
+	strbuf_reset(&value);
 
 	if (path && !is_bundle)
 		refs = clone_local(path, git_dir);
@@ -543,7 +544,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	if (refs) {
 		clear_extra_refs();
 
-		mapped_refs = write_remote_refs(refs, &refspec, reflog_msg.buf);
+		mapped_refs = write_remote_refs(refs, refspec, reflog_msg.buf);
 
 		head_points_at = locate_head(refs, mapped_refs, &remote_head);
 	}
-- 
1.6.1.286.gd33a4.dirty
