From: Alfred Perlstein <alfred@freebsd.org>
Subject: [PATCH] git-svn: Support for git-svn propset
Date: Sun, 30 Nov 2014 22:24:20 -0800
Message-ID: <20141201062420.GF99906@elvis.mu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eric Wong <normalperson@yhbt.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	"Michael G. Schwern" <schwern@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 01 07:33:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XvKYX-0003By-DI
	for gcvg-git-2@plane.gmane.org; Mon, 01 Dec 2014 07:33:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752681AbaLAGdx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Dec 2014 01:33:53 -0500
Received: from elvis.mu.org ([192.203.228.196]:12460 "EHLO elvis.mu.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752678AbaLAGdw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Dec 2014 01:33:52 -0500
Received: by elvis.mu.org (Postfix, from userid 1192)
	id EABC8341F875; Sun, 30 Nov 2014 22:24:20 -0800 (PST)
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260473>

This change allows git-svn to support setting subversion properties.

Very useful for manually setting properties when committing to a
subversion repo that *requires* properties to be set without requiring
moving your changeset to separate subversion checkout in order to
set props.

This change is initially from David Fraser <davidf () sjsoft ! com>
Appearing here: http://marc.info/?l=git&m=125259772625008&w=2

They are now forward ported to most recent git along with fixes to
deal with files in subdirectories.

        Developer's Certificate of Origin 1.1

        By making a contribution to this project, I certify that:

        (a) The contribution was created in whole or in part by me and I
            have the right to submit it under the open source license
            indicated in the file; or

        (b) The contribution is based upon previous work that, to the best
            of my knowledge, is covered under an appropriate open source
            license and I have the right under that license to submit that
            work with modifications, whether created in whole or in part
            by me, under the same open source license (unless I am
            permitted to submit under a different license), as indicated
            in the file; or

        (c) The contribution was provided directly to me by some other
            person who certified (a), (b) or (c) and I have not modified
            it.

	(d) I understand and agree that this project and the contribution
	    are public and that a record of the contribution (including all
	    personal information I submit with it, including my sign-off) is
	    maintained indefinitely and may be redistributed consistent with
	    this project or the open source license(s) involved.

Signed-off-by: Alfred Perlstein <alfred@freebsd.org>
---
 git-svn.perl           | 50 +++++++++++++++++++++++++++++++++++++++++++++++++-
 perl/Git/SVN/Editor.pm | 47 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 96 insertions(+), 1 deletion(-)

diff --git a/git-svn.perl b/git-svn.perl
index b6e2186..91423a8 100755
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
@@ -1376,6 +1380,50 @@ sub cmd_propget {
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
+	# diff has check_attr locally, so just call direct
+	#my $current_properties = check_attr( "svn-properties", $path );
+	my $current_properties = Git::SVN::Editor::check_attr( "svn-properties", $path );
+	my $new_properties = "";
+	if ($current_properties eq "unset" || $current_properties eq "" || $current_properties eq "set") {
+		$new_properties = "$propname=$propval";
+	} else {
+		# TODO: handle combining properties better
+		my @props = split(/;/, $current_properties);
+		my $replaced_prop = 0;
+		foreach my $prop (@props) {
+			# Parse 'name=value' syntax and set the property.
+			if ($prop =~ /([^=]+)=(.*)/) {
+				my ($n,$v) = ($1,$2);
+				if ($n eq $propname)
+				{
+					$v = $propval;
+					$replaced_prop = 1;
+				}
+				if ($new_properties eq "") { $new_properties="$n=$v"; }
+				else { $new_properties="$new_properties;$n=$v"; }
+			}
+		}
+		if ($replaced_prop eq 0) {
+			$new_properties = "$new_properties;$propname=$propval";
+		}
+	}
+	my $attrfile = "$dn/.gitattributes";
+	open my $attrfh, '>>', $attrfile or die "Can't open $attrfile: $!\n";
+	# TODO: don't simply append here if $file already has svn-properties
+	print $attrfh "$file svn-properties=$new_properties\n";
+}
+
 # cmd_proplist (PATH)
 # -------------------
 # Print the list of SVN properties for PATH.
diff --git a/perl/Git/SVN/Editor.pm b/perl/Git/SVN/Editor.pm
index 34e8af9..5158c03 100644
--- a/perl/Git/SVN/Editor.pm
+++ b/perl/Git/SVN/Editor.pm
@@ -288,6 +288,49 @@ sub apply_autoprops {
 	}
 }
 
+sub check_attr
+{
+    my ($attr,$path) = @_;
+    if ( open my $fh, '-|', "git", "check-attr", $attr, "--", $path )
+    {
+	my $val = <$fh>;
+	close $fh;
+	$val =~ s/^[^:]*:\s*[^:]*:\s*(.*)\s*$/$1/;
+	return $val;
+    }
+    else
+    {
+	return undef;
+    }
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
+			# FIXME: clearly I don't know perl and couldn't work out how to evaluate this better
+			if (defined $existing_props->{$n} && $existing_props->{$n} eq $v) {
+				my $needed = 0;
+			} else {
+				$self->change_file_prop($fbat, $n, $v);
+			}
+		}
+	}
+}
+
 sub A {
 	my ($self, $m, $deletions) = @_;
 	my ($dir, $file) = split_path($m->{file_b});
@@ -296,6 +339,7 @@ sub A {
 					undef, -1);
 	print "\tA\t$m->{file_b}\n" unless $::_q;
 	$self->apply_autoprops($file, $fbat);
+	$self->apply_manualprops($m->{file_b}, $fbat);
 	$self->chg_file($fbat, $m);
 	$self->close_file($fbat,undef,$self->{pool});
 }
@@ -311,6 +355,7 @@ sub C {
 	my $fbat = $self->add_file($self->repo_path($m->{file_b}), $pbat,
 				$upa, $self->{r});
 	print "\tC\t$m->{file_a} => $m->{file_b}\n" unless $::_q;
+	$self->apply_manualprops($m->{file_b}, $fbat);
 	$self->chg_file($fbat, $m);
 	$self->close_file($fbat,undef,$self->{pool});
 }
@@ -333,6 +378,7 @@ sub R {
 				$upa, $self->{r});
 	print "\tR\t$m->{file_a} => $m->{file_b}\n" unless $::_q;
 	$self->apply_autoprops($file, $fbat);
+	$self->apply_manualprops($m->{file_b}, $fbat);
 	$self->chg_file($fbat, $m);
 	$self->close_file($fbat,undef,$self->{pool});
 
@@ -348,6 +394,7 @@ sub M {
 	my $fbat = $self->open_file($self->repo_path($m->{file_b}),
 				$pbat,$self->{r},$self->{pool});
 	print "\t$m->{chg}\t$m->{file_b}\n" unless $::_q;
+	$self->apply_manualprops($m->{file_b}, $fbat);
 	$self->chg_file($fbat, $m);
 	$self->close_file($fbat,undef,$self->{pool});
 }
-- 
2.1.2
