From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 23/23] checkout: retire --ignore-other-worktrees in favor of --force
Date: Fri,  3 Jul 2015 20:17:32 -0400
Message-ID: <1435969052-540-24-git-send-email-sunshine@sunshineco.com>
References: <1435969052-540-1-git-send-email-sunshine@sunshineco.com>
Cc: Junio C Hamano <gitster@pobox.com>, Duy Nguyen <pclouds@gmail.com>,
	Mark Levedahl <mlevedahl@gmail.com>,
	Mikael Magnusson <mikachu@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 04 02:19:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZBBBF-0000Yi-VO
	for gcvg-git-2@plane.gmane.org; Sat, 04 Jul 2015 02:19:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755546AbbGDATh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jul 2015 20:19:37 -0400
Received: from mail-ie0-f174.google.com ([209.85.223.174]:33731 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755962AbbGDASt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Jul 2015 20:18:49 -0400
Received: by ieqy10 with SMTP id y10so84666521ieq.0
        for <git@vger.kernel.org>; Fri, 03 Jul 2015 17:18:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=UvcYuaj5yiAoK5iK3hp1bHzckNaYFAqzLzLIT6OwPZo=;
        b=cRmWMOpXwTep0/Ioc15hZnBcs2cVDyziR36Q5ocmfHXWN3JxwqXdz8pS/qqqxW/VYk
         Wz+Iu5nFeY1//V0ufmp0TZkRZVMmnB7NqNZdoKK3Pm7QFSOS3dqxIWuwC6k+qZokA3A1
         UPI1kBX/iTKK/kzRJYkQe+2AfaWqhB1eqHa5T1oIHG561nitwZurOjH74FWV0/a0c7Fw
         bP2EankZGcfP+0thBJizBr0fwveaEd6CYQLlYXBHZ8QqYxPL1sSVeMMXorJOXD7Y8Vlf
         cG1e/j2DWvvrXdrkSZPs8Z/dfx7wQuLBGd0vdW7K4BPAdmcfvoQlAb5rzQ+HuGusMlZD
         tyGg==
X-Received: by 10.50.117.66 with SMTP id kc2mr25962590igb.31.1435969127520;
        Fri, 03 Jul 2015 17:18:47 -0700 (PDT)
Received: from localhost.localdomain (user-12l3cpl.cable.mindspring.com. [69.81.179.53])
        by mx.google.com with ESMTPSA id z195sm7246110iod.33.2015.07.03.17.18.45
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 03 Jul 2015 17:18:46 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.rc1.197.g417e668
In-Reply-To: <1435969052-540-1-git-send-email-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273334>

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
index 77b7141..41148ce 100644
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
@@ -232,12 +235,6 @@ section of linkgit:git-add[1] to learn how to operate the `--patch` mode.
 	specific files such as HEAD, index, etc. See
 	linkgit:git-worktree[1] for a description of linked worktrees.
 
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
index c8c6fa7..8a6c7fa 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -298,7 +298,7 @@ static int add(int ac, const char **av, const char *prefix)
 
 	argv_array_push(&cmd, "checkout");
 	if (force)
-		argv_array_push(&cmd, "--ignore-other-worktrees");
+		argv_array_push(&cmd, "--force");
 	if (new_branch)
 		argv_array_pushl(&cmd, "-b", new_branch, NULL);
 	if (new_branch_force)
-- 
2.5.0.rc1.197.g417e668
