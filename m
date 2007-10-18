From: Sam Vilain <sam@vilain.net>
Subject: Re: git-svn help for authorsfile
Date: Fri, 19 Oct 2007 11:53:37 +1300
Message-ID: <4717E3F1.8020805@vilain.net>
References: <4b3406f0710172326y29c73a79x648ef98208adba78@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Dongsheng Song <dongsheng.song@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 19 00:55:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IieGw-0001wk-AY
	for gcvg-git-2@gmane.org; Fri, 19 Oct 2007 00:55:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763146AbXJRWzJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Oct 2007 18:55:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761861AbXJRWzI
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Oct 2007 18:55:08 -0400
Received: from godel.catalyst.net.nz ([202.78.240.40]:60442 "EHLO
	mail1.catalyst.net.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758088AbXJRWzG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Oct 2007 18:55:06 -0400
Received: from leibniz.catalyst.net.nz ([202.78.240.7] helo=wilber.wgtn.cat-it.co.nz)
	by mail1.catalyst.net.nz with esmtp (Exim 4.63)
	(envelope-from <samv@wilber.wgtn.cat-it.co.nz>)
	id 1IieGb-0008Fb-TO; Fri, 19 Oct 2007 11:55:02 +1300
Received: by wilber.wgtn.cat-it.co.nz (Postfix, from userid 1000)
	id CA3732C7CB; Fri, 19 Oct 2007 11:55:01 +1300 (NZDT)
FCC: imap://sam@localhost/INBOX/Sent
X-Identity-Key: id4
X-Mozilla-Draft-Info: internal/draft; vcard=0; receipt=0; uuencode=0
User-Agent: Icedove 1.5.0.12 (X11/20070606)
In-Reply-To: <4b3406f0710172326y29c73a79x648ef98208adba78@mail.gmail.com>
X-Enigmail-Version: 0.94.2.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61572>

Dongsheng Song wrote:
> In general, all svn projects share the same authorsfile, e.g.
> 
> [svn]
> authorsfile=/path/to/authorsfile
> 
> [svn-remote "project-a"]
>    url = http://server.org/svn
>    branches = branches/*/project-a:refs/remotes/project-a/branches/*
>    tags = tags/*/project-a:refs/remotes/project-a/tags/*
>    trunk = trunk/project-a:refs/remotes/project-a/trunk
> 
> [svn-remote "project-b"]
>    url = http://server.org/svn
>    branches = branches/*/project-b:refs/remotes/project-b/branches/*
>    tags = tags/*/project-b:refs/remotes/project-b/tags/*
>    trunk = trunk/project-b:refs/remotes/project-b/trunk
> 
> But if  project-a and project-b has same svn id, map to different
> user/email, how do I do?
> 
> Can we move authorsfile from svn to svn-remote section ?

Dongsheng,

If you come up with a patch that allows this, then I'm sure it can be
considered; below is what I imagine it would minimally require.  However,
I haven't tested this at all so please treat with caution.

Subject: [PATCH] git-svn: allow per-remote authors map

Allow the authors map to be overridden on a per-remote basis.
---
 git-svn.perl |   14 +++++++++-----
 1 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index c015ea8..47f524d 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -5,7 +5,7 @@ use warnings;
 use strict;
 use vars qw/	$AUTHOR $VERSION
 		$sha1 $sha1_short $_revision
-		$_q $_authors %users/;
+		$_q %users/;
 $AUTHOR = 'Eric Wong <normalperson@yhbt.net>';
 $VERSION = '@@GIT_VERSION@@';
 
@@ -65,7 +65,7 @@ my %remote_opts = ( 'username=s' => \$Git::SVN::Prompt::_username,
                     'config-dir=s' => \$Git::SVN::Ra::config_dir,
                     'no-auth-cache' => \$Git::SVN::Prompt::_no_auth_cache );
 my %fc_opts = ( 'follow-parent|follow!' => \$Git::SVN::_follow_parent,
-		'authors-file|A=s' => \$_authors,
+		'authors-file|A=s' => \$Git::SVN::_authors,
 		'repack:i' => \$Git::SVN::_repack,
 		'noMetadata' => \$Git::SVN::_no_metadata,
 		'useSvmProps' => \$Git::SVN::_use_svm_props,
@@ -142,7 +142,7 @@ my %cmd = (
 			  'oneline' => \$Git::SVN::Log::oneline,
 			  'show-commit' => \$Git::SVN::Log::show_commit,
 			  'non-recursive' => \$Git::SVN::Log::non_recursive,
-			  'authors-file|A=s' => \$_authors,
+			  'authors-file|A=s' => \$Git::SVN::authors,
 			  'color' => \$Git::SVN::Log::color,
 			  'pager=s' => \$Git::SVN::Log::pager,
 			} ],
@@ -187,7 +187,6 @@ exit 1 if (!$rv && $cmd && $cmd ne 'log');
 usage(0) if $_help;
 version() if $_version;
 usage(1) unless defined $cmd;
-load_authors() if $_authors;
 
 # make sure we're always running
 unless ($cmd =~ /(?:clone|init|multi-init)$/) {
@@ -748,6 +747,7 @@ sub file_to_s {
 
 # '<svn username> = real-name <email address>' mapping based on git-svnimport:
 sub load_authors {
+	my $_authors = shift;
 	open my $authors, '<', $_authors or die "Can't open $_authors $!\n";
 	my $log = $cmd eq 'log';
 	while (<$authors>) {
@@ -891,7 +891,7 @@ package Git::SVN;
 use strict;
 use warnings;
 use vars qw/$default_repo_id $default_ref_id $_no_metadata $_follow_parent
-            $_repack $_repack_flags $_use_svm_props $_head
+            $_repack $_repack_flags $_use_svm_props $_head $_authors
             $_use_svnsync_props $no_reuse_existing $_minimize_url/;
 use Carp qw/croak/;
 use File::Path qw/mkpath/;
@@ -993,6 +993,8 @@ sub fetch_all {
 	$remotes ||= read_all_remotes();
 	my $remote = $remotes->{$repo_id} or
 	             die "[svn-remote \"$repo_id\"] unknown\n";
+	my $authors = $remote->{authors} || $_authors;
+	load_authors($authors) if $authors;
 	my $fetch = $remote->{fetch};
 	my $url = $remote->{url} or die "svn-remote.$repo_id.url not defined\n";
 	my (@gs, @globs);
@@ -1050,6 +1052,8 @@ sub read_all_remotes {
 				die "The '*' glob character must be the last ",
 				    "character of '$g'\n";
 			}
+		} elsif (m!^(.+)\.authors=\s*(.*)\s*$!) {
+			$r->{$1}->{authors} = $2;
 		}
 	}
 	$r;
-- 
1.5.3.2.3.g2f2dcc-dirty
