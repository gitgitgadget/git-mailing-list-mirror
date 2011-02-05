From: Jared Hance <jaredhance@gmail.com>
Subject: [PATCH] Add support for merging from upstream by default.
Date: Sat,  5 Feb 2011 08:31:21 -0500
Message-ID: <1296912681-4161-1-git-send-email-jaredhance@gmail.com>
References: <m2k4he23z6.fsf@whitebox.home>
Cc: Jared Hance <jaredhance@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 05 14:31:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PliF1-0003OE-Li
	for gcvg-git-2@lo.gmane.org; Sat, 05 Feb 2011 14:31:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751661Ab1BENbu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Feb 2011 08:31:50 -0500
Received: from mail-vx0-f174.google.com ([209.85.220.174]:56529 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751213Ab1BENbt (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Feb 2011 08:31:49 -0500
Received: by vxb37 with SMTP id 37so1034616vxb.19
        for <git@vger.kernel.org>; Sat, 05 Feb 2011 05:31:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=3FsFgvOH25ClbPJSdiXi6bkqiAIaqFGj74VQQNOxykI=;
        b=htNDY4Lcq7VWmOm72CCeIwlNE4ierfxIEBpVqKi1HYdDlLT37Qcq611jsEwGvCSFUD
         JZKw7868ABv45hxiTU3hC63t+aW/adhInGb8HTlp0X3p+g7HefTeCWMqfue3eQuxRfcV
         KwN8uYjrwCbkmWW83KBicp7Y2EFFUifGlVPfc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=dHBE3kJqMVBZrPJ0z7POP5Cz5LNX3qXHLphi5xGZMAU/7pGVR9ihRSDkM9quuNfIFR
         pYfBerjCHzdTM2Xb5DAzXWvhWbau+bm160xq0iFAtMQhlroz5fArltuuvi15X+VYSo0H
         dDxI2C6iYFKi/mYfKpPI5NW3exyqIf5nZg2jk=
Received: by 10.220.195.71 with SMTP id eb7mr3475689vcb.203.1296912708530;
        Sat, 05 Feb 2011 05:31:48 -0800 (PST)
Received: from localhost.localdomain (cpe-75-186-7-248.cinci.res.rr.com [75.186.7.248])
        by mx.google.com with ESMTPS id g17sm1476926vbv.2.2011.02.05.05.31.47
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 05 Feb 2011 05:31:47 -0800 (PST)
X-Mailer: git-send-email 1.7.4
In-Reply-To: <m2k4he23z6.fsf@whitebox.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166090>

Adds the option merge.defaultupstream to add support for merging from the
upstream branch by default. The upstream branch is found using
branch.[name].upstream.
---

I checked it this time, it really is the right usage.

 builtin/merge.c |   42 +++++++++++++++++++++++++++++++++++-------
 1 files changed, 35 insertions(+), 7 deletions(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index 42fff38..596febe 100644
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
@@ -519,8 +521,15 @@ static int git_merge_config(const char *k, const char *v, void *cb)
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
@@ -983,9 +992,28 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
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
@@ -1048,7 +1076,7 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 		}
 	}
 
-	if (head_invalid || !argc)
+	if (head_invalid || (!argc && !(default_upstream && upstream_branch)))
 		usage_with_options(builtin_merge_usage,
 			builtin_merge_options);
 
-- 
1.7.4
