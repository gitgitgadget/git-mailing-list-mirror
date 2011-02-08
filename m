From: Jared Hance <jaredhance@gmail.com>
Subject: [PATCH v2] Add support for merging from upstream by default.
Date: Tue,  8 Feb 2011 15:48:49 -0500
Message-ID: <1297198129-3403-1-git-send-email-jaredhance@gmail.com>
Cc: Jared Hance <jaredhance@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 08 21:49:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PmuUv-0007Sz-FW
	for gcvg-git-2@lo.gmane.org; Tue, 08 Feb 2011 21:49:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755693Ab1BHUtM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Feb 2011 15:49:12 -0500
Received: from mail-qw0-f46.google.com ([209.85.216.46]:47003 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755457Ab1BHUtL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Feb 2011 15:49:11 -0500
Received: by qwa26 with SMTP id 26so4528337qwa.19
        for <git@vger.kernel.org>; Tue, 08 Feb 2011 12:49:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer;
        bh=GCreor65bmrbjEv9kjC0dLMI8O3NJXNi5aIau/upyEQ=;
        b=Gnf2MvwdzhQquN3Uob1rV5xZ9ahKSZ+lURCaCVLCwWXxr+ikRoKu2h0XaZeYE1Tf5X
         lCHkLiiU3rFrdR9lX+HTqNsxIl5IWdh8Eo9aSIlOWUD1IQLtw8jcpfSWWWt9QRr4ffav
         PMVuMHbA/TFH7acljpFsMO4EmHUqSjp/wRbgw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=AmWpX5WgObVkRBWHovadCeNAh16q1/8q/lQrXSt2bztv0uT8Ap+ZUrtEF2vBtYbZTW
         aOImen0kmKEHGF9gT/bsVgRbPpZr/QfpLoBRLEZ2gTMkoWTY2MgNcE3U7nRRVIfF0W9L
         GeRKiyx7cj1Y2L9laYgvHTD0e3yqYxqvZqJ4s=
Received: by 10.229.186.20 with SMTP id cq20mr12639416qcb.12.1297198150585;
        Tue, 08 Feb 2011 12:49:10 -0800 (PST)
Received: from localhost.localdomain (cpe-75-186-7-248.cinci.res.rr.com [75.186.7.248])
        by mx.google.com with ESMTPS id s10sm3929136qco.11.2011.02.08.12.49.08
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 08 Feb 2011 12:49:09 -0800 (PST)
X-Mailer: git-send-email 1.7.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166367>

Adds the option merge.defaultupstream to add support for merging from the
upstream branch by default. The upstream branch is found using
branch.[name].merge.

Also add helper functions `per_branch_config` and `setup_merge_commit` to
reduce reduncancy and impove clarity.

Signed-off-by: Jared Hance <jaredhance@gmail.com>
---
 Documentation/config.txt |    5 +++
 builtin/merge.c          |   81 +++++++++++++++++++++++++++++++++-------------
 2 files changed, 63 insertions(+), 23 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index c5e1835..25c8292 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1389,6 +1389,11 @@ man.<tool>.path::
 
 include::merge-config.txt[]
 
+merge.defaultUpstream::
+	If merge is called without any ref arguments, merge from the branch
+	specified in branch.<current branch>.merge, which is considered to be
+	the upstream branch for the current branch.
+
 mergetool.<tool>.path::
 	Override the path for the given tool.  This is useful in case
 	your tool is not in the PATH.
diff --git a/builtin/merge.c b/builtin/merge.c
index 42fff38..2b4fd4f 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -37,7 +37,7 @@ struct strategy {
 };
 
 static const char * const builtin_merge_usage[] = {
-	"git merge [options] <remote>...",
+	"git merge [options] [<remote>...]",
 	"git merge [options] <msg> HEAD <remote>",
 	NULL
 };
@@ -58,6 +58,8 @@ static int option_renormalize;
 static int verbosity;
 static int allow_rerere_auto;
 static int abort_current_merge;
+static int default_upstream;
+static const char *upstream_branch;
 
 static struct strategy all_strategy[] = {
 	{ "recursive",  DEFAULT_TWOHEAD | NO_TRIVIAL },
@@ -498,11 +500,15 @@ cleanup:
 	strbuf_release(&bname);
 }
 
-static int git_merge_config(const char *k, const char *v, void *cb)
+static int per_branch_config(const char *k, const char *v, void *cb)
 {
-	if (branch && !prefixcmp(k, "branch.") &&
-		!prefixcmp(k + 7, branch) &&
-		!strcmp(k + 7 + strlen(branch), ".mergeoptions")) {
+	const char *variable;
+	if(!branch || prefixcmp(k, "branch.")
+	   || prefixcmp(k + 7, branch))
+		return 1; /* ignore me */
+
+	variable = k + 7 + strlen(branch);
+	if(!strcmp(variable, ".mergeoptions")) {
 		const char **argv;
 		int argc;
 		char *buf;
@@ -518,9 +524,26 @@ static int git_merge_config(const char *k, const char *v, void *cb)
 		parse_options(argc, argv, NULL, builtin_merge_options,
 			      builtin_merge_usage, 0);
 		free(buf);
+
+		return 0;
 	}
+	else if(strcmp(variable, ".merge")) {
+		return git_config_string(&upstream_branch, k, v);
+	}
+
+	return 1; /* not what I handle */
+}
 
-	if (!strcmp(k, "merge.diffstat") || !strcmp(k, "merge.stat"))
+static int git_merge_config(const char *k, const char *v, void *cb)
+{
+	int status = per_branch_config(k, v, cb);
+
+	if (status <= 0)
+		return status;
+
+	if (!strcmp(k, "merge.defaultupstream"))
+		default_upstream = git_config_bool(k, v);
+	else if (!strcmp(k, "merge.diffstat") || !strcmp(k, "merge.stat"))
 		show_diffstat = git_config_bool(k, v);
 	else if (!strcmp(k, "pull.twohead"))
 		return git_config_string(&pull_twohead, k, v);
@@ -911,6 +934,24 @@ static int evaluate_result(void)
 	return cnt;
 }
 
+static void setup_merge_commit(struct strbuf *buf,
+	struct commit_list ***remotes, const char *s)
+{
+	struct object *o;
+	struct commit *commit;
+
+	o = peel_to_type(s, 0, NULL, OBJ_COMMIT);
+	if (!o)
+		die("%s - not something we can merge", s);
+	commit = lookup_commit(o->sha1);
+	commit->util = (void *)s;
+	*remotes = &commit_list_insert(commit, *remotes)->next;
+
+	strbuf_addf(buf, "GITHEAD_%s", sha1_to_hex(o->sha1));
+	setenv(buf->buf, s, 1);
+	strbuf_reset(buf);
+}
+
 int cmd_merge(int argc, const char **argv, const char *prefix)
 {
 	unsigned char result_tree[20];
@@ -983,9 +1024,15 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 	if (!allow_fast_forward && fast_forward_only)
 		die("You cannot combine --no-ff with --ff-only.");
 
-	if (!argc)
-		usage_with_options(builtin_merge_usage,
-			builtin_merge_options);
+	if (!argc) {
+		if(default_upstream && upstream_branch) {
+			setup_merge_commit(&buf, &remotes, upstream_branch);
+		}
+		else {
+			usage_with_options(builtin_merge_usage,
+					builtin_merge_options);
+		}
+	}
 
 	/*
 	 * This could be traditional "merge <msg> HEAD <commit>..."  and
@@ -1048,7 +1095,7 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 		}
 	}
 
-	if (head_invalid || !argc)
+	if (head_invalid || (!argc && !(default_upstream && upstream_branch)))
 		usage_with_options(builtin_merge_usage,
 			builtin_merge_options);
 
@@ -1059,19 +1106,7 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 	strbuf_reset(&buf);
 
 	for (i = 0; i < argc; i++) {
-		struct object *o;
-		struct commit *commit;
-
-		o = peel_to_type(argv[i], 0, NULL, OBJ_COMMIT);
-		if (!o)
-			die("%s - not something we can merge", argv[i]);
-		commit = lookup_commit(o->sha1);
-		commit->util = (void *)argv[i];
-		remotes = &commit_list_insert(commit, remotes)->next;
-
-		strbuf_addf(&buf, "GITHEAD_%s", sha1_to_hex(o->sha1));
-		setenv(buf.buf, argv[i], 1);
-		strbuf_reset(&buf);
+		setup_merge_commit(&buf, &remotes, argv[i]);
 	}
 
 	if (!use_strategies) {
-- 
1.7.4
