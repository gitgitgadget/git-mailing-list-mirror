From: Leila Muhtasib <muhtasib@gmail.com>
Subject: [PATCH] git-status: Show empty directories
Date: Sat,  9 Jun 2012 15:40:06 -0400
Message-ID: <1339270806-65013-1-git-send-email-muhtasib@gmail.com>
Cc: Leila Muhtasib <muhtasib@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 09 21:40:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SdRWJ-0005fo-RY
	for gcvg-git-2@plane.gmane.org; Sat, 09 Jun 2012 21:40:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751977Ab2FITkT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Jun 2012 15:40:19 -0400
Received: from mail-qc0-f174.google.com ([209.85.216.174]:38069 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751550Ab2FITkS (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Jun 2012 15:40:18 -0400
Received: by qcro28 with SMTP id o28so1374951qcr.19
        for <git@vger.kernel.org>; Sat, 09 Jun 2012 12:40:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=fWmyd779spVbxyc8gPDHOH2oJUbJmZK5Dnvcw3UtBg4=;
        b=BeEl7ACiKWwX4N6hQyFWEdux9HyvqI6civCve0pB6MtmjFsCOASJXzwYfK+y+3fSf2
         24esZt89tiFXbLpAIjGJNuIGD92GZk5hzjH9OSVFgcKSFL70EQgaNxZF7cNFJohBVcfs
         kGV5eFfB1lm2kRQxKOJIywOmuyC4AivBzLbwc8Q9KTnmGV7sUgkFd33cf0fYpUhO6eLG
         k9Ce0jJkNkjihgKBSm1cQI6ffQG/xIJqAp1mAHmoYjJssgfRYsOwFLGo/bOS1MIRXYxd
         6Btb/mVB4nlLqqTzJvgb7lVhxjB+12v3WxFKhDSfbhkU7PVWRqN6ejZ1gIr/QjyhYJIp
         2YRg==
Received: by 10.224.192.133 with SMTP id dq5mr4442600qab.51.1339270817390;
        Sat, 09 Jun 2012 12:40:17 -0700 (PDT)
Received: from localhost ([38.117.156.148])
        by mx.google.com with ESMTPS id gd2sm18219470qab.18.2012.06.09.12.40.16
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 09 Jun 2012 12:40:16 -0700 (PDT)
X-Mailer: git-send-email 1.7.7.5 (Apple Git-26)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199554>

git-status now lists empty directories under the untracked header. Before this
modification, git status did not list empty directories. The header changed
from 'Untracked files' to instead display 'Untracked files and directories'.
A helpful reminder is also added after empty directories indicating they cannot
be added/staged if they are empty. git status -u is unchanged, and will still
only show untracked files just as before. As a result, no need for
documentation change.

Empty dirs are work in progress. They result because of one of the following:
user forgot to add files to dir, user forgot to clean up dir, user under
impression dir is staged and will be committed or is already committed. Last
item might occur as some users setup project and dir structures before adding files.

So this patch servers as a helpful reminder to users that they have an empty dir
so they can act upon it. Plus it clarifies git behavior to the user that empty
dirs can't be tracked.

Signed-off-by: Leila Muhtasib <muhtasib@gmail.com>
---

I ran into this issue myself where I thought my dir was already tracked, and 
when I googled and found other people were confused and asking the same question. 
Why don't empty dirs appear under git status when they aren't tracked? So I came 
up with this patch.

In my commit message, I compiled a list of arguments in favor of this patch. 
But I've also thought about arguments against, however I didn't think they were 
compelling enough to not have this patch. So I've also included my own rebuttal 
below :)

1) Direcories can't be tracked, so why show them under untracked?
Because it is a helpful reminder. See reasons in the commit message above for 
how it is helpful. This would make git more user friendly.
Plus untracked does not mean 'it can be tracked', it just means it's not currently 
tracked by git.

2) Empty directories should be ignored
If someone really wants to ignore something, they can put it in the .gitignore 
file. Otherwise, the benefits above out weight this.


 wt-status.c |   24 +++++++++++++++++++-----
 1 files changed, 19 insertions(+), 5 deletions(-)

diff --git a/wt-status.c b/wt-status.c
index 9ffc535..81bf1aa 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -184,7 +184,12 @@ static void wt_status_print_other_header(struct wt_status *s,
 					 const char *how)
 {
 	const char *c = color(WT_STATUS_HEADER, s);
-	status_printf_ln(s, c, _("%s files:"), what);
+
+	if (s->show_untracked_files == SHOW_NORMAL_UNTRACKED_FILES)
+		status_printf_ln(s, c, _("%s files and directories:"), what);
+	else if (s->show_untracked_files == SHOW_ALL_UNTRACKED_FILES)
+		status_printf_ln(s, c, _("%s files:"), what);
+
 	if (!advice_status_hints)
 		return;
 	status_printf_ln(s, c, _("  (use \"git %s <file>...\" to include in what will be committed)"), how);
@@ -464,16 +469,25 @@ static void wt_status_collect_untracked(struct wt_status *s)
 		return;
 	memset(&dir, 0, sizeof(dir));
 	if (s->show_untracked_files != SHOW_ALL_UNTRACKED_FILES)
-		dir.flags |=
-			DIR_SHOW_OTHER_DIRECTORIES | DIR_HIDE_EMPTY_DIRECTORIES;
+	dir.flags |=
+	  DIR_SHOW_OTHER_DIRECTORIES;
 	setup_standard_excludes(&dir);
 
 	fill_directory(&dir, s->pathspec);
 	for (i = 0; i < dir.nr; i++) {
 		struct dir_entry *ent = dir.entries[i];
 		if (cache_name_is_other(ent->name, ent->len) &&
-		    match_pathspec(s->pathspec, ent->name, ent->len, 0, NULL))
-			string_list_insert(&s->untracked, ent->name);
+		    match_pathspec(s->pathspec, ent->name, ent->len, 0, NULL)) {
+			if (is_empty_dir(ent->name)) {
+				struct strbuf buf_name = STRBUF_INIT;
+				strbuf_addstr(&buf_name, ent->name);
+				strbuf_addstr(&buf_name, " (empty directories cannot be added)");
+				string_list_insert(&s->untracked, buf_name.buf);
+				strbuf_release(&buf_name);
+			}
+			else
+				string_list_insert(&s->untracked, ent->name);
+		}
 		free(ent);
 	}
 
-- 
1.7.7.5 (Apple Git-26)
