From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: [PATCH/RFC] remote: support --all for the prune-subcommand
Date: Mon,  3 Oct 2011 14:16:08 +0200
Message-ID: <1317644168-5808-1-git-send-email-kusmabite@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 03 14:16:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RAhRU-000250-W5
	for gcvg-git-2@lo.gmane.org; Mon, 03 Oct 2011 14:16:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755582Ab1JCMQQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Oct 2011 08:16:16 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:51347 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754352Ab1JCMQP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Oct 2011 08:16:15 -0400
Received: by bkbzt4 with SMTP id zt4so5213078bkb.19
        for <git@vger.kernel.org>; Mon, 03 Oct 2011 05:16:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:message-id:x-mailer;
        bh=uPENnAx+OvQqNOu0RJ/rAeVA3L9+6IeUY4Ez8G2QcKk=;
        b=sGRZ3dNqGYaG60ysNcDMOupw56B3QX5OEcnuweWIZ/5Ym7g5PeW+cBNFtpT7gPunAQ
         aD/HaUcVTMRXBgvZCbyH/+jXYaA0VqTL7FynlMLRiU8RlA7+VbITGvyetfTIAC1+KAMr
         uuxqBwcrnc7UphdcEe202XtvEvsMKtp/M7U1M=
Received: by 10.204.131.200 with SMTP id y8mr9811840bks.242.1317644173937;
        Mon, 03 Oct 2011 05:16:13 -0700 (PDT)
Received: from localhost ([77.40.159.131])
        by mx.google.com with ESMTPS id l15sm13004983bkw.9.2011.10.03.05.16.11
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 03 Oct 2011 05:16:12 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.msysgit.0.579.ga3d6f
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182657>

While we're at it, wrap a long line to fit on a 80 char terminal.

Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
---

I recently needed to prune remote branches in a repo with a lot
of remotes, and to my surprise "git remote prune" didn't support
the --all option. So I added it. Perhaps this is useful for other
people as well?

 Documentation/git-remote.txt |    2 +-
 builtin/remote.c             |   27 ++++++++++++++++++++-------
 2 files changed, 21 insertions(+), 8 deletions(-)

diff --git a/Documentation/git-remote.txt b/Documentation/git-remote.txt
index 5a8c506..856cc7f 100644
--- a/Documentation/git-remote.txt
+++ b/Documentation/git-remote.txt
@@ -19,7 +19,7 @@ SYNOPSIS
 'git remote set-url --add' [--push] <name> <newurl>
 'git remote set-url --delete' [--push] <name> <url>
 'git remote' [-v | --verbose] 'show' [-n] <name>
-'git remote prune' [-n | --dry-run] <name>
+'git remote prune' [-n | --dry-run] (--all | <name>...)
 'git remote' [-v | --verbose] 'update' [-p | --prune] [(<group> | <remote>)...]
 
 DESCRIPTION
diff --git a/builtin/remote.c b/builtin/remote.c
index f2a9c26..2e8407d 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -14,7 +14,7 @@ static const char * const builtin_remote_usage[] = {
 	"git remote rm <name>",
 	"git remote set-head <name> (-a | -d | <branch>)",
 	"git remote [-v | --verbose] show [-n] <name>",
-	"git remote prune [-n | --dry-run] <name>",
+	"git remote prune [-n | --dry-run] (--all | <name>)",
 	"git remote [-v | --verbose] update [-p | --prune] [(<group> | <remote>)...]",
 	"git remote set-branches <name> [--add] <branch>...",
 	"git remote set-url <name> <newurl> [<oldurl>]",
@@ -1222,22 +1222,35 @@ static int set_head(int argc, const char **argv)
 	return result;
 }
 
+static int add_one_remote(struct remote *remote, void *remotes)
+{
+	string_list_append(remotes, remote->name);
+	return 0;
+}
+
 static int prune(int argc, const char **argv)
 {
-	int dry_run = 0, result = 0;
+	struct string_list remotes = STRING_LIST_INIT_NODUP;
+	int dry_run = 0, result = 0, all = 0, i;
 	struct option options[] = {
+		OPT_BOOLEAN(0, "all", &all, "prune all remotes"),
 		OPT__DRY_RUN(&dry_run, "dry run"),
 		OPT_END()
 	};
 
-	argc = parse_options(argc, argv, NULL, options, builtin_remote_prune_usage,
-			     0);
+	argc = parse_options(argc, argv, NULL, options,
+	                     builtin_remote_prune_usage, 0);
 
-	if (argc < 1)
+	if (all)
+		for_each_remote(add_one_remote, &remotes);
+	else if (argc < 1)
 		usage_with_options(builtin_remote_prune_usage, options);
+	else
+		for (; argc; argc--, argv++)
+			string_list_append(&remotes, *argv);
 
-	for (; argc; argc--, argv++)
-		result |= prune_remote(*argv, dry_run);
+	for (i = 0; i < remotes.nr; ++i)
+		result |= prune_remote(remotes.items[i].string, dry_run);
 
 	return result;
 }
-- 
1.7.6.msysgit.0.579.ga3d6f
