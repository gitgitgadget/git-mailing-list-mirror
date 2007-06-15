From: Sam Vilain <sam.vilain@catalyst.net.nz>
Subject: [PATCH] git-svn: avoid string eval for defining functions
Date: Fri, 15 Jun 2007 15:43:59 +1200
Message-ID: <11818790393274-git-send-email-sam.vilain@catalyst.net.nz>
Cc: git@vger.kernel.org, Sam Vilain <sam.vilain@catalyst.net.nz>
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Fri Jun 15 05:44:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hz2jJ-0007Hh-1y
	for gcvg-git@gmane.org; Fri, 15 Jun 2007 05:44:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754768AbXFODoF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Jun 2007 23:44:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754763AbXFODoE
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Jun 2007 23:44:04 -0400
Received: from godel.catalyst.net.nz ([202.78.240.40]:55629 "EHLO
	mail1.catalyst.net.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754761AbXFODoD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jun 2007 23:44:03 -0400
Received: from leibniz.catalyst.net.nz ([202.78.240.7] helo=localhost.localdomain)
	by mail1.catalyst.net.nz with esmtp (Exim 4.50)
	id 1Hz2jA-0007EC-0H; Fri, 15 Jun 2007 15:44:00 +1200
Received: by localhost.localdomain (Postfix, from userid 1000)
	id F0F83CB9E8; Fri, 15 Jun 2007 15:43:59 +1200 (NZST)
X-Mailer: git-send-email 1.5.2.0.45.gfea6d-dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50237>

You don't need to use string eval to define new functions; assigning a
code reference to the target symbol table is enough.
---
 git-svn.perl |   64 +++++++++++++++++++++++++++++----------------------------
 1 files changed, 33 insertions(+), 31 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index 4d35895..4ba0813 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -38,14 +38,16 @@ use IPC::Open3;
 use Git;
 
 BEGIN {
-	my $s;
+	# import functions from Git into our packages, en masse
+	no strict 'refs';
 	foreach (qw/command command_oneline command_noisy command_output_pipe
 	            command_input_pipe command_close_pipe/) {
-		$s .= "*SVN::Git::Editor::$_ = *SVN::Git::Fetcher::$_ = ".
-		      "*Git::SVN::Migration::$_ = ".
-		      "*Git::SVN::Log::$_ = *Git::SVN::$_ = *$_ = *Git::$_; ";
+		for my $package ( qw(SVN::Git::Editor SVN::Git::Fetcher
+			Git::SVN::Migration Git::SVN::Log Git::SVN),
+			__PACKAGE__) {
+			*{"${package}::$_"} = \&{"Git::$_"};
+		}
 	}
-	eval $s;
 }
 
 my ($SVN);
@@ -898,26 +900,26 @@ BEGIN {
 	# some options are read globally, but can be overridden locally
 	# per [svn-remote "..."] section.  Command-line options will *NOT*
 	# override options set in an [svn-remote "..."] section
-	my $e;
-	foreach (qw/follow_parent no_metadata use_svm_props
-	            use_svnsync_props/) {
-		my $key = $_;
+	no strict 'refs';
+	for my $option (qw/follow_parent no_metadata use_svm_props
+			   use_svnsync_props/) {
+		my $key = $option;
 		$key =~ tr/_//d;
-		$e .= "sub $_ {
-			my (\$self) = \@_;
-			return \$self->{-$_} if exists \$self->{-$_};
-			my \$k = \"svn-remote.\$self->{repo_id}\.$key\";
-			eval { command_oneline(qw/config --get/, \$k) };
-			if (\$@) {
-				\$self->{-$_} = \$Git::SVN::_$_;
+		my $prop = "-$option";
+		*$option = sub {
+			my ($self) = @_;
+			return $self->{$prop} if exists $self->{$prop};
+			my $k = "svn-remote.$self->{repo_id}.$key";
+			eval { command_oneline(qw/config --get/, $k) };
+			if ($@) {
+				$self->{$prop} = ${"Git::SVN::_$option"};
 			} else {
-				my \$v = command_oneline(qw/config --bool/,\$k);
-				\$self->{-$_} = \$v eq 'false' ? 0 : 1;
+				my $v = command_oneline(qw/config --bool/,$k);
+				$self->{$prop} = $v eq 'false' ? 0 : 1;
 			}
-			return \$self->{-$_} }\n";
+			return $self->{$prop};
+		}
 	}
-	$e .= "1;\n";
-	eval $e or die $@;
 }
 
 my %LOCKFILES;
@@ -2956,17 +2958,17 @@ my ($can_do_switch, %ignored_err, $RA);
 
 BEGIN {
 	# enforce temporary pool usage for some simple functions
-	my $e;
-	foreach (qw/rev_proplist get_latest_revnum get_uuid get_repos_root/) {
-		$e .= "sub $_ {
-			my \$self = shift;
-			my \$pool = SVN::Pool->new;
-			my \@ret = \$self->SUPER::$_(\@_,\$pool);
-			\$pool->clear;
-			wantarray ? \@ret : \$ret[0]; }\n";
+	no strict 'refs';
+	for my $f (qw/rev_proplist get_latest_revnum get_uuid get_repos_root/) {
+		my $SUPER = "SUPER::$f";
+		*$f = sub {
+			my $self = shift;
+			my $pool = SVN::Pool->new;
+			my @ret = $self->$SUPER(@_,$pool);
+			$pool->clear;
+			wantarray ? @ret : $ret[0];
+		};
 	}
-
-	eval "$e; 1;" or die $@;
 }
 
 sub new {
-- 
1.5.2.0.45.gfea6d-dirty
