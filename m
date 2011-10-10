From: Michael Olson <mwolson@gnu.org>
Subject: [PATCH v2] git-svn: Allow certain refs to be ignored
Date: Mon, 10 Oct 2011 16:27:37 -0700
Message-ID: <CAN4ruPjaWgrk1HKmDR8XYdQcVOaYtj=RQ1R9=KYjGzOZ0-B_vA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Oct 11 01:28:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RDPGO-0004FV-9b
	for gcvg-git-2@lo.gmane.org; Tue, 11 Oct 2011 01:28:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753013Ab1JJX17 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Oct 2011 19:27:59 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:36142 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751000Ab1JJX16 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Oct 2011 19:27:58 -0400
Received: by bkbzt4 with SMTP id zt4so9023720bkb.19
        for <git@vger.kernel.org>; Mon, 10 Oct 2011 16:27:57 -0700 (PDT)
Received: by 10.204.6.206 with SMTP id a14mr7647137bka.38.1318289277133; Mon,
 10 Oct 2011 16:27:57 -0700 (PDT)
Received: by 10.204.24.7 with HTTP; Mon, 10 Oct 2011 16:27:37 -0700 (PDT)
X-Originating-IP: [216.103.134.130]
X-Google-Sender-Auth: bqO96i2Py0pz8I7efTLRGBLl0xE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183267>

Implement a new --ignore-refs option which specifies a regex of refs
to ignore while importing svn history.

This is a useful supplement to the --ignore-paths option, as that
option only operates on the contents of branches and tags, not the
branches and tags themselves.

Signed-off-by: Michael Olson <mwolson@gnu.org>
---
Rebased against git master.

 git-svn.perl |   38 +++++++++++++++++++++++++++++++++-----
 1 files changed, 33 insertions(+), 5 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index 351e743..fed1734 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -94,7 +94,8 @@ $_q ||= 0;
 my %remote_opts = ( 'username=s' => \$Git::SVN::Prompt::_username,
                     'config-dir=s' => \$Git::SVN::Ra::config_dir,
                     'no-auth-cache' => \$Git::SVN::Prompt::_no_auth_cache,
-                    'ignore-paths=s' => \$SVN::Git::Fetcher::_ignore_regex );
+                    'ignore-paths=s' => \$SVN::Git::Fetcher::_ignore_regex,
+                    'ignore-refs=s' => \$Git::SVN::Ra::_ignore_refs_regex );
 my %fc_opts = ( 'follow-parent|follow!' => \$Git::SVN::_follow_parent,
 		'authors-file|A=s' => \$_authors,
 		'authors-prog=s' => \$_authors_prog,
@@ -388,9 +389,12 @@ sub do_git_init_db {
 		command_noisy('config', "$pfx.$i", $icv{$i});
 		$set = $i;
 	}
-	my $ignore_regex = \$SVN::Git::Fetcher::_ignore_regex;
-	command_noisy('config', "$pfx.ignore-paths", $$ignore_regex)
-		if defined $$ignore_regex;
+	my $ignore_paths_regex = \$SVN::Git::Fetcher::_ignore_regex;
+	command_noisy('config', "$pfx.ignore-paths", $$ignore_paths_regex)
+		if defined $$ignore_paths_regex;
+	my $ignore_refs_regex = \$Git::SVN::Ra::_ignore_refs_regex;
+	command_noisy('config', "$pfx.ignore-refs", $$ignore_refs_regex)
+		if defined $$ignore_refs_regex;

 	if (defined $SVN::Git::Fetcher::_preserve_empty_dirs) {
 		my $fname = \$SVN::Git::Fetcher::_placeholder_filename;
@@ -2119,6 +2123,8 @@ sub read_all_remotes {
 			$r->{$1}->{url} = $2;
 		} elsif (m!^(.+)\.pushurl=\s*(.*)\s*$!) {
 			$r->{$1}->{pushurl} = $2;
+		} elsif (m!^(.+)\.ignore-refs=\s*(.*)\s*$!) {
+			$r->{$1}->{ignore_refs_regex} = $2;
 		} elsif (m!^(.+)\.(branches|tags)=$svn_refspec$!) {
 			my ($remote, $t, $local_ref, $remote_ref) =
 			                                     ($1, $2, $3, $4);
@@ -2155,6 +2161,16 @@ sub read_all_remotes {
 		}
 	} keys %$r;

+	foreach my $remote (keys %$r) {
+		foreach ( grep { defined $_ }
+			  map { $r->{$remote}->{$_} } qw(branches tags) ) {
+			foreach my $rs ( @$_ ) {
+				$rs->{ignore_refs_regex} =
+				    $r->{$remote}->{ignore_refs_regex};
+			}
+		}
+	}
+
 	$r;
 }

@@ -5310,7 +5326,7 @@ sub apply_diff {
 }

 package Git::SVN::Ra;
-use vars qw/@ISA $config_dir $_log_window_size/;
+use vars qw/@ISA $config_dir $_ignore_refs_regex $_log_window_size/;
 use strict;
 use warnings;
 my ($ra_invalid, $can_do_switch, %ignored_err, $RA);
@@ -5768,6 +5784,17 @@ sub get_dir_globbed {
 	@finalents;
 }

+# return value: 0 -- don't ignore, 1 -- ignore
+sub is_ref_ignored {
+	my ($g, $p) = @_;
+	my $refname = $g->{ref}->full_path($p);
+	return 1 if defined($g->{ignore_refs_regex}) &&
+	            $refname =~ m!$g->{ignore_refs_regex}!;
+	return 0 unless defined($_ignore_refs_regex);
+	return 1 if $refname =~ m!$_ignore_refs_regex!o;
+	return 0;
+}
+
 sub match_globs {
 	my ($self, $exists, $paths, $globs, $r) = @_;

@@ -5804,6 +5831,7 @@ sub match_globs {
 			next unless /$g->{path}->{regex}/;
 			my $p = $1;
 			my $pathname = $g->{path}->full_path($p);
+			next if is_ref_ignored($g, $p);
 			next if $exists->{$pathname};
 			next if ($self->check_path($pathname, $r) !=
 			         $SVN::Node::dir);
-- 
1.7.4.1
