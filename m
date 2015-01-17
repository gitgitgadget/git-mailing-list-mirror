From: Alexander Kuleshov <kuleshovmail@gmail.com>
Subject: [PATCH v2] branch: add support for --dry-run option
Date: Sat, 17 Jan 2015 22:39:34 +0600
Message-ID: <1421512774-3728-1-git-send-email-kuleshovmail@gmail.com>
Cc: git@vger.kernel.org, Alexander Kuleshov <kuleshovmail@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 17 17:39:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YCWPa-0004a7-53
	for gcvg-git-2@plane.gmane.org; Sat, 17 Jan 2015 17:39:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751562AbbAQQjm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Jan 2015 11:39:42 -0500
Received: from mail-lb0-f172.google.com ([209.85.217.172]:36862 "EHLO
	mail-lb0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751504AbbAQQjl (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Jan 2015 11:39:41 -0500
Received: by mail-lb0-f172.google.com with SMTP id l4so9932980lbv.3
        for <git@vger.kernel.org>; Sat, 17 Jan 2015 08:39:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=/ZzjB6RGCoNr+dPCdyFkR2x8Xs7xE04a58R+ZrV7EGw=;
        b=zbooqgTEmvMNgbexgL8mBWyIODrLWTRuRk3io0Pvqb5dc1C1TMhlkyjBiWQfV6u+yJ
         LBu6SZqxbafAnJ8E7ryyMCsKf8g2RfZdI/RFnfNFdsKSPJs1+XjY/vqtp1n+XzonyM40
         b7tC86Y+bySNWXwUd+fC0+YA32bE+rp7EvJMD6pt/1liXdgrAAZevxIDpgGfStqfmvqp
         U7iapfeDAhMezwf4LmbFkzVW/Y4VDJMLku1L0fdRZSX3uB/8Pnjxr6lNbtpKamJVWEQm
         Alj2jJenCM39bjoTp6okuZ464k4jd5jY51XpK4imi8V1rcHw/dlOopndzL/vGhT2C9L1
         0mjQ==
X-Received: by 10.112.156.132 with SMTP id we4mr21040404lbb.59.1421512780227;
        Sat, 17 Jan 2015 08:39:40 -0800 (PST)
Received: from localhost.localdomain ([37.150.86.244])
        by mx.google.com with ESMTPSA id an8sm2257118lac.7.2015.01.17.08.39.37
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 17 Jan 2015 08:39:39 -0800 (PST)
X-Mailer: git-send-email 2.3.0.rc0.286.ga3dc223.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262588>

This patch adds support -n/--dry-run option for branch(es) deletion.
If -n/--dry-run option passed to git branch -d branch..., branch(es)
will not be removed, instead just print list of branches that are
to be removed.

For example:

    $ git branch
    a
    b
    c
    * master

    $ git branch -d -n a b c
    delete branch 'a' (261c0d1)
    delete branch 'b' (261c0d1)
    delete branch 'c' (261c0d1)

Signed-off-by: Alexander Kuleshov <kuleshovmail@gmail.com>
---
 Documentation/git-branch.txt | 11 +++++++++--
 builtin/branch.c             | 13 +++++++++++++
 2 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
index 311b336..32ea581 100644
--- a/Documentation/git-branch.txt
+++ b/Documentation/git-branch.txt
@@ -16,7 +16,7 @@ SYNOPSIS
 'git branch' (--set-upstream-to=<upstream> | -u <upstream>) [<branchname>]
 'git branch' --unset-upstream [<branchname>]
 'git branch' (-m | -M) [<oldbranch>] <newbranch>
-'git branch' (-d | -D) [-r] <branchname>...
+'git branch' (-d | -D) [--dry-run | -n] [-r] <branchname>...
 'git branch' --edit-description [<branchname>]
 
 DESCRIPTION
@@ -63,7 +63,9 @@ to happen.
 
 With a `-d` or `-D` option, `<branchname>` will be deleted.  You may
 specify more than one branch for deletion.  If the branch currently
-has a reflog then the reflog will also be deleted.
+has a reflog then the reflog will also be deleted. If passed `-n` or
+`--dry-run` option, branch(es) will be not removed, but show a list of
+branches that are to be removed.
 
 Use `-r` together with `-d` to delete remote-tracking branches. Note, that it
 only makes sense to delete remote-tracking branches if they no longer exist
@@ -83,6 +85,11 @@ OPTIONS
 -D::
 	Delete a branch irrespective of its merged status.
 
+-n::
+--dry-run::
+	Don't remove the branch(es), but show a list of branches that are
+	to be removed.
+
 -l::
 --create-reflog::
 	Create the branch's reflog.  This activates recording of
diff --git a/builtin/branch.c b/builtin/branch.c
index d8949cb..4a35a2f 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -61,6 +61,7 @@ static unsigned char merge_filter_ref[20];
 
 static struct string_list output = STRING_LIST_INIT_DUP;
 static unsigned int colopts;
+static int branch_delete_show_only;
 
 static int parse_branch_color_slot(const char *slot)
 {
@@ -255,6 +256,17 @@ static int delete_branches(int argc, const char **argv, int force, int kinds,
 			continue;
 		}
 
+		if (branch_delete_show_only) {
+			printf(remote_branch
+			       ? _("delete remote branch '%s' (%s)\n")
+			       : _("delete branch '%s' (%s)\n"),
+			       bname.buf,
+			       (flags & REF_ISBROKEN) ? "broken"
+			       : (flags & REF_ISSYMREF) ? target
+			       : find_unique_abbrev(sha1, DEFAULT_ABBREV));
+			continue;
+		}
+
 		if (delete_ref(name, sha1, REF_NODEREF)) {
 			error(remote_branch
 			      ? _("Error deleting remote branch '%s'")
@@ -840,6 +852,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 			REF_REMOTE_BRANCH | REF_LOCAL_BRANCH),
 		OPT_BIT('d', "delete", &delete, N_("delete fully merged branch"), 1),
 		OPT_BIT('D', NULL, &delete, N_("delete branch (even if not merged)"), 2),
+		OPT__DRY_RUN(&branch_delete_show_only, N_("dry run")),
 		OPT_BIT('m', "move", &rename, N_("move/rename a branch and its reflog"), 1),
 		OPT_BIT('M', NULL, &rename, N_("move/rename a branch, even if target exists"), 2),
 		OPT_BOOL(0, "list", &list, N_("list branch names")),
-- 
2.3.0.rc0.286.ga3dc223.dirty
