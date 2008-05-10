From: Steven Grimm <koreth@midwinter.com>
Subject: [PATCH] Add svn-compatible "blame" output format to git-svn
Date: Sat, 10 May 2008 14:25:04 -0700
Message-ID: <20080510212504.GA26701@midwinter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 10 23:25:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JuwZp-0001xR-Gt
	for gcvg-git-2@gmane.org; Sat, 10 May 2008 23:25:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756153AbYEJVZH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 May 2008 17:25:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756114AbYEJVZH
	(ORCPT <rfc822;git-outgoing>); Sat, 10 May 2008 17:25:07 -0400
Received: from tater.midwinter.com ([216.32.86.90]:52592 "HELO midwinter.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755491AbYEJVZF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 May 2008 17:25:05 -0400
Received: (qmail 26823 invoked by uid 1001); 10 May 2008 21:25:04 -0000
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81706>

git-svn blame produces output in the format of git blame; in environments
where there are scripts that read the output of svn blame, it's useful
to be able to use them with the output of git-svn blame.

This also fixes a bug in the initial git-svn blame implementation; it was
bombing out on uncommitted local changes.

Signed-off-by: Steven Grimm <koreth@midwinter.com>
---

	I'd actually argue that the svn-compatible format should be the
	default one, with git-compatible available as an option, but if
	there are existing scripts that consume git-svn blame's output,
	I don't want to break them.

	I suspect there aren't any since git-svn blame is relatively new.

 Documentation/git-svn.txt |   11 ++++++++-
 git-svn.perl              |   51 +++++++++++++++++++++++++++++++++++++--------
 2 files changed, 51 insertions(+), 11 deletions(-)

diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
index f4ba105..8071347 100644
--- a/Documentation/git-svn.txt
+++ b/Documentation/git-svn.txt
@@ -168,9 +168,16 @@ Any other arguments are passed directly to `git log'
 'blame'::
        Show what revision and author last modified each line of a file. This is
        identical to `git blame', but SVN revision numbers are shown instead of git
-       commit hashes.
+       commit hashes. Changes that haven't been committed to SVN yet are
+       listed as SVN revision 0.
 +
-All arguments are passed directly to `git blame'.
+All arguments are passed directly to `git blame', except the following:
++
+--svn-format;;
+	Produce output in the same format as `svn blame'. In this mode,
+	uncommitted changes in the working copy are ignored (the version
+	of the file from the HEAD revision is annotated) and whitespace
+	characters in author names are replaced with underscores.
 
 --
 'find-rev'::
diff --git a/git-svn.perl b/git-svn.perl
index e47b1ea..9570deb 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -65,7 +65,8 @@ my ($_stdin, $_help, $_edit,
 	$_template, $_shared,
 	$_version, $_fetch_all, $_no_rebase,
 	$_merge, $_strategy, $_dry_run, $_local,
-	$_prefix, $_no_checkout, $_url, $_verbose);
+	$_prefix, $_no_checkout, $_url, $_verbose,
+	$_svn_format);
 $Git::SVN::_follow_parent = 1;
 my %remote_opts = ( 'username=s' => \$Git::SVN::Prompt::_username,
                     'config-dir=s' => \$Git::SVN::Ra::config_dir,
@@ -188,7 +189,7 @@ my %cmd = (
 		    { 'url' => \$_url, } ],
 	'blame' => [ \&Git::SVN::Log::cmd_blame,
 	            "Show what revision and author last modified each line of a file",
-	            {} ],
+		    { 'svn-format' => \$_svn_format } ],
 );
 
 my $cmd;
@@ -4473,14 +4474,46 @@ sub cmd_blame {
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
+	if ($_svn_format) {
+		($fh, $ctx) = command_output_pipe('blame', @_, '-p', 'HEAD',
+						     '--', $path);
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
+		}
+	} else {
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
 		}
-		print $line;
 	}
 	command_close_pipe($fh, $ctx);
 }
-- 
1.5.5.49.gf43e2
