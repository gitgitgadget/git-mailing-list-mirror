From: Jared Hance <jaredhance@gmail.com>
Subject: [PATCH v3 3/3] Add support for merging from upstream by default.
Date: Tue,  8 Feb 2011 19:23:48 -0500
Message-ID: <1297211028-14382-4-git-send-email-jaredhance@gmail.com>
References: <1297198129-3403-1-git-send-email-jaredhance@gmail.com>
 <1297211028-14382-1-git-send-email-jaredhance@gmail.com>
Cc: Jared Hance <jaredhance@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 09 01:24:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PmxrL-0001bd-03
	for gcvg-git-2@lo.gmane.org; Wed, 09 Feb 2011 01:24:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756025Ab1BIAYQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Feb 2011 19:24:16 -0500
Received: from mail-qw0-f46.google.com ([209.85.216.46]:42325 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755995Ab1BIAYP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Feb 2011 19:24:15 -0500
Received: by qwa26 with SMTP id 26so4662693qwa.19
        for <git@vger.kernel.org>; Tue, 08 Feb 2011 16:24:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=xVlX7Wcjsu0JonLN5KuJYfM4iJ50r5FBl5ioD80zqd0=;
        b=ViNUxuDmaOOwrvIywL/GtBbWdf3cACowCGPQ0cNZMDf5n7neZszpI+FWVfqPWGBYVa
         o/ahNXO6CGqwpS3CSbfnXdDBIih0bATlZp9YJF6ysY208bqEJAORYbaQUT19zd1sKdaj
         VKrJpAeoZBQ36EmMY6pk+eYGdlb7OYIvtxt/s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=iYaCXXpHOwt5CtZAk0lMpkCJ7XwW0IxTvg0vjrgX0hDaCqV7AwTNNfY257PQD4HoN1
         liWBUXHlAw+PmaOQ/G6Qgd3ChsESCv1UC/bIDMvBPehDvdDfJ2WDZaupsvvR7d6t9Xyw
         G+sadqf79vfxfgSmB9YEUAa+0WS1Ar88b8qqM=
Received: by 10.224.19.199 with SMTP id c7mr16135275qab.140.1297211054752;
        Tue, 08 Feb 2011 16:24:14 -0800 (PST)
Received: from localhost.localdomain (cpe-75-186-7-248.cinci.res.rr.com [75.186.7.248])
        by mx.google.com with ESMTPS id nb15sm35516qcb.26.2011.02.08.16.24.12
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 08 Feb 2011 16:24:13 -0800 (PST)
X-Mailer: git-send-email 1.7.4
In-Reply-To: <1297211028-14382-1-git-send-email-jaredhance@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166380>

Adds the option merge.defaultupstream to add support for merging from the
upstream branch by default. The upstream branch is found using
branch.[name].merge.

Signed-off-by: Jared Hance <jaredhance@gmail.com>
---
 Documentation/config.txt |    6 ++++++
 builtin/merge.c          |   31 +++++++++++++++++++++++--------
 2 files changed, 29 insertions(+), 8 deletions(-)

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
index 818bfc7..cd646fb 100644
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
@@ -525,6 +527,8 @@ static int per_branch_config(const char *k, const char *v, void *cb)
 
 		return 0;
 	}
+	else if (!strcmp(variable, ".merge"))
+		return git_config_string(&upstream_branch, k, v);
 
 	return 1; /* not what I handle */
 }
@@ -536,7 +540,9 @@ static int git_merge_config(const char *k, const char *v, void *cb)
 	if (status <= 0)
 		return status;
 
-	if (!strcmp(k, "merge.diffstat") || !strcmp(k, "merge.stat"))
+	if (!strcmp(k, "merge.defaultupstream"))
+		default_upstream = git_config_bool(k, v);
+	else if (!strcmp(k, "merge.diffstat") || !strcmp(k, "merge.stat"))
 		show_diffstat = git_config_bool(k, v);
 	else if (!strcmp(k, "pull.twohead"))
 		return git_config_string(&pull_twohead, k, v);
@@ -1017,9 +1023,13 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 	if (!allow_fast_forward && fast_forward_only)
 		die("You cannot combine --no-ff with --ff-only.");
 
-	if (!argc)
-		usage_with_options(builtin_merge_usage,
-			builtin_merge_options);
+	if (!argc) {
+		if (!default_upstream || !upstream_branch)
+			usage_with_options(builtin_merge_usage,
+					builtin_merge_options);
+		else
+			setup_merge_commit(&buf, &remotes, upstream_branch);
+	}
 
 	/*
 	 * This could be traditional "merge <msg> HEAD <commit>..."  and
@@ -1082,9 +1092,14 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
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
