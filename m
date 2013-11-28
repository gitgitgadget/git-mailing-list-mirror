From: Krzesimir Nowak <krzesimir@endocode.com>
Subject: [PATCH v3] gitweb: Add an option for adding more branch refs
Date: Thu, 28 Nov 2013 12:44:52 +0100
Message-ID: <1385639092-13362-1-git-send-email-krzesimir@endocode.com>
Cc: gitster@pobox.com, sunshine@sunshineco.com, jnareb@gmail.com,
	Krzesimir Nowak <krzesimir@endocode.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 28 12:49:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vm05g-0004dG-0n
	for gcvg-git-2@plane.gmane.org; Thu, 28 Nov 2013 12:49:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758687Ab3K1Ls6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Nov 2013 06:48:58 -0500
Received: from mail-bk0-f53.google.com ([209.85.214.53]:63031 "EHLO
	mail-bk0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758587Ab3K1Ls4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Nov 2013 06:48:56 -0500
Received: by mail-bk0-f53.google.com with SMTP id na10so3712330bkb.40
        for <git@vger.kernel.org>; Thu, 28 Nov 2013 03:48:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=2RrEFwGD8v4wwIn1vyLyanrBFQDlD7W6mHOQrY4byCg=;
        b=JVuYwuNQb7gTvAqLCPKSdwvzdhz0/jHiPzdiVvRsHXcJNP/SFnkzEDKn/v4rrzuSGh
         DyVYC0IbdMSH19uGH+kXPU2ljWHtAGUec1H/w4pvhr+MVUUnvGT4I/ihBAjvVfMvafnv
         XbiSQ79NbPwv08qKE4TN8QUZoPDTXZZgeOZEPwJiw5Ey+OVWb773UdwzDVIMhIl3SgfZ
         AO8Jeub2iSTtGkhbNALxEvUgwtDz7KnADu8o3fG6KWwtkNayKGEAgzAFZHzLyJ28SwoP
         it+chgBkXMPaXujen5WELxG9yA+4WxE2wW4rkntNNSNiljKLPwC1KuOqKZHioHo+IEcB
         iV1A==
X-Gm-Message-State: ALoCoQlkpx17Ovs+fVVbWBoe6TkN1wVcSspr7yeCZa9wBEwxmuxfodkeYImGZReerUGp+FDz0qD4
X-Received: by 10.204.102.201 with SMTP id h9mr24601bko.123.1385639334672;
        Thu, 28 Nov 2013 03:48:54 -0800 (PST)
Received: from localhost.home (95-91-241-33-dynip.superkabel.de. [95.91.241.33])
        by mx.google.com with ESMTPSA id bf8sm11095170bkb.14.2013.11.28.03.48.53
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Nov 2013 03:48:53 -0800 (PST)
X-Mailer: git-send-email 1.8.3.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238492>

Allow @additional_branch_refs configuration variable to tell gitweb to
show refs from additional hierarchies in addition to branches in the
list-of-branches view.

Signed-off-by: Krzesimir Nowak <krzesimir@endocode.com>
---
 Documentation/gitweb.conf.txt | 13 ++++++++
 gitweb/gitweb.perl            | 75 +++++++++++++++++++++++++++++++++----------
 2 files changed, 71 insertions(+), 17 deletions(-)

diff --git a/Documentation/gitweb.conf.txt b/Documentation/gitweb.conf.txt
index e2113d9..cd1a945 100644
--- a/Documentation/gitweb.conf.txt
+++ b/Documentation/gitweb.conf.txt
@@ -549,6 +549,19 @@ This variable matters only when using persistent web environments that
 serve multiple requests using single gitweb instance, like mod_perl,
 FastCGI or Plackup.
 
+@additional_branch_refs::
+	List of additional directories under "refs" which are going to be used
+	as branch refs. You might want to set this variable if you have a gerrit
+	setup where all branches under refs/heads/ are official,
+	push-after-review ones and branches under refs/sandbox/, refs/wip and
+	refs/other are user ones where permissions are much wider, for example
++
+--------------------------------------------------------------------------------
+our @additional_branch_refs = ('sandbox', 'wip', 'other');
+--------------------------------------------------------------------------------
++
+It is an error to specify a ref that does not pass "git check-ref-format"
+scrutiny.
 
 Other variables
 ~~~~~~~~~~~~~~~
diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 68c77f6..25e1d37 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -122,6 +122,10 @@ our $logo_label = "git homepage";
 # source of projects list
 our $projects_list = "++GITWEB_LIST++";
 
+# list of additional "directories" under "refs/" we want to display as
+# branches
+our @additional_branch_refs = ();
+
 # the width (in characters) of the projects list "Description" column
 our $projects_list_description_width = 25;
 
@@ -626,6 +630,10 @@ sub feature_avatar {
 	return @val ? @val : @_;
 }
 
+sub get_branch_refs {
+    return ('heads', @additional_branch_refs);
+}
+
 # checking HEAD file with -e is fragile if the repository was
 # initialized long time ago (i.e. symlink HEAD) and was pack-ref'ed
 # and then pruned.
@@ -680,6 +688,19 @@ sub read_config_file {
 	return;
 }
 
+# performs sanity checks on parts of configuration.
+sub config_sanity_check {
+	# check additional refs validity
+	my %unique_branch_refs = ();
+	for my $ref (@additional_branch_refs) {
+		die_error(500, "Invalid ref '$ref' in \@additional_branch_refs") unless (validate_ref($ref));
+		# 'heads' are added implicitly in get_branch_refs().
+		$unique_branch_refs{$ref} = 1 if ($ref ne 'heads');
+	}
+	@additional_branch_refs = sort keys %unique_branch_refs;
+	%unique_branch_refs = undef;
+}
+
 our ($GITWEB_CONFIG, $GITWEB_CONFIG_SYSTEM, $GITWEB_CONFIG_COMMON);
 sub evaluate_gitweb_config {
 	our $GITWEB_CONFIG = $ENV{'GITWEB_CONFIG'} || "++GITWEB_CONFIG++";
@@ -698,8 +719,11 @@ sub evaluate_gitweb_config {
 
 	# Use first config file that exists.  This means use the per-instance
 	# GITWEB_CONFIG if exists, otherwise use GITWEB_SYSTEM_CONFIG.
-	read_config_file($GITWEB_CONFIG) and return;
-	read_config_file($GITWEB_CONFIG_SYSTEM);
+	if (!read_config_file($GITWEB_CONFIG)) {
+		read_config_file($GITWEB_CONFIG_SYSTEM);
+	}
+
+	config_sanity_check();
 }
 
 # Get loadavg of system, to compare against $maxload.
@@ -1452,6 +1476,16 @@ sub validate_pathname {
 	return $input;
 }
 
+sub validate_ref {
+	my $input = shift || return undef;
+
+	# restrictions on ref name according to git-check-ref-format
+	if ($input =~ m!(/\.|\.\.|[\000-\040\177 ~^:?*\[]|/$)!) {
+		return undef;
+	}
+	return $input;
+}
+
 sub validate_refname {
 	my $input = shift || return undef;
 
@@ -1462,10 +1496,9 @@ sub validate_refname {
 	# it must be correct pathname
 	$input = validate_pathname($input)
 		or return undef;
-	# restrictions on ref name according to git-check-ref-format
-	if ($input =~ m!(/\.|\.\.|[\000-\040\177 ~^:?*\[]|/$)!) {
-		return undef;
-	}
+	# check git-check-ref-format restrictions
+	$input = validate_ref($input)
+		or return undef;
 	return $input;
 }
 
@@ -2515,6 +2548,7 @@ sub format_snapshot_links {
 sub get_feed_info {
 	my $format = shift || 'Atom';
 	my %res = (action => lc($format));
+	my $matched_ref = 0;
 
 	# feed links are possible only for project views
 	return unless (defined $project);
@@ -2522,12 +2556,17 @@ sub get_feed_info {
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
+		if ((defined $hash_base && $hash_base =~ m!^refs/\Q$ref\E/(.*)$!) ||
+		    (defined $hash      && $hash      =~ m!^refs/\Q$ref\E/(.*)$!)) {
+			$branch = $1;
+			$matched_ref = $ref;
+			last;
+		}
 	}
 	# find log type for feed description (title)
 	my $type = 'log';
@@ -2540,7 +2579,7 @@ sub get_feed_info {
 	}
 
 	$res{-title} = $type;
-	$res{'hash'} = (defined $branch ? "refs/heads/$branch" : undef);
+	$res{'hash'} = (defined $branch ? "refs/$matched_ref/$branch" : undef);
 	$res{'file_name'} = $file_name;
 
 	return %res;
@@ -3193,7 +3232,7 @@ sub git_get_last_activity {
 	     '--format=%(committer)',
 	     '--sort=-committerdate',
 	     '--count=1',
-	     'refs/heads') or return;
+	     map { "refs/$_" } get_branch_refs ()) or return;
 	my $most_recent = <$fd>;
 	close $fd or return;
 	if (defined $most_recent &&
@@ -3644,7 +3683,7 @@ sub parse_from_to_diffinfo {
 
 sub git_get_heads_list {
 	my ($limit, @classes) = @_;
-	@classes = ('heads') unless @classes;
+	@classes = get_branch_refs() unless @classes;
 	my @patterns = map { "refs/$_" } @classes;
 	my @headslist;
 
@@ -3662,7 +3701,8 @@ sub git_get_heads_list {
 		my ($committer, $epoch, $tz) =
 			($committerinfo =~ /^(.*) ([0-9]+) (.*)$/);
 		$ref_item{'fullname'}  = $name;
-		$name =~ s!^refs/(?:head|remote)s/!!;
+		my $strip_refs = join '|', map { quotemeta } get_branch_refs();
+		$name =~ s!^refs/(?:$strip_refs|remotes)/!!;
 
 		$ref_item{'name'}  = $name;
 		$ref_item{'id'}    = $hash;
@@ -7179,7 +7219,8 @@ sub snapshot_name {
 		$ver = $1;
 	} else {
 		# branches and other need shortened SHA-1 hash
-		if ($hash =~ m!^refs/(?:heads|remotes)/(.*)$!) {
+		my $strip_refs = join '|', map { quotemeta } get_branch_refs();
+		if ($hash =~ m!^refs/(?:$strip_refs|remotes)/(.*)$!) {
 			$ver = $1;
 		}
 		$ver .= '-' . git_get_short_hash($project, $hash);
-- 
1.8.3.1
