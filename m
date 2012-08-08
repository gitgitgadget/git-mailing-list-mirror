From: Robert Luberda <robert@debian.org>
Subject: [PATCH/RFC] git svn: handle errors and concurrent commits in dcommit
Date: Wed,  8 Aug 2012 07:35:00 +0200
Message-ID: <1344404100-9383-1-git-send-email-robert@debian.org>
References: <5021F9D4.1010700@debian.org>
Cc: Robert Luberda <robert@debian.org>
To: Eric Wong <normalperson@yhbt.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 08 07:38:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Syyyd-0005ep-CC
	for gcvg-git-2@plane.gmane.org; Wed, 08 Aug 2012 07:38:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756161Ab2HHFid (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Aug 2012 01:38:33 -0400
Received: from master.debian.org ([70.103.162.29]:48285 "EHLO
	master.debian.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751848Ab2HHFib (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Aug 2012 01:38:31 -0400
Received: from localhost ([127.0.0.1] helo=vox.robbo.home)
	by master.debian.org with esmtp (Exim 4.72)
	(envelope-from <robert@debian.org>)
	id 1SyyyO-0004zk-Qz; Wed, 08 Aug 2012 05:38:25 +0000
Received: by vox.robbo.home (Postfix, from userid 1000)
	id B687CE47EF; Wed,  8 Aug 2012 07:35:26 +0200 (CEST)
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <5021F9D4.1010700@debian.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203063>

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
 git-svn.perl                         |   74 +++++++++---
 t/t9164-git-svn-dcommit-concrrent.sh |  216 ++++++++++++++++++++++++++++++++++
 2 files changed, 271 insertions(+), 19 deletions(-)
 create mode 100755 t/t9164-git-svn-dcommit-concrrent.sh

diff --git a/git-svn.perl b/git-svn.perl
index 5711c57..828b8f0 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -777,6 +777,44 @@ sub populate_merge_info {
 	return undef;
 }
 
+sub dcommit_rebase {
+	my ($is_last, $current, $fetched_ref, $svn_error) = @_;
+	my @diff;
+
+	if ($svn_error) {
+		print STDERR "\nERROR from SVN:\n",
+				$svn_error->expanded_message, "\n";
+	}
+	unless ($_no_rebase) {
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
+	if ($svn_error) {
+		die "ERROR: Not all changes have been committed into SVN"
+			.($_no_rebase ? ".\n" : ", however the committed\n"
+			."ones (if any) seem to be successfully integrated "
+			."into the working tree.\n")
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
+	my $current_head = command_oneline(qw/rev-parse HEAD/);
 	Git::SVN::remove_username($expect_url);
 	if (defined($_merge_info)) {
 		$_merge_info =~ tr{ }{\n};
@@ -943,6 +982,14 @@ sub cmd_dcommit {
 			                },
 					mergeinfo => $_merge_info,
 			                svn_path => '');
+
+			my $err_handler = $SVN::Error::handler;
+			$SVN::Error::handler = sub {
+				my $err = shift;
+				dcommit_rebase(1, $current_head, $gs->refname,
+					$err);
+			};
+
 			if (!Git::SVN::Editor->new(\%ed_opts)->apply_diff) {
 				print "No changes\n$d~1 == $d\n";
 			} elsif ($parents->{$d} && @{$parents->{$d}}) {
@@ -950,31 +997,19 @@ sub cmd_dcommit {
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
+			my @diff = dcommit_rebase(@$linear_refs == 0, $d,
+						$gs->refname, undef);
 
-			$rewritten_parent = command_oneline(qw/rev-parse HEAD/);
+			$rewritten_parent = command_oneline(qw/rev-parse/,
+							$gs->refname);
 
 			if (@diff) {
+				$current_head = command_oneline(qw/rev-parse
+								HEAD/);
 				@refs = ();
 				my ($url_, $rev_, $uuid_, $gs_) =
 				              working_head_info('HEAD', \@refs);
@@ -1019,6 +1054,7 @@ sub cmd_dcommit {
 				}
 				$parents = \%p;
 				$linear_refs = \@l;
+				undef $last_rev;
 			}
 		}
 	}
diff --git a/t/t9164-git-svn-dcommit-concrrent.sh b/t/t9164-git-svn-dcommit-concrrent.sh
new file mode 100755
index 0000000..aac2dda
--- /dev/null
+++ b/t/t9164-git-svn-dcommit-concrrent.sh
@@ -0,0 +1,216 @@
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
+	) &&
+	svn_cmd checkout "$svnrepo" work-auto-commits.svn
+'
+N=0
+next_N()
+{
+	N=$(( $N + 1 ))
+}
+
+# Setup SVN repository hooks to emulate SVN failures or concurrent commits
+# The function adds
+# either pre-commit  hook, which causes SVN commit given in second argument
+#                    to fail
+# or     post-commit hook, which creates a new commit (a new line added to
+#                    auto_updated_file) after given SVN commit
+# The first argument contains a type of the hook
+# The second argument contains a number (not SVN revision) of commit
+# the hook should be applied for (each time the hook is run, the given
+# number is decreased by one until it gets 0, in which case the hook
+# will execute its real action)
+setup_hook()
+{
+	hook_type="$1"  # "pre-commit" or "post-commit"
+	skip_revs="$2"
+	[ "$hook_type" = "pre-commit" ] ||
+		[ "$hook_type" = "post-commit" ] ||
+		{ echo "ERROR: invalid argument ($hook_type)" \
+			"passed to setup_hook" >&2 ; return 1; }
+	echo "cnt=$skip_revs" > "$hook_type-counter"
+	rm -f "$rawsvnrepo/hooks/"*-commit # drop previous hooks
+	hook="$rawsvnrepo/hooks/$hook_type"
+	cat > "$hook" <<- 'EOF1'
+		#!/bin/sh
+		set -e
+		cd "$1/.."  # "$1" is repository location
+		exec >> svn-hook.log 2>&1
+		hook="$(basename "$0")"
+		echo "*** Executing $hook $@"
+		set -x
+		. ./$hook-counter
+		cnt="$(($cnt - 1))"
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
+			svn commit --config-dir "$svnconf" \
+				-m "auto-committing concurrent change"
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
+test_expect_success 'check if post-commit hook creates a concurrent commit' '
+	setup_hook post-commit 1 &&
+	(
+		cd work.svn &&
+		cp auto_updated_file au_file_saved &&
+		echo 1 >> file &&
+		svn_cmd commit -m "changing file" &&
+		svn_cmd up &&
+		test_must_fail test_cmp auto_updated_file au_file_saved
+	)
+'
+
+test_expect_success 'check if pre-commit hook fails' '
+	setup_hook pre-commit 2 &&
+	(
+		cd work.svn &&
+		echo 2 >> file &&
+		svn_cmd commit -m "changing file once again" &&
+		echo 3 >> file &&
+		test_must_fail svn_cmd commit -m "this commit should fail" &&
+		svn_cmd revert file
+	)
+'
+
+test_expect_success 'dcommit error handling' '
+	setup_hook pre-commit 2 &&
+	next_N && git svn clone "$svnrepo" work$N.git &&
+	(
+		cd work$N.git &&
+		echo 1 >> file && git commit -am "commit change $N.1" &&
+		echo 2 >> file && git commit -am "commit change $N.2" &&
+		echo 3 >> file && git commit -am "commit change $N.3" &&
+		# should fail to dcommit 2nd and 3rd change
+		# but still should leave the repository in reasonable state
+		test_must_fail git svn dcommit &&
+		git update-index --refresh &&
+		git show HEAD~2   | grep -q git-svn-id &&
+		! git show HEAD~1 | grep -q git-svn-id &&
+		! git show HEAD   | grep -q git-svn-id
+	)
+'
+
+test_expect_success 'dcommit concurrent change in non-changed file' '
+	setup_hook post-commit 2 &&
+	next_N && git svn clone "$svnrepo" work$N.git &&
+	(
+		cd work$N.git &&
+		echo 1 >> file && git commit -am "commit change $N.1" &&
+		echo 2 >> file && git commit -am "commit change $N.2" &&
+		echo 3 >> file && git commit -am "commit change $N.3" &&
+		# should rebase and leave the repository in reasonable state
+		git svn dcommit &&
+		git update-index --refresh &&
+		check_contents &&
+		git show HEAD~3 | grep -q git-svn-id &&
+		git show HEAD~2 | grep -q git-svn-id &&
+		git show HEAD~1 | grep -q auto-committing &&
+		git show HEAD   | grep -q git-svn-id
+	)
+'
+
+# An utility function used in the following test
+delete_first_line()
+{
+	file="$1" &&
+	sed 1d < "$file" > "${file}.tmp" &&
+	rm "$file" &&
+	mv "${file}.tmp" "$file"
+}
+
+test_expect_success 'dcommit concurrent non-conflicting change' '
+	setup_hook post-commit 2 &&
+	next_N && git svn clone "$svnrepo" work$N.git &&
+	(
+		cd work$N.git &&
+		cat file >> auto_updated_file &&
+			git commit -am "commit change $N.1" &&
+		delete_first_line auto_updated_file &&
+			git commit -am "commit change $N.2" &&
+		delete_first_line auto_updated_file &&
+			git commit -am "commit change $N.3" &&
+		# should rebase and leave the repository in reasonable state
+		git svn dcommit &&
+		git update-index --refresh &&
+		check_contents &&
+		git show HEAD~3 | grep -q git-svn-id &&
+		git show HEAD~2 | grep -q git-svn-id &&
+		git show HEAD~1 | grep -q auto-committing &&
+		git show HEAD   | grep -q git-svn-id
+	)
+'
+
+test_expect_success 'dcommit --no-rebase concurrent non-conflicting change' '
+	setup_hook post-commit 2 &&
+	next_N && git svn clone "$svnrepo" work$N.git &&
+	(
+		cd work$N.git &&
+		cat file >> auto_updated_file &&
+			git commit -am "commit change $N.1" &&
+		delete_first_line auto_updated_file &&
+			git commit -am "commit change $N.2" &&
+		delete_first_line auto_updated_file &&
+			git commit -am "commit change $N.3" &&
+		# should fail as rebase is needed
+		test_must_fail git svn dcommit --no-rebase &&
+		# but should leave HEAD unchanged
+		git update-index --refresh &&
+		! git show HEAD~2 | grep -q git-svn-id &&
+		! git show HEAD~1 | grep -q git-svn-id &&
+		! git show HEAD   | grep -q git-svn-id
+	)
+'
+
+test_expect_success 'dcommit fails on concurrent conflicting change' '
+	setup_hook post-commit 1 &&
+	next_N && git svn clone "$svnrepo" work$N.git &&
+	(
+		cd work$N.git &&
+		echo a >> file &&
+			git commit -am "commit change $N.1" &&
+		echo b >> auto_updated_file &&
+			git commit -am "commit change $N.2" &&
+		echo c >> auto_updated_file &&
+			git commit -am "commit change $N.3" &&
+		test_must_fail git svn dcommit && # rebase should fail
+		test_must_fail git update-index --refresh
+	)
+'
+
+test_done
-- 
1.7.10.4
