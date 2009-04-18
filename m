From: Frank Lichtenheld <frank@lichtenheld.de>
Subject: [PATCH] Git.pm: Set GIT_WORK_TREE if we set GIT_DIR
Date: Sat, 18 Apr 2009 17:58:49 +0200
Message-ID: <1240070330-31446-1-git-send-email-frank@lichtenheld.de>
Cc: Petr Baudis <pasky@suse.cz>, git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Apr 18 18:00:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LvCyA-0002k4-B1
	for gcvg-git-2@gmane.org; Sat, 18 Apr 2009 18:00:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756330AbZDRP6x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Apr 2009 11:58:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756107AbZDRP6w
	(ORCPT <rfc822;git-outgoing>); Sat, 18 Apr 2009 11:58:52 -0400
Received: from aiolos.lenk.info ([85.214.124.154]:53635 "EHLO aiolos.lenk.info"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755530AbZDRP6w (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Apr 2009 11:58:52 -0400
Received: from mail.lenk.info ([78.47.143.197] ident=Debian-exim)
	by mx.lenk.info with esmtpsa 
	(Cipher TLS-1.0:RSA_AES_256_CBC_SHA1:32) (Exim 4.63 1)
	id 1LvCwL-0005iF-TV; Sat, 18 Apr 2009 17:58:50 +0200
Received: from p57b2734b.dip.t-dialin.net ([87.178.115.75] helo=penrose.djpig.de)
	by mail.lenk.info with esmtpsa 
	(Cipher TLS-1.0:RSA_AES_256_CBC_SHA1:32) (Exim 4.63 1)
	id 1LvCwL-0006Ss-7S; Sat, 18 Apr 2009 17:58:49 +0200
Received: from flichtenheld by penrose.djpig.de with local (Exim 4.69)
	(envelope-from <flichtenheld@astaro.com>)
	id 1LvCwM-0008Be-W1; Sat, 18 Apr 2009 17:58:51 +0200
X-Mailer: git-send-email 1.6.2.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116833>

From: Frank Lichtenheld <flichtenheld@astaro.com>

Otherwise git will use the current directory as work tree which will
lead to unexpected results if we operate in sub directory of the
work tree.

Signed-off-by: Frank Lichtenheld <flichtenheld@astaro.com>
---
 perl/Git.pm         |    2 ++
 t/t9700-perl-git.sh |    4 ++++
 t/t9700/test.pl     |   13 +++++++++++++
 3 files changed, 19 insertions(+), 0 deletions(-)

One example for the unexpected results is that "git log ." doesn't work
correctly, as demonstrated by my test.

diff --git a/perl/Git.pm b/perl/Git.pm
index 291ff5b..4313db7 100644
--- a/perl/Git.pm
+++ b/perl/Git.pm
@@ -1280,6 +1280,8 @@ sub _cmd_exec {
 	my ($self, @args) = @_;
 	if ($self) {
 		$self->repo_path() and $ENV{'GIT_DIR'} = $self->repo_path();
+		$self->repo_path() and $self->wc_path()
+			and $ENV{'GIT_WORK_TREE'} = $self->wc_path();
 		$self->wc_path() and chdir($self->wc_path());
 		$self->wc_subdir() and chdir($self->wc_subdir());
 	}
diff --git a/t/t9700-perl-git.sh b/t/t9700-perl-git.sh
index b4ca244..4eb7d3f 100755
--- a/t/t9700-perl-git.sh
+++ b/t/t9700-perl-git.sh
@@ -29,6 +29,10 @@ test_expect_success \
      git add . &&
      git commit -m "first commit" &&
 
+     echo "new file in subdir 2" > directory2/file2 &&
+     git add . &&
+     git commit -m "commit in directory2" &&
+
      echo "changed file 1" > file1 &&
      git commit -a -m "second commit" &&
 
diff --git a/t/t9700/test.pl b/t/t9700/test.pl
index 697daf3..d9b29ea 100755
--- a/t/t9700/test.pl
+++ b/t/t9700/test.pl
@@ -98,3 +98,16 @@ TODO: {
 	todo_skip 'config after wc_chdir', 1;
 	is($r->config("color.string"), "value", "config after wc_chdir");
 }
+
+# Object generation in sub directory
+chdir("directory2");
+my $r2 = Git->repository();
+is($r2->repo_path, $abs_repo_dir . "/.git", "repo_path (2)");
+is($r2->wc_path, $abs_repo_dir . "/", "wc_path (2)");
+is($r2->wc_subdir, "directory2/", "wc_subdir initial (2)");
+
+# commands in sub directory
+my $last_commit = $r2->command_oneline(qw(rev-parse --verify HEAD));
+like($last_commit, qr/^[0-9a-fA-F]{40}$/, 'rev-parse returned hash');
+my $dir_commit = $r2->command_oneline('log', '-n1', '--pretty=format:%H', '.');
+isnt($last_commit, $dir_commit, 'log . does not show last commit');
-- 
1.6.2.1
