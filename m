Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D5E5320899
	for <e@80x24.org>; Wed, 26 Jul 2017 10:27:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751614AbdGZK1k (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Jul 2017 06:27:40 -0400
Received: from smtp-out-4.talktalk.net ([62.24.135.68]:55916 "EHLO
        smtp-out-4.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751503AbdGZK1i (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Jul 2017 06:27:38 -0400
Received: from lindisfarne.localdomain ([92.22.28.33])
        by smtp.talktalk.net with SMTP
        id aJXGd63uhZtcPaJXUd3j2A; Wed, 26 Jul 2017 11:27:37 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net; s=1605;
        t=1501064857; bh=zugOFIBOW0n+t/Rg+RLCPe5fDhOG7ANV5y7T54ka8L4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
        b=p9MaoDBmwUxoS7DoFLQoBY1IeaLk3ag2Dhk+pCLJCz3t9lPF7iyR51AECZ5N+DwLU
         wkggul/VSXsCW5aq+tPanl2rlRr59KaGqCc/Fme1GcAmxZghviVYSaCg9cbLGm2gRt
         zsppK8HEioPUmgPTayNNuh6v3UuRg4V9ppRH12kQ=
X-Originating-IP: [92.22.28.33]
X-Spam: 0
X-OAuthority: v=2.2 cv=QqEc5h6d c=1 sm=1 tr=0 a=BeSdjzhxhZnKGFP9cxuqMA==:117
 a=BeSdjzhxhZnKGFP9cxuqMA==:17 a=evINK-nbAAAA:8 a=5rxgeBVgAAAA:8
 a=1XWaLZrsAAAA:8 a=xU00C62tSnmYIDRk4WkA:9 a=D_owUW3cxAVI-VK6:21
 a=HqelZRk_kKUWIb0q:21 a=RfR_gqz1fSpA9VikTjo0:22 a=PwKx63F5tFurRwaNxrlG:22
From:   Phillip Wood <phillip.wood@talktalk.net>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Philip Oakley <philipoakley@iee.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [RFC PATCH 1/5] rebase --continue: add --autostage to stage unstaged changes
Date:   Wed, 26 Jul 2017 11:27:16 +0100
Message-Id: <20170726102720.15274-2-phillip.wood@talktalk.net>
X-Mailer: git-send-email 2.13.3
In-Reply-To: <20170726102720.15274-1-phillip.wood@talktalk.net>
References: <20170726102720.15274-1-phillip.wood@talktalk.net>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
X-CMAE-Envelope: MS4wfCjnM9grWYwZBsQ99/6hSPqt6O1LU41gqKFGuLHvpwPaCn/++vV0WgOJf7k3Gv7/pk1mjIAwSEdVPFgKPq6nrATxuZgETXOWUbIQ2UGoVgr9whVnyXIw
 k0JwGVSLGZoq0NK1fVUnsMVurOD+xTYcxFfiQCOhGakosCN0k3g3FYiQdbtE+RH3A96pajZhz+At50NbR/PscbV1iyzMRzKtEuK6WrD/RoyCQJ/H6g5wwsP8
 g4hPG5oVYdzOa4baBR17GsgGZLc9sigIJySPYaMhsczhE3odHIPfkQDsP0yoVWTu
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

After resolving conflicts during a rebase it is a pain to have to run
'git add' before 'git rebase --continue'. Passing --autostage to 'git
rebase --continue' will stage them automatically so long as 'git diff
--check' says they are ok. This is a safety measure to avoid
accidentally staging files containing unresolved conflicts.

Continuing an interactive rebase after a failed exec or if HEAD has
changed since rebase stopped with --autostage will stage changes that
wont be committed as rebase --continue will bail out. This will be
fixed in the next commit.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---

Using diff check is not ideal as it will error out on whitespace
changes (which should be check in a commit hook if the user is worried
about them) as well as merge markers. Looking through diff.c it should
be possible to add a --check=merge-markers optional argument as the
two checks are enabled independently in the code. As Junio pointed out
in a previous message [1] the absence of conflict markers does not
indicate that a file is fully resolved but checking for them does at
least avoid the case of the user blindly continuing when they have
forgotten to look at a conflicted file.

The autostaging behaviour is opt-in so users who like the additional
safety of having to do git add before git rebase --continue can
continue using their current workflow.

I wonder if check_unstaged() should give different error messages
depending on the presence of unmerged paths rather than saying
'unstaged changes' all the time. Also it should probably have some
message after the check for merge markers fails rather than just the
raw output from diff --check.

[1] https://public-inbox.org/git/xmqqmv7td0a5.fsf@gitster.mtv.corp.google.com/


 git-rebase--am.sh          |  1 +
 git-rebase--interactive.sh |  1 +
 git-rebase--merge.sh       |  1 +
 git-rebase.sh              | 76 +++++++++++++++++++++++++++++++++++++++++-----
 4 files changed, 71 insertions(+), 8 deletions(-)

diff --git a/git-rebase--am.sh b/git-rebase--am.sh
index 375239341fbfe885e51a25e9e0dc2d4fee791345..30faa8c24cce2149a883c0055e3f6e93dabd2dd0 100644
--- a/git-rebase--am.sh
+++ b/git-rebase--am.sh
@@ -17,6 +17,7 @@ git_rebase__am () {
 
 case "$action" in
 continue)
+	check_unstaged
 	git am --resolved --resolvemsg="$resolvemsg" \
 		${gpg_sign_opt:+"$gpg_sign_opt"} &&
 	move_to_original_branch
diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 90b1fbe9cf6e8dfb2f4331916809fa40bf9050d2..4c037a3f7a9e01406c4205bf8786a3da5060381f 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -1069,6 +1069,7 @@ git_rebase__interactive () {
 
 case "$action" in
 continue)
+	check_unstaged
 	if test ! -d "$rewritten"
 	then
 		exec git rebase--helper ${force_rebase:+--no-ff} --continue
diff --git a/git-rebase--merge.sh b/git-rebase--merge.sh
index 06a4723d4db3db74ea17ace60d824e83cdee25e9..81723fc485882750c3ed7214b880d49cf55c6d68 100644
--- a/git-rebase--merge.sh
+++ b/git-rebase--merge.sh
@@ -16,6 +16,7 @@ read_state () {
 continue_merge () {
 	test -d "$state_dir" || die "$state_dir directory does not exist"
 
+	check_unstaged
 	unmerged=$(git ls-files -u)
 	if test -n "$unmerged"
 	then
diff --git a/git-rebase.sh b/git-rebase.sh
index 2cf73b88e8e83ca34b9eb319dbc2b0a220139b0f..9ca387349b1cde440c4244de9125446fd35a7b67 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -9,7 +9,7 @@ OPTIONS_STUCKLONG=t
 OPTIONS_SPEC="\
 git rebase [-i] [options] [--exec <cmd>] [--onto <newbase>] [<upstream>] [<branch>]
 git rebase [-i] [options] [--exec <cmd>] [--onto <newbase>] --root [<branch>]
-git-rebase --continue | --abort | --skip | --edit-todo
+git-rebase --continue [--autostage] | --abort | --skip | --edit-todo
 --
  Available options are
 v,verbose!         display a diffstat of what changed upstream
@@ -32,6 +32,7 @@ verify             allow pre-rebase hook to run
 rerere-autoupdate  allow rerere to update index with resolved conflicts
 root!              rebase all reachable commits up to the root(s)
 autosquash         move commits that begin with squash!/fixup! under -i
+a,autostage        add unstaged changes to the index when continuing
 committer-date-is-author-date! passed to 'git am'
 ignore-date!       passed to 'git am'
 signoff            passed to 'git am'
@@ -69,6 +70,7 @@ merge_dir="$GIT_DIR"/rebase-merge
 apply_dir="$GIT_DIR"/rebase-apply
 verbose=
 diffstat=
+autostage=false
 test "$(git config --bool rebase.stat)" = true && diffstat=t
 autostash="$(git config --bool rebase.autostash || echo false)"
 fork_point=auto
@@ -213,6 +215,67 @@ run_pre_rebase_hook () {
 	fi
 }
 
+check_autostage () {
+	# If the user has already staged files that contain whitespace
+	# errors or merge markers then we want ignore them so rebase
+	# --continue behaves consistency with and without --autostage
+	git diff-index --diff-filter=U --cached --name-only -z HEAD |
+		xargs -0 git diff-index --check HEAD -- &&
+	git diff-files --diff-filter=MA --check &&
+	git add -u ||
+		exit $?
+}
+
+autostage_advice () {
+	gettext "\
+Unable to continue rebasing as there are unstaged changes.
+Please stage or reset the changes before continuing with:
+
+  git rebase --continue
+
+or run:
+
+  git rebase --continue --autostage
+
+to stage them automatically.
+"
+}
+
+check_unstaged () {
+	git update-index --ignore-submodules --refresh >/dev/null
+	if ! git diff-files --quiet --ignore-submodules
+	then
+		if test $autostage = true
+		then
+			check_autostage
+		else
+			die "$(autostage_advice)"
+		fi
+	fi
+}
+
+parse_continue () {
+	action=continue
+	shift
+	while test $# != 0
+	do
+		case "$1" in
+		--autostage)
+			autostage=true
+			;;
+		--no-autostage)
+			autostage=false
+			;;
+		--)
+			;;
+		*)
+			usage
+			;;
+		esac
+	shift
+	done
+}
+
 test -f "$apply_dir"/applying &&
 	die "$(gettext "It looks like git-am is in progress. Cannot rebase.")"
 
@@ -243,7 +306,10 @@ do
 	--verify)
 		ok_to_skip_pre_rebase=
 		;;
-	--continue|--skip|--abort|--quit|--edit-todo)
+	--continue)
+		parse_continue "$@"
+		;;
+	--skip|--abort|--quit|--edit-todo)
 		test $total_argc -eq 2 || usage
 		action=${1##--}
 		;;
@@ -374,12 +440,6 @@ continue)
 	# Sanity check
 	git rev-parse --verify HEAD >/dev/null ||
 		die "$(gettext "Cannot read HEAD")"
-	git update-index --ignore-submodules --refresh &&
-	git diff-files --quiet --ignore-submodules || {
-		echo "$(gettext "You must edit all merge conflicts and then
-mark them as resolved using git add")"
-		exit 1
-	}
 	read_basic_state
 	run_specific_rebase
 	;;
-- 
2.13.3

