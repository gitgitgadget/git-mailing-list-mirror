From: Alexander Kuleshov <kuleshovmail@gmail.com>
Subject: [PATCH] branch: add support for --dry-run option
Date: Sat, 17 Jan 2015 13:35:59 +0600
Message-ID: <1421480159-4848-1-git-send-email-kuleshovmail@gmail.com>
Cc: git@vger.kernel.org, Alexander Kuleshov <kuleshovmail@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 17 08:36:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YCNvf-0000fc-ST
	for gcvg-git-2@plane.gmane.org; Sat, 17 Jan 2015 08:36:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751948AbbAQHgP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Jan 2015 02:36:15 -0500
Received: from mail-la0-f41.google.com ([209.85.215.41]:57102 "EHLO
	mail-la0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751287AbbAQHgO (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Jan 2015 02:36:14 -0500
Received: by mail-la0-f41.google.com with SMTP id hv19so22204631lab.0
        for <git@vger.kernel.org>; Fri, 16 Jan 2015 23:36:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=Wwy+tY3anxQesdpS2hIcLNoNcvYztbN5MxcU9tY8Zqk=;
        b=gNk0bcWjsIMk/RbxHQB5cZoTMnAGBdaFmCY7x8jclCtkIa6rCQlKKXi6GPHJ9oyBby
         k6R3+uNBh/6cnAbb/hW6DcgfNpcnr8RXXeO0m8LR81orNxsl6ZRFkVqwJ+PD3KWd+6WS
         DkMEFcwDmMdXEBB+VAHQ+00ZoCIj/AZesmxIXJu0aG4B31MRppb8ZiOxPuXfDj7V1GEZ
         cORiQzHI71G0mfKpsnGBkjG4nosXrz5iXFf1tUJ1jwkprYDX5bEu70cZsIFoSRA/A5T5
         +tbImYx92b2UwsI8G5FsDruYms0dtQcT00HK80IsPF6oMnNCEwA5BxUiQ7aE3o+4o2Li
         aq6w==
X-Received: by 10.152.4.8 with SMTP id g8mr1240819lag.58.1421480172919;
        Fri, 16 Jan 2015 23:36:12 -0800 (PST)
Received: from localhost.localdomain ([37.151.216.146])
        by mx.google.com with ESMTPSA id xh7sm1377095lbb.17.2015.01.16.23.36.10
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 16 Jan 2015 23:36:11 -0800 (PST)
X-Mailer: git-send-email 2.3.0.rc0.286.ga3dc223.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262580>

This patch adds support -d/--dry-run option for branch(es) deletion.
If -d/--dry-run option passed to git branch -d branch..., branch(es)
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
