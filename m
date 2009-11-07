From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCHv7 3/3] gitweb: Smarter snapshot names
Date: Sat,  7 Nov 2009 16:13:29 +0100
Message-ID: <1257606809-23287-4-git-send-email-jnareb@gmail.com>
References: <1257606809-23287-1-git-send-email-jnareb@gmail.com>
Cc: Mark Rada <marada@uwaterloo.ca>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 07 16:14:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N6mzK-0000cF-Pg
	for gcvg-git-2@lo.gmane.org; Sat, 07 Nov 2009 16:14:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752110AbZKGPNm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Nov 2009 10:13:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752107AbZKGPNm
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Nov 2009 10:13:42 -0500
Received: from mail-bw0-f227.google.com ([209.85.218.227]:54017 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752094AbZKGPNl (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Nov 2009 10:13:41 -0500
Received: by mail-bw0-f227.google.com with SMTP id 27so2098717bwz.21
        for <git@vger.kernel.org>; Sat, 07 Nov 2009 07:13:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:from:to:cc
         :subject:date:message-id:x-mailer:in-reply-to:references;
        bh=RIoKbIqfaFcatljOTylPoX12Ol9FkIMQNhgzcWN6/rw=;
        b=cdHAUKpg/9fzYdPo1eV81k7p3Ba1m3Ir1kA9dv0gJ21O+7uGjdTViImvzoD0vu4X77
         57rOI9o717PnzxkuG5JnwRHXhOXoMKLUD7vSpgsKjelGnDMtAb3C182ZZbGg1n6IxEml
         MRtfhBBJOD4t0ZqphqbYHdsWJzuhPG6Mzucjc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=lUVfCi5K5Fz4JSTFAKfR7YOLSMe+VJlNDvlBUxI88p1DvMA7o+5US7snF0LhBGMomx
         Sk0a7BydeaGtZSg2yu5KT85ziJXPC00bhIGGVLINAxoeO/pDAJajREcKlMeGnjCA44lF
         CQCgHmgeWIJOzcbmWvGea6sDk17YhxUCpVK6g=
Received: by 10.204.155.73 with SMTP id r9mr6001820bkw.14.1257606826530;
        Sat, 07 Nov 2009 07:13:46 -0800 (PST)
Received: from localhost.localdomain (abuz230.neoplus.adsl.tpnet.pl [83.8.197.230])
        by mx.google.com with ESMTPS id 14sm328096fxm.3.2009.11.07.07.13.44
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 07 Nov 2009 07:13:45 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id nA7FDhRd023342;
	Sat, 7 Nov 2009 16:13:43 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id nA7FDbJa023329;
	Sat, 7 Nov 2009 16:13:37 +0100
X-Mailer: git-send-email 1.6.5
In-Reply-To: <1257606809-23287-1-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132367>

From: Mark Rada <marada@uwaterloo.ca>

Teach gitweb how to produce nicer snapshot names by only using the
short hash id.  If clients make requests using a tree-ish that is not
a partial or full SHA-1 hash, then the short hash will also be appended
to whatever they asked for.  If clients request snapshot of a tag
(which means that $hash ('h') parameter has 'refs/tags/' prefix),
use only tag name.

Update tests cases in t9502-gitweb-standalone-parse-output.

Gitweb uses the following format for snapshot filenames:
  <sanitized project name>-<version info>.<snapshot suffix>
where <sanitized project name> is project name with '.git' or '/.git'
suffix stripped, unless '.git' is the whole project name.  For
snapshot prefix it uses:
  <sanitized project name>-<version info>/
as compared to <sanitized project name>/ before (without version info).

Current rules for <version info>:
* if 'h' / $hash parameter is SHA-1 or shortened SHA-1, use SHA-1
  shortened to to 7 characters
* otherwise if 'h' / $hash parameter is tag name (it begins with
  'refs/tags/' prefix, use tag name (with 'refs/tags/' stripped
* otherwise if 'h' / $hash parameter starts with 'refs/heads/' prefix,
  strip this prefix, convert '/' into '.', and append shortened SHA-1
  after '-', i.e. use <sanitized hash>-<shortened sha1>

Signed-off-by: Mark Rada <marada@uwaterloo.ca>
Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
Changes since v6:
- use check_snapshot function to test snapshots; therefore separate
  test checking archive prefix is not needed any more
- fixed checking that hierarchical branch names work correctly

 gitweb/gitweb.perl                        |   76 +++++++++++++++++++++++------
 t/t9502-gitweb-standalone-parse-output.sh |   38 ++++++++++++--
 2 files changed, 93 insertions(+), 21 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 8d4a2ae..d8dfd95 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -1983,16 +1983,27 @@ sub quote_command {
 
 # get HEAD ref of given project as hash
 sub git_get_head_hash {
-	my $project = shift;
+	return git_get_full_hash(shift, 'HEAD');
+}
+
+sub git_get_full_hash {
+	return git_get_hash(@_);
+}
+
+sub git_get_short_hash {
+	return git_get_hash(@_, '--short=7');
+}
+
+sub git_get_hash {
+	my ($project, $hash, @options) = @_;
 	my $o_git_dir = $git_dir;
 	my $retval = undef;
 	$git_dir = "$projectroot/$project";
-	if (open my $fd, "-|", git_cmd(), "rev-parse", "--verify", "HEAD") {
-		my $head = <$fd>;
+	if (open my $fd, '-|', git_cmd(), 'rev-parse',
+	    '--verify', '-q', @options, $hash) {
+		$retval = <$fd>;
+		chomp $retval if defined $retval;
 		close $fd;
-		if (defined $head && $head =~ /^([0-9a-fA-F]{40})$/) {
-			$retval = $1;
-		}
 	}
 	if (defined $o_git_dir) {
 		$git_dir = $o_git_dir;
@@ -5179,6 +5190,43 @@ sub git_tree {
 	git_footer_html();
 }
 
+sub snapshot_name {
+	my ($project, $hash) = @_;
+
+	# path/to/project.git  -> project
+	# path/to/project/.git -> project
+	my $name = to_utf8($project);
+	$name =~ s,([^/])/*\.git$,$1,;
+	$name = basename($name);
+	# sanitize name
+	$name =~ s/[[:cntrl:]]/?/g;
+
+	my $ver = $hash;
+	if ($hash =~ /^[0-9a-fA-F]+$/) {
+		# shorten SHA-1 hash
+		my $full_hash = git_get_full_hash($project, $hash);
+		if ($full_hash =~ /^$hash/ && length($hash) > 7) {
+			$ver = git_get_short_hash($project, $hash);
+		}
+	} elsif ($hash =~ m!^refs/tags/(.*)$!) {
+		# tags don't need shortened SHA-1 hash
+		$ver = $1;
+	} else {
+		# branches and other need shortened SHA-1 hash
+		if ($hash =~ m!^refs/(?:heads|remotes)/(.*)$!) {
+			$ver = $1;
+		}
+		$ver .= '-' . git_get_short_hash($project, $hash);
+	}
+	# in case of hierarchical branch names
+	$ver =~ s!/!.!g;
+
+	# name = project-version_string
+	$name = "$name-$ver";
+
+	return wantarray ? ($name, $name) : $name;
+}
+
 sub git_snapshot {
 	my $format = $input_params{'snapshot_format'};
 	if (!@snapshot_fmts) {
@@ -5203,24 +5251,20 @@ sub git_snapshot {
 		die_error(400, 'Object is not a tree-ish');
 	}
 
-	my $name = $project;
-	$name =~ s,([^/])/*\.git$,$1,;
-	$name = basename($name);
-	my $filename = to_utf8($name);
-	$name =~ s/\047/\047\\\047\047/g;
-	my $cmd;
-	$filename .= "-$hash$known_snapshot_formats{$format}{'suffix'}";
-	$cmd = quote_command(
+	my ($name, $prefix) = snapshot_name($project, $hash);
+	my $filename = "$name$known_snapshot_formats{$format}{'suffix'}";
+	my $cmd = quote_command(
 		git_cmd(), 'archive',
 		"--format=$known_snapshot_formats{$format}{'format'}",
-		"--prefix=$name/", $hash);
+		"--prefix=$prefix/", $hash);
 	if (exists $known_snapshot_formats{$format}{'compressor'}) {
 		$cmd .= ' | ' . quote_command(@{$known_snapshot_formats{$format}{'compressor'}});
 	}
 
+	$filename =~ s/(["\\])/\\$1/g;
 	print $cgi->header(
 		-type => $known_snapshot_formats{$format}{'type'},
-		-content_disposition => 'inline; filename="' . "$filename" . '"',
+		-content_disposition => 'inline; filename="' . $filename . '"',
 		-status => '200 OK');
 
 	open my $fd, "-|", $cmd
diff --git a/t/t9502-gitweb-standalone-parse-output.sh b/t/t9502-gitweb-standalone-parse-output.sh
index 741187b..dd83890 100755
--- a/t/t9502-gitweb-standalone-parse-output.sh
+++ b/t/t9502-gitweb-standalone-parse-output.sh
@@ -56,29 +56,57 @@ test_debug '
 
 test_expect_success 'snapshot: full sha1' '
 	gitweb_run "p=.git;a=snapshot;h=$FULL_ID;sf=tar" &&
-	check_snapshot ".git-$FULL_ID" ".git"
+	check_snapshot ".git-$SHORT_ID"
 '
 test_debug 'cat gitweb.headers && cat file_list'
 
 test_expect_success 'snapshot: shortened sha1' '
 	gitweb_run "p=.git;a=snapshot;h=$SHORT_ID;sf=tar" &&
-	check_snapshot ".git-$SHORT_ID" ".git"
+	check_snapshot ".git-$SHORT_ID"
+'
+test_debug 'cat gitweb.headers && cat file_list'
+
+test_expect_success 'snapshot: almost full sha1' '
+	ID=$(git rev-parse --short=30 HEAD) &&
+	gitweb_run "p=.git;a=snapshot;h=$ID;sf=tar" &&
+	check_snapshot ".git-$SHORT_ID"
 '
 test_debug 'cat gitweb.headers && cat file_list'
 
 test_expect_success 'snapshot: HEAD' '
 	gitweb_run "p=.git;a=snapshot;h=HEAD;sf=tar" &&
-	check_snapshot ".git-HEAD" ".git"
+	check_snapshot ".git-HEAD-$SHORT_ID"
 '
 test_debug 'cat gitweb.headers && cat file_list'
 
 test_expect_success 'snapshot: short branch name (master)' '
 	gitweb_run "p=.git;a=snapshot;h=master;sf=tar" &&
-	check_snapshot ".git-master" ".git"
+	ID=$(git rev-parse --verify --short=7 master) &&
+	check_snapshot ".git-master-$ID"
+'
+test_debug 'cat gitweb.headers && cat file_list'
+
+test_expect_success 'snapshot: short tag name (first)' '
+	gitweb_run "p=.git;a=snapshot;h=first;sf=tar" &&
+	ID=$(git rev-parse --verify --short=7 first) &&
+	check_snapshot ".git-first-$ID"
+'
+test_debug 'cat gitweb.headers && cat file_list'
+
+test_expect_success 'snapshot: full branch name (refs/heads/master)' '
+	gitweb_run "p=.git;a=snapshot;h=refs/heads/master;sf=tar" &&
+	ID=$(git rev-parse --verify --short=7 master) &&
+	check_snapshot ".git-master-$ID"
+'
+test_debug 'cat gitweb.headers && cat file_list'
+
+test_expect_success 'snapshot: full tag name (refs/tags/first)' '
+	gitweb_run "p=.git;a=snapshot;h=refs/tags/first;sf=tar" &&
+	check_snapshot ".git-first"
 '
 test_debug 'cat gitweb.headers && cat file_list'
 
-test_expect_failure 'snapshot: hierarchical branch name (xx/test)' '
+test_expect_success 'snapshot: hierarchical branch name (xx/test)' '
 	gitweb_run "p=.git;a=snapshot;h=xx/test;sf=tar" &&
 	! grep "filename=.*/" gitweb.headers
 '
-- 
1.6.5
