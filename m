From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH] git-svn: fix --rmdir when using SVN:: libraries
Date: Mon, 19 Jun 2006 17:48:25 -0700
Message-ID: <1150764508339-git-send-email-normalperson@yhbt.net>
References: <20060619233424.GD3929@localdomain> <11507645052855-git-send-email-normalperson@yhbt.net>
Reply-To: Eric Wong <normalperson@yhbt.net>
Cc: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Tue Jun 20 02:48:45 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FsUQ0-0001qI-KJ
	for gcvg-git@gmane.org; Tue, 20 Jun 2006 02:48:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965021AbWFTAsa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Jun 2006 20:48:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965023AbWFTAsa
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Jun 2006 20:48:30 -0400
Received: from hand.yhbt.net ([66.150.188.102]:52878 "EHLO hand.yhbt.net")
	by vger.kernel.org with ESMTP id S965021AbWFTAs3 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 19 Jun 2006 20:48:29 -0400
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id 1D7757DC023;
	Mon, 19 Jun 2006 17:48:27 -0700 (PDT)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Mon, 19 Jun 2006 17:48:28 -0700
To: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
X-Mailer: git-send-email 1.4.GIT
In-Reply-To: <11507645052855-git-send-email-normalperson@yhbt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22155>

When tracking directories with nearly all of its files at
the most nested levels, --rmdir would accidentally go too
far when deleting.

Of course, we'll add a test for this condition, too.

Makefile: automatically run new tests as they appear in t/

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---
 contrib/git-svn/git-svn.perl          |   15 +++++++++++----
 contrib/git-svn/t/t0002-deep-rmdir.sh |   29 +++++++++++++++++++++++++++++
 2 files changed, 40 insertions(+), 4 deletions(-)

diff --git a/contrib/git-svn/git-svn.perl b/contrib/git-svn/git-svn.perl
index da0ff9a..7e7f2f0 100755
--- a/contrib/git-svn/git-svn.perl
+++ b/contrib/git-svn/git-svn.perl
@@ -2841,13 +2841,20 @@ sub rmdirs {
 		exec qw/git-ls-tree --name-only -r -z/, $self->{c} or croak $!;
 	}
 	local $/ = "\0";
+	my @svn_path = split m#/#, $self->{svn_path};
 	while (<$fh>) {
 		chomp;
-		$_ = $self->{svn_path} . '/' . $_;
-		my ($dn) = ($_ =~ m#^(.*?)/?(?:[^/]+)$#);
-		delete $rm->{$dn};
-		last unless %$rm;
+		my @dn = (@svn_path, (split m#/#, $_));
+		while (pop @dn) {
+			delete $rm->{join '/', @dn};
+		}
+		unless (%$rm) {
+			close $fh;
+			return;
+		}
 	}
+	close $fh;
+
 	my ($r, $p, $bat) = ($self->{r}, $self->{pool}, $self->{bat});
 	foreach my $d (sort { $b =~ tr#/#/# <=> $a =~ tr#/#/# } keys %$rm) {
 		$self->close_directory($bat->{$d}, $p);
diff --git a/contrib/git-svn/t/t0002-deep-rmdir.sh b/contrib/git-svn/t/t0002-deep-rmdir.sh
new file mode 100755
index 0000000..d693d18
--- /dev/null
+++ b/contrib/git-svn/t/t0002-deep-rmdir.sh
@@ -0,0 +1,29 @@
+test_description='git-svn rmdir'
+. ./lib-git-svn.sh
+
+test_expect_success 'initialize repo' "
+	mkdir import &&
+	cd import &&
+	mkdir -p deeply/nested/directory/number/1 &&
+	mkdir -p deeply/nested/directory/number/2 &&
+	echo foo > deeply/nested/directory/number/1/file &&
+	echo foo > deeply/nested/directory/number/2/another &&
+	svn import -m 'import for git-svn' . $svnrepo &&
+	cd ..
+	"
+
+test_expect_success 'mirror via git-svn' "
+	git-svn init $svnrepo &&
+	git-svn fetch &&
+	git checkout -f -b test-rmdir remotes/git-svn
+	"
+
+test_expect_success 'Try a commit on rmdir' "
+	git rm -f deeply/nested/directory/number/2/another &&
+	git commit -a -m 'remove another' &&
+	git-svn commit --rmdir HEAD &&
+	svn ls -R $svnrepo | grep ^deeply/nested/directory/number/1
+	"
+
+
+test_done
-- 
1.4.GIT
