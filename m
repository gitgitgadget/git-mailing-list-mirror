From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [PATCH] Clean up reporting differences on branch switch
Date: Tue, 19 Feb 2008 02:52:14 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0802190249540.5816@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 19 08:53:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JRNHk-0000eA-Uv
	for gcvg-git-2@gmane.org; Tue, 19 Feb 2008 08:53:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751565AbYBSHwb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Feb 2008 02:52:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751653AbYBSHwa
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Feb 2008 02:52:30 -0500
Received: from iabervon.org ([66.92.72.58]:58003 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751388AbYBSHwQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Feb 2008 02:52:16 -0500
Received: (qmail 16645 invoked by uid 1000); 19 Feb 2008 07:52:14 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 19 Feb 2008 07:52:14 -0000
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74389>

This also changes it such that:

$ git checkout

will give the same information without changing branches. This is good
for finding out if the fetch you did recently had anything to say
about the branch you've been on, whose name you don't remember at the
moment.

Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
---
On top of next, of course.

 builtin-checkout.c |   78 ++++-----------------------------------------------
 1 files changed, 7 insertions(+), 71 deletions(-)

diff --git a/builtin-checkout.c b/builtin-checkout.c
index 9370ba0..cb75c9e 100644
--- a/builtin-checkout.c
+++ b/builtin-checkout.c
@@ -291,71 +291,6 @@ static int merge_working_tree(struct checkout_opts *opts,
 	return 0;
 }
 
-/*
- * We really should allow cb_data... Yuck
- */
-static const char *branch_name;
-static int branch_name_len;
-static char *found_remote;
-static char *found_merge;
-static int read_branch_config(const char *var, const char *value)
-{
-	const char *name;
-	if (prefixcmp(var, "branch."))
-		return 0; /* not ours */
-	name = var + strlen("branch.");
-	if (strncmp(name, branch_name, branch_name_len) ||
-	    name[branch_name_len] != '.')
-		return 0; /* not ours either */
-	if (!strcmp(name + branch_name_len, ".remote")) {
-		/*
-		 * Yeah, I know Christian's clean-up should
-		 * be used here, but the topic is based on an
-		 * older fork point.
-		 */
-		if (!value)
-			return error("'%s' not string", var);
-		found_remote = xstrdup(value);
-		return 0;
-	}
-	if (!strcmp(name + branch_name_len, ".merge")) {
-		if (!value)
-			return error("'%s' not string", var);
-		found_merge = xstrdup(value);
-		return 0;
-	}
-	return 0; /* not ours */
-}
-
-static int find_build_base(const char *ours, char **base)
-{
-	struct remote *remote;
-	struct refspec spec;
-
-	*base = NULL;
-
-	branch_name = ours + strlen("refs/heads/");
-	branch_name_len = strlen(branch_name);
-	found_remote = NULL;
-	found_merge = NULL;
-	git_config(read_branch_config);
-
-	if (!found_remote || !found_merge) {
-	cleanup:
-		free(found_remote);
-		free(found_merge);
-		return 0;
-	}
-
-	remote = remote_get(found_remote);
-	memset(&spec, 0, sizeof(spec));
-	spec.src = found_merge;
-	if (remote_find_tracking(remote, &spec))
-		goto cleanup;
-	*base = spec.dst;
-	return 1;
-}
-
 static void adjust_to_tracking(struct branch_info *new, struct checkout_opts *opts)
 {
 	/*
@@ -369,15 +304,16 @@ static void adjust_to_tracking(struct branch_info *new, struct checkout_opts *op
 	const char *msgfmt;
 	char symmetric[84];
 	int show_log;
+	struct branch *branch = branch_get(NULL);
 
-	if (!resolve_ref(new->path, sha1, 1, NULL))
+	if (!branch || !branch->merge)
 		return;
-	ours = lookup_commit(sha1);
 
-	if (!find_build_base(new->path, &base))
-		return;
+	base = branch->merge[0]->dst;
+
+	ours = new->commit;
 
-	sprintf(symmetric, "%s", sha1_to_hex(sha1));
+	sprintf(symmetric, "%s", sha1_to_hex(ours->object.sha1));
 
 	/*
 	 * Ok, it is tracking base; is it ahead of us?
@@ -466,7 +402,7 @@ static void update_refs_for_switch(struct checkout_opts *opts,
 	}
 	remove_branch_state();
 	strbuf_release(&msg);
-	if (new->path)
+	if (new->path || !strcmp(new->name, "HEAD"))
 		adjust_to_tracking(new, opts);
 }
 
-- 
1.5.4.1.1350.g2b9ee
