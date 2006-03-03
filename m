From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH 5/9] contrib/git-svn: cleanup option parsing
Date: Fri, 3 Mar 2006 01:20:08 -0800
Message-ID: <11413776081545-git-send-email-normalperson@yhbt.net>
References: <11413776082506-git-send-email-normalperson@yhbt.net>
Reply-To: Eric Wong <normalperson@yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 03 10:20:46 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FF6Sg-00041U-Js
	for gcvg-git@gmane.org; Fri, 03 Mar 2006 10:20:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752202AbWCCJUR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 3 Mar 2006 04:20:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752205AbWCCJUR
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Mar 2006 04:20:17 -0500
Received: from hand.yhbt.net ([66.150.188.102]:387 "EHLO hand.yhbt.net")
	by vger.kernel.org with ESMTP id S1752202AbWCCJUJ (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 3 Mar 2006 04:20:09 -0500
Received: from Muzzle (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id D6C527DC024;
	Fri,  3 Mar 2006 01:20:08 -0800 (PST)
In-Reply-To: <11413776082506-git-send-email-normalperson@yhbt.net>
X-Mailer: git-send-email
To: junkio@cox.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17148>

Signed-off-by: Eric Wong <normalperson@yhbt.net>

---

 contrib/git-svn/git-svn.perl |   65 +++++++++++++++++++++++-------------------
 1 files changed, 35 insertions(+), 30 deletions(-)

a080e189728de9a7aa834b61205df9d8de1025ba
diff --git a/contrib/git-svn/git-svn.perl b/contrib/git-svn/git-svn.perl
index c2b4ee9..5d547e8 100755
--- a/contrib/git-svn/git-svn.perl
+++ b/contrib/git-svn/git-svn.perl
@@ -24,6 +24,7 @@ $ENV{LC_ALL} = 'C';
 # If SVN:: library support is added, please make the dependencies
 # optional and preserve the capability to use the command-line client.
 # use eval { require SVN::... } to make it lazy load
+# We don't use any modules not in the standard Perl distribution:
 use Carp qw/croak/;
 use IO::File qw//;
 use File::Basename qw/dirname basename/;
@@ -37,26 +38,25 @@ my ($_revision,$_stdin,$_no_ignore_ext,$
 	$_find_copies_harder, $_l, $_version, $_upgrade, $_authors);
 my (@_branch_from, %tree_map, %users);
 
-GetOptions(	'revision|r=s' => \$_revision,
-		'no-ignore-externals' => \$_no_ignore_ext,
-		'stdin|' => \$_stdin,
-		'edit|e' => \$_edit,
-		'rmdir' => \$_rmdir,
-		'upgrade' => \$_upgrade,
-		'help|H|h' => \$_help,
+my %fc_opts = ( 'no-ignore-externals' => \$_no_ignore_ext,
 		'branch|b=s' => \@_branch_from,
-		'find-copies-harder' => \$_find_copies_harder,
-		'authors-file|authors|A=s' => \$_authors,
-		'l=i' => \$_l,
-		'version|V' => \$_version,
-		'no-stop-on-copy' => \$_no_stop_copy );
+		'authors-file|A=s' => \$_authors );
 my %cmd = (
-	fetch => [ \&fetch, "Download new revisions from SVN" ],
-	init => [ \&init, "Initialize and fetch (import)"],
-	commit => [ \&commit, "Commit git revisions to SVN" ],
-	'show-ignore' => [ \&show_ignore, "Show svn:ignore listings" ],
-	rebuild => [ \&rebuild, "Rebuild git-svn metadata (after git clone)" ],
-	help => [ \&usage, "Show help" ],
+	fetch => [ \&fetch, "Download new revisions from SVN",
+			{ 'revision|r=s' => \$_revision, %fc_opts } ],
+	init => [ \&init, "Initialize and fetch (import)", { } ],
+	commit => [ \&commit, "Commit git revisions to SVN",
+			{	'stdin|' => \$_stdin,
+				'edit|e' => \$_edit,
+				'rmdir' => \$_rmdir,
+				'find-copies-harder' => \$_find_copies_harder,
+				'l=i' => \$_l,
+				%fc_opts,
+			} ],
+	'show-ignore' => [ \&show_ignore, "Show svn:ignore listings", { } ],
+	rebuild => [ \&rebuild, "Rebuild git-svn metadata (after git clone)",
+			{ 'no-ignore-externals' => \$_no_ignore_ext,
+			  'upgrade' => \$_upgrade } ],
 );
 my $cmd;
 for (my $i = 0; $i < @ARGV; $i++) {
@@ -75,21 +75,14 @@ foreach (keys %cmd) {
 	}
 }
 
-# '<svn username> = real-name <email address>' mapping based on git-svnimport:
-if ($_authors) {
-	open my $authors, '<', $_authors or die "Can't open $_authors $!\n";
-	while (<$authors>) {
-		chomp;
-		next unless /^(\S+?)\s*=\s*(.+?)\s*<(.+)>\s*$/;
-		my ($user, $name, $email) = ($1, $2, $3);
-		$users{$user} = [$name, $email];
-	}
-	close $authors or croak $!;
-}
+my %opts;
+%opts = %{$cmd{$cmd}->[2]} if (defined $cmd);
 
+GetOptions(%opts, 'help|H|h' => \$_help, 'version|V' => \$_version ) or exit 1;
 usage(0) if $_help;
 version() if $_version;
-usage(1) unless (defined $cmd);
+usage(1) unless defined $cmd;
+load_authors() if $_authors;
 svn_check_ignore_externals();
 $cmd{$cmd}->[0]->(@ARGV);
 exit 0;
@@ -1047,6 +1040,18 @@ sub map_tree_joins {
 	}
 }
 
+# '<svn username> = real-name <email address>' mapping based on git-svnimport:
+sub load_authors {
+	open my $authors, '<', $_authors or die "Can't open $_authors $!\n";
+	while (<$authors>) {
+		chomp;
+		next unless /^(\S+?)\s*=\s*(.+?)\s*<(.+)>\s*$/;
+		my ($user, $name, $email) = ($1, $2, $3);
+		$users{$user} = [$name, $email];
+	}
+	close $authors or croak $!;
+}
+
 __END__
 
 Data structures:
-- 
1.2.3.g4676
