From: Jared Hance <jaredhance@gmail.com>
Subject: [PATCH/RFC] Add support for merging from upstream by default.
Date: Fri,  4 Feb 2011 18:01:19 -0500
Message-ID: <1296860479-17517-1-git-send-email-jaredhance@gmail.com>
References: <7vsjw957fq.fsf_-_@alter.siamese.dyndns.org>
Cc: Jared Hance <jaredhance@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 05 00:01:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PlUes-0001LA-UR
	for gcvg-git-2@lo.gmane.org; Sat, 05 Feb 2011 00:01:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752641Ab1BDXBh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Feb 2011 18:01:37 -0500
Received: from mail-vw0-f46.google.com ([209.85.212.46]:36154 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752479Ab1BDXBg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Feb 2011 18:01:36 -0500
Received: by vws16 with SMTP id 16so1814489vws.19
        for <git@vger.kernel.org>; Fri, 04 Feb 2011 15:01:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=98rG6LVTka1s+OFenuLnwgzcLACVSSKl44XvrpdZJR8=;
        b=Bo+n8a7J4CaQxfITjWx0lqSVT4zTXVGjOWRLLbK0G2EP3CRXdImbHxess0r2uqUIi/
         rocXU5k3YVIDOABoe9Hsq0FhgjqyN77nxLYLENNqDHQ3+aKtUPkRpJA+qEOQcGc8VcRM
         7KbOv36tkyONN+A8GPNorWIev6EYaLDRCEOXU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=iWjyg4qwP9niPdgEL+94y2OLhLLfcEdQmzq/IrFU5mqV/cH2MVlRjKBqm/QcuOS1D7
         330oBZPxMXvwdRfxG31sYbVSPONawLBsryFLRDDXwJhsHhtM+k/3IntyH92OI+6Pj43m
         3b1/hxRD9tF8/YpOUIr+ZbX4x8NPk8T3+jpaQ=
Received: by 10.220.186.66 with SMTP id cr2mr3212532vcb.65.1296860495370;
        Fri, 04 Feb 2011 15:01:35 -0800 (PST)
Received: from localhost.localdomain (cpe-75-186-7-248.cinci.res.rr.com [75.186.7.248])
        by mx.google.com with ESMTPS id i1sm929113vby.1.2011.02.04.15.01.34
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 04 Feb 2011 15:01:34 -0800 (PST)
X-Mailer: git-send-email 1.7.4
In-Reply-To: <7vsjw957fq.fsf_-_@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166064>

Adds the option merge.defaultupstream to add support for merging from the
upstream branch by default. The upstream branch is found using
branch.[name].upstream.
---

This is just testing code; it works but I'm not yet sure if it breaks other
things. I tried to code it so it doesn't.

Note: First time using git send-email; I hope I set it up correctly with the
In-reply-to and Cc's and such.

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
