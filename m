From: Yaacov Akiba Slama <ya@slamail.org>
Subject: [PATCH 1/7] Using svn pools seems to solve the memory leak problem
Date: Wed, 02 Nov 2005 23:51:57 +0200
Message-ID: <E1EXQWT-000504-Qw@localhost.localdomain>
X-From: git-owner@vger.kernel.org Wed Nov 02 22:52:29 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EXQWx-0005A5-Jx
	for gcvg-git@gmane.org; Wed, 02 Nov 2005 22:52:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965285AbVKBVwY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 2 Nov 2005 16:52:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965284AbVKBVwY
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Nov 2005 16:52:24 -0500
Received: from [195.140.142.33] ([195.140.142.33]:44497 "EHLO
	c1-033.cyaris.net") by vger.kernel.org with ESMTP id S965285AbVKBVwV
	(ORCPT <rfc822;git@vger.kernel.org>); Wed, 2 Nov 2005 16:52:21 -0500
Received: from localhost ([127.0.33.1] helo=localhost.localdomain)
	by c1-033.cyaris.net with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1EXQWb-0003cb-5j; Wed, 02 Nov 2005 22:52:10 +0100
Received: from yaslama by localhost.localdomain with local (Exim 4.54)
	id 1EXQWT-000504-Qw; Wed, 02 Nov 2005 23:51:57 +0200
X-Spam-Score: -2.8 (--)
X-Spam-Report: Spam detection software, running on the system "c1-033.cyaris.net", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  Signed-off-by: Yaacov Akiba Slama <ya@slamail.org> ---
	git-svnimport.perl | 8 ++++++-- 1 files changed, 6 insertions(+), 2
	deletions(-) [...] 
	Content analysis details:   (-2.8 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
To: unlisted-recipients:; (no To-header on input)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11046>

Signed-off-by: Yaacov Akiba Slama <ya@slamail.org>

---

 git-svnimport.perl |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

applies-to: b12655de9a371d7d16f7e8318da8c5b0099c39bd
4356b879b425644c436eacb6d43b523bab960704
diff --git a/git-svnimport.perl b/git-svnimport.perl
index 45b6a19..5bf9ef2 100755
--- a/git-svnimport.perl
+++ b/git-svnimport.perl
@@ -112,7 +112,9 @@ sub file {
 		    DIR => File::Spec->tmpdir(), UNLINK => 1);
 
 	print "... $rev $path ...\n" if $opt_v;
-	eval { $self->{'svn'}->get_file($path,$rev,$fh); };
+	my $pool = SVN::Pool->new();
+	eval { $self->{'svn'}->get_file($path,$rev,$fh,$pool); };
+	$pool->clear;
 	if($@) {
 		return undef if $@ =~ /Attempted to get checksum/;
 		die $@;
@@ -674,7 +676,9 @@ sub commit_all {
 }
 
 while(++$current_rev <= $svn->{'maxrev'}) {
-	$svn->{'svn'}->get_log("/",$current_rev,$current_rev,$current_rev,1,1,\&_commit_all,"");
+	my $pool=SVN::Pool->new;
+	$svn->{'svn'}->get_log("/",$current_rev,$current_rev,1,1,1,\&_commit_all,$pool);
+	$pool->clear;
 	commit_all();
 	if($opt_l and not --$opt_l) {
 		print STDERR "Stopping, because there is a memory leak (in the SVN library).\n";
---
0.99.9.GIT
