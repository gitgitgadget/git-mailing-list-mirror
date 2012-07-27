From: "Michael G. Schwern" <schwern@pobox.com>
Subject: [PATCH 4/5] Change the rest of the code to use Git::SVN->path instead of the hash directly.
Date: Fri, 27 Jul 2012 13:00:51 -0700
Message-ID: <1343419252-9447-5-git-send-email-schwern@pobox.com>
References: <1343419252-9447-1-git-send-email-schwern@pobox.com>
Cc: robbat2@gentoo.org, bwalton@artsci.utoronto.ca,
	normalperson@yhbt.net, jrnieder@gmail.com, schwern@pobox.com
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Jul 27 22:01:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Suqj1-0003Oo-L6
	for gcvg-git-2@plane.gmane.org; Fri, 27 Jul 2012 22:01:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752768Ab2G0UBY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Jul 2012 16:01:24 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:61297 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752486Ab2G0UBW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jul 2012 16:01:22 -0400
Received: by yenl2 with SMTP id l2so3603915yen.19
        for <git@vger.kernel.org>; Fri, 27 Jul 2012 13:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=NAwb3VVpbb8MXoU0j8ghjB/zMrAofbqRK+cjxeJsoPg=;
        b=EfsxkF5yXmWI7/ObNtQewzZhgKTn6oAaOM94almIb5SpNf5L3Vj5eaSdL2HsX+L0wS
         VNu18Ex/HO8kMwALHcsT5KQJvFxAH5glVi4Uo5aUczpVZ4IPJlsNI9eWaeZP+i1qaG1I
         F3WqV7Z6dLkdPTZtZTDrKAxIC3Uf+xzV04hj4SNIO0s/2J8Nzb0FwBQKLsntwOervpT2
         D0PeKGpQOJcuEMWhEsN3ibvCD9LoFzUJzYpfS5nkbFt7mWE8pdPei67XgKoEiAgRzAeK
         GZINjOHUkEhOk1gH7UBb9AlE5zy3u9vHvP970oXtQUMhVwu64G9/LeE8h+vABHtlr1oL
         VSSA==
Received: by 10.66.77.71 with SMTP id q7mr8013154paw.0.1343419281088;
        Fri, 27 Jul 2012 13:01:21 -0700 (PDT)
Received: from windhund.local.net (c-71-236-173-173.hsd1.or.comcast.net. [71.236.173.173])
        by mx.google.com with ESMTPS id sk5sm2489907pbc.7.2012.07.27.13.01.19
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 27 Jul 2012 13:01:19 -0700 (PDT)
X-Mailer: git-send-email 1.7.11.3
In-Reply-To: <1343419252-9447-1-git-send-email-schwern@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202371>

From: "Michael G. Schwern" <schwern@pobox.com>

No functional change.
---
 git-svn.perl            | 12 +++++++-----
 perl/Git/SVN.pm         |  4 ++--
 perl/Git/SVN/Fetcher.pm |  2 +-
 perl/Git/SVN/Ra.pm      |  6 +++---
 4 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index 5711c57..039623e 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -1195,7 +1195,7 @@ sub cmd_show_ignore {
 	my ($url, $rev, $uuid, $gs) = working_head_info('HEAD');
 	$gs ||= Git::SVN->new;
 	my $r = (defined $_revision ? $_revision : $gs->ra->get_latest_revnum);
-	$gs->prop_walk($gs->{path}, $r, sub {
+	$gs->prop_walk($gs->path, $r, sub {
 		my ($gs, $path, $props) = @_;
 		print STDOUT "\n# $path\n";
 		my $s = $props->{'svn:ignore'} or return;
@@ -1211,7 +1211,7 @@ sub cmd_show_externals {
 	my ($url, $rev, $uuid, $gs) = working_head_info('HEAD');
 	$gs ||= Git::SVN->new;
 	my $r = (defined $_revision ? $_revision : $gs->ra->get_latest_revnum);
-	$gs->prop_walk($gs->{path}, $r, sub {
+	$gs->prop_walk($gs->path, $r, sub {
 		my ($gs, $path, $props) = @_;
 		print STDOUT "\n# $path\n";
 		my $s = $props->{'svn:externals'} or return;
@@ -1226,7 +1226,7 @@ sub cmd_create_ignore {
 	my ($url, $rev, $uuid, $gs) = working_head_info('HEAD');
 	$gs ||= Git::SVN->new;
 	my $r = (defined $_revision ? $_revision : $gs->ra->get_latest_revnum);
-	$gs->prop_walk($gs->{path}, $r, sub {
+	$gs->prop_walk($gs->path, $r, sub {
 		my ($gs, $path, $props) = @_;
 		# $path is of the form /path/to/dir/
 		$path = '.' . $path;
@@ -1396,7 +1396,7 @@ sub cmd_commit_diff {
 			      "the command-line\n", $usage);
 		}
 		$url = $gs->{url};
-		$svn_path = $gs->{path};
+		$svn_path = $gs->path;
 	}
 	unless (defined $_revision) {
 		fatal("-r|--revision is a required argument\n", $usage);
@@ -1634,6 +1634,8 @@ sub post_fetch_checkout {
 sub complete_svn_url {
 	my ($url, $path) = @_;
 	$path =~ s#/+$##;
+
+	# If the path is not a URL...
 	if ($path !~ m#^[a-z\+]+://#) {
 		if (!defined $url || $url !~ m#^[a-z\+]+://#) {
 			fatal("E: '$path' is not a complete URL ",
@@ -1670,7 +1672,7 @@ sub complete_url_ls_init {
 		    "wanted to set to: $gs->{url}\n";
 	}
 	command_oneline('config', $k, $gs->{url}) unless $orig_url;
-	my $remote_path = "$gs->{path}/$repo_path";
+	my $remote_path = $gs->path . "/$repo_path";
 	$remote_path =~ s{%([0-9A-F]{2})}{chr hex($1)}ieg;
 	$remote_path =~ s#/+#/#g;
 	$remote_path =~ s#^/##g;
diff --git a/perl/Git/SVN.pm b/perl/Git/SVN.pm
index 59bca51..fc907a0 100644
--- a/perl/Git/SVN.pm
+++ b/perl/Git/SVN.pm
@@ -1123,7 +1123,7 @@ sub find_parent_branch {
 			($base, $head) = parse_revision_argument(0, $r);
 		} else {
 			if ($r0 < $r) {
-				$gs->ra->get_log([$gs->{path}], $r0 + 1, $r, 1,
+				$gs->ra->get_log([$gs->path], $r0 + 1, $r, 1,
 					0, 1, sub { $base = $_[1] - 1 });
 			}
 		}
@@ -1145,7 +1145,7 @@ sub find_parent_branch {
 			# at the moment), so we can't rely on it
 			$self->{last_rev} = $r0;
 			$self->{last_commit} = $parent;
-			$ed = Git::SVN::Fetcher->new($self, $gs->{path});
+			$ed = Git::SVN::Fetcher->new($self, $gs->path);
 			$gs->ra->gs_do_switch($r0, $rev, $gs,
 					      $self->full_url, $ed)
 			  or die "SVN connection failed somewhere...\n";
diff --git a/perl/Git/SVN/Fetcher.pm b/perl/Git/SVN/Fetcher.pm
index 76fae9b..046a7a2 100644
--- a/perl/Git/SVN/Fetcher.pm
+++ b/perl/Git/SVN/Fetcher.pm
@@ -83,7 +83,7 @@ sub _mark_empty_symlinks {
 	chomp(my $empty_blob = `git hash-object -t blob --stdin < /dev/null`);
 	my ($ls, $ctx) = command_output_pipe(qw/ls-tree -r -z/, $cmt);
 	local $/ = "\0";
-	my $pfx = defined($switch_path) ? $switch_path : $git_svn->{path};
+	my $pfx = defined($switch_path) ? $switch_path : $git_svn->path;
 	$pfx .= '/' if length($pfx);
 	while (<$ls>) {
 		chomp;
diff --git a/perl/Git/SVN/Ra.pm b/perl/Git/SVN/Ra.pm
index 329f855..27dcdd5 100644
--- a/perl/Git/SVN/Ra.pm
+++ b/perl/Git/SVN/Ra.pm
@@ -264,7 +264,7 @@ sub get_commit_editor {
 sub gs_do_update {
 	my ($self, $rev_a, $rev_b, $gs, $editor) = @_;
 	my $new = ($rev_a == $rev_b);
-	my $path = $gs->{path};
+	my $path = $gs->path;
 
 	if ($new && -e $gs->{index}) {
 		unlink $gs->{index} or die
@@ -300,7 +300,7 @@ sub gs_do_update {
 # svn_ra_reparent didn't work before 1.4)
 sub gs_do_switch {
 	my ($self, $rev_a, $rev_b, $gs, $url_b, $editor) = @_;
-	my $path = $gs->{path};
+	my $path = $gs->path;
 	my $pool = SVN::Pool->new;
 
 	my $full_url = $self->url;
@@ -344,7 +344,7 @@ sub longest_common_path {
 	my $common_max = scalar @$gsv;
 
 	foreach my $gs (@$gsv) {
-		my @tmp = split m#/#, $gs->{path};
+		my @tmp = split m#/#, $gs->path;
 		my $p = '';
 		foreach (@tmp) {
 			$p .= length($p) ? "/$_" : $_;
-- 
1.7.11.3
