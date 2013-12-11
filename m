From: Krzesimir Nowak <krzesimir@endocode.com>
Subject: [PATCH v7 3/4] gitweb: Add a feature for adding more branch refs
Date: Wed, 11 Dec 2013 12:54:43 +0100
Message-ID: <1386762884-7564-4-git-send-email-krzesimir@endocode.com>
References: <1386762884-7564-1-git-send-email-krzesimir@endocode.com>
Cc: gitster@pobox.com, jnareb@gmail.com, sunshine@sunshineco.com,
	Krzesimir Nowak <krzesimir@endocode.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 11 12:55:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VqiOC-0003Hi-Gj
	for gcvg-git-2@plane.gmane.org; Wed, 11 Dec 2013 12:55:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751928Ab3LKLze (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Dec 2013 06:55:34 -0500
Received: from mail-ee0-f49.google.com ([74.125.83.49]:61070 "EHLO
	mail-ee0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751773Ab3LKLzY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Dec 2013 06:55:24 -0500
Received: by mail-ee0-f49.google.com with SMTP id c41so2837137eek.8
        for <git@vger.kernel.org>; Wed, 11 Dec 2013 03:55:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=pgP9Ct5L9a4ViffyOGqCo7DsjVMiujgbS8mP57zR7qE=;
        b=V/izNbDYsUqlkdTnaJe7dZySdcmt2FBiDyNuzxovhgmdknOKELjY61ujaEVBnQNclL
         xdh66i0Ilg7M5VFiRS2u631D4LsFQh92T7etT9QD1itg8veodfS0YXpsHG1+78f2q3YQ
         zpzhW0E4YSPDaZOcIOoTbqPrNz+gNnV4ssvTUD6XDmqr1fNjlpA8nhCeDGjUNqSQt0WO
         c3+8yJEWANyOzQgja7MM/wx6MjfzQvXdIbF94DOtqajVQbnjVQsJDoZGMXGrCVRd6W+f
         XSdaZCi0sCJgOMS7uoSfBn7CIFQdYwAfNk/+VGEG+adH4Rb72jSi0ppPed/adUjwSxl5
         ebmQ==
X-Gm-Message-State: ALoCoQlmrfcullJuIDFuME9wZSkVQtX7w2CHvC4f+QHmurEBti44S9nM0Ldi3l7NTVjt6PbZSeo1
X-Received: by 10.14.218.69 with SMTP id j45mr1509874eep.22.1386762923290;
        Wed, 11 Dec 2013 03:55:23 -0800 (PST)
Received: from localhost.home (95-91-241-58-dynip.superkabel.de. [95.91.241.58])
        by mx.google.com with ESMTPSA id z42sm52742677eeo.17.2013.12.11.03.55.21
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Dec 2013 03:55:22 -0800 (PST)
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1386762884-7564-1-git-send-email-krzesimir@endocode.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239191>

Allow extra-branch-refs feature to tell gitweb to show refs from
additional hierarchies in addition to branches in the list-of-branches
view.

Signed-off-by: Krzesimir Nowak <krzesimir@endocode.com>
---
 Documentation/gitweb.conf.txt | 37 ++++++++++++++++++++
 gitweb/gitweb.perl            | 80 ++++++++++++++++++++++++++++++++++++-------
 2 files changed, 105 insertions(+), 12 deletions(-)

diff --git a/Documentation/gitweb.conf.txt b/Documentation/gitweb.conf.txt
index e2113d9..db4154f 100644
--- a/Documentation/gitweb.conf.txt
+++ b/Documentation/gitweb.conf.txt
@@ -849,6 +849,43 @@ time zones in the form of "+/-HHMM", such as "+0200".
 +
 Project specific override is not supported.
 
+extra-branch-refs::
+	List of additional directories under "refs" which are going to
+	be used as branch refs. For example if you have a gerrit setup
+	where all branches under refs/heads/ are official,
+	push-after-review ones and branches under refs/sandbox/,
+	refs/wip and refs/other are user ones where permissions are
+	much wider, then you might want to set this variable as
+	follows:
++
+--------------------------------------------------------------------------------
+$feature{'extra-branch-refs'}{'default'} =
+	['sandbox', 'wip', 'other'];
+--------------------------------------------------------------------------------
++
+This feature can be configured on per-repository basis after setting
+$feature{'extra-branch-refs'}{'override'} to true, via repository's
+`gitweb.extraBranchRefs` configuration variable, which contains a
+space separated list of refs. An example:
++
+--------------------------------------------------------------------------------
+[gitweb]
+	extraBranchRefs = sandbox wip other
+--------------------------------------------------------------------------------
++
+The gitweb.extraBranchRefs is actually a multi-valued configuration
+variable, so following example is also correct and the result is the
+same as of the snippet above:
++
+--------------------------------------------------------------------------------
+[gitweb]
+	extraBranchRefs = sandbox
+	extraBranchRefs = wip other
+--------------------------------------------------------------------------------
++
+It is an error to specify a ref that does not pass "git check-ref-format"
+scrutiny. Duplicated values are filtered.
+
 
 EXAMPLES
 --------
diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index b5a8a36..222699a 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -548,6 +548,20 @@ our %feature = (
 		'sub' => sub { feature_bool('remote_heads', @_) },
 		'override' => 0,
 		'default' => [0]},
+
+	# Enable showing branches under other refs in addition to heads
+
+	# To set system wide extra branch refs have in $GITWEB_CONFIG
+	# $feature{'extra-branch-refs'}{'default'} = ['dirs', 'of', 'choice'];
+	# To have project specific config enable override in $GITWEB_CONFIG
+	# $feature{'extra-branch-refs'}{'override'} = 1;
+	# and in project config gitweb.extrabranchrefs = dirs of choice
+	# Every directory is separated with whitespace.
+
+	'extra-branch-refs' => {
+		'sub' => \&feature_extra_branch_refs,
+		'override' => 0,
+		'default' => []},
 );
 
 sub gitweb_get_feature {
@@ -626,6 +640,21 @@ sub feature_avatar {
 	return @val ? @val : @_;
 }
 
+sub feature_extra_branch_refs {
+	my (@branch_refs) = @_;
+	my $values = git_get_project_config('extrabranchrefs');
+
+	if ($values) {
+		$values = config_to_multi ($values);
+		@branch_refs = ();
+		foreach my $value (@{$values}) {
+			push @branch_refs, split /\s+/, $value;
+		}
+	}
+
+	return @branch_refs;
+}
+
 # checking HEAD file with -e is fragile if the repository was
 # initialized long time ago (i.e. symlink HEAD) and was pack-ref'ed
 # and then pruned.
@@ -656,6 +685,18 @@ sub filter_snapshot_fmts {
 		!$known_snapshot_formats{$_}{'disabled'}} @fmts;
 }
 
+sub filter_and_validate_refs {
+	my @refs = @_;
+	my %unique_refs = ();
+
+	foreach my $ref (@refs) {
+		die_error(500, "Invalid ref '$ref' in 'extra-branch-refs' feature") unless (is_valid_ref_format($ref));
+		# 'heads' are added implicitly in get_branch_refs().
+		$unique_refs{$ref} = 1 if ($ref ne 'heads');
+	}
+	return sort keys %unique_refs;
+}
+
 # If it is set to code reference, it is code that it is to be run once per
 # request, allowing updating configurations that change with each request,
 # while running other code in config file only once.
@@ -1113,7 +1154,7 @@ sub evaluate_git_dir {
 	our $git_dir = "$projectroot/$project" if $project;
 }
 
-our (@snapshot_fmts, $git_avatar);
+our (@snapshot_fmts, $git_avatar, @extra_branch_refs);
 sub configure_gitweb_features {
 	# list of supported snapshot formats
 	our @snapshot_fmts = gitweb_get_feature('snapshot');
@@ -1131,6 +1172,13 @@ sub configure_gitweb_features {
 	} else {
 		$git_avatar = '';
 	}
+
+	our @extra_branch_refs = gitweb_get_feature('extra-branch-refs');
+	@extra_branch_refs = filter_and_validate_refs (@extra_branch_refs);
+}
+
+sub get_branch_refs {
+	return ('heads', @extra_branch_refs);
 }
 
 # custom error handler: 'die <message>' is Internal Server Error
@@ -2527,6 +2575,7 @@ sub format_snapshot_links {
 sub get_feed_info {
 	my $format = shift || 'Atom';
 	my %res = (action => lc($format));
+	my $matched_ref = 0;
 
 	# feed links are possible only for project views
 	return unless (defined $project);
@@ -2534,12 +2583,17 @@ sub get_feed_info {
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
@@ -2552,7 +2606,7 @@ sub get_feed_info {
 	}
 
 	$res{-title} = $type;
-	$res{'hash'} = (defined $branch ? "refs/heads/$branch" : undef);
+	$res{'hash'} = (defined $branch ? "refs/$matched_ref/$branch" : undef);
 	$res{'file_name'} = $file_name;
 
 	return %res;
@@ -3205,7 +3259,7 @@ sub git_get_last_activity {
 	     '--format=%(committer)',
 	     '--sort=-committerdate',
 	     '--count=1',
-	     'refs/heads') or return;
+	     map { "refs/$_" } get_branch_refs ()) or return;
 	my $most_recent = <$fd>;
 	close $fd or return;
 	if (defined $most_recent &&
@@ -3656,7 +3710,7 @@ sub parse_from_to_diffinfo {
 
 sub git_get_heads_list {
 	my ($limit, @classes) = @_;
-	@classes = ('heads') unless @classes;
+	@classes = get_branch_refs() unless @classes;
 	my @patterns = map { "refs/$_" } @classes;
 	my @headslist;
 
@@ -3674,7 +3728,8 @@ sub git_get_heads_list {
 		my ($committer, $epoch, $tz) =
 			($committerinfo =~ /^(.*) ([0-9]+) (.*)$/);
 		$ref_item{'fullname'}  = $name;
-		$name =~ s!^refs/(?:head|remote)s/!!;
+		my $strip_refs = join '|', map { quotemeta } get_branch_refs();
+		$name =~ s!^refs/($strip_refs|remotes)/!!;
 
 		$ref_item{'name'}  = $name;
 		$ref_item{'id'}    = $hash;
@@ -7191,7 +7246,8 @@ sub snapshot_name {
 		$ver = $1;
 	} else {
 		# branches and other need shortened SHA-1 hash
-		if ($hash =~ m!^refs/(?:heads|remotes)/(.*)$!) {
+		my $strip_refs = join '|', map { quotemeta } get_branch_refs();
+		if ($hash =~ m!^refs/($strip_refs|remotes)/(.*)$!) {
 			$ver = $1;
 		}
 		$ver .= '-' . git_get_short_hash($project, $hash);
-- 
1.8.3.1
