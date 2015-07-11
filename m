From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 12/16] worktree: detect branch symref/detach and error conditions locally
Date: Fri, 10 Jul 2015 20:05:42 -0400
Message-ID: <1436573146-3893-13-git-send-email-sunshine@sunshineco.com>
References: <1436573146-3893-1-git-send-email-sunshine@sunshineco.com>
Cc: Duy Nguyen <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
	Mark Levedahl <mlevedahl@gmail.com>,
	Mikael Magnusson <mikachu@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 11 09:04:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZDopl-0005IE-C3
	for gcvg-git-2@plane.gmane.org; Sat, 11 Jul 2015 09:04:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752431AbbGKHEV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 Jul 2015 03:04:21 -0400
Received: from mail-ig0-f177.google.com ([209.85.213.177]:36588 "EHLO
	mail-ig0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751892AbbGKHEU (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Jul 2015 03:04:20 -0400
Received: by igrv9 with SMTP id v9so26954915igr.1
        for <git@vger.kernel.org>; Sat, 11 Jul 2015 00:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3AYm2VacBB2FtfTfVmUDeVm1Yy6/uJo6Vo99R5KpuoA=;
        b=SMcc+783gU59+AQps2aR2MOELXd/zpUaxLrZvKetj8GYnAKNwysD58qLmcD+rH4Bdn
         YNMkJvhWnOToy4LfcxyR7e+JbjpWKgdHvoxy6Vq+ngXfP3m9wnIulMAz3aphXdU2L3FC
         iJVtwqUaVk1lpyKUcO5S+D3WswkLOgtWV+rOZmrI+L5Lx3ebZaqXljbLfjNrChPqlo7s
         j9Qa7bgu9HapxFZCq7SZLpB3T550EvMkTEIPQ8yFBbxyCv3hlxFzhjDbBiH/X7YZ7IQ7
         /XsrzF+bqg4O3Y40O+/3pVWix3T9T6L6ZOLxOaUtKb3RgziCKfWG9OGDH+Ta5lcEszPW
         kcNA==
X-Received: by 10.50.43.230 with SMTP id z6mr1399918igl.64.1436573198476;
        Fri, 10 Jul 2015 17:06:38 -0700 (PDT)
Received: from localhost.localdomain (user-12l3cpl.cable.mindspring.com. [69.81.179.53])
        by smtp.gmail.com with ESMTPSA id g81sm7533321ioi.20.2015.07.10.17.06.37
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 10 Jul 2015 17:06:38 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.rc1.201.ga12d9f8
In-Reply-To: <1436573146-3893-1-git-send-email-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273852>

The eventual goal is for git-worktree to populate the new worktree via
"git reset --hard" rather than "git checkout". As a consequence,
git-worktree will no longer be able to rely upon git-branch to determine
the state of the worktree (detached or branch symref), or to check for
error conditions, such as the requested branch already checked out
elsewhere, or an invalid reference. Therefore, imbue git-worktree with
the intelligence to determine a branch symref or detached state locally,
and to perform error checking on its own.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---

This patch is somewhat RFC since I spent a lot of time browsing the
branch- and ref-related APIs figuring out how to determine if the
provided refname was a branch name or some other (detached) reference.
I'm not at all sure that my use of strbuf_check_branch_ref(),
ref_exists(), and lookup_commit_reference_by_name() is the best
approach, or even appropriate, although it seems to work as desired.

 builtin/worktree.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/builtin/worktree.c b/builtin/worktree.c
index e04a6d1..babdef1 100644
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
 
@@ -187,11 +189,23 @@ static int add_worktree(const char *path, const char *refname,
 	struct stat st;
 	struct child_process cp;
 	int counter = 0, len, ret;
+	struct strbuf symref = STRBUF_INIT;
+	struct commit *commit = NULL;
 	unsigned char rev[20];
 
 	if (file_exists(path) && !is_empty_dir(path))
 		die(_("'%s' already exists"), path);
 
+	if (!opts->detach && !strbuf_check_branch_ref(&symref, refname) &&
+	    ref_exists(symref.buf)) {
+		if (!opts->force)
+			die_if_checked_out(symref.buf);
+	} else {
+		commit = lookup_commit_reference_by_name(refname);
+		if (!commit)
+			die(_("invalid reference: %s"), refname);
+	}
+
 	name = worktree_basename(path, &len);
 	strbuf_addstr(&sb_repo,
 		      git_path("worktrees/%.*s", (int)(path + len - name), name));
@@ -278,6 +292,7 @@ static int add_worktree(const char *path, const char *refname,
 	strbuf_addf(&sb, "%s/locked", sb_repo.buf);
 	unlink_or_warn(sb.buf);
 	strbuf_release(&sb);
+	strbuf_release(&symref);
 	strbuf_release(&sb_repo);
 	strbuf_release(&sb_git);
 	return ret;
-- 
2.5.0.rc1.201.ga12d9f8
