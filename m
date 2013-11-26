From: Krzesimir Nowak <krzesimir@endocode.com>
Subject: [PATCH] gitweb: Add an option for adding more branch refs
Date: Tue, 26 Nov 2013 11:37:23 +0100
Message-ID: <1385462243-7898-1-git-send-email-krzesimir@endocode.com>
Cc: gitster@pobox.com, Krzesimir Nowak <krzesimir@endocode.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 26 11:38:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VlG2k-00042e-Pl
	for gcvg-git-2@plane.gmane.org; Tue, 26 Nov 2013 11:38:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755501Ab3KZKiy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Nov 2013 05:38:54 -0500
Received: from mail-bk0-f52.google.com ([209.85.214.52]:42887 "EHLO
	mail-bk0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755169Ab3KZKiy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Nov 2013 05:38:54 -0500
Received: by mail-bk0-f52.google.com with SMTP id u14so2463860bkz.39
        for <git@vger.kernel.org>; Tue, 26 Nov 2013 02:38:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=tuHYDXk+o/+Ou4wVz3zrWLBTbDveiLyzeJANBxNvJjs=;
        b=dKHIPmaB21pqd0wa7EBz3nE40Ed0eP8KNy+LoiUuCymONAYQ8N/6khk7Eh29JeyT6J
         QHYCW4vo5V9w6UqfVuLkqFVf8peL0Gzu2PASS60Z8fupx/0MTqf+MntLrjBSfYzuLlxC
         ogbexxZaNnxUORbjmvlQwEiAp9iq6/oS6QCI7RYJw5ISyWd2BKKtPrHGLBEN9gQgLcD7
         HO6OeObUYASVly/ck/z7CmuQCXnBHEfKG5/4J75owJlDRSPDl0HK2xmBonUKs8bGmMMf
         BOjzCzoMDTa+56PSrYLBcOmdLS01VUccPIn9aZBKyxQgNxWl6GmHnUmGcenNoPzkoxC6
         28Bg==
X-Gm-Message-State: ALoCoQmHiP9D6ocfzOOeELJJMXJyytMvDz84m1libOpoC10+GNJxznghMkPQEBJAtCgHF11qw4Xq
X-Received: by 10.205.78.199 with SMTP id zn7mr866775bkb.59.1385462332346;
        Tue, 26 Nov 2013 02:38:52 -0800 (PST)
Received: from localhost.home (95-91-241-34-dynip.superkabel.de. [95.91.241.34])
        by mx.google.com with ESMTPSA id zl3sm50442241bkb.4.2013.11.26.02.38.51
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Nov 2013 02:38:51 -0800 (PST)
X-Mailer: git-send-email 1.8.3.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238376>

Overriding an @additional_branch_refs configuration variable with
value ('wip') will make gitweb to show branches that appear in
refs/heads and refs/wip (refs/heads is hardcoded). Might be useful for
gerrit setups where user branches are not stored under refs/heads/.

Signed-off-by: Krzesimir Nowak <krzesimir@endocode.com>
---
 gitweb/gitweb.perl | 99 ++++++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 74 insertions(+), 25 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 68c77f6..9bfd38b 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -17,6 +17,7 @@ use Encode;
 use Fcntl ':mode';
 use File::Find qw();
 use File::Basename qw(basename);
+use List::Util qw(min);
 use Time::HiRes qw(gettimeofday tv_interval);
 binmode STDOUT, ':utf8';
 
@@ -122,6 +123,10 @@ our $logo_label = "git homepage";
 # source of projects list
 our $projects_list = "++GITWEB_LIST++";
 
+# list of additional "directories" under "refs/" we want to display as
+# branches
+our @additional_branch_refs = ();
+
 # the width (in characters) of the projects list "Description" column
 our $projects_list_description_width = 25;
 
@@ -626,14 +631,29 @@ sub feature_avatar {
 	return @val ? @val : @_;
 }
 
+sub get_branch_refs {
+    return ('heads', @additional_branch_refs);
+}
+
 # checking HEAD file with -e is fragile if the repository was
 # initialized long time ago (i.e. symlink HEAD) and was pack-ref'ed
 # and then pruned.
 sub check_head_link {
 	my ($dir) = @_;
 	my $headfile = "$dir/HEAD";
-	return ((-e $headfile) ||
-		(-l $headfile && readlink($headfile) =~ /^refs\/heads\//));
+
+	if (-e $headfile) {
+		return 1;
+	}
+	if (-l $headfile) {
+		my $rl = readlink($headfile);
+
+		for my $ref (get_branch_refs()) {
+			return 1 if $rl =~ /^refs\/$ref\//;
+		}
+	}
+
+	return 0;
 }
 
 sub check_export_ok {
@@ -2515,6 +2535,7 @@ sub format_snapshot_links {
 sub get_feed_info {
 	my $format = shift || 'Atom';
 	my %res = (action => lc($format));
+	my $matched_ref = 0;
 
 	# feed links are possible only for project views
 	return unless (defined $project);
@@ -2522,12 +2543,17 @@ sub get_feed_info {
 	# or don't have specific feed yet (so they should use generic)
 	return if (!$action || $action =~ /^(?:tags|heads|forks|tag|search)$/x);
 
-	my $branch;
-	# branches refs uses 'refs/heads/' prefix (fullname) to differentiate
-	# from tag links; this also makes possible to detect branch links
-	if ((defined $hash_base && $hash_base =~ m!^refs/heads/(.*)$!) ||
-	    (defined $hash      && $hash      =~ m!^refs/heads/(.*)$!)) {
-		$branch = $1;
+	my $branch = undef;
+	# branches refs uses 'refs/' + $get_branch_refs()[x] + '/' prefix
+	# (fullname) to differentiate from tag links; this also makes
+	# possible to detect branch links
+	for my $ref (get_branch_refs()) {
+		if ((defined $hash_base && $hash_base =~ m!^refs/$ref/(.*)$!) ||
+		    (defined $hash      && $hash      =~ m!^refs/$ref/(.*)$!)) {
+			$branch = $1;
+			$matched_ref = $ref;
+			last;
+		}
 	}
 	# find log type for feed description (title)
 	my $type = 'log';
@@ -2540,7 +2566,7 @@ sub get_feed_info {
 	}
 
 	$res{-title} = $type;
-	$res{'hash'} = (defined $branch ? "refs/heads/$branch" : undef);
+	$res{'hash'} = (defined $branch ? "refs/$matched_ref/$branch" : undef);
 	$res{'file_name'} = $file_name;
 
 	return %res;
@@ -3184,24 +3210,43 @@ sub git_get_project_owner {
 	return $owner;
 }
 
-sub git_get_last_activity {
-	my ($path) = @_;
-	my $fd;
+sub git_get_last_activity_age {
+	my ($refs) = @_;
+	my $fd = -1;
 
-	$git_dir = "$projectroot/$path";
 	open($fd, "-|", git_cmd(), 'for-each-ref',
 	     '--format=%(committer)',
 	     '--sort=-committerdate',
 	     '--count=1',
-	     'refs/heads') or return;
+	     $refs) or return undef;
+
 	my $most_recent = <$fd>;
-	close $fd or return;
+	close $fd or return undef;
 	if (defined $most_recent &&
 	    $most_recent =~ / (\d+) [-+][01]\d\d\d$/) {
 		my $timestamp = $1;
-		my $age = time - $timestamp;
-		return ($age, age_string($age));
+		return time - $timestamp;
 	}
+
+	return undef;
+}
+
+sub git_get_last_activity {
+	my ($path) = @_;
+	my @ages = ();
+
+	$git_dir = "$projectroot/$path";
+	for my $ref (get_branch_refs()) {
+		my $age = git_get_last_activity_age('refs/' . $_);
+
+		push @ages, $age if defined $age;
+	}
+	if (@ages) {
+		my $min_age = min(@ages);
+
+		return ($min_age, age_string($min_age));
+	}
+
 	return (undef, undef);
 }
 
@@ -3223,7 +3268,7 @@ sub git_get_remotes_list {
 		next if $wanted and not $remote eq $wanted;
 		my ($url, $key) = ($1, $2);
 
-		$remotes{$remote} ||= { 'heads' => () };
+		$remotes{$remote} ||= { map { $_ => () } get_branch_refs() };
 		$remotes{$remote}{$key} = $url;
 	}
 	close $fd or return;
@@ -3237,9 +3282,11 @@ sub fill_remote_heads {
 	my @heads = map { "remotes/$_" } keys %$remotes;
 	my @remoteheads = git_get_heads_list(undef, @heads);
 	foreach my $remote (keys %$remotes) {
-		$remotes->{$remote}{'heads'} = [ grep {
-			$_->{'name'} =~ s!^$remote/!!
-			} @remoteheads ];
+		foreach my $ref (get_branch_refs()) {
+			$remotes->{$remote}{$ref} = [ grep {
+				$_->{'name'} =~ s!^$remote/!!
+				} @remoteheads ];
+		}
 	}
 }
 
@@ -3644,7 +3691,7 @@ sub parse_from_to_diffinfo {
 
 sub git_get_heads_list {
 	my ($limit, @classes) = @_;
-	@classes = ('heads') unless @classes;
+	@classes = get_branch_refs() unless @classes;
 	my @patterns = map { "refs/$_" } @classes;
 	my @headslist;
 
@@ -3662,7 +3709,8 @@ sub git_get_heads_list {
 		my ($committer, $epoch, $tz) =
 			($committerinfo =~ /^(.*) ([0-9]+) (.*)$/);
 		$ref_item{'fullname'}  = $name;
-		$name =~ s!^refs/(?:head|remote)s/!!;
+		my $strip_refs = join '|', get_branch_refs();
+		$name =~ s!^refs/(?:$strip_refs|remotes)/!!;
 
 		$ref_item{'name'}  = $name;
 		$ref_item{'id'}    = $hash;
@@ -4286,7 +4334,7 @@ sub git_print_page_nav {
 # available if the feature is enabled
 sub format_ref_views {
 	my ($current) = @_;
-	my @ref_views = qw{tags heads};
+	my @ref_views = ('tags', get_branch_refs());
 	push @ref_views, 'remotes' if gitweb_check_feature('remote_heads');
 	return join " | ", map {
 		$_ eq $current ? $_ :
@@ -7179,7 +7227,8 @@ sub snapshot_name {
 		$ver = $1;
 	} else {
 		# branches and other need shortened SHA-1 hash
-		if ($hash =~ m!^refs/(?:heads|remotes)/(.*)$!) {
+		my $strip_refs = join '|', get_branch_refs();
+		if ($hash =~ m!^refs/(?:$strip_refs|remotes)/(.*)$!) {
 			$ver = $1;
 		}
 		$ver .= '-' . git_get_short_hash($project, $hash);
-- 
1.8.3.1
