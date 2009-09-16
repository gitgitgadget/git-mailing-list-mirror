From: David Fraser <davidf@sjsoft.com>
Subject: [PATCH] Initial manually svn property setting support for git-svn
Date: Wed, 16 Sep 2009 02:02:09 -0500 (CDT)
Message-ID: <1927112650.1281253084529659.JavaMail.root@klofta.sjsoft.com>
References: <1482075216.1261253084509966.JavaMail.root@klofta.sjsoft.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_20_871626556.1253084529646"
Cc: David Moore <davidm@sjsoft.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 16 13:32:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MnskJ-0007UA-Bm
	for gcvg-git-2@lo.gmane.org; Wed, 16 Sep 2009 13:32:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753824AbZIPLcO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Sep 2009 07:32:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752603AbZIPLcO
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Sep 2009 07:32:14 -0400
Received: from klofta.sjsoft.com ([66.135.55.210]:60423 "EHLO
	klofta.sjsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752599AbZIPLcN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Sep 2009 07:32:13 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by klofta.sjsoft.com (Postfix) with ESMTP id 939F7183800D
	for <git@vger.kernel.org>; Wed, 16 Sep 2009 02:02:14 -0500 (CDT)
X-Virus-Scanned: amavisd-new at klofta.sjsoft.com
Received: from klofta.sjsoft.com ([127.0.0.1])
	by localhost (klofta.sjsoft.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7HrVVhvNu8aW; Wed, 16 Sep 2009 02:02:09 -0500 (CDT)
Received: from klofta.sjsoft.com (klofta.sjsoft.com [66.135.55.210])
	by klofta.sjsoft.com (Postfix) with ESMTP id BD5AA1838007;
	Wed, 16 Sep 2009 02:02:09 -0500 (CDT)
In-Reply-To: <1482075216.1261253084509966.JavaMail.root@klofta.sjsoft.com>
X-Originating-IP: [41.245.146.71]
X-Mailer: Zimbra 6.0.1_GA_1816.RHEL5_64 (ZimbraWebClient - FF3.0 (Linux)/6.0.1_GA_1816.RHEL5_64)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128644>

------=_Part_20_871626556.1253084529646
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

This basically stores an attribute 'svn-properties' for each file that needs them changed, and then sets the properties when committing.

Issues remaining:
 * The way it edits the .gitattributes file is suboptimal - it just appends to the end the latest version
 * It could use the existing code to get the current svn properties to see if properties need to be changed; but this doesn't work on add
 * It would be better to cache all the svn properties locally - this could be done automatically in .gitattributes but I'm not sure everyone would want this, etc
 * No support for deleting properties

Usage is:
 git svn propset PROPNAME PROPVALUE PATH

Added minimal documentation for git-svn propset

Signed-off-by: David Fraser <davidf@sjsoft.com>
---
 Documentation/git-svn.txt |    5 ++
 git-svn.perl              |   95 ++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 99 insertions(+), 1 deletions(-)

------=_Part_20_871626556.1253084529646
Content-Type: text/x-patch;
	name=0001-Initial-manually-svn-property-setting-support-for-gi.patch
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=0001-Initial-manually-svn-property-setting-support-for-gi.patch

>From 521ed4fc7c877269fb029b9494ef57300c722a10 Mon Sep 17 00:00:00 2001
From: David Fraser <davidf@sjsoft.com>
Date: Wed, 16 Sep 2009 13:28:00 +0200
Subject: [PATCH] Initial manually svn property setting support for git-svn.

This basically stores an attribute 'svn-properties' for each file that needs them changed, and then sets the properties when committing.

Issues remaining:
 * The way it edits the .gitattributes file is suboptimal - it just appends to the end the latest version
 * It could use the existing code to get the current svn properties to see if properties need to be changed; but this doesn't work on add
 * It would be better to cache all the svn properties locally - this could be done automatically in .gitattributes but I'm not sure everyone would want this, etc
 * No support for deleting properties

Usage is:
 git svn propset PROPNAME PROPVALUE PATH

Added minimal documentation for git-svn propset

Signed-off-by: David Fraser <davidf@sjsoft.com>
---
 Documentation/git-svn.txt |    5 ++
 git-svn.perl              |   95 ++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 99 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
index 1812890..b14bcf0 100644
--- a/Documentation/git-svn.txt
+++ b/Documentation/git-svn.txt
@@ -345,6 +345,11 @@ Any other arguments are passed directly to 'git log'
 	Gets the Subversion property given as the first argument, for a
 	file.  A specific revision can be specified with -r/--revision.
 
+'propset'::
+	Sets the Subversion property given as the first argument, to the value
+        given as the second argument, for files specifed as the remaining
+	arguments. The property will be sent with the next commit.
+
 'show-externals'::
 	Shows the Subversion externals.  Use -r/--revision to specify a
 	specific revision.
diff --git a/git-svn.perl b/git-svn.perl
index e0ec258..aaf92fb 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -80,7 +80,7 @@ my ($_stdin, $_help, $_edit,
 	$_version, $_fetch_all, $_no_rebase, $_fetch_parent,
 	$_merge, $_strategy, $_dry_run, $_local,
 	$_prefix, $_no_checkout, $_url, $_verbose,
-	$_git_format, $_commit_url, $_tag);
+	$_git_format, $_commit_url, $_tag, $_set_svn_props);
 $Git::SVN::_follow_parent = 1;
 $_q ||= 0;
 my %remote_opts = ( 'username=s' => \$Git::SVN::Prompt::_username,
@@ -147,6 +147,7 @@ my %cmd = (
 			  'dry-run|n' => \$_dry_run,
 			  'fetch-all|all' => \$_fetch_all,
 			  'commit-url=s' => \$_commit_url,
+			  'set-svn-props=s' => \$_set_svn_props,
 			  'revision|r=i' => \$_revision,
 			  'no-rebase' => \$_no_rebase,
 			%cmt_opts, %fc_opts } ],
@@ -171,6 +172,9 @@ my %cmd = (
         'propget' => [ \&cmd_propget,
 		       'Print the value of a property on a file or directory',
 		       { 'revision|r=i' => \$_revision } ],
+        'propset' => [ \&cmd_propset,
+		       'Set the value of a property on a file or directory - will be set on commit',
+		       {} ],
         'proplist' => [ \&cmd_proplist,
 		       'List all properties of a file or directory',
 		       { 'revision|r=i' => \$_revision } ],
@@ -892,6 +896,64 @@ sub cmd_propget {
 	print $props->{$prop} . "\n";
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
+	my $current_properties = check_attr( "svn-properties", $path );
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
@@ -4185,6 +4247,33 @@ sub apply_autoprops {
 	}
 }
 
+sub apply_manualprops {
+	my ($self, $file, $fbat) = @_;
+	my $path = $cmd_dir_prefix . $file;
+	my $pending_properties = ::check_attr( "svn-properties", $path );
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
 	my ($self, $m) = @_;
 	my ($dir, $file) = split_path($m->{file_b});
@@ -4193,6 +4282,7 @@ sub A {
 					undef, -1);
 	print "\tA\t$m->{file_b}\n" unless $::_q;
 	$self->apply_autoprops($file, $fbat);
+	$self->apply_manualprops($file, $fbat);
 	$self->chg_file($fbat, $m);
 	$self->close_file($fbat,undef,$self->{pool});
 }
@@ -4204,6 +4294,7 @@ sub C {
 	my $fbat = $self->add_file($self->repo_path($m->{file_b}), $pbat,
 				$self->url_path($m->{file_a}), $self->{r});
 	print "\tC\t$m->{file_a} => $m->{file_b}\n" unless $::_q;
+	$self->apply_manualprops($file, $fbat);
 	$self->chg_file($fbat, $m);
 	$self->close_file($fbat,undef,$self->{pool});
 }
@@ -4223,6 +4314,7 @@ sub R {
 	my $fbat = $self->add_file($self->repo_path($m->{file_b}), $pbat,
 				$self->url_path($m->{file_a}), $self->{r});
 	print "\tR\t$m->{file_a} => $m->{file_b}\n" unless $::_q;
+	$self->apply_manualprops($file, $fbat);
 	$self->apply_autoprops($file, $fbat);
 	$self->chg_file($fbat, $m);
 	$self->close_file($fbat,undef,$self->{pool});
@@ -4239,6 +4331,7 @@ sub M {
 	my $fbat = $self->open_file($self->repo_path($m->{file_b}),
 				$pbat,$self->{r},$self->{pool});
 	print "\t$m->{chg}\t$m->{file_b}\n" unless $::_q;
+	$self->apply_manualprops($file, $fbat);
 	$self->chg_file($fbat, $m);
 	$self->close_file($fbat,undef,$self->{pool});
 }
-- 
1.6.0.4


------=_Part_20_871626556.1253084529646--
