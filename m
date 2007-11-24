From: Gustaf Hendeby <hendeby@isy.liu.se>
Subject: [PATCH] git-svn now reads settings even if called in subdirectory
Date: Sat, 24 Nov 2007 14:47:56 +0100
Message-ID: <1195912076-3903-1-git-send-email-hendeby@isy.liu.se>
Cc: gitster@pobox.com, Gustaf Hendeby <hendeby@isy.liu.se>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 24 15:19:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ivvqa-0007Tz-Ni
	for gcvg-git-2@gmane.org; Sat, 24 Nov 2007 15:19:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752836AbXKXOSp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Nov 2007 09:18:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752820AbXKXOSp
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Nov 2007 09:18:45 -0500
Received: from bogotron.isy.liu.se ([130.236.48.26]:64619 "EHLO
	bogotron.isy.liu.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752799AbXKXOSo (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Nov 2007 09:18:44 -0500
X-Greylist: delayed 1844 seconds by postgrey-1.27 at vger.kernel.org; Sat, 24 Nov 2007 09:18:44 EST
Received: from spamotron.isy.liu.se (spamotron.isy.liu.se [130.236.48.19])
	by bogotron.isy.liu.se (Postfix) with ESMTP id 0982F25A59;
	Sat, 24 Nov 2007 14:47:59 +0100 (MET)
Received: from bogotron.isy.liu.se ([130.236.48.26])
 by spamotron.isy.liu.se (spamotron.isy.liu.se [130.236.48.19]) (amavisd-new, port 10022)
 with ESMTP id 25712-01; Sat, 24 Nov 2007 14:47:57 +0100 (MET)
Received: from pluring.isy.liu.se (pluring.isy.liu.se [130.236.56.134])
	by bogotron.isy.liu.se (Postfix) with ESMTP id AF69A25A50;
	Sat, 24 Nov 2007 14:47:56 +0100 (MET)
Received: by pluring.isy.liu.se (Postfix, from userid 2087)
	id 6AA495DDB7; Sat, 24 Nov 2007 14:47:56 +0100 (CET)
X-Mailer: git-send-email 1.5.3.6.1992.g3d0f
X-Virus-Scanned: by amavisd-new at isy.liu.se
X-Spam-Checker-Version: SpamAssassin 2.63-isy (2004-01-11) on spamotron.isy.liu.se
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65952>

Previously, git-svn first read the .git/config file for settings as if
current working directory was the repository top-directory, and after
that made sure to cd into top-directory.  The result was a silent
failur to read configuration settings.  This patch changes the order
these two things are done.

Signed-off-by: Gustaf Hendeby <hendeby@isy.liu.se>

---

This fix seems a bit too obvious, which makes me think I missed
something conceptual here.  However, the patch passes "make test" and
"make full-svn-test", and the problems I had with the svn.authorsfile
setting not being honored while fetching from a subdirectory are gone.

 git-svn.perl |   35 ++++++++++++++++++-----------------
 1 files changed, 18 insertions(+), 17 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index 43e1591..640a45a 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -193,23 +193,6 @@ for (my $i = 0; $i < @ARGV; $i++) {
 	}
 };
 
-my %opts = %{$cmd{$cmd}->[2]} if (defined $cmd);
-
-read_repo_config(\%opts);
-Getopt::Long::Configure('pass_through') if ($cmd && $cmd eq 'log');
-my $rv = GetOptions(%opts, 'help|H|h' => \$_help, 'version|V' => \$_version,
-                    'minimize-connections' => \$Git::SVN::Migration::_minimize,
-                    'id|i=s' => \$Git::SVN::default_ref_id,
-                    'svn-remote|remote|R=s' => sub {
-                       $Git::SVN::no_reuse_existing = 1;
-                       $Git::SVN::default_repo_id = $_[1] });
-exit 1 if (!$rv && $cmd && $cmd ne 'log');
-
-usage(0) if $_help;
-version() if $_version;
-usage(1) unless defined $cmd;
-load_authors() if $_authors;
-
 # make sure we're always running
 unless ($cmd =~ /(?:clone|init|multi-init)$/) {
 	unless (-d $ENV{GIT_DIR}) {
@@ -231,6 +214,24 @@ unless ($cmd =~ /(?:clone|init|multi-init)$/) {
 		$ENV{GIT_DIR} = $git_dir;
 	}
 }
+
+my %opts = %{$cmd{$cmd}->[2]} if (defined $cmd);
+
+read_repo_config(\%opts);
+Getopt::Long::Configure('pass_through') if ($cmd && $cmd eq 'log');
+my $rv = GetOptions(%opts, 'help|H|h' => \$_help, 'version|V' => \$_version,
+                    'minimize-connections' => \$Git::SVN::Migration::_minimize,
+                    'id|i=s' => \$Git::SVN::default_ref_id,
+                    'svn-remote|remote|R=s' => sub {
+                       $Git::SVN::no_reuse_existing = 1;
+                       $Git::SVN::default_repo_id = $_[1] });
+exit 1 if (!$rv && $cmd && $cmd ne 'log');
+
+usage(0) if $_help;
+version() if $_version;
+usage(1) unless defined $cmd;
+load_authors() if $_authors;
+
 unless ($cmd =~ /^(?:clone|init|multi-init|commit-diff)$/) {
 	Git::SVN::Migration::migration_check();
 }
-- 
1.5.3.6.1992.g3d0f
