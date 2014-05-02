From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v6 0/7] Reject non-ff pulls by default
Date: Thu,  1 May 2014 19:00:01 -0500
Message-ID: <1398988808-29678-1-git-send-email-felipe.contreras@gmail.com>
Cc: Andreas Krey <a.krey@gmx.de>, John Keeping <john@keeping.me.uk>,
	Jeff King <peff@peff.net>, Richard Hansen <rhansen@bbn.com>,
	Philip Oakley <philipoakley@iee.org>,
	"Brian M. Carlson" <sandals@crustytoothpaste.net>,
	"W. Trevor King" <wking@tremily.us>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 02 02:10:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wg141-0000Qm-B6
	for gcvg-git-2@plane.gmane.org; Fri, 02 May 2014 02:10:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752680AbaEBAKt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 May 2014 20:10:49 -0400
Received: from mail-oa0-f46.google.com ([209.85.219.46]:43532 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752241AbaEBAKs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 May 2014 20:10:48 -0400
Received: by mail-oa0-f46.google.com with SMTP id i4so3644617oah.5
        for <git@vger.kernel.org>; Thu, 01 May 2014 17:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=G3OQdr86rdl88dSrRLLHwr6KorqJQrPT1FZhHAanRT8=;
        b=DL6e4Kh6tZxsT9Vp2N7bYiiQv1kzxoUCF0IcbqNdr0w2TgWkyU3mZ0XKeT6g0z2XhJ
         +/q3Jb76YFB0kDk4cZLBFovvLEffuNxkjXH9DcFkJN60VuETo6tmWOFosfswgR2to1PV
         u4F4VWOa91FF6baVf8lHSa1Vbftd69UB/knzAScyJ0yRt6V9Xxo043wbtc/dSzo6/YTK
         32nkubB54hYiT01h2RipC4ZZT1OcY1/WxvgBLW9J2XSsD7A0svW5BypjCB6RD057hyIb
         wwiJCtAv7MpF4V+akktp7zzmVBvXL6U5bd2XdbK+3ToAMewEW1gCNYi/ERVHMgswjt6I
         crTg==
X-Received: by 10.60.63.12 with SMTP id c12mr13625186oes.23.1398989448183;
        Thu, 01 May 2014 17:10:48 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id wy2sm62724392obc.21.2014.05.01.17.10.44
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 May 2014 17:10:47 -0700 (PDT)
X-Mailer: git-send-email 1.9.2+fc1.19.g85b6256
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247901>

NOTE: Added a commit to throw a warning before the final switch.

It is very typical for Git newcomers to inadvertently create merges and worst:
inadvertently pushing them. This is one of the reasons many experienced users
prefer to avoid 'git pull', and recommend newcomers to avoid it as well.

To avoid these problems and keep 'git pull' useful, it has been agreed that
'git pull' should barf by default if the merge is non-fast-forward.
Unfortunately this breaks backwards-compatibility, so we need to be careful
about the error messages we give, and that we provide enough information to our
users to move forward without distrupting their workflow too much.

With the proper error messages and documentation, it has been agreed that the
new behavior is OK.

These are the steps needed to achieve this:

4) Only allow fast-forward merges by default

We could pass --ff-only to `git merge`, however, if we do that we'll get an error like this:

  Not possible to fast-forward, aborting.

This is not friendly; we want an error that is user-friendly:

  The pull was not fast-forward, please either merge or rebase.
  If unsure, run 'git pull --merge'.

When we do this we want to give the users the option to go back to the previous
behavior, so a new configuration is needed.

3) Add ff-only config

This option would trigger a check inside `git pull` itself, and error out with
the aforementioned message if it's not possible to do a fast-forward merge.

However, this option conflicts with --rebase, and --no-rebase. Solution below.

2) Add --merge option

Since we have a message that says "If unsure, run 'git pull --merge'", which is
more friendly than 'git pull --no-rebase', we should add this option, and
deprecate --no-rebase.

However, the documentation would become confusing if --merge is configured in
pull.rebase, instead, we want something like this:

  See `pull.mode`, `branch.<name>.pullmode` in linkgit:git-config[1] if you want
  to make `git pull` always use `--merge`.

1) Rename pull.rename to pull.mode and
   branch.<name>.rebase to branch.<name>.pullmode

This way the configurations and options remain consistent:

  git pull --merge
  pull.mode = merge
  branch.<name>.pullmode = merge

  git pull --rebase
  pull.mode = rebase
  branch.<name>.pullmode = rebase

  git pull --rebase=preserve
  pull.mode = rebase-preserve
  branch.<name>.pullmode = rebase-preserve

  git pull
  pull.mode = ff-only
  branch.<name>.pullmode = ff-only
 
This patch series does all the steps mentioned, but in reverse order, and in
addition updates the tests to use the new configurations instead.

Changes since v5:

 * Add commit to enable a transitional warning
 * Renamed option to ff-only
 * Added deprecation documentation for configs
 * Removed config deprecation warnings

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 4ebd3b5..b391ec1 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -774,6 +774,8 @@ branch.<name>.pullmode::
 	'git rebase' so that locally committed merge commits will not be
 	flattened by running 'git pull'.
 +
+	It was named 'branch.<name>.rebase' but that is deprecated now.
++
 *NOTE*: this is a possibly dangerous operation; do *not* use
 it unless you understand the implications (see linkgit:git-rebase[1]
 for details).
@@ -1884,8 +1886,8 @@ pretty.<name>::
 pull.mode::
 	When "git pull" is run, this determines if it would either merge or
 	rebase the fetched branch. The possible values are 'merge',
-	'rebase', 'merge-ff-only,' and 'rebase-preserve'.
-	If 'merge-ff-only' is specified, the merge will only succeed if it's
+	'rebase', 'ff-only,' and 'rebase-preserve'.
+	If 'ff-only' is specified, the merge will only succeed if it's
 	fast-forward.
 	See "branch.<name>.pullmode" for doing this in a non branch-specific
 	manner.
@@ -1894,6 +1896,9 @@ pull.mode::
 	'git rebase' so that locally committed merge commits will not be
 	flattened by running 'git pull'.
 +
++
+	It was named 'pull.rebase' but that is deprecated now.
++
 *NOTE*: this is a possibly dangerous operation; do *not* use
 it unless you understand the implications (see linkgit:git-rebase[1]
 for details).
diff --git a/Documentation/git-pull.txt b/Documentation/git-pull.txt
index ca8e951..968315c 100644
--- a/Documentation/git-pull.txt
+++ b/Documentation/git-pull.txt
@@ -54,7 +54,7 @@ Then `git pull` will merge in a fast-foward way up to the new master.
 However, a non-fast-foward case looks very different.
 
 ------------
-	  A---B---C origin/master
+	  A---B---C master on origin
 	 /
     D---E---F---G master
 	^
diff --git a/git-pull.sh b/git-pull.sh
index 8cf8f68..bccaf27 100755
--- a/git-pull.sh
+++ b/git-pull.sh
@@ -16,7 +16,7 @@ cd_to_toplevel
 
 
 warn () {
-	printf >&2 '%s\n' "$*"
+	printf >&2 'warning: %s\n' "$*"
 }
 
 die_conflict () {
@@ -57,7 +57,7 @@ then
 	mode=$(git config pull.mode)
 fi
 case "$mode" in
-merge|rebase|merge-ff-only|'')
+merge|rebase|ff-only|'')
 	;;
 rebase-preserve)
 	mode="rebase"
@@ -69,7 +69,7 @@ rebase-preserve)
 	exit 1
 	;;
 esac
-
+# backwards compatibility
 if test -z "$mode"
 then
 	rebase=$(bool_or_string_config branch.$curr_branch_short.rebase)
@@ -77,13 +77,8 @@ then
 	then
 		rebase=$(bool_or_string_config pull.rebase)
 	fi
-	if test -n "$rebase"
-	then
-		warn "$(gettext "The configurations pull.rebase and branch.<name>.rebase are deprecated.")"
-		warn "$(gettext "Please use pull.mode and branch.<name>.pullmode instead.")"
-	fi
 fi
-test -z "$mode" && mode=merge-ff-only
+test -z "$mode" && mode=ff-only
 dry_run=
 while :
 do
@@ -322,7 +317,7 @@ case "$merge_head" in
 *)
 	# check if a non-fast-foward merge would be needed
 	merge_head=${merge_head% }
-	if test "$mode" = merge-ff-only -a -z "$no_ff$ff_only${squash#--no-squash}" &&
+	if test "$mode" = 'ff-only' && test -z "$no_ff$ff_only${squash#--no-squash}" &&
 		test -n "$orig_head" &&
 		! git merge-base --is-ancestor "$orig_head" "$merge_head" &&
 		! git merge-base --is-ancestor "$merge_head" "$orig_head"
diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
index 2e2b476..dc7749b 100755
--- a/t/t5520-pull.sh
+++ b/t/t5520-pull.sh
@@ -365,9 +365,9 @@ test_expect_success 'git pull --rebase against local branch' '
 	test file = "$(cat file2)"
 '
 
-test_expect_success 'git pull fast-forward' '
+test_expect_success 'git pull fast-forward (ff-only)' '
 	test_when_finished "git checkout master && git branch -D other test" &&
-	test_config pull.mode merge-ff-only &&
+	test_config pull.mode ff-only &&
 	git checkout -b other master &&
 	>new &&
 	git add new &&
@@ -377,9 +377,9 @@ test_expect_success 'git pull fast-forward' '
 	git pull
 '
 
-test_expect_success 'git pull non-fast-forward' '
+test_expect_success 'git pull non-fast-forward (ff-only)' '
 	test_when_finished "git checkout master && git branch -D other test" &&
-	test_config pull.mode merge-ff-only &&
+	test_config pull.mode ff-only &&
 	git checkout -b other master^ &&
 	>new &&
 	git add new &&
@@ -389,9 +389,9 @@ test_expect_success 'git pull non-fast-forward' '
 	test_must_fail git pull
 '
 
-test_expect_success 'git pull non-fast-forward (merge)' '
+test_expect_success 'git pull non-fast-forward with merge (ff-only)' '
 	test_when_finished "git checkout master && git branch -D other test" &&
-	test_config pull.mode merge-ff-only &&
+	test_config pull.mode ff-only &&
 	git checkout -b other master^ &&
 	>new &&
 	git add new &&
@@ -401,4 +401,15 @@ test_expect_success 'git pull non-fast-forward (merge)' '
 	git pull --merge
 '
 
+test_expect_success 'git pull non-fast-forward (default)' '
+	test_when_finished "git checkout master && git branch -D other test" &&
+	git checkout -b other master^ &&
+	>new &&
+	git add new &&
+	git commit -m new &&
+	git checkout -b test -t other &&
+	git reset --hard master &&
+	test_must_fail git pull
+'
+
 test_done


Felipe Contreras (7):
  pull: rename pull.rebase to pull.mode
  pull: migrate all the tests to pull.mode
  pull: refactor $rebase variable into $mode
  pull: add --merge option
  pull: add merge-ff-only option
  pull: add warning on non-ff merges
  pull: only allow ff merges by default

 Documentation/config.txt     |  42 ++++++++++--------
 Documentation/git-pull.txt   |  28 ++++++++++--
 branch.c                     |   4 +-
 builtin/remote.c             |  14 +++++-
 git-pull.sh                  | 100 +++++++++++++++++++++++++++++++-----------
 t/t3200-branch.sh            |  40 ++++++++---------
 t/t4013-diff-various.sh      |   2 +-
 t/t5500-fetch-pack.sh        |   2 +-
 t/t5505-remote.sh            |   2 +-
 t/t5520-pull.sh              | 101 ++++++++++++++++++++++++++++++-------------
 t/t5524-pull-msg.sh          |   2 +-
 t/t5601-clone.sh             |   4 +-
 t/t5700-clone-reference.sh   |   4 +-
 t/t6022-merge-rename.sh      |  20 ++++-----
 t/t6026-merge-attr.sh        |   2 +-
 t/t6029-merge-subtree.sh     |   6 +--
 t/t6037-merge-ours-theirs.sh |  10 ++---
 17 files changed, 256 insertions(+), 127 deletions(-)

-- 
1.9.2+fc1.19.g85b6256
