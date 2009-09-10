From: David Fraser <davidf@sjsoft.com>
Subject: git svn propset support
Date: Thu, 10 Sep 2009 10:41:06 -0500 (CDT)
Message-ID: <1077746712.371252597266033.JavaMail.root@klofta.sjsoft.com>
References: <1699967795.351252597251356.JavaMail.root@klofta.sjsoft.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_6_1527419887.1252597266023"
Cc: David Moore <davidm@sjsoft.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 10 17:48:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mllt9-0005Jc-LS
	for gcvg-git-2@lo.gmane.org; Thu, 10 Sep 2009 17:48:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751917AbZIJPsi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Sep 2009 11:48:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751913AbZIJPsi
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Sep 2009 11:48:38 -0400
Received: from klofta.sjsoft.com ([66.135.55.210]:49041 "EHLO
	klofta.sjsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751709AbZIJPsh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Sep 2009 11:48:37 -0400
X-Greylist: delayed 450 seconds by postgrey-1.27 at vger.kernel.org; Thu, 10 Sep 2009 11:48:37 EDT
Received: from localhost (localhost.localdomain [127.0.0.1])
	by klofta.sjsoft.com (Postfix) with ESMTP id E5EA218384C2
	for <git@vger.kernel.org>; Thu, 10 Sep 2009 10:41:10 -0500 (CDT)
X-Virus-Scanned: amavisd-new at klofta.sjsoft.com
Received: from klofta.sjsoft.com ([127.0.0.1])
	by localhost (klofta.sjsoft.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xyTp-lB61TVg; Thu, 10 Sep 2009 10:41:06 -0500 (CDT)
Received: from klofta.sjsoft.com (klofta.sjsoft.com [66.135.55.210])
	by klofta.sjsoft.com (Postfix) with ESMTP id 1954018384BB;
	Thu, 10 Sep 2009 10:41:06 -0500 (CDT)
In-Reply-To: <1699967795.351252597251356.JavaMail.root@klofta.sjsoft.com>
X-Originating-IP: [41.245.152.2]
X-Mailer: Zimbra 5.0.18_GA_3011.RHEL5_64 (ZimbraWebClient - FF3.0 (Linux)/5.0.18_GA_3011.RHEL5_64)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128122>

------=_Part_6_1527419887.1252597266023
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

Hi

I've been trying to hack at getting manually property setting support for git-svn.

I've got a start of a patch that basically stores an attribute 'svn-properties' for each file that needs them changed, and then sets the properties when committing.

Issues remaining:
 * The way it edits the .gitattributes file is suboptimal - it just appends to the end the latest version
 * It could use the existing code to get the current svn properties to see if properties need to be changed; but this doesn't work on add
 * It would be better to cache all the svn properties locally - this could be done automatically in .gitattributes but I'm not sure everyone would want this, etc
 * No support for deleting properties

Usage is:
 git svn propset PROPNAME PROPVALUE PATH

Patch attached (against 1.6.0.2) - any comments welcome

David

-- 
David Fraser
St James Software

------=_Part_6_1527419887.1252597266023
Content-Type: text/x-patch; name=git-svn-propset-0.patch
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=git-svn-propset-0.patch

--- git-1.6.0.2/git-svn.perl	2008-12-15 15:52:14.000000000 +0200
+++ git-svn.perl	2009-09-10 17:35:04.000000000 +0200
@@ -66,7 +66,7 @@
 	$_version, $_fetch_all, $_no_rebase,
 	$_merge, $_strategy, $_dry_run, $_local,
 	$_prefix, $_no_checkout, $_url, $_verbose,
-	$_git_format, $_commit_url);
+	$_git_format, $_commit_url, $_set_svn_props);
 $Git::SVN::_follow_parent = 1;
 my %remote_opts = ( 'username=s' => \$Git::SVN::Prompt::_username,
                     'config-dir=s' => \$Git::SVN::Ra::config_dir,
@@ -128,6 +128,7 @@
 			  'dry-run|n' => \$_dry_run,
 			  'fetch-all|all' => \$_fetch_all,
 			  'commit-url=s' => \$_commit_url,
+			  'set-svn-props=s' => \$_set_svn_props,
 			  'revision|r=i' => \$_revision,
 			  'no-rebase' => \$_no_rebase,
 			%cmt_opts, %fc_opts } ],
@@ -141,6 +142,9 @@
         'propget' => [ \&cmd_propget,
 		       'Print the value of a property on a file or directory',
 		       { 'revision|r=i' => \$_revision } ],
+        'propset' => [ \&cmd_propset,
+		       'Set the value of a property on a file or directory - will be set on commit',
+		       {} ],
         'proplist' => [ \&cmd_proplist,
 		       'List all properties of a file or directory',
 		       { 'revision|r=i' => \$_revision } ],
@@ -700,6 +704,64 @@
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
@@ -3598,6 +3660,34 @@
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
 	my ($self, $m) = @_;
 	my ($dir, $file) = split_path($m->{file_b});
@@ -3606,6 +3696,7 @@
 					undef, -1);
 	print "\tA\t$m->{file_b}\n" unless $::_q;
 	$self->apply_autoprops($file, $fbat);
+	$self->apply_manualprops($file, $fbat);
 	$self->chg_file($fbat, $m);
 	$self->close_file($fbat,undef,$self->{pool});
 }
@@ -3617,6 +3708,7 @@
 	my $fbat = $self->add_file($self->repo_path($m->{file_b}), $pbat,
 				$self->url_path($m->{file_a}), $self->{r});
 	print "\tC\t$m->{file_a} => $m->{file_b}\n" unless $::_q;
+	$self->apply_manualprops($file, $fbat);
 	$self->chg_file($fbat, $m);
 	$self->close_file($fbat,undef,$self->{pool});
 }
@@ -3636,6 +3728,7 @@
 	my $fbat = $self->add_file($self->repo_path($m->{file_b}), $pbat,
 				$self->url_path($m->{file_a}), $self->{r});
 	print "\tR\t$m->{file_a} => $m->{file_b}\n" unless $::_q;
+	$self->apply_manualprops($file, $fbat);
 	$self->chg_file($fbat, $m);
 	$self->close_file($fbat,undef,$self->{pool});
 
@@ -3651,6 +3744,7 @@
 	my $fbat = $self->open_file($self->repo_path($m->{file_b}),
 				$pbat,$self->{r},$self->{pool});
 	print "\t$m->{chg}\t$m->{file_b}\n" unless $::_q;
+	$self->apply_manualprops($file, $fbat);
 	$self->chg_file($fbat, $m);
 	$self->close_file($fbat,undef,$self->{pool});
 }

------=_Part_6_1527419887.1252597266023--
