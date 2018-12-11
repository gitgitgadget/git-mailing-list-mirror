Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1DE0C20A1E
	for <e@80x24.org>; Tue, 11 Dec 2018 04:08:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729146AbeLKEIt (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Dec 2018 23:08:49 -0500
Received: from washoe.dartmouth.edu ([129.170.30.229]:54778 "EHLO
        smtp.onerussian.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727566AbeLKEIt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Dec 2018 23:08:49 -0500
Received: from c-76-24-253-1.hsd1.nh.comcast.net ([76.24.253.1] helo=localhost)
        by smtp.onerussian.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <yoh@onerussian.com>)
        id 1gWZLi-0004zL-Cm; Mon, 10 Dec 2018 23:08:46 -0500
From:   Yaroslav Halchenko <debian@onerussian.com>
To:     git@vger.kernel.org
Cc:     Yaroslav Halchenko <debian@onerussian.com>
Date:   Mon, 10 Dec 2018 23:08:38 -0500
Message-Id: <20181211040839.17472-1-debian@onerussian.com>
X-Mailer: git-send-email 2.20.0.rc2.8.g0a3bec4a1c.dirty
In-Reply-To: <CAGZ79kYDa27EFk4A9uEzCnoW7scjb1U8fKwCo0P7rUZESto+Qg@mail.gmail.com>
References: <CAGZ79kYDa27EFk4A9uEzCnoW7scjb1U8fKwCo0P7rUZESto+Qg@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 76.24.253.1
X-SA-Exim-Rcpt-To: git@vger.kernel.org, yoh@onerussian.com
X-SA-Exim-Mail-From: yoh@onerussian.com
Subject: [PATCH 1/2] submodule: Add --reset-hard option for git submodule update
X-SA-Exim-Version: 4.2.1 (built Mon, 26 Dec 2011 16:57:07 +0000)
X-SA-Exim-Scanned: Yes (on smtp.onerussian.com)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch adds a --reset-hard option for the update command to hard
reset submodule(s) to the gitlink for the corresponding submodule in
the superproject.  This feature is desired e.g. to be able to discard
recent changes in the entire hierarchy of the submodules after running

   git reset --hard PREVIOUS_STATE

in the superproject which leaves submodules in their original state,
and

   git reset --hard --recurse-submodules PREVIOUS_STATE

would result in the submodules being checked into detached HEADs.

As in the original  git reset --hard  no checks or any kind of
safe-guards against jumping into some state which was never on the
current branch is done.

must_die_on_failure is not set to  yes to mimic behavior of a update
--checkout strategy, which would leave user with a non-clean state
immediately apparent via  git status  so an informed decision/actions
could be done manually.

Signed-off-by: Yaroslav Halchenko <debian@onerussian.com>
---
 Documentation/git-submodule.txt | 12 +++++++++++-
 Documentation/gitmodules.txt    |  4 ++--
 builtin/submodule--helper.c     |  3 ++-
 git-submodule.sh                | 10 +++++++++-
 submodule.c                     |  4 ++++
 submodule.h                     |  1 +
 t/t7406-submodule-update.sh     | 17 ++++++++++++++++-
 7 files changed, 45 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
index ba3c4df550..f4e0483997 100644
--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
@@ -124,7 +124,7 @@ If you really want to remove a submodule from the repository and commit
 that use linkgit:git-rm[1] instead. See linkgit:gitsubmodules[7] for removal
 options.
 
-update [--init] [--remote] [-N|--no-fetch] [--[no-]recommend-shallow] [-f|--force] [--checkout|--rebase|--merge] [--reference <repository>] [--depth <depth>] [--recursive] [--jobs <n>] [--] [<path>...]::
+update [--init] [--remote] [-N|--no-fetch] [--[no-]recommend-shallow] [-f|--force] [--checkout|--rebase|--merge|--reset-hard] [--reference <repository>] [--depth <depth>] [--recursive] [--jobs <n>] [--] [<path>...]::
 +
 --
 Update the registered submodules to match what the superproject
@@ -358,6 +358,16 @@ the submodule itself.
 	If the key `submodule.$name.update` is set to `rebase`, this option is
 	implicit.
 
+--reset-hard::
+	This option is only valid for the update command.
+	Hard reset current state to the commit recorded in the	superproject.
+	If this option is given, the submodule's HEAD will not get detached
+	if it was not detached before. Note that, like with a regular
+	`git reset --hard` no safe-guards are in place to prevent jumping
+	to a commit which was never part of the current branch.
+	If the key `submodule.$name.update` is set to `reset-hard`, this
+	option is implicit.
+
 --init::
 	This option is only valid for the update command.
 	Initialize all submodules for which "git submodule init" has not been
diff --git a/Documentation/gitmodules.txt b/Documentation/gitmodules.txt
index 312b6f9259..e085dbc01f 100644
--- a/Documentation/gitmodules.txt
+++ b/Documentation/gitmodules.txt
@@ -43,8 +43,8 @@ submodule.<name>.update::
 	command in the superproject. This is only used by `git
 	submodule init` to initialize the configuration variable of
 	the same name. Allowed values here are 'checkout', 'rebase',
-	'merge' or 'none'. See description of 'update' command in
-	linkgit:git-submodule[1] for their meaning. Note that the
+	'merge', 'reset-hard' or 'none'. See description of 'update' command
+	in linkgit:git-submodule[1] for their meaning. Note that the
 	'!command' form is intentionally ignored here for security
 	reasons.
 
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index d38113a31a..31d95c3cd6 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -1481,6 +1481,7 @@ static void determine_submodule_update_strategy(struct repository *r,
 	if (just_cloned &&
 	    (out->type == SM_UPDATE_MERGE ||
 	     out->type == SM_UPDATE_REBASE ||
+	     out->type == SM_UPDATE_RESET_HARD ||
 	     out->type == SM_UPDATE_NONE))
 		out->type = SM_UPDATE_CHECKOUT;
 
@@ -1851,7 +1852,7 @@ static int update_clone(int argc, const char **argv, const char *prefix)
 			      "submodule boundaries")),
 		OPT_STRING(0, "update", &update,
 			   N_("string"),
-			   N_("rebase, merge, checkout or none")),
+			   N_("rebase, merge, checkout, reset-hard or none")),
 		OPT_STRING_LIST(0, "reference", &suc.references, N_("repo"),
 			   N_("reference repository")),
 		OPT_BOOL(0, "dissociate", &suc.dissociate,
diff --git a/git-submodule.sh b/git-submodule.sh
index 5e608f8bad..b5d6fad983 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -9,7 +9,7 @@ USAGE="[--quiet] add [-b <branch>] [-f|--force] [--name <name>] [--reference <re
    or: $dashless [--quiet] status [--cached] [--recursive] [--] [<path>...]
    or: $dashless [--quiet] init [--] [<path>...]
    or: $dashless [--quiet] deinit [-f|--force] (--all| [--] <path>...)
-   or: $dashless [--quiet] update [--init] [--remote] [-N|--no-fetch] [-f|--force] [--checkout|--merge|--rebase] [--[no-]recommend-shallow] [--reference <repository>] [--recursive] [--] [<path>...]
+   or: $dashless [--quiet] update [--init] [--remote] [-N|--no-fetch] [-f|--force] [--checkout|--merge|--rebase|--reset-hard] [--[no-]recommend-shallow] [--reference <repository>] [--recursive] [--] [<path>...]
    or: $dashless [--quiet] summary [--cached|--files] [--summary-limit <n>] [commit] [--] [<path>...]
    or: $dashless [--quiet] foreach [--recursive] <command>
    or: $dashless [--quiet] sync [--recursive] [--] [<path>...]
@@ -483,6 +483,9 @@ cmd_update()
 		-m|--merge)
 			update="merge"
 			;;
+		--reset-hard)
+			update="reset-hard"
+			;;
 		--recursive)
 			recursive=1
 			;;
@@ -621,6 +624,11 @@ cmd_update()
 				say_msg="$(eval_gettext "Submodule path '\$displaypath': merged in '\$sha1'")"
 				must_die_on_failure=yes
 				;;
+			reset-hard)
+				command="git reset --hard"
+				die_msg="$(eval_gettext "Unable to reset --hard to '\$sha1' in submodule path '\$displaypath'")"
+				say_msg="$(eval_gettext "Submodule path '\$displaypath': was reset --hard to '\$sha1'")"
+				;;
 			!*)
 				command="${update_module#!}"
 				die_msg="$(eval_gettext "Execution of '\$command \$sha1' failed in submodule path '\$displaypath'")"
diff --git a/submodule.c b/submodule.c
index 6415cc5580..4580cf0944 100644
--- a/submodule.c
+++ b/submodule.c
@@ -373,6 +373,8 @@ enum submodule_update_type parse_submodule_update_type(const char *value)
 		return SM_UPDATE_REBASE;
 	else if (!strcmp(value, "merge"))
 		return SM_UPDATE_MERGE;
+	else if (!strcmp(value, "reset-hard"))
+		return SM_UPDATE_RESET_HARD;
 	else if (*value == '!')
 		return SM_UPDATE_COMMAND;
 	else
@@ -406,6 +408,8 @@ const char *submodule_strategy_to_string(const struct submodule_update_strategy
 		return "checkout";
 	case SM_UPDATE_MERGE:
 		return "merge";
+	case SM_UPDATE_RESET_HARD:
+		return "reset-hard";
 	case SM_UPDATE_REBASE:
 		return "rebase";
 	case SM_UPDATE_NONE:
diff --git a/submodule.h b/submodule.h
index a680214c01..f23ac4630e 100644
--- a/submodule.h
+++ b/submodule.h
@@ -29,6 +29,7 @@ enum submodule_update_type {
 	SM_UPDATE_CHECKOUT,
 	SM_UPDATE_REBASE,
 	SM_UPDATE_MERGE,
+	SM_UPDATE_RESET_HARD,
 	SM_UPDATE_NONE,
 	SM_UPDATE_COMMAND
 };
diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
index e87164aa8f..2e08e0047c 100755
--- a/t/t7406-submodule-update.sh
+++ b/t/t7406-submodule-update.sh
@@ -6,7 +6,8 @@
 test_description='Test updating submodules
 
 This test verifies that "git submodule update" detaches the HEAD of the
-submodule and "git submodule update --rebase/--merge" does not detach the HEAD.
+submodule and "git submodule update --rebase/--merge/--reset-hard" does
+not detach the HEAD.
 '
 
 . ./test-lib.sh
@@ -305,6 +306,20 @@ test_expect_success 'submodule update --merge staying on master' '
 	)
 '
 
+test_expect_success 'submodule update --reset-hard staying on master' '
+	(cd super/submodule &&
+	  git reset --hard HEAD~1
+	) &&
+	(cd super &&
+	 (cd submodule &&
+	  compare_head
+	 ) &&
+	 git submodule update --reset-hard submodule &&
+	 cd submodule &&
+	 compare_head
+	)
+'
+
 test_expect_success 'submodule update - rebase in .git/config' '
 	(cd super &&
 	 git config submodule.submodule.update rebase
-- 
2.20.0.rc2.8.g0a3bec4a1c.dirty

