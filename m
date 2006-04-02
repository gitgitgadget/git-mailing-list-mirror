From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH] contrib/git-svn: accept configuration via repo-config
Date: Sat, 01 Apr 2006 18:25:02 -0800
Message-ID: <11439447031422-git-send-email-normalperson@yhbt.net>
Reply-To: Eric Wong <normalperson@yhbt.net>
Cc: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Sun Apr 02 04:25:37 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FPsHS-0000MU-9R
	for gcvg-git@gmane.org; Sun, 02 Apr 2006 04:25:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751170AbWDBCZG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 1 Apr 2006 21:25:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751639AbWDBCZG
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Apr 2006 21:25:06 -0500
Received: from hand.yhbt.net ([66.150.188.102]:15067 "EHLO hand.yhbt.net")
	by vger.kernel.org with ESMTP id S1751170AbWDBCZE (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 1 Apr 2006 21:25:04 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id E14BA2DC033;
	Sat,  1 Apr 2006 18:25:03 -0800 (PST)
To: junkio@cox.net, git@vger.kernel.org
X-Mailer: git-send-email 1.3.0.rc1.g709a5
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18253>

repo-config keys are any of the long option names minus the '-'
characters

Signed-off-by: Eric Wong <normalperson@yhbt.net>

---

 contrib/git-svn/git-svn.perl |   17 +++++++++++++++++
 1 files changed, 17 insertions(+), 0 deletions(-)

2eb11880066977d65ed7e51b04c2bfa97d217752
diff --git a/contrib/git-svn/git-svn.perl b/contrib/git-svn/git-svn.perl
index 59dd504..edfb19c 100755
--- a/contrib/git-svn/git-svn.perl
+++ b/contrib/git-svn/git-svn.perl
@@ -67,6 +67,23 @@ for (my $i = 0; $i < @ARGV; $i++) {
 
 my %opts = %{$cmd{$cmd}->[2]} if (defined $cmd);
 
+# convert GetOpt::Long specs for use by git-repo-config
+foreach my $o (keys %opts) {
+	my $v = $opts{$o};
+	my ($key) = ($o =~ /^([a-z\-]+)/);
+	$key =~ s/-//g;
+	my $arg = 'git-repo-config';
+	$arg .= ' --int' if ($o =~ /=i$/);
+	$arg .= ' --bool' if ($o !~ /=[sfi]$/);
+	$arg .= " svn.$key"; # $key only matches [a-z\-], always shell-safe
+	if (ref $v eq 'ARRAY') {
+		chomp(@$v = `$arg`);
+	} else {
+		chomp($$v = `$arg`);
+		$$v = 0 if $$v eq 'false';
+	}
+}
+
 GetOptions(%opts, 'help|H|h' => \$_help,
 		'version|V' => \$_version,
 		'id|i=s' => \$GIT_SVN) or exit 1;
-- 
1.3.0.rc1.g709a5
