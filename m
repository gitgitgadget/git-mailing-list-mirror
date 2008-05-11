From: Steven Grimm <koreth@midwinter.com>
Subject: [PATCH v2] Add svn-compatible "blame" output format to git-svn
Date: Sat, 10 May 2008 22:11:18 -0700
Message-ID: <20080511051118.GA18207@midwinter.com>
References: <7vabix8t3g.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 11 07:12:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jv3qy-00043L-As
	for gcvg-git-2@gmane.org; Sun, 11 May 2008 07:12:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750843AbYEKFLT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 May 2008 01:11:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750836AbYEKFLT
	(ORCPT <rfc822;git-outgoing>); Sun, 11 May 2008 01:11:19 -0400
Received: from tater.midwinter.com ([216.32.86.90]:41493 "HELO midwinter.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750792AbYEKFLS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 May 2008 01:11:18 -0400
Received: (qmail 18353 invoked by uid 1001); 11 May 2008 05:11:18 -0000
Content-Disposition: inline
In-Reply-To: <7vabix8t3g.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81733>

git-svn blame produced output in the format of git blame; in environments
where there are scripts that read the output of svn blame, it's useful
to be able to use them with the output of git-svn. The git-compatible
format is still available using the new "--git-format" option.

This also fixes a bug in the initial git-svn blame implementation; it was
bombing out on uncommitted local changes.

Signed-off-by: Steven Grimm <koreth@midwinter.com>
---

	The svn-compatible format is now the default.

 Documentation/git-svn.txt |   15 +++++++++---
 git-svn.perl              |   55 ++++++++++++++++++++++++++++++++++++---------
 2 files changed, 55 insertions(+), 15 deletions(-)

diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
index f4ba105..c6b56b4 100644
--- a/Documentation/git-svn.txt
+++ b/Documentation/git-svn.txt
@@ -166,11 +166,18 @@ environment). This command has the same behaviour.
 Any other arguments are passed directly to `git log'
 
 'blame'::
-       Show what revision and author last modified each line of a file. This is
-       identical to `git blame', but SVN revision numbers are shown instead of git
-       commit hashes.
+       Show what revision and author last modified each line of a file. The
+       output of this mode is format-compatible with the output of
+       `svn blame' by default. Like the SVN blame command,
+       local uncommitted changes in the working copy are ignored;
+       the version of the file in the HEAD revision is annotated. Unknown
+       arguments are passed directly to git-blame.
 +
-All arguments are passed directly to `git blame'.
+--git-format;;
+	Produce output in the same format as `git blame', but with
+	SVN revision numbers instead of git commit hashes. In this mode,
+	changes that haven't been committed to SVN (including local
+	working-copy edits) are shown as revision 0.
 
 --
 'find-rev'::
diff --git a/git-svn.perl b/git-svn.perl
index e47b1ea..77f880e 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -65,7 +65,8 @@ my ($_stdin, $_help, $_edit,
 	$_template, $_shared,
 	$_version, $_fetch_all, $_no_rebase,
 	$_merge, $_strategy, $_dry_run, $_local,
-	$_prefix, $_no_checkout, $_url, $_verbose);
+	$_prefix, $_no_checkout, $_url, $_verbose,
+	$_git_format);
 $Git::SVN::_follow_parent = 1;
 my %remote_opts = ( 'username=s' => \$Git::SVN::Prompt::_username,
                     'config-dir=s' => \$Git::SVN::Ra::config_dir,
@@ -188,7 +189,7 @@ my %cmd = (
 		    { 'url' => \$_url, } ],
 	'blame' => [ \&Git::SVN::Log::cmd_blame,
 	            "Show what revision and author last modified each line of a file",
-	            {} ],
+		    { 'git-format' => \$_git_format } ],
 );
 
 my $cmd;
@@ -225,7 +226,7 @@ unless ($cmd && $cmd =~ /(?:clone|init|multi-init)$/) {
 my %opts = %{$cmd{$cmd}->[2]} if (defined $cmd);
 
 read_repo_config(\%opts);
-Getopt::Long::Configure('pass_through') if ($cmd && $cmd eq 'log');
+Getopt::Long::Configure('pass_through') if ($cmd && ($cmd eq 'log' || $cmd eq 'blame'));
 my $rv = GetOptions(%opts, 'help|H|h' => \$_help, 'version|V' => \$_version,
                     'minimize-connections' => \$Git::SVN::Migration::_minimize,
                     'id|i=s' => \$Git::SVN::default_ref_id,
@@ -4468,19 +4469,51 @@ out:
 }
 
 sub cmd_blame {
-	my $path = shift;
+	my $path = pop;
 
 	config_pager();
 	run_pager();
 
-	my ($fh, $ctx) = command_output_pipe('blame', @_, $path);
-	while (my $line = <$fh>) {
-		if ($line =~ /^\^?([[:xdigit:]]+)\s/) {
-			my (undef, $rev, undef) = ::cmt_metadata($1);
-			$rev = sprintf('%-10s', $rev);
-			$line =~ s/^\^?[[:xdigit:]]+(\s)/$rev$1/;
+	my ($fh, $ctx, $rev);
+
+	if ($_git_format) {
+		($fh, $ctx) = command_output_pipe('blame', @_, $path);
+		while (my $line = <$fh>) {
+			if ($line =~ /^\^?([[:xdigit:]]+)\s/) {
+				# Uncommitted edits show up as a rev ID of
+				# all zeros, which we can't look up with
+				# cmt_metadata
+				if ($1 !~ /^0+$/) {
+					(undef, $rev, undef) =
+						::cmt_metadata($1);
+					$rev = '0' if (!$rev);
+				} else {
+					$rev = '0';
+				}
+				$rev = sprintf('%-10s', $rev);
+				$line =~ s/^\^?[[:xdigit:]]+(\s)/$rev$1/;
+			}
+			print $line;
+		}
+	} else {
+		($fh, $ctx) = command_output_pipe('blame', '-p', @_, 'HEAD',
+						  '--', $path);
+		my ($sha1);
+		my %authors;
+		while (my $line = <$fh>) {
+			if ($line =~ /^([[:xdigit:]]{40})\s\d+\s\d+/) {
+				$sha1 = $1;
+				(undef, $rev, undef) = ::cmt_metadata($1);
+				$rev = '0' if (!$rev);
+			}
+			elsif ($line =~ /^author (.*)/) {
+				$authors{$rev} = $1;
+				$authors{$rev} =~ s/\s/_/g;
+			}
+			elsif ($line =~ /^\t(.*)$/) {
+				printf("%6s %10s %s\n", $rev, $authors{$rev}, $1);
+			}
 		}
-		print $line;
 	}
 	command_close_pipe($fh, $ctx);
 }
-- 
1.5.5.49.gf43e2
