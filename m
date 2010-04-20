From: Michael Olson <mwolson@gnu.org>
Subject: [PATCH/RFC 1/2] git-svn: Allow certain refs to be ignored
Date: Tue, 20 Apr 2010 14:30:14 -0700
Message-ID: <w2nc8b3bef91004201430n4d02e390pa2023d6401a1cb43@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Eric Wong <normalperson@yhbt.net>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Tim Stoakes <tim@stoakes.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 20 23:30:55 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O4L1y-0000Fv-Qn
	for gcvg-git-2@lo.gmane.org; Tue, 20 Apr 2010 23:30:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755417Ab0DTVas (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Apr 2010 17:30:48 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:57959 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755360Ab0DTVar (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Apr 2010 17:30:47 -0400
Received: by pwj9 with SMTP id 9so4669825pwj.19
        for <git@vger.kernel.org>; Tue, 20 Apr 2010 14:30:47 -0700 (PDT)
Received: by 10.220.81.20 with HTTP; Tue, 20 Apr 2010 14:30:14 -0700 (PDT)
X-Originating-IP: [209.104.55.5]
X-Google-Sender-Auth: c6bb72182e179eee
Received: by 10.141.13.3 with SMTP id q3mr806566rvi.174.1271799046937; Tue, 20 
	Apr 2010 14:30:46 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145399>

Implement a new --ignore-refs option which specifies a regex of refs
to ignore while importing svn history.

This is a useful supplement to the --ignore-paths option, as that
option only operates on the contents of branches and tags, not the
branches and tags themselves.

Signed-off-by: Michael W. Olson <mwolson@gnu.org>
---
 git-svn.perl |   38 +++++++++++++++++++++++++++++++++-----
 1 files changed, 33 insertions(+), 5 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index 2c86ea2..0e1feb3 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -89,7 +89,8 @@ $_q ||= 0;
 my %remote_opts = ( 'username=s' => \$Git::SVN::Prompt::_username,
                     'config-dir=s' => \$Git::SVN::Ra::config_dir,
                     'no-auth-cache' => \$Git::SVN::Prompt::_no_auth_cache,
-                    'ignore-paths=s' => \$SVN::Git::Fetcher::_ignore_regex );
+                    'ignore-paths=s' => \$SVN::Git::Fetcher::_ignore_regex,
+                    'ignore-refs=s' => \$Git::SVN::Ra::_ignore_refs_regex );
 my %fc_opts = ( 'follow-parent|follow!' => \$Git::SVN::_follow_parent,
 		'authors-file|A=s' => \$_authors,
 		'authors-prog=s' => \$_authors_prog,
@@ -378,9 +379,12 @@ sub do_git_init_db {
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
@@ -1823,6 +1827,8 @@ sub read_all_remotes {
 			$r->{$1}->{svm} = {};
 		} elsif (m!^(.+)\.url=\s*(.*)\s*$!) {
 			$r->{$1}->{url} = $2;
+		} elsif (m!^(.+)\.ignore-refs=\s*(.*)\s*$!) {
+			$r->{$1}->{ignore_refs_regex} = $2;
 		} elsif (m!^(.+)\.(branches|tags)=$svn_refspec$!) {
 			my ($remote, $t, $local_ref, $remote_ref) =
 			                                     ($1, $2, $3, $4);
@@ -1858,6 +1864,16 @@ sub read_all_remotes {
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

@@ -4806,7 +4822,7 @@ sub apply_diff {
 }

 package Git::SVN::Ra;
-use vars qw/@ISA $config_dir $_log_window_size/;
+use vars qw/@ISA $config_dir $_ignore_refs_regex $_log_window_size/;
 use strict;
 use warnings;
 my ($ra_invalid, $can_do_switch, %ignored_err, $RA);
@@ -5264,6 +5280,17 @@ sub get_dir_globbed {
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

@@ -5300,6 +5327,7 @@ sub match_globs {
 			next unless /$g->{path}->{regex}/;
 			my $p = $1;
 			my $pathname = $g->{path}->full_path($p);
+			next if is_ref_ignored($g, $p);
 			next if $exists->{$pathname};
 			next if ($self->check_path($pathname, $r) !=
 			         $SVN::Node::dir);
-- 
1.7.1.rc0
