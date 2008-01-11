From: Mark Levedahl <mlevedahl@gmail.com>
Subject: [PATCH] Teach remote machinery about remotes.default config variable
Date: Thu, 10 Jan 2008 22:29:46 -0500
Message-ID: <1200022189-2400-2-git-send-email-mlevedahl@gmail.com>
References: <1200022189-2400-1-git-send-email-mlevedahl@gmail.com>
Cc: git@vger.kernel.org, Mark Levedahl <mlevedahl@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Jan 11 04:30:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JDAb9-0004bC-T2
	for gcvg-git-2@gmane.org; Fri, 11 Jan 2008 04:30:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755823AbYAKD36 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jan 2008 22:29:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754736AbYAKD35
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Jan 2008 22:29:57 -0500
Received: from hs-out-0708.google.com ([64.233.178.241]:3059 "EHLO
	hs-out-2122.google.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751613AbYAKD34 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jan 2008 22:29:56 -0500
Received: by hs-out-2122.google.com with SMTP id 54so862397hsz.5
        for <git@vger.kernel.org>; Thu, 10 Jan 2008 19:29:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=Nu3J7nhwT04GJ1nZ9B+Y9sPDUrVmsICDAnuiQ2KCGYk=;
        b=Yp5MS2A/J73TVmtzTNwWFtLf+mDnz1q7oELH2Vqt3eAqM9g6J/CpkcqtfXue7z2T/6+4Cb/mNtcjbLWb8AuNx5+iQsgJEDEPEV02Gk0iSDGgOpeS9Vx0ysPr7ZzJnczUBchdlVpH7+nU9Kw1jJDRJHetQEXlNleWO8p7ZOScNcQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=sFArncaqupTEycYmWm/lxN/DqYTnD2LI6ak8HM9WQvfb8DCnNN3CIUKloY3uFp7XMgrHv56Q9xKo8gKtHD/UEyogVtD6yAHLtsxQEbP21CPHAugcWGhX2zuq8hj+PPpDssVMLGVp2ehbyoDaZV2L4MYmDxUyjTc5K3EH5uV0yLA=
Received: by 10.150.191.10 with SMTP id o10mr1117898ybf.84.1200022194611;
        Thu, 10 Jan 2008 19:29:54 -0800 (PST)
Received: from localhost.localdomain ( [71.163.17.196])
        by mx.google.com with ESMTPS id h8sm4363197wxd.39.2008.01.10.19.29.53
        (version=SSLv3 cipher=OTHER);
        Thu, 10 Jan 2008 19:29:53 -0800 (PST)
X-Mailer: git-send-email 1.5.4.rc2.99.g3ef7-dirty
In-Reply-To: <1200022189-2400-1-git-send-email-mlevedahl@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70118>

This introduces a new configuration variable, remotes.default, that
defines the name of the default remote to be used. Traditionally, this
is "origin", and could be overridden for a given branch. This change
introduces a way to redefine the default as desired and have that honored
regardless of the currently checked out head (e.g., remotes.default is
used when on a detached head or any other non-tracking branch).

Signed-off-by: Mark Levedahl <mlevedahl@gmail.com>
---
 Documentation/config.txt |    6 ++++++
 git-parse-remote.sh      |    5 +++--
 remote.c                 |   11 ++++++++++-
 3 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 1b6d6d6..01ce295 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -800,6 +800,12 @@ remote.<name>.tagopt::
 	Setting this value to --no-tags disables automatic tag following when fetching
 	from remote <name>
 
+remotes.default::
+	The name of the remote used by default for fetch / pull. If unset,
+	origin is assumed. This value is used whenever the current branch
+	has no corresponding branch.<name>.remote, such as when working on
+	a detached head.
+
 remotes.<group>::
 	The list of remotes which are fetched by "git remote update
 	<group>".  See linkgit:git-remote[1].
diff --git a/git-parse-remote.sh b/git-parse-remote.sh
index 695a409..1b235e0 100755
--- a/git-parse-remote.sh
+++ b/git-parse-remote.sh
@@ -56,8 +56,9 @@ get_remote_url () {
 
 get_default_remote () {
 	curr_branch=$(git symbolic-ref -q HEAD | sed -e 's|^refs/heads/||')
-	origin=$(git config --get "branch.$curr_branch.remote")
-	echo ${origin:-origin}
+	git config --get "branch.$curr_branch.remote" ||
+	git config --get "remotes.default" ||
+	echo origin
 }
 
 get_remote_default_refs_for_push () {
diff --git a/remote.c b/remote.c
index 0e00680..4937237 100644
--- a/remote.c
+++ b/remote.c
@@ -10,6 +10,7 @@ static int allocated_branches;
 
 static struct branch *current_branch;
 static const char *default_remote_name;
+static const char *remotes_default_name;
 
 #define BUF_SIZE (2048)
 static char buffer[BUF_SIZE];
@@ -233,6 +234,11 @@ static int handle_config(const char *key, const char *value)
 			add_merge(branch, xstrdup(value));
 		return 0;
 	}
+	if (!strcmp(key, "remotes.default")) {
+		if (value)
+			remotes_default_name = xstrdup(value);
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
+			default_remote_name = remotes_default_name ?
+				remotes_default_name : xstrdup("origin");
+	}
 }
 
 struct refspec *parse_ref_spec(int nr_refspec, const char **refspec)
-- 
1.5.4.rc2.99.g3ef7-dirty
