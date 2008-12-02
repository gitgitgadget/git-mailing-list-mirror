From: Deskin Miller <deskinm@umich.edu>
Subject: [PATCH] git-svn: Make branch use correct svn-remote
Date: Mon,  1 Dec 2008 21:43:00 -0500
Message-ID: <1228185780-22938-1-git-send-email-deskinm@umich.edu>
Cc: gitster@pobox.com, normalperson@yhbt.net,
	Deskin Miller <deskinm@umich.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 02 03:44:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L7LFX-0007Nx-2F
	for gcvg-git-2@gmane.org; Tue, 02 Dec 2008 03:44:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752919AbYLBCnM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Dec 2008 21:43:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752920AbYLBCnL
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Dec 2008 21:43:11 -0500
Received: from an-out-0708.google.com ([209.85.132.240]:2258 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752917AbYLBCnJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Dec 2008 21:43:09 -0500
Received: by an-out-0708.google.com with SMTP id d40so1075012and.1
        for <git@vger.kernel.org>; Mon, 01 Dec 2008 18:43:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:sender;
        bh=l8SliVjmKZuDHseWdnWYldKTZpzayCUB1hRKrq8ms68=;
        b=pH7/KuWb7nbX+PrDyhdPuL14+4h7KOU/a275/BypRgQPa80G6LnceLsvyMp432GG0i
         vUmxuCQkgsqvTn1NGpA/yAPvvmBiINHkzFrHDIEOCtKkQGvdCqEbZaqUpWI1ErNXhXbs
         wL5eb+tUspuRhHXvJUSjcqvvNyzuuIIqL4KOk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:sender;
        b=EJXhYS3+Vhc3Jy/SLF9CvUVMHTjgL++E+rLEW9UdBTHgdJ1S29hX2JcZC0hYk14cQd
         Gg1/+w2DZxGjstcPULYz/BiFEAj6ThYoyFhkjLN9gOyH954azRKWTR+UfhHra4cvyhrC
         kqYzkSEBCbNhX2H4FhsPLfQAdFTcf5yX6esKM=
Received: by 10.100.174.13 with SMTP id w13mr6340319ane.141.1228185788368;
        Mon, 01 Dec 2008 18:43:08 -0800 (PST)
Received: from localhost.localdomain ([68.40.49.130])
        by mx.google.com with ESMTPS id b14sm3693499ana.12.2008.12.01.18.43.06
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 01 Dec 2008 18:43:07 -0800 (PST)
X-Mailer: git-send-email 1.6.1.rc1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102112>

The 'branch' subcommand incorrectly had the svn-remote to use hardcoded
as 'svn', the default remote name.  This meant that branches derived
from other svn-remotes would try to use the branch and tag configuration
for the 'svn' remote, potentially copying would-be branches to the wrong
place in SVN, into the branch namespace for another project.

Fix this by using the remote name extracted from the svn info for the
specified git ref.  Add a testcase for this behaviour.

Signed-off-by: Deskin Miller <deskinm@umich.edu>
---
Applies on v1.6.1-rc1.  Apologies for not catching this when first
writing testcases for the branch subcommand.

Deskin Miller

 git-svn.perl                  |    2 +-
 t/t9128-git-svn-cmd-branch.sh |   17 +++++++++++++++++
 2 files changed, 18 insertions(+), 1 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index 914c707..e64e97b 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -558,7 +558,7 @@ sub cmd_branch {
 
 	my ($src, $rev, undef, $gs) = working_head_info($head);
 
-	my $remote = Git::SVN::read_all_remotes()->{svn};
+	my $remote = Git::SVN::read_all_remotes()->{$gs->{repo_id}};
 	my $glob = $remote->{ $_tag ? 'tags' : 'branches' };
 	my ($lft, $rgt) = @{ $glob->{path} }{qw/left right/};
 	my $dst = join '/', $remote->{url}, $lft, $branch_name, ($rgt || ());
diff --git a/t/t9128-git-svn-cmd-branch.sh b/t/t9128-git-svn-cmd-branch.sh
index 47c4d4d..e2b6696 100755
--- a/t/t9128-git-svn-cmd-branch.sh
+++ b/t/t9128-git-svn-cmd-branch.sh
@@ -56,4 +56,21 @@ test_expect_success 'git svn branch tests' '
 	test_must_fail git svn tag tag1
 '
 
+test_expect_success 'branch uses correct svn-remote' '
+	(svn co "$svnrepo" svn &&
+	cd svn &&
+	mkdir mirror &&
+	svn add mirror &&
+	svn copy trunk tags branches mirror/ &&
+	svn ci -m "made mirror" ) &&
+	rm -rf svn &&
+	git svn init -s -R mirror --prefix=mirror/ "$svnrepo"/mirror &&
+	git svn fetch -R mirror &&
+	git checkout mirror/trunk &&
+	base=$(git rev-parse HEAD:) &&
+	git svn branch -m "branch in mirror" d &&
+	test $base = $(git rev-parse remotes/mirror/d:) &&
+	test_must_fail git rev-parse remotes/d
+'
+
 test_done
-- 
1.6.1.rc1
