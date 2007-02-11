From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] git-svn: re-map repository URLs and UUIDs on SVK mirror paths
Date: Sat, 10 Feb 2007 20:55:18 -0800
Message-ID: <20070211045518.GA20663@mayonaise.dyndns.org>
References: <20070210233750.A333013A384@magnus.utsl.gen.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Sam Vilain <sam@vilain.net>
X-From: git-owner@vger.kernel.org Sun Feb 11 05:55:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HG6kH-0000x3-7B
	for gcvg-git@gmane.org; Sun, 11 Feb 2007 05:55:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752722AbXBKEzV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 10 Feb 2007 23:55:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752718AbXBKEzV
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Feb 2007 23:55:21 -0500
Received: from hand.yhbt.net ([66.150.188.102]:55309 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752722AbXBKEzU (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Feb 2007 23:55:20 -0500
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id DB9667DC094;
	Sat, 10 Feb 2007 20:55:18 -0800 (PST)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Sat, 10 Feb 2007 20:55:18 -0800
Content-Disposition: inline
In-Reply-To: <20070210233750.A333013A384@magnus.utsl.gen.nz>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39271>

Note: these patches (both Sam's and mine below) are not meant for
master, but the development/semi-rewrite version of git-svn at
http://git.bogomips.org/git-svn.git

Sam: here's my take on your patches.  I'll add support for
per-[svn-remote "..."] configuration that we talked about
on IRC in a separate patch.

>From 45fd937a6129aebc9cad1b7128f2811dd32af454 Mon Sep 17 00:00:00 2001
From: Eric Wong <normalperson@yhbt.net>
Date: Sat, 10 Feb 2007 20:46:50 -0800
Subject: [PATCH] git-svn: add support for SVN::Mirror/svk using revprops for metadata

Pass --use-svm-props or set the svn.usesvmprops key with git-config
to enable using properties set by SVN::Mirror when it mirrored the
upstream URL.

This is heavily based on work from Sam Vilain:
> From: Sam Vilain <sam@vilain.net>
> Date: Sun, 11 Feb 2007 12:34:45 +1300
> Subject: [PATCH] git-svn: re-map repository URLs and UUIDs on SVK mirror paths
>
> If an SVN revision has a property, "svm:headrev", it is likely that
> the revision was created by SVN::Mirror (a part of SVK).  The property
> contains a repository UUID and a revision.  We want to make it look
> like we are mirroring the original URL, so introduce a helper function
> that returns the original identity URL and UUID, and use it when
> generating commit messages.

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---
 git-svn.perl |  115 +++++++++++++++++++++++++++++++++++++++++++++++++++++-----
 1 files changed, 105 insertions(+), 10 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index 7e1a655..23e1d42 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -64,6 +64,7 @@ my %fc_opts = ( 'follow-parent|follow!' => \$Git::SVN::_follow_parent,
 		'authors-file|A=s' => \$_authors,
 		'repack:i' => \$Git::SVN::_repack,
 		'no-metadata' => \$Git::SVN::_no_metadata,
+		'use-svm-props|svm-props' => \$Git::SVN::_use_svm_props,
 		'quiet|q' => \$_q,
 		'repack-flags|repack-args|repack-opts=s' =>
 		   \$Git::SVN::_repack_flags,
@@ -645,7 +646,7 @@ package Git::SVN;
 use strict;
 use warnings;
 use vars qw/$default_repo_id $default_ref_id $_no_metadata $_follow_parent
-            $_repack $_repack_flags/;
+            $_repack $_repack_flags $_use_svm_props/;
 use Carp qw/croak/;
 use File::Path qw/mkpath/;
 use File::Copy qw/copy/;
@@ -920,9 +921,54 @@ sub new {
 
 sub refname { "refs/remotes/$_[0]->{ref_id}" }
 
+sub set_svm_vars {
+	my ($self, $ra) = @_;
+	my $section = "svn-remote.$self->{repo_id}";
+
+	# see if we have it in our config, first:
+	eval {
+		$self->{svm} = {
+		  source => $self->tmp_config('--get', "$section.svm-source"),
+		  uuid => $self->tmp_config('--get', "$section.svm-uuid"),
+		}
+	};
+	return $ra if ($self->{svm}->{source} && $self->{svm}->{uuid});
+
+	# nope, make sure we're connected to the repository root:
+	if ($ra->{repos_root} ne $self->{url}) {
+		$ra = Git::SVN::Ra->new($ra->{repos_root});
+	}
+	my $r = $ra->get_latest_revnum;
+	my ($props) = ($ra->get_dir('', $r))[2];
+	if (my $src = $props->{'svm:source'}) {
+		# don't know what a '!' is there for, also the
+		# username is of no interest
+		$src =~ s{!$}{};
+		$src =~ s{(^[a-z\+]*://)[^/@]*@}{$1};
+		$self->tmp_config('--add', "$section.svm-source", $src);
+
+		my $uuid = $props->{'svm:uuid'};
+		$uuid =~ m{^[0-9a-f\-]{30,}$}
+		    or die "doesn't look right - svm:uuid is '$uuid'\n";
+		$self->tmp_config('--add', "$section.svm-uuid", $uuid);
+
+		$self->{svm} = { source => $src , uuid => $uuid };
+	}
+	if ($ra->{repos_root} ne $self->{url}) {
+		$ra = Git::SVN::Ra->new($self->{url});
+	}
+	$ra;
+}
+
 sub ra {
 	my ($self) = shift;
-	Git::SVN::Ra->new($self->{url});
+	my $ra = Git::SVN::Ra->new($self->{url});
+	$self->{-use_svm_props} = $Git::SVN::_use_svm_props;
+	if ($self->{-use_svm_props} && !$self->{svm}) {
+		$ra = $self->set_svm_vars($ra);
+		$self->{-want_revprops} = 1;
+	}
+	$ra;
 }
 
 sub rel_path {
@@ -1006,16 +1052,44 @@ sub get_fetch_range {
 	(++$min, $max);
 }
 
+sub tmp_config {
+	my ($self, @args) = @_;
+	unless (-f $self->{config}) {
+		open my $fh, '>', $self->{config} or
+		    die "Can't open $self->{config}: $!\n";
+		print $fh "; This file is used internally by git-svn\n" or
+		      die "Couldn't write to $self->{config}: $!\n";
+		print $fh "; You should not have to edit it\n" or
+		      die "Couldn't write to $self->{config}: $!\n";
+		close $fh or die "Couldn't close $self->{config}: $!\n";
+	}
+	my $old_config = $ENV{GIT_CONFIG};
+	$ENV{GIT_CONFIG} = $self->{config};
+	$@ = undef;
+	my @ret = eval { command('config', @args) };
+	my $err = $@;
+	if (defined $old_config) {
+		$ENV{GIT_CONFIG} = $old_config;
+	} else {
+		delete $ENV{GIT_CONFIG};
+	}
+	die $err if $err;
+	wantarray ? @ret : $ret[0];
+}
+
 sub tmp_index_do {
 	my ($self, $sub) = @_;
 	my $old_index = $ENV{GIT_INDEX_FILE};
 	$ENV{GIT_INDEX_FILE} = $self->{index};
-	my @ret = &$sub;
-	if ($old_index) {
+	$@ = undef;
+	my @ret = eval { &$sub };
+	my $err = $@;
+	if (defined $old_index) {
 		$ENV{GIT_INDEX_FILE} = $old_index;
 	} else {
 		delete $ENV{GIT_INDEX_FILE};
 	}
+	die $err if $err;
 	wantarray ? @ret : $ret[0];
 }
 
@@ -1105,9 +1179,8 @@ sub do_git_commit {
 	                                                           or croak $!;
 	print $msg_fh $log_entry->{log} or croak $!;
 	unless ($_no_metadata) {
-		print $msg_fh "\ngit-svn-id: ", $self->full_url, '@',
-		              $log_entry->{revision}, ' ',
-		              $self->ra->uuid, "\n" or croak $!;
+		print $msg_fh "\ngit-svn-id: $log_entry->{metadata}\n"
+		              or croak $!;
 	}
 	$msg_fh->flush == 0 or croak $!;
 	close $msg_fh or croak $!;
@@ -1123,7 +1196,11 @@ sub do_git_commit {
 
 	$self->{last_rev} = $log_entry->{revision};
 	$self->{last_commit} = $commit;
-	print "r$log_entry->{revision} = $commit ($self->{ref_id})\n";
+	print "r$log_entry->{revision}";
+	if (defined $log_entry->{svm_revision}) {
+		 print " (\@$log_entry->{svm_revision})";
+	}
+	print " = $commit ($self->{ref_id})\n";
 	if (defined $_repack && (--$_repack_nr == 0)) {
 		$_repack_nr = $_repack;
 		# repack doesn't use any arguments with spaces in them, does it?
@@ -1351,13 +1428,16 @@ sub make_log_entry {
 	my %log_entry = ( parents => $parents || [], revision => $rev,
 	                  log => '');
 
+	my $headrev;
 	my $logged = delete $self->{logged_rev_props};
-	if (!$logged || $self->{-want_extra_revprops}) {
+	if (!$logged || $self->{-want_revprops}) {
 		my $rp = $self->ra->rev_proplist($rev);
 		foreach (sort keys %$rp) {
 			my $v = $rp->{$_};
 			if (/^svn:(author|date|log)$/) {
 				$log_entry{$1} = $v;
+			} elsif ($_ eq 'svm:headrev') {
+				$headrev = $v;
 			} else {
 				print $un "  rev_prop: ", uri_encode($_), ' ',
 					  uri_encode($v), "\n";
@@ -1371,6 +1451,21 @@ sub make_log_entry {
 	$log_entry{date} = parse_svn_date($log_entry{date});
 	$log_entry{author} = check_author($log_entry{author});
 	$log_entry{log} .= "\n";
+	if (defined $headrev && $self->{-use_svm_props}) {
+		my ($uuid, $r) = $headrev =~ m{^([a-f\d\-]{30,}):(\d+)$};
+		if ($uuid ne $self->{svm}->{uuid}) {
+			die "UUID mismatch on SVM path:\n",
+			    "expected: $self->{svm}->{uuid}\n",
+			    "     got: $uuid\n";
+		}
+		my $full_url = $self->{svm}->{source};
+		$full_url .= "/$self->{path}" if length $self->{path};
+		$log_entry{metadata} = "$full_url\@$r $uuid";
+		$log_entry{svm_revision} = $r;
+	} else {
+		$log_entry{metadata} = $self->full_url . "\@$rev " .
+		                       $self->ra->uuid;
+	}
 	\%log_entry;
 }
 
@@ -1549,7 +1644,7 @@ sub _new {
 		close $fh or croak $!;
 	}
 	bless { ref_id => $ref_id, dir => $dir, index => "$dir/index",
-	        path => $path,
+	        path => $path, config => "$ENV{GIT_DIR}/svn/config",
 	        db_path => "$dir/.rev_db", repo_id => $repo_id }, $class;
 }
 
-- 
1.5.0.rc4.104.g9cd7c


-- 
Eric Wong
