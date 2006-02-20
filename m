From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH 7/9] git-svn: fix several corner-case and rare bugs with 'commit'
Date: Mon, 20 Feb 2006 10:57:28 -0800
Message-ID: <11404618483587-git-send-email-normalperson@yhbt.net>
References: <11404618483094-git-send-email-normalperson@yhbt.net>
Reply-To: Eric Wong <normalperson@yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: junkio@cox.net, Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Mon Feb 20 19:57:58 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FBGEO-0001UO-PG
	for gcvg-git@gmane.org; Mon, 20 Feb 2006 19:57:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932632AbWBTS5j (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 20 Feb 2006 13:57:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932628AbWBTS5j
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Feb 2006 13:57:39 -0500
Received: from hand.yhbt.net ([66.150.188.102]:59579 "EHLO hand.yhbt.net")
	by vger.kernel.org with ESMTP id S932632AbWBTS5a (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 20 Feb 2006 13:57:30 -0500
Received: from untitled (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id EF9942DC03A;
	Mon, 20 Feb 2006 10:57:28 -0800 (PST)
In-Reply-To: <11404618483094-git-send-email-normalperson@yhbt.net>
X-Mailer: git-send-email
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16491>

None of these were really show-stoppers (or even triggered)
on most of the trees I've tracked.

* Node change prevention for identically named nodes.  This is
  a limitation of SVN, but we find the error and exit before
  it's passed to SVN so we don't dirty our working tree when our
  commit fails.  git-svn will exit with an error code 1 if any
  of the following conditions are found:

  1.  a directory is removed and a file of the same name of the
      removed directory is created
  1a. a file has its parent directory removed and the file is
      takes the name of the removed parent directory::
          baz/zzz    =>  baz
  2.  a file is removed and a directory of the same name of the
      removed file is created.
  2a. a file is moved into a deeper directory that shares the
      previous name of the file::
          dir/$file  =>  dir/file/$file

  Since SVN cannot handle these cases, the user will have to
  manually split the commit into several parts.

* --rmdir now handles nested/deep removals. If dir/a/b/c/d/e/file
  is removed, and everything else is in the dir/ hierarchy is
  otherwise empty, then dir/ will be deleted when file is deleted
  from svn and --rmdir specified.

* Always assert that we have written the tree we want to write
  on commits.  This helped me find several bugs in the symlink
  handling code (which as been fixed).

* Several symlink handling fixes.  We now refuse to set
  permissions on symlinks.  We also always unlink a file
  if we're going to overwrite it.

* Apply changes in a pre-determined order, so we always have
  rename from locations handy before we delete them.

Signed-off-by: Eric Wong <normalperson@yhbt.net>

---

 contrib/git-svn/git-svn |  260 ++++++++++++++++++++++++++++++++++++-----------
 1 files changed, 200 insertions(+), 60 deletions(-)

cc9e5f27fee073de35fd6f50ec15ea59dda8b71b
diff --git a/contrib/git-svn/git-svn b/contrib/git-svn/git-svn
index 25c248d..3a59454 100755
--- a/contrib/git-svn/git-svn
+++ b/contrib/git-svn/git-svn
@@ -238,7 +238,11 @@ sub commit {
 	my $svn_current_rev =  svn_info('.')->{'Last Changed Rev'};
 	foreach my $c (@revs) {
 		print "Committing $c\n";
-		svn_checkout_tree($svn_current_rev, $c);
+		my $mods = svn_checkout_tree($svn_current_rev, $c);
+		if (scalar @$mods == 0) {
+			print "Skipping, no changes detected\n";
+			next;
+		}
 		$svn_current_rev = svn_commit_tree($svn_current_rev, $c);
 	}
 	print "Done committing ",scalar @revs," revisions to SVN\n";
@@ -267,9 +271,9 @@ sub setup_git_svn {
 }
 
 sub assert_svn_wc_clean {
-	my ($svn_rev, $commit) = @_;
+	my ($svn_rev, $treeish) = @_;
 	croak "$svn_rev is not an integer!\n" unless ($svn_rev =~ /^\d+$/);
-	croak "$commit is not a sha1!\n" unless ($commit =~ /^$sha1$/o);
+	croak "$treeish is not a sha1!\n" unless ($treeish =~ /^$sha1$/o);
 	my $svn_info = svn_info('.');
 	if ($svn_rev != $svn_info->{'Last Changed Rev'}) {
 		croak "Expected r$svn_rev, got r",
@@ -282,12 +286,42 @@ sub assert_svn_wc_clean {
 		print STDERR $_ foreach @status;
 		croak;
 	}
-	my ($tree_a) = grep(/^tree $sha1$/o,`git-cat-file commit $commit`);
-	$tree_a =~ s/^tree //;
-	chomp $tree_a;
-	chomp(my $tree_b = `GIT_INDEX_FILE=$GIT_SVN_INDEX git-write-tree`);
-	if ($tree_a ne $tree_b) {
-		croak "$svn_rev != $commit, $tree_a != $tree_b\n";
+	assert_tree($treeish);
+}
+
+sub assert_tree {
+	my ($treeish) = @_;
+	croak "Not a sha1: $treeish\n" unless $treeish =~ /^$sha1$/o;
+	chomp(my $type = `git-cat-file -t $treeish`);
+	my $expected;
+	while ($type eq 'tag') {
+		chomp(($treeish, $type) = `git-cat-file tag $treeish`);
+	}
+	if ($type eq 'commit') {
+		$expected = (grep /^tree /,`git-cat-file commit $treeish`)[0];
+		($expected) = ($expected =~ /^tree ($sha1)$/);
+		die "Unable to get tree from $treeish\n" unless $expected;
+	} elsif ($type eq 'tree') {
+		$expected = $treeish;
+	} else {
+		die "$treeish is a $type, expected tree, tag or commit\n";
+	}
+
+	my $old_index = $ENV{GIT_INDEX_FILE};
+	my $tmpindex = $GIT_SVN_INDEX.'.assert-tmp';
+	if (-e $tmpindex) {
+		unlink $tmpindex or croak $!;
+	}
+	$ENV{GIT_INDEX_FILE} = $tmpindex;
+	git_addremove();
+	chomp(my $tree = `git-write-tree`);
+	if ($old_index) {
+		$ENV{GIT_INDEX_FILE} = $old_index;
+	} else {
+		delete $ENV{GIT_INDEX_FILE};
+	}
+	if ($tree ne $expected) {
+		croak "Tree mismatch, Got: $tree, Expected: $expected\n";
 	}
 }
 
@@ -298,7 +332,6 @@ sub parse_diff_tree {
 	my @mods;
 	while (<$diff_fh>) {
 		chomp $_; # this gets rid of the trailing "\0"
-		print $_,"\n";
 		if ($state eq 'meta' && /^:(\d{6})\s(\d{6})\s
 					$sha1\s($sha1)\s([MTCRAD])\d*$/xo) {
 			push @mods, {	mode_a => $1, mode_b => $2,
@@ -309,36 +342,44 @@ sub parse_diff_tree {
 				$state = 'file_b';
 			}
 		} elsif ($state eq 'file_a') {
-			my $x = $mods[$#mods] or croak __LINE__,": Empty array\n";
+			my $x = $mods[$#mods] or croak "Empty array\n";
 			if ($x->{chg} !~ /^(?:C|R)$/) {
-				croak __LINE__,": Error parsing $_, $x->{chg}\n";
+				croak "Error parsing $_, $x->{chg}\n";
 			}
 			$x->{file_a} = $_;
 			$state = 'file_b';
 		} elsif ($state eq 'file_b') {
-			my $x = $mods[$#mods] or croak __LINE__,": Empty array\n";
+			my $x = $mods[$#mods] or croak "Empty array\n";
 			if (exists $x->{file_a} && $x->{chg} !~ /^(?:C|R)$/) {
-				croak __LINE__,": Error parsing $_, $x->{chg}\n";
+				croak "Error parsing $_, $x->{chg}\n";
 			}
 			if (!exists $x->{file_a} && $x->{chg} =~ /^(?:C|R)$/) {
-				croak __LINE__,": Error parsing $_, $x->{chg}\n";
+				croak "Error parsing $_, $x->{chg}\n";
 			}
 			$x->{file_b} = $_;
 			$state = 'meta';
 		} else {
-			croak __LINE__,": Error parsing $_\n";
+			croak "Error parsing $_\n";
 		}
 	}
 	close $diff_fh or croak $!;
+
 	return \@mods;
 }
 
 sub svn_check_prop_executable {
 	my $m = shift;
-	if ($m->{mode_b} =~ /755$/ && $m->{mode_a} !~ /755$/) {
-		sys(qw(svn propset svn:executable 1), $m->{file_b});
+	return if -l $m->{file_b};
+	if ($m->{mode_b} =~ /755$/) {
+		chmod((0755 &~ umask),$m->{file_b}) or croak $!;
+		if ($m->{mode_a} !~ /755$/) {
+			sys(qw(svn propset svn:executable 1), $m->{file_b});
+		}
+		-x $m->{file_b} or croak "$m->{file_b} is not executable!\n";
 	} elsif ($m->{mode_b} !~ /755$/ && $m->{mode_a} =~ /755$/) {
 		sys(qw(svn propdel svn:executable), $m->{file_b});
+		chmod((0644 &~ umask),$m->{file_b}) or croak $!;
+		-x $m->{file_b} and croak "$m->{file_b} is executable!\n";
 	}
 }
 
@@ -349,84 +390,166 @@ sub svn_ensure_parent_path {
 	sys(qw(svn add -N), $dir_b) unless (-d "$dir_b/.svn");
 }
 
+sub precommit_check {
+	my $mods = shift;
+	my (%rm_file, %rmdir_check, %added_check);
+
+	my %o = ( D => 0, R => 1, C => 2, A => 3, M => 3, T => 3 );
+	foreach my $m (sort { $o{$a->{chg}} <=> $o{$b->{chg}} } @$mods) {
+		if ($m->{chg} eq 'R') {
+			if (-d $m->{file_b}) {
+				err_dir_to_file("$m->{file_a} => $m->{file_b}");
+			}
+			# dir/$file => dir/file/$file
+			my $dirname = dirname($m->{file_b});
+			while ($dirname ne File::Spec->curdir) {
+				if ($dirname ne $m->{file_a}) {
+					$dirname = dirname($dirname);
+					next;
+				}
+				err_file_to_dir("$m->{file_a} => $m->{file_b}");
+			}
+			# baz/zzz => baz (baz is a file)
+			$dirname = dirname($m->{file_a});
+			while ($dirname ne File::Spec->curdir) {
+				if ($dirname ne $m->{file_b}) {
+					$dirname = dirname($dirname);
+					next;
+				}
+				err_dir_to_file("$m->{file_a} => $m->{file_b}");
+			}
+		}
+		if ($m->{chg} =~ /^(D|R)$/) {
+			my $t = $1 eq 'D' ? 'file_b' : 'file_a';
+			$rm_file{ $m->{$t} } = 1;
+			my $dirname = dirname( $m->{$t} );
+			my $basename = basename( $m->{$t} );
+			$rmdir_check{$dirname}->{$basename} = 1;
+		} elsif ($m->{chg} =~ /^(?:A|C)$/) {
+			if (-d $m->{file_b}) {
+				err_dir_to_file($m->{file_b});
+			}
+			my $dirname = dirname( $m->{file_b} );
+			my $basename = basename( $m->{file_b} );
+			$added_check{$dirname}->{$basename} = 1;
+			while ($dirname ne File::Spec->curdir) {
+				if ($rm_file{$dirname}) {
+					err_file_to_dir($m->{file_b});
+				}
+				$dirname = dirname $dirname;
+			}
+		}
+	}
+	return (\%rmdir_check, \%added_check);
+
+	sub err_dir_to_file {
+		my $file = shift;
+		print STDERR "Node change from directory to file ",
+				"is not supported by Subversion: ",$file,"\n";
+		exit 1;
+	}
+	sub err_file_to_dir {
+		my $file = shift;
+		print STDERR "Node change from file to directory ",
+				"is not supported by Subversion: ",$file,"\n";
+		exit 1;
+	}
+}
+
 sub svn_checkout_tree {
-	my ($svn_rev, $commit) = @_;
+	my ($svn_rev, $treeish) = @_;
 	my $from = file_to_s("$REV_DIR/$svn_rev");
 	assert_svn_wc_clean($svn_rev,$from);
-	print "diff-tree '$from' '$commit'\n";
+	print "diff-tree '$from' '$treeish'\n";
 	my $pid = open my $diff_fh, '-|';
 	defined $pid or croak $!;
 	if ($pid == 0) {
 		my @diff_tree = qw(git-diff-tree -z -r -C);
 		push @diff_tree, '--find-copies-harder' if $_find_copies_harder;
 		push @diff_tree, "-l$_l" if defined $_l;
-		exec(@diff_tree, $from, $commit) or croak $!;
+		exec(@diff_tree, $from, $treeish) or croak $!;
 	}
 	my $mods = parse_diff_tree($diff_fh);
 	unless (@$mods) {
 		# git can do empty commits, SVN doesn't allow it...
-		return $svn_rev;
+		return $mods;
 	}
-	my %rm;
-	foreach my $m (@$mods) {
+	my ($rm, $add) = precommit_check($mods);
+
+	my %o = ( D => 1, R => 0, C => -1, A => 3, M => 3, T => 3 );
+	foreach my $m (sort { $o{$a->{chg}} <=> $o{$b->{chg}} } @$mods) {
 		if ($m->{chg} eq 'C') {
 			svn_ensure_parent_path( $m->{file_b} );
 			sys(qw(svn cp),		$m->{file_a}, $m->{file_b});
-			blob_to_file(		$m->{sha1_b}, $m->{file_b});
+			apply_mod_line_blob($m);
 			svn_check_prop_executable($m);
 		} elsif ($m->{chg} eq 'D') {
-			$rm{dirname $m->{file_b}}->{basename $m->{file_b}} = 1;
 			sys(qw(svn rm --force), $m->{file_b});
 		} elsif ($m->{chg} eq 'R') {
 			svn_ensure_parent_path( $m->{file_b} );
 			sys(qw(svn mv --force), $m->{file_a}, $m->{file_b});
-			blob_to_file(		$m->{sha1_b}, $m->{file_b});
+			apply_mod_line_blob($m);
 			svn_check_prop_executable($m);
-			$rm{dirname $m->{file_a}}->{basename $m->{file_a}} = 1;
 		} elsif ($m->{chg} eq 'M') {
-			if ($m->{mode_b} =~ /^120/ && $m->{mode_a} =~ /^120/) {
-				unlink $m->{file_b} or croak $!;
-				blob_to_symlink($m->{sha1_b}, $m->{file_b});
-			} else {
-				blob_to_file($m->{sha1_b}, $m->{file_b});
-			}
+			apply_mod_line_blob($m);
 			svn_check_prop_executable($m);
 		} elsif ($m->{chg} eq 'T') {
 			sys(qw(svn rm --force),$m->{file_b});
-			if ($m->{mode_b} =~ /^120/ && $m->{mode_a} =~ /^100/) {
-				blob_to_symlink($m->{sha1_b}, $m->{file_b});
-			} else {
-				blob_to_file($m->{sha1_b}, $m->{file_b});
-			}
-			svn_check_prop_executable($m);
+			apply_mod_line_blob($m);
 			sys(qw(svn add --force), $m->{file_b});
+			svn_check_prop_executable($m);
 		} elsif ($m->{chg} eq 'A') {
 			svn_ensure_parent_path( $m->{file_b} );
-			blob_to_file(		$m->{sha1_b}, $m->{file_b});
-			if ($m->{mode_b} =~ /755$/) {
-				chmod 0755, $m->{file_b};
-			}
+			apply_mod_line_blob($m);
 			sys(qw(svn add --force), $m->{file_b});
+			svn_check_prop_executable($m);
 		} else {
 			croak "Invalid chg: $m->{chg}\n";
 		}
 	}
-	if ($_rmdir) {
-		my $old_index = $ENV{GIT_INDEX_FILE};
-		$ENV{GIT_INDEX_FILE} = $GIT_SVN_INDEX;
-		foreach my $dir (keys %rm) {
-			my $files = $rm{$dir};
-			my @files;
-			foreach (safe_qx('svn','ls',$dir)) {
-				chomp;
-				push @files, $_ unless $files->{$_};
-			}
-			sys(qw(svn rm),$dir) unless @files;
-		}
-		if ($old_index) {
-			$ENV{GIT_INDEX_FILE} = $old_index;
-		} else {
-			delete $ENV{GIT_INDEX_FILE};
+
+	assert_tree($treeish);
+	if ($_rmdir) { # remove empty directories
+		handle_rmdir($rm, $add);
+	}
+	assert_tree($treeish);
+	return $mods;
+}
+
+# svn ls doesn't work with respect to the current working tree, but what's
+# in the repository.  There's not even an option for it... *sigh*
+# (added files don't show up and removed files remain in the ls listing)
+sub svn_ls_current {
+	my ($dir, $rm, $add) = @_;
+	chomp(my @ls = safe_qx('svn','ls',$dir));
+	my @ret = ();
+	foreach (@ls) {
+		s#/$##; # trailing slashes are evil
+		push @ret, $_ unless $rm->{$dir}->{$_};
+	}
+	if (exists $add->{$dir}) {
+		push @ret, keys %{$add->{$dir}};
+	}
+	return \@ret;
+}
+
+sub handle_rmdir {
+	my ($rm, $add) = @_;
+
+	foreach my $dir (sort {length $b <=> length $a} keys %$rm) {
+		my $ls = svn_ls_current($dir, $rm, $add);
+		next if (scalar @$ls);
+		sys(qw(svn rm --force),$dir);
+
+		my $dn = dirname $dir;
+		$rm->{ $dn }->{ basename $dir } = 1;
+		$ls = svn_ls_current($dn, $rm, $add);
+		while (scalar @$ls == 0 && $dn ne File::Spec->curdir) {
+			sys(qw(svn rm --force),$dn);
+			$dir = basename $dn;
+			$dn = dirname $dn;
+			$rm->{ $dn }->{ $dir } = 1;
+			$ls = svn_ls_current($dn, $rm, $add);
 		}
 	}
 }
@@ -692,10 +815,23 @@ sub git_commit {
 	return $commit;
 }
 
+sub apply_mod_line_blob {
+	my $m = shift;
+	if ($m->{mode_b} =~ /^120/) {
+		blob_to_symlink($m->{sha1_b}, $m->{file_b});
+	} else {
+		blob_to_file($m->{sha1_b}, $m->{file_b});
+	}
+}
+
 sub blob_to_symlink {
 	my ($blob, $link) = @_;
 	defined $link or croak "\$link not defined!\n";
 	croak "Not a sha1: $blob\n" unless $blob =~ /^$sha1$/o;
+	if (-l $link || -f _) {
+		unlink $link or croak $!;
+	}
+
 	my $dest = `git-cat-file blob $blob`; # no newline, so no chomp
 	symlink $dest, $link or croak $!;
 }
@@ -704,6 +840,10 @@ sub blob_to_file {
 	my ($blob, $file) = @_;
 	defined $file or croak "\$file not defined!\n";
 	croak "Not a sha1: $blob\n" unless $blob =~ /^$sha1$/o;
+	if (-l $file || -f _) {
+		unlink $file or croak $!;
+	}
+
 	open my $blob_fh, '>', $file or croak "$!: $file\n";
 	my $pid = fork;
 	defined $pid or croak $!;
-- 
1.2.0.gdee6
