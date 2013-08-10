From: Stephen Haberman <stephen@exigencecorp.com>
Subject: [PATCH] pull: Allow pull to preserve merges when rebasing.
Date: Fri,  9 Aug 2013 23:58:56 -0500
Message-ID: <1376110736-11748-1-git-send-email-stephen@exigencecorp.com>
Cc: Johannes.Schindelin@gmx.de, avarab@gmail.com,
	Stephen Haberman <stephen@exigencecorp.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 10 06:59:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V81Gv-0005Ja-No
	for gcvg-git-2@plane.gmane.org; Sat, 10 Aug 2013 06:59:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751393Ab3HJE7V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Aug 2013 00:59:21 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:44355 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751162Ab3HJE7U (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Aug 2013 00:59:20 -0400
Received: by mail-ob0-f174.google.com with SMTP id wd6so4654348obb.19
        for <git@vger.kernel.org>; Fri, 09 Aug 2013 21:59:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=exigencecorp.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=N+zKT6BM5QyX+cW9NDmN6ezj05b55JWBavLxCp4EMdo=;
        b=ITQrVOAyRvOOP3w/madDipM3r/9ek5k4o1nZSLjGDXDfIqWcAaljWlRehHG+IoxNAC
         WD19J9CBOhf6jqVAVkc51BDU6qsunSmXAasZSGd7WpVvrDgHWvt0lG4Row1KTLs46YgO
         JjE/TaGd4Q0Ub8qZy0hNj59iD3jgy4R/TdVuc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=N+zKT6BM5QyX+cW9NDmN6ezj05b55JWBavLxCp4EMdo=;
        b=XPE0tH9qciHzxYB1HMXQvqvt+O6UHVuWdUtFl1xapFwfY1nn9CVATlB83mRJRuxMXD
         X+OovegGy7UPltNx9so6fTHL3CDJ6gHr5vb0g1FN3EyqJ3mjA6OSc9XBIdNoY9IwsK3I
         FkE2IcdL3SkFAODhyiEJUPUKohyp3YSoqJ3jy8ZyQvMd1iDBZlBP+qOLTFmQfDQQSp1k
         89nzKeqxRHBHbgiCB7T8EGISwujkKMzPeldnQdV58aT5rCDfzymLZnQv9pMKgJcgvIuR
         m2gyYP3ZMY2hJWjsIULBCW2o3R7TNFm2Tnr8/4I/LPzio6AHTInliV+pa455HSAmCBAO
         qPMg==
X-Gm-Message-State: ALoCoQmxZC7wGqosaigIBCWLA8SBSE34iHHBtPP3I7p65skQmokhu2u69FDWajU7FQtEcIqVQMU/
X-Received: by 10.60.58.71 with SMTP id o7mr3279580oeq.51.1376110760082;
        Fri, 09 Aug 2013 21:59:20 -0700 (PDT)
Received: from localhost.localdomain (wsip-184-187-11-226.om.om.cox.net. [184.187.11.226])
        by mx.google.com with ESMTPSA id z2sm22582783obi.3.2013.08.09.21.59.18
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 09 Aug 2013 21:59:19 -0700 (PDT)
X-Mailer: git-send-email 1.8.1.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232061>

If a user is working on master, and has merged in their feature branch, but now
has to "git pull" because master moved, with pull.rebase their feature branch
will be flattened into master.

This is because "git pull" currently does not know about rebase's preserve
merges flag, which would avoid this behavior, as it would instead replay just
the merge commit of the feature branch onto the new master, and not replay each
individual commit in the feature branch.

Add a --rebase=preserve option, which will pass along --preserve-merges to
rebase.

Also add 'preserve' to the allowed values for the pull.rebase config setting.

Signed-off-by: Stephen Haberman <stephen@exigencecorp.com>
---
Hey,

This is version 2 of my previous patch--I changed over to the --rebase=preserve
syntax as suggested by Johannes and Junio.

I also updated the documentation.

I believe it is ready for serious consideration. Please let me know if I'm
missing anything subtle or obvious.

Thanks,
Stephen

 Documentation/config.txt   |  8 ++++++++
 Documentation/git-pull.txt | 18 ++++++++++++------
 git-pull.sh                | 23 ++++++++++++++++++-----
 t/t5520-pull.sh            | 28 ++++++++++++++++++++++++++++
 4 files changed, 66 insertions(+), 11 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index ec57a15..4c22be2 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -766,6 +766,10 @@ branch.<name>.rebase::
 	"git pull" is run. See "pull.rebase" for doing this in a non
 	branch-specific manner.
 +
+	When preserve, also pass `--preserve-merges` along to 'git rebase'
+	so that locally committed merge commits will not be flattened
+	by running 'git pull'.
++
 *NOTE*: this is a possibly dangerous operation; do *not* use
 it unless you understand the implications (see linkgit:git-rebase[1]
 for details).
@@ -1826,6 +1830,10 @@ pull.rebase::
 	pull" is run. See "branch.<name>.rebase" for setting this on a
 	per-branch basis.
 +
+	When preserve, also pass `--preserve-merges` along to 'git rebase'
+	so that locally committed merge commits will not be flattened
+	by running 'git pull'.
++
 *NOTE*: this is a possibly dangerous operation; do *not* use
 it unless you understand the implications (see linkgit:git-rebase[1]
 for details).
diff --git a/Documentation/git-pull.txt b/Documentation/git-pull.txt
index 6ef8d59..87ff938 100644
--- a/Documentation/git-pull.txt
+++ b/Documentation/git-pull.txt
@@ -102,12 +102,18 @@ include::merge-options.txt[]
 :git-pull: 1
 
 -r::
---rebase::
-	Rebase the current branch on top of the upstream branch after
-	fetching.  If there is a remote-tracking branch corresponding to
-	the upstream branch and the upstream branch was rebased since last
-	fetched, the rebase uses that information to avoid rebasing
-	non-local changes.
+--rebase[=false|true|preserve]::
+	When true, rebase the current branch on top of the upstream
+	branch after fetching. If there is a remote-tracking branch
+	corresponding to the upstream branch and the upstream branch
+	was rebased since last fetched, the rebase uses that information
+	to avoid rebasing non-local changes.
++
+When preserve, also rebase the current branch on top of the upstream
+branch, but pass `--preserve-merges` along to `git rebase` so that
+locally created merge commits will not be flatten.
++
+When false, merge the current branch into the upstream branch.
 +
 See `pull.rebase`, `branch.<name>.rebase` and `branch.autosetuprebase` in
 linkgit:git-config[1] if you want to make `git pull` always use
diff --git a/git-pull.sh b/git-pull.sh
index f0df41c..d142b38 100755
--- a/git-pull.sh
+++ b/git-pull.sh
@@ -40,13 +40,13 @@ test -f "$GIT_DIR/MERGE_HEAD" && die_merge
 
 strategy_args= diffstat= no_commit= squash= no_ff= ff_only=
 log_arg= verbosity= progress= recurse_submodules= verify_signatures=
-merge_args= edit=
+merge_args= edit= rebase_args=
 curr_branch=$(git symbolic-ref -q HEAD)
 curr_branch_short="${curr_branch#refs/heads/}"
-rebase=$(git config --bool branch.$curr_branch_short.rebase)
+rebase=$(git config branch.$curr_branch_short.rebase)
 if test -z "$rebase"
 then
-	rebase=$(git config --bool pull.rebase)
+	rebase=$(git config pull.rebase)
 fi
 dry_run=
 while :
@@ -111,7 +111,14 @@ do
 		merge_args="$merge_args$xx "
 		;;
 	-r|--r|--re|--reb|--reba|--rebas|--rebase)
-		rebase=true
+		# if the value is already non-false, like preserve, leave it alone
+		if test -z "$rebase" -o false = "$rebase"
+		then
+			rebase=true
+		fi
+		;;
+	--rebase=*)
+		rebase="${1#*=}"
 		;;
 	--no-r|--no-re|--no-reb|--no-reba|--no-rebas|--no-rebase)
 		rebase=false
@@ -145,6 +152,12 @@ do
 	shift
 done
 
+if test preserve = "$rebase"
+then
+	rebase=true
+	rebase_args=--preserve-merges
+fi
+
 error_on_no_merge_candidates () {
 	exec >&2
 	for opt
@@ -292,7 +305,7 @@ fi
 merge_name=$(git fmt-merge-msg $log_arg <"$GIT_DIR/FETCH_HEAD") || exit
 case "$rebase" in
 true)
-	eval="git-rebase $diffstat $strategy_args $merge_args $verbosity"
+	eval="git-rebase $diffstat $strategy_args $merge_args $rebase_args $verbosity"
 	eval="$eval --onto $merge_head ${oldremoteref:-$merge_head}"
 	;;
 *)
diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
index ed4d9c8..29cd45d 100755
--- a/t/t5520-pull.sh
+++ b/t/t5520-pull.sh
@@ -148,6 +148,34 @@ test_expect_success 'branch.to-rebase.rebase should override pull.rebase' '
 	test new = $(git show HEAD:file2)
 '
 
+test_expect_success 'pull.rebase=preserve' '
+	git reset --hard before-rebase &&
+	test_config pull.rebase preserve &&
+	git checkout -b keep-merge second^ &&
+	test_commit file3 &&
+	git checkout to-rebase &&
+	git merge keep-merge &&
+	git tag before-preserve-rebase &&
+	git pull . copy &&
+	test $(git rev-parse HEAD^^) = $(git rev-parse copy) &&
+	test $(git rev-parse HEAD^2) = $(git rev-parse keep-merge)
+'
+
+test_expect_success '--rebase=preserve' '
+	git reset --hard before-preserve-rebase &&
+	git pull --rebase=preserve . copy &&
+	test $(git rev-parse HEAD^^) = $(git rev-parse copy) &&
+	test $(git rev-parse HEAD^2) = $(git rev-parse keep-merge)
+'
+
+test_expect_success '--rebase respects pull.rebase=preserve' '
+	git reset --hard before-preserve-rebase &&
+	test_config pull.rebase preserve &&
+	git pull --rebase . copy &&
+	test $(git rev-parse HEAD^^) = $(git rev-parse copy) &&
+	test $(git rev-parse HEAD^2) = $(git rev-parse keep-merge)
+'
+
 test_expect_success '--rebase with rebased upstream' '
 
 	git remote add -f me . &&
-- 
1.8.1.2
