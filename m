From: Steven Walter <stevenrwalter@gmail.com>
Subject: [PATCH 2/2] git-svn.perl: fix a false-positive in the "already exists" test
Date: Thu,  9 Feb 2012 13:55:25 -0500
Message-ID: <1328813725-16638-2-git-send-email-stevenrwalter@gmail.com>
References: <1328813725-16638-1-git-send-email-stevenrwalter@gmail.com>
Cc: Steven Walter <stevenrwalter@gmail.com>
To: normalperson@yhbt.net, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 09 19:55:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RvZ9c-00063E-MO
	for gcvg-git-2@plane.gmane.org; Thu, 09 Feb 2012 19:55:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754354Ab2BISzc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Feb 2012 13:55:32 -0500
Received: from mail-gy0-f174.google.com ([209.85.160.174]:34846 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752825Ab2BISzb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Feb 2012 13:55:31 -0500
Received: by ghrr11 with SMTP id r11so1064792ghr.19
        for <git@vger.kernel.org>; Thu, 09 Feb 2012 10:55:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=AfSFJvuhimOVzNiGx7B+dax9+yhpj83JKR6kkwU3nOs=;
        b=xkcGFPr6NrHAERVqDAGtDWKviKoH6UXHvQWYxzVN8KG+l3MNMpGW9QbC1DCAoyhs5X
         kMW0ZKFioxVDFQp764vC3hBoFNtc7RdVwoS30JQ7CnnwZaEnKs0hOFqc4sKSQDRexH7W
         6ZKiNAPHCGzkuJq5Hpoc0d9ctLjpZ9ihR7aoo=
Received: by 10.236.197.74 with SMTP id s50mr4233697yhn.127.1328813730667;
        Thu, 09 Feb 2012 10:55:30 -0800 (PST)
Received: from brock (adsl-184-43-8-254.bgk.bellsouth.net. [184.43.8.254])
        by mx.google.com with ESMTPS id o11sm7870267anl.11.2012.02.09.10.55.29
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 09 Feb 2012 10:55:30 -0800 (PST)
Received: from srwalter by brock with local (Exim 4.76)
	(envelope-from <srwalter@brock>)
	id 1RvZ9V-0004Kx-1j; Thu, 09 Feb 2012 13:55:29 -0500
X-Mailer: git-send-email 1.7.5.4
In-Reply-To: <1328813725-16638-1-git-send-email-stevenrwalter@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190304>

open_or_add_dir checks to see if the directory already exists or not.
If it already exists and is not a directory, then we fail.  However,
open_or_add_dir did not previously account for the possibility that the
path did exist as a file, but is deleted in the current commit.

In order to prevent this legitimate case from failing, open_or_add_dir
needs to know what files are deleted in the current commit.
Unfortunately that information has to be plumbed through a couple of
layers.
---
 git-svn.perl |   43 ++++++++++++++++++++++++++-----------------
 1 files changed, 26 insertions(+), 17 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index 520b02b..351e9e3 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -5147,7 +5147,7 @@ sub rmdirs {
 }
 
 sub open_or_add_dir {
-	my ($self, $full_path, $baton) = @_;
+	my ($self, $full_path, $baton, $deletions) = @_;
 	my $t = $self->{types}->{$full_path};
 	if (!defined $t) {
 		die "$full_path not known in r$self->{r} or we have a bug!\n";
@@ -5156,7 +5156,7 @@ sub open_or_add_dir {
 		no warnings 'once';
 		# SVN::Node::none and SVN::Node::file are used only once,
 		# so we're shutting up Perl's warnings about them.
-		if ($t == $SVN::Node::none) {
+		if ($t == $SVN::Node::none || defined($deletions->{$full_path})) {
 			return $self->add_directory($full_path, $baton,
 			    undef, -1, $self->{pool});
 		} elsif ($t == $SVN::Node::dir) {
@@ -5171,17 +5171,18 @@ sub open_or_add_dir {
 }
 
 sub ensure_path {
-	my ($self, $path) = @_;
+	my ($self, $path, $deletions) = @_;
 	my $bat = $self->{bat};
 	my $repo_path = $self->repo_path($path);
 	return $bat->{''} unless (length $repo_path);
+
 	my @p = split m#/+#, $repo_path;
 	my $c = shift @p;
-	$bat->{$c} ||= $self->open_or_add_dir($c, $bat->{''});
+	$bat->{$c} ||= $self->open_or_add_dir($c, $bat->{''}, $deletions);
 	while (@p) {
 		my $c0 = $c;
 		$c .= '/' . shift @p;
-		$bat->{$c} ||= $self->open_or_add_dir($c, $bat->{$c0});
+		$bat->{$c} ||= $self->open_or_add_dir($c, $bat->{$c0}, $deletions);
 	}
 	return $bat->{$c};
 }
@@ -5238,9 +5239,9 @@ sub apply_autoprops {
 }
 
 sub A {
-	my ($self, $m) = @_;
+	my ($self, $m, $deletions) = @_;
 	my ($dir, $file) = split_path($m->{file_b});
-	my $pbat = $self->ensure_path($dir);
+	my $pbat = $self->ensure_path($dir, $deletions);
 	my $fbat = $self->add_file($self->repo_path($m->{file_b}), $pbat,
 					undef, -1);
 	print "\tA\t$m->{file_b}\n" unless $::_q;
@@ -5250,9 +5251,9 @@ sub A {
 }
 
 sub C {
-	my ($self, $m) = @_;
+	my ($self, $m, $deletions) = @_;
 	my ($dir, $file) = split_path($m->{file_b});
-	my $pbat = $self->ensure_path($dir);
+	my $pbat = $self->ensure_path($dir, $deletions);
 	my $fbat = $self->add_file($self->repo_path($m->{file_b}), $pbat,
 				$self->url_path($m->{file_a}), $self->{r});
 	print "\tC\t$m->{file_a} => $m->{file_b}\n" unless $::_q;
@@ -5269,9 +5270,9 @@ sub delete_entry {
 }
 
 sub R {
-	my ($self, $m) = @_;
+	my ($self, $m, $deletions) = @_;
 	my ($dir, $file) = split_path($m->{file_b});
-	my $pbat = $self->ensure_path($dir);
+	my $pbat = $self->ensure_path($dir, $deletions);
 	my $fbat = $self->add_file($self->repo_path($m->{file_b}), $pbat,
 				$self->url_path($m->{file_a}), $self->{r});
 	print "\tR\t$m->{file_a} => $m->{file_b}\n" unless $::_q;
@@ -5280,14 +5281,14 @@ sub R {
 	$self->close_file($fbat,undef,$self->{pool});
 
 	($dir, $file) = split_path($m->{file_a});
-	$pbat = $self->ensure_path($dir);
+	$pbat = $self->ensure_path($dir, $deletions);
 	$self->delete_entry($m->{file_a}, $pbat);
 }
 
 sub M {
-	my ($self, $m) = @_;
+	my ($self, $m, $deletions) = @_;
 	my ($dir, $file) = split_path($m->{file_b});
-	my $pbat = $self->ensure_path($dir);
+	my $pbat = $self->ensure_path($dir, $deletions);
 	my $fbat = $self->open_file($self->repo_path($m->{file_b}),
 				$pbat,$self->{r},$self->{pool});
 	print "\t$m->{chg}\t$m->{file_b}\n" unless $::_q;
@@ -5357,9 +5358,9 @@ sub chg_file {
 }
 
 sub D {
-	my ($self, $m) = @_;
+	my ($self, $m, $deletions) = @_;
 	my ($dir, $file) = split_path($m->{file_b});
-	my $pbat = $self->ensure_path($dir);
+	my $pbat = $self->ensure_path($dir, $deletions);
 	print "\tD\t$m->{file_b}\n" unless $::_q;
 	$self->delete_entry($m->{file_b}, $pbat);
 }
@@ -5392,10 +5393,18 @@ sub apply_diff {
 	my ($self) = @_;
 	my $mods = $self->{mods};
 	my %o = ( D => -2, R => 0, C => -1, A => 3, M => 3, T => 3 );
+	my %deletions;
+
+	foreach my $m (@$mods) {
+		if ($m->{chg} eq "D") {
+			$deletions{$m->{file_b}} = 1;
+		}
+	}
+
 	foreach my $m (sort { $o{$a->{chg}} <=> $o{$b->{chg}} } @$mods) {
 		my $f = $m->{chg};
 		if (defined $o{$f}) {
-			$self->$f($m);
+			$self->$f($m, \%deletions);
 		} else {
 			fatal("Invalid change type: $f");
 		}
-- 
1.7.9.4.ge7a0d
