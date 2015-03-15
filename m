From: Alexander Kuleshov <kuleshovmail@gmail.com>
Subject: [PATCH RFC 1/3] add: add new --exclude option to git add
Date: Sun, 15 Mar 2015 19:49:59 +0600
Message-ID: <1426427399-22423-1-git-send-email-kuleshovmail@gmail.com>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Alexander Kuleshov <kuleshovmail@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 15 14:50:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YX8vz-0001rK-FS
	for gcvg-git-2@plane.gmane.org; Sun, 15 Mar 2015 14:50:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752338AbbCONuQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Mar 2015 09:50:16 -0400
Received: from mail-lb0-f174.google.com ([209.85.217.174]:35539 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751856AbbCONuP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Mar 2015 09:50:15 -0400
Received: by lbcgn8 with SMTP id gn8so5250804lbc.2
        for <git@vger.kernel.org>; Sun, 15 Mar 2015 06:50:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=KGjzLnm71f7NyWyB60KsYMcJOgYCOaR1DvWNLwpMxEQ=;
        b=t8LFikyGUUPSPRoiHQlUHlafkvh+vuPtiwx3lqfC3fWkBtHPHuSlo+HMUCTPigJB6+
         4zb/pXWHoUTsUjwhjWdA9Xtq68rYLQhiXMpTekNScLoY+hvnAj3EibdEZDgfRI1dsdkV
         buyas4B+Por9INf25mDvP3k7T7ZRYzNSLXVx0S/Geld8cWVdpvI4Uj+UgyJCU5J1CfqT
         lL14GvIBKpUtmKE/JArwq5G8XgST5dxwFFBInWDUX+yEnYOYeAH1ynXJdY8bCbe3HI9N
         37bi1sD8HesKLRY+1lGuq4tzfIgr7yqKZTCpNqJB3mjhkz3rfSPAKZvuK7/DhSIfUgUp
         B5Mw==
X-Received: by 10.152.23.3 with SMTP id i3mr49646783laf.97.1426427413571;
        Sun, 15 Mar 2015 06:50:13 -0700 (PDT)
Received: from localhost.localdomain ([95.56.108.218])
        by mx.google.com with ESMTPSA id xu8sm1573902lab.21.2015.03.15.06.50.09
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 15 Mar 2015 06:50:11 -0700 (PDT)
X-Mailer: git-send-email 2.3.3.472.g20ceeac
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265493>

This patch introduces new --exclude option for the git add
command.

We already have core.excludesfile configuration variable which indicates
a path to file which contains patterns to exclude. This patch provides
ability to pass --exclude option to the git add command to exclude paths
from command line in addition to which found in the ignore files.

Signed-off-by: Alexander Kuleshov <kuleshovmail@gmail.com>
---
 builtin/add.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/builtin/add.c b/builtin/add.c
index 3390933..5c602a6 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -244,6 +244,16 @@ static int ignore_removal_cb(const struct option *opt, const char *arg, int unse
 	return 0;
 }
 
+struct string_list exclude_list = STRING_LIST_INIT_NODUP;
+struct exclude_list *el;
+
+static int exclude_cb(const struct option *opt, const char *arg, int unset)
+{
+	struct string_list *exclude_list = opt->value;
+	string_list_append(exclude_list, arg);
+	return 0;
+}
+
 static struct option builtin_add_options[] = {
 	OPT__DRY_RUN(&show_only, N_("dry run")),
 	OPT__VERBOSE(&verbose, N_("be verbose")),
@@ -255,6 +265,9 @@ static struct option builtin_add_options[] = {
 	OPT_BOOL('u', "update", &take_worktree_changes, N_("update tracked files")),
 	OPT_BOOL('N', "intent-to-add", &intent_to_add, N_("record only the fact that the path will be added later")),
 	OPT_BOOL('A', "all", &addremove_explicit, N_("add changes from all tracked and untracked files")),
+	{ OPTION_CALLBACK, 0, "exclude", &exclude_list, N_("pattern"),
+	  N_("do no add files matching pattern to index"),
+	  0, exclude_cb },
 	{ OPTION_CALLBACK, 0, "ignore-removal", &addremove_explicit,
 	  NULL /* takes no arguments */,
 	  N_("ignore paths removed in the working tree (same as --no-all)"),
@@ -298,6 +311,7 @@ static int add_files(struct dir_struct *dir, int flags)
 
 int cmd_add(int argc, const char **argv, const char *prefix)
 {
+	int i;
 	int exit_status = 0;
 	struct pathspec pathspec;
 	struct dir_struct dir;
@@ -381,6 +395,11 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 		if (!ignored_too) {
 			dir.flags |= DIR_COLLECT_IGNORED;
 			setup_standard_excludes(&dir);
+
+			el = add_exclude_list(&dir, EXC_CMDL, "--exclude option");
+			for (i = 0; i < exclude_list.nr; i++)
+				add_exclude(exclude_list.items[i].string, "", 0, el, -(i+1));
+
 		}
 
 		memset(&empty_pathspec, 0, sizeof(empty_pathspec));
@@ -446,5 +465,6 @@ finish:
 			die(_("Unable to write new index file"));
 	}
 
+	string_list_clear(&exclude_list, 0);
 	return exit_status;
 }
-- 
2.3.3.472.g20ceeac
