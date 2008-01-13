From: Mark Levedahl <mlevedahl@gmail.com>
Subject: [PATCH] Teach remote machinery about core.origin config variable
Date: Sun, 13 Jan 2008 11:27:07 -0500
Message-ID: <1200241631-3300-1-git-send-email-mlevedahl@gmail.com>
References: <478A3284.1000102@gmail.com>
Cc: git@vger.kernel.org, Mark Levedahl <mlevedahl@gmail.com>
To: gitster@pobox.org
X-From: git-owner@vger.kernel.org Sun Jan 13 17:27:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JE5ga-00016Z-8K
	for gcvg-git-2@gmane.org; Sun, 13 Jan 2008 17:27:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752838AbYAMQ1S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Jan 2008 11:27:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752268AbYAMQ1S
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Jan 2008 11:27:18 -0500
Received: from wx-out-0506.google.com ([66.249.82.235]:2842 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752071AbYAMQ1R (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Jan 2008 11:27:17 -0500
Received: by wx-out-0506.google.com with SMTP id h31so976652wxd.4
        for <git@vger.kernel.org>; Sun, 13 Jan 2008 08:27:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=gvPOTKOuS9opOT1hr81tvariVJJpvdujTNokox2i8Gs=;
        b=Ujqr8L77VEnO8rGO0gh1TPcD7gWrnzvTQLeuBYtqcEiZLU6BLSeWR2J2jHNPEoKHWd1yy2/vKl+BMq7FYLJ/KNDOZ4t6TZVGenzluz0r8iBVIFV8SpY23KOnlqv/SNk6YJBnUPjCh9QaWgTYeebHxv4N05YnH8wqN0QfiZYo7x8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=R0yrEC93XvOCbt0WoDPRcpH99Cl7/unGlaJcyZLcfuEiYLX5liZyOWkD3o3C4nkHRehKmuBdGrWQfGoEuu0fmkTGnngrYicSsTH/CiStVxXkr+V52bSsq02P5DkOMHKTFPgQKspUvjPpp3Gbpn9qlRKyEd+m3CnG/i9tsUFnMqg=
Received: by 10.70.111.2 with SMTP id j2mr3753972wxc.30.1200241634883;
        Sun, 13 Jan 2008 08:27:14 -0800 (PST)
Received: from localhost.localdomain ( [71.163.17.196])
        by mx.google.com with ESMTPS id i18sm8324960wxd.0.2008.01.13.08.27.13
        (version=SSLv3 cipher=OTHER);
        Sun, 13 Jan 2008 08:27:13 -0800 (PST)
X-Mailer: git-send-email 1.5.4.rc3.14.gc50f
In-Reply-To: <478A3284.1000102@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70391>

This introduces a new configuration variable, core.origin, that
defines the name of the default remote to be used. Traditionally, this
is "origin", and could be overridden for a given branch. This change
introduces a way to redefine the default as desired and have that honored
regardless of the currently checked out head (e.g., core.origin is
used when on a detached head or any other non-tracking branch).

Signed-off-by: Mark Levedahl <mlevedahl@gmail.com>
---
 Documentation/config.txt |    6 ++++++
 git-parse-remote.sh      |    5 +++--
 remote.c                 |   11 ++++++++++-
 3 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index df091d1..b7241cf 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -291,6 +291,12 @@ core.editor::
 	`GIT_EDITOR` environment, `core.editor`, `VISUAL` and
 	`EDITOR` environment variables and then finally `vi`.
 
+core.origin::
+	The name of the remote used by default for fetch / pull. If unset,
+	origin is assumed. This value is used whenever the current branch
+	has no corresponding branch.<name>.remote, such as when working on
+	a detached head.
+
 core.pager::
 	The command that git will use to paginate output.  Can be overridden
 	with the `GIT_PAGER` environment variable.
diff --git a/git-parse-remote.sh b/git-parse-remote.sh
index 695a409..c7ac7c7 100755
--- a/git-parse-remote.sh
+++ b/git-parse-remote.sh
@@ -56,8 +56,9 @@ get_remote_url () {
 
 get_default_remote () {
 	curr_branch=$(git symbolic-ref -q HEAD | sed -e 's|^refs/heads/||')
-	origin=$(git config --get "branch.$curr_branch.remote")
-	echo ${origin:-origin}
+	git config --get "branch.$curr_branch.remote" ||
+	git config --get "core.origin" ||
+	echo origin
 }
 
 get_remote_default_refs_for_push () {
diff --git a/remote.c b/remote.c
index 0e00680..302d499 100644
--- a/remote.c
+++ b/remote.c
@@ -10,6 +10,7 @@ static int allocated_branches;
 
 static struct branch *current_branch;
 static const char *default_remote_name;
+static const char *core_origin;
 
 #define BUF_SIZE (2048)
 static char buffer[BUF_SIZE];
@@ -233,6 +234,11 @@ static int handle_config(const char *key, const char *value)
 			add_merge(branch, xstrdup(value));
 		return 0;
 	}
+	if (!strcmp(key, "core.origin")) {
+		if (value)
+			core_origin = xstrdup(value);
+		return 0;
+	}
 	if (prefixcmp(key,  "remote."))
 		return 0;
 	name = key + 7;
@@ -291,7 +297,6 @@ static void read_config(void)
 	int flag;
 	if (default_remote_name) // did this already
 		return;
-	default_remote_name = xstrdup("origin");
 	current_branch = NULL;
 	head_ref = resolve_ref("HEAD", sha1, 0, &flag);
 	if (head_ref && (flag & REF_ISSYMREF) &&
@@ -300,6 +305,10 @@ static void read_config(void)
 			make_branch(head_ref + strlen("refs/heads/"), 0);
 	}
 	git_config(handle_config);
+	if (!default_remote_name) {
+		default_remote_name = core_origin ?
+		core_origin : xstrdup("origin");
+	}
 }
 
 struct refspec *parse_ref_spec(int nr_refspec, const char **refspec)
-- 
1.5.4.rc3.14.gc50f
