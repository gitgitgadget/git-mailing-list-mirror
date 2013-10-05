From: Johan Herland <johan@herland.net>
Subject: [RFC/PATCHv2 3/3] Git 2.0: git svn: Set default --prefix='origin/' if --prefix is not given
Date: Sun,  6 Oct 2013 01:30:33 +0200
Message-ID: <1381015833-696-3-git-send-email-johan@herland.net>
References: <20131003190139.GA8710@dcvr.yhbt.net>
 <1381015833-696-1-git-send-email-johan@herland.net>
Cc: tfnico@gmail.com, Johan Herland <johan@herland.net>,
	Eric Wong <normalperson@yhbt.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 06 01:31:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VSbJq-00023H-BI
	for gcvg-git-2@plane.gmane.org; Sun, 06 Oct 2013 01:31:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752860Ab3JEXb0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Oct 2013 19:31:26 -0400
Received: from mail-lb0-f169.google.com ([209.85.217.169]:50725 "EHLO
	mail-lb0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752524Ab3JEXbJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Oct 2013 19:31:09 -0400
Received: by mail-lb0-f169.google.com with SMTP id z5so4574870lbh.28
        for <git@vger.kernel.org>; Sat, 05 Oct 2013 16:31:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=X4XNa5MSYXriBoQ8Jz0L6gQ/ge1VjxVDz0PnCYtu5Yo=;
        b=h3C7OCm8X4f/DqwdyThA8bbTb3ZGGvm1/R1ZQp34XUWTNffpWrazM9iLdqk9Fr0210
         te/vQFr2FbAipHWUgW2naGUUpH4kukP73Lgdjt8eXSY/jU0t9aerLs0SACzu/u8HJ4Q2
         06mfFAJb+7/brIm9MyrpGYqd3bpst8dXHoKqIXddgW29MJiEwdDOqbRq3YTyFwWXmR2f
         eABpBg8N70I2z4Djp0TugbVWLf6vlS+Jfhjsje46ohQ5HnX0M6A8ytYBbfGYT3CkkpbU
         00IP8NMHdTeRh7SVUTEuVUj7Qqlxuz/ub3HFLVQOHCbgIZygZjHqld1BCMXIK6UZsgTF
         pPAA==
X-Received: by 10.112.168.3 with SMTP id zs3mr18561359lbb.2.1381015867390;
        Sat, 05 Oct 2013 16:31:07 -0700 (PDT)
Received: from beta.herland (96.37-191-129.fiber.lynet.no. [37.191.129.96])
        by mx.google.com with ESMTPSA id i3sm17824544laf.4.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 05 Oct 2013 16:31:06 -0700 (PDT)
X-Mailer: git-send-email 1.8.4.653.g2df02b3
In-Reply-To: <1381015833-696-1-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235733>

git-svn by default puts its Subversion-tracking refs directly in
refs/remotes/*. This runs counter to Git's convention of using
refs/remotes/$remote/* for storing remote-tracking branches.

Furthermore, combining git-svn with regular git remotes run the risk of
clobbering refs under refs/remotes (e.g. if you have a git remote
called "tags" with a "v1" branch, it will overlap with the git-svn's
tracking branch for the "v1" tag from Subversion.

Even though the git-svn refs stored in refs/remotes/* are not "proper"
remote-tracking branches (since they are not covered by a proper git
remote's refspec), they clearly represent a similar concept, and would
benefit from following the same convention.

For example, if git-svn tracks Subversion branch "foo" at
refs/remotes/foo, and you create a local branch refs/heads/foo to add
some commits to be pushed back to Subversion (using "git svn dcommit),
then it is clearly unhelpful of Git to throw

  warning: refname 'foo' is ambiguous.

every time you checkout, rebase, or otherwise interact with the branch.

The existing workaround for this is to supply the --prefix=quux/ to
git svn init/clone, so that git-svn's tracking branches end up in
refs/remotes/quux/* instead of refs/remotes/*. However, encouraging
users to specify --prefix to work around a design flaw in git-svn is
suboptimal, and not a long term solution to the problem. Instead,
git-svn should default to use a non-empty prefix that saves
unsuspecting users from the inconveniences described above.

This patch will only affect newly created git-svn setups, as the
--prefix option only applies to git svn init (and git svn clone).
Existing git-svn setups will continue with their existing (lack of)
prefix. Also, if anyone somehow prefers git-svn's old layout, they
can recreate that by explicitly passing an empty prefix (--prefix "")
on the git svn init/clone command line.

The patch changes the default value for --prefix from "" to "origin/",
updates the git-svn manual page, and fixes the fallout in the git-svn
testcases.

(Note that this patch might be easier to review using the --word-diff
and --word-diff-regex=. diff options.)

Suggested-by: Thomas Ferris Nicolaisen <tfnico@gmail.com>
Cc: Eric Wong <normalperson@yhbt.net>
Signed-off-by: Johan Herland <johan@herland.net>
---
 Documentation/git-svn.txt                        | 19 +--------
 git-svn.perl                                     | 12 +-----
 t/t9107-git-svn-migrate.sh                       | 54 ++++++++++++------------
 t/t9114-git-svn-dcommit-merge.sh                 |  4 +-
 t/t9116-git-svn-log.sh                           | 46 ++++++++++----------
 t/t9117-git-svn-init-clone.sh                    | 16 +++----
 t/t9118-git-svn-funky-branch-names.sh            | 20 ++++-----
 t/t9120-git-svn-clone-with-percent-escapes.sh    | 14 +++---
 t/t9125-git-svn-multi-glob-branch-names.sh       |  6 +--
 t/t9128-git-svn-cmd-branch.sh                    | 18 ++++----
 t/t9135-git-svn-moved-branch-empty-file.sh       |  2 +-
 t/t9141-git-svn-multiple-branches.sh             | 28 ++++++------
 t/t9145-git-svn-master-branch.sh                 |  2 +-
 t/t9155-git-svn-fetch-deleted-tag.sh             |  4 +-
 t/t9156-git-svn-fetch-deleted-tag-2.sh           |  6 +--
 t/t9161-git-svn-mergeinfo-push.sh                | 22 +++++-----
 t/t9163-git-svn-reset-clears-caches.sh           |  4 +-
 t/t9165-git-svn-fetch-merge-branch-of-branch.sh  |  2 +-
 t/t9166-git-svn-fetch-merge-branch-of-branch2.sh |  2 +-
 t/t9167-git-svn-cmd-branch-subproject.sh         |  2 +-
 20 files changed, 128 insertions(+), 155 deletions(-)

diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
index 59e912e..43da05a 100644
--- a/Documentation/git-svn.txt
+++ b/Documentation/git-svn.txt
@@ -86,14 +86,7 @@ COMMANDS
 	(refs/remotes/$remote/*). Setting a prefix is also useful
 	if you wish to track multiple projects that share a common
 	repository.
-+
-NOTE: In Git v2.0, the default prefix will CHANGE from "" (no prefix)
-to "origin/". This is done to put SVN-tracking refs at
-"refs/remotes/origin/*" instead of "refs/remotes/*", and make them
-more compatible with how Git's own remote-tracking refs are organized
-(i.e. refs/remotes/$remote/*). You can enjoy the same benefits today,
-by using the --prefix option.
-
+	By default, the prefix is set to 'origin/'.
 --ignore-paths=<regex>;;
 	When passed to 'init' or 'clone' this regular expression will
 	be preserved as a config key.  See 'fetch' for a description
@@ -987,16 +980,6 @@ without giving any repository layout options.  If the full history with
 branches and tags is required, the options '--trunk' / '--branches' /
 '--tags' must be used.
 
-When using the options for describing the repository layout (--trunk,
---tags, --branches, --stdlayout), please also specify the --prefix
-option (e.g. '--prefix=origin/') to cause your SVN-tracking refs to be
-placed at refs/remotes/origin/* rather than the default refs/remotes/*.
-The former is more compatible with the layout of Git's "regular"
-remote-tracking refs (refs/remotes/$remote/*), and may potentially
-prevent similarly named SVN branches and Git remotes from clobbering
-eachother. In Git v2.0 the default prefix used (i.e. when no --prefix
-is given) will change from "" (no prefix) to "origin/".
-
 When using multiple --branches or --tags, 'git svn' does not automatically
 handle name collisions (for example, if two branches from different paths have
 the same name, or if a branch and a tag have the same name).  In these cases,
diff --git a/git-svn.perl b/git-svn.perl
index 0443a4f..ad3fe66 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -1389,17 +1389,7 @@ sub cmd_multi_init {
 		usage(1);
 	}
 
-	unless (defined $_prefix) {
-		$_prefix = '';
-		warn <<EOF
-WARNING: --prefix is not given, defaulting to empty prefix.
-         This is probably not what you want! In order to stay compatible
-         with regular remote-tracking refs, provide a prefix like
-         --prefix=origin/ (remember the trailing slash), which will cause
-         the SVN-tracking refs to be placed at refs/remotes/origin/*.
-NOTE: In Git v2.0, the default prefix will change from empty to 'origin/'.
-EOF
-	}
+	$_prefix = 'origin/' unless defined $_prefix;
 	if (defined $url) {
 		$url = canonicalize_url($url);
 		init_subdir(@_);
diff --git a/t/t9107-git-svn-migrate.sh b/t/t9107-git-svn-migrate.sh
index ee73013..6e69fc4 100755
--- a/t/t9107-git-svn-migrate.sh
+++ b/t/t9107-git-svn-migrate.sh
@@ -45,27 +45,27 @@ test_expect_success 'initialize old-style (v0) git svn layout' '
 test_expect_success 'initialize a multi-repository repo' '
 	git svn init "$svnrepo" -T trunk -t tags -b branches &&
 	git config --get-all svn-remote.svn.fetch > fetch.out &&
-	grep "^trunk:refs/remotes/trunk$" fetch.out &&
+	grep "^trunk:refs/remotes/origin/trunk$" fetch.out &&
 	test -n "`git config --get svn-remote.svn.branches \
-	            "^branches/\*:refs/remotes/\*$"`" &&
+	            "^branches/\*:refs/remotes/origin/\*$"`" &&
 	test -n "`git config --get svn-remote.svn.tags \
-	            "^tags/\*:refs/remotes/tags/\*$"`" &&
+	            "^tags/\*:refs/remotes/origin/tags/\*$"`" &&
 	git config --unset svn-remote.svn.branches \
-	                        "^branches/\*:refs/remotes/\*$" &&
+	                        "^branches/\*:refs/remotes/origin/\*$" &&
 	git config --unset svn-remote.svn.tags \
-	                        "^tags/\*:refs/remotes/tags/\*$" &&
-	git config --add svn-remote.svn.fetch "branches/a:refs/remotes/a" &&
-	git config --add svn-remote.svn.fetch "branches/b:refs/remotes/b" &&
+	                        "^tags/\*:refs/remotes/origin/tags/\*$" &&
+	git config --add svn-remote.svn.fetch "branches/a:refs/remotes/origin/a" &&
+	git config --add svn-remote.svn.fetch "branches/b:refs/remotes/origin/b" &&
 	for i in tags/0.1 tags/0.2 tags/0.3; do
 		git config --add svn-remote.svn.fetch \
-		                 $i:refs/remotes/$i || exit 1; done &&
+		                 $i:refs/remotes/origin/$i || exit 1; done &&
 	git config --get-all svn-remote.svn.fetch > fetch.out &&
-	grep "^trunk:refs/remotes/trunk$" fetch.out &&
-	grep "^branches/a:refs/remotes/a$" fetch.out &&
-	grep "^branches/b:refs/remotes/b$" fetch.out &&
-	grep "^tags/0\.1:refs/remotes/tags/0\.1$" fetch.out &&
-	grep "^tags/0\.2:refs/remotes/tags/0\.2$" fetch.out &&
-	grep "^tags/0\.3:refs/remotes/tags/0\.3$" fetch.out &&
+	grep "^trunk:refs/remotes/origin/trunk$" fetch.out &&
+	grep "^branches/a:refs/remotes/origin/a$" fetch.out &&
+	grep "^branches/b:refs/remotes/origin/b$" fetch.out &&
+	grep "^tags/0\.1:refs/remotes/origin/tags/0\.1$" fetch.out &&
+	grep "^tags/0\.2:refs/remotes/origin/tags/0\.2$" fetch.out &&
+	grep "^tags/0\.3:refs/remotes/origin/tags/0\.3$" fetch.out &&
 	grep "^:refs/${remotes_git_svn}" fetch.out
 	'
 
@@ -73,14 +73,14 @@ test_expect_success 'initialize a multi-repository repo' '
 test_expect_success 'multi-fetch works on partial urls + paths' "
 	git svn multi-fetch &&
 	for i in trunk a b tags/0.1 tags/0.2 tags/0.3; do
-		git rev-parse --verify refs/remotes/\$i^0 >> refs.out || exit 1;
+		git rev-parse --verify refs/remotes/origin/\$i^0 >> refs.out || exit 1;
 	    done &&
 	test -z \"\`sort < refs.out | uniq -d\`\" &&
 	for i in trunk a b tags/0.1 tags/0.2 tags/0.3; do
 	  for j in trunk a b tags/0.1 tags/0.2 tags/0.3; do
 		if test \$j != \$i; then continue; fi
-	    test -z \"\`git diff refs/remotes/\$i \
-	                         refs/remotes/\$j\`\" ||exit 1; done; done
+	    test -z \"\`git diff refs/remotes/origin/\$i \
+	                         refs/remotes/origin/\$j\`\" ||exit 1; done; done
 	"
 
 test_expect_success 'migrate --minimize on old inited layout' '
@@ -98,27 +98,27 @@ test_expect_success 'migrate --minimize on old inited layout' '
 	git svn migrate --minimize &&
 	test -z "`git config -l | grep "^svn-remote\.git-svn\."`" &&
 	git config --get-all svn-remote.svn.fetch > fetch.out &&
-	grep "^trunk:refs/remotes/trunk$" fetch.out &&
-	grep "^branches/a:refs/remotes/a$" fetch.out &&
-	grep "^branches/b:refs/remotes/b$" fetch.out &&
-	grep "^tags/0\.1:refs/remotes/tags/0\.1$" fetch.out &&
-	grep "^tags/0\.2:refs/remotes/tags/0\.2$" fetch.out &&
-	grep "^tags/0\.3:refs/remotes/tags/0\.3$" fetch.out &&
+	grep "^trunk:refs/remotes/origin/trunk$" fetch.out &&
+	grep "^branches/a:refs/remotes/origin/a$" fetch.out &&
+	grep "^branches/b:refs/remotes/origin/b$" fetch.out &&
+	grep "^tags/0\.1:refs/remotes/origin/tags/0\.1$" fetch.out &&
+	grep "^tags/0\.2:refs/remotes/origin/tags/0\.2$" fetch.out &&
+	grep "^tags/0\.3:refs/remotes/origin/tags/0\.3$" fetch.out &&
 	grep "^:refs/${remotes_git_svn}" fetch.out
 	'
 
 test_expect_success  ".rev_db auto-converted to .rev_map.UUID" '
 	git svn fetch -i trunk &&
-	test -z "$(ls "$GIT_DIR"/svn/refs/remotes/trunk/.rev_db.* 2>/dev/null)" &&
-	expect="$(ls "$GIT_DIR"/svn/refs/remotes/trunk/.rev_map.*)" &&
+	test -z "$(ls "$GIT_DIR"/svn/refs/remotes/origin/trunk/.rev_db.* 2>/dev/null)" &&
+	expect="$(ls "$GIT_DIR"/svn/refs/remotes/origin/trunk/.rev_map.*)" &&
 	test -n "$expect" &&
 	rev_db="$(echo $expect | sed -e "s,_map,_db,")" &&
 	convert_to_rev_db "$expect" "$rev_db" &&
 	rm -f "$expect" &&
 	test -f "$rev_db" &&
 	git svn fetch -i trunk &&
-	test -z "$(ls "$GIT_DIR"/svn/refs/remotes/trunk/.rev_db.* 2>/dev/null)" &&
-	test ! -e "$GIT_DIR"/svn/refs/remotes/trunk/.rev_db &&
+	test -z "$(ls "$GIT_DIR"/svn/refs/remotes/origin/trunk/.rev_db.* 2>/dev/null)" &&
+	test ! -e "$GIT_DIR"/svn/refs/remotes/origin/trunk/.rev_db &&
 	test -f "$expect"
 	'
 
diff --git a/t/t9114-git-svn-dcommit-merge.sh b/t/t9114-git-svn-dcommit-merge.sh
index f524d2f..6f0968a 100755
--- a/t/t9114-git-svn-dcommit-merge.sh
+++ b/t/t9114-git-svn-dcommit-merge.sh
@@ -48,7 +48,7 @@ test_expect_success 'setup svn repository' '
 test_expect_success 'setup git mirror and merge' '
 	git svn init "$svnrepo" -t tags -T trunk -b branches &&
 	git svn fetch &&
-	git checkout -b svn remotes/trunk &&
+	git checkout -b svn remotes/origin/trunk &&
 	git checkout -b merge &&
 	echo new file > new_file &&
 	git add new_file &&
@@ -81,7 +81,7 @@ test_debug 'gitk --all & sleep 1'
 
 test_expect_success 'verify post-merge ancestry' "
 	test x\`git rev-parse --verify refs/heads/svn\` = \
-	     x\`git rev-parse --verify refs/remotes/trunk \` &&
+	     x\`git rev-parse --verify refs/remotes/origin/trunk \` &&
 	test x\`git rev-parse --verify refs/heads/svn^2\` = \
 	     x\`git rev-parse --verify refs/heads/merge\` &&
 	git cat-file commit refs/heads/svn^ | grep '^friend$'
diff --git a/t/t9116-git-svn-log.sh b/t/t9116-git-svn-log.sh
index cf4c052..45773ee 100755
--- a/t/t9116-git-svn-log.sh
+++ b/t/t9116-git-svn-log.sh
@@ -20,20 +20,20 @@ test_expect_success 'setup repository and import' '
 	) &&
 	git svn init "$svnrepo" -T trunk -b branches -t tags &&
 	git svn fetch &&
-	git reset --hard trunk &&
+	git reset --hard origin/trunk &&
 	echo bye >> README &&
 	git commit -a -m bye &&
 	git svn dcommit &&
-	git reset --hard a &&
+	git reset --hard origin/a &&
 	echo why >> FEEDME &&
 	git update-index --add FEEDME &&
 	git commit -m feedme &&
 	git svn dcommit &&
-	git reset --hard trunk &&
+	git reset --hard origin/trunk &&
 	echo aye >> README &&
 	git commit -a -m aye &&
 	git svn dcommit &&
-	git reset --hard b &&
+	git reset --hard origin/b &&
 	echo spy >> README &&
 	git commit -a -m spy &&
 	echo try >> README &&
@@ -42,26 +42,26 @@ test_expect_success 'setup repository and import' '
 	'
 
 test_expect_success 'run log' "
-	git reset --hard a &&
-	git svn log -r2 trunk | grep ^r2 &&
-	git svn log -r4 trunk | grep ^r4 &&
+	git reset --hard origin/a &&
+	git svn log -r2 origin/trunk | grep ^r2 &&
+	git svn log -r4 origin/trunk | grep ^r4 &&
 	git svn log -r3 | grep ^r3
 	"
 
 test_expect_success 'run log against a from trunk' "
-	git reset --hard trunk &&
-	git svn log -r3 a | grep ^r3
+	git reset --hard origin/trunk &&
+	git svn log -r3 origin/a | grep ^r3
 	"
 
 printf 'r1 \nr2 \nr4 \n' > expected-range-r1-r2-r4
 
 test_expect_success 'test ascending revision range' "
-	git reset --hard trunk &&
+	git reset --hard origin/trunk &&
 	git svn log -r 1:4 | grep '^r[0-9]' | cut -d'|' -f1 | test_cmp expected-range-r1-r2-r4 -
 	"
 
 test_expect_success 'test ascending revision range with --show-commit' "
-	git reset --hard trunk &&
+	git reset --hard origin/trunk &&
 	git svn log --show-commit -r 1:4 | grep '^r[0-9]' | cut -d'|' -f1 | test_cmp expected-range-r1-r2-r4 -
 	"
 
@@ -69,7 +69,7 @@ test_expect_success 'test ascending revision range with --show-commit (sha1)' "
 	git svn find-rev r1 >expected-range-r1-r2-r4-sha1 &&
 	git svn find-rev r2 >>expected-range-r1-r2-r4-sha1 &&
 	git svn find-rev r4 >>expected-range-r1-r2-r4-sha1 &&
-	git reset --hard trunk &&
+	git reset --hard origin/trunk &&
 	git svn log --show-commit -r 1:4 | grep '^r[0-9]' | cut -d'|' -f2 >out &&
 	git rev-parse \$(cat out) >actual &&
 	test_cmp expected-range-r1-r2-r4-sha1 actual
@@ -78,67 +78,67 @@ test_expect_success 'test ascending revision range with --show-commit (sha1)' "
 printf 'r4 \nr2 \nr1 \n' > expected-range-r4-r2-r1
 
 test_expect_success 'test descending revision range' "
-	git reset --hard trunk &&
+	git reset --hard origin/trunk &&
 	git svn log -r 4:1 | grep '^r[0-9]' | cut -d'|' -f1 | test_cmp expected-range-r4-r2-r1 -
 	"
 
 printf 'r1 \nr2 \n' > expected-range-r1-r2
 
 test_expect_success 'test ascending revision range with unreachable revision' "
-	git reset --hard trunk &&
+	git reset --hard origin/trunk &&
 	git svn log -r 1:3 | grep '^r[0-9]' | cut -d'|' -f1 | test_cmp expected-range-r1-r2 -
 	"
 
 printf 'r2 \nr1 \n' > expected-range-r2-r1
 
 test_expect_success 'test descending revision range with unreachable revision' "
-	git reset --hard trunk &&
+	git reset --hard origin/trunk &&
 	git svn log -r 3:1 | grep '^r[0-9]' | cut -d'|' -f1 | test_cmp expected-range-r2-r1 -
 	"
 
 printf 'r2 \n' > expected-range-r2
 
 test_expect_success 'test ascending revision range with unreachable upper boundary revision and 1 commit' "
-	git reset --hard trunk &&
+	git reset --hard origin/trunk &&
 	git svn log -r 2:3 | grep '^r[0-9]' | cut -d'|' -f1 | test_cmp expected-range-r2 -
 	"
 
 test_expect_success 'test descending revision range with unreachable upper boundary revision and 1 commit' "
-	git reset --hard trunk &&
+	git reset --hard origin/trunk &&
 	git svn log -r 3:2 | grep '^r[0-9]' | cut -d'|' -f1 | test_cmp expected-range-r2 -
 	"
 
 printf 'r4 \n' > expected-range-r4
 
 test_expect_success 'test ascending revision range with unreachable lower boundary revision and 1 commit' "
-	git reset --hard trunk &&
+	git reset --hard origin/trunk &&
 	git svn log -r 3:4 | grep '^r[0-9]' | cut -d'|' -f1 | test_cmp expected-range-r4 -
 	"
 
 test_expect_success 'test descending revision range with unreachable lower boundary revision and 1 commit' "
-	git reset --hard trunk &&
+	git reset --hard origin/trunk &&
 	git svn log -r 4:3 | grep '^r[0-9]' | cut -d'|' -f1 | test_cmp expected-range-r4 -
 	"
 
 printf -- '------------------------------------------------------------------------\n' > expected-separator
 
 test_expect_success 'test ascending revision range with unreachable boundary revisions and no commits' "
-	git reset --hard trunk &&
+	git reset --hard origin/trunk &&
 	git svn log -r 5:6 | test_cmp expected-separator -
 	"
 
 test_expect_success 'test descending revision range with unreachable boundary revisions and no commits' "
-	git reset --hard trunk &&
+	git reset --hard origin/trunk &&
 	git svn log -r 6:5 | test_cmp expected-separator -
 	"
 
 test_expect_success 'test ascending revision range with unreachable boundary revisions and 1 commit' "
-	git reset --hard trunk &&
+	git reset --hard origin/trunk &&
 	git svn log -r 3:5 | grep '^r[0-9]' | cut -d'|' -f1 | test_cmp expected-range-r4 -
 	"
 
 test_expect_success 'test descending revision range with unreachable boundary revisions and 1 commit' "
-	git reset --hard trunk &&
+	git reset --hard origin/trunk &&
 	git svn log -r 5:3 | grep '^r[0-9]' | cut -d'|' -f1 | test_cmp expected-range-r4 -
 	"
 
diff --git a/t/t9117-git-svn-init-clone.sh b/t/t9117-git-svn-init-clone.sh
index 1c8d049..bea6145 100755
--- a/t/t9117-git-svn-init-clone.sh
+++ b/t/t9117-git-svn-init-clone.sh
@@ -83,25 +83,25 @@ EOF
 	rm -f expect actual
 }
 
-test_expect_success 'init with -s/-T/-b/-t without --prefix warns' '
+test_expect_success 'init with -s/-T/-b/-t assumes --prefix=origin/' '
 	test ! -d project &&
 	git svn init -s "$svnrepo"/project project 2>warning &&
-	grep -q prefix warning &&
-	test_svn_configured_prefix "" &&
+	test_must_fail grep -q prefix warning &&
+	test_svn_configured_prefix "origin/" &&
 	rm -rf project &&
 	rm -f warning
 	'
 
-test_expect_success 'clone with -s/-T/-b/-t without --prefix warns' '
+test_expect_success 'clone with -s/-T/-b/-t assumes --prefix=origin/' '
 	test ! -d project &&
 	git svn clone -s "$svnrepo"/project 2>warning &&
-	grep -q prefix warning &&
-	test_svn_configured_prefix "" &&
+	test_must_fail grep -q prefix warning &&
+	test_svn_configured_prefix "origin/" &&
 	rm -rf project &&
 	rm -f warning
 	'
 
-test_expect_success 'init with -s/-T/-b/-t and --prefix does not warn' '
+test_expect_success 'init with -s/-T/-b/-t and --prefix="" still works' '
 	test ! -d project &&
 	git svn init -s "$svnrepo"/project project --prefix="" 2>warning &&
 	test_must_fail grep -q prefix warning &&
@@ -110,7 +110,7 @@ test_expect_success 'init with -s/-T/-b/-t and --prefix does not warn' '
 	rm -f warning
 	'
 
-test_expect_success 'clone with -s/-T/-b/-t and --prefix does not warn' '
+test_expect_success 'clone with -s/-T/-b/-t and --prefix="" still works' '
 	test ! -d project &&
 	git svn clone -s "$svnrepo"/project --prefix="" 2>warning &&
 	test_must_fail grep -q prefix warning &&
diff --git a/t/t9118-git-svn-funky-branch-names.sh b/t/t9118-git-svn-funky-branch-names.sh
index 15f93b4..ed4d136 100755
--- a/t/t9118-git-svn-funky-branch-names.sh
+++ b/t/t9118-git-svn-funky-branch-names.sh
@@ -41,20 +41,20 @@ test_expect_success 'test clone with funky branch names' '
 	git svn clone -s "$svnrepo/pr ject" project &&
 	(
 		cd project &&
-		git rev-parse "refs/remotes/fun%20plugin" &&
-		git rev-parse "refs/remotes/more%20fun%20plugin!" &&
-		git rev-parse "refs/remotes/$scary_ref" &&
-		git rev-parse "refs/remotes/%2Eleading_dot" &&
-		git rev-parse "refs/remotes/trailing_dot%2E" &&
-		git rev-parse "refs/remotes/trailing_dotlock%2Elock" &&
-		git rev-parse "refs/remotes/$non_reflog"
+		git rev-parse "refs/remotes/origin/fun%20plugin" &&
+		git rev-parse "refs/remotes/origin/more%20fun%20plugin!" &&
+		git rev-parse "refs/remotes/origin/$scary_ref" &&
+		git rev-parse "refs/remotes/origin/%2Eleading_dot" &&
+		git rev-parse "refs/remotes/origin/trailing_dot%2E" &&
+		git rev-parse "refs/remotes/origin/trailing_dotlock%2Elock" &&
+		git rev-parse "refs/remotes/origin/$non_reflog"
 	)
 	'
 
 test_expect_success 'test dcommit to funky branch' "
 	(
 		cd project &&
-		git reset --hard 'refs/remotes/more%20fun%20plugin!' &&
+		git reset --hard 'refs/remotes/origin/more%20fun%20plugin!' &&
 		echo hello >> foo &&
 		git commit -m 'hello' -- foo &&
 		git svn dcommit
@@ -64,7 +64,7 @@ test_expect_success 'test dcommit to funky branch' "
 test_expect_success 'test dcommit to scary branch' '
 	(
 		cd project &&
-		git reset --hard "refs/remotes/$scary_ref" &&
+		git reset --hard "refs/remotes/origin/$scary_ref" &&
 		echo urls are scary >> foo &&
 		git commit -m "eep" -- foo &&
 		git svn dcommit
@@ -74,7 +74,7 @@ test_expect_success 'test dcommit to scary branch' '
 test_expect_success 'test dcommit to trailing_dotlock branch' '
 	(
 		cd project &&
-		git reset --hard "refs/remotes/trailing_dotlock%2Elock" &&
+		git reset --hard "refs/remotes/origin/trailing_dotlock%2Elock" &&
 		echo who names branches like this anyway? >> foo &&
 		git commit -m "bar" -- foo &&
 		git svn dcommit
diff --git a/t/t9120-git-svn-clone-with-percent-escapes.sh b/t/t9120-git-svn-clone-with-percent-escapes.sh
index 1d92c05..1c84ce1 100755
--- a/t/t9120-git-svn-clone-with-percent-escapes.sh
+++ b/t/t9120-git-svn-clone-with-percent-escapes.sh
@@ -58,19 +58,19 @@ test_expect_success 'test clone --stdlayout with percent escapes' '
 	git svn clone --stdlayout "$svnrepo/pr%20ject" percent &&
 	(
 		cd percent &&
-		git rev-parse refs/remotes/trunk^0 &&
-		git rev-parse refs/remotes/b^0 &&
-		git rev-parse refs/remotes/tags/v1^0
+		git rev-parse refs/remotes/origin/trunk^0 &&
+		git rev-parse refs/remotes/origin/b^0 &&
+		git rev-parse refs/remotes/origin/tags/v1^0
 	)
 '
 
 test_expect_success 'test clone -s with unescaped space' '
-	git svn clone -s "$svnrepo/pr ject" space &&
+	git svn clone -s "$svnrepo/pr ject" --prefix origin/ space &&
 	(
 		cd space &&
-		git rev-parse refs/remotes/trunk^0 &&
-		git rev-parse refs/remotes/b^0 &&
-		git rev-parse refs/remotes/tags/v1^0
+		git rev-parse refs/remotes/origin/trunk^0 &&
+		git rev-parse refs/remotes/origin/b^0 &&
+		git rev-parse refs/remotes/origin/tags/v1^0
 	)
 '
 
diff --git a/t/t9125-git-svn-multi-glob-branch-names.sh b/t/t9125-git-svn-multi-glob-branch-names.sh
index 096abd1..0d53fc9 100755
--- a/t/t9125-git-svn-multi-glob-branch-names.sh
+++ b/t/t9125-git-svn-multi-glob-branch-names.sh
@@ -20,14 +20,14 @@ test_expect_success 'test clone with multi-glob in branch names' '
 	git svn clone -T trunk -b branches/*/* -t tags \
 	              "$svnrepo/project" project &&
 	(cd project &&
-		git rev-parse "refs/remotes/v14.1/beta" &&
-		git rev-parse "refs/remotes/v14.1/gold"
+		git rev-parse "refs/remotes/origin/v14.1/beta" &&
+		git rev-parse "refs/remotes/origin/v14.1/gold"
 	)
 	'
 
 test_expect_success 'test dcommit to multi-globbed branch' "
 	(cd project &&
-	git reset --hard 'refs/remotes/v14.1/gold' &&
+	git reset --hard 'refs/remotes/origin/v14.1/gold' &&
 	echo hello >> foo &&
 	git commit -m 'hello' -- foo &&
 	git svn dcommit
diff --git a/t/t9128-git-svn-cmd-branch.sh b/t/t9128-git-svn-cmd-branch.sh
index 4b034a6..4e95f79 100755
--- a/t/t9128-git-svn-cmd-branch.sh
+++ b/t/t9128-git-svn-cmd-branch.sh
@@ -29,30 +29,30 @@ test_expect_success 'initialize svnrepo' '
 test_expect_success 'import into git' '
 	git svn init --stdlayout "$svnrepo" &&
 	git svn fetch &&
-	git checkout remotes/trunk
+	git checkout remotes/origin/trunk
 '
 
 test_expect_success 'git svn branch tests' '
 	git svn branch a &&
 	base=$(git rev-parse HEAD:) &&
-	test $base = $(git rev-parse remotes/a:) &&
+	test $base = $(git rev-parse remotes/origin/a:) &&
 	git svn branch -m "created branch b blah" b &&
-	test $base = $(git rev-parse remotes/b:) &&
+	test $base = $(git rev-parse remotes/origin/b:) &&
 	test_must_fail git branch -m "no branchname" &&
 	git svn branch -n c &&
-	test_must_fail git rev-parse remotes/c &&
+	test_must_fail git rev-parse remotes/origin/c &&
 	test_must_fail git svn branch a &&
 	git svn branch -t tag1 &&
-	test $base = $(git rev-parse remotes/tags/tag1:) &&
+	test $base = $(git rev-parse remotes/origin/tags/tag1:) &&
 	git svn branch --tag tag2 &&
-	test $base = $(git rev-parse remotes/tags/tag2:) &&
+	test $base = $(git rev-parse remotes/origin/tags/tag2:) &&
 	git svn tag tag3 &&
-	test $base = $(git rev-parse remotes/tags/tag3:) &&
+	test $base = $(git rev-parse remotes/origin/tags/tag3:) &&
 	git svn tag -m "created tag4 foo" tag4 &&
-	test $base = $(git rev-parse remotes/tags/tag4:) &&
+	test $base = $(git rev-parse remotes/origin/tags/tag4:) &&
 	test_must_fail git svn tag -m "no tagname" &&
 	git svn tag -n tag5 &&
-	test_must_fail git rev-parse remotes/tags/tag5 &&
+	test_must_fail git rev-parse remotes/origin/tags/tag5 &&
 	test_must_fail git svn tag tag1
 '
 
diff --git a/t/t9135-git-svn-moved-branch-empty-file.sh b/t/t9135-git-svn-moved-branch-empty-file.sh
index 5280e5f..93db45d 100755
--- a/t/t9135-git-svn-moved-branch-empty-file.sh
+++ b/t/t9135-git-svn-moved-branch-empty-file.sh
@@ -12,7 +12,7 @@ test_expect_success 'clone using git svn' 'git svn clone -s "$svnrepo" x'
 test_expect_success 'test that b1 exists and is empty' '
 	(
 		cd x &&
-		git reset --hard branch-c &&
+		git reset --hard origin/branch-c &&
 		test -f b1 &&
 		! test -s b1
 	)
diff --git a/t/t9141-git-svn-multiple-branches.sh b/t/t9141-git-svn-multiple-branches.sh
index 3cd0671..8e7f7d6 100755
--- a/t/t9141-git-svn-multiple-branches.sh
+++ b/t/t9141-git-svn-multiple-branches.sh
@@ -66,18 +66,18 @@ test_expect_success 'clone multiple branch and tag paths' '
 		      -t tags_A/* --tags tags_B \
 		      "$svnrepo/project" git_project &&
 	( cd git_project &&
-		git rev-parse refs/remotes/first &&
-		git rev-parse refs/remotes/second &&
-		git rev-parse refs/remotes/1 &&
-		git rev-parse refs/remotes/2 &&
-		git rev-parse refs/remotes/tags/1.0 &&
-		git rev-parse refs/remotes/tags/2.0 &&
-		git rev-parse refs/remotes/tags/3.0 &&
-		git rev-parse refs/remotes/tags/4.0 &&
-		git rev-parse refs/remotes/tags/v5 &&
-		git rev-parse refs/remotes/tags/v6 &&
-		git rev-parse refs/remotes/tags/v7 &&
-		git rev-parse refs/remotes/tags/v8
+		git rev-parse refs/remotes/origin/first &&
+		git rev-parse refs/remotes/origin/second &&
+		git rev-parse refs/remotes/origin/1 &&
+		git rev-parse refs/remotes/origin/2 &&
+		git rev-parse refs/remotes/origin/tags/1.0 &&
+		git rev-parse refs/remotes/origin/tags/2.0 &&
+		git rev-parse refs/remotes/origin/tags/3.0 &&
+		git rev-parse refs/remotes/origin/tags/4.0 &&
+		git rev-parse refs/remotes/origin/tags/v5 &&
+		git rev-parse refs/remotes/origin/tags/v6 &&
+		git rev-parse refs/remotes/origin/tags/v7 &&
+		git rev-parse refs/remotes/origin/tags/v8
 	)
 '
 
@@ -85,8 +85,8 @@ test_expect_success 'Multiple branch or tag paths require -d' '
 	( cd git_project &&
 		test_must_fail git svn branch -m "No new branch" Nope &&
 		test_must_fail git svn tag -m "No new tag" Tagless &&
-		test_must_fail git rev-parse refs/remotes/Nope &&
-		test_must_fail git rev-parse refs/remotes/tags/Tagless
+		test_must_fail git rev-parse refs/remotes/origin/Nope &&
+		test_must_fail git rev-parse refs/remotes/origin/tags/Tagless
 	) &&
 	( cd svn_project &&
 		svn_cmd up &&
diff --git a/t/t9145-git-svn-master-branch.sh b/t/t9145-git-svn-master-branch.sh
index 16852d2..6559137 100755
--- a/t/t9145-git-svn-master-branch.sh
+++ b/t/t9145-git-svn-master-branch.sh
@@ -17,7 +17,7 @@ test_expect_success 'git svn clone --stdlayout sets up trunk as master' '
 	git svn clone -s "$svnrepo" g &&
 	(
 		cd g &&
-		test x`git rev-parse --verify refs/remotes/trunk^0` = \
+		test x`git rev-parse --verify refs/remotes/origin/trunk^0` = \
 		     x`git rev-parse --verify refs/heads/master^0`
 	)
 '
diff --git a/t/t9155-git-svn-fetch-deleted-tag.sh b/t/t9155-git-svn-fetch-deleted-tag.sh
index a486a98..184336f 100755
--- a/t/t9155-git-svn-fetch-deleted-tag.sh
+++ b/t/t9155-git-svn-fetch-deleted-tag.sh
@@ -35,8 +35,8 @@ test_expect_success 'fetch deleted tags from same revision with checksum error'
 	cd git_project &&
 	git svn fetch &&
 
-	git diff --exit-code mybranch:trunk/subdir/file tags/mytag:file &&
-	git diff --exit-code master:subdir/file tags/mytag^:file
+	git diff --exit-code origin/mybranch:trunk/subdir/file origin/tags/mytag:file &&
+	git diff --exit-code master:subdir/file origin/tags/mytag^:file
 '
 
 test_done
diff --git a/t/t9156-git-svn-fetch-deleted-tag-2.sh b/t/t9156-git-svn-fetch-deleted-tag-2.sh
index 5ce7e2f..7a6e33b 100755
--- a/t/t9156-git-svn-fetch-deleted-tag-2.sh
+++ b/t/t9156-git-svn-fetch-deleted-tag-2.sh
@@ -36,9 +36,9 @@ test_expect_success 'fetch deleted tags from same revision with no checksum erro
 	cd git_project &&
 	git svn fetch &&
 
-	git diff --exit-code master:subdir3/file tags/mytag:file &&
-	git diff --exit-code master:subdir2/file tags/mytag^:file &&
-	git diff --exit-code master:subdir1/file tags/mytag^^:file
+	git diff --exit-code master:subdir3/file origin/tags/mytag:file &&
+	git diff --exit-code master:subdir2/file origin/tags/mytag^:file &&
+	git diff --exit-code master:subdir1/file origin/tags/mytag^^:file
 '
 
 test_done
diff --git a/t/t9161-git-svn-mergeinfo-push.sh b/t/t9161-git-svn-mergeinfo-push.sh
index 1eab701..6cb0909 100755
--- a/t/t9161-git-svn-mergeinfo-push.sh
+++ b/t/t9161-git-svn-mergeinfo-push.sh
@@ -18,8 +18,8 @@ test_expect_success 'load svn dump' "
 
 test_expect_success 'propagate merge information' '
 	git config svn.pushmergeinfo yes &&
-	git checkout svnb1 &&
-	git merge --no-ff svnb2 &&
+	git checkout origin/svnb1 &&
+	git merge --no-ff origin/svnb2 &&
 	git svn dcommit
 	'
 
@@ -29,7 +29,7 @@ test_expect_success 'check svn:mergeinfo' '
 	'
 
 test_expect_success 'merge another branch' '
-	git merge --no-ff svnb3 &&
+	git merge --no-ff origin/svnb3 &&
 	git svn dcommit
 	'
 
@@ -40,7 +40,7 @@ test_expect_success 'check primary parent mergeinfo respected' '
 	'
 
 test_expect_success 'merge existing merge' '
-	git merge --no-ff svnb4 &&
+	git merge --no-ff origin/svnb4 &&
 	git svn dcommit
 	'
 
@@ -53,7 +53,7 @@ test_expect_success "check both parents' mergeinfo respected" '
 	'
 
 test_expect_success 'make further commits to branch' '
-	git checkout svnb2 &&
+	git checkout origin/svnb2 &&
 	touch newb2file &&
 	git add newb2file &&
 	git commit -m "later b2 commit" &&
@@ -64,8 +64,8 @@ test_expect_success 'make further commits to branch' '
 	'
 
 test_expect_success 'second forward merge' '
-	git checkout svnb1 &&
-	git merge --no-ff svnb2 &&
+	git checkout origin/svnb1 &&
+	git merge --no-ff origin/svnb2 &&
 	git svn dcommit
 	'
 
@@ -78,8 +78,8 @@ test_expect_success 'check new mergeinfo added' '
 	'
 
 test_expect_success 'reintegration merge' '
-	git checkout svnb4 &&
-	git merge --no-ff svnb1 &&
+	git checkout origin/svnb4 &&
+	git merge --no-ff origin/svnb1 &&
 	git svn dcommit
 	'
 
@@ -92,11 +92,11 @@ test_expect_success 'check reintegration mergeinfo' '
 	'
 
 test_expect_success 'dcommit a merge at the top of a stack' '
-	git checkout svnb1 &&
+	git checkout origin/svnb1 &&
 	touch anotherfile &&
 	git add anotherfile &&
 	git commit -m "a commit" &&
-	git merge svnb4 &&
+	git merge origin/svnb4 &&
 	git svn dcommit
 	'
 
diff --git a/t/t9163-git-svn-reset-clears-caches.sh b/t/t9163-git-svn-reset-clears-caches.sh
index cd4c662..d6245ce 100755
--- a/t/t9163-git-svn-reset-clears-caches.sh
+++ b/t/t9163-git-svn-reset-clears-caches.sh
@@ -70,9 +70,9 @@ test_expect_success 'rebase looses SVN merge (m)' '
 #
 test_expect_success 'reset and fetch gets the SVN merge (m) correctly' '
 	git svn reset -r 3 &&
-	git reset --hard trunk &&
+	git reset --hard origin/trunk &&
 	git svn fetch &&
-	test 2 = $(git cat-file -p trunk|grep parent|wc -l)
+	test 2 = $(git cat-file -p origin/trunk|grep parent|wc -l)
 '
 
 test_done
diff --git a/t/t9165-git-svn-fetch-merge-branch-of-branch.sh b/t/t9165-git-svn-fetch-merge-branch-of-branch.sh
index 13ae7e3..fa3ef3b 100755
--- a/t/t9165-git-svn-fetch-merge-branch-of-branch.sh
+++ b/t/t9165-git-svn-fetch-merge-branch-of-branch.sh
@@ -53,7 +53,7 @@ test_expect_success 'clone svn repo' '
 '
 
 test_expect_success 'verify merge commit' 'x=$(git rev-parse HEAD^2) &&
-	y=$(git rev-parse branch2) &&
+	y=$(git rev-parse origin/branch2) &&
 	test "x$x" = "x$y"
 '
 
diff --git a/t/t9166-git-svn-fetch-merge-branch-of-branch2.sh b/t/t9166-git-svn-fetch-merge-branch-of-branch2.sh
index af0ec0e..52f2e46 100755
--- a/t/t9166-git-svn-fetch-merge-branch-of-branch2.sh
+++ b/t/t9166-git-svn-fetch-merge-branch-of-branch2.sh
@@ -46,7 +46,7 @@ test_expect_success 'clone svn repo' '
 '
 
 test_expect_success 'verify merge commit' 'x=$(git rev-parse HEAD^2) &&
-	y=$(git rev-parse branch2) &&
+	y=$(git rev-parse origin/branch2) &&
 	test "x$x" = "x$y"
 '
 
diff --git a/t/t9167-git-svn-cmd-branch-subproject.sh b/t/t9167-git-svn-cmd-branch-subproject.sh
index 53def87..ba35fc0 100755
--- a/t/t9167-git-svn-cmd-branch-subproject.sh
+++ b/t/t9167-git-svn-cmd-branch-subproject.sh
@@ -31,7 +31,7 @@ test_expect_success 'import into git' '
 	git svn init --trunk=trunk/project --branches=branches/*/project \
 		--tags=tags/*/project "$svnrepo" &&
 	git svn fetch &&
-	git checkout remotes/trunk
+	git checkout remotes/origin/trunk
 '
 
 test_expect_success 'git svn branch tests' '
-- 
1.8.4.653.g2df02b3
