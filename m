From: "Dave O'Neill" <dmo@roaringpenguin.com>
Subject: [PATCH] Let git-svnimport and git-svn clean up SVK commit messages
Date: Thu, 21 Jun 2007 16:51:32 -0400
Message-ID: <11824590923150-git-send-email-dmo@roaringpenguin.com>
References: <1182392095394-git-send-email-dmo@roaringpenguin.com>
Cc: "Dave O'Neill" <dmo@roaringpenguin.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 21 22:51:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I1TdE-00069t-Hq
	for gcvg-git@gmane.org; Thu, 21 Jun 2007 22:51:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756702AbXFUUvg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Jun 2007 16:51:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756050AbXFUUvg
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Jun 2007 16:51:36 -0400
Received: from www.roaringpenguin.com ([206.191.13.82]:4079 "EHLO
	www.roaringpenguin.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755594AbXFUUve (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jun 2007 16:51:34 -0400
Received: from magnesium.roaringpenguin.com (ottawa-hs-64-26-171-99.s-ip.magma.ca [64.26.171.99])
	by www.roaringpenguin.com (8.14.1/8.14.0) with ESMTP id l5LKpWrd008689
	for <git@vger.kernel.org>; Thu, 21 Jun 2007 16:51:33 -0400
Received: from localhost.localdomain (oxygen.roaringpenguin.com [192.168.10.8])
	by magnesium.roaringpenguin.com (8.12.10/8.12.10) with ESMTP id l5LKpWWo004588;
	Thu, 21 Jun 2007 16:51:33 -0400
X-Mailer: git-send-email 1.5.2.2.239.g89630
In-Reply-To: <1182392095394-git-send-email-dmo@roaringpenguin.com>
X-Scanned-By: CanIt (www . roaringpenguin . com) on 206.191.13.82
X-Scanned-By: MIMEDefang 2.57 on 192.168.10.12
X-Spam-Score: undef - spam scanning disabled
X-CanItPRO-Stream: outgoing (inherits from default)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50655>

SVN repositories that have been committed to with SVK will have commits that
contain SVK metadata on the first line of the message:

   r12345@hostname: user | YYYY-MM-DD HH:MM:SS -ZZZZ

After importing, git will then pick up this first as the commit title, which
isn't terribly informative in 'git log --pretty=oneline' or gitk.

This patch adds a -k option to git-svnimport and a --fix-svk-message option
(and fixSvkMessage config option) to git-svn.  Enabling this option allows
git-svn to try and move that metadata to the end of the commit message,
possibly giving us a more meaningful first line.
---
 Documentation/git-svn.txt       |   13 +++++++++++++
 Documentation/git-svnimport.txt |    6 +++++-
 git-svn.perl                    |   23 ++++++++++++++++++++---
 git-svnimport.perl              |   15 ++++++++++++---
 4 files changed, 50 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
index c0d7d95..5cd89f9 100644
--- a/Documentation/git-svn.txt
+++ b/Documentation/git-svn.txt
@@ -54,6 +54,8 @@ COMMANDS
 	Set the 'useSvmProps' option in the [svn-remote] config.
 --use-svnsync-props;;
 	Set the 'useSvnsyncProps' option in the [svn-remote] config.
+--fix-svk-message;;
+	Set the 'fixSvkMessage' option in the [svn-remote] config.
 --rewrite-root=<URL>;;
 	Set the 'rewriteRoot' option in the [svn-remote] config.
 --username=<USER>;;
@@ -385,6 +387,14 @@ svn-remote.<name>.rewriteRoot::
 	the repository with a public http:// or svn:// URL in the
 	metadata so users of it will see the public URL.
 
+svn-remote.<name>.fixSvkMessage::
+	SVN repositories that have been committed to with SVK will have
+	commits that contain SVK metadata on the first line of the
+	message, which git will then pick up as the commit title.  Enabling
+	this option allows git-svn to try and move that metadata to the end
+	of the commit message, possibly giving us a more meaningful first
+	line.
+
 Since the noMetadata, rewriteRoot, useSvnsyncProps and useSvmProps
 options all affect the metadata generated and used by git-svn; they
 *must* be set in the configuration file before any history is imported
@@ -393,6 +403,9 @@ and these settings should never be changed once they are set.
 Additionally, only one of these four options can be used per-svn-remote
 section because they affect the 'git-svn-id:' metadata line.
 
+The fixSvkMessage option may be set in combination with any of these, and
+can be set after import if desired.
+
 --
 
 BASIC EXAMPLES
diff --git a/Documentation/git-svnimport.txt b/Documentation/git-svnimport.txt
index e97d15e..23a54b0 100644
--- a/Documentation/git-svnimport.txt
+++ b/Documentation/git-svnimport.txt
@@ -11,7 +11,7 @@ SYNOPSIS
 --------
 [verse]
 'git-svnimport' [ -o <branch-for-HEAD> ] [ -h ] [ -v ] [ -d | -D ]
-		[ -C <GIT_repository> ] [ -i ] [ -u ] [-l limit_rev]
+		[ -C <GIT_repository> ] [ -i ] [ -k ] [ -u ] [-l limit_rev]
 		[ -b branch_subdir ] [ -T trunk_subdir ] [ -t tag_subdir ]
 		[ -s start_chg ] [ -m ] [ -r ] [ -M regex ]
 		[ -I <ignorefile_name> ] [ -A <author_file> ]
@@ -68,6 +68,10 @@ When importing incrementally, you might need to edit the .git/svn2git file.
 	Prepend 'rX: ' to commit messages, where X is the imported
 	subversion revision.
 
+-k::
+	Remove SVK-style revision/commiter info from the top of commit
+	messages and move it to the bottom.
+
 -I <ignorefile_name>::
 	Import the svn:ignore directory property to files with this
 	name in each directory. (The Subversion and GIT ignore
diff --git a/git-svn.perl b/git-svn.perl
index 50128d7..1451f0d 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -83,6 +83,7 @@ my %init_opts = ( 'template=s' => \$_template, 'shared:s' => \$_shared,
                   'trunk|T=s' => \$_trunk, 'tags|t=s' => \$_tags,
                   'branches|b=s' => \$_branches, 'prefix=s' => \$_prefix,
                   'minimize-url|m' => \$Git::SVN::_minimize_url,
+		  'fix-svk-message' => \$Git::SVN::_fix_svk_message,
 		  'no-metadata' => sub { $icv{noMetadata} = 1 },
 		  'use-svm-props' => sub { $icv{useSvmProps} = 1 },
 		  'use-svnsync-props' => sub { $icv{useSvnsyncProps} = 1 },
@@ -280,6 +281,11 @@ sub do_git_init_db {
 		command_noisy('config', "$pfx.$i", $icv{$i});
 		$set = $i;
 	}
+
+	if( defined $Git::SVN::_fix_svk_message ) {
+		command_noisy('config', "$pfx.fixSvkMessage", $Git::SVN::_fix_svk_message);
+	}
+
 }
 
 sub init_subdir {
@@ -826,7 +832,7 @@ sub working_head_info {
 package Git::SVN;
 use strict;
 use warnings;
-use vars qw/$default_repo_id $default_ref_id $_no_metadata $_follow_parent
+use vars qw/$default_repo_id $default_ref_id $_no_metadata $_follow_parent $_fix_svk_message
             $_repack $_repack_flags $_use_svm_props $_head
             $_use_svnsync_props $no_reuse_existing $_minimize_url/;
 use Carp qw/croak/;
@@ -849,7 +855,7 @@ BEGIN {
 	# per [svn-remote "..."] section.  Command-line options will *NOT*
 	# override options set in an [svn-remote "..."] section
 	no strict 'refs';
-	for my $option (qw/follow_parent no_metadata use_svm_props
+	for my $option (qw/follow_parent no_metadata use_svm_props fix_svk_message
 			   use_svnsync_props/) {
 		my $key = $option;
 		$key =~ tr/_//d;
@@ -1613,7 +1619,18 @@ sub do_git_commit {
 	}
 	defined(my $pid = open3(my $msg_fh, my $out_fh, '>&STDERR', @exec))
 	                                                           or croak $!;
-	print $msg_fh $log_entry->{log} or croak $!;
+	my $log_msg = $log_entry->{log};
+
+	if( $self->fix_svk_message ) {
+		# Remove SVK cruft in commit message
+		$log_msg =~ s{(r\d+\@[^:]+:\s+\S+\s+\|\s+\d{4}-\d{2}-\d{2}\s+\d{2}:\d{2}:\d{2}\s[\+-]\d{4})\s*}{};
+		if( $1 ) {
+			# and stick it on the end so we don't lose it
+			$log_msg .= "\n$1"
+		}
+	}
+
+	print $msg_fh $log_msg or croak $!;
 	unless ($self->no_metadata) {
 		print $msg_fh "\ngit-svn-id: $log_entry->{metadata}\n"
 		              or croak $!;
diff --git a/git-svnimport.perl b/git-svnimport.perl
index f459762..89afdd8 100755
--- a/git-svnimport.perl
+++ b/git-svnimport.perl
@@ -32,20 +32,20 @@ $ENV{'TZ'}="UTC";
 
 our($opt_h,$opt_o,$opt_v,$opt_u,$opt_C,$opt_i,$opt_m,$opt_M,$opt_t,$opt_T,
     $opt_b,$opt_r,$opt_I,$opt_A,$opt_s,$opt_l,$opt_d,$opt_D,$opt_S,$opt_F,
-    $opt_P,$opt_R);
+    $opt_P,$opt_R,$opt_k);
 
 sub usage() {
 	print STDERR <<END;
 Usage: ${\basename $0}     # fetch/update GIT from SVN
        [-o branch-for-HEAD] [-h] [-v] [-l max_rev] [-R repack_each_revs]
        [-C GIT_repository] [-t tagname] [-T trunkname] [-b branchname]
-       [-d|-D] [-i] [-u] [-r] [-I ignorefilename] [-s start_chg]
+       [-d|-D] [-i] [-k] [-u] [-r] [-I ignorefilename] [-s start_chg]
        [-m] [-M regex] [-A author_file] [-S] [-F] [-P project_name] [SVN_URL]
 END
 	exit(1);
 }
 
-getopts("A:b:C:dDFhiI:l:mM:o:rs:t:T:SP:R:uv") or usage();
+getopts("A:b:C:dDFhiI:kl:mM:o:rs:t:T:SP:R:uv") or usage();
 usage if $opt_h;
 
 my $tag_name = $opt_t || "tags";
@@ -835,6 +835,15 @@ sub commit {
 		$pw->writer();
 		$pr->reader();
 
+		if ( $opt_k ) {
+			# Remove SVK cruft in commit message
+			$message =~ s{(r\d+\@[^:]+:\s+\S+\s+\|\s+\d{4}-\d{2}-\d{2}\s+\d{2}:\d{2}:\d{2}\s[\+-]\d{4})\s*}{};
+			if( $1 ) {
+				# and stick it on the end so we don't lose it
+				$message .= "\n$1"
+			}
+		}
+
 		$message =~ s/[\s\n]+\z//;
 		$message = "r$revision: $message" if $opt_r;
 
-- 
1.5.2.2.239.g89630
