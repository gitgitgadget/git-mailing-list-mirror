From: Robert Luberda <robert@debian.org>
Subject: [PATCH/RFC] git svn: handle errors and concurrent commits in dcommit
Date: Wed,  1 Aug 2012 23:26:37 +0200
Message-ID: <1343856397-6536-1-git-send-email-robert@debian.org>
Cc: Robert Luberda <robert@debian.org>
To: Eric Wong <normalperson@yhbt.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 01 23:42:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SwggX-0003sO-Pc
	for gcvg-git-2@plane.gmane.org; Wed, 01 Aug 2012 23:42:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755954Ab2HAVmX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Aug 2012 17:42:23 -0400
Received: from master.debian.org ([70.103.162.29]:51571 "EHLO
	master.debian.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755950Ab2HAVmW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Aug 2012 17:42:22 -0400
Received: from localhost ([127.0.0.1] helo=vox.robbo.home)
	by master.debian.org with esmtp (Exim 4.72)
	(envelope-from <robert@debian.org>)
	id 1Swgaf-00089J-KX; Wed, 01 Aug 2012 21:36:25 +0000
Received: by vox.robbo.home (Postfix, from userid 1000)
	id 7124710B259; Wed,  1 Aug 2012 23:26:43 +0200 (CEST)
X-Mailer: git-send-email 1.7.10.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202728>

dcommit didn't handle errors returned by SVN and coped very
poorly with concurrent commits that appear in SVN repository
while dcommit was running. In both cases it left git repository
in inconsistent state: index (which was reset with `git reset
--mixed' after a successful commit to SVN) no longer matched the
checkouted tree, when the following commit failed or needed to be
rebased. See http://bugs.debian.org/676904 for examples.

This patch fixes the issues by:
- introducing error handler for dcommit. The handler will try
  to rebase or reset working tree before returning error to the
  end user. dcommit_rebase function was extracted out of cmd_dcommit
  to ensure consistency between cmd_dcommit and the error handler.
- calling `git reset --mixed' only once after all patches are
  successfully committed to SVN. This ensures index is not touched
  for most of the time of dcommit run.
---
 git-svn.perl                         |   70 ++++++++++----
 t/t9164-git-svn-dcommit-concrrent.sh |  173 ++++++++++++++++++++++++++++++++++
 2 files changed, 224 insertions(+), 19 deletions(-)
 create mode 100755 t/t9164-git-svn-dcommit-concrrent.sh

diff --git a/git-svn.perl b/git-svn.perl
index 5711c57..ca3383f 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -777,6 +777,44 @@ sub populate_merge_info {
 	return undef;
 }
 
+sub dcommit_rebase {
+	my ($is_last, $current, $fetched_ref, $svn_error) = @_;
+	my @diff;
+
+	if ($svn_error)
+	{
+		print STDERR "\nERROR from SVN: ", $svn_error->expanded_message, "\n";
+	}
+	unless ($_no_rebase)
+	{
+		# we always want to rebase against the current HEAD,
+		# not any head that was passed to us
+		@diff = command('diff-tree', $current,
+	                   $fetched_ref, '--');
+		my @finish;
+		if (@diff) {
+			@finish = rebase_cmd();
+			print STDERR "W: $current and ", $fetched_ref,
+			             " differ, using @finish:\n",
+			             join("\n", @diff), "\n";
+		} elsif ($is_last) {
+			print "No changes between ", $current, " and ",
+			      $fetched_ref,
+			      "\nResetting to the latest ",
+			      $fetched_ref, "\n";
+			@finish = qw/reset --mixed/;
+		}
+		command_noisy(@finish, $fetched_ref) if @finish;
+	}
+	if ($svn_error)
+	{
+		die "ERROR: Not all changes have been committed into SVN"
+			.($_no_rebase ? ". " : ", however the committed ones (if any) seem to be successfully integrated into the working tree. ")
+			."Please see the above messages for details.\n";
+	}
+	return @diff;
+}
+
 sub cmd_dcommit {
 	my $head = shift;
 	command_noisy(qw/update-index --refresh/);
@@ -904,6 +942,7 @@ sub cmd_dcommit {
 	}
 
 	my $rewritten_parent;
+	my $current_head =  command_oneline(qw/rev-parse HEAD/);
 	Git::SVN::remove_username($expect_url);
 	if (defined($_merge_info)) {
 		$_merge_info =~ tr{ }{\n};
@@ -943,6 +982,13 @@ sub cmd_dcommit {
 			                },
 					mergeinfo => $_merge_info,
 			                svn_path => '');
+
+			my $err_handler = $SVN::Error::handler;
+			$SVN::Error::handler = sub {
+				my $err = shift;
+				dcommit_rebase(1, $current_head, $gs->refname, $err);
+			};
+
 			if (!Git::SVN::Editor->new(\%ed_opts)->apply_diff) {
 				print "No changes\n$d~1 == $d\n";
 			} elsif ($parents->{$d} && @{$parents->{$d}}) {
@@ -950,31 +996,16 @@ sub cmd_dcommit {
 				                               $parents->{$d};
 			}
 			$_fetch_all ? $gs->fetch_all : $gs->fetch;
+			$SVN::Error::handler = $err_handler;
 			$last_rev = $cmt_rev;
 			next if $_no_rebase;
 
-			# we always want to rebase against the current HEAD,
-			# not any head that was passed to us
-			my @diff = command('diff-tree', $d,
-			                   $gs->refname, '--');
-			my @finish;
-			if (@diff) {
-				@finish = rebase_cmd();
-				print STDERR "W: $d and ", $gs->refname,
-				             " differ, using @finish:\n",
-				             join("\n", @diff), "\n";
-			} else {
-				print "No changes between current HEAD and ",
-				      $gs->refname,
-				      "\nResetting to the latest ",
-				      $gs->refname, "\n";
-				@finish = qw/reset --mixed/;
-			}
-			command_noisy(@finish, $gs->refname);
+			my @diff = dcommit_rebase(@$linear_refs == 0, $d, $gs->refname, undef);
 
-			$rewritten_parent = command_oneline(qw/rev-parse HEAD/);
+			$rewritten_parent = command_oneline(qw/rev-parse/, $gs->refname);
 
 			if (@diff) {
+				$current_head = command_oneline(qw/rev-parse HEAD/);
 				@refs = ();
 				my ($url_, $rev_, $uuid_, $gs_) =
 				              working_head_info('HEAD', \@refs);
@@ -1019,6 +1050,7 @@ sub cmd_dcommit {
 				}
 				$parents = \%p;
 				$linear_refs = \@l;
+				undef $last_rev;
 			}
 		}
 	}
diff --git a/t/t9164-git-svn-dcommit-concrrent.sh b/t/t9164-git-svn-dcommit-concrrent.sh
new file mode 100755
index 0000000..7916a63
--- /dev/null
+++ b/t/t9164-git-svn-dcommit-concrrent.sh
@@ -0,0 +1,173 @@
+#!/bin/sh
+#
+# Copyright (c) 2012 Robert Luberda
+#
+
+test_description='concurrent git svn dcommit'
+. ./lib-git-svn.sh
+
+
+
+test_expect_success 'setup svn repository' '
+	svn_cmd checkout "$svnrepo" work.svn &&
+	(
+		cd work.svn &&
+		echo >file && echo > auto_updated_file
+		svn_cmd add file auto_updated_file &&
+		svn_cmd commit -m "initial commit"
+       ) &&
+	svn_cmd checkout "$svnrepo" work-auto-commits.svn
+'
+N=0
+next_N()
+{
+	N=`expr $N + 1`
+}
+
+# Setup SVN repository hooks to emulate SVN failures or concurrent commits
+# The function adds either
+# either pre-commit  hook, which causes SVN commit given in second argument to fail
+# or     post-commit hook, which creates a new commit (a new line added to
+#                    auto_updated_file) after given SVN commit
+# The second argument contains a number (not SVN revision) of commit the the hook
+# should be applied for.
+setup_hook()
+{
+	hook_type="$1"  # pre-commit to fail commit or post-commit to make concurrent commit
+	skip_revs="$2"  # skip number of revisions before applying the hook
+			# the number is decremented by one each time hook is called until
+			# it gets 0, in which case the real part of hook is executed
+	[ "$hook_type" = "pre-commit" ] || [ "$hook_type" = "post-commit" ] ||
+		{ echo "ERROR: invalid argument ($hook_type) passed to setup_hook" >&2 ; return 1; }
+	echo "cnt=$skip_revs" > "$hook_type-counter"
+	rm -f "$rawsvnrepo/hooks/"*-commit # drop previous hooks
+	hook="$rawsvnrepo/hooks/$hook_type"
+	cat > "$hook" <<- 'EOF1'
+		#!/bin/sh
+		set -e
+		cd "$1/.."  # "$1" is repository location
+		exec >> svn-hook.log 2>&1
+		hook="`basename "$0"`"
+		echo "*** Executing $hook $@"
+		set -x
+		. ./$hook-counter
+		cnt=`expr "$cnt" - 1` || [ $? = 1 ] # expr returns error code 1 if expression is 0
+		echo "cnt=$cnt" > ./$hook-counter
+		[ "$cnt" = "0" ] || exit 0
+EOF1
+	if [ "$hook_type" = "pre-commit" ]; then
+		echo "echo 'commit disallowed' >&2; exit 1" >> "$hook"
+	else
+		echo "PATH=\"$PATH\"; export PATH" >> $hook
+		echo "svnconf=\"$svnconf\"" >> $hook
+		cat >> "$hook" <<- 'EOF2'
+			cd work-auto-commits.svn
+			svn up --config-dir "$svnconf"
+			echo "$$" >> auto_updated_file
+			svn commit --config-dir "$svnconf" -m "auto-committing concurrent change from post-commit hook"
+			exit 0
+EOF2
+	fi
+	chmod 755 "$hook"
+}
+
+check_contents()
+{
+	gitdir="$1"
+	(cd ../work.svn && svn_cmd up) &&
+	test_cmp file ../work.svn/file &&
+	test_cmp auto_updated_file ../work.svn/auto_updated_file
+}
+
+test_expect_success 'check if svn post-commit hook creates a concurrent commit' '
+	setup_hook post-commit 1 &&
+	(cd work.svn &&
+		cp auto_updated_file auto_updated_file_saved
+		echo 1 >> file &&
+		svn_cmd commit -m "changing file" &&
+		svn_cmd up &&
+		test_must_fail test_cmp auto_updated_file auto_updated_file_saved)
+'
+
+test_expect_success 'check if svn pre-commit hook fails' '
+	setup_hook pre-commit 2 &&
+	(cd work.svn &&
+		echo 2 >> file &&
+		svn_cmd commit -m "changing file once again" &&
+		echo 3 >> file &&
+		test_must_fail svn_cmd commit -m "this commit should fail" &&
+		svn_cmd revert file)
+'
+
+test_expect_success 'git svn dcommit error handling' '
+	setup_hook pre-commit 2 &&
+	next_N && git svn clone "$svnrepo" work$N.git &&
+	( cd work$N.git &&
+		echo 1 >> file && git commit -am "commit change $N.1" &&
+		echo 2 >> file && git commit -am "commit change $N.2" &&
+		echo 3 >> file && git commit -am "commit change $N.3" &&
+		test_must_fail git svn dcommit && # should fail to dcommit 2nd and 3rd changes
+		git update-index --refresh && # but still should leave repository in reasonable state
+		git show HEAD~2   | grep -q git-svn-id &&
+		! git show HEAD~1 | grep -q git-svn-id &&
+		! git show HEAD   | grep -q git-svn-id )
+'
+
+test_expect_success 'git svn dcommit concurrent change in non-changed file' '
+	setup_hook post-commit 2 &&
+	next_N && git svn clone "$svnrepo" work$N.git &&
+	( cd work$N.git &&
+		echo 1 >> file && git commit -am "commit change $N.1" &&
+		echo 2 >> file && git commit -am "commit change $N.2" &&
+		echo 3 >> file && git commit -am "commit change $N.3" &&
+		git svn dcommit # should rebase
+		git update-index --refresh && # and leave repository in reasonable state
+		check_contents &&
+		git show HEAD~3 | grep -q git-svn-id &&
+		git show HEAD~2 | grep -q git-svn-id &&
+		git show HEAD~1 | grep -q auto-committing &&
+		git show HEAD   | grep -q git-svn-id )
+'
+
+test_expect_success 'git svn dcommit concurrent non-conflicting change in changed file' '
+	setup_hook post-commit 2 &&
+	next_N && git svn clone "$svnrepo" work$N.git &&
+	( cd work$N.git &&
+		cat file >> auto_updated_file && git commit -am "commit change $N.1" &&
+		sed -i 1d auto_updated_file && git commit -am "commit change $N.2" &&
+		sed -i 1d auto_updated_file && git commit -am "commit change $N.3" &&
+		git svn dcommit && # should rebase
+		git update-index --refresh && # and leave repository in reasonable state
+		check_contents &&
+		git show HEAD~3 | grep -q git-svn-id &&
+		git show HEAD~2 | grep -q git-svn-id &&
+		git show HEAD~1 | grep -q auto-committing &&
+		git show HEAD   | grep -q git-svn-id )
+'
+
+test_expect_success 'git svn dcommit --no-rebase on concurrent non-conflicting change in changed file' '
+	setup_hook post-commit 2 &&
+	next_N && git svn clone "$svnrepo" work$N.git &&
+	( cd work$N.git &&
+		cat file >> auto_updated_file && git commit -am "commit change $N.1" &&
+		sed -i 1d auto_updated_file && git commit -am "commit change $N.2" &&
+		sed -i 1d auto_updated_file && git commit -am "commit change $N.3" &&
+		test_must_fail git svn dcommit --no-rebase && # should fail as rebase is needed
+		git update-index --refresh && # but still should leave repository in reasonable state
+		! git show HEAD~2 | grep -q git-svn-id &&
+		! git show HEAD~1 | grep -q git-svn-id &&
+		! git show HEAD   | grep -q git-svn-id)
+'
+
+test_expect_success 'git svn dcommit fails on concurrent conflicting change' '
+	setup_hook post-commit 1 &&
+	next_N && git svn clone "$svnrepo" work$N.git &&
+	( cd work$N.git &&
+		echo a >> file && git commit -am "commit change $N.1" &&
+		echo b >> auto_updated_file && git commit -am "commit change $N.2" &&
+		echo c >> auto_updated_file && git commit -am "commit change $N.3" &&
+		test_must_fail git svn dcommit && # rebase should fail
+		test_must_fail git update-index --refresh )
+'
+
+test_done
-- 
1.7.10.4
