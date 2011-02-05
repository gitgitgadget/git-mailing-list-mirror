From: Jared Hance <jaredhance@gmail.com>
Subject: [PATCH] Add support for merging from upstream by default.
Date: Fri,  4 Feb 2011 19:45:21 -0500
Message-ID: <1296866721-27818-1-git-send-email-jaredhance@gmail.com>
Cc: Jared Hance <jaredhance@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 05 01:46:10 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PlWHx-0007XC-AI
	for gcvg-git-2@lo.gmane.org; Sat, 05 Feb 2011 01:46:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752277Ab1BEApo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Feb 2011 19:45:44 -0500
Received: from mail-vx0-f174.google.com ([209.85.220.174]:65247 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752085Ab1BEApo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Feb 2011 19:45:44 -0500
Received: by vxb37 with SMTP id 37so926663vxb.19
        for <git@vger.kernel.org>; Fri, 04 Feb 2011 16:45:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer;
        bh=Ynil4xnIks3iCpl1HUuZYyTb1BeUoBuf8YapfwCZVnQ=;
        b=UEAguSRBr/DEcNjfQhB7A6NB5bE3Oz+cGPBC+z5GIzMDI0Wq92dEGt3pK8voJI6obg
         vv39scaeCwW2DQcQ1YXzsZRoWT4xY+2u7ShYD87Ysam0lfm3vfDoKaRpXUihpSXEKkws
         DFR3mGaom1nPwWw1OPAUUc3hPc2+lxe24zubA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=OqQTYssJfd+zPrTRYZg3XswQ7dTJnae7SF076fs3ZRafutiiw7nVi568UsaYkXRbBH
         NxA/zEruCW2IFrywfp1ouMorxzAFu0kApDqxuAPa/KeNqFZz8i7WH9IsbybvBVBhot3n
         kRS7ejnFDqU5RqNZGY4CNoh7lNO9vuPXNPZkA=
Received: by 10.220.186.139 with SMTP id cs11mr392106vcb.46.1296866743038;
        Fri, 04 Feb 2011 16:45:43 -0800 (PST)
Received: from localhost.localdomain (cpe-75-186-7-248.cinci.res.rr.com [75.186.7.248])
        by mx.google.com with ESMTPS id o6sm580746vcr.27.2011.02.04.16.45.41
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 04 Feb 2011 16:45:42 -0800 (PST)
X-Mailer: git-send-email 1.7.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166067>

Adds the option merge.defaultupstream to add support for merging from the
upstream branch by default. The upstream branch is found using
branch.[name].upstream.
---

So it turns out that the old code _did_ work with options; I had thought it
hadn't because I relied on !argc == 0, but since argc is decreased after parsing
options anyway, it isn't a problem. This update fixes the usage as Junio
suggested, since it does support options.

 builtin/merge.c |   41 +++++++++++++++++++++++++++++++++++------
 1 files changed, 35 insertions(+), 6 deletions(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index 42fff38..a69b69f 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -37,6 +37,7 @@ struct strategy {
 };
 
 static const char * const builtin_merge_usage[] = {
+        "git merge",
 	"git merge [options] <remote>...",
 	"git merge [options] <msg> HEAD <remote>",
 	NULL
@@ -58,6 +59,8 @@ static int option_renormalize;
 static int verbosity;
 static int allow_rerere_auto;
 static int abort_current_merge;
+static int default_upstream;
+static const char *upstream_branch;
 
 static struct strategy all_strategy[] = {
 	{ "recursive",  DEFAULT_TWOHEAD | NO_TRIVIAL },
@@ -519,8 +522,15 @@ static int git_merge_config(const char *k, const char *v, void *cb)
 			      builtin_merge_usage, 0);
 		free(buf);
 	}
-
-	if (!strcmp(k, "merge.diffstat") || !strcmp(k, "merge.stat"))
+        else if(branch && !prefixcmp(k, "branch.") &&
+                !prefixcmp(k + 7, branch) &&
+                !strcmp(k + 7 + strlen(branch), ".upstream")) {
+                return git_config_string(&upstream_branch, k, v);
+        }
+
+        if (!strcmp(k, "merge.defaultupstream"))
+                default_upstream = git_config_bool(k, v);
+        else if (!strcmp(k, "merge.diffstat") || !strcmp(k, "merge.stat"))
 		show_diffstat = git_config_bool(k, v);
 	else if (!strcmp(k, "pull.twohead"))
 		return git_config_string(&pull_twohead, k, v);
@@ -983,9 +993,28 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 	if (!allow_fast_forward && fast_forward_only)
 		die("You cannot combine --no-ff with --ff-only.");
 
-	if (!argc)
-		usage_with_options(builtin_merge_usage,
-			builtin_merge_options);
+	if (!argc) {
+                if(default_upstream && upstream_branch) {
+		        struct object *o;
+                        struct commit *commit;
+
+                        o = peel_to_type(upstream_branch, 0, NULL, OBJ_COMMIT);
+                        if (!o)
+                            die("%s - not something we can merge", argv[i]);
+                        commit = lookup_commit(o->sha1);
+                        commit->util = (void *)upstream_branch;
+                        remotes = &commit_list_insert(commit, remotes)->next;
+
+                        strbuf_addf(&buf, "GITHEAD_%s", sha1_to_hex(o->sha1));
+                        setenv(buf.buf, upstream_branch, 1);
+                        strbuf_reset(&buf);
+                }
+                else {
+		        usage_with_options(builtin_merge_usage,
+			        builtin_merge_options);
+
+                }
+        }
 
 	/*
 	 * This could be traditional "merge <msg> HEAD <commit>..."  and
@@ -1048,7 +1077,7 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 		}
 	}
 
-	if (head_invalid || !argc)
+	if (head_invalid || (!argc && !(default_upstream && upstream_branch)))
 		usage_with_options(builtin_merge_usage,
 			builtin_merge_options);
 
-- 
1.7.4
