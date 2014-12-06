From: Alfred Perlstein <alfred@freebsd.org>
Subject: [PATCH] git-svn: Support for git-svn propset
Date: Sat, 6 Dec 2014 14:29:42 -0800
Message-ID: <20141206222942.GB91825@elvis.mu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eric Wong <normalperson@yhbt.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	"Michael G. Schwern" <schwern@pobox.com>,
	David Fraser <davidf@sjsoft.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 06 23:29:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XxNrH-0007eR-J5
	for gcvg-git-2@plane.gmane.org; Sat, 06 Dec 2014 23:29:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752066AbaLFW3n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Dec 2014 17:29:43 -0500
Received: from elvis.mu.org ([192.203.228.196]:33535 "EHLO elvis.mu.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751869AbaLFW3m (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Dec 2014 17:29:42 -0500
Received: by elvis.mu.org (Postfix, from userid 1192)
	id A5CBC341F885; Sat,  6 Dec 2014 14:29:42 -0800 (PST)
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260966>

This change allows git-svn to support setting subversion properties.

Very useful for manually setting properties when committing to a
subversion repo that *requires* properties to be set without requiring
moving your changeset to separate subversion checkout in order to
set props.

This change is initially from David Fraser <davidf () sjsoft ! com>
Appearing here:
  http://marc.info/?l=git&m=125259772625008&w=2

They are now forward ported to most recent git along with fixes to
deal with files in subdirectories.

Style and functional changes from Eric Wong have been taken
in thier entirety from:
  http://marc.info/?l=git&m=141742735608544&w=2

Reviewed-by: Eric Wong <normalperson@yhbt.net>
Signed-off-by: Alfred Perlstein <alfred@freebsd.org>
Signed-off-by: David Fraser <davidf@sjsoft.com>
---
 git-svn.perl               | 49 +++++++++++++++++++++++++++++++-
 perl/Git/SVN/Editor.pm     | 43 ++++++++++++++++++++++++++++
 t/t9148-git-svn-propset.sh | 71 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 162 insertions(+), 1 deletion(-)
 create mode 100755 t/t9148-git-svn-propset.sh

diff --git a/git-svn.perl b/git-svn.perl
index b6e2186..5cdbf39 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -115,7 +115,7 @@ my ($_stdin, $_help, $_edit,
 	$_before, $_after,
 	$_merge, $_strategy, $_preserve_merges, $_dry_run, $_parents, $_local,
 	$_prefix, $_no_checkout, $_url, $_verbose,
-	$_commit_url, $_tag, $_merge_info, $_interactive);
+	$_commit_url, $_tag, $_merge_info, $_interactive, $_set_svn_props);
 
 # This is a refactoring artifact so Git::SVN can get at this git-svn switch.
 sub opt_prefix { return $_prefix || '' }
@@ -193,6 +193,7 @@ my %cmd = (
 			  'dry-run|n' => \$_dry_run,
 			  'fetch-all|all' => \$_fetch_all,
 			  'commit-url=s' => \$_commit_url,
+			  'set-svn-props=s' => \$_set_svn_props,
 			  'revision|r=i' => \$_revision,
 			  'no-rebase' => \$_no_rebase,
 			  'mergeinfo=s' => \$_merge_info,
@@ -228,6 +229,9 @@ my %cmd = (
         'propget' => [ \&cmd_propget,
 		       'Print the value of a property on a file or directory',
 		       { 'revision|r=i' => \$_revision } ],
+        'propset' => [ \&cmd_propset,
+		       'Set the value of a property on a file or directory - will be set on commit',
+		       {} ],
         'proplist' => [ \&cmd_proplist,
 		       'List all properties of a file or directory',
 		       { 'revision|r=i' => \$_revision } ],
@@ -1376,6 +1380,49 @@ sub cmd_propget {
 	print $props->{$prop} . "\n";
 }
 
+# cmd_propset (PROPNAME, PROPVAL, PATH)
+# ------------------------
+# Adjust the SVN property PROPNAME to PROPVAL for PATH.
+sub cmd_propset {
+	my ($propname, $propval, $path) = @_;
+	$path = '.' if not defined $path;
+	$path = $cmd_dir_prefix . $path;
+	usage(1) if not defined $propname;
+	usage(1) if not defined $propval;
+	my $file = basename($path);
+	my $dn = dirname($path);
+	my $cur_props = Git::SVN::Editor::check_attr( "svn-properties", $path );
+	my $new_props = "";
+	if ($cur_props eq "unset" || $cur_props eq "" || $cur_props eq "set") {
+		$new_props = "$propname=$propval";
+	} else {
+		# TODO: handle combining properties better
+		my @props = split(/;/, $cur_props);
+		my $replaced_prop;
+		foreach my $prop (@props) {
+			# Parse 'name=value' syntax and set the property.
+			if ($prop =~ /([^=]+)=(.*)/) {
+				my ($n,$v) = ($1,$2);
+				if ($n eq $propname)
+				{
+					$v = $propval;
+					$replaced_prop = 1;
+				}
+				if ($new_props eq "") { $new_props="$n=$v"; }
+				else { $new_props="$new_props;$n=$v"; }
+			}
+		}
+		if (!$replaced_prop) {
+			$new_props = "$new_props;$propname=$propval";
+		}
+	}
+	my $attrfile = "$dn/.gitattributes";
+	open my $attrfh, '>>', $attrfile or die "Can't open $attrfile: $!\n";
+	# TODO: don't simply append here if $file already has svn-properties
+	print $attrfh "$file svn-properties=$new_props\n" or die "write to $attrfile";
+	close $attrfh or die "close $attrfile";
+}
+
 # cmd_proplist (PATH)
 # -------------------
 # Print the list of SVN properties for PATH.
diff --git a/perl/Git/SVN/Editor.pm b/perl/Git/SVN/Editor.pm
index 34e8af9..dd15318 100644
--- a/perl/Git/SVN/Editor.pm
+++ b/perl/Git/SVN/Editor.pm
@@ -288,6 +288,45 @@ sub apply_autoprops {
 	}
 }
 
+sub check_attr
+{
+	my ($attr,$path) = @_;
+	my $fh = command_output_pipe("check-attr", $attr, "--", $path);
+	return undef if (!$fh);
+
+	my $val = <$fh>;
+	close $fh;
+	$val =~ s/^[^:]*:\s*[^:]*:\s*(.*)\s*$/$1/;
+	return $val;
+}
+
+sub apply_manualprops {
+	my ($self, $file, $fbat) = @_;
+	my $pending_properties = check_attr( "svn-properties", $file );
+	if ($pending_properties eq "") { return; }
+	# Parse the list of properties to set.
+	my @props = split(/;/, $pending_properties);
+	# TODO: get existing properties to compare to - this fails for add so currently not done
+	# my $existing_props = ::get_svnprops($file);
+	my $existing_props = {};
+	# TODO: caching svn properties or storing them in .gitattributes would make that faster
+	foreach my $prop (@props) {
+		# Parse 'name=value' syntax and set the property.
+		if ($prop =~ /([^=]+)=(.*)/) {
+			my ($n,$v) = ($1,$2);
+			for ($n, $v) {
+				s/^\s+//; s/\s+$//;
+			}
+			# FIXME: clearly I don't know perl and couldn't work
+			# out how to evaluate this better
+			my $existing = $existing_props->{$n};
+			if (!defined($existing) || $existing ne $v) {
+			    $self->change_file_prop($fbat, $n, $v);
+			}
+		}
+	}
+}
+
 sub A {
 	my ($self, $m, $deletions) = @_;
 	my ($dir, $file) = split_path($m->{file_b});
@@ -296,6 +335,7 @@ sub A {
 					undef, -1);
 	print "\tA\t$m->{file_b}\n" unless $::_q;
 	$self->apply_autoprops($file, $fbat);
+	$self->apply_manualprops($m->{file_b}, $fbat);
 	$self->chg_file($fbat, $m);
 	$self->close_file($fbat,undef,$self->{pool});
 }
@@ -311,6 +351,7 @@ sub C {
 	my $fbat = $self->add_file($self->repo_path($m->{file_b}), $pbat,
 				$upa, $self->{r});
 	print "\tC\t$m->{file_a} => $m->{file_b}\n" unless $::_q;
+	$self->apply_manualprops($m->{file_b}, $fbat);
 	$self->chg_file($fbat, $m);
 	$self->close_file($fbat,undef,$self->{pool});
 }
@@ -333,6 +374,7 @@ sub R {
 				$upa, $self->{r});
 	print "\tR\t$m->{file_a} => $m->{file_b}\n" unless $::_q;
 	$self->apply_autoprops($file, $fbat);
+	$self->apply_manualprops($m->{file_b}, $fbat);
 	$self->chg_file($fbat, $m);
 	$self->close_file($fbat,undef,$self->{pool});
 
@@ -348,6 +390,7 @@ sub M {
 	my $fbat = $self->open_file($self->repo_path($m->{file_b}),
 				$pbat,$self->{r},$self->{pool});
 	print "\t$m->{chg}\t$m->{file_b}\n" unless $::_q;
+	$self->apply_manualprops($m->{file_b}, $fbat);
 	$self->chg_file($fbat, $m);
 	$self->close_file($fbat,undef,$self->{pool});
 }
diff --git a/t/t9148-git-svn-propset.sh b/t/t9148-git-svn-propset.sh
new file mode 100755
index 0000000..b36a8a2
--- /dev/null
+++ b/t/t9148-git-svn-propset.sh
@@ -0,0 +1,71 @@
+#!/bin/sh
+#
+# Copyright (c) 2014 Alfred Perlstein
+#
+
+test_description='git svn propset tests'
+
+. ./lib-git-svn.sh
+
+foo_subdir2="subdir/subdir2/foo_subdir2"
+
+mkdir import
+(cd import
+	mkdir subdir
+	mkdir subdir/subdir2
+	touch foo		# for 'add props top level'
+	touch subdir/foo_subdir # for 'add props relative'
+	touch "$foo_subdir2"	# for 'add props subdir'
+	svn_cmd import -m 'import for git svn' . "$svnrepo" >/dev/null
+)
+rm -rf import
+
+test_expect_success 'initialize git svn' 'git svn init "$svnrepo"'
+test_expect_success 'fetch revisions from svn' 'git svn fetch'
+
+# There is a bogus feature about svn propset which means that it will only
+# be taken as a delta for svn dcommit iff the file is also modified.
+# That is fine for now.
+test_expect_success 'add props top level' '
+	git svn propset svn:keywords "FreeBSD=%H" foo &&
+	echo hello >> foo &&
+	git commit -m "testing propset" foo &&
+	git svn dcommit
+	svn_cmd co "$svnrepo" svn_project &&
+	(cd svn_project && test "`svn propget svn:keywords foo`" = "FreeBSD=%H") &&
+	rm -rf svn_project
+	'
+
+test_expect_success 'add multiple props' '
+	git svn propset svn:keywords "FreeBSD=%H" foo &&
+	git svn propset fbsd:nokeywords yes foo &&
+	echo hello >> foo &&
+	git commit -m "testing propset" foo &&
+	git svn dcommit
+	svn_cmd co "$svnrepo" svn_project &&
+	(cd svn_project && test "`svn propget svn:keywords foo`" = "FreeBSD=%H") &&
+	(cd svn_project && test "`svn propget fbsd:nokeywords foo`" = "yes") &&
+	(cd svn_project && test "`svn proplist -q foo | wc -l`" -eq 2) &&
+	rm -rf svn_project
+	'
+
+test_expect_success 'add props subdir' '
+	git svn propset svn:keywords "FreeBSD=%H" "$foo_subdir2" &&
+	echo hello >> "$foo_subdir2" &&
+	git commit -m "testing propset" "$foo_subdir2" &&
+	git svn dcommit
+	svn_cmd co "$svnrepo" svn_project &&
+	(cd svn_project && test "`svn propget svn:keywords "$foo_subdir2"`" = "FreeBSD=%H") &&
+	rm -rf svn_project
+	'
+
+test_expect_success 'add props relative' '
+	(cd subdir/subdir2 && git svn propset svn:keywords "FreeBSD=%H" ../foo_subdir ) &&
+	echo hello >> subdir/foo_subdir &&
+	git commit -m "testing propset" subdir/foo_subdir &&
+	git svn dcommit
+	svn_cmd co "$svnrepo" svn_project &&
+	(cd svn_project && test "`svn propget svn:keywords subdir/foo_subdir`" = "FreeBSD=%H") &&
+	rm -rf svn_project
+	'
+test_done
-- 
2.1.2
