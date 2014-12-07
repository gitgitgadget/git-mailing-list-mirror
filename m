From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] git-svn: Support for git-svn propset
Date: Sun, 7 Dec 2014 05:42:11 +0000
Message-ID: <20141207054211.GA25793@dcvr.yhbt.net>
References: <20141206222942.GB91825@elvis.mu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	"Michael G. Schwern" <schwern@pobox.com>,
	David Fraser <davidf@sjsoft.com>
To: Alfred Perlstein <alfred@freebsd.org>
X-From: git-owner@vger.kernel.org Sun Dec 07 06:42:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XxUbw-0004pV-P7
	for gcvg-git-2@plane.gmane.org; Sun, 07 Dec 2014 06:42:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751909AbaLGFmP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Dec 2014 00:42:15 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:40145 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751487AbaLGFmO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Dec 2014 00:42:14 -0500
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id DC2FE633805;
	Sun,  7 Dec 2014 05:42:11 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20141206222942.GB91825@elvis.mu.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260970>

Alfred Perlstein <alfred@freebsd.org> wrote:
> This change allows git-svn to support setting subversion properties.
> 
> Very useful for manually setting properties when committing to a
> subversion repo that *requires* properties to be set without requiring
> moving your changeset to separate subversion checkout in order to
> set props.
> 
> This change is initially from David Fraser <davidf () sjsoft ! com>

No point to obfuscate email addresses in commit messages (especially
it's also in the Signed-off-by :).

> Appearing here:
>   http://marc.info/?l=git&m=125259772625008&w=2
> 
> They are now forward ported to most recent git along with fixes to
> deal with files in subdirectories.
> 
> Style and functional changes from Eric Wong have been taken
> in thier entirety from:

s/thier/their/

>   http://marc.info/?l=git&m=141742735608544&w=2

Fwiw, I prefer equivalent mid.gmane.org links since the message-ID
remains useful if the web server ever goes away. e.g.:

  http://mid.gmane.org/20141201094911.GA13931@dcvr.yhbt.net

> Reviewed-by: Eric Wong <normalperson@yhbt.net>
> Signed-off-by: Alfred Perlstein <alfred@freebsd.org>
> Signed-off-by: David Fraser <davidf@sjsoft.com>

I'd like to squash in the following changes (in order of importance):

- use && to chain commands throughout tests
- use svn_cmd wrapper throughout tests
- show $! in die messages
- favor $(...) over `...` in tests
- make new_props an array simplify building the final list
- wrap long comments (help output still needs fixing)
- remove unnecessary FIXME comment

No need to resend if you're OK with these things.  Thanks again.

diff --git a/git-svn.perl b/git-svn.perl
index 5cdbf39..ec5cee4 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -1392,9 +1392,9 @@ sub cmd_propset {
 	my $file = basename($path);
 	my $dn = dirname($path);
 	my $cur_props = Git::SVN::Editor::check_attr( "svn-properties", $path );
-	my $new_props = "";
+	my @new_props;
 	if ($cur_props eq "unset" || $cur_props eq "" || $cur_props eq "set") {
-		$new_props = "$propname=$propval";
+		push @new_props, "$propname=$propval";
 	} else {
 		# TODO: handle combining properties better
 		my @props = split(/;/, $cur_props);
@@ -1403,24 +1403,24 @@ sub cmd_propset {
 			# Parse 'name=value' syntax and set the property.
 			if ($prop =~ /([^=]+)=(.*)/) {
 				my ($n,$v) = ($1,$2);
-				if ($n eq $propname)
-				{
+				if ($n eq $propname) {
 					$v = $propval;
 					$replaced_prop = 1;
 				}
-				if ($new_props eq "") { $new_props="$n=$v"; }
-				else { $new_props="$new_props;$n=$v"; }
+				push @new_props, "$n=$v";
 			}
 		}
 		if (!$replaced_prop) {
-			$new_props = "$new_props;$propname=$propval";
+			push @new_props, "$propname=$propval";
 		}
 	}
 	my $attrfile = "$dn/.gitattributes";
 	open my $attrfh, '>>', $attrfile or die "Can't open $attrfile: $!\n";
 	# TODO: don't simply append here if $file already has svn-properties
-	print $attrfh "$file svn-properties=$new_props\n" or die "write to $attrfile";
-	close $attrfh or die "close $attrfile";
+	my $new_props = join(';', @new_props);
+	print $attrfh "$file svn-properties=$new_props\n" or
+		die "write to $attrfile: $!\n";
+	close $attrfh or die "close $attrfile: $!\n";
 }
 
 # cmd_proplist (PATH)
diff --git a/perl/Git/SVN/Editor.pm b/perl/Git/SVN/Editor.pm
index dd15318..8bed2d9 100644
--- a/perl/Git/SVN/Editor.pm
+++ b/perl/Git/SVN/Editor.pm
@@ -288,8 +288,7 @@ sub apply_autoprops {
 	}
 }
 
-sub check_attr
-{
+sub check_attr {
 	my ($attr,$path) = @_;
 	my $fh = command_output_pipe("check-attr", $attr, "--", $path);
 	return undef if (!$fh);
@@ -306,10 +305,12 @@ sub apply_manualprops {
 	if ($pending_properties eq "") { return; }
 	# Parse the list of properties to set.
 	my @props = split(/;/, $pending_properties);
-	# TODO: get existing properties to compare to - this fails for add so currently not done
+	# TODO: get existing properties to compare to
+	# - this fails for add so currently not done
 	# my $existing_props = ::get_svnprops($file);
 	my $existing_props = {};
-	# TODO: caching svn properties or storing them in .gitattributes would make that faster
+	# TODO: caching svn properties or storing them in .gitattributes
+	# would make that faster
 	foreach my $prop (@props) {
 		# Parse 'name=value' syntax and set the property.
 		if ($prop =~ /([^=]+)=(.*)/) {
@@ -317,8 +318,6 @@ sub apply_manualprops {
 			for ($n, $v) {
 				s/^\s+//; s/\s+$//;
 			}
-			# FIXME: clearly I don't know perl and couldn't work
-			# out how to evaluate this better
 			my $existing = $existing_props->{$n};
 			if (!defined($existing) || $existing ne $v) {
 			    $self->change_file_prop($fbat, $n, $v);
diff --git a/t/t9148-git-svn-propset.sh b/t/t9148-git-svn-propset.sh
index b36a8a2..6973e8d 100755
--- a/t/t9148-git-svn-propset.sh
+++ b/t/t9148-git-svn-propset.sh
@@ -9,16 +9,14 @@ test_description='git svn propset tests'
 
 foo_subdir2="subdir/subdir2/foo_subdir2"
 
-mkdir import
-(cd import
-	mkdir subdir
-	mkdir subdir/subdir2
-	touch foo		# for 'add props top level'
-	touch subdir/foo_subdir # for 'add props relative'
-	touch "$foo_subdir2"	# for 'add props subdir'
+(mkdir import && cd import &&
+	mkdir subdir &&
+	mkdir subdir/subdir2 &&
+	touch foo && : "for 'add props top level'" &&
+	touch subdir/foo_subdir && : "for 'add props relative'" &&
+	touch "$foo_subdir2" && : "for 'add props subdir'" &&
 	svn_cmd import -m 'import for git svn' . "$svnrepo" >/dev/null
-)
-rm -rf import
+) && rm -rf import
 
 test_expect_success 'initialize git svn' 'git svn init "$svnrepo"'
 test_expect_success 'fetch revisions from svn' 'git svn fetch'
@@ -30,9 +28,10 @@ test_expect_success 'add props top level' '
 	git svn propset svn:keywords "FreeBSD=%H" foo &&
 	echo hello >> foo &&
 	git commit -m "testing propset" foo &&
-	git svn dcommit
+	git svn dcommit &&
 	svn_cmd co "$svnrepo" svn_project &&
-	(cd svn_project && test "`svn propget svn:keywords foo`" = "FreeBSD=%H") &&
+	(cd svn_project &&
+	 test "$(svn_cmd propget svn:keywords foo)" = "FreeBSD=%H") &&
 	rm -rf svn_project
 	'
 
@@ -41,11 +40,12 @@ test_expect_success 'add multiple props' '
 	git svn propset fbsd:nokeywords yes foo &&
 	echo hello >> foo &&
 	git commit -m "testing propset" foo &&
-	git svn dcommit
+	git svn dcommit &&
 	svn_cmd co "$svnrepo" svn_project &&
-	(cd svn_project && test "`svn propget svn:keywords foo`" = "FreeBSD=%H") &&
-	(cd svn_project && test "`svn propget fbsd:nokeywords foo`" = "yes") &&
-	(cd svn_project && test "`svn proplist -q foo | wc -l`" -eq 2) &&
+	(cd svn_project &&
+		test "$(svn_cmd propget svn:keywords foo)" = "FreeBSD=%H" &&
+		test "$(svn_cmd propget fbsd:nokeywords foo)" = "yes" &&
+		test "$(svn_cmd proplist -q foo | wc -l)" -eq 2) &&
 	rm -rf svn_project
 	'
 
@@ -53,19 +53,24 @@ test_expect_success 'add props subdir' '
 	git svn propset svn:keywords "FreeBSD=%H" "$foo_subdir2" &&
 	echo hello >> "$foo_subdir2" &&
 	git commit -m "testing propset" "$foo_subdir2" &&
-	git svn dcommit
+	git svn dcommit &&
 	svn_cmd co "$svnrepo" svn_project &&
-	(cd svn_project && test "`svn propget svn:keywords "$foo_subdir2"`" = "FreeBSD=%H") &&
+	(cd svn_project &&
+	 test "$(svn_cmd propget svn:keywords "$foo_subdir2")" = "FreeBSD=%H"
+	) &&
 	rm -rf svn_project
 	'
 
 test_expect_success 'add props relative' '
-	(cd subdir/subdir2 && git svn propset svn:keywords "FreeBSD=%H" ../foo_subdir ) &&
+	(cd subdir/subdir2 &&
+	 git svn propset svn:keywords "FreeBSD=%H" ../foo_subdir ) &&
 	echo hello >> subdir/foo_subdir &&
 	git commit -m "testing propset" subdir/foo_subdir &&
-	git svn dcommit
+	git svn dcommit &&
 	svn_cmd co "$svnrepo" svn_project &&
-	(cd svn_project && test "`svn propget svn:keywords subdir/foo_subdir`" = "FreeBSD=%H") &&
+	(cd svn_project &&
+	 test "$(svn_cmd propget svn:keywords subdir/foo_subdir)" = "FreeBSD=%H"
+	) &&
 	rm -rf svn_project
 	'
 test_done
