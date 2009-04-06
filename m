From: Finn Arne Gangstad <finnag@pvv.org>
Subject: [PATCH 3/3] git remote update: Fallback to remote if group does not exist
Date: Mon,  6 Apr 2009 15:41:02 +0200
Message-ID: <1239025262-16960-4-git-send-email-finnag@pvv.org>
References: <1239025262-16960-1-git-send-email-finnag@pvv.org>
Cc: gitster@pobox.com, Finn Arne Gangstad <finnag@pvv.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 06 15:43:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lqp71-0002xr-KG
	for gcvg-git-2@gmane.org; Mon, 06 Apr 2009 15:43:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755838AbZDFNln (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Apr 2009 09:41:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755723AbZDFNln
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Apr 2009 09:41:43 -0400
Received: from decibel.pvv.ntnu.no ([129.241.210.179]:56660 "EHLO
	decibel.pvv.ntnu.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755616AbZDFNll (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Apr 2009 09:41:41 -0400
Received: from decibel.pvv.ntnu.no
	([129.241.210.179] helo=localhost.localdomain ident=finnag)
	by decibel.pvv.ntnu.no with esmtp (Exim 4.69)
	(envelope-from <finnag@pvv.org>)
	id 1Lqp4u-0004Pq-Jr; Mon, 06 Apr 2009 15:41:34 +0200
X-Mailer: git-send-email 1.5.4.3
In-Reply-To: <1239025262-16960-1-git-send-email-finnag@pvv.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115825>

Previously, git remote update <remote> would fail unless there was
a remote group configured with the same name as the remote.
git remote update will now fall back to using the remote if no matching
group can be found.

This enables "git remote update -p <remote>..." to fetch and prune one
or more remotes, for example.

Signed-off-by: Finn Arne Gangstad <finnag@pvv.org>
---
 Documentation/git-remote.txt |    2 +-
 builtin-remote.c             |   10 ++++++++--
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-remote.txt b/Documentation/git-remote.txt
index 0b6e67d..9e2b4ea 100644
--- a/Documentation/git-remote.txt
+++ b/Documentation/git-remote.txt
@@ -16,7 +16,7 @@ SYNOPSIS
 'git remote set-head' <name> [-a | -d | <branch>]
 'git remote show' [-n] <name>
 'git remote prune' [-n | --dry-run] <name>
-'git remote update' [-p | --prune] [group]
+'git remote update' [-p | --prune] [group | remote]...
 
 DESCRIPTION
 -----------
diff --git a/builtin-remote.c b/builtin-remote.c
index 51df99b..ca7c639 100644
--- a/builtin-remote.c
+++ b/builtin-remote.c
@@ -1232,8 +1232,14 @@ static int update(int argc, const char **argv)
 		int groups_found = 0;
 		remote_group.name = argv[i];
 		result = git_config(get_remote_group, &groups_found);
-		if (!groups_found && (i != 1 || strcmp(argv[1], "default")))
-			die("No such remote group: '%s'", argv[i]);
+		if (!groups_found && (i != 1 || strcmp(argv[1], "default"))) {
+			struct remote *remote;
+			if (!remote_is_configured(argv[i]))
+				die("No such remote or remote group: %s",
+				    argv[i]);
+			remote = remote_get(argv[i]);
+			string_list_append(remote->name, remote_group.list);
+		}
 	}
 
 	if (!result && !list.nr  && argc == 2 && !strcmp(argv[1], "default"))
-- 
1.6.2.1.471.gdfdaa
