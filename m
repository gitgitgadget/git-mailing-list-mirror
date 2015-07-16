From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 16/20] worktree: detect branch-name/detached and error conditions locally
Date: Thu, 16 Jul 2015 04:20:21 -0400
Message-ID: <1437034825-32054-17-git-send-email-sunshine@sunshineco.com>
References: <1437034825-32054-1-git-send-email-sunshine@sunshineco.com>
Cc: Junio C Hamano <gitster@pobox.com>, Duy Nguyen <pclouds@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 16 10:21:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZFePr-0008Ik-EU
	for gcvg-git-2@plane.gmane.org; Thu, 16 Jul 2015 10:21:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754343AbbGPIVF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Jul 2015 04:21:05 -0400
Received: from mail-ig0-f172.google.com ([209.85.213.172]:34439 "EHLO
	mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754024AbbGPIVA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Jul 2015 04:21:00 -0400
Received: by igvi1 with SMTP id i1so8056724igv.1
        for <git@vger.kernel.org>; Thu, 16 Jul 2015 01:21:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jCXhdnfl+vuc+SSP/f65JB75DO5gLrQZvGOMdIc1J70=;
        b=Ukkhu8nvlUUsnnsgTspDkbmBz7B0XTJUsPU3CO4yDlSYw6MbFOnaU7kFK3ui6+tbhs
         TCQLS/bCu7gVjQaysi9V1zRzt0kzAZcUT0dapJdp/t0mXNcjgXJMUyVmhr/A/YrAmbFI
         u9g6WxzgUBAbIeflG+nV1Bu9r5e/ppKZdOC4d2O/uYzJHeRy9OKhFLksv6mSjYEs/76v
         /xwsaPfZmEHpPaZkA1msqk+RD+vZnsg5QJEDt3Q4LAmKUXNZrD0Qh6hUFvbkEAmPiHd+
         8T0tFiD0RlWQrXMs5k1Ce8b+LMFddGz16wUKpKER8+iDgj9nH+AYnFEAEczoWq8C9vX8
         CzoQ==
X-Received: by 10.107.135.193 with SMTP id r62mr11228139ioi.29.1437034860243;
        Thu, 16 Jul 2015 01:21:00 -0700 (PDT)
Received: from localhost.localdomain (user-12l3cpl.cable.mindspring.com. [69.81.179.53])
        by smtp.gmail.com with ESMTPSA id j83sm4581146iod.25.2015.07.16.01.20.59
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 16 Jul 2015 01:20:59 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.rc2.378.g0af52e8
In-Reply-To: <1437034825-32054-1-git-send-email-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274011>

git-worktree currently conflates setting of HEAD in the new worktree
with initial worktree population via a single git-checkout invocation,
which requires git-checkout to have special knowledge that it is
operating in a newly created worktree. The eventual goal is to separate
these operations and rid git-checkout of that overly-intimate knowledge.

Once these operations are separate, git-worktree will no longer be able
to rely upon git-branch to determine the state of the worktree (branch
name or detached), or to check for error conditions, such as the
requested branch already checked out elsewhere, or an invalid reference.
Therefore, imbue git-worktree with the intelligence to determine a
branch name or detached state locally, and to perform error checking on
its own.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---

Changes since v1: don't bother calling ref_exists() for newly created
branch; add a few in-code comments explaining logic; reword commit
message.

 builtin/worktree.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/builtin/worktree.c b/builtin/worktree.c
index 28095c1..e8f3f30 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -3,6 +3,8 @@
 #include "dir.h"
 #include "parse-options.h"
 #include "argv-array.h"
+#include "branch.h"
+#include "refs.h"
 #include "run-command.h"
 #include "sigchain.h"
 
@@ -188,11 +190,26 @@ static int add_worktree(const char *path, const char *refname,
 	struct child_process cp;
 	struct argv_array child_env = ARGV_ARRAY_INIT;
 	int counter = 0, len, ret;
+	struct strbuf symref = STRBUF_INIT;
+	struct commit *commit = NULL;
 	unsigned char rev[20];
 
 	if (file_exists(path) && !is_empty_dir(path))
 		die(_("'%s' already exists"), path);
 
+	/* is 'refname' a branch or commit? */
+	if (opts->force_new_branch) /* definitely a branch */
+		;
+	else if (!opts->detach && !strbuf_check_branch_ref(&symref, refname) &&
+		 ref_exists(symref.buf)) { /* it's a branch */
+		if (!opts->force)
+			die_if_checked_out(symref.buf);
+	} else { /* must be a commit */
+		commit = lookup_commit_reference_by_name(refname);
+		if (!commit)
+			die(_("invalid reference: %s"), refname);
+	}
+
 	name = worktree_basename(path, &len);
 	strbuf_addstr(&sb_repo,
 		      git_path("worktrees/%.*s", (int)(path + len - name), name));
@@ -281,6 +298,7 @@ static int add_worktree(const char *path, const char *refname,
 	unlink_or_warn(sb.buf);
 	argv_array_clear(&child_env);
 	strbuf_release(&sb);
+	strbuf_release(&symref);
 	strbuf_release(&sb_repo);
 	strbuf_release(&sb_git);
 	return ret;
-- 
2.5.0.rc2.378.g0af52e8
