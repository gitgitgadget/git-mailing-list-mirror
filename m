From: Jared Hance <jaredhance@gmail.com>
Subject: [PATCH v4 5/5] merge: add support for merging from upstream by default
Date: Thu, 10 Feb 2011 18:40:09 -0500
Message-ID: <1297381209-6377-10-git-send-email-jaredhance@gmail.com>
References: <1297381209-6377-1-git-send-email-jaredhance@gmail.com>
Cc: Jared Hance <jaredhance@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 11 00:42:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Png9j-0006eN-EO
	for gcvg-git-2@lo.gmane.org; Fri, 11 Feb 2011 00:42:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932476Ab1BJXko (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Feb 2011 18:40:44 -0500
Received: from mail-vx0-f174.google.com ([209.85.220.174]:50690 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932447Ab1BJXkg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Feb 2011 18:40:36 -0500
Received: by mail-vx0-f174.google.com with SMTP id 37so1028081vxb.19
        for <git@vger.kernel.org>; Thu, 10 Feb 2011 15:40:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=vCGUpz7ZpAyo8b2UqlNw1xR0sVCbWRH4akkb+6SAA/o=;
        b=Z+aps4kzqPa3HRdm7bk0G+H5KHq0OJ8T0wWpviNjkB/dFjOSnBFEwCCoC5aMpMddW3
         0dmwBEvSLFx+YLns7vSZLBzw7piAQkEYnjlgxHP+EXPYhbTVpaAn8mYuHkKbQ9O2DWUy
         1MZD6AB8t2Z+arw9VoqbCDydu6ta0VsJUQ9JY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=fxXttHxoiQ7wqAMEtfohgcvxdzJ0srA8EdzQsohTj6pHnoRMY6mu0bSjBwKtpvx1P5
         /JW/VFAg2T+IasdUFXqV+lCmAGBsPzsCtEvFaFmaCB5REHxQy5yfv1CwqZE3gf2gIhDJ
         DOrMfa7oQyO62ugW0mDZSjhGFPYEteMjDyPm4=
Received: by 10.220.201.6 with SMTP id ey6mr808740vcb.68.1297381236245;
        Thu, 10 Feb 2011 15:40:36 -0800 (PST)
Received: from localhost.localdomain (cpe-75-186-7-248.cinci.res.rr.com [75.186.7.248])
        by mx.google.com with ESMTPS id r7sm126736vbx.19.2011.02.10.15.40.35
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 10 Feb 2011 15:40:35 -0800 (PST)
X-Mailer: git-send-email 1.7.4
In-Reply-To: <1297381209-6377-1-git-send-email-jaredhance@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166522>

Add the option merge.defaultupstream to add support for merging from
the upstream branch by default. The upstream branch is found using
branch.[name].merge.

Signed-off-by: Jared Hance <jaredhance@gmail.com>
---
 Documentation/config.txt |    6 ++++++
 builtin/merge.c          |   32 +++++++++++++++++++++++---------
 2 files changed, 29 insertions(+), 9 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index c5e1835..4415691 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1389,6 +1389,12 @@ man.<tool>.path::
 
 include::merge-config.txt[]
 
+merge.defaultUpstream::
+	If merge is called without any ref arguments, merge from the branch
+	specified in branch.<current branch>.merge, which is considered to be
+	the upstream branch for the current branch, possibly set by --track or
+	--set-upstream.
+
 mergetool.<tool>.path::
 	Override the path for the given tool.  This is useful in case
 	your tool is not in the PATH.
diff --git a/builtin/merge.c b/builtin/merge.c
index 71b392d..a3ca6a0 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -37,7 +37,7 @@ struct strategy {
 };
 
 static const char * const builtin_merge_usage[] = {
-	"git merge [options] <branch>...",
+	"git merge [options] [<branch>...]",
 	"git merge [options] <msg> HEAD <branch>",
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
@@ -524,7 +526,8 @@ static int per_branch_config(const char *k, const char *v, void *cb)
 		free(buf);
 
 		return 0;
-	}
+	} else if (!strcmp(variable, ".merge"))
+		return git_config_string(&upstream_branch, k, v);
 
 	return 1; /* not what I handle */
 }
@@ -536,7 +539,9 @@ static int git_merge_config(const char *k, const char *v, void *cb)
 	if (status <= 0)
 		return status;
 
-	if (!strcmp(k, "merge.diffstat") || !strcmp(k, "merge.stat"))
+	if (!strcmp(k, "merge.defaultupstream"))
+		default_upstream = git_config_bool(k, v);
+	else if (!strcmp(k, "merge.diffstat") || !strcmp(k, "merge.stat"))
 		show_diffstat = git_config_bool(k, v);
 	else if (!strcmp(k, "pull.twohead"))
 		return git_config_string(&pull_twohead, k, v);
@@ -1017,9 +1022,13 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 	if (!allow_fast_forward && fast_forward_only)
 		die("You cannot combine --no-ff with --ff-only.");
 
-	if (!argc)
-		usage_with_options(builtin_merge_usage,
-			builtin_merge_options);
+	if (!argc) {
+		if (!default_upstream || !upstream_branch)
+			usage_with_options(builtin_merge_usage,
+					builtin_merge_options);
+
+		setup_merge_commit(&buf, &remotes, upstream_branch);
+	}
 
 	/*
 	 * This could be traditional "merge <msg> HEAD <commit>..."  and
@@ -1082,9 +1091,14 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 		}
 	}
 
-	if (head_invalid || !argc)
-		usage_with_options(builtin_merge_usage,
-			builtin_merge_options);
+	if (head_invalid)
+		usage_msg_opt("cannot use old-style invocation from an unborn"
+				"branch", 
+				builtin_merge_usage, builtin_merge_options);
+
+	if (!argc && !(default_upstream && upstream_branch))
+		usage_msg_opt("no commit to merge specified",
+				builtin_merge_usage, builtin_merge_options);
 
 	strbuf_addstr(&buf, "merge");
 	for (i = 0; i < argc; i++)
-- 
1.7.4
