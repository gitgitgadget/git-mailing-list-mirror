From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH] svn: initial "master" points to trunk if possible
Date: Wed, 12 Aug 2009 22:33:22 -0700
Message-ID: <20090813053322.GA24694@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 13 07:34:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MbSx8-00083g-E9
	for gcvg-git-2@gmane.org; Thu, 13 Aug 2009 07:34:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751880AbZHMFdX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Aug 2009 01:33:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751216AbZHMFdX
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Aug 2009 01:33:23 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:53699 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751184AbZHMFdW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Aug 2009 01:33:22 -0400
Received: from localhost (user-118bg0q.cable.mindspring.com [66.133.192.26])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by dcvr.yhbt.net (Postfix) with ESMTPSA id 291B71F7E2;
	Thu, 13 Aug 2009 05:33:23 +0000 (UTC)
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125783>

Since "trunk" is a convention for the main development branch in
the SVN world, try to make that the master branch upon initial
checkout if it exists.  This is probably less surprising based
on user requests.

t9135 was the only test which relied on the previous behavior
and thus needed to be modified.

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---

  pushed out to git://yhbt.net/git-svn along with some others

  Adam Brewster (1):
        svn: allow branches outside of refs/remotes

  Eric Wong (2):
        svn: initial "master" points to trunk if possible
        svn: (cleanup) use predefined constant for rev_map_fmt


 git-svn.perl                               |   11 +++++++++++
 t/t9135-git-svn-moved-branch-empty-file.sh |    7 ++++++-
 t/t9145-git-svn-master-branch.sh           |   25 +++++++++++++++++++++++++
 3 files changed, 42 insertions(+), 1 deletions(-)
 create mode 100755 t/t9145-git-svn-master-branch.sh

diff --git a/git-svn.perl b/git-svn.perl
index b0bfb74..fad2960 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -1156,6 +1156,17 @@ sub post_fetch_checkout {
 	my $gs = $Git::SVN::_head or return;
 	return if verify_ref('refs/heads/master^0');
 
+	# look for "trunk" ref if it exists
+	my $remote = Git::SVN::read_all_remotes()->{$gs->{repo_id}};
+	my $fetch = $remote->{fetch};
+	if ($fetch) {
+		foreach my $p (keys %$fetch) {
+			basename($fetch->{$p}) eq 'trunk' or next;
+			$gs = Git::SVN->new($fetch->{$p}, $gs->{repo_id}, $p);
+			last;
+		}
+	}
+
 	my $valid_head = verify_ref('HEAD^0');
 	command_noisy(qw(update-ref refs/heads/master), $gs->refname);
 	return if ($valid_head || !verify_ref('HEAD^0'));
diff --git a/t/t9135-git-svn-moved-branch-empty-file.sh b/t/t9135-git-svn-moved-branch-empty-file.sh
index 03705fa..5280e5f 100755
--- a/t/t9135-git-svn-moved-branch-empty-file.sh
+++ b/t/t9135-git-svn-moved-branch-empty-file.sh
@@ -10,7 +10,12 @@ test_expect_success 'load svn dumpfile'  '
 test_expect_success 'clone using git svn' 'git svn clone -s "$svnrepo" x'
 
 test_expect_success 'test that b1 exists and is empty' '
-	(cd x && test -f b1 && ! test -s b1)
+	(
+		cd x &&
+		git reset --hard branch-c &&
+		test -f b1 &&
+		! test -s b1
+	)
 	'
 
 test_done
diff --git a/t/t9145-git-svn-master-branch.sh b/t/t9145-git-svn-master-branch.sh
new file mode 100755
index 0000000..16852d2
--- /dev/null
+++ b/t/t9145-git-svn-master-branch.sh
@@ -0,0 +1,25 @@
+#!/bin/sh
+#
+# Copyright (c) 2009 Eric Wong
+#
+test_description='git svn initial master branch is "trunk" if possible'
+. ./lib-git-svn.sh
+
+test_expect_success 'setup test repository' '
+	mkdir i &&
+	> i/a &&
+	svn_cmd import -m trunk i "$svnrepo/trunk" &&
+	svn_cmd import -m b/a i "$svnrepo/branches/a" &&
+	svn_cmd import -m b/b i "$svnrepo/branches/b"
+'
+
+test_expect_success 'git svn clone --stdlayout sets up trunk as master' '
+	git svn clone -s "$svnrepo" g &&
+	(
+		cd g &&
+		test x`git rev-parse --verify refs/remotes/trunk^0` = \
+		     x`git rev-parse --verify refs/heads/master^0`
+	)
+'
+
+test_done
-- 
Eric Wong
