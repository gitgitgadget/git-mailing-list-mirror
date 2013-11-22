From: Krzesimir Nowak <krzesimir@endocode.com>
Subject: [PATCH] gitweb: Make showing branches configurable
Date: Fri, 22 Nov 2013 14:10:48 +0100
Message-ID: <1385125848-8243-1-git-send-email-krzesimir@endocode.com>
Cc: Krzesimir Nowak <krzesimir@endocode.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 22 14:11:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VjqVq-0006UD-UN
	for gcvg-git-2@plane.gmane.org; Fri, 22 Nov 2013 14:11:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755520Ab3KVNLG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Nov 2013 08:11:06 -0500
Received: from mail-bk0-f49.google.com ([209.85.214.49]:61274 "EHLO
	mail-bk0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755321Ab3KVNLE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Nov 2013 08:11:04 -0500
Received: by mail-bk0-f49.google.com with SMTP id my13so782072bkb.8
        for <git@vger.kernel.org>; Fri, 22 Nov 2013 05:11:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=8v4o9SYib6Y5xyFWWcIyhX7gVBFZThVKapQD9UsSjDc=;
        b=fuX/TTGc0wLdOyYXlNRq2BYqY6dKWTfhy8B+DjzhytOsJYxmN4gpjh3iDaBrHRli6z
         zmE0Wfl5gVZQa9ROWNlUJ0xHK1jDiC7WtKCMQop0mVFNSXD71b7Q+IbgDo40l+1GPR76
         xKywUJPHkWASfdpbk+LYNF4+NIEPqOcKUTY8/hLOTP2cMt0SMKfLphZncN79rLTXMOJw
         yzoiE8zxtUkrOJTBjZRXjeJzAr8a0lYj8b5ev2ac4ux9axNZq8uuzB+gSYzhLJnfNLZe
         kJ848PHUJniE13R0qW+IEhzl+lttNzxMUH+PX5otOc0bVMftGh1ZDk56ZR3is/aeSVjb
         ZeRA==
X-Gm-Message-State: ALoCoQlqY/6AKvsH/8eBJ7Xz+vJ6KEymXeypI5b7qDSpG/sCkJ5SFn6WMiOkmh6OW7nwtm+fs+c+
X-Received: by 10.204.117.3 with SMTP id o3mr1828761bkq.38.1385125862379;
        Fri, 22 Nov 2013 05:11:02 -0800 (PST)
Received: from localhost.localdomain (p57923128.dip0.t-ipconnect.de. [87.146.49.40])
        by mx.google.com with ESMTPSA id k9sm4280991bko.16.2013.11.22.05.11.01
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Nov 2013 05:11:01 -0800 (PST)
X-Mailer: git-send-email 1.8.3.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238185>

Running 'make GITWEB_WANTED_REFS="heads wip" gitweb.cgi' will create a
gitweb CGI script showing branches that appear in refs/heads/ and in
refs/wip/. Might be useful for gerrit setups where user branches are
not stored under refs/heads/.

Signed-off-by: Krzesimir Nowak <krzesimir@endocode.com>
---

Notes:
    I'm actually not sure if all those changes are really necessary as I
    was mostly targeting it for Gerrit use. Especially I mean the changes
    in git_get_remotes_list, fill_remote_heads and print_page_nav. I tried
    to make it as general as it gets, so there's nothing Gerrit specific.

 gitweb/Makefile    |  4 ++-
 gitweb/gitweb.perl | 94 +++++++++++++++++++++++++++++++++++++++---------------
 2 files changed, 72 insertions(+), 26 deletions(-)

diff --git a/gitweb/Makefile b/gitweb/Makefile
index cd194d0..361dce9 100644
--- a/gitweb/Makefile
+++ b/gitweb/Makefile
@@ -38,6 +38,7 @@ GITWEB_SITE_HTML_HEAD_STRING =
 GITWEB_SITE_HEADER =
 GITWEB_SITE_FOOTER =
 HIGHLIGHT_BIN = highlight
+GITWEB_WANTED_REFS = heads
 
 # include user config
 -include ../config.mak.autogen
@@ -148,7 +149,8 @@ GITWEB_REPLACE = \
 	-e 's|++GITWEB_SITE_HTML_HEAD_STRING++|$(GITWEB_SITE_HTML_HEAD_STRING)|g' \
 	-e 's|++GITWEB_SITE_HEADER++|$(GITWEB_SITE_HEADER)|g' \
 	-e 's|++GITWEB_SITE_FOOTER++|$(GITWEB_SITE_FOOTER)|g' \
-	-e 's|++HIGHLIGHT_BIN++|$(HIGHLIGHT_BIN)|g'
+	-e 's|++HIGHLIGHT_BIN++|$(HIGHLIGHT_BIN)|g' \
+	-e 's|++GITWEB_WANTED_REFS++|$(GITWEB_WANTED_REFS)|g'
 
 GITWEB-BUILD-OPTIONS: FORCE
 	@rm -f $@+
diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 68c77f6..8bc9e9a 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -17,6 +17,7 @@ use Encode;
 use Fcntl ':mode';
 use File::Find qw();
 use File::Basename qw(basename);
+use List::Util qw(min);
 use Time::HiRes qw(gettimeofday tv_interval);
 binmode STDOUT, ':utf8';
 
@@ -122,6 +123,9 @@ our $logo_label = "git homepage";
 # source of projects list
 our $projects_list = "++GITWEB_LIST++";
 
+# list of "directories" under "refs/" we want to display as branches
+our @wanted_refs = qw{++GITWEB_WANTED_REFS++};
+
 # the width (in characters) of the projects list "Description" column
 our $projects_list_description_width = 25;
 
@@ -632,8 +636,19 @@ sub feature_avatar {
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
+		for my $ref (@wanted_refs) {
+			return 1 if $rl =~ /^refs\/$ref\//;
+		}
+	}
+
+	return 0;
 }
 
 sub check_export_ok {
@@ -2515,6 +2530,7 @@ sub format_snapshot_links {
 sub get_feed_info {
 	my $format = shift || 'Atom';
 	my %res = (action => lc($format));
+	my $matched_ref = 0;
 
 	# feed links are possible only for project views
 	return unless (defined $project);
@@ -2522,12 +2538,17 @@ sub get_feed_info {
 	# or don't have specific feed yet (so they should use generic)
 	return if (!$action || $action =~ /^(?:tags|heads|forks|tag|search)$/x);
 
-	my $branch;
-	# branches refs uses 'refs/heads/' prefix (fullname) to differentiate
-	# from tag links; this also makes possible to detect branch links
-	if ((defined $hash_base && $hash_base =~ m!^refs/heads/(.*)$!) ||
-	    (defined $hash      && $hash      =~ m!^refs/heads/(.*)$!)) {
-		$branch = $1;
+	my $branch = undef;
+	# branches refs uses 'refs/' + $wanted_refs[x] + '/' prefix
+	# (fullname) to differentiate from tag links; this also makes
+	# possible to detect branch links
+	for my $ref (@wanted_refs) {
+		if ((defined $hash_base && $hash_base =~ m!^refs/$ref/(.*)$!) ||
+		    (defined $hash      && $hash      =~ m!^refs/$ref/(.*)$!)) {
+			$branch = $1;
+			$matched_ref = $ref;
+			last;
+		}
 	}
 	# find log type for feed description (title)
 	my $type = 'log';
@@ -2540,7 +2561,7 @@ sub get_feed_info {
 	}
 
 	$res{-title} = $type;
-	$res{'hash'} = (defined $branch ? "refs/heads/$branch" : undef);
+	$res{'hash'} = (defined $branch ? "refs/$matched_ref/$branch" : undef);
 	$res{'file_name'} = $file_name;
 
 	return %res;
@@ -3184,24 +3205,43 @@ sub git_get_project_owner {
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
+	}
+
+	return undef;
+}
+
+sub git_get_last_activity {
+	my ($path) = @_;
+	my @ages = ();
+
+	$git_dir = "$projectroot/$path";
+	for my $ref (@wanted_refs) {
+		my $age = git_get_last_activity_age('refs/' . $_);
+
+		push @ages, $age if defined $age;
 	}
+	if (@ages) {
+		my $min_age = min(@ages);
+
+		return ($min_age, age_string($min_age));
+	}
+
 	return (undef, undef);
 }
 
@@ -3223,7 +3263,7 @@ sub git_get_remotes_list {
 		next if $wanted and not $remote eq $wanted;
 		my ($url, $key) = ($1, $2);
 
-		$remotes{$remote} ||= { 'heads' => () };
+		$remotes{$remote} ||= { map { $_ => () } @wanted_refs };
 		$remotes{$remote}{$key} = $url;
 	}
 	close $fd or return;
@@ -3237,9 +3277,11 @@ sub fill_remote_heads {
 	my @heads = map { "remotes/$_" } keys %$remotes;
 	my @remoteheads = git_get_heads_list(undef, @heads);
 	foreach my $remote (keys %$remotes) {
-		$remotes->{$remote}{'heads'} = [ grep {
-			$_->{'name'} =~ s!^$remote/!!
-			} @remoteheads ];
+		foreach my $ref (@wanted_refs) {
+			$remotes->{$remote}{$ref} = [ grep {
+				$_->{'name'} =~ s!^$remote/!!
+				} @remoteheads ];
+		}
 	}
 }
 
@@ -3644,7 +3686,7 @@ sub parse_from_to_diffinfo {
 
 sub git_get_heads_list {
 	my ($limit, @classes) = @_;
-	@classes = ('heads') unless @classes;
+	@classes = @wanted_refs unless @classes;
 	my @patterns = map { "refs/$_" } @classes;
 	my @headslist;
 
@@ -3662,7 +3704,8 @@ sub git_get_heads_list {
 		my ($committer, $epoch, $tz) =
 			($committerinfo =~ /^(.*) ([0-9]+) (.*)$/);
 		$ref_item{'fullname'}  = $name;
-		$name =~ s!^refs/(?:head|remote)s/!!;
+		my $strip_refs = join '|', @wanted_refs;
+		$name =~ s!^refs/(?:$strip_refs|remotes)/!!;
 
 		$ref_item{'name'}  = $name;
 		$ref_item{'id'}    = $hash;
@@ -4286,7 +4329,7 @@ sub git_print_page_nav {
 # available if the feature is enabled
 sub format_ref_views {
 	my ($current) = @_;
-	my @ref_views = qw{tags heads};
+	my @ref_views = ("tags", @wanted_refs);
 	push @ref_views, 'remotes' if gitweb_check_feature('remote_heads');
 	return join " | ", map {
 		$_ eq $current ? $_ :
@@ -7179,7 +7222,8 @@ sub snapshot_name {
 		$ver = $1;
 	} else {
 		# branches and other need shortened SHA-1 hash
-		if ($hash =~ m!^refs/(?:heads|remotes)/(.*)$!) {
+		my $strip_refs = join '|', @wanted_refs;
+		if ($hash =~ m!^refs/(?:$strip_refs|remotes)/(.*)$!) {
 			$ver = $1;
 		}
 		$ver .= '-' . git_get_short_hash($project, $hash);
-- 
1.8.3.1
