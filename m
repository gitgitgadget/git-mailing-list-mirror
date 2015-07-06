From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v3 23/23] checkout: retire --ignore-other-worktrees in favor of --force
Date: Mon,  6 Jul 2015 13:31:00 -0400
Message-ID: <1436203860-846-24-git-send-email-sunshine@sunshineco.com>
References: <1436203860-846-1-git-send-email-sunshine@sunshineco.com>
Cc: Junio C Hamano <gitster@pobox.com>, Duy Nguyen <pclouds@gmail.com>,
	Mark Levedahl <mlevedahl@gmail.com>,
	Mikael Magnusson <mikachu@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 06 19:32:07 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZCAFS-0007ti-Ck
	for gcvg-git-2@plane.gmane.org; Mon, 06 Jul 2015 19:32:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754143AbbGFRcB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jul 2015 13:32:01 -0400
Received: from mail-ie0-f176.google.com ([209.85.223.176]:34076 "EHLO
	mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754105AbbGFRbw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jul 2015 13:31:52 -0400
Received: by iebmu5 with SMTP id mu5so117799543ieb.1
        for <git@vger.kernel.org>; Mon, 06 Jul 2015 10:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=i61APdREYe3Gd++y0DmZ7eLzWBLE8zCgisSEB0m052s=;
        b=nH74TUn2iuhOJBxpP8+DyMO/wNqjoJh0OWd7ptXgdoKUfDYfBPi8mBZE+mA5E/yFG2
         Yjr1nVaaXXYLv9AnyKe72q9ru7Y0imlIXWlyWyisXOy++uxXV7Pna6ZRmIV15iFPR+pZ
         BcMuHCHyJQyeekpQHJ+fvQ0nrvcg6bRBbqqa1zg98s+3EaCsf1USIx6fPP/ZoY+0DSLL
         BR+tz5yd8WSrDswi19xW7xf8hwbzOCDFtWqx0DmEFEKzz1NXypOiZ3557NakBzjSw3jc
         7dgO8CstQxyq2HonRpGE3ZDNcIdjs5Nq3vUpJ6uIdThrhnEtlzRrOM/jOUA1d1L3wFvF
         tJfg==
X-Received: by 10.107.170.88 with SMTP id t85mr32027987ioe.71.1436203911482;
        Mon, 06 Jul 2015 10:31:51 -0700 (PDT)
Received: from localhost.localdomain (user-12l3cpl.cable.mindspring.com. [69.81.179.53])
        by mx.google.com with ESMTPSA id g18sm12861567iod.5.2015.07.06.10.31.50
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 06 Jul 2015 10:31:51 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.rc1.197.g417e668
In-Reply-To: <1436203860-846-1-git-send-email-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273423>

As a safeguard, checking out a branch already checked out by a different
worktree is disallowed. This behavior can be overridden with
--ignore-other-worktrees, however, this option is neither obvious nor
particularly discoverable. As a common safeguard override, --force is
more likely to come to mind. Therefore, overload it to also suppress the
check for a branch already checked out elsewhere.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---

I plopped this patch at the end of the series so that it can be dropped
easily if desired since Junio indicated[1] that he would "moderately
object" to this change.

[1]: http://thread.gmane.org/gmane.comp.version-control.git/273032/focus=273108

 Documentation/git-checkout.txt | 9 +++------
 builtin/checkout.c             | 8 +++-----
 builtin/worktree.c             | 2 +-
 3 files changed, 7 insertions(+), 12 deletions(-)

diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkout.txt
index efe6a02..6c3085d 100644
--- a/Documentation/git-checkout.txt
+++ b/Documentation/git-checkout.txt
@@ -111,6 +111,9 @@ OPTIONS
 +
 When checking out paths from the index, do not fail upon unmerged
 entries; instead, unmerged entries are ignored.
++
+By default, checking out a branch already checked out in another worktree
+is disallowed. This overrides that safeguard.
 
 --ours::
 --theirs::
@@ -225,12 +228,6 @@ This means that you can use `git checkout -p` to selectively discard
 edits from your current working tree. See the ``Interactive Mode''
 section of linkgit:git-add[1] to learn how to operate the `--patch` mode.
 
---ignore-other-worktrees::
-	`git checkout` refuses when the wanted ref is already checked
-	out by another worktree. This option makes it check the ref
-	out anyway. In other words, the ref can be held by more than one
-	worktree.
-
 <branch>::
 	Branch to checkout; if it refers to a branch (i.e., a name that,
 	when prepended with "refs/heads/", is a valid ref), then that
diff --git a/builtin/checkout.c b/builtin/checkout.c
index 5754554..01c7c30 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -35,7 +35,6 @@ struct checkout_opts {
 	int writeout_stage;
 	int overwrite_ignore;
 	int ignore_skipworktree;
-	int ignore_other_worktrees;
 
 	const char *new_branch;
 	const char *new_branch_force;
@@ -903,7 +902,8 @@ static void check_linked_checkout(struct branch_info *new, const char *id)
 		strbuf_rtrim(&gitdir);
 	} else
 		strbuf_addstr(&gitdir, get_git_common_dir());
-	die(_("'%s' is already checked out at '%s'"), new->name, gitdir.buf);
+	die(_("'%s' is already checked out at '%s'; use --force to override"),
+	    new->name, gitdir.buf);
 done:
 	strbuf_release(&path);
 	strbuf_release(&sb);
@@ -1151,7 +1151,7 @@ static int checkout_branch(struct checkout_opts *opts,
 		char *head_ref = resolve_refdup("HEAD", 0, sha1, &flag);
 		if (head_ref &&
 		    (!(flag & REF_ISSYMREF) || strcmp(head_ref, new->path)) &&
-		    !opts->ignore_other_worktrees)
+		    !opts->force)
 			check_linked_checkouts(new);
 		free(head_ref);
 	}
@@ -1198,8 +1198,6 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 			 N_("do not limit pathspecs to sparse entries only")),
 		OPT_HIDDEN_BOOL(0, "guess", &dwim_new_local_branch,
 				N_("second guess 'git checkout no-such-branch'")),
-		OPT_BOOL(0, "ignore-other-worktrees", &opts.ignore_other_worktrees,
-			 N_("do not check if another worktree is holding the given ref")),
 		OPT_END(),
 	};
 
diff --git a/builtin/worktree.c b/builtin/worktree.c
index 69248ba..050b443 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -303,7 +303,7 @@ static int add(int ac, const char **av, const char *prefix)
 
 	argv_array_push(&cmd, "checkout");
 	if (force)
-		argv_array_push(&cmd, "--ignore-other-worktrees");
+		argv_array_push(&cmd, "--force");
 	if (new_branch)
 		argv_array_pushl(&cmd, "-b", new_branch, NULL);
 	if (new_branch_force)
-- 
2.5.0.rc1.197.g417e668
