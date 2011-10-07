From: Michael Olson <mwolson@gnu.org>
Subject: [PATCH] git-svn: Allow certain refs to be ignored
Date: Thu, 6 Oct 2011 17:41:20 -0700
Message-ID: <CAN4ruPiSgY+LPdDgS021WQyoHMuNrJDzrqMuCt9G5qfZ=XtjoQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 07 02:41:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RByVX-0006CP-AC
	for gcvg-git-2@lo.gmane.org; Fri, 07 Oct 2011 02:41:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935892Ab1JGAlm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Oct 2011 20:41:42 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:56077 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752416Ab1JGAlm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Oct 2011 20:41:42 -0400
Received: by bkbzt4 with SMTP id zt4so4159428bkb.19
        for <git@vger.kernel.org>; Thu, 06 Oct 2011 17:41:40 -0700 (PDT)
Received: by 10.204.132.87 with SMTP id a23mr954719bkt.285.1317948100177; Thu,
 06 Oct 2011 17:41:40 -0700 (PDT)
Received: by 10.204.112.79 with HTTP; Thu, 6 Oct 2011 17:41:20 -0700 (PDT)
X-Originating-IP: [99.116.250.80]
X-Google-Sender-Auth: __Dw862wQrtrJNC3ZjCwBfDfxEs
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183050>

Implement a new --ignore-refs option which specifies a regex of refs
to ignore while importing svn history.

This is a useful supplement to the --ignore-paths option, as that
option only operates on the contents of branches and tags, not the
branches and tags themselves.

Signed-off-by: Michael Olson <mwolson@gnu.org>
---
Re-sent by request of Piotr Krukowiecki.  This is against v1.7.4.1,
and I've been using it stably for a while.

 git-svn.perl |   38 +++++++++++++++++++++++++++++++++-----
 1 files changed, 33 insertions(+), 5 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index 177dd25..541fa2d 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -90,7 +90,8 @@ $_q ||= 0;
 my %remote_opts = ( 'username=s' => \$Git::SVN::Prompt::_username,
                     'config-dir=s' => \$Git::SVN::Ra::config_dir,
                     'no-auth-cache' => \$Git::SVN::Prompt::_no_auth_cache,
-                    'ignore-paths=s' => \$SVN::Git::Fetcher::_ignore_regex );
+                    'ignore-paths=s' => \$SVN::Git::Fetcher::_ignore_regex,
+                    'ignore-refs=s' => \$Git::SVN::Ra::_ignore_refs_regex );
 my %fc_opts = ( 'follow-parent|follow!' => \$Git::SVN::_follow_parent,
 		'authors-file|A=s' => \$_authors,
 		'authors-prog=s' => \$_authors_prog,
@@ -380,9 +381,12 @@ sub do_git_init_db {
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
 }

 sub init_subdir {
@@ -1831,6 +1835,8 @@ sub read_all_remotes {
 			$r->{$1}->{svm} = {};
 		} elsif (m!^(.+)\.url=\s*(.*)\s*$!) {
 			$r->{$1}->{url} = $2;
+		} elsif (m!^(.+)\.ignore-refs=\s*(.*)\s*$!) {
+			$r->{$1}->{ignore_refs_regex} = $2;
 		} elsif (m!^(.+)\.(branches|tags)=$svn_refspec$!) {
 			my ($remote, $t, $local_ref, $remote_ref) =
 			                                     ($1, $2, $3, $4);
@@ -1867,6 +1873,16 @@ sub read_all_remotes {
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

@@ -4876,7 +4892,7 @@ sub apply_diff {
 }

 package Git::SVN::Ra;
-use vars qw/@ISA $config_dir $_log_window_size/;
+use vars qw/@ISA $config_dir $_ignore_refs_regex $_log_window_size/;
 use strict;
 use warnings;
 my ($ra_invalid, $can_do_switch, %ignored_err, $RA);
@@ -5334,6 +5350,17 @@ sub get_dir_globbed {
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

@@ -5370,6 +5397,7 @@ sub match_globs {
 			next unless /$g->{path}->{regex}/;
 			my $p = $1;
 			my $pathname = $g->{path}->full_path($p);
+			next if is_ref_ignored($g, $p);
 			next if $exists->{$pathname};
 			next if ($self->check_path($pathname, $r) !=
 			         $SVN::Node::dir);
-- 
1.7.4.1
