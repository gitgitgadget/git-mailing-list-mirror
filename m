From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH] contrib/git-svn: add show-ignore command
Date: Sun, 26 Feb 2006 02:22:27 -0800
Message-ID: <11409493473353-git-send-email-normalperson@yhbt.net>
Reply-To: Eric Wong <normalperson@yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Sun Feb 26 11:22:38 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FDJ2w-0003Fz-GF
	for gcvg-git@gmane.org; Sun, 26 Feb 2006 11:22:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751312AbWBZKW3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 26 Feb 2006 05:22:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750811AbWBZKW3
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Feb 2006 05:22:29 -0500
Received: from hand.yhbt.net ([66.150.188.102]:56994 "EHLO hand.yhbt.net")
	by vger.kernel.org with ESMTP id S1751312AbWBZKW2 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 26 Feb 2006 05:22:28 -0500
Received: from Muzzle (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id 8988F2DC03C;
	Sun, 26 Feb 2006 02:22:27 -0800 (PST)
In-Reply-To: 
X-Mailer: git-send-email
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16779>

Recursively finds and lists the svn:ignore property on
directories.  The output is suitable for appending to the
$GIT_DIR/info/exclude file.

Signed-off-by: Eric Wong <normalperson@yhbt.net>

---

 contrib/git-svn/git-svn.perl |   25 +++++++++++++++++++++++++
 contrib/git-svn/git-svn.txt  |    7 +++++++
 2 files changed, 32 insertions(+), 0 deletions(-)

0858c770ef3e0f440c20a255baaf4792b3201813
diff --git a/contrib/git-svn/git-svn.perl b/contrib/git-svn/git-svn.perl
index a32ce15..84d43de 100755
--- a/contrib/git-svn/git-svn.perl
+++ b/contrib/git-svn/git-svn.perl
@@ -49,6 +49,7 @@ my %cmd = (
 	fetch => [ \&fetch, "Download new revisions from SVN" ],
 	init => [ \&init, "Initialize and fetch (import)"],
 	commit => [ \&commit, "Commit git revisions to SVN" ],
+	'show-ignore' => [ \&show_ignore, "Show svn:ignore listings" ],
 	rebuild => [ \&rebuild, "Rebuild git-svn metadata (after git clone)" ],
 	help => [ \&usage, "Show help" ],
 );
@@ -258,6 +259,30 @@ sub commit {
 
 }
 
+sub show_ignore {
+	require File::Find or die $!;
+	my $exclude_file = "$GIT_DIR/info/exclude";
+	open my $fh, '<', $exclude_file or croak $!;
+	chomp(my @excludes = (<$fh>));
+	close $fh or croak $!;
+	
+	$SVN_URL ||= file_to_s("$GIT_DIR/$GIT_SVN/info/url");
+	chdir $SVN_WC or croak $!;
+	my %ign;
+	File::Find::find({wanted=>sub{if(lstat $_ && -d _ && -d "$_/.svn"){
+		s#^\./##;
+		@{$ign{$_}} = safe_qx(qw(svn propget svn:ignore),$_);
+		}}, no_chdir=>1},'.');
+	
+	print "\n# /\n";
+	foreach (@{$ign{'.'}}) { print '/',$_ if /\S/ }
+	delete $ign{'.'};
+	foreach my $i (sort keys %ign) {
+		print "\n# ",$i,"\n";
+		foreach (@{$ign{$i}}) { print '/',$i,'/',$_ if /\S/ }
+	}
+}
+
 ########################### utility functions #########################
 
 sub setup_git_svn {
diff --git a/contrib/git-svn/git-svn.txt b/contrib/git-svn/git-svn.txt
index cf098d7..b4b7789 100644
--- a/contrib/git-svn/git-svn.txt
+++ b/contrib/git-svn/git-svn.txt
@@ -61,6 +61,11 @@ rebuild::
 	the directory/repository you're tracking has moved or changed
 	protocols.
 
+show-ignore::
+	Recursively finds and lists the svn:ignore property on
+	directories.  The output is suitable for appending to
+	the $GIT_DIR/info/exclude file.
+
 OPTIONS
 -------
 -r <ARG>::
@@ -152,6 +157,8 @@ Tracking and contributing to an Subversi
 	git commit git-svn-HEAD..my-branch
 # Something is committed to SVN, pull the latest into your branch::
 	git-svn fetch && git pull . git-svn-HEAD
+# Append svn:ignore settings to the default git exclude file:
+	git-svn show-ignore >> .git/info/exclude
 
 DESIGN PHILOSOPHY
 -----------------
-- 
1.2.2.ga559
