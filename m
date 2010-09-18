From: Kirill Smelkov <kirr@landau.phys.spbu.ru>
Subject: [PATCH (girocco) 2/3] taskd/clone: ask git-svn to store branches under svn-origin/heads/* instead of svn-origin/*
Date: Sat, 18 Sep 2010 13:58:53 +0400
Message-ID: <9b21791c9138823862157c5889181543ac4f1f2a.1284803429.git.kirr@landau.phys.spbu.ru>
References: <cover.1284803429.git.kirr@landau.phys.spbu.ru>
Cc: git@vger.kernel.org, Kirill Smelkov <kirr@landau.phys.spbu.ru>,
	Andrew Steinborn <g33kdyoo@gmail.com>,
	Miklos Vajna <vmiklos@frugalware.org>,
	Eric Wong <normalperson@yhbt.net>
To: Petr Baudis <pasky@ucw.cz>, admin@repo.or.cz
X-From: git-owner@vger.kernel.org Sat Sep 18 11:57:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OwuAp-0005f1-25
	for gcvg-git-2@lo.gmane.org; Sat, 18 Sep 2010 11:57:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755451Ab0IRJ5c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Sep 2010 05:57:32 -0400
Received: from landau.phys.spbu.ru ([195.19.235.38]:42943 "EHLO
	landau.phys.spbu.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755387Ab0IRJ5b (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Sep 2010 05:57:31 -0400
Received: by landau.phys.spbu.ru (Postfix, from userid 506)
	id EBEE0FF6F3; Sat, 18 Sep 2010 13:57:30 +0400 (MSD)
Received: from kirr by landau.phys.spbu.ru with local (Exim 4.72)
	(envelope-from <kirr@roro3.zxlink>)
	id 1OwuCS-0002cE-Mg; Sat, 18 Sep 2010 13:59:16 +0400
X-Mailer: git-send-email 1.7.3.rc2.1.g63647
In-Reply-To: <cover.1284803429.git.kirr@landau.phys.spbu.ru>
In-Reply-To: <cover.1284803429.git.kirr@landau.phys.spbu.ru>
References: <cover.1284803429.git.kirr@landau.phys.spbu.ru>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156447>

The trick originally suggested by Mikls Vajna does the following:

    refs/remotes/svn-origin/heads/*     ->  refs/heads/*
    refs/remotes/svn-origin/trunk       ->  refs/heads/master
    refs/remotes/svn-origin/tags/*      ->  refs/tags/*

The problem is git-svn now stores svn branches under
refs/remotes/svn-origin/* (not refs/remotes/svn-origin/heads/* as we
used to expect), and so the first mapping does nothing, and we end up
without svn branches in refs/heads/ namespace.

So, to avoid the problem let's ask git-svn to put svn branches under
svn-origin/heads/* -- then our mapping will work as expected, and it
will fix girocco problem of not propagating svn branches (except trunk)
to git refs/heads/ namespace.

Note: we can't write ``+refs/remotes/svn-origin/*:refs/heads/*'' in the
mapping instead, because then it will recursively put everything from
under svn-origin/ into refs/heads/ , at least including tags/ .

( Eric, at least it seems a bit unflexible for storing svn branches right under
  $prefix/ -- as you can see for automated git mirroring of svn repos, I
  had to tweak git config by hand... )

Cc: Andrew Steinborn <g33kdyoo@gmail.com>
Cc: Miklos Vajna <vmiklos@frugalware.org>
Cc: Eric Wong <normalperson@yhbt.net>
---
 taskd/clone.sh |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/taskd/clone.sh b/taskd/clone.sh
index 8d56e1e..12363e5 100755
--- a/taskd/clone.sh
+++ b/taskd/clone.sh
@@ -26,6 +26,10 @@ case "$url" in
 		# we just remote svn+ here, so svn+http://... becomes http://...
 		svnurl="${url#svn+}"
 		GIT_DIR=. git svn init -s --prefix=svn-origin/ "$svnurl"
+		# ask git-svn to store branches under svn-origin/heads/* instead of svn-origin/*
+		GIT_DIR=. git config svn-remote.svn.branches	\
+			"$(git config --get svn-remote.svn.branches |	\
+			   sed 's|:refs/remotes/svn-origin/\*$|:refs/remotes/svn-origin/heads/*|')"
 		GIT_DIR=. git svn fetch
 		# Neat Trick suggested by Miklos Vajna
 		GIT_DIR=. git config remote.origin.url .
-- 
1.7.3.rc2.1.g63647
