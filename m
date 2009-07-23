From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH] git svn: fix shallow clone when upstream revision is too
	new
Date: Wed, 22 Jul 2009 23:43:57 -0700
Message-ID: <20090723064357.GA19062@dcvr.yhbt.net>
References: <1247771532.7382.115.camel@localhost> <20090720055514.GA3229@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Ka-Hing Cheung <kcheung@riverbed.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 23 08:44:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MTs2X-0005Nr-Ea
	for gcvg-git-2@gmane.org; Thu, 23 Jul 2009 08:44:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753332AbZGWGn7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Jul 2009 02:43:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752834AbZGWGn7
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Jul 2009 02:43:59 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:60216 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751195AbZGWGn7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Jul 2009 02:43:59 -0400
Received: from localhost (user-118bg0q.cable.mindspring.com [66.133.192.26])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by dcvr.yhbt.net (Postfix) with ESMTPSA id D72A31F78E;
	Thu, 23 Jul 2009 06:43:58 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20090720055514.GA3229@dcvr.yhbt.net>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123850>

Thanks to Ka-Hing Cheung for the initial bug report and patch:
> git-svn uses $ra->get_latest_revnum to find out the latest
> revision, but that can be problematic, because get_latest_revnum
> returns the latest revnum in the entire repository, not
> restricted by whatever URL you used to construct $ra. So if you
> do git svn clone -r HEAD svn://blah/blah/trunk, it won't work if
> the latest checkin is in one of the branches (it will try to
> fetch a rev that doesn't exist in trunk, making the clone
> useless).

Relying on SVN::Core::INVALID_REVNUM (-1) as the "start"
argument to SVN::Ra::get_log() proved unreliable with http(s)
URLs so the result of SVN::Ra::get_latest_revnum() is used as
the "start" argument instead.

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---

 Junio: Pushed out to git://git.bogomips.org/git-svn several
 days ago, I thought I had sent this email days ago but
 I had to leave in a hurry and never sent it.

 git-svn.perl                     |    1 +
 t/t9142-git-svn-shallow-clone.sh |   30 ++++++++++++++++++++++++++++++
 2 files changed, 31 insertions(+), 0 deletions(-)
 create mode 100755 t/t9142-git-svn-shallow-clone.sh

diff --git a/git-svn.perl b/git-svn.perl
index 43c86e8..9369acc 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -1647,6 +1647,7 @@ sub fetch_all {
 	my $ra = Git::SVN::Ra->new($url);
 	my $uuid = $ra->get_uuid;
 	my $head = $ra->get_latest_revnum;
+	$ra->get_log("", $head, 0, 1, 0, 1, sub { $head = $_[1] });
 	my $base = defined $fetch ? $head : 0;
 
 	# read the max revs for wildcard expansion (branches/*, tags/*)
diff --git a/t/t9142-git-svn-shallow-clone.sh b/t/t9142-git-svn-shallow-clone.sh
new file mode 100755
index 0000000..fd5ad49
--- /dev/null
+++ b/t/t9142-git-svn-shallow-clone.sh
@@ -0,0 +1,30 @@
+#!/bin/sh
+#
+# Copyright (c) 2009 Eric Wong
+#
+
+test_description='git svn shallow clone'
+. ./lib-git-svn.sh
+
+test_expect_success 'setup test repository' '
+	svn_cmd mkdir -m "create standard layout" \
+	  "$svnrepo"/trunk "$svnrepo"/branches "$svnrepo"/tags &&
+	svn_cmd cp -m "branch off trunk" \
+	  "$svnrepo"/trunk "$svnrepo"/branches/a &&
+	svn_cmd co "$svnrepo"/branches/a &&
+	(
+		cd a &&
+		> foo &&
+		svn_cmd add foo &&
+		svn_cmd commit -m "add foo"
+	)
+'
+
+start_httpd
+
+test_expect_success 'clone trunk with "-r HEAD"' '
+	git svn clone -r HEAD "$svnrepo/trunk" g &&
+	( cd g && git rev-parse --symbolic --verify HEAD )
+'
+
+test_done
-- 
Eric Wong
