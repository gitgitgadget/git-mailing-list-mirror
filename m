From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v5 1/6] pull: rename pull.rename to pull.mode
Date: Tue, 29 Apr 2014 06:17:01 -0500
Message-ID: <1398770226-9686-2-git-send-email-felipe.contreras@gmail.com>
References: <1398770226-9686-1-git-send-email-felipe.contreras@gmail.com>
Cc: Andreas Krey <a.krey@gmx.de>, John Keeping <john@keeping.me.uk>,
	Jeff King <peff@peff.net>, Richard Hansen <rhansen@bbn.com>,
	Philip Oakley <philipoakley@iee.org>,
	"Brian M. Carlson" <sandals@crustytoothpaste.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 29 13:28:12 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wf6Cp-0004pG-Uw
	for gcvg-git-2@plane.gmane.org; Tue, 29 Apr 2014 13:28:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933878AbaD2L1u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Apr 2014 07:27:50 -0400
Received: from mail-yk0-f181.google.com ([209.85.160.181]:43751 "EHLO
	mail-yk0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933848AbaD2L1q (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Apr 2014 07:27:46 -0400
Received: by mail-yk0-f181.google.com with SMTP id q200so40996ykb.12
        for <git@vger.kernel.org>; Tue, 29 Apr 2014 04:27:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ZwgL7RvddmzYQJUj/nd4v31JvRrwx9F310ID3DMMeCQ=;
        b=QfXAKX31oYSxJDHVBx68q/jFdgEavKySELjjiQMRX75xJ+IkvO1F4xblLLjkNYb/da
         BgwxHfs9oDB8L0ir2T/5fCLcBGIEnU8DXn7Tvi7WG9dWVI2JXlB4Wcl381MRMzI/H6ox
         MbAik48hbmLD2cytIj63Yu7LjjPYRIPoGtRq4pSGw+tx7LmCtesXTmempY2AMZvrkau1
         CqgwymJzh2Q60PifDQE9HNHIvWBtkQuATYKZIFWoqekTaMXfdLwE4s4MvKfCVPhXBhre
         ivBzHNDQrf36jOhOinz+4ZNTJWDDSjqjBat/m2RbP6gw+/Fa++BFAhBSn86WzZGF1g38
         Z69Q==
X-Received: by 10.236.84.98 with SMTP id r62mr24641312yhe.9.1398770865657;
        Tue, 29 Apr 2014 04:27:45 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id c72sm22981255yho.20.2014.04.29.04.27.43
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Apr 2014 04:27:44 -0700 (PDT)
X-Mailer: git-send-email 1.9.2+fc1.3.gade8541
In-Reply-To: <1398770226-9686-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247568>

Also 'branch.<name>.rebase' to 'branch.<name>.pullmode'.

This way 'pull.mode' can be set to 'merge', and the default can be
something else.

The old configurations still work, but get deprecated.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/config.txt   | 34 +++++++++++++++++-----------------
 Documentation/git-pull.txt |  2 +-
 branch.c                   |  4 ++--
 builtin/remote.c           | 14 ++++++++++++--
 git-pull.sh                | 39 +++++++++++++++++++++++++++++++++++++--
 t/t3200-branch.sh          | 40 ++++++++++++++++++++--------------------
 t/t5601-clone.sh           |  4 ++--
 7 files changed, 91 insertions(+), 46 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index c26a7c8..5978d35 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -708,7 +708,7 @@ branch.autosetupmerge::
 branch.autosetuprebase::
 	When a new branch is created with 'git branch' or 'git checkout'
 	that tracks another branch, this variable tells Git to set
-	up pull to rebase instead of merge (see "branch.<name>.rebase").
+	up pull to rebase instead of merge (see "branch.<name>.pullmode").
 	When `never`, rebase is never automatically set to true.
 	When `local`, rebase is set to true for tracked branches of
 	other local branches.
@@ -764,15 +764,15 @@ branch.<name>.mergeoptions::
 	option values containing whitespace characters are currently not
 	supported.
 
-branch.<name>.rebase::
-	When true, rebase the branch <name> on top of the fetched branch,
-	instead of merging the default branch from the default remote when
-	"git pull" is run. See "pull.rebase" for doing this in a non
-	branch-specific manner.
+branch.<name>.pullmode::
+	When "git pull" is run, this determines if it would either merge or
+	rebase the fetched branch. The possible values are 'merge',
+	'rebase', and 'rebase-preserve'. See "pull.mode" for doing this in a
+	non branch-specific manner.
 +
-	When preserve, also pass `--preserve-merges` along to 'git rebase'
-	so that locally committed merge commits will not be flattened
-	by running 'git pull'.
+	When 'rebase-preserve', also pass `--preserve-merges` along to
+	'git rebase' so that locally committed merge commits will not be
+	flattened by running 'git pull'.
 +
 *NOTE*: this is a possibly dangerous operation; do *not* use
 it unless you understand the implications (see linkgit:git-rebase[1]
@@ -1881,15 +1881,15 @@ pretty.<name>::
 	Note that an alias with the same name as a built-in format
 	will be silently ignored.
 
-pull.rebase::
-	When true, rebase branches on top of the fetched branch, instead
-	of merging the default branch from the default remote when "git
-	pull" is run. See "branch.<name>.rebase" for setting this on a
-	per-branch basis.
+pull.mode::
+	When "git pull" is run, this determines if it would either merge or
+	rebase the fetched branch. The possible values are 'merge',
+	'rebase', and 'rebase-preserve'. See "branch.<name>.pullmode" for doing
+	this in a non branch-specific manner.
 +
-	When preserve, also pass `--preserve-merges` along to 'git rebase'
-	so that locally committed merge commits will not be flattened
-	by running 'git pull'.
+	When 'rebase-preserve', also pass `--preserve-merges` along to
+	'git rebase' so that locally committed merge commits will not be
+	flattened by running 'git pull'.
 +
 *NOTE*: this is a possibly dangerous operation; do *not* use
 it unless you understand the implications (see linkgit:git-rebase[1]
diff --git a/Documentation/git-pull.txt b/Documentation/git-pull.txt
index 200eb22..9a91b9f 100644
--- a/Documentation/git-pull.txt
+++ b/Documentation/git-pull.txt
@@ -117,7 +117,7 @@ locally created merge commits will not be flattened.
 +
 When false, merge the current branch into the upstream branch.
 +
-See `pull.rebase`, `branch.<name>.rebase` and `branch.autosetuprebase` in
+See `pull.mode`, `branch.<name>.pullmode` and `branch.autosetuprebase` in
 linkgit:git-config[1] if you want to make `git pull` always use
 `--rebase` instead of merging.
 +
diff --git a/branch.c b/branch.c
index 723a36b..63ce671 100644
--- a/branch.c
+++ b/branch.c
@@ -71,8 +71,8 @@ void install_branch_config(int flag, const char *local, const char *origin, cons
 
 	if (rebasing) {
 		strbuf_reset(&key);
-		strbuf_addf(&key, "branch.%s.rebase", local);
-		git_config_set(key.buf, "true");
+		strbuf_addf(&key, "branch.%s.pullmode", local);
+		git_config_set(key.buf, "rebase");
 	}
 	strbuf_release(&key);
 
diff --git a/builtin/remote.c b/builtin/remote.c
index b3ab4cf..46d3c4d 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -264,7 +264,7 @@ static int config_read_branches(const char *key, const char *value, void *cb)
 		char *name;
 		struct string_list_item *item;
 		struct branch_info *info;
-		enum { REMOTE, MERGE, REBASE } type;
+		enum { REMOTE, MERGE, REBASE, PULLMODE } type;
 
 		key += 7;
 		if (ends_with(key, ".remote")) {
@@ -276,6 +276,9 @@ static int config_read_branches(const char *key, const char *value, void *cb)
 		} else if (ends_with(key, ".rebase")) {
 			name = xstrndup(key, strlen(key) - 7);
 			type = REBASE;
+		} else if (ends_with(key, ".pullmode")) {
+			name = xstrndup(key, strlen(key) - 9);
+			type = PULLMODE;
 		} else
 			return 0;
 
@@ -299,12 +302,19 @@ static int config_read_branches(const char *key, const char *value, void *cb)
 				space = strchr(value, ' ');
 			}
 			string_list_append(&info->merge, xstrdup(value));
-		} else {
+		} else if (type == REBASE) {
 			int v = git_config_maybe_bool(orig_key, value);
 			if (v >= 0)
 				info->rebase = v;
 			else if (!strcmp(value, "preserve"))
 				info->rebase = 1;
+		} else {
+			if (!strcmp(value, "rebase"))
+				info->rebase = 1;
+			else if (!strcmp(value, "merge"))
+				info->rebase = 0;
+			else if (!strcmp(value, "rebase-preserve"))
+				info->rebase = 1;
 		}
 	}
 	return 0;
diff --git a/git-pull.sh b/git-pull.sh
index 0a5aa2c..d4e25f1 100755
--- a/git-pull.sh
+++ b/git-pull.sh
@@ -15,6 +15,10 @@ require_work_tree_exists
 cd_to_toplevel
 
 
+warn () {
+	printf >&2 '%s\n' "$*"
+}
+
 die_conflict () {
     git diff-index --cached --name-status -r --ignore-submodules HEAD --
     if [ $(git config --bool --get advice.resolveConflict || echo true) = "true" ]; then
@@ -47,10 +51,41 @@ log_arg= verbosity= progress= recurse_submodules= verify_signatures=
 merge_args= edit= rebase_args=
 curr_branch=$(git symbolic-ref -q HEAD)
 curr_branch_short="${curr_branch#refs/heads/}"
-rebase=$(bool_or_string_config branch.$curr_branch_short.rebase)
+mode=$(git config branch.${curr_branch_short}.pullmode)
+if test -z "$mode"
+then
+	mode=$(git config pull.mode)
+fi
+case "$mode" in
+merge)
+	rebase="false"
+	;;
+rebase)
+	rebase="true"
+	;;
+rebase-preserve)
+	rebase="preserve"
+	;;
+'')
+	;;
+*)
+	echo "Invalid value for 'mode'"
+	usage
+	exit 1
+	;;
+esac
 if test -z "$rebase"
 then
-	rebase=$(bool_or_string_config pull.rebase)
+	rebase=$(bool_or_string_config branch.$curr_branch_short.rebase)
+	if test -z "$rebase"
+	then
+		rebase=$(bool_or_string_config pull.rebase)
+	fi
+	if test -n "$rebase"
+	then
+		warn "$(gettext "The configurations pull.rebase and branch.<name>.rebase are deprecated.")"
+		warn "$(gettext "Please use pull.mode and branch.<name>.pullmode instead.")"
+	fi
 fi
 dry_run=
 while :
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index fcdb867..b79aa75 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -559,7 +559,7 @@ test_expect_success 'autosetuprebase local on a tracked local branch' '
 	git branch --track myr1 mybase &&
 	test "$(git config branch.myr1.remote)" = . &&
 	test "$(git config branch.myr1.merge)" = refs/heads/mybase &&
-	test "$(git config branch.myr1.rebase)" = true
+	test "$(git config branch.myr1.pullmode)" = rebase
 '
 
 test_expect_success 'autosetuprebase always on a tracked local branch' '
@@ -571,7 +571,7 @@ test_expect_success 'autosetuprebase always on a tracked local branch' '
 	git branch --track myr2 mybase &&
 	test "$(git config branch.myr2.remote)" = . &&
 	test "$(git config branch.myr2.merge)" = refs/heads/mybase &&
-	test "$(git config branch.myr2.rebase)" = true
+	test "$(git config branch.myr2.pullmode)" = rebase
 '
 
 test_expect_success 'autosetuprebase remote on a tracked local branch' '
@@ -583,7 +583,7 @@ test_expect_success 'autosetuprebase remote on a tracked local branch' '
 	git branch --track myr3 mybase2 &&
 	test "$(git config branch.myr3.remote)" = . &&
 	test "$(git config branch.myr3.merge)" = refs/heads/mybase2 &&
-	! test "$(git config branch.myr3.rebase)" = true
+	! test "$(git config branch.myr3.pullmode)" = rebase
 '
 
 test_expect_success 'autosetuprebase never on a tracked local branch' '
@@ -595,7 +595,7 @@ test_expect_success 'autosetuprebase never on a tracked local branch' '
 	git branch --track myr4 mybase2 &&
 	test "$(git config branch.myr4.remote)" = . &&
 	test "$(git config branch.myr4.merge)" = refs/heads/mybase2 &&
-	! test "$(git config branch.myr4.rebase)" = true
+	! test "$(git config branch.myr4.pullmode)" = rebase
 '
 
 test_expect_success 'autosetuprebase local on a tracked remote branch' '
@@ -606,7 +606,7 @@ test_expect_success 'autosetuprebase local on a tracked remote branch' '
 	git branch --track myr5 local/master &&
 	test "$(git config branch.myr5.remote)" = local &&
 	test "$(git config branch.myr5.merge)" = refs/heads/master &&
-	! test "$(git config branch.myr5.rebase)" = true
+	! test "$(git config branch.myr5.pullmode)" = rebase
 '
 
 test_expect_success 'autosetuprebase never on a tracked remote branch' '
@@ -617,7 +617,7 @@ test_expect_success 'autosetuprebase never on a tracked remote branch' '
 	git branch --track myr6 local/master &&
 	test "$(git config branch.myr6.remote)" = local &&
 	test "$(git config branch.myr6.merge)" = refs/heads/master &&
-	! test "$(git config branch.myr6.rebase)" = true
+	! test "$(git config branch.myr6.pullmode)" = rebase
 '
 
 test_expect_success 'autosetuprebase remote on a tracked remote branch' '
@@ -628,7 +628,7 @@ test_expect_success 'autosetuprebase remote on a tracked remote branch' '
 	git branch --track myr7 local/master &&
 	test "$(git config branch.myr7.remote)" = local &&
 	test "$(git config branch.myr7.merge)" = refs/heads/master &&
-	test "$(git config branch.myr7.rebase)" = true
+	test "$(git config branch.myr7.pullmode)" = rebase
 '
 
 test_expect_success 'autosetuprebase always on a tracked remote branch' '
@@ -639,7 +639,7 @@ test_expect_success 'autosetuprebase always on a tracked remote branch' '
 	git branch --track myr8 local/master &&
 	test "$(git config branch.myr8.remote)" = local &&
 	test "$(git config branch.myr8.merge)" = refs/heads/master &&
-	test "$(git config branch.myr8.rebase)" = true
+	test "$(git config branch.myr8.pullmode)" = rebase
 '
 
 test_expect_success 'autosetuprebase unconfigured on a tracked remote branch' '
@@ -650,7 +650,7 @@ test_expect_success 'autosetuprebase unconfigured on a tracked remote branch' '
 	git branch --track myr9 local/master &&
 	test "$(git config branch.myr9.remote)" = local &&
 	test "$(git config branch.myr9.merge)" = refs/heads/master &&
-	test "z$(git config branch.myr9.rebase)" = z
+	test "z$(git config branch.myr9.pullmode)" = z
 '
 
 test_expect_success 'autosetuprebase unconfigured on a tracked local branch' '
@@ -661,7 +661,7 @@ test_expect_success 'autosetuprebase unconfigured on a tracked local branch' '
 	git branch --track myr10 mybase2 &&
 	test "$(git config branch.myr10.remote)" = . &&
 	test "$(git config branch.myr10.merge)" = refs/heads/mybase2 &&
-	test "z$(git config branch.myr10.rebase)" = z
+	test "z$(git config branch.myr10.pullmode)" = z
 '
 
 test_expect_success 'autosetuprebase unconfigured on untracked local branch' '
@@ -671,7 +671,7 @@ test_expect_success 'autosetuprebase unconfigured on untracked local branch' '
 	git branch --no-track myr11 mybase2 &&
 	test "z$(git config branch.myr11.remote)" = z &&
 	test "z$(git config branch.myr11.merge)" = z &&
-	test "z$(git config branch.myr11.rebase)" = z
+	test "z$(git config branch.myr11.pullmode)" = z
 '
 
 test_expect_success 'autosetuprebase unconfigured on untracked remote branch' '
@@ -681,7 +681,7 @@ test_expect_success 'autosetuprebase unconfigured on untracked remote branch' '
 	git branch --no-track myr12 local/master &&
 	test "z$(git config branch.myr12.remote)" = z &&
 	test "z$(git config branch.myr12.merge)" = z &&
-	test "z$(git config branch.myr12.rebase)" = z
+	test "z$(git config branch.myr12.pullmode)" = z
 '
 
 test_expect_success 'autosetuprebase never on an untracked local branch' '
@@ -692,7 +692,7 @@ test_expect_success 'autosetuprebase never on an untracked local branch' '
 	git branch --no-track myr13 mybase2 &&
 	test "z$(git config branch.myr13.remote)" = z &&
 	test "z$(git config branch.myr13.merge)" = z &&
-	test "z$(git config branch.myr13.rebase)" = z
+	test "z$(git config branch.myr13.pullmode)" = z
 '
 
 test_expect_success 'autosetuprebase local on an untracked local branch' '
@@ -703,7 +703,7 @@ test_expect_success 'autosetuprebase local on an untracked local branch' '
 	git branch --no-track myr14 mybase2 &&
 	test "z$(git config branch.myr14.remote)" = z &&
 	test "z$(git config branch.myr14.merge)" = z &&
-	test "z$(git config branch.myr14.rebase)" = z
+	test "z$(git config branch.myr14.pullmode)" = z
 '
 
 test_expect_success 'autosetuprebase remote on an untracked local branch' '
@@ -714,7 +714,7 @@ test_expect_success 'autosetuprebase remote on an untracked local branch' '
 	git branch --no-track myr15 mybase2 &&
 	test "z$(git config branch.myr15.remote)" = z &&
 	test "z$(git config branch.myr15.merge)" = z &&
-	test "z$(git config branch.myr15.rebase)" = z
+	test "z$(git config branch.myr15.pullmode)" = z
 '
 
 test_expect_success 'autosetuprebase always on an untracked local branch' '
@@ -725,7 +725,7 @@ test_expect_success 'autosetuprebase always on an untracked local branch' '
 	git branch --no-track myr16 mybase2 &&
 	test "z$(git config branch.myr16.remote)" = z &&
 	test "z$(git config branch.myr16.merge)" = z &&
-	test "z$(git config branch.myr16.rebase)" = z
+	test "z$(git config branch.myr16.pullmode)" = z
 '
 
 test_expect_success 'autosetuprebase never on an untracked remote branch' '
@@ -736,7 +736,7 @@ test_expect_success 'autosetuprebase never on an untracked remote branch' '
 	git branch --no-track myr17 local/master &&
 	test "z$(git config branch.myr17.remote)" = z &&
 	test "z$(git config branch.myr17.merge)" = z &&
-	test "z$(git config branch.myr17.rebase)" = z
+	test "z$(git config branch.myr17.pullmode)" = z
 '
 
 test_expect_success 'autosetuprebase local on an untracked remote branch' '
@@ -747,7 +747,7 @@ test_expect_success 'autosetuprebase local on an untracked remote branch' '
 	git branch --no-track myr18 local/master &&
 	test "z$(git config branch.myr18.remote)" = z &&
 	test "z$(git config branch.myr18.merge)" = z &&
-	test "z$(git config branch.myr18.rebase)" = z
+	test "z$(git config branch.myr18.pullmode)" = z
 '
 
 test_expect_success 'autosetuprebase remote on an untracked remote branch' '
@@ -758,7 +758,7 @@ test_expect_success 'autosetuprebase remote on an untracked remote branch' '
 	git branch --no-track myr19 local/master &&
 	test "z$(git config branch.myr19.remote)" = z &&
 	test "z$(git config branch.myr19.merge)" = z &&
-	test "z$(git config branch.myr19.rebase)" = z
+	test "z$(git config branch.myr19.pullmode)" = z
 '
 
 test_expect_success 'autosetuprebase always on an untracked remote branch' '
@@ -769,7 +769,7 @@ test_expect_success 'autosetuprebase always on an untracked remote branch' '
 	git branch --no-track myr20 local/master &&
 	test "z$(git config branch.myr20.remote)" = z &&
 	test "z$(git config branch.myr20.merge)" = z &&
-	test "z$(git config branch.myr20.rebase)" = z
+	test "z$(git config branch.myr20.pullmode)" = z
 '
 
 test_expect_success 'autosetuprebase always on detached HEAD' '
diff --git a/t/t5601-clone.sh b/t/t5601-clone.sh
index 5e67035..0e91b67 100755
--- a/t/t5601-clone.sh
+++ b/t/t5601-clone.sh
@@ -191,8 +191,8 @@ test_expect_success 'clone respects global branch.autosetuprebase' '
 		rm -fr dst &&
 		git clone src dst &&
 		cd dst &&
-		actual="z$(git config branch.master.rebase)" &&
-		test ztrue = $actual
+		actual="$(git config branch.master.pullmode)" &&
+		test "$actual" = rebase
 	)
 '
 
-- 
1.9.2+fc1.3.gade8541
