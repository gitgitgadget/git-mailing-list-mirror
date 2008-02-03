From: Mark Levedahl <mlevedahl@gmail.com>
Subject: [PATCH 1/7] Teach remote machinery about core.origin config variable
Date: Sun,  3 Feb 2008 12:31:01 -0500
Message-ID: <1202059867-1184-2-git-send-email-mlevedahl@gmail.com>
References: <1202059867-1184-1-git-send-email-mlevedahl@gmail.com>
Cc: git@vger.kernel.org, Mark Levedahl <mlevedahl@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sun Feb 03 18:32:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JLih3-0000ZE-My
	for gcvg-git-2@gmane.org; Sun, 03 Feb 2008 18:31:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757081AbYBCRbS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Feb 2008 12:31:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756998AbYBCRbS
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Feb 2008 12:31:18 -0500
Received: from fg-out-1718.google.com ([72.14.220.152]:37993 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756714AbYBCRbR (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Feb 2008 12:31:17 -0500
Received: by fg-out-1718.google.com with SMTP id e21so1719736fga.17
        for <git@vger.kernel.org>; Sun, 03 Feb 2008 09:31:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=JOt6CGBsUc7TjQjgDhkX5O4saAocoCJBIRyuUTx8PME=;
        b=upN6B2JIYFI/lrirFXi0+6/09+VDs4cKe6p8TKTRDr2yEnNAjmp3cT/YXYVlrS8/UmaL1ccsjvY2cP0E9byUG9LblHcKXKqBdOgL+Yp4A26IuERpPhARArMIwVhau/Bb16GNnqLAswCzGURIW6PxqSXxeKulxFqkIK7AcNreGn0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=qf8IkxobSqFUZNOor16H/eEAhtOkXu1mCpQkt/h8w4RWucf63xNbzy4hzIy4eTso1MbLS3LJ0PB3hpsAXGgDuFj6Azk0Y4fykp4fdyKLo69t9lVkTs8EaoL2U7XqBHBP3ROHq80HcoxZEJ9MOmrJC7MsSgemYPYdgiHkM1B0lLM=
Received: by 10.86.97.7 with SMTP id u7mr5663282fgb.39.1202059876204;
        Sun, 03 Feb 2008 09:31:16 -0800 (PST)
Received: from localhost.localdomain ( [71.191.242.88])
        by mx.google.com with ESMTPS id l19sm8463628fgb.0.2008.02.03.09.31.13
        (version=SSLv3 cipher=OTHER);
        Sun, 03 Feb 2008 09:31:15 -0800 (PST)
X-Mailer: git-send-email 1.5.4.18.g43c18
In-Reply-To: <1202059867-1184-1-git-send-email-mlevedahl@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72379>

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
index 4e222f1..a890f5d 100644
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
1.5.4.18.g43c18
